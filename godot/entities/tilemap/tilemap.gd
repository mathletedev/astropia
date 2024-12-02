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
	var cells = []
	for y in dimensions.y:
		for x in dimensions.x:
			var tile = noise.get_noise_2d(x, y)
			if (tile < 0.3):
				cells.append(Vector2(x,y))
				
	set_cells_terrain_connect(cells,0,0,0)
