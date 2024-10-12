extends Node2D

# Declare member variables here if needed
@onready var character_body = $CharacterBody2D
@onready var sprite = $CharacterBody2D/Sprite2D
@onready var collision_shape = $CharacterBody2D/CollisionShape2D

func _ready():
	# Set the sprite to invisible initially
	sprite.visible = false
	# You can also set up any initial settings for the node here if needed
	print("Sprite is initially invisible")

# Function to activate the sprite
func activate():
	sprite.visible = true
	print("Sprite is now visible")
