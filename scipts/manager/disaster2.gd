extends Node2D

func _ready():
	DialogueManager.call_deferred("start_decision_2_dialogue")
