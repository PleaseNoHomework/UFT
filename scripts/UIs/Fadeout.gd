extends ColorRect

var fadeout = false
var ray : RayCast2D

# Called when the node enters the scene tree for the first time.
func _ready():
	color = Color(0, 0, 0, 0)
	ray = get_node("../MapChanger")
	print(ray)
	
	
func fade(delta):
	if fadeout:
		if color.a <= 1:
			color.a += delta * 2
		else:
			fadeout = !fadeout
	else:
		if color.a >= 0:
			color.a -= delta * 2
		else:
			fadeout = !fadeout
			
			
			
func _process(delta):
	if ray.is_colliding():
		fadeout = true
		
		
	fade(delta)
