extends CharacterBody2D

# constants
const MOVE_SPEED = 1000

func _physics_process(delta):
	# use inputs to control character body
	velocity = Vector2(0, 0)
	if Input.is_action_pressed("move_right"):
		velocity.x = MOVE_SPEED
	elif Input.is_action_pressed("move_left"):
		velocity.x = -MOVE_SPEED
	if Input.is_action_pressed("move_down"):
		velocity.y = MOVE_SPEED
	elif Input.is_action_pressed("move_up"):
		velocity.y = -MOVE_SPEED
	move_and_slide()
	
	# constrain movement to be within the screen
	var screen_rect = get_viewport_rect().size
	if global_position.x < 0:
		global_position.x = 0
	elif global_position.x > screen_rect.x:
		global_position.x = screen_rect.x
	if global_position.y < 0:
		global_position.y = 0
	elif global_position.y > screen_rect.y:
		global_position.y = screen_rect.y
