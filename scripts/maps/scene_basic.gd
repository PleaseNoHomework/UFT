extends Node2D

var player : KinematicBody2D
var pausescene : PopupDialog
var paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("./Player")
	
func _process(delta):
	if Input.is_action_just_pressed("ui_down"):
		pauseMenu()
		
func pauseMenu():
	if paused:
		Engine.time_scale = 1	
	else: #showPause
		Engine.time_scale = 0
	paused = !paused

