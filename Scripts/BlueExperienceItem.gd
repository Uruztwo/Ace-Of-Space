extends Node2D



func _on_area_2d_area_entered(area):
	GameEvents.emit_xp_drop_collected(1)
	queue_free()
