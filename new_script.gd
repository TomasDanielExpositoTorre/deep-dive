func save_game(data: Dictionary) -> void:
	var file = File.new()
	if file.open(SAVE_FILE_PATH, File.WRITE) == OK:
		# Convertimos los datos a JSON y los escribimos en el archivo
		file.store_string(to_json(data))
		file.close()
		print("Juego guardado correctamente")
	else:
		print("Error al guardar el juego") extends Node
		
		
		
func load_game() -> Dictionary:
	var file = File.new()
	if file.file_exists(SAVE_FILE_PATH):
		if file.open(SAVE_FILE_PATH, File.READ) == OK:
			# Leemos el contenido y lo convertimos de JSON a un diccionario
			var data = parse_json(file.get_as_text())
			file.close()
			print("Juego cargado correctamente")
			return data
		else:
			print("Error al cargar el juego")
	else:
		print("No se encontró un archivo de guardado")
	
	# Retorna un diccionario vacío si no se encuentra el archivo
    return {}
