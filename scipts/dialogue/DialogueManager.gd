extends Node


var dialogue_ui: CanvasLayer
var current_dialogue_id := ""

var interaction_lock := false

var dialogue_data := {

	"asisten_awal": {
		"speaker": "Asisten",
		"portrait": "res://assets/char/portrait/asisten.png",
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
		"portrait": "res://assets/char/portrait/kades.png",
		"lines": [
			"Anda dari tim penyelamat?",
			"Syukurlah kalian akhirnya datang.",
			"Desa kami terkena banjir cukup parah.",
			"Masih ada warga yang belum berhasil dievakuasi.",
			"Lokasinya berada di bagian timur desa.",
			"Saya harap kalian bisa membantu kami."
		]
	},

	"painah_01": {
		"speaker": "Bu Painah",
		"portrait": "res://assets/char/portrait/painah.png",
		"lines": [
			"Syukurlah kalian datang.",
			"Saya dengar beberapa anak masih berada di sekitar sekolah.",
			"Saya tidak tahu pasti berapa orang yang masih di sana.",
			"Tapi sepertinya kondisinya cukup parah."
		]
	},

	"slamet_01": {
		"speaker": "Pak Slamet",
		"portrait": "res://assets/char/portrait/slamet.png",
		"lines": [
			"Syukurlah kalian datang.",
			"Air di RT 03 sudah semakin tinggi.",
			"Masih banyak warga yang terjebak di sana.",
			"Beberapa bahkan sudah naik ke atap rumah.",
			"Saya khawatir kalau air terus naik, keadaan akan semakin buruk."
		]
	},

	"yanto_01": {
		"speaker": "Pak Yanto",
		"portrait": "res://assets/char/portrait/yanto.png",
		"lines": [
			"Saya melihat keadaan dari arah timur sebelum kembali ke camp.",
			"Beberapa rumah di sana sudah rusak cukup parah.",
			"Air juga membuat jalan menuju bagian timur sulit dilewati.",
			"Kalau tim kalian hendak masuk ke sana, sebaiknya berhati-hati.",
			"Saya tidak tahu kondisi warga yang masih berada di dalam rumah."
		]
	},

	"wati_01": {
		"speaker": "Bu Wati",
		"portrait": "res://assets/char/portrait/wati.png",
		"lines": [
			"Saya baru saja dari arah RT 03.",
			"Memang airnya cukup tinggi.",
			"Tapi sepertinya tidak sebanyak yang dikatakan Pak Slamet.",
			"Saya kira warga yang terjebak tidak lebih dari beberapa orang.",
			"Meski begitu, saya juga tidak berani memastikan."
		]
	},
	
	"ujang_01": {
		"speaker": "Kang Ujang",
		"portrait": "res://assets/char/portrait/ujang.png",
		"lines": [
			"Kalau kalian mau ke arah rumah Pak Darto, hati-hati.",
			"Jalan di sana tertutup longsoran.",
			"Saya sempat melihat bagian rumahnya sebelum tanah turun.",
			"Saya tidak tahu apakah masih ada orang di dalam.",
			"Tapi sebaiknya jangan terlalu lama menunggu."
		]
	},
	
	"doctor_surti_01": {
		"speaker": "Dokter",
		"portrait": "res://assets/char/portrait/dokter_surti.png",
		"lines": [
			"Bapak Surti belum bisa diajak bicara.",
			"Kondisinya masih cukup lemah setelah dievakuasi.",
			"Tapi sebelum kondisinya memburuk, beliau sempat memberi saya informasi.",
			"Beliau mengatakan masih ada beberapa warga yang terjebak di sekitar 
			rumah-rumah di bagian timur, tepatnya tetangga Pak Surti.",
			"Beliau juga meminta agar tim penyelamat berhati-hati karena beberapa 
			jalan sudah tidak bisa dilewati."
		]
	},
	
	"asisten_need_kades": {
		"speaker": "Asisten",
		"portrait": "res://assets/char/portrait/asisten.png",
		"lines": [
			"Sepertinya kita sudah mendapatkan semua informasi dari warga.",
			"Sekarang coba bicara dengan kepala desa terlebih dahulu."
		]
	},
	
	"asisten_not_ready": {
		"speaker": "Asisten",
		"portrait": "res://assets/char/portrait/asisten.png",
		"lines": [
			"Kita belum mendapatkan semua informasi dari warga.",
			"Coba bicara dengan warga yang masih belum kita temui."
		]
	},
	
	"asisten_ready": {
		"speaker": "Asisten",
		"portrait": "res://assets/char/portrait/asisten.png",
		"lines": [
			"Semua informasi sudah kita kumpulkan.",
			"Ketua tim sudah menunggu di lokasi bencana.",
			"Kalau kamu sudah siap, kita bisa berangkat."
		],
		"choices": [
			"Siap, mari berangkat.",
			"Belum, saya ingin bersiap dulu.",
			"Apa saja yang perlu disiapkan?"
		]
	},
	
	"asisten_pilihan_belum": {
		"speaker": "Asisten",
		"portrait": "res://assets/char/portrait/asisten.png",
		"lines": [
			"Baik, kita tidak perlu terburu-buru.",
			"Pastikan kamu sudah siap sebelum kita berangkat."
		]
	},

	"asisten_pilihan_bertanya": {
		"speaker": "Asisten",
		"portrait": "res://assets/char/portrait/asisten.png",
		"lines": [
			"Yang paling penting adalah informasi yang sudah kita kumpulkan.",
			"Di lokasi nanti, kita akan bertemu dengan ketua tim penyelamat.",
			"Ketua tim akan menentukan prioritas berdasarkan kondisi di lapangan."
		]
	},

	"asisten_semua_siap": {
		"speaker": "Asisten",
		"portrait": "res://assets/char/portrait/asisten.png",
		"lines": [
			"Baik.",
			"Kalau begitu, mari kita berangkat ke lokasi bencana."
		]
	},
<<<<<<< HEAD
	
	"ketua_tim_after_decision": {
		"speaker": "Ketua Tim",
			"portrait": "res://assets/char/portrait/ketua_tim.png",
			"lines": [
			"Keputusan sudah dibuat.",
			"Segera menuju lokasi yang sudah kita prioritaskan."
		]
	},
=======
>>>>>>> a033c14c47f105df6dfa8fd1bf97efadadf18140

	"ketua_tim_01": {
		"speaker": "Ketua Tim",
		"portrait": "res://assets/char/portrait/ketua_tim.png",
		"lines": [
			"Kalian akhirnya sampai.",
			"Saya ingin mendengar laporan dari kalian.",
			"Apa yang berhasil kalian ketahui dari warga di camp?"
		]
	},

	"ketua_tim_no_report": {
		"speaker": "Ketua Tim",
		"portrait": "res://assets/char/portrait/ketua_tim.png",
		"lines": [
			"Kalian belum memiliki laporan yang cukup.",
			"Pastikan kalian sudah berbicara dengan warga sebelum datang ke sini."
		]
	},
	
	"ketua_tim_decision": {
		"speaker": "Ketua Tim",
		"portrait": "res://assets/char/portrait/ketua_tim.png",
		"lines": [
			"Baik. Saya sudah mendengar laporan kalian.",
			"Beberapa lokasi membutuhkan perhatian kita.",
			"Kita tidak mungkin menangani semuanya sekaligus.",
			"Kita harus menentukan prioritas."
		],
		"choices": [
			"Prioritaskan SD Karang Anyar",
			"Prioritaskan RT 03",
			"Prioritaskan Rumah Pak Darto"
		]
	},
	
	"ketua_tim_pilih_sd": {
		"speaker": "Ketua Tim",
		"portrait": "res://assets/char/portrait/ketua_tim.png",
		"lines": [
			"Baik.",
			"Kita prioritaskan SD Karang Anyar.",
			"Menurut laporan Bu Painah, masih ada kemungkinan anak-anak berada di sekitar sekolah.",
			"Tim bersiap menuju sekolah."
		]
	},
	"ketua_tim_pilih_rt03": {
		"speaker": "Ketua Tim",
		"portrait": "res://assets/char/portrait/ketua_tim.png",
		"lines": [
			"Baik.",
			"Kita prioritaskan RT 03.",
			"Informasi mengenai jumlah warga memang masih berbeda, tetapi kondisi air terus memburuk.",
			"Tim bersiap menuju RT 03."
		]
	},
	"ketua_tim_pilih_pak_darto": {
		"speaker": "Ketua Tim",
		"portrait": "res://assets/char/portrait/ketua_tim.png",
		"lines": [
			"Baik.",
			"Kita prioritaskan rumah Pak Darto.",
			"Jalur menuju rumahnya tertutup longsor dan kita tidak tahu apakah masih ada orang di dalam.",
			"Tim bersiap menuju lokasi."
		]
	}
}

