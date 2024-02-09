extends KinematicBody2D

var speed = 800
var sp : Sprite
var rightray : RayCast2D
var leftray : RayCast2D
var hurt : CollisionShape2D
var velo : Vector2
var movetime = 3
var stoptime = 1
var resettime = 0
var moves = true
var normalized_vec : Vector2 = Vector2(0,0)
var bullet = preload("res://scenes/enemys/bullet.tscn")



func attack():
	var player = get_node("../Player")
	normalized_vec = (player.global_position - global_position).normalized()
	var bullet_ins = bullet.instance()
	bullet_ins.setVelo(normalized_vec * 800)
	add_child(bullet_ins)	

func move():
	velo = Vector2(0, 500)
	velo.x = speed
	move_and_slide(velo, Vector2.UP)
	
	if rightray.enabled == true:	
		if not rightray.is_colliding():
			speed = -speed
			rightray.enabled = false
			leftray.enabled = true
			sp.flip_h = false
	
	elif leftray.enabled == true:		
		if not leftray.is_colliding():
			speed = -speed
			rightray.enabled = true
			leftray.enabled = false
			sp.flip_h = true
					
					
func resmove(delta):
	if moves == true:
		move()
		resettime += delta
		if resettime >= movetime:
			resettime = 0
			moves = !moves
	else:
		move_and_slide(Vector2.ZERO, Vector2.UP)
		resettime += delta
		if resettime >= stoptime:
			resettime = 0
			moves = !moves

func tempattack(delta):
	resettime += delta
	if resettime > 1:
		attack()
		resettime = 0

func _ready():
	rightray = $Right
	leftray = $Left
	sp = $Sprite
	hurt = $hurt
	
	sp.flip_h = true
	rightray.enabled = true
	leftray.enabled = false

func _physics_process(delta):
	resmove(delta)
	tempattack(delta)
	pass

#func _on_normal_pos_received(normal_poss):
#	print(normal_poss)
#	normalized_vec = normal_poss
