extends KinematicBody2D



var isleft : bool = false
var findplayer : bool = false
var notfindplayer : bool = false
var isalive : bool = true
var velocity = Vector2.ZERO
var checkplatformvec = Vector2(10, 90)
var HP : int
var gravity = 400

var animate : AnimatedSprite
var checkplayer : Area2D
var checkplatform : RayCast2D

func setHP(hp : int):
	HP = hp
	
func setcheckplatform(vec : Vector2):
	checkplatformvec = vec


func isleft_func():
	if isleft:
		animate.flip_h = true
		checkplayer.rotation_degrees = 180
		checkplatform.cast_to = Vector2(-checkplatformvec.x, checkplatformvec.y)
	else:
		animate.flip_h = false
		checkplayer.rotation_degrees = 0
		checkplatform.cast_to = Vector2(checkplatformvec.x, checkplatformvec.y)
	 
func findparameters():
	animate = get_node("./animate")
	checkplayer = get_node("./checkplayer")
	checkplatform = get_node("./checkplatform")
	
func _ready():
	findparameters()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
