extends CharacterBody2D

var original_color = Color(1, 1, 1, 1)
var flicker_interval = 1  # Interval for flickering and vibrating
var vibration_amount = 1.0  # Amount of vibration in pixels
@export var health : int = 3
@export var maxHealth : int = 3 
var isTargetable = true

func _ready():
	add_to_group("player") 

func take_damage(damage: int):
	if(isTargetable):
		
		#shake camera
		$Camera2D.shake_strength = 2
		$Camera2D.shake_decay = 2
		
		var sprite = $Sprite2D
		health -= damage
		get_parent().get_node("UI").get_node("HealthBar").update_health(health)
		isTargetable = false
		sprite.modulate = Color(15, 15, 15, 0.5)  # Change to semi-transparent white
		await get_tree().create_timer(flicker_interval).timeout
		$Sprite2D.modulate = Color(1,1,1,1)
		isTargetable = true
