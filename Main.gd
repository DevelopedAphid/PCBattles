extends Node2D

#settings
var grid_size: int  = 16
var termination_points = []

func _process(_delta):
	#can all this be done by getting a reference to the pointer earlier to reduce number of get_node calls?
	if get_node("45DegLineCreator").is_drawing == false:
		if get_node("Pointer").visible == false:
			get_node("Pointer").visible = true
		get_node("Pointer").position = get_node("45DegLineCreator").snap_first_point_to_grid()
	else: 
		if get_node("Pointer").visible == true:
			get_node("Pointer").visible = false
