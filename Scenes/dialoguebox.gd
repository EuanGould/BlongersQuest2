extends Panel

var textLabel

func setText(text):
	textLabel.clear()
	textLabel.add_text(text)

func _ready():
	textLabel = $RichTextLabel
