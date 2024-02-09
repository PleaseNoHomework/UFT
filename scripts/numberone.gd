extends StaticBody2D

var attack_duration = 0.1

var isarea = true

var timeflow = 0
var attackcool = 0.5
var isplayer = false
var area : Area2D


func _ready():
	var player = get_node("../")
	if player is KinematicBody2D:
		player.isattack = true
	area = $Area2D

func _process(delta): #수정필요 0.1초 이내로 닿을시에만 공격되도록
	timeflow += delta
	var player = get_node("../")
	if player is KinematicBody2D:
		isplayer = true
		
	if isplayer:
		if timeflow >= attack_duration and isarea:
			isarea = false
			area.queue_free()
		if timeflow >= attackcool:
			player.isattack = false
			queue_free()
		
			
