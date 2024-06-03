extends Control

@onready var score_label = $Panel/ScoreLabel


func _ready():
	get_tree().paused = true

func set_score(new_score):
	score_label.text = "SCORE: " + str(new_score)
	
func _on_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	
