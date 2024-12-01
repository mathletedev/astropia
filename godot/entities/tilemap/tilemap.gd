extends TileMapLayer

@export var dimensions: Vector2i = Vector2i(400, 400)

var noise := FastNoiseLite.new()
var tile_size := Vector2i(16, 16)


func _ready():
	var random_seed := randi()

	noise.seed = random_seed
	noise.frequency = 0.05
	noise.fractal_octaves = 1
	noise.fractal_lacunarity = 2
	noise.fractal_gain = 0.5

	generate_tiles()


func generate_tiles():
	for y in dimensions.y:
		for x in dimensions.x:
			var tile = get_tile(noise.get_noise_2d(x, y))
			if tile == Vector2i(-1, -1):
				continue

			set_cell(Vector2i(x, y), 1, tile)


func get_tile(noise_value: float):
	if noise_value > 0:
		return Vector2i(0, 0)
	else:
		return Vector2i(-1, -1)
