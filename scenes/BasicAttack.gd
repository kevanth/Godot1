extends PlayerAttack
class_name BasicAttack1

@export var endAnimationTime : float= 0.2
var minimumChargeTime = 0.1
var hitboxOffset = 7
var queuedNextAttack 
var currSeq
var timer 
var speedMult


func enter(sequence = "1"):
	timer =  $"../../Timer"
	queuedNextAttack = null
	currSeq = sequence
	character.animationPlayer.play("BasicAttack"+str(sequence))
	var hitBoxNode = createHitbox(10,"hitbox",hitboxOffset)
	hitBoxNode.get_node("AnimationPlayer").play("hitbox"+str(sequence),-1,2)
	hitBoxNode.hitvfxToggle = false
	hitBoxNode.damage = attackDamage * character.body.damageMultiplier
	speedMult = 1
	return self
	
func physics_update(delta : float):
	if not character.animationPlayer.animation_finished.is_connected(_on_animation_fin):
		character.animationPlayer.animation_finished.connect(_on_animation_fin)
	character.body.velocity = -(Vector2(5,0) if character.sprite.flip_h else Vector2(-5,0)) * speedMult
	character.body.move_and_slide()
		
func _input(event):
	if event is InputEventKey:
		if event.pressed and not event.echo:
			if event.get_key_label() == KEY_W:
				queuedNextAttack = "BasicAttack1"
			if Input.is_key_pressed(KEY_Q):
				queuedNextAttack = "PlayerAttack1"
				
func _on_animation_fin(animationName):
	if queuedNextAttack and currSeq != "2":
		if queuedNextAttack == "BasicAttack1" :
			Transitioned.emit(self,"BasicAttack1", "2")
		elif queuedNextAttack == "PlayerAttack1":
			Transitioned.emit(self,"PlayerAttack1")
	elif str(animationName).begins_with("BasicAttack"):
		timer.wait_time = endAnimationTime
		timer.start()
		speedMult = 0
		await timer.timeout
		Transitioned.emit(self,"PlayerIdle")
