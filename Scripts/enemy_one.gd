extends CharacterBody2D

@onready var health_component = $HealthComponent
@onready var sprite = $Sprite2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@export var modulated_colour = Color.WHITE
@export var original_speed = 220
var speed



func _ready():
	speed = original_speed

func _physics_process(delta):
	global_position.x -= speed * delta	
	


func _on_area_2d_area_entered(_area):
	health_component.damage(1)
	sprite.modulate = Color.RED
	speed = 0
	await get_tree().create_timer(0.1).timeout
	speed = original_speed
	sprite.modulate = Color.WHITE


func _on_area_2d_body_entered(_body):
	health_component.damage(2)


func _on_health_component_died():
	#sprite.visible = false
	#animated_sprite_2d.visible = true
	#animated_sprite_2d.play("explosion")
	pass


func _on_base_entry_area_entered(area):
	queue_free()
