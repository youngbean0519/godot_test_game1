extends StaticBody2D

var landed := false
@onready var main = get_tree().get_root().get_node("/root/Main")

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "Player" and not landed:
		landed = true
		main.score += 100

func _process(delta):
	if global_position.y > main.camera.global_position.y + 600:
		queue_free()
