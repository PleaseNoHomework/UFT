extends Node2D


func _process(delta):
	if GlobalUI.mapstatus == GlobalUI.mapchangestatus.mapchange:
		pass


func _ready():
	pass

func _on_ColorRect_changemaps(nextscene):
	Global.setPlayerPos(Global.startPos)
	print(nextscene)
	get_tree().change_scene(nextscene)
