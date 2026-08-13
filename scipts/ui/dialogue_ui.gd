extends CanvasLayer

signal dialogue_finished
signal choice_selected(index, text)

@onready var dialogue_box: Panel = $DialogueBox
@onready var portrait: TextureRect = $DialogueBox/Portrait
@onready var speaker_name: Label = $DialogueBox/MarginContainer/Content/VBoxContainer/SpeakerName
@onready var dialogue_label: Label = $DialogueBox/MarginContainer/Content/VBoxContainer/DialogueText
@onready var continue_indicator: Label = $DialogueBox/ContinueIndicator
@onready var choice_box: Panel = $ChoiceBox
@onready var choice1: Button = $ChoiceBox/Choices/Choice1
@onready var choice2: Button = $ChoiceBox/Choices/Choice2
@onready var choice3: Button = $ChoiceBox/Choices/Choice3

var dialogues: Array = []
var pending_choices: Array = []
var current_dialogue := 0
var current_dialogue_id := ""
var is_dialogue_active := false

var is_typing := false
var typing_speed := 0.03

var choices: Array = []
var selected_choice := 0
var choosing := false

func _ready():
	DialogueManager.register_dialogue_ui(self)

	dialogue_box.visible = false
	continue_indicator.visible = false


func start_dialogue(speaker: String, portrait_texture: Texture2D, lines: Array, choice_list: Array = []):

	if lines.is_empty():
		print("Dialog kosong.")
		return

	if is_dialogue_active:
		return

	dialogues = lines.duplicate()
	current_dialogue = 0
	is_dialogue_active = true
	pending_choices = choice_list.duplicate()

	speaker_name.text = speaker
	portrait.texture = portrait_texture

	dialogue_box.visible = true
	continue_indicator.visible = false

	show_current_dialogue()

func show_current_dialogue():

	# Pengaman agar tidak mengakses Array kosong
	if dialogues.is_empty():
		end_dialogue()
		return

	# Pengaman index
	if current_dialogue < 0 or current_dialogue >= dialogues.size():
		end_dialogue()
		return

	dialogue_label.text = dialogues[current_dialogue]

	is_typing = true
	dialogue_label.visible_characters = 0
	continue_indicator.visible = false

	var text_length := dialogue_label.text.length()

	for i in range(text_length):

		if not is_typing:
			break

		dialogue_label.visible_characters = i + 1

		await get_tree().create_timer(typing_speed).timeout

	# Jika dialog sudah berakhir ketika coroutine menunggu,
	# jangan melakukan apa-apa lagi.
	if not is_dialogue_active:
		return

	is_typing = false
	dialogue_label.visible_characters = -1

	continue_indicator.visible = true


func _process(_delta):

	if not is_dialogue_active:
		return

	if choosing:
		handle_choice_input()
		return

	if Input.is_action_just_pressed("interact"):

		if is_typing:
			is_typing = false
			dialogue_label.visible_characters = -1
			continue_indicator.visible = true

		else:
			next_dialogue()


func handle_choice_input():

	if Input.is_action_just_pressed("choice_up"):
		selected_choice -= 1

		if selected_choice < 0:
			selected_choice = choices.size() - 1

		update_choice_selection()

	if Input.is_action_just_pressed("choice_down"):
		selected_choice += 1

		if selected_choice >= choices.size():
			selected_choice = 0

		update_choice_selection()

	if Input.is_action_just_pressed("interact"):
		select_choice()

func select_choice():

	if choices.is_empty():
		return

	if selected_choice < 0 or selected_choice >= choices.size():
		return

	var selected = choices[selected_choice]

	print("Player memilih: ", selected)

	choosing = false
	choice_box.visible = false

	choices.clear()
	pending_choices.clear()

	is_dialogue_active = false

	choice_selected.emit(selected_choice, selected)

func next_dialogue():

	if not is_dialogue_active:
		return

	if dialogues.is_empty():
		end_dialogue()
		return

	current_dialogue += 1

	if current_dialogue >= dialogues.size():

		if not pending_choices.is_empty():
			continue_indicator.visible = false
			show_choices(pending_choices)
			return

		end_dialogue()
		return

	show_current_dialogue()

func show_choices(choice_list: Array):

	if choice_list.is_empty():
		return

	choices = choice_list.duplicate()
	selected_choice = 0
	choosing = true

	choice_box.visible = true

	choice1.visible = false
	choice2.visible = false
	choice3.visible = false

	if choices.size() > 0:
		choice1.text = choices[0]
		choice1.visible = true

	if choices.size() > 1:
		choice2.text = choices[1]
		choice2.visible = true

	if choices.size() > 2:
		choice3.text = choices[2]
		choice3.visible = true

	update_choice_selection()

func hide_choices():

	choice_box.visible = false
	choosing = false

func update_choice_selection():

	choice1.text = "> " + choices[0] if selected_choice == 0 else choices[0]

	if choices.size() > 1:
		choice2.text = "> " + choices[1] if selected_choice == 1 else choices[1]

	if choices.size() > 2:
		choice3.text = "> " + choices[2] if selected_choice == 2 else choices[2]

func end_dialogue():

	is_dialogue_active = false
	is_typing = false

	dialogue_box.visible = false
	continue_indicator.visible = false
	choice_box.visible = false

	choosing = false
	
	dialogues.clear()
	current_dialogue = 0

	dialogue_finished.emit()
	
	print("Interview progress: ", GameManager.get_interview_count(), "/6")
