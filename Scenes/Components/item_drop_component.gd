extends Node

@export_range(0, 1) var drop_chance: float = 0.5
@export var blue_xp_scene : PackedScene
@export var health_component: Node

func _ready():
	(health_component as HealthComponent).died.connect(on_died)

func on_died():
	if randf() > drop_chance:
		return
	if blue_xp_scene == null:
		return
	if not owner is Node2D:
		return
	var spawn_position = (owner as Node2D).global_position
	var blue_xp_instance = blue_xp_scene.instantiate() as Node2D	
	owner.get_parent().add_child(blue_xp_instance)
	blue_xp_instance.global_position = spawn_position
