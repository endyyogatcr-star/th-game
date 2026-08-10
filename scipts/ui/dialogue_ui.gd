extends CanvasLayer

@onready var dialogue_box: Panel = $DialogueBox
@onready var portrait: TextureRect = $DialogueBox/MarginContainer/Content/Portrait
@onready var speaker_name: Label = $DialogueBox/MarginContainer/Content/VBoxContainer/SpeakerName
@onready var dialogue_label: Label = $DialogueBox/MarginContainer/Content/VBoxContainer/DialogueText
@onready var continue_indicator: Label = $DialogueBox/ContinueIndicator

var dialogues: Array = []
var current_dialogue := 0
var is_dialogue_active := false

var is_typing := false
var typing_speed := 0.03

func start_dialogue(speaker: String, lines: Array):
	dialogues = lines
	current_dialogue = 0
	is_dialogue_active = true

	speaker_name.text = speaker
	dialogue_box.visible = true
	continue_indicator.visible = false

	show_current_dialogue()


func show_current_dialogue():
	dialogue_label.text = dialogues[current_dialogue]

	is_typing = true
	dialogue_label.visible_characters = 0

	continue_indicator.visible = false

	var text_length = dialogue_label.text.length()

	for i in range(text_length):
		if not is_typing:
			break

		dialogue_label.visible_characters = i + 1
		await get_tree().create_timer(typing_speed).timeout

	is_typing = false
	dialogue_label.visible_characters = -1

	continue_indicator.visible = true

func _process(_delta):
	if is_dialogue_active and Input.is_action_just_pressed("interact"):

		if is_typing:
			is_typing = false
			continue_indicator.visible = true
		else:
			next_dialogue()

func next_dialogue():
	current_dialogue += 1

	if current_dialogue >= dialogues.size():
		end_dialogue()
	else:
		show_current_dialogue()


func end_dialogue():
	is_dialogue_active = false
	is_typing = false

	dialogues.clear()
	current_dialogue = 0

	dialogue_box.visible = false
	continue_indicator.visible = false