func register_dialogue_ui(ui: CanvasLayer):
	dialogue_ui = ui

	if not dialogue_ui.dialogue_finished.is_connected(_on_dialogue_finished):
		dialogue_ui.dialogue_finished.connect(_on_dialogue_finished)
	if not dialogue_ui.choice_selected.is_connected(_on_choice_selected):
		dialogue_ui.choice_selected.connect(_on_choice_selected)
	
func start_dialogue(dialogue_id: String):

	if interaction_lock:
		return

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

func _clear_interaction_lock():
	interaction_lock = false

func _on_dialogue_finished():

	print("Dialog selesai: ", current_dialogue_id)
	interaction_lock = true

	if current_dialogue_id == "kades_01":
		GameManager.talked_to_kades = true
		print("GameManager: talked_to_kades = true")

	if current_dialogue_id == "asisten_awal":
		GameManager.first_talk_asisten = true
		print("GameManager: first_talk_asisten = true")

	if current_dialogue_id == "painah_01":
		GameManager.interviewed_painah = true
		print("GameManager: Bu Painah sudah diwawancarai")

	if current_dialogue_id == "slamet_01":
		GameManager.interviewed_slamet = true
		print("GameManager: Pak Slamet sudah diwawancarai")

	if current_dialogue_id == "wati_01":
		GameManager.interviewed_wati = true
		print("GameManager: Bu Wati sudah diwawancarai")
	
	if current_dialogue_id == "ujang_01":
		GameManager.interviewed_ujang = true
		print("GameManager: Kang Ujang sudah diwawancarai")
	
	if current_dialogue_id == "doctor_surti_01":
		GameManager.interviewed_surti = true
		print("GameManager: informasi Nenek Surti sudah diterima")

	if current_dialogue_id == "yanto_01":
		GameManager.interviewed_yanto = true
		print("GameManager: Pak Yanto sudah diwawancarai")

	if current_dialogue_id == "asisten_semua_siap":
		print("Player siap berangkat ke lokasi bencana.")
		call_deferred("_go_to_disaster")

	if current_dialogue_id == "custom_report":
		call_deferred("_start_decision_phase")
