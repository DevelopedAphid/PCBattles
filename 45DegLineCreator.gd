extends Node2D

var is_drawing: bool = false
var point_count: int = 0
var grid_step: int 
var last_pos: Vector2

func _ready():
	$Line2D.hide()
	grid_step = get_parent().grid_size

#TODO: rename snap function
#TODO: make it so you can draw a second line after the first (create line creator from main)
#TODO: make component objects able to be placed by the player (and snap to grid)

func _input(event):
	if event is InputEventMouseButton && event.is_pressed(): #is_pressed debounces so we don't add to same spot
		if !is_drawing && point_count == 0 && get_parent().termination_points.has(snap_first_point_to_grid()): #checks that line begins at a termination point
			$Line2D.show()
			is_drawing = true
			#add origin point
			$Line2D.add_point(snap_first_point_to_grid())
			last_pos = snap_first_point_to_grid()
			point_count += 1
			#add second point so it can be moved
			$Line2D.add_point($Line2D.points[0])
			point_count += 1
		elif is_drawing:
			$Line2D.add_point(snap_next_point_to_grid())
			last_pos = snap_next_point_to_grid()
			point_count += 1
			if get_parent().termination_points.has(last_pos):
				is_drawing = false
				point_count = 0


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

func snap_first_point_to_grid():
	var mouse_pos: Vector2 = get_global_mouse_position()
	mouse_pos.x = stepify(mouse_pos.x, grid_step)
	mouse_pos.y = stepify(mouse_pos.y, grid_step)
	return mouse_pos
