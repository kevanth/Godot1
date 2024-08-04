extends State
class_name PlayerWalk

@export var moveSpeed:int

func enter():
	character.animationStateMachine.travel("walk")
	return self

func physics_update(_delta : float):
	var inputDirection = Vector2(
		Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left'), 
		Input.get_action_strength('ui_down') - Input.get_action_strength('ui_up')
	).normalized()
	
	if(inputDirection != Vector2.ZERO):
		#walk
		if inputDirection.x > 0:
			character.sprite.flip_h = false
		else:
			character.sprite.flip_h = true
	
		character.body.velocity = moveSpeed * inputDirection
	
		character.body.velocity= character.body.velocity*1.5 if Input.is_key_pressed(KEY_SHIFT) else character.body.velocity
		character.body.move_and_slide()
	else:
		Transitioned.emit(self,"PlayerIdle")
		
	if Input.is_key_pressed(KEY_SPACE):
		Transitioned.emit(self,"PlayerDash")
	elif Input.is_key_pressed(KEY_Q):
		Transitioned.emit(self,"PlayerAttack1")
		
