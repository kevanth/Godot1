extends Node

@export var init_state : State

var current_state : State
var states: Dictionary = {}
var character: Character


func _ready():
	
	character = Character.new(
			get_parent(),
			get_parent().get_node_or_null("Sprite2D"),
			get_parent().get_node_or_null("CollisionShape2D"),
			get_parent().get_node_or_null("AnimationPlayer"),
			get_parent().get_node_or_null("AnimationTree")
			)
	#initialize Dicionary states
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.character = character
			child.Transitioned.connect(on_child_transition)
			
	if init_state:
			current_state = init_state.enter()

func _process(delta):
	#dead
	if character.body.health<=0:
		on_child_transition(current_state,"GooDead")
	if current_state:
		current_state.update(delta)
	
func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)
		
func on_child_transition(state : State, new_state_name : String):
	print("trainsition from: " + state.name + " To " + new_state_name)
	if state != current_state:
		return
		
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		#if ! exist then return
		return
		
	if current_state: 
		#if we have a current_state exit
		current_state.exit()
	
	if new_state:
		current_state = new_state.enter()
		assert (current_state != null, "Error, new state enter() returning null")
	
