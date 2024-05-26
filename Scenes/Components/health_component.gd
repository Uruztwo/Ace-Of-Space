extends Node
class_name HealthComponent

@export var Max_Health: float
var current_health
signal died
signal health_changed(new_health) 
@export var update_game_events : bool

func _ready():
	current_health = Max_Health
	if update_game_events == true:
		GameEvents.current_player_hp = current_health
func damage(damage_amount:float):
	current_health = max(current_health - damage_amount, 0)
	Callable(check_death).call_deferred()
	health_changed.emit(current_health)
	update_hp_info()
func update_hp_info():
	if update_game_events == true:
		GameEvents.current_player_hp = current_health * 100 / Max_Health

func check_death():
	if current_health == 0:
		died.emit()
		owner.queue_free()	

func get_health():
	return Max_Health
