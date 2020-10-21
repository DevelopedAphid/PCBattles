extends Node2D

var is_drawing: bool = false
var point_count: int = 0
var grid_step: int = 100
var last_pos: Vector2

func _ready():
	$Line2D.hide()

#TODO: add debounce so that only one point is only added once
#TODO: finish line on enter/space or something
#TODO: round the line edges so we don't get weird flat bits on 45 deg

func _input(event):
	if event is InputEventMouseButton:
		if !is_drawing:
			$Line2D.show()
			is_drawing = true
			$Line2D.add_point(snap_first_point_to_grid())
		elif is_drawing:
			$Line2D.add_point(add_next_point())
		
		

func _process(_delta):
	if is_drawing:
		$Line2D.points[point_count-1] = snap_next_point_to_grid()

func snap_next_point_to_grid():
		var mouse_pos: Vector2 = get_global_mouse_position()
		mouse_pos.x = stepify(mouse_pos.x, grid_step)
		mouse_pos.y = stepify(mouse_pos.y, grid_step)
		var point_diff: Vector2 = mouse_pos - last_pos
		
		#45 deg
		if abs(point_diff.x) == abs(point_diff.y):
			mouse_pos.x = last_pos.x + point_diff.x
			mouse_pos.y = last_pos.y + point_diff.y
		#x is long side
		elif abs(point_diff.x) > abs(point_diff.y):
			mouse_pos.y = last_pos.y
		#y is long side
		elif abs(point_diff.y) > abs(point_diff.x):
			mouse_pos.x = last_pos.x
		
		return mouse_pos

func add_next_point():
	last_pos = snap_next_point_to_grid()
	return last_pos

func snap_first_point_to_grid():
	var mouse_pos: Vector2 = get_global_mouse_position()
	mouse_pos.x = stepify(mouse_pos.x, grid_step)
	mouse_pos.y = stepify(mouse_pos.y, grid_step)
	last_pos = mouse_pos
	return mouse_pos
