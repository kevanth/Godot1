extends State
class_name GooAttack

var jump_component = null
var to_jump_timer 
var jumping = false
var charging = false
var charge_timer = randf_range(0.5, 1.5)
@export var jumpLandingAttack_Scene: PackedScene

var flicker_timer = 0.0  # Timer for flickering
var flicker_interval = 0.1  # Interval for flickering
var original_color  # Store the original color of the sprit

func enter():
	jump_component = character.body.get_node("GooJump") 
	jump_component.jump_started.connect(_on_jump_started)
	jump_component.jump_finished.connect(_on_jump_finished)
	to_jump_timer = randf_range(0, 1)
	return self

func physics_update(delta):

	if !jumping and !charging:
		character.animationPlayer.play("idle")
	
	if to_jump_timer <= 0:
		charging = true
		character.animationPlayer.play("jumpCharge")
		charge_timer -= delta
	elif jumping == false:
		to_jump_timer -= delta
		
	if charge_timer < 0 :
		var sprite = character.body.get_node("Sprite2D")
		character.animationPlayer.play("jump")
		jump()
		charge_timer = randf_range(0.5, 1.5)
		to_jump_timer = randf_range(0, 1)
		

func _on_jump_started():
	jumping = true

func _on_jump_finished():
	character.animationPlayer.play("idle")	
	var jumpLandingAttack = jumpLandingAttack_Scene.instantiate()
	jumpLandingAttack.global_position = character.body.global_position
	var animationPlayer = jumpLandingAttack.get_node("AnimationPlayer")
	if(animationPlayer): 
		animationPlayer.play("jumpfx")
		if not animationPlayer.animation_finished.is_connected(_on_animation_fin):
			animationPlayer.animation_finished.connect(_on_animation_fin.bind(jumpLandingAttack))
	character.body.get_parent().add_child(jumpLandingAttack)
	jumping = false

func jump():
	jump_component.start_jump(character.body.player.global_position, 1, 7)
		
func _on_animation_fin(body, animationName):
	if body == "jumpfx":
		animationName.queue_free()
		
func exit():
	jump_component.jump_finished.disconnect(_on_jump_finished)
		

