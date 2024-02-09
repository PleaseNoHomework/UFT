extends Area2D


func _ready():
	connect("body_entered", self, "findplayer")
	connect("body_exited", self, "missplayer")
	
func findplayer(other):
	if other.name == "Player":
		var parent = get_parent()
		if parent != null:
			parent.notfindplayer = false
	
func missplayer(other):
	if other.name == "Player":
		var parent = get_parent()
		if parent != null:
			parent.notfindplayer = true
