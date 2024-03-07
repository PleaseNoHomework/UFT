extends KinematicBody2D

var dash_duration = 0.2
var now_dash_duration = 0
var attack_duration = 0.4


var now_jump_duration = 0
var jump_duration = 0.4

var now_wall_jump_duration = 0
var wall_jump_duration = 0.3

var now_hitted_duration = 0
var hitted_duration = 0.25
var infinitetime = 0
var infinitystart = false
var hit_left : bool = false
var hit_start = false

var velocity : Vector2

var gravity = 500#original gravity
var slowgravity = 300 #falling with umbrella
var wall_gravity = 100

var canjump = false
var jumpstart = false
var isjumping = false
var isfalling = false
var isslowjumping = false
var walljumping = false

var attackpos = false


var inwind = false

var dashcount = 1
var jumpcount = 1
var walljumpcount = 1

var canpickup = false


#var attack_sc = preload("res://scenes/player/numberone.tscn")
#var parry_sc = preload("res://scenes/player/parring.tscn")

var player_shape : CollisionShape2D
var checkwallup : RayCast2D
var checkwalldown : RayCast2D
var checkplatform : RayCast2D
var attackbox : Area2D
var state_machine
var checkleft = false

enum status {
	DEFAULT,
	DASH,
	HITTED,
	SAVE
}

enum jumpstatus {
	DEFAULT,
	WALL,
	WIND
}

var stat = status.DEFAULT
var jumpstat = jumpstatus.DEFAULT


var ismove = false
var isLeft = false
var isumbrella = false
var iswall = false
var isdash = false
var isattack = false
var state = "off_um"


var iswalljump = false #ability walljumping
var isslowum = true #ability slowdescent

var iswalling : bool
var finishwalling : bool



signal picked
signal down_platform_enabled

func isleftfunc():
	if isLeft:
		checkwallup.cast_to = Vector2(-80, 0)
		checkwalldown.cast_to = Vector2(-80, 0)
		attackbox.rotation_degrees = 180
	else:
		checkwallup.cast_to = Vector2(80, 0)
		checkwalldown.cast_to = Vector2(80, 0)
		attackbox.rotation_degrees = 0
	
			
func attack(delta):
	if Input.is_action_just_pressed("attacks") and !isattack:
		isattack = true
		
		
		
	if isattack:
		attackbox.monitoring = true
		pass
		
	else:
		attackbox.monitoring = false
				
func move(delta : float):
	
	if Input.is_action_just_released("ui_right") or Input.is_action_just_released("ui_left"):
		velocity.x = 0
		state_machine.travel("move")
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = Global.speed
		isLeft = false
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -Global.speed
		isLeft = true
		
	else:
		velocity.x = 0


	velocity = move_and_slide(velocity, Vector2.UP)

func jump(delta : float):
	if checkplatform.is_colliding():
		set_collision_mask_bit(7, true)
		canjump = true
	else:
		set_collision_mask_bit(7, false)
		canjump = false
		
	if canjump and Input.is_action_just_pressed("ui_up"):
		now_jump_duration = 0
		dashcount = 1
		isjumping = true

	if velocity.y < gravity:
		if velocity.y < 0:
			velocity.y += gravity * delta * 9
		else:
			velocity.y += gravity * delta * 3
		

		if Input.is_action_pressed("ui_up") and now_jump_duration < jump_duration and isjumping:
			velocity.y = Global.jumpPower
			now_jump_duration += delta
		
		if Input.is_action_just_released("ui_up"):
			now_jump_duration = jump_duration
			
		if now_jump_duration >= jump_duration: #jumping finished
			if Global.isSlowDescent and Input.is_action_pressed("ui_up") and velocity.y > gravity / 3: #slowdesecent
				velocity.y = gravity / 3


func dash(delta : float):

	if isLeft:
		velocity = Vector2(-Global.speed * 2, 0)
	else:
		velocity = Vector2(Global.speed * 2, 0)
		
	move_and_slide(velocity)
	now_dash_duration += delta
	
	if now_dash_duration >= dash_duration:
		now_dash_duration = 0
		velocity = Vector2(0,0)
		stat = status.DEFAULT
		now_jump_duration = jump_duration



func walljump(delta : float):


		
	if jumpstat == jumpstatus.WALL:
		walljumpcount = 1
		if velocity.y < 0:
			velocity.y = 0
		elif velocity.y <= wall_gravity:
			velocity.y += wall_gravity * delta
		else:
			velocity.y = wall_gravity
		
		
		if walljumpcount > 0 and Input.is_action_just_pressed("ui_up"):
			walljumpcount -= 1
			print("wall jummping!")
			walljumping = true
			jumpcount = 0
			
	if walljumping:
		if isLeft:
			velocity = Vector2(200, -400)
		else:
			velocity = Vector2(-200, -400)
			
		
		
		now_wall_jump_duration += delta
		if now_wall_jump_duration >= wall_jump_duration:
			print("finished walljumping!")
			isLeft = !isLeft
			walljumping = false
			jumpstat = jumpstatus.DEFAULT
			now_wall_jump_duration = 0
			velocity = Vector2(0, -300)
	move_and_slide(velocity)	

