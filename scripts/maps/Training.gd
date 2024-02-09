extends "res://scripts/maps/scene_basic.gd"




func _ready():
	get_tree().connect("tree_changed", self, "_on_tree_changed")
	pass


func _on_Area2D_exitarea(nowscene):
	get_tree().change_scene("res://scenes/maps/main.tscn")

func _on_tree_changed():
	print("신 전환 완료!")
	var players = $Player
	print(players.global_position)
