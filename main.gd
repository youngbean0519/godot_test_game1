extends Node2D

@onready var player = $Player
@onready var camera = $Player/Camera2D
@onready var score_label = $UI/ScoreLabel
@onready var spawner = $PlatformSpawner
@onready var score_manager = $ScoreManager
@onready var background_image = $BackgroundLayer/BackgroundImage
@onready var game_over_panel = $UI/GameOverPanel

@export var texture_before_3000: Texture2D
@export var texture_after_3000: Texture2D

var texture_switched := false

const DEATH_Y := 2000

func _ready():
	background_image.texture = texture_before_3000
	score_manager.connect("score_updated", Callable(self, "_on_score_updated"))
	_on_score_updated(score_manager.get_score())

func _process(delta):
	if player.global_position.y > DEATH_Y:
		print("💀 Game Over")
		game_over()
	
	if score_manager.get_score() >= score_manager.max_score:
		print("🎉 Congratulaiton!")
		game_over()

func _on_score_updated(new_score):
	if not texture_switched and new_score >= 3000:
		background_image.texture = texture_after_3000
		texture_switched = true
	print("점수 갱신 시도 중")
	score_label.text = "Score: %d" % new_score
	print("score: ", score_label.text)

func game_over():
	if not game_over_panel.visible:
		game_over_panel.visible = true
		var score_label = game_over_panel.get_node("VBoxContainer/Score")
		if score_label:
			score_label.text = "Your score: %d" % score_manager.get_score()
		else:
			print("Score label not found in GameOverPanel")
		get_tree().paused = true
		
func _on_retry_pressed() -> void:
	score_manager.reset()
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	get_tree().quit()
