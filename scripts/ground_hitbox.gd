extends Area2D

var _p = null

func _ready():
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")

func _on_body_entered(other):
	_p = other
	
	if _p.name == "bullet":
		print("땅 총알삭제!")
		_p.queue_free()
