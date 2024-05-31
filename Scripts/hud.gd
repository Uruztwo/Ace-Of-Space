extends Control

@onready var hplabel = $HPlabel
@export var player :Player
@export var experience_manager : Node
@onready var gametimer = $MarginContainer/GameTime
@onready var time_label = $MarginContainer/TimeLabel
@onready var h_pbar = $HPbar
@onready var progress_bar = $ExpMarginContainer/ProgressBar
@onready var texture_rect = $TextureRect
var hp_percent

func _ready():

	experience_manager.experience_updated.connect(on_experience_updated)
func _process(_delta):
	var time_elapsed = get_time_elapsed()
	time_label.text = format_seconds_to_string(time_elapsed)
	time_label.text = str(time_elapsed)
	
func get_time_elapsed():
	
	return max(gametimer.time_left, 0) as int
	
func format_seconds_to_string(seconds: float):
	var minutes = floor(seconds / 60)
	var remaining_seconds = seconds - (minutes * 60)
	return str(minutes) + ":" + str(floor(remaining_seconds))	
func on_experience_updated(current_experience: float, target_experience: float):
	var percent = current_experience / target_experience
	progress_bar.value = percent

