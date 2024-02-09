extends Control

	
func _check_exiting():
	get_tree().quit()
	
func _no_check_exiting():
	#popup.hide()
	pass

func start_new_game():
	print("start new game")
	

func exit_game():
	print("exit button pressed")
	#popup.popup_centered()
	



func _on_newgamebutton_pressed():
	get_tree().change_scene("res://scenes/maps/Training.tscn")


func _on_exitgamebutton_pressed():
	$CanvasLayer/PopupDialog.popup_centered()





func _on_yesbutton_pressed():
	get_tree().quit()


func _on_nobuton_pressed():
	$CanvasLayer/PopupDialog.hide()
