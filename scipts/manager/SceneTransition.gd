extends Area2D


@export_file("*.tscn")
var target_scene: String = ""

@export var spawn_point_name: String = ""

var player_nearby := false


func _ready():
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

		if target_scene != "":
			SceneTransitionData.spawn_point_name = spawn_point_name
			get_tree().change_scene_to_file(target_scene)
