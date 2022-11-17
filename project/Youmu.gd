extends KinematicBody2D

signal shoot(bullet, direction, location)
signal dead()

# Declare member variables here. Examples:
# var a = 2
onready var type = "Boss"
var velocity = Vector2()
var direction = Vector2()
var hp = 10
var speed = 90
var shot_speed = 150
var fairy_shot = preload("res://FairyShot.tscn")
var cutscene_mode = false

func cutscene_on():
	cutscene_mode = true

func cutscene_off():
	cutscene_mode = false

func get_hit():
	$AudioHurt.play()
	hp -= 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if !cutscene_mode:
		$HPcount.text = String(hp)
	else:
		$HPcount.text = ''
	
	if velocity.x != 0:
		$AnimatedSprite.flip_h = velocity.x < 0
	move_and_slide(velocity)
	if hp <= 0:
		queue_free()


func _on_Timer_timeout():
	emit_signal('shoot', fairy_shot, deg2rad(rand_range(0, 359)), position)


func _on_PlayerIndicator_body_entered(body):
	if body.get('type') == "Player":
		$Timer.start(0.1)


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
