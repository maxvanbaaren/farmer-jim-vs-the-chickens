extends KinematicBody2D

var initialized = false ##
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
	if initialized == true:##
		var vec_to_player = player.global_position - global_position
		vec_to_player = vec_to_player.normalized()
		move_and_collide(vec_to_player * speed * delta)
	#position.x += dir_x * speed * delta
	#position.y += dir_y * speed * delta
	if anim2.current_animation == "Emotion" and tran.visible == true:
		monster()
		
########################################
#onready var Timer: Node = $Timer

#ar dir_x: int
#var dir_y: int
#var right_side: int = 150
#var left_side: int = 50
#var top: int = 50
#var bottom : int = 150

#func _process(delta):
	#if dir_x > 0 and global_position.x >= right_side:
	#	dir_x = 0 
	#if dir_x < 0 and global_position.x <= left_side:
	#	dir_x = 0
	#if dir_y > 0 and global_position.y >= bottom:
	#	dir_y = 0
	#if dir_y < 0 and global_position.y <= top:
	#	dir_y = 0
	#position.x += dir_x * speed * delta
	#position.y += dir_y * speed * delta
	

#func _on_Timer_timeout():
#	randomize()
#	dir_x = randi() % 5 - 2
#	dir_y = randi() % 5 - 2
#	print(str(dir_x) + "    " + str(dir_y))
#	restart_timer()

#func restart_timer():
#	var new_time = randi() % 3 + 1 # random time between 1 and 3
#	Timer.wait_time = new_time
#	Timer.start()
#############################################

func choose_fruit():
	var pos = int(position.x) % 16
	if pos > 7:
		anim1.play("Carrot")
	else:
		anim1.play("Pear")
	anim2.stop()
	anim2.play("Emotion")
	
func monster():
	ismonster = true
	anim1.play("Monster")
	anim2.play("Monster")
	speed = 140
	
func _on_CarrotArea_area_entered(_area):
	if anim1.current_animation == "Carrot":
		choose_fruit()

func _on_PearArea_area_entered(_area):
	if anim1.current_animation == "Pear":
		choose_fruit()

func _on_Area2D_area_entered(_area):
	if ismonster == true:
		get_tree().change_scene("res://Death.tscn")

