extends Control

var file
var dialogue
var dialogue_index

var dialogue_box
var portrait
var choices_box

var waiting
var in_choice

var pumpkin_playlist
var playlist_index

signal court
signal corridor

func setInChoice(value):
	waiting = value
	in_choice = value

func _ready():
	in_choice = false
	waiting = false
	portrait = $NewPortrait
	dialogue_box = $DialogueBox
	choices_box = $ChoiceBox
	file = 'res://Text/pumpkin/pumpkin4.txt'
	pumpkin_playlist = ['res://Text/eye/eye1.txt','res://Text/eye/eye2.txt','res://Text/eye/eye3.txt','res://Text/eye/eye4.txt']
	playlist_index = 0
	dialogue = load_file(pumpkin_playlist[playlist_index])
	updateDialogue()

func reset():
	dialogue = load_file(pumpkin_playlist[playlist_index])
	updateDialogue()

func load_file(path):
	dialogue_index = 0
	
	var f = FileAccess.open(path, FileAccess.READ).get_as_text()
	
	var dialogue_array = f.strip_edges().split("\n", false) as Array
	
	return dialogue_array

func updateDialogue():
	var currentLine = dialogue[dialogue_index]
	
	if currentLine == "[COURT]":
		court.emit()
	elif currentLine == "[CORRIDOR]":
		corridor.emit()
	elif currentLine == "[STARTCOURT]":
		$MasterAnimationPlayer.play("startcourt")
	elif currentLine == "[STARTCORRIDOR]":
		$MasterAnimationPlayer.play("startcorridor")
	elif currentLine[0] == "[":
		currentLine = currentLine.substr(1, currentLine.length() - 2)
		portrait.setExpression(currentLine)
	elif currentLine[0] == "{":
		currentLine = currentLine.substr(1, currentLine.length() - 2)
		choices_box.visible = true
		choices_box.setAll(currentLine)
		in_choice = true
		waiting = true
	elif currentLine == "<END>":
		waiting = false
	elif currentLine[0] == "<":
		skip_to("<END>")
	else:
		dialogue_box.setText(dialogue[dialogue_index])
		waiting = true

func _process(delta: float) -> void:
	if not waiting and not in_choice:
		updateDialogue()
		dialogue_index += 1
		if dialogue_index == dialogue.size():
			playlist_index += 1
			if playlist_index >= pumpkin_playlist.size():
				get_tree().change_scene_to_file("res://Scenes/credits.tscn")
			else:
				reset()
	
	if Input.is_action_just_pressed("progressDialogue") and not in_choice:
		waiting = false
		$pageturn.pitch_scale = randf_range(0.3, 0.8)
		$pageturn.play()


func _on_choice_box_choice_made(choice_id: Variant) -> void:
	if in_choice:
		skip_to("<" + choice_id + ">")
		in_choice = false
		choices_box.visible = false
		waiting = false


func skip_to(identifier):
	while dialogue[dialogue_index] != identifier:
		dialogue_index += 1
	
	dialogue_index += 1
	updateDialogue()
