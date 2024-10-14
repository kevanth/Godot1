extends Node2D

@onready var sprite = $Sprite2D

func _ready():
	# Set the sprite to invisible initially
	sprite.visible = false
	# You can also set up any initial settings for the node here if needed
	print("Sprite is initially invisible")

# Function to activate the sprite
func activate():
	sprite.visible = true
	print("Sprite is now visible")
