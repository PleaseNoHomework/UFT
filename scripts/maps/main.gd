extends "res://scripts/maps/scene_basic.gd"

signal dis

var enemy : KinematicBody2D
var playerpos : Vector2
var enemypos : Vector2
var normal_pos : Vector2
var tt = false
signal normal_poss

# Called when the node enters the scene tree for the first time.
func _ready():
	enemy = $enemy1
	player = $Player
	connect("exitarea", self, "_changearea")
	pass



func _on_restart_exitarea(nowscene):
	print(nowscene)
	Global.HPS -= 1
	print(Global.HPS)
	get_tree().change_scene("res://scenes/maps/Training.tscn")
