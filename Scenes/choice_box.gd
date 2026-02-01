extends Panel

var a
var b
var c

signal choice_made(choice_id)

func _ready() -> void:
	a = $A
	b = $B
	c = $C
	
func setAll(choices_raw):
	var choices = choices_raw.split("|")
	
	a.setText(choices[0])
	b.setText(choices[1])
	c.setText(choices[2])

func choiceMade(choice_id):
	choice_made.emit(choice_id)
	$SelectSound.play()

func _on_Cbutton_pressed() -> void:
	choiceMade("C")


func _on_Bbutton_pressed() -> void:
	choiceMade("B")


func _on_Abutton_pressed() -> void:
	choiceMade("A")
