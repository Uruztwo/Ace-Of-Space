extends Node

@export var max_health: float
var current_health

signal died

func _ready():
	current_health = max_health

func damage(damage: float):
	current_health = max(current_health - damage, 0)
	if current_health == 0:
		died.emit()
		owner.queue_free()
