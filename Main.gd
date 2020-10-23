extends Node2D

#settings
var grid_size: int  = 25
var termination_points = []

#scenes to be able to instance
export (PackedScene) var LineTermination

func _ready():
	#set up line terminations
	var line_termination_1 = LineTermination.instance()
	add_child(line_termination_1)
	termination_points.append(Vector2(100,100))
	line_termination_1.position = termination_points[0]
	
	var line_termination_2 = LineTermination.instance()
	add_child(line_termination_2)
	termination_points.append(Vector2(200,200))
	line_termination_2.position = termination_points[1]
	
