extends Node

var HP : float = 100
var grayHP : float = 0
var jumpPower : float = -300
var speed : float = 200


var isJump : bool = true
var isWallJump : bool = false
var isDoubleJump : bool = false
var isSlowDescent : bool = false



var startPos : Vector2 = Vector2(400, 200)

var cutscene1 : bool = false
var cutscene2 : bool = false

var enemy_stage1 : Array = []

func setPlayerPos(vec : Vector2):
	startPos = vec



func _ready():
	for i in range(30):
		enemy_stage1.append(false)
