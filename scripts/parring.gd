extends Area2D

var timeflow = 0
var isparry = false

func _ready():
	connect("body_entered", self, "parried")

func parried(other):
	print(other)
	if !isparry:
		print("parried!")
		isparry = true

func _process(delta):
	timeflow += delta
	if timeflow >= 0.5:
		queue_free()
