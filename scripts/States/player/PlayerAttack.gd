extends State
class_name PlayerAttack

@export var attackDamage : int
@export var hitBox : PackedScene

func createHitbox(damage:int, animationName:String, hitboxOffset:int):
	var hitBoxNode = hitBox.instantiate()
		
	hitBoxNode.global_position = character.body.global_position + (Vector2(-hitboxOffset,0) if character.sprite.flip_h else Vector2(hitboxOffset,0))
	
	var animationPlayer = hitBoxNode.get_node("AnimationPlayer")
	if(animationPlayer): 
		animationPlayer.play(animationName)
		hitBoxNode.scale.x = -hitBoxNode.scale.x if character.sprite.flip_h else hitBoxNode.scale.x
		# Connect the animation_finished signal to a function that deletes the shadow
		if not animationPlayer.animation_finished.is_connected(_on_animation_fin_hitbox):
			animationPlayer.animation_finished.connect(_on_animation_fin_hitbox.bind(hitBoxNode))
	character.body.get_parent().add_child(hitBoxNode)
	return hitBoxNode
		
		
		
func _on_animation_fin_hitbox(animationName,body):
	if animationName == animationName:
		body.queue_free()

