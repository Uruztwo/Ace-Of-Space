extends Node


#signal pause_or_resume

func pause_resume():
	get_tree().paused = !get_tree().paused
