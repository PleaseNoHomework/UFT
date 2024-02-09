extends Camera2D

var Player : KinematicBody2D

enum camerastatus {
	DEFAULT,
	FORKING
}

enum camerascale {
	DEFAULT,
	ZOOM,
	UNZOOM
}

var status = camerastatus.DEFAULT
var scales = camerascale.DEFAULT

func default():
	global_position = Player.global_position
	
func forking(pos : Vector2, delta : float):
	if abs(pos.x - global_position.x) >= 10:
		print(abs(pos.x - global_position.x))
		if pos.x > global_position.x:
			global_position.x += pos.x * delta * 0.2
		else:
			global_position.x -= pos.x * delta * 0.2
			
	else:
		global_position.x = pos.x
	
	if abs(pos.y - global_position.y) >= 10:			
		if pos.y > global_position.y:
			global_position.y += pos.y * delta * 0.3
		elif pos.y <= global_position.y :
			global_position.y -= pos.y * delta * 0.3 
			
	else:
		global_position.y = pos.y
		

func Zoom(delta):
	
	if zoom.x < 3:
		zoom.x += delta * 0.3
	if zoom.y < 3:
		zoom.y += delta * 0.3
		
	if zoom.x >= 3 and zoom.y >= 3:
		zoom = Vector2(3,3)
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



func _physics_process(delta):
	match status:
		camerastatus.DEFAULT:
			default()
		camerastatus.FORKING:
			forking(Vector2(2360,485), delta)
			
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
	Global.speed = 50
	Global.isJump = false
	print("!")



func _on_Camera_zoom_area_exited(area):
	status = camerastatus.DEFAULT
	scales = camerascale.UNZOOM
	Global.speed = 200
	Global.isJump = true
