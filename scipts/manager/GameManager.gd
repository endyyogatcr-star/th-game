extends Node


var talked_to_kades := false
var interviewed_painah := true
var interviewed_slamet := true
var interviewed_wati := true
var interviewed_ujang := true
var interviewed_surti := true
var interviewed_yanto := true
var report_ready := false
var first_talk_asisten :=false
var first_talk_ketua :=false
var departure_ready := false
var selected_priority := ""
var has_medical_supply := false
var has_radio := false
var has_supply_box := false
var decision_made := false
var completed_sd := false
var completed_rt03 := false
var completed_pak_darto := false
var medical_supply := 3
var carmantel_rope := 1
var lifebuoy := 2
var rescue_score := 0
var mission_started := false
var talked_to_ani :=false
var talked_to_budi :=false
var sd_result := ""

func has_all_equipment() -> bool:
	return (
		has_medical_supply
		and has_radio
		and has_supply_box
	)

func get_interview_count() -> int:
	var count := 0
	if interviewed_painah:
		count += 1
	if interviewed_slamet:
		count += 1
	if interviewed_wati:
		count += 1
	if interviewed_ujang:
		count += 1
	if interviewed_surti:
		count += 1
	if interviewed_yanto:
		count += 1
	return count

func has_interviewed_all() -> bool:
	return get_interview_count() >= 6
	
func all_locations_completed() -> bool:

	return (
		completed_sd
		and completed_rt03
		and completed_pak_darto
	)
func go_to_disaster():
	get_tree().change_scene_to_file("res://scenes/levels/disaster01.tscn")
	
func _ready():
	print("Interview progress: ", get_interview_count(), "/6")
	print("=== RESCUE RESOURCE ===")
	print("Medical Supply: ", GameManager.medical_supply)
	print("Tali Carmantel: ", GameManager.carmantel_rope)
	print("Pelampung: ", GameManager.lifebuoy)
	print("Rescue Score: ", GameManager.rescue_score)

func get_report_summary() -> Array[String]:
	var report: Array[String] = []

	if interviewed_painah:
		report.append("Bu Painah mencemaskan anak-anak yang mungkin belum sempat \nkeluar dari kelas belakang SD Karang Anyar saat longsor.")

	if interviewed_slamet:
		report.append("Pak Slamet dengan panik melaporkan belasan warga RT 03 terjebak \ndi atap rumah karena air naik.")

	if interviewed_wati:
		report.append("Bu Wati mengklarifikasi laporan Pak Slamet, menyatakan bahwa \nkorban di RT 03 hanya sekitar 5-6 orang.")

	if interviewed_ujang:
		report.append("Kang Ujang melihat longsor mengarah ke rumah Pak Darto, akses ke \nsana kini tertutup reruntuhan.")

	if interviewed_surti:
		report.append("Ada kelompok rentan, Mbah Karto yang tak bisa berjalan dan anak kecil \nyang sulit dievakuasi di RT 03.")

	if interviewed_yanto:
		report.append("Pak Yanto menginformasikan alat evakuasi sangat terbatas \nhanya 1 tali carmantel & 2 pelampung.")

	return report

func use_lifebuoy() -> bool:

	if lifebuoy <= 0:
		return false

	lifebuoy -= 1

	print("Pelampung digunakan.")
	print("Sisa pelampung: ", lifebuoy)

	return true

func use_carmantel_rope() -> bool:

	if carmantel_rope <= 0:
		return false

	carmantel_rope -= 1

	print("Tali Carmantel digunakan.")
	print("Sisa tali Carmantel: ", carmantel_rope)

	return true

func use_medical_supply() -> bool:

	if medical_supply <= 0:
		return false

	medical_supply -= 1

	print("Medical Supply digunakan.")
	print("Sisa Medical Supply: ", medical_supply)

	return true
