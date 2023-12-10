extends GraphNode

const LABEL = preload("res://Scenes/Components/Extras/label.tscn")

@onready var controls: MarginContainer = $Controls
var input_values: Array = []

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	execute()
	for i in range(input_values.size()):
		if input_values[i] == 1:
			set_slot_color_left(i, Color(Globals.line_colors["active"]))
		
		elif input_values[i] == 0:
			set_slot_color_left(i, Color(Globals.line_colors["inactive"]))
			
func execute() -> void:
	for connection: Dictionary in get_parent().connection_list:
		if connection["to_node"] == self.name:
			input_values[connection["to_port"]] = connection["data"]

	for child in get_children():
		if child.is_in_group("value_label"):
			child.text = str(input_values[child.get_index()])

func _on_add_btn_pressed() -> void:
	var value_label: Label = LABEL.instantiate()
	input_values.append(0)
	add_child(value_label)
	move_child(value_label, controls.get_index())
	
	for i in range(input_values.size()):
		set_slot_enabled_left(i, true)
	
func _on_rmv_btn_pressed() -> void:
	var index: int = 0
	for i in get_children():
		if i.is_in_group("value_label"):
			index = i.get_index()
	
	var graph: GraphEdit = get_parent()
	var graph_connections: Array = graph.get_connection_list()

	for connection: Dictionary in graph_connections:
		if connection["from_node"] == self.name:
			graph.disconnect_node(connection["from_node"], index, connection["to_node"], connection["to_port"])
	
	if get_child(index).is_in_group("value_label"):
		#var slot_size: = get_child(index).rect_size.y
		
		# TODO: remove the connection line before queue_freeing.
		
		get_child(index).queue_free()
		#self.rect_size.y -= slot_size
	
		input_values.remove_at(index)
		set_slot_enabled_left(index, false)


