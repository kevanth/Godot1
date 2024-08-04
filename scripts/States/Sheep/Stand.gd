extends State

class_name Stand

func enter():
	$"../../AnimationPlayer".play("stand")
	return self
