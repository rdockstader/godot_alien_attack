extends Area2D

signal died

@export var speed = 600

func _physics_process(delta):
	global_position.x += (-1 * speed * delta)

func die(was_killed = false):
	queue_free()
	if(was_killed):
		emit_signal("died")


func _on_body_entered(body):
	body.take_damage()
	die()
