extends Node


var talked_to_kades := false
var interviewed_painah := false
var interviewed_slamet := false
var interviewed_wati := false
var interviewed_ujang := false
var interviewed_surti := false
var interviewed_yanto := false

var first_talk_asisten :=false
var departure_ready := false

var has_medical_supply := false
var has_radio := false
var has_supply_box := false

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

func _ready():
	print("Interview progress: ", get_interview_count(), "/6")
