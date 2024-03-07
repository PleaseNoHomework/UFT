extends Node

var isSave : bool = false
var fade : bool = false

var HP : float = 100
var grayHP : float = 0
var jumpPower : float = -500
var jump_duration : float = 1
var speed : float = 400


var canmove : bool = true
var isJump : bool = true
var isWallJump : bool = false
var isDoubleJump : bool = false
var isSlowDescent : bool = true


var startPos : Vector2 = Vector2(200, 300)

var cutscene1 : bool = false
var cutscene2 : bool = false

var enemy_stage1 : Array = []

func setPlayerPos(vec : Vector2):
	startPos = vec



func _ready():
	for i in range(30):
		enemy_stage1.append(false)
