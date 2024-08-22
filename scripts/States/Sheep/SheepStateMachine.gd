extends StateMachine


func _process(delta):
	#dead
	if character.body.health<=0 and current_state.name.to_lower()!="Dead":
		on_child_transition(current_state,"Dead")
	if current_state:
		current_state.update(delta)
	
