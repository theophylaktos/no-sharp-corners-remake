extends RotateableObject

class_name DamageableObject

@export var health: int:
	set(new_value):
		health = new_value
		if self.has_method("update_healthbar"):
			self.call("update_healthbar")
@export var damage: int
