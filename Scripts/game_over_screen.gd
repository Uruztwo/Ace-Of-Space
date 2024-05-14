extends Control

@onready var score = $Panel/Score

func _ready():
	Engine.time_scale = 0.01

func set_score(new_score):
	score.text = "SCORE: " + str(new_score)

func _on_button_pressed():
	get_tree().reload_current_scene()
	GameEvents.scene_reset = true
	Engine.time_scale = 1.0
