extends Node
class_name Character

var body : CharacterBody2D
var sprite : Sprite2D
var collision : CollisionShape2D
var animationPlayer : AnimationPlayer
var animationTree : AnimationTree
var animationStateMachine
#Constructor
func _init(new_body : CharacterBody2D, new_sprite : Sprite2D, new_collision : CollisionShape2D, new_animationPlayer : AnimationPlayer, new_animationTree : AnimationTree):
	body = new_body
	sprite = new_sprite
	collision = new_collision
	animationPlayer = new_animationPlayer
	animationTree = new_animationTree
	animationStateMachine = animationTree.get("parameters/playback") if animationTree != null else null
