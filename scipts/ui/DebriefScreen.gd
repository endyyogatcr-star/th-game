extends CanvasLayer

func _ready():
	var lines = []
	
	if GameManager.mission_order.size() >= 3 and GameManager.mission_order[2] == "pak_darto":
		lines.append("Kamu memilih menyelamatkan pak Darto di prioritas terakhir yang mengakibatkan Mbah Karto yang bersama beliau terluka.")
		
	if GameManager.sd_rescue_method == "sd_no_resource":
		lines.append("Anak-anak dari SD terluka akibat proses evakuasi tanpa menggunakan alat yang aman.")
	
	if GameManager.rt03_rescue_method != "rt03_use_rope":
		lines.append("Warga RT 03 mengalami cedera karena alat evakuasi yang digunakan tidak sesuai.")
		
	if lines.size() == 0:
		lines.append("Luar biasa! Tidak ada warga yang terluka parah berkat keputusan cepat dan penggunaan alat yang tepat.")
	else:
		if GameManager.unsaved_civilians > 0:
			lines.append("Ada " + str(GameManager.unsaved_civilians) + " warga yang terluka parah tidak bisa tertangani karena persediaan medis kurang.")
	
	var text = ""
	for i in range(lines.size()):
		text += lines[i]
		if i < lines.size() - 1:
			text += "\n\n"
		
	$CenterContainer/Label.text = text
