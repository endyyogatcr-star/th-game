extends Area2D


@export_file("*.tscn")
var target_scene: String = ""

@export var spawn_point_name: String = ""

var player_nearby := false
var interact_icon: Sprite2D

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	interact_icon = Sprite2D.new()
	interact_icon.texture = load("res://assets/ui/interact.png")
	interact_icon.visible = false
	interact_icon.position = Vector2(0, -50)
	interact_icon.z_index = 10
	add_child(interact_icon)

func _on_body_entered(body):
	if body.name == "Player":
		player_nearby = true
		if interact_icon:
			interact_icon.visible = true

func _on_body_exited(body):
	if body.name == "Player":
		player_nearby = false
		if interact_icon:
			interact_icon.visible = false


func _process(_delta):

	if not player_nearby:
		return

	if Input.is_action_just_pressed("interact"):

		if target_scene != "":
			SceneTransitionData.spawn_point_name = spawn_point_name
			GlobalTransition.change_scene(target_scene)
