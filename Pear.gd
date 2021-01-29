extends RigidBody2D

#destroyed on collision 
func _on_Area2D_area_entered(_area):
	queue_free()
