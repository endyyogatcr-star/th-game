extends CanvasLayer

var color_rect: ColorRect
var label: Label

func _ready():
	layer = 100
	
	color_rect = ColorRect.new()
	color_rect.color = Color.BLACK
	color_rect.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	color_rect.modulate.a = 0
	add_child(color_rect)
	
	var center_container = CenterContainer.new()
	center_container.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	color_rect.add_child(center_container)
	
	label = Label.new()
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.add_theme_font_size_override("font_size", 24)
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	label.custom_minimum_size = Vector2(800, 0) # Allow wrapping
	center_container.add_child(label)

func change_scene(path: String, text: String = ""):
	label.text = text
	
	var tween = create_tween()
	tween.tween_property(color_rect, "modulate:a", 1.0, 0.5)
	await tween.finished
	
	if text != "":
		# Wait a bit so player can read the text
		await get_tree().create_timer(3.0).timeout
	else:
		await get_tree().create_timer(0.2).timeout
	
	get_tree().change_scene_to_file(path)
	
	var tween_out = create_tween()
	tween_out.tween_property(color_rect, "modulate:a", 0.0, 0.5)
	await tween_out.finished
