extends TileMap

func _ready():
	var terrain_set = 3  # Adjust to your Terrain Set ID
	var terrain_type = 0  # The specific terrain type within the Terrain Set
	var tile_positions = []  # List of tiles to modify

	for x in range(10, 20):  # Example: Place terrain tiles in a 10x10 area
		for y in range(10, 20):
			tile_positions.append(Vector2i(x, y))

	set_cells_terrain_connect(0, tile_positions, terrain_set, terrain_type, true)  # Auto-connect terrain tiles
	notify_runtime_tile_data_update()  # Force TileMap update
