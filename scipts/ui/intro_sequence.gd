extends Control

var texts = [
	"Telah terjadi bencana banjir dan \nlongsor di Desa Karang Anyar...",
	"Banyak warga yang terjebak dan \nmembutuhkan evakuasi segera.",
	"Waktu kita tidak banyak...",
	"Setiap detik sangat berharga \ndi masa 'Golden Hour'.",
	"Bersiaplah untuk misi penyelamatan."
]

var current_index = 0
@onready var label: Label = $CenterContainer/Label
var is_finished = false

func _ready() -> void:
	label.modulate.a = 0
	show_next_text()

func show_next_text() -> void:
	if current_index >= texts.size():
		finish_intro()
		return
		
	label.text = texts[current_index]
	
	var tween = create_tween()
	# Fade In
	tween.tween_property(label, "modulate:a", 1.0, 1.5)
	# Wait
	tween.tween_interval(2.0)
	# Fade Out
	tween.tween_property(label, "modulate:a", 0.0, 1.5)
	
	tween.finished.connect(_on_tween_finished)

func _on_tween_finished() -> void:
	if not is_finished:
		current_index += 1
		show_next_text()

func finish_intro() -> void:
	if not is_finished:
		is_finished = true
		get_tree().change_scene_to_file("res://scenes/levels/level_01.tscn")
	
func _input(event: InputEvent) -> void:
	# Memungkinkan pemain melewati intro dengan menekan Enter/Spasi atau Escape
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("ui_cancel"):
		finish_intro()
