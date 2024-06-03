extends Control

@onready var score = $Panel/Score
var paused

func _ready():
	
	get_tree().paused = true
	
func set_score(new_score):
	score.text = "SCORE: " + str(new_score)

func _on_button_pressed():
	
	#if get_tree():
	get_tree().reload_current_scene()
	#GameEvents.scene_reset = true
	#Engine.time_scale = 1.0
	get_tree().paused = false
	
