extends Node


var dialogue_ui: CanvasLayer
var current_dialogue_id := ""

var dialogue_data := {

	"asisten_awal": {
		"speaker": "Asisten",
		"portrait": "res://assets/char/portrait/tim1/def.png",
		"lines": [
			"Hei, Selamat pagi.",
			"Kita baru saja menerima panggilan darurat dari 
			sebuah desa di sebelah timur.",
			"Menurut laporan awal, banjir cukup parah dan beberapa 
			rumah warga mengalami kerusakan.",
			"Sebelum kita berangkat, pastikan semua perlengkapan 
			yang dibutuhkan sudah dibawa.",
			"Setelah itu, temui Kepala Desa di seberang camp."
		]
	},

	"kades_01": {
		"speaker": "Kepala Desa",
		"portrait": "res://assets/char/portrait/kades/def.png",
		"lines": [
			"Anda dari tim penyelamat?",
			"Syukurlah kalian akhirnya datang.",
			"Desa kami terkena banjir cukup parah.",
			"Masih ada warga yang belum berhasil dievakuasi.",
			"Lokasinya berada di bagian timur desa.",
			"Saya harap kalian bisa membantu kami."
		]
	},

	"asisten_setelah_kades": {
		"speaker": "Asisten",
		"portrait": "res://assets/char/portrait/tim1/def.png",
		"lines": [
			"Sudah berbicara dengan Kepala Desa?",
			"Kalau begitu, kita sudah tahu situasinya.",
			"Sebelum berangkat, kita perlu memastikan semua perlengkapan sudah siap.",
			"Apakah kamu siap untuk berangkat?"
		],
		"choices": [
			"Siap.",
			"Belum.",
			"Apa saja yang perlu disiapkan?"
		]
	},
	"asisten_pilihan_siap": {
		"speaker": "Asisten",
		"portrait": "res://assets/char/portrait/tim1/def.png",
		"lines": [
			"Baik, kalau begitu kita bisa bersiap untuk berangkat."
		]
	},
	"asisten_pilihan_belum": {
		"speaker": "Asisten",
		"portrait": "res://assets/char/portrait/tim1/def.png",
		"lines": [
			"Baik.",
			"Siapkan semua perlengkapan terlebih dahulu."
		]
	},
	"asisten_pilihan_bertanya": {
		"speaker": "Asisten",
		"portrait": "res://assets/char/portrait/tim1/def.png",
		"lines": [
			"Kita membutuhkan tiga perlengkapan utama.",
			"Medical Supply untuk menangani warga yang terluka.",
			"Radio untuk berkomunikasi dengan tim.",
			"Dan Supply Box untuk membawa perlengkapan tambahan."
		]
	},
	"asisten_perlengkapan_belum": {
		"speaker": "Asisten",
		"portrait": "res://assets/char/portrait/tim1/def.png",
		"lines": [
			"Belum.",
			"Masih ada perlengkapan yang belum kamu ambil.",
			"Pastikan Medical Supply, Radio, dan Supply Box sudah dibawa."
		]
	},
	"asisten_semua_siap": {
		"speaker": "Asisten",
		"portrait": "res://assets/char/portrait/tim1/def.png",
		"lines": [
			"Bagus.",
			"Semua perlengkapan sudah lengkap.",
			"Kalau begitu, kita siap berangkat."
		]
	},
}
func register_dialogue_ui(ui: CanvasLayer):
	dialogue_ui = ui

	if not dialogue_ui.dialogue_finished.is_connected(_on_dialogue_finished):
		dialogue_ui.dialogue_finished.connect(_on_dialogue_finished)
	if not dialogue_ui.choice_selected.is_connected(_on_choice_selected):
		dialogue_ui.choice_selected.connect(_on_choice_selected)
	
func start_dialogue(dialogue_id: String):

	if dialogue_ui == null:
		print("DialogueUI belum terdaftar.")
		return

	if not dialogue_data.has(dialogue_id):
		print("Dialogue ID tidak ditemukan: ", dialogue_id)
		return

	if dialogue_ui.is_dialogue_active:
		return

	current_dialogue_id = dialogue_id

	var data: Dictionary = dialogue_data[dialogue_id]

	var speaker: String = data["speaker"]
	var portrait_path: String = data["portrait"]
	var lines: Array = data["lines"]
	var choices: Array = data.get("choices", [])

	if lines.is_empty():
		print("Dialog ", dialogue_id, " tidak memiliki isi.")
		return

	var portrait_texture = load(portrait_path)

	if portrait_texture == null:
		print("Portrait tidak ditemukan: ", portrait_path)
		return

	dialogue_ui.call_deferred(
		"start_dialogue",
		speaker,
		portrait_texture,
		lines,
		choices
	)

func _on_dialogue_finished():

	print("Dialog selesai: ", current_dialogue_id)

	if current_dialogue_id == "kades_01":

		GameManager.talked_to_kades = true

		print("GameManager: talked_to_kades = true")

func _on_choice_selected(index, text):
	print("Pilihan player: ", index, " - ", text)
	if current_dialogue_id == "asisten_setelah_kades":
		match index:
			0: _handle_pilihan_siap()
			1: start_dialogue("asisten_pilihan_belum")
			2: start_dialogue("asisten_pilihan_bertanya")

func _handle_pilihan_siap():

	if GameManager.has_all_equipment():
		start_dialogue("asisten_semua_siap")
	else:
		start_dialogue("asisten_perlengkapan_belum")
