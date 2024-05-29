extends Node2D

@onready var player = $Player
@onready var enemy_spawner = $EnemySpawner
@onready var hud = $UI/HUD
var hpbar
var player_hp_info


func _on_enemy_spawner_enemy_spawned(new_enemy):
	enemy_spawner.add_child(new_enemy)
	
func _process(delta):
	if Input.is_action_just_pressed("Reload"):
		get_tree().reload_current_scene()
	if player != null:	
		hpbar.value = player_hp_info.get_health_percent()
	if player == null:
		hpbar.value = 0
			
func _ready():
	hpbar = hud.get_node("HPbar")
	player_hp_info = player.get_node("HealthComponent")
