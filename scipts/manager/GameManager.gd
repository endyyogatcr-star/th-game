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
var departure_ready := false
var selected_priority := ""
var has_medical_supply := false
var has_radio := false
var has_supply_box := false
var decision_made := false


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

func go_to_disaster():
	get_tree().change_scene_to_file("res://scenes/levels/disaster01.tscn")
	
func _ready():
	print("Interview progress: ", get_interview_count(), "/6")

func get_report_summary() -> Array[String]:
	var report: Array[String] = []

	if interviewed_painah:
		report.append("Ada kemungkinan korban masih berada di sekitar SD Karang Anyar.")

	if interviewed_slamet:
		report.append("Pak Slamet melaporkan banyak warga terjebak di RT 03.")

	if interviewed_wati:
		report.append("Bu Wati memberikan laporan berbeda mengenai jumlah warga di RT 03.")

	if interviewed_ujang:
		report.append("Akses menuju rumah Pak Darto tertutup longsor.")

	if interviewed_surti:
		report.append("Ada informasi mengenai warga yang masih terjebak di bagian timur.")

	if interviewed_yanto:
		report.append("Beberapa rumah di bagian timur mengalami kerusakan dan akses jalan sulit dilewati.")

	return report
