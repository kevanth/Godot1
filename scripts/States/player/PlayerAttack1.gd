extends PlayerAttack
class_name PlayerAttack1
var isCharging 
var slideBackCD

func enter():
	character.animationStateMachine.travel("attackCharge1")
	isCharging = true
	slideBackCD = 0.2
	return self
	
func physics_update(_delta : float):
	if slideBackCD > 0:
		character.body.velocity = Vector2(1,0) if character.sprite.flip_h else Vector2(-1,0)
		character.body.velocity *=30
		slideBackCD -= _delta
		character.body.move_and_slide()
	else:
		character.body.velocity = Vector2.ZERO 
		
	if !Input.is_key_pressed(KEY_Q) and isCharging:
		character.animationStateMachine.travel("attack1")
		if not character.animationTree.animation_finished.is_connected(_on_animation_fin):
			character.animationTree.animation_finished.connect(_on_animation_fin)
		character.body.velocity = -(Vector2(1,0) if character.sprite.flip_h else Vector2(-1,0))
		character.body.velocity *= 600
		slideBackCD -= _delta
		isCharging = false
		character.body.move_and_slide()
		
		var hitBoxNode = hitBox.instantiate()
		hitBoxNode.global_position = character.body.global_position + (Vector2(-11,0) if character.sprite.flip_h else Vector2(11,0))
		
		var animationPlayer = hitBoxNode.get_node("AnimationPlayer")
		if(animationPlayer): 
			animationPlayer.play("attack1hitbox")
			hitBoxNode.get_node("Sprite2D").flip_h = character.sprite.flip_h
			# Connect the animation_finished signal to a function that deletes the shadow
			if not animationPlayer.animation_finished.is_connected(_on_animation_fin_hitbox):
				animationPlayer.animation_finished.connect(_on_animation_fin_hitbox.bind(hitBoxNode))
		character.body.get_parent().add_child(hitBoxNode)
		
func _on_animation_fin_hitbox(animationName,body):
	if animationName == "attack1hitbox":
		body.queue_free()

func _on_animation_fin(animationName):
	if animationName == "attack1":
		Transitioned.emit(self,"PlayerIdle")
