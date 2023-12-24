extends GraphNode

var input_values: Array = [0]
var output_values: Array = [0]

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	execute()
	for i in range(output_values.size()):
		if output_values[i] == 1:
			set_slot_color_right(0, Color(Globals.line_colors["active"]))
		
		elif output_values[i] == 0:
			set_slot_color_right(0, Color(Globals.line_colors["inactive"]))

	if input_values[0] == 1:
		set_slot_color_left(0, Color(Globals.line_colors["active"]))
	elif input_values[0] == 0:
		set_slot_color_left(0, Color(Globals.line_colors["inactive"]))

func get_input_values() -> void:
	input_values = [0, 0]
	for connection: Dictionary in get_parent().connection_list:
		if connection["to_node"] == self.name:
			input_values[connection["to_port"]] = connection["data"]

func execute() -> void:
	get_input_values()
	if input_values[0]:
		output_values[0] = 0
	else:
		output_values[0] = 1
