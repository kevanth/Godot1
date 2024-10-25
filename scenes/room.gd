extends Node2D

@export var goo : PackedScene
@onready var sinkhole = $sinkhole
@onready var player = $player

func _ready():
	if Global.player_instance == null:
		Global.set_player_instance(player)
	print("Ready scene")

func _process(delta):
	var current_enemies = get_tree().get_nodes_in_group("enemies").size()
	if current_enemies == 0 and !sinkhole.sprite.visible:
		level_cleared()
	
	
func level_cleared():
	#sinkhole activate 
	sinkhole.activate()

func next_level():
	print("NEXT LVL")
	GameController.change_scene("res://scenes/room_2.tscn")
	#GameController.reset_current_scene("res://scenes/room_1.tscn")
