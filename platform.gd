extends Area2D

@onready var main = get_tree().get_root().get_node("/root/Main")

func _process(delta):
	# 카메라 아래로 사라지면 발판 제거
	if global_position.y > main.camera.global_position.y:
		queue_free()
