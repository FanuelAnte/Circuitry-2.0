extends GraphEdit

var connection_list: Array
var selected_nodes: Dictionary = {}

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	update_connections()

func update_connections() -> void:
	var connections: Array = self.get_connection_list()

	for i in range(connections.size()):
		var from_path: NodePath = NodePath(connections[i].from_node)
		var node: GraphNode = self.get_node(from_path)
		if is_instance_valid(node):
			if node.output_values[connections[i].from_port] != null:
				connections[i]["data"] = node.output_values[connections[i].from_port]
		else:
			connections[i]["data"] = 0
		
	connection_list = connections
	
func _on_connection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
	for connection: Dictionary in connection_list:
		if connection.to_node == to_node and connection.to_port == to_port:
			return
	self.connect_node(from_node, from_port, to_node, to_port)

func _on_disconnection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
	self.disconnect_node(from_node, from_port, to_node, to_port)

func remove_connections_to_node(node: Node) -> void:
	for connection: Dictionary in connection_list:
		if connection.to_node == node.name or connection.from_node == node.name:
			self.disconnect_node(connection.from_node, connection.from_port, connection.to_node, connection.to_port)

func _on_delete_nodes_request(nodes: Array) -> void:
	for node: Node in selected_nodes.keys():
		if selected_nodes[node] and !(node.is_in_group("io_nodes")):
			remove_connections_to_node(node)
			node.queue_free()
	selected_nodes = {}

func _on_node_selected(node: Node) -> void:
	selected_nodes[node] = true

func _on_node_deselected(node: Node) -> void:
	selected_nodes[node] = false

