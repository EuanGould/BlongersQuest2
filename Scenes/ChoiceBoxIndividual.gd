extends Panel

var text_contents

var text_label

func _ready() -> void:
	text_label = $RichTextLabel

func setText(new_contents):
	text_label.clear()
	text_label.add_text(new_contents)
