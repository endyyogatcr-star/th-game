extends Node2D


@onready var player = $Player


var cutscene_active := true
var cutscene_duration := 5.0
var cutscene_timer := 0.0


func _ready():

	start_arrival_cutscene()


func start_arrival_cutscene():

	cutscene_active = true
	cutscene_timer = cutscene_duration

	print("Cutscene kedatangan SD dimulai.")

	# Matikan kontrol player
	player.can_control = false


func _process(delta):

	if not cutscene_active:
		return

	# Gerak otomatis ke kanan
	player.velocity.x = player.speed

	player.move_and_slide()

	cutscene_timer -= delta

	if cutscene_timer <= 0.0:
		end_arrival_cutscene()


func end_arrival_cutscene():

	cutscene_active = false

	# Hentikan gerakan
	player.velocity.x = 0

	# Kembalikan kontrol player
	player.can_control = true

	print("Player tiba di SD.")

	DialogueManager.start_dialogue("sd_arrival")
