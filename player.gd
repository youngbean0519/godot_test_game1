extends CharacterBody2D

const SPEED = 200
const JUMP_VELOCITY = -600
const GRAVITY = 1000

func _ready():
	$FootSensor.connect("area_entered", Callable(self, "_on_foot_sensor_area_entered"))

func _on_foot_sensor_area_entered(area):
	print("발판 충돌 감지")
	if area.is_in_group("Platform"):
		#if velocity.y > 0:
			var score_manager = get_tree().get_root().get_node("/root/Main/ScoreManager")
			score_manager.add_score(100)
			print("점수 + 100")

func _physics_process(delta):
	# 중력 적용
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# 좌우 이동
	var direction = Input.get_action_strength("ui_right") \
					- Input.get_action_strength("ui_left")
	velocity.x = direction * SPEED

	# 점프 (spacebar = ui_accept)
	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY

	move_and_slide()
