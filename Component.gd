extends Node2D

#scenes to be able to instance
export (PackedScene) var LineTermination

#settings
var termination_pos_1 = Vector2(16,16)
var termination_pos_2 = Vector2(-16,16)



func _ready():
	position = Vector2(16,16)
	#set up line terminations
	var line_termination_1 = LineTermination.instance()
	add_child(line_termination_1)
	line_termination_1.set_position(termination_pos_1)
	line_termination_1.update_line_term_array()
	
	var line_termination_2 = LineTermination.instance()
	add_child(line_termination_2)
	line_termination_2.set_position(termination_pos_2)
	line_termination_2.update_line_term_array()

