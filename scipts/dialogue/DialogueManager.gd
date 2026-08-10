extends Node


var dialogue_ui: CanvasLayer


var dialogue_data := {
	"warga_01": {
		"speaker": "Warga",
		"portrait": "res://assets/char/portrait/kades/def.png",
		"lines": [
			"Terimakasih sudah datang ke desa kami",
			"Desa kami baru saja terkena banjir bandang",
			"Banyak warga yang kehilangna nyawa juga persediaan pangan makin menipis"
		]
	},
	"tim_01": {
		"speaker": "Ketua Tim",
		"portrait": "res://assets/char/portrait/tim1/def.png",
		"lines": [
			"Mari langsung ke lokasi",
			"Kita akan memasuki zona terdampak.",
			"pastikan semua persiapan sudah matang."
	]
}
}


func register_dialogue_ui(ui: CanvasLayer):
	dialogue_ui = ui


func start_dialogue(dialogue_id: String):

	if dialogue_ui == null:
		print("DialogueUI belum terdaftar.")
		return

	if not dialogue_data.has(dialogue_id):
		print("Dialogue ID tidak ditemukan: ", dialogue_id)
		return

	if dialogue_ui.is_dialogue_active:
		return

	var data: Dictionary = dialogue_data[dialogue_id]

	var speaker: String = data["speaker"]
	var portrait_path: String = data["portrait"]
	var lines: Array = data["lines"]

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
		lines
	)
