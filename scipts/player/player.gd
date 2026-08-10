extends CharacterBody2D

@export var speed: float = 200.0
@export var gravity: float = 1200.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):

	if DialogueManager.dialogue_ui != null and DialogueManager.dialogue_ui.is_dialogue_active:
		velocity.x = 0
		animated_sprite.stop()
		return

	var direction = Input.get_axis("move_left", "move_right")

	velocity.x = direction * speed

	if not is_on_floor():
		velocity.y += gravity * delta

	if direction != 0:
		animated_sprite.play("walk")
		animated_sprite.flip_h = direction < 0
	else:
		animated_sprite.stop()
		animated_sprite.play("idle")

	move_and_slide()
