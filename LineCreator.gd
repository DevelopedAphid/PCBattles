extends Node2D

var is_drawing: bool = false
var point_count: int = 0

func _ready():
	$Line2D.hide()

#TODO: add debounce so that only one point is only added once
#TODO: finish line on enter/space or something

func _input(event):
	if event is InputEventMouseButton:
		if !is_drawing:
			$Line2D.show()
			is_drawing = true
			_add_point_at_position(event.position)
			
		_add_point_at_position(event.position)

func _process(_delta):
	if is_drawing:
		$Line2D.points[point_count - 1] = get_global_mouse_position()
		print(point_count)

func _add_point_at_position(pos):
	$Line2D.add_point(pos)
	point_count += 1