func windascent(delta : float):
	if Input.is_action_pressed("ui_up"):
		if velocity.y > 0:
			velocity.y = 0
		
		elif velocity.y > Global.jumpPower * 0.7:
			velocity.y += Global.jumpPower * delta * 3
			
	else:
		if velocity.y < gravity:
			if velocity.y < 0:
				velocity.y += gravity * delta * 9
			else:
				velocity.y += gravity * delta * 3
func checkumbrella():
	if state == "off_um":
		isumbrella = false
		isslowum = false
		$AnimatedSprite.play("off_um")
	else:
		isumbrella = true
		isslowum = true
		$AnimatedSprite.play("on_um")
		

func hitted(delta):
	if !hit_start:
		hit_left = isLeft
		hit_start = true
		now_hitted_duration = 0
	else:
		now_hitted_duration += delta
		var x = 300 if isLeft else -300
		move_and_slide(Vector2(x, -100))
		if now_hitted_duration >= hitted_duration:
			print("finish hit")
			now_hitted_duration = 0
			hit_start = false
			stat = status.DEFAULT

	


func _ready():
	global_position = Global.startPos
	print(global_position)
	
	player_shape = $Player_Shape
	checkwallup = $CheckWallUp
	checkwalldown = $CheckWallDown
	checkplatform = $CheckPlatform
	attackbox = $AttackBox
	state_machine = $AnimationTree.get("parameters/playback")
	print(state_machine)
	
	attackbox.monitoring = false
	isumbrella = false
	ismove = true
	velocity = Vector2(0,0)




func _physics_process(delta):
	isleftfunc()
	iswalling = (isLeft and Input.is_action_pressed("ui_left")) or (!isLeft and Input.is_action_pressed("ui_right"))
	finishwalling = (isLeft and Input.is_action_just_pressed("ui_right")) or (!isLeft and Input.is_action_just_pressed("ui_left")) or checkplatform.is_colliding() and jumpstat == jumpstatus.WALL
	if infinitystart:
		infinitetime += delta
		if infinitetime >= 1:
			infinitystart = false
			infinitetime = 0
			print("finish infinite")
	if inwind:
		jumpstat = jumpstatus.WIND
	else:
		
		if checkwallup.is_colliding() and not checkplatform.is_colliding() and iswalling and jumpstat != jumpstatus.WALL: #change in wall
			jumpstat = jumpstatus.WALL

		elif not walljumping and jumpstat == jumpstatus.WALL:
			pass
		if finishwalling and jumpstat == jumpstatus.WALL:
			jumpstat = jumpstatus.DEFAULT
			isLeft = !isLeft				
				
		if not checkwallup.is_colliding() and not walljumping:
			jumpstat = jumpstatus.DEFAULT
		
			
	if Global.canmove:
		match stat:
			status.DEFAULT:			
				match jumpstat:
					jumpstatus.DEFAULT:
						move(delta)
						jump(delta)
					jumpstatus.WALL:
						walljump(delta)
						
					jumpstatus.WIND:
						move(delta)
						windascent(delta)
			status.DASH:
				dash(delta)
			status.HITTED:
				hitted(delta)
				pass
			status.SAVE:
				pass
				
		if Input.is_action_just_pressed("dash") and dashcount > 0:
			stat = status.DASH
			dashcount -= 1
		
	
	attack(delta)
	


func _on_pickup_doublejump_area_entered(area):
	canpickup = true
	

func _on_pickup_doublejump_area_exited(area):
	canpickup = false


func _on_pickup_doublejump_abilityname(ability_name):
	if ability_name == "walljump":
		iswalljump = true	
	canpickup = false


func _on_SavePos_area_entered(area):
	print("agga")
	Global.isSave = true


func _on_SavePos_area_exited(area):
	print("exit")
	Global.isSave = true


func _on_AttackBox_area_entered(area):
	if attack_duration <= 0.2:
		pass


func _on_AscentArea_area_entered(area):
	jumpstat = jumpstatus.WIND
	inwind = true
	print(area.name)


func _on_AscentArea_area_exited(area):
	print("finish ascent!")
	inwind = false


func _on_Hitbox_area_entered(area):
	if !infinitystart:
		stat = status.HITTED
		infinitystart = true

