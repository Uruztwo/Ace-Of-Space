extends CharacterBody2D

var speed = 450
signal took_damage

@export var Rocket: PackedScene
@onready var screen_size = get_viewport_rect().size
@export var Cannon : PackedScene
@export var Basic_Lasers_Scene : PackedScene
@onready var laser_container = $LaserContainer
@onready var left_muzzle = $LeftMuzzle
@onready var right_muzzle = $RightMuzzle
@onready var cannon_muzzle = $CannonMuzzle
@onready var cannon_container = $CannonContainer
#@onready var lasers = $Lasers
#@onready var cannon = $Cannon
#@onready var destroyed = $Destroyed
@onready var sprite = $Sprite2D

@export var scale_amount = Vector2(1.2, 1.2)
@export var scale_duration = 0.4

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
	#lasers.play()

func take_damage():
	emit_signal("took_damage")

func die():
	#destroyed.play()
	#await get_tree().create_timer(0.4).timeout
	queue_free()
	
func fire_cannon():
	var new_cannon_muzzle = Cannon.instantiate()
	cannon_container.add_child(new_cannon_muzzle)
	new_cannon_muzzle.global_position = cannon_muzzle.global_position
	#cannon.play()

func shooting_anim():
	var tween = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	tween.tween_property(sprite, "scale", scale_amount, scale_duration * 0.1).from_current()
	tween.tween_property(sprite, "scale", Vector2.ONE, scale_duration * 0.9).from(scale_amount)


func fire_rockets():
	var new_rocket = Rocket.instantiate()
	cannon_container.add_child(new_rocket)
	new_rocket.global_position = cannon_muzzle.global_position
