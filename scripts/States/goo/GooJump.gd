extends Node

signal jump_started
signal jump_finished

var jump_duration   
var jump_time 

var start 
var end 
var height

func _ready():
	set_physics_process(false)  # Disable processing initially

func start_jump(destination, duration, newHeight):
	jump_duration = duration
	jump_time = 0.0
	start = get_parent().global_position
	end = destination
	
	#if exceed max distance
	if(start.distance_to(end) > get_parent().max_distance):
		print("MAX")
		var direction = (end - start).normalized()
		end = start + direction * get_parent().max_distance
		
	height = newHeight # Adjust the jump height as needed
	emit_signal("jump_started")
	set_physics_process(true)  # Enable processing when the jump starts

func _physics_process(delta):
	jump_time += delta
	var t = jump_time / jump_duration
	if t > 1.0:
		t = 1.0
		set_physics_process(false)  # Disable physics processing after the jump finishes
		emit_signal("jump_finished")

	# Calculate the velocity for both horizontal and vertical movement
	var horizontal_velocity = (end.x - start.x) / jump_duration
	var vertical_velocity = (end.y - start.y) / jump_duration - height * 4 * (1 - 2 * t)

	get_parent().velocity = Vector2(horizontal_velocity, vertical_velocity)

	# Apply the velocity using move_and_slide to respect collisions
	get_parent().move_and_slide()
