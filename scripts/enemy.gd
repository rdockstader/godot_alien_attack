extends Area2D


@export var speed = 600

func _physics_process(delta):
	global_position.x += (-1 * speed * delta)

func die():
	queue_free()
