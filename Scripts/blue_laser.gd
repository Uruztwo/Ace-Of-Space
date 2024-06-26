extends Area2D

@onready var animation_player = $AnimationPlayer

var speed = 600
#@onready var animation_player = $AnimationPlayer

func _physics_process(delta):
	global_position.x += speed * delta

func _on_area_entered(_area):	
	animation_player.play("on_contact")
	await get_tree().create_timer(0.1).timeout
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