<<<<<<< HEAD
		return
		
	call_deferred("_clear_interaction_lock")
=======
	else:
		call_deferred("_clear_interaction_lock")

func _go_to_disaster():
	GameManager.go_to_disaster()
>>>>>>> a033c14c47f105df6dfa8fd1bf97efadadf18140

func _go_to_disaster():
	GameManager.go_to_disaster()

func _on_choice_selected(index, text):
	print("Pilihan player: ", index, " - ", text)
	if current_dialogue_id == "asisten_ready":
		match index:
			0:_handle_pilihan_siap()
			1:start_dialogue("asisten_pilihan_belum")
			2:start_dialogue("asisten_pilihan_bertanya")

	elif current_dialogue_id == "ketua_tim_decision":
		match index:
			0:_select_priority("sd")
			1:_select_priority("rt03")
			2:_select_priority("pak_darto")

func _handle_pilihan_siap():
	GameManager.departure_ready = true
	start_dialogue("asisten_semua_siap")

func start_custom_dialogue(
	speaker: String,
	portrait_path: String,
	lines: Array
):

	if interaction_lock:
		return

	if dialogue_ui == null:
		print("DialogueUI belum terdaftar.")
		return

	if dialogue_ui.is_dialogue_active:
		return

	var portrait_texture = load(portrait_path)

	if portrait_texture == null:
		print("Portrait tidak ditemukan: ", portrait_path)
		return

	current_dialogue_id = "custom_report"

	dialogue_ui.call_deferred(
		"start_dialogue",
		speaker,
		portrait_texture,
		lines,
		[]
	)

func start_report_dialogue():

	var report := GameManager.get_report_summary()

	if report.is_empty():
		start_dialogue("ketua_tim_no_report")
		return

	var lines: Array[String] = []

	lines.append("Baik. Sampaikan apa yang kalian temukan.")

	for information in report:
		lines.append("- " + information)

	lines.append("Informasi ini akan menjadi dasar untuk menentukan prioritas penyelamatan.")

	start_custom_dialogue(
		"Ketua Tim",
		"res://assets/char/portrait/ketua_tim.png",
		lines
	)

func _start_decision_phase():
	interaction_lock = false
	start_dialogue("ketua_tim_decision")

func _select_priority(priority: String):

	if GameManager.decision_made:
		return

	GameManager.selected_priority = priority
	GameManager.decision_made = true

	print("Prioritas dipilih: ", priority)

<<<<<<< HEAD
	interaction_lock = false

	match priority:
=======
	match priority:

>>>>>>> a033c14c47f105df6dfa8fd1bf97efadadf18140
		"sd":
			start_dialogue("ketua_tim_pilih_sd")

		"rt03":
			start_dialogue("ketua_tim_pilih_rt03")

		"pak_darto":
			start_dialogue("ketua_tim_pilih_pak_darto")
