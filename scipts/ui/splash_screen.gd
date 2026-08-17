extends Control

@onready var logo: TextureRect = $CenterContainer/TextureRect
var is_finished = false

func _ready() -> void:
	logo.modulate.a = 0
	
	var tween = create_tween()
	# Fade In
	tween.tween_property(logo, "modulate:a", 1.0, 1.5)
	# Wait
	tween.tween_interval(2.0)
	# Fade Out
	tween.tween_property(logo, "modulate:a", 0.0, 1.5)
	
	tween.finished.connect(_on_tween_finished)

func _on_tween_finished() -> void:
	finish_splash()

func finish_splash() -> void:
	if not is_finished:
		is_finished = true
		get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")

func _input(event: InputEvent) -> void:
	# Boleh di-skip dengan klik atau tombol
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("ui_cancel") or (event is InputEventMouseButton and event.pressed):
		finish_splash()
