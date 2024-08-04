extends State

var walkTimer = -1
var standTimer
var direction
var walking = false
@export var walkSpeed:float

func enter():
	$"../../AnimationPlayer".play("stand")
	standTimer = randf_range(3,5)
	return self


func physics_update(delta):
	if standTimer>0:
		standTimer -= delta
		walking = false
		$"../../AnimationPlayer".play("stand")
	elif standTimer<=0 and walkTimer < 0 and walking == false:
		walking = true
		$"../../AnimationPlayer".play("walk")
		walkTimer = randf_range(1,3)
		direction = Vector2(randf_range(-1,1), randf_range(-1,1))
		character.sprite.flip_h = true if direction.x < 0 else false
		print(direction)
	elif walking == true and walkTimer < 0:
		print("finish walking")
		standTimer = randf_range(1,3)
		if 1 == randi_range(1,1):
			Transitioned.emit(self,"attack")	
	else: 
		#print("move")
		direction = checkIfHitWall(direction)
		character.body.velocity = direction*walkSpeed
		character.body.move_and_slide()
		walkTimer-=delta
		

func near_player():
	var player_pos = character.body.player.global_position
	if int(player_pos.distance_to(character.body.position)) < 50:
		return true
	return false

func checkIfHitWall(direction):
	var xFlipped = false
	var yFlipped = false
	for i in range(character.body.get_slide_collision_count()):
		var collision = character.body.get_slide_collision(i)
		if is_wall_collision(collision.get_normal()):
			print("Hit a wall with normal: ", collision.get_normal())
			# Handle wall collision (e.g., stop horizontal movement)
			if collision.get_normal().x != 0 and xFlipped == false:
				direction.x = -direction.x
				xFlipped = true
			elif yFlipped == false:
				yFlipped = true
				direction.y = -direction.y		
	return direction
	
func is_wall_collision(normal: Vector2) -> bool:
	return abs(normal.x) > 0.7 or abs(normal.y) > 0.7
