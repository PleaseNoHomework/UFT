extends RigidBody2D

var velocity = Vector2(500, -500)
var kk : KinematicBody2D
var vanishtime = 5
var tt = 0
signal hurted


func setVelo(vec : Vector2):
	velocity = vec
func _ready():
	self.linear_velocity = velocity
	
	
func _physics_process(delta):
	tt += delta
	if tt > vanishtime:
		queue_free()
		
