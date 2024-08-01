extends CharacterBody2D

var original_color = Color(1, 1, 1, 1)
var flicker_interval = 0.05  # Interval for flickering and vibrating
var vibration_amount = 1.0  # Amount of vibration in pixels
var player 
@export var health : int = 100
@export var maxHealth : int = 100

func _init():
	collision_layer = 2
	collision_mask = 16
	self.add_to_group("enemies")

func _ready():
	# Store the original color of the sprite
	original_color = $Sprite2D.modulate
	player = get_tree().get_nodes_in_group("player")[0]
	get_node("HealthBar").update_health(health, maxHealth)
	

func take_damage(damage, damager):
	var sprite = $Sprite2D
	sprite.modulate = Color(1, 1, 1, 0.5)  # Change to semi-transparent white
	health -= damage
	get_node("HealthBar").update_health(health, maxHealth)
		
	# Start the flicker and vibration effect
	_start_flicker_and_vibrate()

	

func _start_flicker_and_vibrate() -> void:
	var sprite = $Sprite2D
	var original_position = global_position
	var jumping = false

	for i in range(10):  # Flicker and vibrate for 10 intervals
		await get_tree().create_timer(flicker_interval).timeout
		_toggle_flicker()
		
		# Vibrate by moving the character slightly
		var offset = Vector2(rand_range(-vibration_amount, vibration_amount), rand_range(-vibration_amount, vibration_amount))
		global_position += offset
		global_position = original_position

	# Reset color and position after flickering and vibrating
	sprite.modulate = original_color
	global_position = original_position

func _toggle_flicker():
	var sprite = $Sprite2D
	if sprite.modulate == Color(1, 1, 1, 1):
		sprite.modulate = Color(1, 1, 1, 0.5)  # Change to semi-transparent
	else:
		sprite.modulate = Color(1, 1, 1, 1)  # Change back to original color

func rand_range(min, max):
	return min + randf() * (max - min)
