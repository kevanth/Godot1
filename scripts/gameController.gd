# GameController.gd (Autoload)
extends Node

var current_scene: Node = null

func change_scene(scene_path: String) -> void:
	'''
	If current scene is empty set current scene to the one the tree is pointing towards (Active)
	Remove player from active scene
	Load new scene and add to tree, as well as update the health bar
	'''
	if !current_scene:
		current_scene = get_tree().current_scene #If first scene
	
	if Global.player_instance and Global.player_instance.get_parent():
		current_scene.remove_child(Global.player_instance)
	
	var new_scene = load(scene_path)
	if new_scene:
		var instance = new_scene.instantiate()
		current_scene.queue_free()  # Free the previous scene
		get_tree().root.add_child(instance)
		current_scene = instance  # Set the new scene as the current one
		print("Scene successfully changed to: ", current_scene)
		_add_player_to_new_scene(Global.player_instance)
		#current_scene.get_node("UI").get_node("HealthBar").update_health(Global.player_instance.health)
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
