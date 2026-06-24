extends CharacterBody3D

var velocidad:int = 200
var direccion:Vector3

var sensibilidad:float = 0.001
@onready var camara:Camera3D = $Camera3D
#-----------------------------------------------------------------------------------------------------------------------------------
func _physics_process(delta):
	caminar(delta)
	move_and_slide()
	
func _input(event):
	mover_camara(event)
	
func _process(delta):
	ocultar_raton()
#-----------------------------------------------------------------------------------------------------------------------------------
func caminar(delta):
	var input_dir = Vector3(Input.get_axis("izquierda","derecha"), 0, Input.get_axis("adelante","atras"))
	var direccion = (transform.basis * input_dir).normalized()
	
	if direccion:
		velocity.x = direccion.x * velocidad 
		velocity.z = direccion.z * velocidad 
	else:
		velocity.x = move_toward(velocity.x, 0, velocidad)
		velocity.z = move_toward(velocity.z, 0, velocidad)
	
#---------------------------------------------------------------------------------------------------------------------------------------
func mover_camara(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * sensibilidad)
		
		camara.rotate_x(-event.relative.y * sensibilidad)
		camara.rotation.x = clamp(camara.rotation.x,deg_to_rad(-90),deg_to_rad(90))
		#-------------------------------------------------------------------------------------------------------------------------
func ocultar_raton():
	if Input.is_action_just_pressed("ocultar_raton"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
