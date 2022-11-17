extends Node2D


# Declare member variables here. Examples:
const FAIRY_COUNT = 4
var fairies_dead = 0
onready var pause = preload("res://PauseMenu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_tree().get_root().get_node_or_null('Level1') != null:
		get_tree().get_root().get_node('Level1').queue_free()
	$AudioStreamPlayer.play()
	var dial = Dialogic.start('Level2_start')
	add_child(dial)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_pause"):
		var pause_inst = pause.instance()
		add_child(pause_inst)
		get_tree().paused = true
	
	if fairies_dead >= FAIRY_COUNT:
		fairies_dead = -1
		var dialogue = Dialogic.start('Level2_end')
		add_child(dialogue)


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
