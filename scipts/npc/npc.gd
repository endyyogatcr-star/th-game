extends CharacterBody2D

var player_nearby := false

@onready var dialogue_ui = get_parent().get_node("DialogueUI")

func _on_interaction_area_body_entered(body):
	if body.name == "Player":
		player_nearby = true


func _on_interaction_area_body_exited(body):
	if body.name == "Player":
		player_nearby = false


func _process(_delta):
	if player_nearby and Input.is_action_just_pressed("interact"):
		dialogue_ui.show_dialogue("Terimakasih sudah datang ke desa kami")
