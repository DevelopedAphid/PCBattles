extends Line2D

#TODO: make the grid size global

var grid_size: int = 25

func _ready():
	add_point(Vector2(0,0))
	var x = 0
	var y = 0
	
	for n in range(grid_size, get_viewport_rect().size.x + grid_size, grid_size):
		add_point(Vector2(x,0))
		add_point(Vector2(x,get_viewport_rect().size.y))
		add_point(Vector2(x,0))
		x = n
	
	for n in range(grid_size, get_viewport_rect().size.y + grid_size, grid_size):
		add_point(Vector2(0,y))
		add_point(Vector2(get_viewport_rect().size.x,y))
		add_point(Vector2(0,y))
		y = n

