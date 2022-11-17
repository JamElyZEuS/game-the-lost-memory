extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if Dialogic.get_variable('shattered1') == 'true':
		$PauseMenu/Background/Shattered1/SImg1.set('visible', true)
	if Dialogic.get_variable('shattered2') == 'true':
		$PauseMenu/Background/Shattered2/SImg2.set('visible', true)
	if Dialogic.get_variable('shattered3') == 'true':
		$PauseMenu/Background/Shattered3/SImg3.set('visible', true)
	if Dialogic.get_variable('yukari') == 'true':
		$PauseMenu/Background/ExtraDone.set('visible', true)
	
	$PauseMenu/Background/Continue_Button.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Continue_Button_pressed():
	$PauseMenu/AudioGUI.play()
	get_tree().paused = false
	queue_free()


func _on_Exit_Button_pressed():
	$PauseMenu/AudioGUI.play()
	var mm = load("res://MainMenu.tscn")
	var mm_inst = mm.instance()
	get_tree().paused = false
	get_tree().get_root().add_child(mm_inst)
	queue_free()


func _on_Button_focus_entered():
	$PauseMenu/AudioGUI.play()
