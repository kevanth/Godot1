extends Node2D

@export var goo : PackedScene
@onready var sinkhole = $sinkhole
@onready var player = $gund

func _ready():
	if Global.player_instance == null:
		Global.set_player_instance(player)
	print("Ready sene")

func _process(delta):
	var current_enemies = get_tree().get_nodes_in_group("enemies").size()
	#if current_enemies < 2	:
		#var goo = goo.instantiate()
		#goo.global_position = get_node("gund").global_position + Vector2(randf_range(-30,30),randf_range(-30,30))
		#add_child(goo)
	if current_enemies == 0 and !sinkhole.sprite.visible:
		level_cleared()
	
	
func level_cleared():
	#sinkhole activate 
	sinkhole.activate()

func next_level():
	print("NEXT LVL")
	GameController.change_scene("res://scenes/room_2.tscn")
	#GameController.reset_current_scene("res://scenes/room_1.tscn")
