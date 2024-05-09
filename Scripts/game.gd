extends Node2D

var score = 0
var lives = 3
var base_hp = 10
@onready var enemy_spawner = $EnemySpawner
@onready var player = $Player
@onready var hud = $UI/HUD
@onready var ui = $UI

var gos = preload("res://Scenes/game_over_screen.tscn")
var original_engine_time = Engine.time_scale
var is_paused = false

func _process(_delta):
	if Input.is_action_just_pressed("Pause"):
		is_paused = !is_paused
		pause_resume()
	if Input.is_action_just_pressed("slower"):
		slow_game()
	if Input.is_action_just_pressed("faster"):
		fasten_game()
	
func _ready():
	hud.set_score_label(score)
	hud.set_lives(lives)
	hud.set_base_hp(base_hp)
		
func _on_player_took_damage():
	lives -= 1
	hud.set_lives(lives)
	if lives == 0:
		var new_gos = gos.instantiate()
		ui.add_child(new_gos)
		player.die()
		new_gos.set_score(score)
		#Engine.time_scale = 0.01

func _on_enemy_spawner_enemy_spawned(new_enemy):
	
	new_enemy.connect("died", _on_enemy_died)
	enemy_spawner.add_child(new_enemy)
func _on_enemy_died():
	score += 100
	hud.set_score_label(score)
func _on_death_zone_area_entered(area):
	area.queue_free()

func pause_resume():
	if is_paused == false:
		Engine.time_scale = 1.0
	if 	is_paused == true:
		Engine.time_scale = 0.0
	
func slow_game():
	Engine.time_scale -= 0.1
func fasten_game():
	Engine.time_scale += 0.1
		




func _on_base_border_area_entered(_area):
	if base_hp >= 0:	
		hud.set_base_hp(base_hp)
		base_hp -= 1	
		print("Enemy has entered the base! ")
	if base_hp == -1:
		var new_gos = gos.instantiate()
		ui.add_child(new_gos)
		new_gos.set_score(score)
