extends Node2D

@export var lives = 3

@onready var player = $Player
@onready var hud = $UI/HUD

var game_over_scene = preload("res://scenes/game_over_screen.tscn")

var score = 0

func _ready():
	hud.set_score_label(score)
	hud.set_lives_label(lives)

func _on_enemy_death_zone_area_entered(area):
	area.die()


func _on_player_took_damage():
	lives -= 1
	hud.set_lives_label(lives)
	if(lives <= 0):
		lives = 0
		player.die()
		
		await get_tree().create_timer(.75).timeout
		
		var game_over = game_over_scene.instantiate()
		$UI.add_child(game_over)
		


func _on_enemy_spawner_enemy_spawned(enemy_instance):
	enemy_instance.connect("died", _on_enemy_died)
	add_child(enemy_instance)

func _on_enemy_died():
	score+=100
	hud.set_score_label(score)
