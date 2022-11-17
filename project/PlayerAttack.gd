extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionShape2D.set_deferred('disabled', false)
	$AnimatedSprite.play("default")
	$AudioStreamPlayer.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimatedSprite_animation_finished():
	queue_free()


func _on_PlayerAttack_body_entered(body):
	if body.get('type') == "Fairy":
		body.queue_free()
	elif body.get('type') == "Boss":
		body.get_hit()
		$CollisionShape2D.set_deferred('disabled', true)
