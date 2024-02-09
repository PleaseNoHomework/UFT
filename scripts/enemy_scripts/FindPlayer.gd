extends Area2D


func _ready():
	connect("body_entered", self, "find_player")

func find_player(other):
	if other.name == "Player":
		print("find player!")
		var parent = get_node("../")
		if parent != null:
			parent.findplayer = true
		
