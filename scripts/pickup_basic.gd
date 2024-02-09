extends Area2D
var player : KinematicBody2D
signal abilityname

func _ready():
	pass


func setpos(vec : Vector2):
	global_position = vec

func checkability(ability : bool):
	if ability:
		queue_free()
