extends Node2D

var cut1 = false
var cut2 = false

var ss : TileMap
var finished = false


func _ready():
	#if Global.cutscene1:
	#	$broke_tile.queue_free()
	pass
	
func _process(delta):
	if $broke_tile.is_colliding():
		cut1 = true
	if $broke_tile2.is_colliding() and cut1:
		Global.cutscene1 = true
		
	if Global.cutscene1 and !finished:
		$tile_broke.queue_free()
		finished = true
