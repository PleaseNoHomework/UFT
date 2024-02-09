extends KinematicBody2D

var animated : AnimatedSprite
var checkplatfrom : RayCast2D
var findplayerarea : Area2D
var bullets = preload("res://scenes/enemys/bullet.tscn")


var isLeft = false
var findplayer = false
var notfindplayer = false

var velocity : Vector2

var bulletvelocity : Vector2
var timeflow = 0
var attacktimeflow = 0
var nottimeflow = 0


func _ready():
	animated = $Animated
	checkplatfrom = $CheckPlatform
	findplayerarea = $FindPlayer
	
	checkplatfrom.enabled = true
	checkplatfrom.cast_to = Vector2(10, 90)

func free_move():
	$Animated.play("move")
	
	if not checkplatfrom.is_colliding():
		isLeft = !isLeft
	
	if isLeft:
		checkplatfrom.cast_to = Vector2(-10, 90)
		velocity = Vector2(-400, 0)
	else:
		checkplatfrom.cast_to = Vector2(10, 90)
		velocity = Vector2(400, 0)
		
	if checkplatfrom.is_colliding():
		move_and_slide(velocity)

func found_move(delta : float):
	var player = get_node("../Player")
	if player != null:
		if self.global_position.x - player.global_position.x > 0: #isLeft == true
			isLeft = true
		else:
			isLeft = false 
	timeflow += delta
	if timeflow >= 0.3:
		attacktimeflow += delta
	if attacktimeflow >= 1.4:
		print("try attack!")
		attack()
		attacktimeflow = 0
		timeflow = 0
		
	if notfindplayer:
		findplayer = false
		notfindplayer = false
		print("finish attack!")
		timeflow = 0
		attacktimeflow = 0
		

func attack():
	var bullet_ins = bullets.instance()
	
	if isLeft:
		bulletvelocity = Vector2(-1200, 0)
	else:
		bulletvelocity = Vector2(1200, 0)
	bullet_ins.setVelo(bulletvelocity)
	add_child(bullet_ins)


func _physics_process(delta):
	if isLeft:
		findplayerarea.rotation_degrees = 180
	else:
		findplayerarea.rotation_degrees = 0
	
	if !findplayer:
		free_move()
	else:
		found_move(delta)
