extends KinematicBody2D

var max_speed = 150
var fire_speed = 500
var acceleration = 800
var move = Vector2.ZERO
var carrot = preload("res://Carrot.tscn")
var pear = preload("res://Pear.tscn")
onready var hud = get_node("/root/HUD").get_node("CanvasLayer")
onready var arrow = get_node("arrow")
var numcarrot = 5
var numpear = 5

func _ready():
	yield(get_tree(), "idle_frame")
	get_tree().call_group("animals", "set_player", self)
	hud.layer = 0
	#sets food counters
	hud.get_node("c0").visible = false
	hud.get_node("c1").visible = false
	hud.get_node("c2").visible = false
	hud.get_node("c3").visible = false
	hud.get_node("c4").visible = false
	hud.get_node("c6").visible = false
	hud.get_node("c7").visible = false
	hud.get_node("c8").visible = false
	hud.get_node("c9").visible = false
	hud.get_node("p0").visible = false
	hud.get_node("p1").visible = false
	hud.get_node("p2").visible = false
	hud.get_node("p3").visible = false
	hud.get_node("p4").visible = false
	hud.get_node("p6").visible = false
	hud.get_node("p7").visible = false
	hud.get_node("p8").visible = false
	hud.get_node("p9").visible = false
	hud.get_node("c5").visible = true
	hud.get_node("p5").visible = true

func _physics_process(delta):
	#aiming 
	arrow.look_at(get_global_mouse_position())
	#movement
	var axis = get_axis()
	if axis == Vector2.ZERO:
		apply_friction(acceleration * delta)  
	else: 
		apply_move(axis * acceleration * delta)
	move = move_and_slide(move)
	#fires carrot
	if Input.is_action_just_pressed("fire_carrot") and numcarrot > 0 :
		var carrot_instance = carrot.instance()
		carrot_instance.position = position
		carrot_instance.rotation_degrees = arrow.rotation_degrees
		carrot_instance.apply_impulse(Vector2(),Vector2(fire_speed,0).rotated(arrow.rotation))
		get_tree().get_root().add_child(carrot_instance)
		numcarrot -= 1
		minus_carrot()
	#fires pear
	if Input.is_action_just_pressed("fire_pear") and numpear > 0 :
		var pear_instance = pear.instance()
		pear_instance.position = position
		pear_instance.rotation_degrees = arrow.rotation_degrees
		pear_instance.apply_impulse(Vector2(),Vector2(fire_speed,0).rotated(arrow.rotation))
		get_tree().get_root().add_child(pear_instance)
		numpear -= 1
		minus_pear()

#movement input 
func get_axis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	axis.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return axis.normalized()

#movement
func apply_friction(amount):
	if move.length() > amount:
		move -= move.normalized() * amount
	else:
		move = Vector2.ZERO

#movement
func apply_move(amount):
	move += amount
	move = move.clamped(max_speed)

#pick up pear
func _on_pearpickup_area_entered(_area):
	if numpear < 9:
		numpear += 1
	add_pear()

#pickup carrot
func _on_carrotpickup_area_entered(_area):
	if numcarrot < 9:
		numcarrot += 1
	add_carrot()

#adjust carrot counter down 
func minus_carrot():
	if numcarrot == 0:
		hud.get_node("c1").visible = false
		hud.get_node("c0").visible = true
	elif numcarrot == 1:
		hud.get_node("c2").visible = false
		hud.get_node("c1").visible = true
	elif numcarrot == 2:
		hud.get_node("c3").visible = false
		hud.get_node("c2").visible = true
	elif numcarrot == 3:
		hud.get_node("c4").visible = false
		hud.get_node("c3").visible = true
	elif numcarrot == 4:
		hud.get_node("c5").visible = false
		hud.get_node("c4").visible = true
	elif numcarrot == 5:
		hud.get_node("c6").visible = false
		hud.get_node("c5").visible = true
	elif numcarrot == 6:
		hud.get_node("c7").visible = false
		hud.get_node("c6").visible = true
	elif numcarrot == 7:
		hud.get_node("c8").visible = false
		hud.get_node("c7").visible = true
	elif numcarrot == 8:
		hud.get_node("c9").visible = false
		hud.get_node("c8").visible = true

#adjust pear counter down
func minus_pear():
	if numpear == 0:
		hud.get_node("p1").visible = false
		hud.get_node("p0").visible = true
	elif numpear == 1:
		hud.get_node("p2").visible = false
		hud.get_node("p1").visible = true
	elif numpear == 2:
		hud.get_node("p3").visible = false
		hud.get_node("p2").visible = true
	elif numpear == 3:
		hud.get_node("p4").visible = false
		hud.get_node("p3").visible = true
	elif numpear == 4:
		hud.get_node("p5").visible = false
		hud.get_node("p4").visible = true
	elif numpear == 5:
		hud.get_node("p6").visible = false
		hud.get_node("p5").visible = true
	elif numpear == 6:
		hud.get_node("p7").visible = false
		hud.get_node("p6").visible = true
	elif numpear == 7:
		hud.get_node("p8").visible = false
		hud.get_node("p7").visible = true
	elif numpear == 8:
		hud.get_node("p9").visible = false
		hud.get_node("p8").visible = true

#adjust carrot counter up 
func add_carrot():
	if numcarrot == 1:
		hud.get_node("c0").visible = false
		hud.get_node("c1").visible = true
	elif numcarrot == 2:
		hud.get_node("c1").visible = false
		hud.get_node("c2").visible = true
	elif numcarrot == 3:
		hud.get_node("c2").visible = false
		hud.get_node("c3").visible = true
	elif numcarrot == 4:
		hud.get_node("c3").visible = false
		hud.get_node("c4").visible = true
	elif numcarrot == 5:
		hud.get_node("c4").visible = false
		hud.get_node("c5").visible = true
	elif numcarrot == 6:
		hud.get_node("c5").visible = false
		hud.get_node("c6").visible = true
	elif numcarrot == 7:
		hud.get_node("c6").visible = false
		hud.get_node("c7").visible = true
	elif numcarrot == 8:
		hud.get_node("c7").visible = false
		hud.get_node("c8").visible = true
	elif numcarrot == 9:
		hud.get_node("c8").visible = false
		hud.get_node("c9").visible = true

#adjust pear counter up 
func add_pear():
	if numpear == 1:
		hud.get_node("p0").visible = false
		hud.get_node("p1").visible = true
	elif numpear == 2:
		hud.get_node("p1").visible = false
		hud.get_node("p2").visible = true
	elif numpear == 3:
		hud.get_node("p2").visible = false
		hud.get_node("p3").visible = true
	elif numpear == 4:
		hud.get_node("p3").visible = false
		hud.get_node("p4").visible = true
	elif numpear == 5:
		hud.get_node("p4").visible = false
		hud.get_node("p5").visible = true
	elif numpear == 6:
		hud.get_node("p5").visible = false
		hud.get_node("p6").visible = true
	elif numpear == 7:
		hud.get_node("p6").visible = false
		hud.get_node("p7").visible = true
	elif numpear == 8:
		hud.get_node("p7").visible = false
		hud.get_node("p8").visible = true
	elif numpear == 9:
		hud.get_node("p8").visible = false
		hud.get_node("p9").visible = true
