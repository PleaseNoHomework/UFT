extends Camera2D

var player : KinematicBody2D

func _ready():
	player = get_node("../Player")
	print(player)


func _process(delta):
	global_position = player.global_position
