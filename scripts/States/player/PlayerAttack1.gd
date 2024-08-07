extends PlayerAttack
class_name PlayerAttack1
var isCharging 
var slideBackCD
var chargeTimeFull = 1
var currentChargingTime
var afterAttackWaitTime = 0.2
var minimumChargeTime = 0.1
var hitboxOffset = 11
@export var shadowScene : PackedScene 

func enter():
	character.animationPlayer.play("attackCharge1")
	isCharging = true
	currentChargingTime = 0
	slideBackCD = 0.2
	return self
	
func physics_update(delta : float):
	
	currentChargingTime += delta
	
	if currentChargingTime >= chargeTimeFull:
		fullChargeFlicker()
		
	if slideBackCD > 0:
		character.body.velocity = Vector2(1,0) if character.sprite.flip_h else Vector2(-1,0)
		character.body.velocity *=30
		slideBackCD -= delta
		character.body.move_and_slide()
	else:
		character.body.velocity = Vector2.ZERO 
		
	#release charge
	if !Input.is_key_pressed(KEY_Q) and isCharging and currentChargingTime>=minimumChargeTime:
		character.animationPlayer.play("attack1")
		if not character.animationPlayer.animation_finished.is_connected(_on_animation_fin):
			character.animationPlayer.animation_finished.connect(_on_animation_fin)
		character.body.velocity = -(Vector2(1,0) if character.sprite.flip_h else Vector2(-1,0))
		if currentChargingTime >= chargeTimeFull:
			character.body.velocity *= 2000
			var shadowNode = shadowScene.instantiate()
			shadowNode.global_position = character.body.global_position
			
			var animationPlayer = shadowNode.get_node("AnimationPlayer")
			if(animationPlayer): 
				animationPlayer.play("dash_vfx")
				shadowNode.get_node("Sprite2D").flip_h = character.sprite.flip_h
				# Connect the animation_finished signal to a function that deletes the shadow
				animationPlayer.animation_finished.connect(_on_animation_fin_dash.bind(shadowNode))
				character.body.get_parent().add_child(shadowNode)
		else :
			character.body.velocity *= 600			
		slideBackCD -= delta
		isCharging = false
		character.body.move_and_slide()
		
		var hitBoxNode = hitBox.instantiate()
		if currentChargingTime >= chargeTimeFull:
			hitBoxNode.damage = 60
			hitBoxNode.fullCharge = true
		else:
			hitBoxNode.damage = 20
			
		hitBoxNode.hitvfxToggle = true
		hitBoxNode.global_position = character.body.global_position + (Vector2(-hitboxOffset,0) if character.sprite.flip_h else Vector2(hitboxOffset,0))
		
		var animationPlayer = hitBoxNode.get_node("AnimationPlayer")
		if(animationPlayer): 
			animationPlayer.play("attack1hitbox")
			hitBoxNode.scale.x = -hitBoxNode.scale.x if character.sprite.flip_h else hitBoxNode.scale.x
			# Connect the animation_finished signal to a function that deletes the shadow
			if not animationPlayer.animation_finished.is_connected(_on_animation_fin_hitbox):
				animationPlayer.animation_finished.connect(_on_animation_fin_hitbox.bind(hitBoxNode))
		character.body.get_parent().add_child(hitBoxNode)
		
func _on_animation_fin_dash(animation_name,body):
	if animation_name == "dash_vfx":  # Replace with the name of your shadow animation
		body.queue_free()
		
		
func _on_animation_fin_hitbox(animationName,body):
	if animationName == "attack1hitbox":
		body.queue_free()

func _on_animation_fin(animationName):
	if animationName == "attack1":
		Transitioned.emit(self,"PlayerIdle")
		
func fullChargeFlicker():
	character.sprite.modulate = Color(1,2,2,1)
	await get_tree().create_timer(0.2).timeout
	character.sprite.modulate = Color(1,1,1,1)
	await get_tree().create_timer(0.2).timeout
