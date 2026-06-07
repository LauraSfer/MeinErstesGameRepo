extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Hallo")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_up"):
		print("hoch")
		$klappe.rotate_z(2 * (3.141592 / 90))
	if Input.is_action_pressed("ui_down"):
		print("runter")	
		$klappe.rotate_z(-2 * (3.141592 / 90))
