extends Node

var scene_reset = false

signal experience_item_collected(number: float)

func emit_xp_drop_collected(number: float):
	experience_item_collected.emit(number)
	
