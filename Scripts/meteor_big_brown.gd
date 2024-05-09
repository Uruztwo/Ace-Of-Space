extends StaticBody2D
@onready var sprite = $Sprite2D
@export var power_up_red :PackedScene

@export var HP = 8

func take_damage():
	HP -= 1
	sprite.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = Color.WHITE


func _on_area_2d_area_entered(_area):
	take_damage()	
	if HP == 0:
		die()

func die():
	queue_free()
