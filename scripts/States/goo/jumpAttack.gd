extends Area2D

func _init():
	collision_layer = 0
	collision_mask = 1 # Ensure this matches the layer of the enemies

func _ready():
	print("Setting up hitbox signals")
	self.connect("body_entered", _on_body_entered)
	print("Signals connected")

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("Hit a player body: ", body.name)
		body.take_damage(1)
		
