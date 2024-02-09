extends Control

var ispaused : bool = false

func _unhandled_input(event):
	if event.is_action_pressed("paused"):
		ispaused = !ispaused


func set_paused(value : bool):
	ispaused = value
	get_tree().paused = ispaused
	visible = ispaused


