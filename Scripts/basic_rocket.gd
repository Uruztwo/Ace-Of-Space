extends Area2D

var speed = 250

func _process(delta):
	global_position.x += speed * delta
