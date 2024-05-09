extends Node2D

#@export var Enemy_Tscn : PackedScene

var Enemy1_Scene = preload("res://Scenes/enemy.tscn")
var Enemy2_Scene = preload("res://Scenes/enemy2.tscn")
@onready var spawn_positions_first_line = $SpawnPositionsFirstLine
@onready var spawn_positions_second_line = $SpawnPositionsSecondLine

signal enemy_spawned(new_enemy)

func _on_timer_timeout():
	spawn_enemy()

func spawn_enemy():
	var spawn_positions_array = spawn_positions_first_line.get_children()
	var random_spawn_positions = spawn_positions_array.pick_random()
	var new_enemy = Enemy1_Scene.instantiate()
	
	new_enemy.global_position = random_spawn_positions.global_position
	emit_signal("enemy_spawned", new_enemy)
	


func _on_enemy_2_timer_timeout():
	var spawn_positions_array = spawn_positions_second_line.get_children()
	var random_spawn_positions = spawn_positions_array.pick_random()
	var new_enemy = Enemy2_Scene.instantiate()
	
	new_enemy.global_position = random_spawn_positions.global_position
	emit_signal("enemy_spawned", new_enemy)
