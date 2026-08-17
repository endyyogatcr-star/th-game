extends CanvasLayer

func _ready() -> void:
	# Hilangkan instruksi kontrol perlahan setelah 5 detik
	var tween = create_tween()
	tween.tween_interval(5.0)
	tween.tween_property($TextureRect, "modulate:a", 0.0, 1.0)
	tween.parallel().tween_property($ColorRect, "modulate:a", 0.0, 1.0)
	tween.finished.connect(queue_free)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("ui_cancel"):
		queue_free()
