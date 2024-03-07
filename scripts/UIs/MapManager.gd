extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Map3_Enter_Map2_area_entered(area):
	Global.setPlayerPos(Vector2(400,-300))
	get_tree().change_scene("res://scenes/maps/Training.tscn")
