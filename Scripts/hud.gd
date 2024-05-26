extends Control

@onready var gametimer = $MarginContainer/GameTime
@onready var time_label = $MarginContainer/TimeLabel
var player = null
@onready var h_pbar = $HPbar


func _ready():
	#var main_node = get_parent().get_parent()
	#var player = main_node.get_node("Player")
	#if player:
		#var health_component = player.get_node("HealthComponent")
		#if health_component:
			#health_component.connect("health_changed", Callable(self, "_on_health_changed"))
			#h_pbar.value = health_component.get_health()
	pass		
	h_pbar.value = GameEvents.current_player_hp
	print(h_pbar.value)
func _process(_delta):
	var time_elapsed = get_time_elapsed()
	#time_label.text = format_seconds_to_string(time_elapsed)
	time_label.text = str(time_elapsed)
	h_pbar.value = GameEvents.current_player_hp
	
func get_time_elapsed():
	
	return max(gametimer.time_left, 0) as int
	
func format_seconds_to_string(seconds: float):
	var minutes = floor(seconds / 60)
	var remaining_seconds = seconds - (minutes * 60)
	return str(minutes) + ":" + str(floor(remaining_seconds))
		

#func _on_health_changed(new_health):
	#h_pbar.value = new_health
