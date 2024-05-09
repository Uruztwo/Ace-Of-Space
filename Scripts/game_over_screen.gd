extends Control

@onready var score = $Panel/Score

func set_score(new_score):
	score.text = "SCORE: " + str(new_score)

func _on_button_pressed():
	get_tree().reload_current_scene()
