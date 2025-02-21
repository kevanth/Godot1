extends State

var walkTimer = -1
var standTimer
var direction
var walking = false
@export var walkSpeed:float

func enter():
	$"../../AnimationPlayer".play("stand")
	standTimer = randf_range(1,3)
	return self


func physics_update(delta):
	if near_player():
		Transitioned.emit(self,"Agroed")
	if standTimer>0:
		standTimer -= delta
		walking = false
		$"../../AnimationPlayer".play("stand")
	elif standTimer<=0 and walkTimer < 0 and walking == false:
		walking = true
		$"../../AnimationPlayer".play("walk")
		walkTimer = randf_range(3,6)
		direction = Vector2(randf_range(-1,1), randf_range(-1,1))
		character.sprite.flip_h = true if direction.x < 0 else false
		print(direction)
	elif walking == true and walkTimer < 0:
		standTimer = randf_range(1,3)		
	else:
		character.body.velocity = direction*walkSpeed
		character.body.move_and_slide()
		walkTimer-=delta
		

func near_player():
	var player_pos = character.body.player.global_position
	if int(player_pos.distance_to(character.body.position)) < 50:
		return true
	return false
