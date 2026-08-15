extends Area2D


var player_inside := false


func _ready():

	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body):

	if body.name == "Player":
		player_inside = true
		print("Player berada di dekat perahu.")


func _on_body_exited(body):

	if body.name == "Player":
		player_inside = false


func _process(_delta):

	if not player_inside:
		return

	if Input.is_action_just_pressed("interact"):

		print("Player berinteraksi dengan perahu.")

		enter_selected_mission()


func enter_selected_mission():

	match GameManager.selected_priority:

		"sd":
			print("Berangkat menuju SD Karang Anyar.")
			get_tree().change_scene_to_file(
				"res://scenes/levels/MissionSD.tscn"
			)

		"rt03":
			print("Berangkat menuju RT 03.")
			get_tree().change_scene_to_file(
				"res://scenes/levels/MissionRT03.tscn"
			)

		"pak_darto":
			print("Berangkat menuju rumah Pak Darto.")
			get_tree().change_scene_to_file(
				"res://scenes/levels/MissionPakDarto.tscn"
			)

		_:
			print("Belum ada lokasi yang dipilih.")
