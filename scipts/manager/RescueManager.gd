extends Node


var active_event := false
var time_left := 0.0

var current_event_id := ""


signal rescue_event_started(event_id, duration)
signal rescue_event_timeout(event_id)
signal rescue_event_finished(event_id)


func start_event(event_id: String, duration: float):

	if active_event:
		return

	active_event = true
	current_event_id = event_id
	time_left = duration

	print("Rescue Event dimulai: ", event_id)
	print("Waktu: ", duration)

	rescue_event_started.emit(event_id, duration)


func _process(delta):

	if not active_event:
		return

	time_left -= delta

	if time_left <= 0.0:

		time_left = 0.0
		active_event = false

		print("WAKTU HABIS!")

		rescue_event_timeout.emit(current_event_id)

		current_event_id = ""
