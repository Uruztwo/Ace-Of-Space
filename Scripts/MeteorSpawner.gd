extends Node2D

var meteor_scene = preload("res://Scenes/meteor_big_brown.tscn")
#@export var power_up_red :PackedScene
@onready var spawn_pos = $Spawn_Pos
var first_meteor: bool
var second_meteor: bool

func spawn_meteor():
	
	var spawn_positions_array = spawn_pos.get_children()
	var random_spawn_positions = spawn_positions_array.pick_random()
	var new_meteor = meteor_scene.instantiate()
	add_child(new_meteor)
	new_meteor.global_position = random_spawn_positions.global_position



func _on_timer_timeout():
	spawn_meteor()
