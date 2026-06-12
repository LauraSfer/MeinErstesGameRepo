extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var radius = 1
	var segments = 6
	var delta = TAU / segments #2*PI für 360
	
	var verts = PackedVector3Array() #enthält eckdaten
	verts.append(Vector3(radius,0,0))
	for i in range(1, segments):
		var x = radius * cos(i*delta)
		var z = radius * sin(i*delta)
		print("Punkt" + str(i) + ": (" + str(x) + ", 0, " + str(z) + ")")
		
		#TODO: Füge punkte in den verts array ein
		verts.append(Vector3(x, 0, z))
		
	verts.append(Vector3(0, 0, 0)) # dieswer punkt kriegt immer den index segments
	
	var Indices = PackedInt32Array()
	
	
		
		#TODO: Füge ein dreieck (drei indices) in indices-array ein 
		# mit den indices aktueller schleifendurchlauf (i) vorangegangener
		#schleifendurcjlauf (i-1), letzter eintrag im array (segments)
	for i in range(1, segments):
		Indices.append(segments)
		Indices.append(i-1)
		Indices.append(i)	
		
		
		
		
		#füge das letzte dreieck ein KEINEN eintrag in den verts array 
		#nur drei einträge in den index array
	Indices.append(segments)
	Indices.append(segments-1)
	Indices.append(0)
	
	
	
	
	
	var meta_array = [] #meta Array
	meta_array.resize(Mesh.ARRAY_MAX) #automatische länge
	meta_array[Mesh.ARRAY_VERTEX] = verts #an stelle 0 automatisch
	meta_array[Mesh.ARRAY_INDEX] = Indices
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, meta_array)  
	#meta array in surfaces eintragen
	
