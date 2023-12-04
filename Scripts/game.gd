extends Node2D

var lives = 3
var score = 0

@onready var player = $Player
@onready var UI = $UI
@onready var hud = $UI/HUD
@onready var game_over_scene = preload("res://Scenes/game_over_screen.tscn")

@onready var enemy_hit_sound = $EnemyHitSound
@onready var lose_life_sound = $LoseLifeSound

func _ready():
	hud.set_score_label(score)
	hud.set_lives_left_label(lives)

func _on_deadzone_area_entered(area):
	area.queue_free()

func _on_player_took_damage():
	lose_life_sound.play()
	lives -= 1
	if lives == 0:
		player.die()
		await get_tree().create_timer(1.5).timeout
		show_game_over_scene()
	hud.set_lives_left_label(lives)

func _on_enemy_spawner_enemy_spawned(enemy_instance):
	enemy_instance.connect("died", _on_enemy_died)
	add_child(enemy_instance)

func _on_enemy_died():
	enemy_hit_sound.play()
	score += 50
	hud.set_score_label(score)

func show_game_over_scene():
	var game_over_scene_instance = game_over_scene.instantiate()
	game_over_scene_instance.set_score(score)
	UI.add_child(game_over_scene_instance)



func _on_enemy_spawner_enemy_path_spawned(enemy_path_signal):
	add_child(enemy_path_signal)
	enemy_path_signal.enemy.connect("died", _on_enemy_died)
