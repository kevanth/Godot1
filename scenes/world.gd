extends Node2D

@export var goo : PackedScene

func _process(delta):
	var current_enemies = get_tree().get_nodes_in_group("enemies").size()
	#if current_enemies < 2	:
		#var goo = goo.instantiate()
		#goo.global_position = get_node("gund").global_position + Vector2(randf_range(-30,30),randf_range(-30,30))
		#add_child(goo)
#

