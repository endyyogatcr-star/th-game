extends Area2D


@export_enum("medical_supply", "radio", "supply_box")
var equipment_type: String = "medical_supply"

@export var equipment_name: String = "Medical Supply"

var player_nearby := false


func _ready():

	if equipment_type == "medical_supply":
		if GameManager.has_medical_supply:
			queue_free()
			return

	if equipment_type == "radio":
		if GameManager.has_radio:
			queue_free()
			return

	if equipment_type == "supply_box":
		if GameManager.has_supply_box:
			queue_free()
			return
		
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.name == "Player":
		player_nearby = true


func _on_body_exited(body):
	if body.name == "Player":
		player_nearby = false


func _process(_delta):

	if not player_nearby:
		return

	if Input.is_action_just_pressed("interact"):
		collect_equipment()


func collect_equipment():

	match equipment_type:

		"medical_supply":
			GameManager.has_medical_supply = true

		"radio":
			GameManager.has_radio = true

		"supply_box":
			GameManager.has_supply_box = true

	print(equipment_name, " berhasil diambil.")

	print(
		"Medical: ", GameManager.has_medical_supply,
		" | Radio: ", GameManager.has_radio,
		" | Supply: ", GameManager.has_supply_box
	)
	queue_free()
