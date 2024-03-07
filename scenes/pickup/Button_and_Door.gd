extends Node2D


var changedoor : bool = false
var wheredoor : bool = false

var button : Area2D
var buttonSprite : AnimatedSprite
var door : StaticBody2D
var doorSprite : AnimatedSprite
var nows : String



func _ready():
	button = $Button
	buttonSprite = $Button/ButtonSprite
	door = $Door
	doorSprite = $Door/DoorSprite
	nows = get_tree().get_current_scene().get_name()
	
	match nows:
		"Map_3":
			changedoor = GlobalPickup.door_map3
		
		"Map_7":
			changedoor = GlobalPickup.door_map7
		_:
			changedoor = false
	
	if changedoor: #already opened door
		buttonSprite.animation = "Opened"
		door.queue_free()
	else:
		buttonSprite.animation = "Closed"
		
		
func _process(delta):
	if !changedoor and Input.is_action_just_pressed("ui_down"): #문 조작하기
		print("wow~")
		changedoor = true
		buttonSprite.play("Opening")
		doorSprite.play("Opening")
		
		
		match nows:
			"Map_3":
				GlobalPickup.door_map3 = true
			
			"Map_7":
				GlobalPickup.door_map7 = true


func _on_Button_area_entered(area):
	changedoor = true


func _on_Button_area_exited(area):
	changedoor = false


func _on_DoorSprite_animation_finished():
	door.queue_free()


func _on_ButtonSprite_animation_finished():
	buttonSprite.animation = "Opened"
