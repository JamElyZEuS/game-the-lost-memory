extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var level1 = preload("res://Level1.tscn")
onready var final = preload("res://LevelFinal.tscn")
onready var extra = preload("res://LevelExtra.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	if get_tree().get_root().get_node_or_null('Level1') != null:
		get_tree().get_root().get_node('Level1').queue_free()
	if get_tree().get_root().get_node_or_null('Level2') != null:
		get_tree().get_root().get_node('Level2').queue_free()
	if get_tree().get_root().get_node_or_null('Level3') != null:
		get_tree().get_root().get_node('Level3').queue_free()
	if get_tree().get_root().get_node_or_null('LevelFinal') != null:
		get_tree().get_root().get_node('LevelFinal').queue_free()
	if get_tree().get_root().get_node_or_null('LevelExtra') != null:
		get_tree().get_root().get_node('LevelExtra').queue_free()
	
	if Dialogic.get_variable('good_end') == 'true':
		$CanvasLayer/Control/TextureRect/Button_Extra.set('disabled', false)
	if Dialogic.get_variable('final_reached') == 'true':
		$CanvasLayer/Control/TextureRect/Button_Final.set('disabled', false)
	
	if Dialogic.get_variable('bad_end') == 'true':
		$CanvasLayer/Control/TextureRect/End1/EImg1.set('visible', true)
	if Dialogic.get_variable('good_end') == 'true':
		$CanvasLayer/Control/TextureRect/End2/EImg2.set('visible', true)
	if Dialogic.get_variable('true_end') == 'true':
		$CanvasLayer/Control/TextureRect/TitleEnd.set('visible', true)
		$CanvasLayer/Control/TextureRect/End3/EImg3.set('visible', true)
	
	$CanvasLayer/Control/TextureRect/Button_Start.grab_focus()
	$AudioStreamPlayer.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Dialogic.get_variable('shattered1') == 'true':
		$CanvasLayer/Control/TextureRect/Shattered1/SImg1.set('visible', true)
	else:
		$CanvasLayer/Control/TextureRect/Shattered1/SImg1.set('visible', false)
	if Dialogic.get_variable('shattered2') == 'true':
		$CanvasLayer/Control/TextureRect/Shattered2/SImg2.set('visible', true)
	else:
		$CanvasLayer/Control/TextureRect/Shattered2/SImg2.set('visible', false)
	if Dialogic.get_variable('shattered3') == 'true':
		$CanvasLayer/Control/TextureRect/Shattered3/SImg3.set('visible', true)
	else:
		$CanvasLayer/Control/TextureRect/Shattered3/SImg3.set('visible', false)
	if Dialogic.get_variable('yukari') == 'true':
		$CanvasLayer/Control/TextureRect/ExtraDone.set('visible', true)
	else:
		$CanvasLayer/Control/TextureRect/ExtraDone.set('visible', false)


func _on_Button_Start_pressed():
	$AudioGUI.play()
	var lvl1_inst = level1.instance()
	get_tree().get_root().add_child(lvl1_inst)
	queue_free()


func _on_Button_Extra_pressed():
	$AudioGUI.play()
	var xtr_inst = extra.instance()
	get_tree().get_root().add_child(xtr_inst)
	queue_free()


func _on_Button_focus_entered():
	$AudioGUI.play()


func _on_Button_Final_pressed():
	$AudioGUI.play()
	var fnl_inst = final.instance()
	get_tree().get_root().add_child(fnl_inst)
	queue_free()


func _on_Button_Forget_pressed():
	$AudioGUI.play()
	var dial = Dialogic.start('forget_data')
	add_child(dial)
