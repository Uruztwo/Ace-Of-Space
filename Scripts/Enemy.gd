extends CharacterBody2D
@onready var sprite = $Sprite2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@export var HP = 2
@export var modulated_colour = Color.WHITE
@export var original_speed = 220
var dropped_item = preload("res://Scenes/blue_experience.tscn")
var speed
@onready var audio_player_2d = $AudioStreamPlayer2D



signal died 

func _ready():
	speed = original_speed
func _physics_process(delta):
	global_position.x -= speed * delta

func _on_area_2d_area_entered(_area):
	take_damage()	
	if HP == 0:
		#print("Character HP is 0, dropping item.")
		sprite.visible = false
		animated_sprite_2d.visible = true
		animated_sprite_2d.play()
		await get_tree().create_timer(0.3).timeout
		die()
	
func die():
	emit_signal("died")
	
	item_drop()
	queue_free()

func _on_area_2d_body_entered(body):
	body.take_damage()
	die()


func take_damage():	
	HP -= 1
	audio_player_2d.play()
	sprite.modulate = Color.RED
	speed = 0
	await get_tree().create_timer(0.1).timeout
	speed = original_speed
	sprite.modulate = Color.WHITE
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func item_drop():
	call_deferred("do_item_drop")	
func do_item_drop():
	var drop_chance = randf()
	if drop_chance <= 0.5:
		var new_drop = dropped_item.instantiate()
		get_tree().get_root().add_child(new_drop)
		new_drop.position = global_position
	
