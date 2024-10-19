# GameController.gd (Autoload)
extends Node

# Function to change scenes using get_tree()
func change_scene(scene_path: String):
	if ResourceLoader.exists(scene_path):
		get_tree().change_scene_to_file(scene_path)
	else:
		print("Scene path does not exist: " + scene_path)

# Function to reset the current scene
func reset_current_scene(scene_path: String):
	var current_scene = get_tree().current_scene
	if current_scene:
		get_tree().change_scene_to_file(scene_path)

# Function to pause the game
func pause_game():
	get_tree().paused = true

# Function to unpause the game
func unpause_game():
	get_tree().paused = false

# Function to quit the game
func quit_game():
	get_tree().quit()
