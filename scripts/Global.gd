# Global.gd
extends Node

# Global variable for storing the character instance
var player_instance: CharacterBody2D = null

# Function to set the character instance when it's created
func set_player_instance(player):
	player_instance = player
	print(player_instance)

# Function to remove or reset the character instance
func reset_player_instance():
	player_instance = null
