extends Node2D

@onready var player = $Player
@onready var camera = $Player/Camera2D
@onready var score_label = $UI/ScoreLabel
@onready var spawner = $PlatformSpawner
@onready var game_over_panel = $UI/GameOverPanel

var score := 0
var max_score := 10000
const DEATH_Y := 2000

func _process(delta):
	score_label.text = "Score: %d" % score
	
	if player.global_position.y > DEATH_Y:
		print("💀 Game Over")
		game_over()
	
	if score >= max_score:
		print("🎉 Congratulaiton!")
		game_over()

func game_over():
	if not game_over_panel.visible:
		game_over_panel.visible = true
		game_over_panel.process_mode = Node.PROCESS_MODE_ALWAYS
		var score_label = game_over_panel.get_node("VBoxContainer/Score")
		if score_label:
			score_label.text = "Your score: %d" % score
		else:
			print("Score label not found in GameOverPanel")
		get_tree().paused = true
		
func _on_retry_pressed() -> void:
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	get_tree().quit()
