extends StateMachine
class_name EnemyStateMachine

func _ready() -> void:
	set_physics_process(false)
	super._ready()

func _process(delta):
	#dead
	if character.body.player and !is_physics_processing():
		set_physics_process(true)
	if character.body.health<=0 and current_state.name.to_lower()!="Dead":
		on_child_transition(current_state,"Dead")
	if current_state:
		current_state.update(delta)
