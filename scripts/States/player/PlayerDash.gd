extends State
class_name PlayerDash

@export var moveSpeed: int
@export var dashSpeed: int
@export var dashDuration : float  # Duration of the dash in seconds
@export var shadowScene : PackedScene 

var dashing: bool = false
var dash_time_left: float = 0.0
var dash_direction: Vector2 = Vector2.ZERO


func enter():
	character.animationStateMachine.travel("walk")
	character.body.isTargetable = false
	
	dashing = true
	dash_time_left = dashDuration
	dash_direction = character.body.velocity.normalized()
	
	addDashVfx()
	return self
	
func exit():
	character.body.isTargetable = true
	
func addDashVfx():
	var shadowNode = shadowScene.instantiate()
	shadowNode.global_position = character.body.global_position
	
	var animationPlayer = shadowNode.get_node("AnimationPlayer")
	if(animationPlayer): 
		animationPlayer.play("dash_vfx")
		shadowNode.get_node("Sprite2D").flip_h = character.sprite.flip_h
		# Connect the animation_finished signal to a function that deletes the shadow
		animationPlayer.animation_finished.connect(_on_animation_finished.bind(shadowNode))

	character.body.get_parent().add_child(shadowNode)
	
func _on_animation_finished(animation_name,body):
	if animation_name == "dash_vfx":  # Replace with the name of your shadow animation
		body.queue_free()
		
func physics_update(_delta: float):
	if dashing:
		if dash_time_left > 0:
			character.body.velocity = dashSpeed * dash_direction
			dash_time_left -= _delta
			character.body.move_and_slide()
		else:
			dashing = false
			character.body.velocity = Vector2.ZERO  # Reset velocity after dashing
			
	else:
		character.body.velocity = Vector2.ZERO
		var inputDirection = Vector2(
						Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left'), 
						Input.get_action_strength('ui_down') - Input.get_action_strength('ui_up')
					).normalized()
		if inputDirection != Vector2.ZERO:
			Transitioned.emit(self, "PlayerWalk")
		else:
			Transitioned.emit(self, "PlayerIdle")
