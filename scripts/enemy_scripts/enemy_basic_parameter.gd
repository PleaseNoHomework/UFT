extends KinematicBody2D



var isleft : bool = false
var findplayer : bool = false
var notfindplayer : bool = false
var isalive : bool = true
var velocity = Vector2.ZERO
export var pos = Vector2(10, 90)
var HP : int
var gravity = 400

var animate : AnimatedSprite
var checkplayer : Area2D
var checkplatform : RayCast2D

func setHP(hp : int):
	HP = hp
	
func setPos(vec : Vector2):
	pos = vec


func isleft_func():
	if isleft:
		animate.flip_h = true
		checkplayer.rotation_degrees = 180
	else:
		animate.flip_h = false
		checkplayer.rotation_degrees = 0
	 
func findparameters():
	animate = get_node("./animate")
	checkplayer = get_node("./checkplayer")
	checkplatform = get_node("./checkplatform")
	
func _ready():
	findparameters()
	global_position = pos

func _process(delta):
	
	if HP <= 0:
		isalive = false
		
	if !isalive:
		queue_free()
