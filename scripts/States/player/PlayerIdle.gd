extends State
class_name PlayerIdle

func enter():
	character.body.velocity = Vector2.ZERO
	character.animationPlayer.play("idle")
	return self

func update(_delta : float) -> void:
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down"):
		Transitioned.emit(self,"PlayerWalk")
	if Input.is_key_pressed(KEY_Q):
		Transitioned.emit(self,"PlayerAttack1")
