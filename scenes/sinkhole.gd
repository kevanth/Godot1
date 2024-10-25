extends Area2D

@onready var sprite = $Sprite2D

func _ready():
	# Set the sprite to invisible initially
	sprite.visible = false
	monitoring = true

# Function to activate the sprite
func activate():
	sprite.visible = true
	self.connect("body_entered",_on_body_entered)
	# Check if any bodies are already inside when the area becomes active
	var overlapping_bodies = get_overlapping_bodies()
	for body in overlapping_bodies:
		_on_body_entered(body)


func _on_body_entered(body):
	if body.is_in_group("player"):
		self.disconnect("body_entered",_on_body_entered)
		get_parent().next_level()
		
	

