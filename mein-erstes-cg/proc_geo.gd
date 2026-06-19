extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var radius = 1
	var segments = 6
	var height = 1.0
	var delta = TAU / segments #2*PI für 360
	########################################################
	var verts_top = PackedVector3Array() #enthält eckdaten
	var Indices_top = PackedInt32Array()
	var norms_top = PackedVector3Array()
	
	var verts_bottom = PackedVector3Array() #enthält eckdaten
	var Indices_bottom = PackedInt32Array()
	var norms_bottom = PackedVector3Array()
	
	var verts_side = PackedVector3Array() #enthält eckdaten
	var Indices_side = PackedInt32Array()
	var norms_side = PackedVector3Array()
	
	######################################################
	
	verts_top.append(Vector3(radius,height,0))
	norms_top.append(Vector3(0, 1, 0))
	for i in range(1, segments):
		var x = radius * cos(i*delta)
		var z = radius * sin(i*delta)
		print("Punkt" + str(i) + ": (" + str(x) + ", 0, " + str(z) + ")")
		
		#TODO: Füge punkte in den verts array ein
		verts_top.append(Vector3(x, height, z))
		norms_top.append(Vector3(0, 1, 0))
		
	verts_bottom.append(Vector3(radius,0,0))
	norms_bottom.append(Vector3(0, -1, 0))
	for i in range(1, segments):
		var x = radius * cos(i*delta)
		var z = radius * sin(i*delta)
		print("Punkt" + str(i) + ": (" + str(x) + ", 0, " + str(z) + ")")
		
		#TODO: Füge punkte in den verts array ein
		verts_bottom.append(Vector3(x, 0, z))
		norms_bottom.append(Vector3(0, -1, 0))
		
		
		
		
	verts_side.append(Vector3(radius,height,0))	
	verts_side.append(Vector3(radius,0,0)) #zwei punkte
	
	norms_side.append(Vector3(1, 0, 0))
	norms_side.append(Vector3(1, 0, 0))	
	for i in range(1, segments):
		var x = 1 * cos(i*delta)
		var z = 1 * sin(i*delta)
		
		#print("Punkt" + str(i) + ": (" + str(x) + ", 0, " + str(z) + ")")
		#TODO: Füge punkte in den verts array ein
		verts_side.append(Vector3(radius*x, height, radius*z))
		verts_side.append(Vector3(radius*x, 0, radius*z))
		
		norms_side.append(Vector3(x, 0, z))
		norms_side.append(Vector3(x, 0, z))
		
		
	#######################################################	
	verts_top.append(Vector3(0, height, 0)) # dieswer punkt kriegt immer den index segments
	norms_top.append(Vector3(0, 1, 0))
	
	verts_bottom.append(Vector3(0, 0, 0)) # dieswer punkt kriegt immer den index segments
	norms_bottom.append(Vector3(0, -1, 0))
	
####################################################################
		#TODO: Füge ein dreieck (drei indices) in indices-array ein 
		# mit den indices aktueller schleifendurchlauf (i) vorangegangener
		#schleifendurcjlauf (i-1), letzter eintrag im array (segments)
	for i in range(1, segments):
		Indices_top.append(segments)
		Indices_top.append(i-1)
		Indices_top.append(i)
		
		#füge das letzte dreieck ein KEINEN eintrag in den verts array 
		#nur drei einträge in den index array
	Indices_top.append(segments)
	Indices_top.append(segments-1)
	Indices_top.append(0)
	
	
	
	
	
	for i in range(1, segments):
		Indices_bottom.append(i)
		Indices_bottom.append(i-1)
		Indices_bottom.append(segments)
		#füge das letzte dreieck ein KEINEN eintrag in den verts array 
		#nur drei einträge in den index array
	Indices_bottom.append(0)
	Indices_bottom.append(segments-1)
	Indices_bottom.append(segments)
	
	
	
	
	for i in range(1, segments):
		Indices_side.append((i-1)*2)
		Indices_side.append((i-1)*2+1)
		Indices_side.append(i*2)
		
		Indices_side.append((i-1)*2+1)
		Indices_side.append(i*2+1)
		Indices_side.append(i*2)
		
		
		#füge das letzte dreieck ein KEINEN eintrag in den verts array 
		#nur drei einträge in den index array
	Indices_side.append((segments-1)*2)
	Indices_side.append((segments-1)*2+1)
	Indices_side.append(0)
		
	Indices_side.append((segments-1)*2+1)
	Indices_side.append(1)
	Indices_side.append(0)
	###########################################################################



	var meta_array_top = [] #meta Array
	meta_array_top.resize(Mesh.ARRAY_MAX) #automatische länge
	meta_array_top[Mesh.ARRAY_VERTEX] = verts_top #an stelle 0 automatisch
	meta_array_top[Mesh.ARRAY_NORMAL]= norms_top
	meta_array_top[Mesh.ARRAY_INDEX] = Indices_top
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, meta_array_top)  
	#meta array in surfaces eintragen
	
	var meta_array_bottom = [] #meta Array
	meta_array_bottom.resize(Mesh.ARRAY_MAX) #automatische länge
	meta_array_bottom[Mesh.ARRAY_VERTEX] = verts_bottom #an stelle 0 automatisch
	meta_array_bottom[Mesh.ARRAY_NORMAL]= norms_bottom
	meta_array_bottom[Mesh.ARRAY_INDEX] = Indices_bottom
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, meta_array_bottom)  
	
	
	
	var meta_array_side = [] #meta Array
	meta_array_side.resize(Mesh.ARRAY_MAX) #automatische länge
	meta_array_side[Mesh.ARRAY_VERTEX] = verts_side #an stelle 0 automatisch
	meta_array_side[Mesh.ARRAY_NORMAL]= norms_side
	meta_array_side[Mesh.ARRAY_INDEX] = Indices_side
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, meta_array_side) 
