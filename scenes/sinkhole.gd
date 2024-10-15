extends Node2D

@onready var sprite = $Sprite2D

func _ready():
	# Set the sprite to invisible initially
	sprite.visible = false

# Function to activate the sprite
func activate():
	sprite.visible = true
	self.connect("body_entered",_on_body_entered)


func _on_body_entered(body):
	if body.is_in_group("player"):
		#print("Hit a player body: ", body.name)
		print("CLEAR")
	

