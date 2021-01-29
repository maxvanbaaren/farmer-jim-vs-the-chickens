extends Node2D

onready var hud = get_node("/root/HUD").get_node("CanvasLayer")

func _ready():
	hud.layer = -1

func _physics_process(_delta): 
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://Main.tscn")
