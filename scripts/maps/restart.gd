extends Area2D


var nowscene : Node2D
signal exitarea

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "wow")
	nowscene = get_node("../")


func wow(other):
	if other.name == "Player":
		emit_signal("exitarea", nowscene)
