extends Area2D


var speed = 600
#@onready var animation_player = $AnimationPlayer

func _physics_process(delta):
	global_position.x += speed * delta

func _on_area_entered(_area):	
	#animation_player.play("on_hit")
	await get_tree().create_timer(0.1).timeout
	queue_free()
