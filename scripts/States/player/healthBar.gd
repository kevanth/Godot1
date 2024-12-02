extends Control

@onready var health_icons = [
	$HBoxContainer/TextureRect,
	$HBoxContainer/TextureRect2,
	$HBoxContainer/TextureRect3
] 

func _ready():
	update_health_display()

func update_health(newHealth):
	Global.player_instance.health = newHealth
	#max_health = max_health
	#current_health = max(current_health, 0)  # Ensure health doesn't go below 0
	update_health_display()

func heal(heal_amount):
	Global.player_instance.health += heal_amount
	Global.player_instance.health = min(Global.player_instance.health, Global.player_instance.maxHealth)  # Ensure health doesn't exceed max
	update_health_display()

func update_health_display():
	for i in range(Global.player_instance.maxHealth):
		if i < Global.player_instance.health:
			health_icons[i].texture = preload("res://characters/player/heart_full.png")  # Full health icon
		else:
			health_icons[i].texture = preload("res://characters/player/heart_empty.png")  # Empty health icon
