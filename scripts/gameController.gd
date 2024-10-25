# GameController.gd (Autoload)
extends Node

var current_scene: Node = null
var player = null

func change_scene(scene_path: String) -> void:
	# Remove the player from the current scene if it's still in the tree
	player = Global.player_instance
	if !current_scene:
		current_scene = get_tree().current_scene #If first scene
	
	if player and player.get_parent():
		print(player)
		print(player.get_parent())
		current_scene.remove_child(player)
		print(player.get_parent())
	
	var new_scene = load(scene_path)
	if new_scene:
		var instance = new_scene.instantiate()
		current_scene.queue_free()  # Free the previous scene
		get_tree().root.add_child(instance)
		current_scene = instance  # Set the new scene as the current one
		print("Scene successfully changed to: ", current_scene)
		_add_player_to_new_scene(player)
	else:
		print("Failed to load scene: ", scene_path)

# Helper function to add the player to the new scene
func _add_player_to_new_scene(player):
	if current_scene:
		#player.position = Vector2(1,1)
		current_scene.add_child(player)
	else:
		print("Error: Current scene is not set.")
		
# Function to reset the current scene
func reset_current_scene(scene_path: String):
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
