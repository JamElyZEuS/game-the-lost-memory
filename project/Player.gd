extends KinematicBody2D

signal shoot(bullet, direction, location)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var _animation = $AnimatedSprite
onready var type = "Player"
var hp = 5
var suikas = 1
var speed = 120
var velocity = Vector2()
var direction = Vector2(1, 0)
var melee = preload("res://PlayerAttack.tscn")
var suika = preload("res://SuikaShot.tscn")
var invincible = false
var cutscene_mode = false
var boss_battle = false
var tired = false

var canuse_melee = true

func invincible_on():
	invincible = true

func invincible_off():
	invincible = false

func cutscene_on():
	invincible = true
	cutscene_mode = true

func cutscene_off():
	invincible = false
	cutscene_mode = false

func tire():
	tired = true
	invincible = true
	$AnimatedSprite.flip_v = true
	$AnimatedSprite.scale.y = 0.7
	$AnimationPlayer.play("invincible")
	$HPRegen.start(0.5)

func untire():
	$AnimatedSprite.flip_v = false
	$AnimatedSprite.scale.y = 1
	$AnimationPlayer.stop()
	$HPRegen.start(5)
	invincible = false
	tired = false

func get_hit():
	if !invincible:
		$AudioHurt.play()
		hp -= 1
		invincible = true
		$AnimationPlayer.play("invincible")
		$InvTimer.start()
	if hp <= 0:
		tire()


# Called when the node enters the scene tree for the first time.
func _ready():
	_animation.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if !cutscene_mode and !tired:
		$HPcount.text = String(hp)
		$Suikacount.text = String(suikas)
		if Input.is_action_pressed("ui_left"):
			velocity.x = -speed
		elif Input.is_action_pressed("ui_right"):
			velocity.x = speed
		else:
			velocity.x = 0
		
		if Input.is_action_pressed("ui_up"):
			velocity.y = -speed
		elif Input.is_action_pressed("ui_down"):
			velocity.y = speed
		else:
			velocity.y = 0
		
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
			direction = velocity.normalized()
			_animation.play("walk")
		else:
			_animation.play("default")
		
		if velocity.x != 0:
			_animation.flip_h = velocity.x < 0
		
		move_and_slide(velocity)
		
		if Input.is_action_just_pressed("player_attack"):
			if canuse_melee:
				canuse_melee = false
				$MeleeCooldown.start()
				var melee_instance = melee.instance()
				add_child(melee_instance)
				melee_instance.position = direction * 20
				melee_instance.look_at(to_global(direction))
		
		if !boss_battle:
			if Input.is_action_just_pressed("ui_cancel"):
				if suikas > 0:
					suikas -= 1
					emit_signal('shoot', suika, get_angle_to(to_global(direction)), position)
		else:
			$Suikacount.text = ''
	elif cutscene_mode:
		$HPcount.text = ''
		$Suikacount.text = ''
	else:
		$HPcount.text = String(hp)
		if !boss_battle:
			$Suikacount.text = String(suikas)
		else:
			$Suikacount.text = ''


func _on_InvTimer_timeout():
	invincible = false
	$AnimationPlayer.stop()
	$AnimatedSprite.modulate.a = 1


func _on_HPRegen_timeout():
	if hp < 5:
		hp += 1
	
	if hp >= 5 and tired:
		untire()


func _on_SuikaRegen_timeout():
	if suikas < 3:
		suikas += 1


func _on_InteractArea_body_entered(body):
	if body.get('type') == "Shattered1":
		body.queue_free()
		var dialogue = Dialogic.start('Shattered1')
		add_child(dialogue)
	elif body.get('type') == "Shattered2":
		body.queue_free()
		var dialogue = Dialogic.start('Shattered2')
		add_child(dialogue)
	elif body.get('type') == "Shattered3":
		body.queue_free()
		var dialogue = Dialogic.start('Shattered3')
		add_child(dialogue)


func _on_MeleeCooldown_timeout():
	canuse_melee = true
