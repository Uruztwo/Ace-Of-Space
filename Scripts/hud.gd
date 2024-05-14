extends Control

@onready var score = $Score
@onready var lives = $Lives
@onready var gametimer = $MarginContainer/Gametimer
@onready var time_label = $MarginContainer/TimeLabel
@onready var base_hp = $BaseHP
@onready var beginning = $Beginning
@export var experience_manager : Node
@onready var progress_bar = $ProgressBar


func _ready():
	experience_manager.experience_updated.connect(on_experience_updated)
	progress_bar.value = 0

func set_base_hp(amount):
	base_hp.text = "BASE: " + str(amount)

func set_score_label(new_score):
	score.text = "SCORE: " + str(new_score)
	
func set_lives(amount):
	lives.text = str(amount)

func _process(_delta):
	var time_elapsed = get_time_elapsed()
	time_label.text = format_seconds_to_string(time_elapsed)

func get_time_elapsed():
	
	return max(gametimer.time_left, 0)
	
func format_seconds_to_string(seconds: float):
	var minutes = floor(seconds / 60)
	var remaining_seconds = seconds - (minutes * 60)
	return str(minutes) + ":" + str(floor(remaining_seconds))
	
func _on_timer_timeout():
	beginning.visible = false

func on_experience_updated(current_experience:float, target_experience:float):
	var percent = current_experience / target_experience
	progress_bar.value = percent
