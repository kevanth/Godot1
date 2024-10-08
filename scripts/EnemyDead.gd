extends State
class_name EnemyDead

var original_color = Color(1, 1, 1, 1)
var flicker_interval = 0.2  # Interval for flickering and vibrating
var vibration_amount = 2 
var direction:Vector2
var flickered = false
var flyOff = 0.2
var flyoffspeed = 80

func enter():
	character.animationPlayer.play("dead")
	# Calculate the direction vector from player to the object
	direction = character.body.global_position - character.body.player.global_position
	# Normalize the direction vector to get a unit vector
	direction = direction.normalized()
	return self

func physics_update(delta):
	if flyOff > 0:
		character.body.velocity = direction * flyoffspeed
		character.body.move_and_slide()
		# Check if character is on a wall
		if character.body.is_on_wall():
			# Stop flying off if hit a wall
			flyOff = 0
			_start_flicker_and_vibrate()
		else:
			flyOff -= delta
	else :
		_start_flicker_and_vibrate()
	

func _start_flicker_and_vibrate() -> void:
	var sprite = character.sprite
	var original_position = character.body.global_position
	var jumping = false

	for i in range(10):  # Flicker and vibrate for 10 intervals
		await get_tree().create_timer(flicker_interval).timeout
		_toggle_flicker()
		
		# Vibrate by moving the character slightly
		var offset = Vector2(randf_range(-vibration_amount, vibration_amount), randf_range(-vibration_amount, vibration_amount))
		character.body.global_position += offset
		character.body.global_position = original_position

	# Reset color and position after flickering and vibrating
	sprite.modulate = original_color
	character.body.global_position = original_position
	character.body.queue_free()
	
	
func _toggle_flicker():
	var sprite = character.sprite
	if sprite.modulate == Color(1, 1, 1, 1):
		sprite.modulate = Color(1, 1, 1, 0.5)  # Change to semi-transparent
	else:
		sprite.modulate = Color(1, 1, 1, 1)  # Change back to original color
