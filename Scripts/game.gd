extends Node2D

@onready var player = $Player
@onready var enemy_spawner = $EnemySpawner
@onready var hud = $UI/HUD
var hpbar
var player_hp_info
var hplabel


func _on_enemy_spawner_enemy_spawned(new_enemy):
	enemy_spawner.add_child(new_enemy)
	
func _process(_delta):
	if Input.is_action_just_pressed("Reload"):
		get_tree().reload_current_scene()
	if player != null:	
		hpbar.value = player_hp_info.get_health_percent()
		hplabel.text = str(player_hp_info.current_health) + "/" + str(player_hp_info.Max_Health)
	if player == null:
		hpbar.value = 0
		hplabel.text = str(0) + "/" + str(player_hp_info.Max_Health)
	if Input.is_action_just_pressed("slowdown"):
		Engine.time_scale -= 0.1
	if  Input.is_action_just_pressed("fastenup"):
		Engine.time_scale += 0.1
	
func _ready():
	hpbar = hud.get_node("HPbar")
	player_hp_info = player.get_node("HealthComponent")
	hplabel = hud.get_node("HPlabel")
