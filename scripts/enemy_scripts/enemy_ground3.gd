extends KinematicBody2D

var animate : AnimatedSprite
var collision : CollisionShape2D
var findplayerarea : Area2D
var checkplatform : RayCast2D

var timeflow = 0
var findtimeflow = 0
var exittimeflow = 0
var iswalk = false
var isLeft = false
var findplayer = false
var notfindplayer = false
var velocity : Vector2 = Vector2.ZERO

func isleft_func():
	if isLeft:
		findplayerarea.rotation_degrees = 180
		animate.flip_h = true
		checkplatform.cast_to = Vector2(-10,90)
	else:
		findplayerarea.rotation_degrees = 0
		animate.flip_h = false
		checkplatform.cast_to = Vector2(10,90)
		
func free_move(delta : float):
	timeflow += delta
	velocity.y = 400
	
	
	if !iswalk: #stop, 1넘어가면 걷기 on
		velocity = Vector2(0, velocity.y)
		move_and_slide(velocity)
		if timeflow >= 1:
			iswalk = true
			timeflow = 0
			isLeft = !isLeft
			animate.frame = 1
			animate.playing = true

		
	if iswalk and timeflow <= 3:
		if checkplatform.is_colliding():
			animate.play("Walk")
			if isLeft:
				velocity = Vector2(-200,velocity.y)
			else:
				velocity = Vector2(200,velocity.y)
		else:
			velocity = Vector2(0,velocity.y)
			animate.frame = 1
			animate.playing = false
		move_and_slide(velocity)
	
	if iswalk and ((checkplatform.is_colliding() and timeflow > 3) or (not checkplatform.is_colliding() and timeflow > 1)):	
		print(timeflow)
		timeflow = 0
		iswalk = false
		animate.frame = 1
		animate.playing = false
			

func dash_move(delta : float):
	var player = get_node("../Player")
	if player != null:
		if global_position.x > player.global_position.x:
			isLeft = true
			if velocity.x > 0:
				velocity.x += -1200 * delta
			elif velocity.x > -800:
				velocity.x += -400 * delta
			else:
				velocity.x = -800
		
		else:
			isLeft = false
			if velocity.x < 0:
				velocity.x += 1200 * delta
			elif velocity.x < 800:
				velocity.x += 400 * delta
			else:
				velocity.x = 800
				
		velocity.y = 700
		move_and_slide(velocity)		
		


func _ready():
	animate = $enemy_animate
	collision = $enemy_collision
	findplayerarea = $checkplayer
	checkplatform = $checkplatform
	
	checkplatform.enabled = true
	

func _physics_process(delta):
	isleft_func()
	
	if !findplayer:
		free_move(delta)
	else:
		findtimeflow += delta
		if findtimeflow < 0.7:
			animate.frame = 1
		else:
			if !notfindplayer:
				exittimeflow = 0
				dash_move(delta)
			else:
				var player = get_node("../Player")
					
				if velocity.x <= 0.1 and velocity.x >= -0.1:
					animate.frame = 1
					velocity.x = 0

					exittimeflow += delta
					if exittimeflow >= 1: #exit
						findtimeflow = 0
						findplayer = false
						notfindplayer = false						
					
				else:
					if velocity.x <= 0:
						velocity.x += 400 * delta
					else:
						velocity.x += -400 * delta
					move_and_slide(velocity)
					
				
				
