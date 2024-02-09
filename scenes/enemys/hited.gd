extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "attacked")
	
func attacked(other):
	print(other.name)
	if other.name == "attack1":
		var enemy = get_node("../")
		if enemy != null:
			enemy.HP -= 1
			print("enemy HP decresed!", enemy.HP)
