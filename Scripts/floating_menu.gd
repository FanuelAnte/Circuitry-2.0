extends Control

const AND = preload("res://Scenes/Components/and.tscn")
const NOT = preload("res://Scenes/Components/not.tscn")

var graph_edit: GraphEdit

var added_node: Node

func _ready() -> void:
	graph_edit = get_parent().get_child(0)

func _process(delta: float) -> void:
	pass
	
func add_gate(scene_path: PackedScene) -> void:
	added_node = scene_path.instantiate()
	added_node.graph_edit = graph_edit
	graph_edit.add_child(added_node)

func _modulate_menu(alpha: float) -> void:
	var mod_tween: Tween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	mod_tween.tween_property(self, "modulate", Color(1, 1, 1, alpha), 0.5)
	
func _on_and_btn_button_down() -> void:
	_modulate_menu(0.5)
	add_gate(AND)
	
func _on_and_btn_button_up() -> void:
	_modulate_menu(1)
	added_node.is_being_dragged = false
	
func _on_not_btn_button_down() -> void:
	_modulate_menu(0.5)
	add_gate(NOT)
	
func _on_not_btn_button_up() -> void:
	_modulate_menu(1)
	added_node.is_being_dragged = false



