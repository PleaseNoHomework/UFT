extends Area2D

var doorsprite : AnimatedSprite
var ppt : RayCast2D
var ppb : RayCast2D
var ppm : RayCast2D
var breakable = false
var wallHP = 3
var where : bool
var mapname = ""

func _ready():
	doorsprite = $door_sprite
	ppt = $playerpos_top
	ppb = $playerpos_bot
	ppm = $playerpos_mid
	mapname = get_tree().get_current_scene().get_name()
	
	match mapname:
		"Map_4":
			where = GlobalPickup.breakabledoor_map4
			
	if where:
		queue_free()
	


func _on_Breakable_door_area_entered(area):
	if breakable: #attacked
		wallHP -= 1
		
		if wallHP != 0:
			doorsprite.play("attacked")
			
		else:
			doorsprite.play("breaked")
		yield(doorsprite, "animation_finished")
		
		doorsprite.play("default")
