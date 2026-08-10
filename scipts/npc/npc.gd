extends CharacterBody2D


@export var dialogue_id: String = "warga_01"

var player_nearby := false


func _on_interaction_area_body_entered(body):
	if body.name == "Player":
		player_nearby = true


func _on_interaction_area_body_exited(body):
	if body.name == "Player":
		player_nearby = false


func _process(_delta):

	if not player_nearby:
		return

	if DialogueManager.dialogue_ui == null:
		return

	if DialogueManager.dialogue_ui.is_dialogue_active:
		return

	if Input.is_action_just_pressed("interact"):
		DialogueManager.start_dialogue(dialogue_id)
