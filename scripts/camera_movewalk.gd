extends Camera2D

var Player : KinematicBody2D

export var left_top : Vector2
export var right_bottom : Vector2

export var forkingpos : Vector2
export var forkingsec : float = 1
var gap : Vector2
var scalegap : float = 1.5

enum camerastatus {
	DEFAULT,
	FORKING,
	EVENT,
	SAVE
}

enum camerascale {
	DEFAULT,
	ZOOM,
	UNZOOM
}

var status = camerastatus.DEFAULT
var scales = camerascale.DEFAULT

func default():
	var x = left_top.x if left_top.x > Player.global_position.x else right_bottom.x if right_bottom.x < Player.global_position.x else Player.global_position.x
	var y = left_top.y if left_top.y > Player.global_position.y else right_bottom.y if right_bottom.y < Player.global_position.y else Player.global_position.y
	
	
	global_position = Vector2(x, y)
	
func forking(pos : Vector2, gap : Vector2, delta : float):
	if abs(pos.x - global_position.x) >= 10:
		global_position.x += gap.x * delta * forkingsec
			
	else:
		global_position.x = pos.x
	
	if abs(pos.y - global_position.y) >= 10:			
		global_position.y += gap.y * delta * forkingsec
			
	else:
		global_position.y = pos.y
		
		

func Zoom(delta : float):
	
	if zoom.x < 2.5:
		zoom.x += scalegap * forkingsec * delta
	if zoom.y < 2.5:
		zoom.y += scalegap * forkingsec * delta
		
		
	print(zoom.x, " ", zoom.y)
	if zoom.x >= 3 and zoom.y >= 3:
		zoom = Vector2(2.5,2.5)
		scales = camerascale.DEFAULT
		
func Unzoom(delta):
	if zoom.x > 1:
		zoom.x -= delta
	if zoom.y > 1:
		zoom.y -= delta
		
	if zoom.x <= 1 and zoom.y <= 1:
		zoom = Vector2(1,1)
		scales = camerascale.DEFAULT

func _ready():
	Player = get_node("../Player")
	forkingpos = Vector2.ZERO



func _physics_process(delta):
	
	match status:
		camerastatus.DEFAULT:
			default()
		camerastatus.FORKING:
			forking(forkingpos, gap, delta)
			
	match scales:
		camerascale.DEFAULT:
			pass
		camerascale.ZOOM:
			Zoom(delta)
		camerascale.UNZOOM:
			Unzoom(delta)


func _on_Camera_zoom_area_entered(area):
	status = camerastatus.FORKING
	scales = camerascale.ZOOM
	
	print("!")



func _on_Camera_zoom_area_exited(area):
	status = camerastatus.DEFAULT
	scales = camerascale.UNZOOM
	Global.isJump = true


func _on_hidden1_area_entered(area):
	print(global_position)
	forkingpos = Vector2(800, -200)
	gap = forkingpos - global_position
	status = camerastatus.FORKING


func _on_hidden1_area_exited(area):
	status = camerastatus.DEFAULT


func _on_umbrella_area_area_entered(area):
	forkingpos = Vector2(2400, 490)
	gap = forkingpos - global_position
	print(gap)
	status = camerastatus.FORKING
	scales = camerascale.ZOOM
	if !Global.cutscene2:
		Global.isJump = false


func _on_SavePos_change_camera_folk():
	forkingpos = Vector2(get_node("../SavePos").global_position.x, global_position.y)
	gap = forkingpos - global_position
	status = camerastatus.FORKING


func _on_SavePos_change_camera_default():
	status = camerastatus.DEFAULT

