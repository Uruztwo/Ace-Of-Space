extends CharacterBody2D

@onready var health_component = $HealthComponent

@onready var sprite = $Sprite2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@export var HP = 2
@export var modulated_colour = Color.WHITE
@export var original_speed = 220
#var dropped_item = preload("res://Scenes/blue_experience.tscn")
var speed
#@onready var audio_player_2d = $AudioStreamPlayer2D


func _ready():
	speed = original_speed

func _physics_process(delta):
	global_position.x -= speed * delta	


func _on_area_2d_area_entered(area):
	health_component.damage(100)
