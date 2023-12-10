extends CheckButton

signal input_toggled(value: bool, index: int)

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_toggled(toggled_on: bool) -> void:
	self.text = str(toggled_on)
	emit_signal("input_toggled", toggled_on, get_index())
