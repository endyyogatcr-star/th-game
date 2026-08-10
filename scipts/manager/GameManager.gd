extends Node


var talked_to_kades := false

var has_medical_supply := false
var has_radio := false
var has_supply_box := false

func has_all_equipment() -> bool:
	return (
		has_medical_supply
		and has_radio
		and has_supply_box
	)
