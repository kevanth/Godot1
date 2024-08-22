extends Sprite2D



func update_health(health, maxHealth):
	var percentage = float(health)/float(maxHealth) * 100
	print(health, " + ", maxHealth)
	print(percentage )
	frame = clamp(int(percentage / 10.0), 0, 9)
	 
