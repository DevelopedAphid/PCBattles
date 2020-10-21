extends Node2D

var is_drawing: bool = false
var point_count: int = 0
var grid_step: int = 100

func _ready():
	$Line2D.hide()

#TODO: add debounce so that only one point is only added once
#TODO: finish line on enter/space or something

func _input(event):
	if event is InputEventMouseButton:
		if !is_drawing:
			$Line2D.show()
			is_drawing = true
			_add_point_at_position(round_and_return_mouse_pos())
			
		_add_point_at_position(round_and_return_mouse_pos())

func _process(_delta):
	if is_drawing:
		$Line2D.points[point_count - 1] = round_and_return_mouse_pos()


func _add_point_at_position(pos):
	$Line2D.add_point(pos)
	point_count += 1

func round_and_return_mouse_pos():
	#get mouse position
	var mouse_position: Vector2 = get_global_mouse_position()
	#set to the grid
	mouse_position.x = stepify(mouse_position.x, grid_step)
	mouse_position.y = stepify(mouse_position.y, grid_step)
	return mouse_position
