extends Node2D

signal enemy_spawned(enemy_instance)
signal path_enemy_spawned(path_enemy_instance)

@export var min_spawn_interval = 0.5
@export var max_spawn_interval = 2.0

@onready var timer = $Timer
@onready var path_enemy_timer = $pathEnemyTimer
@onready var spawn_positions = $SpawnPositions

var enemy_scene = preload("res://scenes/enemy.tscn")
var path_enemy_scene = preload("res://scenes/path_enemy.tscn")


func _ready():
	timer.wait_time = max_spawn_interval
	timer.wait_time = max_spawn_interval * 3
	
	timer.connect(("timeout"), _on_timer_timeout)
	path_enemy_timer.connect("timeout", _on_path_enemy_timer_timeout)
	
func _on_timer_timeout():
	spawn_enemy()
	timer.wait_time = randf_range(min_spawn_interval, max_spawn_interval)
	
func _on_path_enemy_timer_timeout():
	spawn_path_enemy()
	
func spawn_enemy():
	var enemy_instance = enemy_scene.instantiate()
	var spawn_point = spawn_positions.get_children().pick_random()
	enemy_instance.global_position = spawn_point.global_position
	emit_signal("enemy_spawned", enemy_instance)

func spawn_path_enemy():
	var path_enemy_instance = path_enemy_scene.instantiate()
	emit_signal("path_enemy_spawned", path_enemy_instance)
