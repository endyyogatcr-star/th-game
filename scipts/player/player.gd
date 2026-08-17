extends CharacterBody2D

@export var speed: float = 200.0
@export var gravity: float = 1200.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var can_control := true

var sfx_jalan_air = preload("res://assets/audio/jalan air.ogg")
var sfx_jalan_biasa = preload("res://assets/audio/jalan biasa.ogg")
var sfx_player: AudioStreamPlayer2D

func _physics_process(delta):
	
	if not can_control:
		return

	if DialogueManager.dialogue_ui != null and DialogueManager.dialogue_ui.is_dialogue_active:
		velocity.x = 0
		animated_sprite.stop()
		if sfx_player != null and sfx_player.playing:
			sfx_player.stop()
		return

	var direction = Input.get_axis("move_left", "move_right")

	velocity.x = direction * speed

	if not is_on_floor():
		velocity.y += gravity * delta

	if direction != 0:
		animated_sprite.play("walk")
		animated_sprite.flip_h = direction < 0
		if sfx_player != null and not sfx_player.playing and sfx_player.stream != null:
			sfx_player.play()
	else:
		animated_sprite.stop()
		animated_sprite.play("idle")
		if sfx_player != null and sfx_player.playing:
			sfx_player.stop()

	move_and_slide()

func _ready():
	sfx_player = AudioStreamPlayer2D.new()
	add_child(sfx_player)
	var scene_path = get_tree().current_scene.scene_file_path if get_tree().current_scene else ""
	if "disaster01" in scene_path or "level_01" in scene_path:
		sfx_player.stream = sfx_jalan_air
	elif "Tent" in scene_path or "Tent02" in scene_path:
		sfx_player.stream = sfx_jalan_biasa
		
	if GameManager.has_method("update_bgm"):
		GameManager.update_bgm()

	if SceneTransitionData.spawn_point_name == "":
		return

	var spawn_point = get_tree().current_scene.get_node_or_null(
		SceneTransitionData.spawn_point_name
	)

	if spawn_point:
		global_position = spawn_point.global_position

	SceneTransitionData.spawn_point_name = ""
