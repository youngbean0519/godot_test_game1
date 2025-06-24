extends CharacterBody2D

const SPEED = 200
const JUMP_VELOCITY = -600
const GRAVITY = 1000

func _physics_process(delta):
	# 중력 적용
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	# 좌우 이동
	var direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = direction * SPEED
	
	# 점프
	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):	# 기본적으로 spacebar
		velocity.y = JUMP_VELOCITY
	
	move_and_slide()
