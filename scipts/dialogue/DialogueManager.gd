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
			"Ada anak-anak yang tadi masih di kelas belakang pas longsor...",
			"Saya nggak yakin semua sempat keluar.",
			"Saya sangat cemas dan merasa bersalah karena tidak sempat mengecek ulang."
		]
	},

	"slamet_01": {
		"speaker": "Pak Slamet",
		"portrait": "res://assets/char/portrait/slamet.png",
		"lines": [
			"Rumah kami mulai kemasukan air, banyak yang masih di atap!",
			"Ada belasan orang yang terjebak di sana!",
			"Tolong cepat!"
		]
	},

	"yanto_01": {
		"speaker": "Pak Yanto",
		"portrait": "res://assets/char/portrait/yanto.png",
		"lines": [
			"Alat kita cuma satu tali carmantel sama dua pelampung,",
			"sisanya di posko kecamatan yang aksesnya juga keputus.",
			"Dipakai sekarang atau ditahan buat yang lebih parah, saya serahkan ke tim."
		]
	},

	"wati_01": {
		"speaker": "Bu Wati",
		"portrait": "res://assets/char/portrait/wati.png",
		"lines": [
			"Saya baru saja dari arah RT 03.",
			"Memang airnya cukup tinggi.",
			"Tapi sepertinya tidak sebanyak yang dikatakan Pak Slamet.",
			"Gak sebanyak itu kok, paling cuma 5-6 orang.",
			"Sebagian udah naik ke rumah tetangga yang lebih tinggi."
		]
	},
	
	"ujang_01": {
		"speaker": "Kang Ujang",
		"portrait": "res://assets/char/portrait/ujang.png",
		"lines": [
			"Saya lihat longsornya ke arah rumah Pak Darto,",
			"tapi abis itu saya lari, gak sempat lihat lebih jauh.",
			"Aksesnya sekarang ketutup reruntuhan."
		]
	},
	
	"doctor_surti_01": {
		"speaker": "Dokter",
		"portrait": "res://assets/char/portrait/dokter_surti.png",
		"lines": [
			"Bapak Surti belum bisa diajak bicara.",
			"Kondisinya masih cukup lemah setelah dievakuasi.",
			"Tapi sebelum kondisinya memburuk, beliau sempat memberi saya informasi.",
			"Dia bisa keluar, tapi Mbah Karto di sebelah rumahnya gak bisa jalan, masih di dalam.",
			"Anak-anak kecil juga masih banyak yang digendong orang tuanya, susah gerak cepat."
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
	
	"ketua_tim_after_decision": {
		"speaker": "Ketua Tim",
			"portrait": "res://assets/char/portrait/ketua_tim.png",
			"lines": [
			"Keputusan sudah dibuat.",
			"Segera menuju lokasi yang sudah kita prioritaskan."
		]
	},

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
	},
	"sd_arrival": {
		"speaker": "Ketua Tim",
		"portrait": "res://assets/char/portrait/ketua_tim.png",
		"lines": [
			"Akhirnya kita sampai di sekolah.",
			"Menurut laporan warga, masih ada beberapa anak yang belum berhasil dievakuasi.",
			"Kita harus menentukan tindakan dengan cepat.",
			"Di sana! Ada dua anak di atas atap.",
			"Sepertinya mereka belum berhasil dievakuasi.",
			"Kita harus segera membantu mereka."
		]
	},
	"ani_01": {
		"speaker": "Anak 1",
		"portrait": "res://assets/char/portrait/ani.png",
		"lines": [
			"Pak! Tolong kami!",
			"Airnya terus naik!",
			"Kami sudah tidak bisa turun dari sini."
		]
	},
	"budi_01": {
		"speaker": "Anak 2",
		"portrait": "res://assets/char/portrait/Budi.png",
		"lines": [
			"Teman-teman yang lain sudah pergi.",
			"Tapi kami tertinggal karena tidak sempat turun.",
			"Tolong bawa kami keluar dari sini."
		]
	},
	"sd_rescue_decision": {
		"speaker": "Ketua Tim",
		"portrait": "res://assets/char/portrait/ketua_tim.png",
		"lines": [
			"Anak-anak itu masih terjebak di atas atap.",
			"Air di sekitar sekolah cukup deras.",
			"Kita harus menentukan cara untuk mengevakuasi mereka."
		],
		"choices":[
			"Gunakan 1 pelampung",
			"Gunakan tali Carmantel",
			"Evakuasi tanpa resource"
		]
	},
	"sd_use_lifebuoy": {
		"speaker": "Ketua Tim",
		"portrait": "res://assets/char/portrait/ketua_tim.png",
		"lines": [
			"Gunakan pelampung.",
			"Kita akan membantu mereka turun satu per satu.",
			"Pastikan anak-anak tetap tenang."
		]
	},
	"sd_use_rope": {
		"speaker": "Ketua Tim",
		"portrait": "res://assets/char/portrait/ketua_tim.png",
		"lines": [
			"Kita gunakan tali Carmantel.",
			"Amankan jalur terlebih dahulu.",
			"Setelah itu kita evakuasi anak-anak."
		]
	},
	"sd_no_resource": {
		"speaker": "Ketua Tim",
		"portrait": "res://assets/char/portrait/ketua_tim.png",
		"lines": [
			"Kita coba lakukan tanpa menggunakan perlengkapan.",
			"Semua harus bergerak dengan sangat hati-hati.",
			"Kesalahan sedikit saja bisa membahayakan anak-anak."
		]
	},
	"sd_empty": {
		"speaker": "Ketua Tim",
		"portrait": "res://assets/char/portrait/ketua_tim.png",
		"lines": [
			"Perlengkapan kita sudah habis"
		]
	},
	"sd_finish":{
		"speaker": "Ketua Tim",
		"portrait": "res://assets/char/portrait/ketua_tim.png",
		"lines": [
			"Ayo kita kembali"
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

	if current_dialogue_id == "ketua_tim_01":
		GameManager.first_talk_ketua = true
		print("GameManager: first_talk_ketua = true")

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
		return
		
	
	if current_dialogue_id == "ani_01":
		GameManager.talked_to_ani = true
	if current_dialogue_id == "budi_01":
		GameManager.talked_to_budi = true
	
	if current_dialogue_id == ("sd_empty"):
		start_dialogue("sd_rescue_decision")
	
	if current_dialogue_id == "sd_rescue_decision":
		GameManager.completed_sd = true
		print("SD selesai ", GameManager.completed_sd)
		get_tree().change_scene_to_file(
		"res://scenes/levels/MissionSDafter.tscn")
		return
	
	
	call_deferred("_clear_interaction_lock")

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

	elif current_dialogue_id == "sd_rescue_decision":
		match index:
			0:
				if GameManager.use_lifebuoy():
					start_dialogue("sd_use_lifebuoy")
				else:
					start_dialogue("sd_empty")
					print("Pelampung sudah habis.")
			1:
				if GameManager.use_carmantel_rope():
					start_dialogue("sd_use_rope")
				else:
					start_dialogue("sd_empty")
					print("Tali Carmantel sudah habis.")
			2:
				print("Player memilih evakuasi tanpa resource.")
				start_dialogue("sd_no_resource")
		
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

	lines.append("Informasi ini akan menjadi dasar untuk \nmenentukan prioritas penyelamatan.")

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
	GameManager.mission_started = true

	print("Prioritas dipilih: ", priority)

	interaction_lock = false

	match priority:
		"sd":
			start_dialogue("ketua_tim_pilih_sd")

		"rt03":
			start_dialogue("ketua_tim_pilih_rt03")

		"pak_darto":
			start_dialogue("ketua_tim_pilih_pak_darto")
