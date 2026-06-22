extends RichTextLabel

@export var licenses_path: String = "res://licenses.txt"

func _ready():
	var file = FileAccess.open(licenses_path, FileAccess.READ)
	if file:
		var licenses_text = file.get_as_text()
		licenses_text = "LICENSES:\n\n" + licenses_text
		text = licenses_text
