extends RigidBody2D

func _on_Area2D_area_entered(_area):
	queue_free()
