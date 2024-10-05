extends Camera2D

var shake_strength = 0.0
var shake_decay = 0.0
var original_position = Vector2.ZERO

func _ready():
	# Store the original camera position
	original_position = position
	
func start_shake(strength: float, decay: float):
	shake_strength = strength
	shake_decay = decay

func _process(delta):
	if shake_strength > 0:
		# Create a random offset for the camera
		var shake_offset = Vector2(
			randf_range(-shake_strength, shake_strength),
			randf_range(-shake_strength, shake_strength)
		)
		
		# Apply the offset to the camera position
		position = original_position + shake_offset
		
		# Reduce the strength of the shake over time
		shake_strength = max(0, shake_strength - shake_decay * delta)
	else:
		# Return the camera to its original position once shaking stops
		position = original_position
