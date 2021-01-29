extends Area2D

onready var anim = $AnimationPlayer

func _ready():
	get_node("Sprite2").visible = false

#sets appearance and collision area 
func _physics_process(_delta):
	if anim.current_animation == "idle":
		get_node("foodready/CollisionShape2D").disabled = true
	if anim.current_animation == "idle" and get_node("Sprite2").visible == true:
		anim.play("ready")
	if anim.current_animation == "ready":
		get_node("foodready/CollisionShape2D").disabled = false

#resets cycle
func _on_foodready_area_entered(_area):
	get_node("Sprite2").visible = false
	anim.play("idle")
