extends Area2D

var off_save : Texture
var on_save : Texture
var savesprite : Sprite

var nowsave : bool = false
signal change_camera_folk
signal change_camera_default

func _ready():
	off_save = preload("res://images/pickup_and_save/save_offum.png")
	on_save = preload("res://images/pickup_and_save/save_onum.png")
	savesprite = $SaveSprite
	savesprite.texture = off_save
	
	
func _process(delta):
		
		
	if Input.is_action_just_pressed("save") and Global.isSave: 
		if !nowsave: #저장 시작하기
			nowsave = true
			savesprite.texture = on_save
			Global.isJump = false
			Global.speed = 200
			emit_signal("change_camera_folk")
		else: #저장 마치고 움직이기
			nowsave = false
			savesprite.texture = off_save
			Global.isJump = true
			Global.speed = 400
			emit_signal("change_camera_default")
