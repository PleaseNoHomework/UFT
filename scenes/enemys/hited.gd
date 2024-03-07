extends Area2D

func _ready():
	connect("body_entered", self, "attacked")
	
func attacked(other):
	print(other.name)
	if other.name == "attack1":
		var enemy = get_node("../")
		if enemy != null:
			enemy.HP -= 1
			print("enemy HP decresed!", enemy.HP)
