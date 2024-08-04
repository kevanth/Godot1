extends Control

@onready var health_icons = [
	$HBoxContainer/TextureRect,
	$HBoxContainer/TextureRect2,
	$HBoxContainer/TextureRect3
]
var max_health = 3
var current_health = 3

func _ready():
	update_health_display()

func update_health(newHealth):
	current_health = newHealth
	#max_health = max_health
	#current_health = max(current_health, 0)  # Ensure health doesn't go below 0
	update_health_display()

func heal(heal_amount):
	current_health += heal_amount
	current_health = min(current_health, max_health)  # Ensure health doesn't exceed max
	update_health_display()

func update_health_display():
	for i in range(max_health):
		if i < current_health:
			health_icons[i].texture = preload("res://characters/player/heart_full.png")  # Full health icon
		else:
			health_icons[i].texture = preload("res://characters/player/heart_empty.png")  # Empty health icon
