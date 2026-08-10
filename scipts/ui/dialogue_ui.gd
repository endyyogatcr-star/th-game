extends CanvasLayer

@onready var dialogue_box: Panel = $DialogueBox
@onready var dialogue_label: Label = $DialogueBox/MarginContainer/Label


func show_dialogue(text: String):
	dialogue_label.text = text
	dialogue_box.visible = true


func hide_dialogue():
	dialogue_box.visible = false
