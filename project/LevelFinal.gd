extends Node2D


# Declare member variables here. Examples:
const FAIRY_COUNT = 1
var fairies_dead = 0
onready var pause = preload("res://PauseMenu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_tree().get_root().get_node_or_null('Level3') != null:
		get_tree().get_root().get_node('Level3').queue_free()
	if Dialogic.get_variable('shattered1') == 'true' and Dialogic.get_variable('shattered2') == 'true' and Dialogic.get_variable('shattered3') == 'true':
		var dial = Dialogic.start('LevelFinal_good_start')
		add_child(dial)
	else:
		var dial = Dialogic.start('LevelFinal_start')
		add_child(dial)
	$Player/Camera2D.zoom = Vector2(0.4, 0.4)
	$Player.boss_battle = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_pause"):
		var pause_inst = pause.instance()
		add_child(pause_inst)
		get_tree().paused = true
	
	if fairies_dead >= FAIRY_COUNT:
		fairies_dead = -1
		if Dialogic.get_variable('shattered1') == 'true' and Dialogic.get_variable('shattered2') == 'true' and Dialogic.get_variable('shattered3') == 'true':
			if Dialogic.get_variable('yukari') == 'true':
				var dialogue = Dialogic.start('end_true')
				add_child(dialogue)
			else:
				var dialogue = Dialogic.start('end_good')
				add_child(dialogue)
		else:
			var dial = Dialogic.start('end_bad')
			add_child(dial)


func _on_Fairy_shoot(bullet, direction, location):
	var b = bullet.instance()
	add_child(b)
	b.rotation = direction
	b.position = location
	b.velocity = b.velocity.rotated(direction)


func _on_Player_shoot(bullet, direction, location):
	var b = bullet.instance()
	add_child(b)
	b.rotation = direction
	b.position = location
	b.velocity = b.velocity.rotated(direction)


func _on_Fairy_dead():
	fairies_dead += 1
