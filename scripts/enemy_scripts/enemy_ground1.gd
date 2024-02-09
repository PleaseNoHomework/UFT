extends "res://scripts/enemy_scripts/enemy_basic_parameter.gd"


var changedirection = 2
var timeflow = 0 
var beforeruntimeflow = 0
var runtimeflow = 0
var runspeed = 500
var temp = false

func free_move(delta : float): #플레이어를 찾기전 자유롭게 움직인다.
	timeflow += delta
	if timeflow >= 1.5:
		timeflow = 0
		isleft = !isleft
	
	velocity.y = gravity
	move_and_slide(velocity)
		
func find_move(delta : float):
	beforeruntimeflow += delta
	if beforeruntimeflow >= 0.5:
		var player = get_node("../Player")
		if player != null:
			
			if player.global_position.x < global_position.x:
				velocity = Vector2(runspeed, velocity.y)
				isleft = false
			else:
				velocity = Vector2(-runspeed, velocity.y)
				isleft = true
				
			isleft_func()
			if checkplatform.is_colliding():
				move_and_slide(velocity)			
			runtimeflow += delta
			if runtimeflow >= 1:
				runtimeflow = 0
				beforeruntimeflow = 0
				timeflow = 0
				velocity = Vector2(0, gravity)
				findplayer = false

func enemyai(delta : float):
	if HP <= 0:
		isalive = false
	
	if !isalive:
		queue_free()
	else:
		if !findplayer:
			free_move(delta)
		else:
			find_move(delta)

func _ready():
	setHP(4)
	setcheckplatform(Vector2(40, 50))
	pass
	
func _process(delta):
	isleft_func()
	enemyai(delta)
	


