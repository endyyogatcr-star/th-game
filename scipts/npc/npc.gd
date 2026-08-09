extends CharacterBody2D

var player_nearby := false

@onready var dialogue_box = get_tree().get_first_node_in_group("dialogue_box")
func _on_interaction_area_body_entered(body):
	if body.name == "Player":
		player_nearby = true


func _on_interaction_area_body_exited(body):
	if body.name == "Player":
		player_nearby = false


func _process(_delta):
	if player_nearby and Input.is_action_just_pressed("interact"):
		print("NPC berhasil diajak bicara!")
