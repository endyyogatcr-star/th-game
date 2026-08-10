extends CharacterBody2D


@export var npc_type: String = ""
@export var dialogue_id: String = ""

var player_nearby := false

func _on_interaction_area_body_entered(body):
	if body.name == "Player":
		player_nearby = true


func _on_interaction_area_body_exited(body):
	if body.name == "Player":
		player_nearby = false

func get_dialogue_id() -> String:
	match npc_type:
		"asisten":
			if not GameManager.talked_to_kades:				return "asisten_awal"
			if not GameManager.has_all_equipment():
				return "asisten_setelah_kades"
			return "asisten_siap"
		"kades":
			return "kades_01"

	return dialogue_id

func _process(_delta):

	if not player_nearby:
		return

	if DialogueManager.dialogue_ui == null:
		return

	if DialogueManager.dialogue_ui.is_dialogue_active:
		return

	if Input.is_action_just_pressed("interact"):
		DialogueManager.start_dialogue(get_dialogue_id())
