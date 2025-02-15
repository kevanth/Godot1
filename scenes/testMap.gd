extends TileMap

@export var map_size: Vector2i = Vector2i(200, 200)
@export var tile_count: int = 3  # Adjust based on your TileSet atlas

func _ready():
	for x in range(map_size.x):
		for y in range(map_size.y):
			var tile_id = randi() % tile_count  # Pick a random tile
			set_cell(0, Vector2i(x, y), 0, Vector2i(tile_id, 0))  # Layer, Position, TileSet Source, Atlas Coords
			print("Placing tile at:", x, y, " Tile ID:", tile_id)

