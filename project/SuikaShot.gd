extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var type = "Special"
var velocity = Vector2.RIGHT
var speed = 70

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("default")
	$AudioStreamPlayer2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = velocity.normalized() * speed * delta
	position += velocity


func _on_FairyShot_body_entered(body):
	if body.get('type') == "Fairy":
		body.queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Timer_timeout():
	queue_free()


func _on_SuikaShot_area_entered(area):
	if area.get('type') == "Bullet":
		area.queue_free()
