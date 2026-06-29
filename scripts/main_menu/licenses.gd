extends RichTextLabel

@export var licenses_path: String = "res://licenses.txt"
@export var play_button: Button

func _ready():
	var file = FileAccess.open(licenses_path, FileAccess.READ)
	if file:
		var licenses_text = file.get_as_text()
		licenses_text = "LICENSES:\n\n" + licenses_text
		text = licenses_text
	else:
		text = "failed to find licenses.txt\nthis is a bug"
		play_button.queue_free()
