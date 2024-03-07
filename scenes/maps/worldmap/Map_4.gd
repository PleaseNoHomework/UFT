extends Node2D



func _ready():
	if GlobalPickup.hidden_map4:
		$tile_hidden.queue_free()


func _on_hidden_trigger_area_entered(area):
	$tile_hidden.queue_free()
	GlobalPickup.hidden_map4 = true
