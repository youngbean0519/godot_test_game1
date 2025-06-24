extends Node2D

@export var platform_scene: PackedScene
@export var spawn_distance: int = 120
@export var min_x: int = -150
@export var max_x: int = 150
@export var ahead_buffer := 1000	# 카메라보다 이만큼 윜까지 발판을 미리 생성

var last_y := 0.0
@onready var camera = get_parent().get_node("Player/Camera2D")

func _ready():
	last_y = camera.global_position.y + 600
	for i in range(10):
		spawn_platform(last_y - i * spawn_distance)

func _process(delta):
	while last_y > camera.global_position.y - ahead_buffer:
		last_y -= spawn_distance
		spawn_platform(last_y)

func spawn_platform(y_pos: float):
	var platform = platform_scene.instantiate()
	platform.position = Vector2(randi_range(min_x, max_x), y_pos)
	get_parent().add_child(platform)
