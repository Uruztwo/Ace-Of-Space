extends Node2D

@onready var player = $Player
@onready var enemy_spawner = $EnemySpawner
@onready var hud = $UI/HUD
@onready var ui = $UI

var hpbar
var player_hp_info
var hplabel
var game_time
var player_max_health

var game_over_screen = preload("res://game_over_screen.tscn")
var Vic_Screen = preload("res://Scenes/victory_screen.tscn")

func _on_enemy_spawner_enemy_spawned(new_enemy):
	enemy_spawner.add_child(new_enemy)
	
func _process(_delta):
	if Input.is_action_just_pressed("Reload"):
		get_tree().reload_current_scene()
	#if is_instance_valid(player) and is_instance_valid(player_hp_info):
		#var health_percent = player_hp_info.get_health_percent()
		#hpbar.value = health_percent
		#hplabel.text = str(player_hp_info.current_health) + "/" + str(player_max_health)
	#else:
		#hpbar.value = 0
		#hplabel.text = "0/" + str(player_max_health)
		#
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
	if game_time.time_left == 0:
		var new_vs = Vic_Screen.instantiate()
		ui.add_child(new_vs)	
	if hpbar.value == 0:
		var new_gos = game_over_screen.instantiate()
		ui.add_child(new_gos)	
	
func _ready():
	hpbar = hud.get_node("HPbar")
	player_hp_info = player.get_node("HealthComponent")
	hplabel = hud.get_node("HPlabel")
	game_time = hud.get_node("MarginContainer/GameTime")
	
func show_victory_screen():
	if not ui.has_node(Vic_Screen.name):
		var new_vs = Vic_Screen.instantiate()
		ui.add_child(new_vs)

func show_game_over_screen():
	if not ui.has_node(game_over_screen.name):
		var new_gos = game_over_screen.instantiate()
		ui.add_child(new_gos)	
