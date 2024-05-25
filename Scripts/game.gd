extends Node2D

@onready var enemy_spawner = $EnemySpawner



func _on_enemy_spawner_enemy_spawned(new_enemy):
	enemy_spawner.add_child(new_enemy)
	
