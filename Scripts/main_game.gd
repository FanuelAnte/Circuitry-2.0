extends Control

@onready var floating_menu: Control = $FloatingMenu

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_mouse_button_pressed(2):
		var tween: Tween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
		tween.tween_property(floating_menu, "position", get_global_mouse_position(), 0.3)
