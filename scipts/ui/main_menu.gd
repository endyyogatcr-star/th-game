extends Control

@onready var mulai_button: Button = $CenterContainer/VBoxContainer/MarginContainer/MulaiButton
@onready var keluar_button: Button = $CenterContainer/VBoxContainer/KeluarButton

func _ready() -> void:
	mulai_button.grab_focus()
	
	# Explicitly set focus neighbors just in case the MarginContainer disrupts auto-navigation
	mulai_button.focus_neighbor_bottom = mulai_button.get_path_to(keluar_button)
	keluar_button.focus_neighbor_top = keluar_button.get_path_to(mulai_button)
func _on_mulai_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/intro_sequence.tscn")

func _on_keluar_pressed() -> void:
	get_tree().quit()
