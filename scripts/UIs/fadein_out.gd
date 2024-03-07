extends ColorRect


var fade : bool = false
signal changemaps(nextscene)

func setchangevalue(nextscene : String, startpos : Vector2):
	GlobalUI.nextscene = "res://scenes/maps/worldmap/" + nextscene + ".tscn"
	GlobalUI.mapstatus = GlobalUI.mapchangestatus.fadeout
	Global.startPos = startpos



func fade_inout(delta : float):
	if GlobalUI.mapstatus == GlobalUI.mapchangestatus.fadeout:
		if color.a < 1: #fade out
			Global.canmove = false
			color.a += delta
		else:
			GlobalUI.mapstatus = GlobalUI.mapchangestatus.mapchange
			Global.canmove = true
			emit_signal("changemaps", GlobalUI.nextscene)
		
	if GlobalUI.mapstatus == GlobalUI.mapchangestatus.fadein:
		if color.a > 0:
			color.a -= delta
		else:
			GlobalUI.mapstatus = GlobalUI.mapchangestatus.default
		
		
		
func _ready():
	GlobalUI.mapstatus = GlobalUI.mapchangestatus.fadein
	color = Color(0,0,0,1)
	

func _process(delta):	
	fade_inout(delta)
	

func _on_MapChanger_1to2_mapchange():
	setchangevalue("Map_2", Vector2(40,460))

func _on_MapChange_2to1_mapchange():
	setchangevalue("Map_1", Vector2(1150,460))


func _on_MapChange_2to3_mapchange():
	setchangevalue("Map_3", Vector2(280, -200))



func _on_MapChanger_3to4_mapchange():
	setchangevalue("Map_4", Vector2(60, 30))

func _on_MapChange_4to3_mapchange():
	setchangevalue("Map_3", Vector2(4890, 1130))

func _on_MapChange_7to8_mapchange():
	setchangevalue("Map_8", Vector2(-270,420))


func _on_MapChange_8to7_mapchange():
	setchangevalue("Map_7", Vector2(3200, 420))


func _on_MapChange_8to9_mapchange():
	setchangevalue("Map_9", Vector2(150,150))


func _on_MapChange_4to5_mapchange():
	setchangevalue("Map_5and6", Vector2(120,460))

func _on_MapChange_5to4_mapchange():
	setchangevalue("Map_4", Vector2(1600,300))
	
	

func _on_MapChange_5to2_mapchange():
	setchangevalue("Map_2", Vector2(6380,490))


func _on_MapChange_9to8_mapchange():
	setchangevalue("Map_8", Vector2(2500,420))


func _on_MapChange_9to10_mapchange():
	setchangevalue("Map_10", Vector2(900,-400))

func _on_MapChange_10to9_mapchange():
	setchangevalue("Map_9", Vector2(-670,2250))


func _on_MapChange_10to11_mapchange():
	setchangevalue("Map_11", Vector2(200, 70))


func _on_MapChange_11to12_mapchange():
	setchangevalue("Map_12", Vector2(760, 490))


func _on_MapChange_12to13_mapchange():
	setchangevalue("Map_13and14", Vector2(1270, 430))


func _on_MapChange_12to11_mapchange():
	setchangevalue("Map_11", Vector2(-2000, 1940))


func _on_MapChange_13to12_mapchange():
	setchangevalue("Map_12", Vector2(-3000, 490))


func _on_MapChange_4to13_mapchange():
	setchangevalue("Map_13and14", Vector2(-2000, -3170))


func _on_MapChange_7to2_mapchange():
	setchangevalue("Map_2", Vector2(7300,490))
	pass # Replace with function body.





func _on_MapChange_2to7_mapchange():
	setchangevalue("Map_7", Vector2(100, 490))


func _on_MapChanger_3to2_mapchange():
	setchangevalue("Map_2", Vector2(550,465))







func _on_MapChange_2to5_mapchange():
	setchangevalue("Map_5and6", Vector2(1672, -1020))


func _on_MapChange_13to4_mapchange():
	setchangevalue("Map_4", Vector2(250, 1810))
