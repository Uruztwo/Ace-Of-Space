extends Node
class_name HealthComponent

@export var Max_Health: float
var current_health
signal died
signal health_changed(new_health) 
@export var update_game_events : bool
var is_dead = false


func _ready():
	current_health = Max_Health
func damage(damage_amount:float):
	current_health = max(current_health - damage_amount, 0)
	Callable(check_death).call_deferred()
	

func check_death():
	if current_health == 0:
		var is_dead = true
		died.emit()
		#await get_tree().create_timer(0.2).timeout	
		owner.queue_free()	

func get_health_percent():
	if Max_Health <=0:
		return 0
	return min(current_health / Max_Health, 1)
