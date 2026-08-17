extends CanvasLayer

var is_transitioning = false

func _ready():
	var injured = false
	
	if GameManager.mission_order.size() >= 3 and GameManager.mission_order[2] == "pak_darto":
		injured = true
		
	if GameManager.sd_rescue_method == "sd_no_resource":
		injured = true
	
	if GameManager.rt03_rescue_method != "rt03_use_rope":
		injured = true
		
	var ending_text = ""
	
	if not injured:
		ending_text = "Best Ending\n\nSemua korban selamat dan tidak ada yang terluka."
	elif GameManager.unsaved_civilians == 0:
		ending_text = "Good Ending\n\nAda korban terluka akibat evakuasi, namun semuanya berhasil diobati."
	elif GameManager.unsaved_civilians == 1:
		ending_text = "Neutral Ending\n\nSebanyak " + str(GameManager.unsaved_civilians) + " orang tidak terselamatkan karena kekurangan persediaan medis."
	else:
		ending_text = "Bad Ending\n\nSebanyak " + str(GameManager.unsaved_civilians) + " orang tidak terselamatkan."
		
	ending_text += "\n\n(Klik untuk melanjutkan)"
		
	$CenterContainer/Label.text = ending_text

func _input(event):
	if is_transitioning:
		return
		
	if (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT) or event.is_action_pressed("ui_accept"):
		is_transitioning = true
		GlobalTransition.change_scene("res://scenes/ui/main_menu.tscn", "Terimakasih telah memainkan demo dari game golden hour")
