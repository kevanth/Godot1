# Virtual base class for all states.
extends Node
class_name State
var character : Character

signal Transitioned


func enter() -> State:
	return self
	
func exit():
	pass

func update(_delta : float):
	pass
	
func physics_update(_delta : float):
	pass
 
