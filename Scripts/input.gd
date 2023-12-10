extends GraphNode

const TOGGLE = preload("res://Scenes/Components/Extras/toggle.tscn")

@onready var controls: MarginContainer = $Controls
var right_port_values: Array = []

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	for i in range(right_port_values.size()):
		if right_port_values[i] == 1:
			set_slot_color_right(i, Globals.line_colors["active"])
		
		elif right_port_values[i] == 0:
			set_slot_color_right(i, Globals.line_colors["inactive"])
			
	for child in get_children():
		if child.is_in_group("toggle"):
			child.text = str(right_port_values[child.get_index()])
			
	for i in get_children():
		var index: int = 0
		if i.is_in_group("toggle"):
			index = i.get_index()
			i.button_pressed = right_port_values[index]

func set_slot_value(value: bool, slot_index: int) -> void:
	if value == true:
		right_port_values[slot_index] = 1
	else:
		right_port_values[slot_index] = 0

func value_toggled(button_pressed: bool, index: int) -> void:
	set_slot_value(button_pressed, index)

func _on_add_btn_pressed() -> void:
	var toggle: CheckButton = TOGGLE.instantiate()
	right_port_values.append(0)
	add_child(toggle)
	move_child(toggle, controls.get_index())
	
	toggle.connect("input_toggled", set_slot_value)
	
	for i in range(right_port_values.size()):
		set_slot_enabled_right(i, true)

func _on_rmv_btn_pressed() -> void:
	var index: int = 0
	for i in get_children():
		if i.is_in_group("toggle"):
			index = i.get_index()
	
	var graph: GraphEdit = get_parent()
	var graph_connections: Array = graph.get_connection_list()

	for connection: Dictionary in graph_connections:
		if connection["from_node"] == self.name:
			graph.disconnect_node(connection["from_node"], index, connection["to_node"], connection["to_port"])
	
	if get_child(index).is_in_group("toggle"):
		#var slot_size: = get_child(index).rect_size.y
		get_child(index).queue_free()
		#self.rect_size.y -= slot_size
	
		right_port_values.remove_at(index)
		set_slot_enabled_right(index, false)
