extends KinematicBody2D

signal shoot(bullet, direction, location)
signal dead()

# Declare member variables here. Examples:
# var a = 2
onready var type = "Fairy"
var velocity = Vector2()
var direction = Vector2()
var speed = 80
var shot_speed = 150
var fairy_shot = preload("res://FairyShot.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move_and_slide(velocity)


func _on_Timer_timeout():
	emit_signal('shoot', fairy_shot, deg2rad(rand_range(0, 359)), position)


func _on_PlayerIndicator_body_entered(body):
	if body.get('type') == "Player":
		$Timer.start(0.3)


func _on_PlayerIndicator_body_exited(body):
	if body.get('type') == "Player":
		$Timer.stop()


func _on_DangerIndicator_body_entered(body):
	if body.get('type') == "Player":
		velocity = -to_local(body.position).normalized() * speed


func _on_DangerIndicator_body_exited(body):
	if body.get('type') == "Player":
		velocity = Vector2.ZERO


func _on_Fairy1_tree_exiting():
	emit_signal('dead')
