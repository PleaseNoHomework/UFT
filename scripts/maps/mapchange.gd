extends RayCast2D

signal mapchange()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if is_colliding():
		emit_signal("mapchange")
