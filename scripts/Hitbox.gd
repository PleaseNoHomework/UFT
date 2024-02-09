extends Area2D

var _player = null

func _ready():
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")
	
func _on_body_entered(other):
	_player = other
	if other.name == "bullet":
		print("총알삭제!")
		var player = get_parent()
		print(player.HP)
		player.HP -= 1
		_player.queue_free()

