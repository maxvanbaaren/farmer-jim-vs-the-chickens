extends KinematicBody2D

var initialized = false 
var speed = 10
var player = null
var ismonster = false
onready var anim1 = $AnimationPlayer
onready var anim2 = $AnimationPlayer2
onready var tran = $Transform

func _ready():
	player = get_parent().get_node("Player")

func _physics_process(delta):
	if player == null:
		return
	#moves towards player
	if initialized == true:
		var vec_to_player = player.global_position - global_position
		vec_to_player = vec_to_player.normalized()
		move_and_collide(vec_to_player * speed * delta)
	#turns into monster if emotion animation reaches end
	if anim2.current_animation == "Emotion" and tran.visible == true:
		monster()

#picks next desired food and resets emotion animation 
func choose_fruit():
	var pos = int(position.x) % 16
	if pos > 7:
		anim1.play("Carrot")
	else:
		anim1.play("Pear")
	anim2.stop()
	anim2.play("Emotion")

#turns into monster
func monster():
	ismonster = true
	anim1.play("Monster")
	anim2.play("Monster")
	speed = 140

#hit by carrot
func _on_CarrotArea_area_entered(_area):
	if anim1.current_animation == "Carrot":
		choose_fruit()

#hit by pear
func _on_PearArea_area_entered(_area):
	if anim1.current_animation == "Pear":
		choose_fruit()

#kills player if monster 
func _on_Area2D_area_entered(_area):
	if ismonster == true:
		get_tree().change_scene("res://Death.tscn")

