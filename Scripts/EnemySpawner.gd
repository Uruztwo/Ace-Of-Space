extends Node2D


var Enemy1_Scene = preload("res://Scenes/enemy_one.tscn")
@onready var spawn_positions_first_line = $SpawnPositionsFirstLine
#@onready var spawn_positions_second_line = $SpawnPositionsSecondLine

signal enemy_spawned(new_enemy)

#func _process(delta):
	#get_tree().create_timer(0.5)
	#var new_enemy = Enemy1_Scene.instantiate()
	#
	#new_enemy.global_position = $SpawnPositionsFirstLine/SpawnPos1.global_position
	#

func _on_timer_timeout():
	spawn_enemy()

func spawn_enemy():
	var spawn_positions_array = spawn_positions_first_line.get_children()
	var random_spawn_positions = spawn_positions_array.pick_random()
	var new_enemy = Enemy1_Scene.instantiate()
	#add_child(new_enemy)
	
	new_enemy.global_position = random_spawn_positions.global_position
	emit_signal("enemy_spawned", new_enemy)
	
