extends Area2D

var speed = 250
var base_scale

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position.x += speed * delta
