extends Node2D

@onready var player = $Player
@onready var camera = $Player/Camera2D
@onready var score_label = $UI/ScoreLabel
@onready var spawner = $PlatformSpawner

var score := 0
var max_score := 10000

func _process(delta):
	score_label.text = "Score: $d" % score
	
	if player.global_position.y > camera.global_position.y + 400:
		print("💀 Game Over")
		get_tree().paused = true
	
	if score >= max_score:
		print("🎉 Congratulaiton!")
		get_tree().paused = true
