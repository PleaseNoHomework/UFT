extends "res://scripts/pickup_basic.gd"


func _ready():
	player = get_node("../Player")
	checkability(player.iswalljump)
	setpos(Vector2(600,100))
	connect("area_entered", self, "arr")
	

func _on_Player_picked():
	emit_signal("abilityname", "walljump")
	queue_free()
