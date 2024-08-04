extends Area2D

var damage: int
var fullCharge:int = false
var vfx_offset = Vector2(15,0)

func _init():
	collision_layer = 0
	collision_mask = 2 # Ensure this matches the layer of the enemies

func _ready():
	print("Setting up hitbox signals")
	self.connect("body_entered", _on_body_entered)
	print("Signals connected")

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		print("Hit an enemy body: ", body.name)
		body.take_damage(damage)
		hitvfx(body)
	
func hitvfx(body):
	if $Sprite2D.flip_h:
		$Sprite2D/hitvfx.position.x = -vfx_offset.x
	else:
		$Sprite2D/hitvfx.position.x = vfx_offset.x
	$Sprite2D/hitvfx.frame = 4 if fullCharge else randi_range(0,3)
	$Sprite2D/hitvfx.global_position = body.global_position
	$Sprite2D/hitvfx.set_visible(true)
	await get_tree().create_timer(1).timeout
	$Sprite2D/hitvfx.set_visible(false)
	
		
