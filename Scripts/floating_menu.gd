extends Control


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _modulate_menu(alpha: float) -> void:
	var mod_tween: Tween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	mod_tween.tween_property(self, "modulate", Color(1, 1, 1, alpha), 0.5)
	
