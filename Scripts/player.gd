extends CharacterBody2D
class_name Player

var speed = 450
signal took_damage
var base_fire_rate
@export var Rocket: PackedScene
@onready var screen_size = get_viewport_rect().size
@export var Cannon : PackedScene
@export var Basic_Lasers_Scene : PackedScene
@onready var laser_container = $LaserContainer
@onready var right_muzzle = $RightMuzzle
@onready var cannon_muzzle = $CannonMuzzle
@onready var left_muzzle = $LeftMuzzle
@onready var cannon_container = $CannonContainer
@onready var sprite = $Sprite2D
@onready var health_component = $HealthComponent
@export var scale_amount = Vector2(1.2, 1.2)
@export var scale_duration = 0.4
@onready var fire_rate_timer = $AbilityController/FireRateTimer


func _ready():
	base_fire_rate = fire_rate_timer.wait_time
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)
	print(fire_rate_timer.wait_time)
func _physics_process(_delta):
	
	if Input.is_action_just_pressed("Fire_Lasers"):
		fire_lasers()
		
	if Input.is_action_just_pressed("Fire_Cannon"):
		fire_cannon()
			
	if Input.is_action_just_pressed("Fire_Rockets"):
		fire_rockets()
			
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized()
	velocity = direction * speed
	move_and_slide()
	
	
	global_position.x = clamp(global_position.x, 75, screen_size.x)
	global_position.y = clamp(global_position.y, 0, screen_size.y)
func get_movement_vector():
	
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_movement, y_movement)

func fire_lasers():
	var new_laser_right_muzzle = Basic_Lasers_Scene.instantiate()
	var new_laser_left_muzzle = Basic_Lasers_Scene.instantiate()
	laser_container.add_child(new_laser_left_muzzle)
	laser_container.add_child(new_laser_right_muzzle)
	new_laser_left_muzzle.global_position = left_muzzle.global_position
	new_laser_right_muzzle.global_position = right_muzzle.global_position
	shooting_anim()
	

func take_damage():
	emit_signal("took_damage")

func die():

	queue_free()
	
func fire_cannon():
	var new_cannon_muzzle = Cannon.instantiate()
	cannon_container.add_child(new_cannon_muzzle)
	new_cannon_muzzle.global_position = cannon_muzzle.global_position
	

func shooting_anim():
	var tween = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	tween.tween_property(sprite, "scale", scale_amount, scale_duration * 0.1).from_current()
	tween.tween_property(sprite, "scale", Vector2.ONE, scale_duration * 0.9).from(scale_amount)


func fire_rockets():
	var new_rocket = Rocket.instantiate()
	cannon_container.add_child(new_rocket)
	new_rocket.global_position = cannon_muzzle.global_position


func _on_hurt_box_body_entered(_body):
	health_component.damage(1)

func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id != "fire_rate":
		return
	var percent_reduction = current_upgrades["fire_rate"]["quantity"] * .1	
	fire_rate_timer.wait_time = base_fire_rate * ( 1 - percent_reduction)
	fire_rate_timer.start()
	
	print(fire_rate_timer.wait_time)
	
