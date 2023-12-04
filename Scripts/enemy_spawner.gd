extends Node2D

signal enemy_spawned(enemy_instance)
signal enemy_path_spawned(enemy_path_signal)

@onready var enemy_scene = preload("res://Scenes/enemy.tscn")
@onready var path_enemy_scene = preload("res://Scenes/path_enemy.tscn")
@onready var spawn_positions = $SpawnPositions

func _on_timer_timeout():
	spawn_enemy()
	
func spawn_enemy():
	var spawn_positions_array = spawn_positions.get_children()
	var random_spawn_position = spawn_positions_array.pick_random()
	
	
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.global_position = random_spawn_position.global_position
	emit_signal("enemy_spawned", enemy_instance)
	#add_child(enemy_instance)


func _on_enemy_path_timer_timeout():
	spawn_path_enemy()
	
func spawn_path_enemy():
	var enemy_path_signal = path_enemy_scene.instantiate()
	emit_signal("enemy_path_spawned", enemy_path_signal)
	
