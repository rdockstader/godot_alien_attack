extends Node2D

@export var min_spawn_interval = 0.5
@export var max_spawn_interval = 2.0

@onready var timer = $Timer
@onready var enemies_node = $enemies
@onready var spawn_positions = $SpawnPositions

var enemy_scene = preload("res://scenes/enemy.tscn")


func _ready():
	timer.wait_time = max_spawn_interval
	timer.connect(("timeout"), _on_timer_timeout)
	
func _on_timer_timeout():
	spawn_enemy()
	timer.wait_time = randf_range(min_spawn_interval, max_spawn_interval)
	
func spawn_enemy():
	print('spawning enemy')
	var enemy_instance = enemy_scene.instantiate()
	var spawn_point = spawn_positions.get_children().pick_random()
	enemy_instance.global_position = spawn_point.global_position
	enemies_node.add_child(enemy_instance)
