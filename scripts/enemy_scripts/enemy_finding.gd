extends Area2D

var _p = null
var cooltime = 1
var cool = 0
func _ready():
	cool = 1
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")
	
func _on_body_entered(other):
	print("플레이어 접근!")
	if cool >= cooltime:
		var parent = get_parent()
		parent.attack()
		cool = 0
	
	
func _process(delta):
	cool += delta

