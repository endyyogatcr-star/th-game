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
			GlobalTransition.change_scene("res://scenes/levels/MissionSD.tscn", "Menuju ke SD Karang Anyar...")

		"rt03":
			print("Berangkat menuju RT 03.")
			GlobalTransition.change_scene("res://scenes/levels/MissionRT03.tscn", "Menuju ke RT 03...")

		"pak_darto":
			print("Berangkat menuju rumah Pak Darto.")
			GlobalTransition.change_scene("res://scenes/levels/MissionPakDarto.tscn", "Menuju ke Rumah Pak Darto...")

		_:
			print("Belum ada lokasi yang dipilih.")
