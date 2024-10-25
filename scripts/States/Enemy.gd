extends CharacterBody2D
class_name Enemy

var original_color = Color(1, 1, 1, 1)
var flicker_interval = 1  # Interval for flickering and vibrating
var vibration_amount = 1.0  # Amount of vibration in pixels
var player 
@onready var state_machine = $"StateMachine"
@export var health : int = 100
@export var maxHealth : int = 100

func _init():
	collision_layer = 2
	collision_mask = 16
	self.add_to_group("enemies")

func _ready():
	# Store the original color of the sprite
	original_color = $Sprite2D.modulate
	
func _process(delta: float) -> void:
	player = Global.player_instance
	if player:
		# Proceed with your setup using the player instance
		set_process(false)
	else:
		print("Player instance not yet set, waiting...")

func take_damage(damage):
	var sprite = $Sprite2D
	#sprite.modulate = Color(1, 1, 1, 0.5)  # Change to semi-transparent white
	health -= damage
	get_node("Health").update_health(health, maxHealth)
	$Sprite2D.modulate = Color(15,15,15,1)
	await get_tree().create_timer(flicker_interval).timeout
	$Sprite2D.modulate = Color(1,1,1,1)
	$Health.frame
	
	# Start the flicker and vibration effect
	#_start_flicker_and_vibrate()
	
