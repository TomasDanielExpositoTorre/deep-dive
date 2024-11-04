extends Node
#
## Define a save path
const SAVE_FILE_PATH = "res://metadata.json"
#
## Function to save game progress
#func save_game(player, game_time):
	#var save_data = {
		#"position": player.global_position,
		#"Lives": player.health,
		#"Time": game_time
	#}
#
	## Open file in write mode
	#var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	#if file:
		## Write the JSON data
		#file.store_string(JSON.stringify(save_data))
		#file.close()
		#print("Game saved successfully!")
	#else:
		#print("Failed to open save file.")
#
## Function to load game progress
#func load_game(player):
	## Open file in read mode
	#var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	#if file:
		## Read and parse JSON data
		#var save_data = JSON.parse_string(file.get_as_text()).result
		#file.close()
#
		## Restore player properties
		#player.global_position = save_data["position"]
		#player.health = save_data["health"]
		#
		## Return saved time to resume from that time
		#return save_data["time"]
	#else:
		#print("No save file found.")
		#return null






# Función para guardar datos en un archivo
func save_game(data: Dictionary) -> void:
	# Abrimos el archivo en modo escritura
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	if file:
		# Convertimos el diccionario de datos a JSON y lo escribimos en el archivo
		file.store_string(JSON.stringify(data))
		file.close()  # Cerramos el archivo
		print("Juego guardado correctamente")
	else:
		print("Error al guardar el juego")

# Función para cargar datos desde el archivo
func load_game() -> Dictionary:
	# Verificamos si el archivo existe antes de intentar abrirlo
	if FileAccess.file_exists(SAVE_FILE_PATH):
		# Abrimos el archivo en modo lectura
		var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
		if file:
			# Leemos el contenido y lo convertimos de JSON a un diccionario
			var data = JSON.parse_string(file.get_as_text())
			file.close()  # Cerramos el archivo
			print("Juego cargado correctamente")
			return data
		else:
			print("Error al cargar el juego")
	else:
		print("No se encontró un archivo de guardado")
	
	# Retorna un diccionario vacío si no se encuentra el archivo
	return {}
