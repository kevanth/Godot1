extends Sprite2D

func _init():
	frame = 9

func update_health(health, maxHealth):
	var percentage = float(health)/float(maxHealth) * 100
	print(health, " + ", maxHealth)
	print(percentage )
	frame = clamp(int(percentage / 10.0), 0, 9)
	print(frame)
	 
