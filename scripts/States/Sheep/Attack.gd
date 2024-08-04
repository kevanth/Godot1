extends State

var chargeTime
@export var speed:float
var originalScaleX
var rollTime 
var direction
var last_pos

func enter():
	$"../../AnimationPlayer".play("attackCharge")
	print("attack")
	originalScaleX = character.body.scale.x
	rollTime = randf_range(2,4)
	chargeTime = randf_range(2,4)
	return self
	
func physics_update(delta):
	if chargeTime>0:
		chargeTime -= delta
		direction =  (character.body.player.global_position - character.body.global_position).normalized()
		character.sprite.flip_h = true if direction.x < 0 else false
	elif rollTime < 0:
		Transitioned.emit(self,"Agroed")
	else:
		if $"../../AnimationPlayer".get_current_animation() != "attack":
				$"../../AnimationPlayer".play("attack")
		 # Check for collisions
		direction = checkIfHitWall(direction)	
		character.sprite.flip_h = true if direction.x < 0 else false
		character.body.velocity = direction * speed
		last_pos = character.body.global_position
		character.body.move_and_slide()
		rollTime -= delta
		

func is_wall_collision(normal: Vector2) -> bool:
	return abs(normal.x) > 0.7 or abs(normal.y) > 0.7


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
