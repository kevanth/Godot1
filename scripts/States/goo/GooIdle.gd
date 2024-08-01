extends State
class_name GooIdle

var jump_component = null
var to_jump_timer 
var jumping = false
var charging = false
var charge_timer = 2

var flicker_timer = 0.0  # Timer for flickering
var flicker_interval = 0.1  # Interval for flickering
var original_color  # Store the original color of the sprite

func enter():
	jump_component = character.body.get_node("GooJump") 
	jump_component.jump_started.connect(_on_jump_started)
	jump_component.jump_finished.connect(_on_jump_finished)
	to_jump_timer = randf_range(0, 3)
	original_color = character.body.get_node("Sprite2D").modulate
	return self
	
func exit():
	jump_component.jump_started.disconnect(_on_jump_started)
	jump_component.jump_finished.disconnect(_on_jump_finished)

func physics_update(delta):
	if near_player():
		Transitioned.emit(self,"GooAttack")

	if !jumping:
		character.animationPlayer.play("idle")
	
	if to_jump_timer < 0:
		charging = true
		character.animationPlayer.play("jump_transition")
		# flicker logic for charging
		flicker_timer -= delta
		if flicker_timer <= 0:
			flicker_timer = flicker_interval
			var sprite = character.body.get_node("Sprite2D")
			if sprite.modulate == original_color:
				sprite.modulate = Color(1, 1, 1, 0.5)  # Change to white
			else:
				sprite.modulate = original_color  # Change back to original color
		charge_timer -= delta
	elif jumping == false:
		to_jump_timer -= delta
		
	if charge_timer < 0 :
		var sprite = character.body.get_node("Sprite2D")
		sprite.modulate = original_color
		character.animationPlayer.play("jump")
		jump()
		charge_timer = 2
		to_jump_timer = randf_range(0, 3)

func near_player():
	var player_pos = character.body.player.global_position
	if int(player_pos.distance_to(character.body.position)) < 50:
		return true
	return false

	
func _on_jump_started():
	jumping = true
	print("Jump started in idle state")

func _on_jump_finished():
	print("Jump finished in idle state")
	print(character.body.position)
	jumping = false

func jump():
	var random_destination = generate_random_destination()
	print(random_destination)
	jump_component.start_jump(random_destination, 1.5, 5)

func generate_random_destination():
	var min_x = -20.0
	var max_x = 20.0
	var min_y = -20.0
	var max_y = 20.0
	return character.body.global_position + Vector2(randf_range(min_x, max_x), randf_range(min_y, max_y))

func randf_range(min, max):
	return min + randf() * (max - min)
