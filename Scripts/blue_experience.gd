extends Node2D
#@onready var animation_player = $AnimationPlayer

func _on_area_2d_area_entered(_area):
	GameEvents.emit_xp_drop_collected(1)
	queue_free()
