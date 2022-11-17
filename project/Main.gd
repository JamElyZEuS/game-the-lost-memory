extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var disclaimer = preload("res://Disclaimer.tscn")
onready var fs = preload("res://Fullscreen.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var fs_inst = fs.instance()
	get_tree().get_root().call_deferred('add_child', fs_inst)
	var dc_inst = disclaimer.instance()
	add_child(dc_inst)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
