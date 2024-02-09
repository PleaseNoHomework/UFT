extends KinematicBody2D

var dash_duration = 0.2
var now_dash_duration = 0
var attack_duration = 0.4
var jump_duration = 0.35
var now_jump_duration = 0
var hoveringtime = 0.3
var starthoveringtime = 0
var now_wall_jump_duration = 0
var wall_jump_duration = 0.3

var HP : float
var minpos = 0 #jump gap, falling damage
var maxpos = 0
var speed : float
var velocity : Vector2

var originalgravity = 1200
var gravity = 600 #original gravity
var slowgravity = 300 #falling with umbrella


var wall_gravity = 400
export var jumppower = -1200
var isjumping = false
var isslowjumping = false

var firstjumping = false
var secondjumping = false
var falling = false
var walljumping = false

var exitjumping = false

var dashcount = 1
var jumpcount = 2
var walljumpcount = 1

var canpickup = false


var attack_sc = preload("res://scenes/player/numberone.tscn")
var parry_sc = preload("res://scenes/player/parring.tscn")
var checkwallup : RayCast2D
var checkwalldown : RayCast2D
var checkplatform : RayCast2D
var checkleft = false

var ismove = false
var isLeft = false
var isumbrella = false
var iswall = false
var isdash = false
var isattack = false
var state = "off_um"


var iswalljump = false #ability walljumping
var isslowum = true #ability slowdescent

signal picked


func isleftfunc():
	if isLeft:
		checkwallup.cast_to = Vector2(-80, 20)
	else:
		checkwallup.cast_to = Vector2(80, 20)
						
func attack():
	if Input.is_action_just_pressed("attacks"):
		var attack_ins = attack_sc.instance()
		if isLeft:
			attack_ins.position = Vector2(-100, 0)
		else:
			attack_ins.position = Vector2(100, 0)
		add_child(attack_ins)
		
func parry():
	if Input.is_action_just_pressed("parry"):
		var parry_ins = parry_sc.instance()
		add_child(parry_ins)
						
func move(delta : float):
	
	if Input.is_action_just_released("ui_right") or Input.is_action_just_released("ui_left"):
		velocity.x = 0
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = Global.speed
		isLeft = false
	if Input.is_action_pressed("ui_left"):
		velocity.x = -Global.speed
		isLeft = true
	
	if !isjumping:
		starthoveringtime += delta
		if isslowjumping and starthoveringtime > hoveringtime:
			velocity.y = 300
		elif velocity. y < originalgravity:
			velocity.y += 2000 * delta
		else:
			velocity.y = originalgravity


	velocity = move_and_slide(velocity, Vector2.UP)

func jump(delta : float):
	if Global.isJump:
		slowdescent()
		if is_on_floor():
			isjumping = false
			falling = false
			now_jump_duration = 0
			jumpcount = 2
			dashcount = 1
			
		
		if Input.is_action_just_pressed("ui_up") and jumpcount > 0:
			starthoveringtime = 0
			isjumping = true
			jumpcount -= 1
			now_jump_duration = 0
		if Input.is_action_pressed("ui_up") and now_jump_duration < jump_duration and isjumping:
			velocity.y = jumppower
			now_jump_duration += delta
		if (Input.is_action_just_released("ui_up") or now_jump_duration >= jump_duration) and isjumping:
			isjumping = false
			velocity.y = -300

func dash(delta : float):
	if Input.is_action_just_pressed("dash") and dashcount > 0:
		ismove = false
		isdash = true
		
	if isdash:
		if isLeft:
			velocity = Vector2(-speed * 4, 0)
		else:
			velocity = Vector2(speed * 4, 0)
			
		move_and_slide(velocity)
		now_dash_duration += delta
		
		if now_dash_duration >= dash_duration:
			dashcount -= 1
			now_dash_duration = 0
			velocity = Vector2(0,0)
			if not is_on_floor():
				isjumping = false
			isdash = false
			ismove = true


func slowdescent():
	
	if isslowum == true and Input.is_action_pressed("ui_up"):
		isslowjumping = true
	else:
		isslowjumping = false


func walljump(delta : float):
	if checkwallup.is_colliding() and not checkplatform.is_colliding():
		iswall = true
		isjumping = false
	else:
		iswall = false
		
	if iswall and !walljumping:
		walljumpcount = 1
		if velocity.y < 0:
			velocity.y = 0
		elif velocity.y <= 300:
			velocity.y += 300 * delta
		else:
			velocity.y = 300
		move_and_slide(velocity)
		if isLeft and Input.is_action_just_pressed("ui_right"):
			isLeft = false
		elif !isLeft and Input.is_action_just_pressed("ui_left"):
			isLeft = true
			
		if walljumpcount > 0 and Input.is_action_just_pressed("ui_up"):
			walljumpcount -= 1
			print("wall jummping!")
			walljumping = true
			jumpcount = 0
			
	if walljumping:
		if isLeft:
			velocity = Vector2(400, -800)
		else:
			velocity = Vector2(-400, -800)
			
		move_and_slide(velocity)
		
		now_wall_jump_duration += delta
		if now_wall_jump_duration >= wall_jump_duration:
			print("finished walljumping!")
			isLeft = !isLeft
			walljumping = false
			now_wall_jump_duration = 0
			velocity = Vector2(0, -300)
		

func checkumbrella():
	if state == "off_um":
		isumbrella = false
		isslowum = false
		$AnimatedSprite.play("off_um")
	else:
		isumbrella = true
		isslowum = true
		$AnimatedSprite.play("on_um")
		

func _ready():
	HP = Global.HP
	speed = Global.speed
	global_position = Global.startPos
	
	
	checkwallup = $CheckWallUp
	checkwalldown = $CheckWallDown
	checkplatform = $CheckPlatform
	isumbrella = false
	ismove = true
	velocity = Vector2(0,0)





func _physics_process(delta):
	isleftfunc()
	parry()
	
	dash(delta)
	if !iswall and !walljumping and ismove:
		move(delta)
		jump(delta)
	if state == "off_um":
		if !isattack:
			attack()
	if Input.is_action_just_pressed("umbrella"):
		if state == "off_um" and isattack == false:
			state = "on_um"
		else:
			state = "off_um"
	checkumbrella()

	if iswalljump:
		walljump(delta)
	if canpickup and Input.is_action_just_pressed("pickup"):
		print("picked!")
		emit_signal("picked")



func _on_pickup_doublejump_area_entered(area):
	canpickup = true
	

func _on_pickup_doublejump_area_exited(area):
	canpickup = false


func _on_pickup_doublejump_abilityname(ability_name):
	if ability_name == "walljump":
		iswalljump = true	
	canpickup = false

