extends CanvasLayer

@onready var dialogue_box: Panel = $DialogueBox
@onready var dialogue_label: Label = $DialogueBox/MarginContainer/Label

var dialogues: Array = []
var current_dialogue := 0
var is_dialogue_active := false


func start_dialogue(lines: Array):
	dialogues = lines
	current_dialogue = 0
	is_dialogue_active = true

	dialogue_box.visible = true
	dialogue_label.text = dialogues[current_dialogue]


func _process(_delta):
	if is_dialogue_active and Input.is_action_just_pressed("interact"):
		next_dialogue()


func next_dialogue():
	current_dialogue += 1

	if current_dialogue >= dialogues.size():
		end_dialogue()
	else:
		dialogue_label.text = dialogues[current_dialogue]


func end_dialogue():
	is_dialogue_active = false
	dialogues.clear()
	current_dialogue = 0
	dialogue_box.visible = false
