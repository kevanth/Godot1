extends PlayerAttack
class_name BasicAttack
var afterAttackWaitTime = 0.2
var minimumChargeTime = 0.1
var hitboxOffset = 11

func enter():
	character.animationPlayer.play("BasicAttack")
	return self
	
func physics_update(delta : float):
	character.animationPlayer.play("attack1")
	#if not character.animationTree.animation_finished.is_connected(_on_animation_fin):
	#	character.animationTree.animation_finished.connect(_on_animation_fin)
	character.body.velocity = -(Vector2(1,0) if character.sprite.flip_h else Vector2(-1,0))
	character.body.move_and_slide()
		
	var hitBoxNode = createHitbox(10,"BasicAttack",hitboxOffset)
		

func _on_animation_fin(animationName):
	if animationName == "attack1":
		Transitioned.emit(self,"PlayerIdle")
