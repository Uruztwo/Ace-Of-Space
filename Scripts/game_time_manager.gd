extends Node
@onready var timer = $Timer

func get_time_passed():
	timer.wait_time -= timer.time_left
