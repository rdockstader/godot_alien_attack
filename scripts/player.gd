extends CharacterBody2D

signal took_damage

# constants
const MOVE_SPEED = 1000
const ROCKET_OFFSET = 80

var rocket_scene = preload("res://scenes/rocket.tscn")
@onready var rocket_node = $RocketContainer


func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()

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
	global_position = global_position.clamp(Vector2(0, 0), get_viewport_rect().size)

func shoot():	
	var rocket_instance = rocket_scene.instantiate()
	rocket_instance.global_position = global_position
	rocket_instance.global_position.x += ROCKET_OFFSET
	rocket_node.add_child(rocket_instance)
	
func take_damage():
	emit_signal("took_damage")
	
func die():
	queue_free()
