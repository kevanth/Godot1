# GameController.gd (Autoload)
extends Node

# Function to change scenes using get_tree()
func change_scene(scene_path: String):
	var player = Global.player_instance
	
	# Remove the player from the current scene if it's still in the tree
	if player and player.get_parent():
		player.get_parent().remove_child(player)
		
	if ResourceLoader.exists(scene_path):
		get_tree().change_scene_to_file(scene_path)
	else:
		print("Scene path does not exist: " + scene_path)
		return
		
	# Add the player to the new scene's root node after it loads
	player.move_local_x(10)
	print(get_tree().current_scene)
	# Add the player to the new scene after it has fully loaded
	call_deferred("_add_player_to_new_scene", player)

# Helper function to add the player to the new scene
func _add_player_to_new_scene(player):
	if get_tree().current_scene:
		player.move_local_x(10)
		get_tree().current_scene.add_child(player)
	else:
		print("Error: Current scene is not set.")
		

# Function to reset the current scene
func reset_current_scene(scene_path: String):
	var current_scene = get_tree().current_scene
	if current_scene:
		change_scene(scene_path)
		
		
		
		

# Function to pause the game
func pause_game():
	get_tree().paused = true

# Function to unpause the game
func unpause_game():
	get_tree().paused = false

# Function to quit the game
func quit_game():
	get_tree().quit()
