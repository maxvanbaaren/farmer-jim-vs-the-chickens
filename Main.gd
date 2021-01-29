extends Node2D

onready var a1 = get_node("Animal")
onready var a2 = get_node("Animal2")
onready var a3 = get_node("Animal3")
onready var a4 = get_node("Animal4")
onready var a5 = get_node("Animal5") 
var a_num = 1

#initializes first chicken
func _ready():
	a1.initialized = true
	a1.visible = true
	a1.choose_fruit()
	a2.visible = false
	a3.visible = false
	a4.visible = false
	a5.visible = false
	timer_start()

func timer_start():
	var timer = get_node("Timer")
	timer.set_wait_time(20)
	timer.start()	

#initializes next chicken 
func _on_Timer_timeout():
	a_num += 1
	if a_num == 2:
		a2.initialized = true
		a2.visible = true
		a2.choose_fruit()
	elif a_num == 3:
		a3.initialized = true
		a3.visible = true
		a3.choose_fruit()
	elif a_num == 4:
		a4.initialized = true
		a4.visible = true
		a4.choose_fruit()
	elif a_num == 5:
		a5.initialized = true
		a5.visible = true
		a5.choose_fruit()
	timer_start()
	
