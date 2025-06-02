@tool
extends EditorPlugin

var _last_save_time := 0.0
const SAVE_INTERVAL := 5.0  # 每5秒保存一次，避免性能问题
var _files_to_save := []  # 存储需要保存的文件路径
var _is_saving := false  # 防止重复保存

func _enter_tree():
	print("Autosave plugin enabled.")
	add_autosave_handler()
func _exit_tree():
	print("Autosave plugin disabled.")
	remove_autosave_handler()
func add_autosave_handler():
	var editor_interface = get_editor_interface()
	if editor_interface:
		var event = editor_interface.get_base_control().connect("gui_input", _on_gui_input)
		if event != OK:print("Failed to connect gui_input event.")
func remove_autosave_handler():
	var editor_interface = get_editor_interface()
	if editor_interface:
		var base_control = editor_interface.get_base_control()
		if base_control.is_connected("gui_input", _on_gui_input):
			base_control.disconnect("gui_input", _on_gui_input)
func _on_gui_input(event):
	if event is InputEventMouseButton or event is InputEventKey:
		var current_time = Time.get_ticks_msec() / 1000.0
		if current_time - _last_save_time >= SAVE_INTERVAL and not _is_saving:
			_is_saving = true
			call_deferred("_save_project_files_deferred")
			_last_save_time = current_time
func _save_project_files_deferred():
	var editor_interface = get_editor_interface()
	if not editor_interface:
		print("Error: Editor interface not available.")
		_is_saving = false
		return
	#保存当前打开的场景
	var edited_scene = editor_interface.get_edited_scene_root()
	if edited_scene:
		var error = editor_interface.save_scene()
		if error == OK:print("Scene autosaved: ", edited_scene.scene_file_path)
		else:print("Failed to autosave scene: ", error)
	_files_to_save.clear()
	collect_project_files("res://")
   	# 保存所有文件
	for file_path in _files_to_save:
		if ResourceLoader.exists(file_path):
			var resource = ResourceLoader.load(file_path)
			if resource:
				var error = ResourceSaver.save(resource, file_path)
				if error == OK:print("File autosaved: ", file_path)
				else:print("Failed to autosave file: ", file_path, " Error: ", error)
	_is_saving = false
func collect_project_files(path: String):
	var dir = DirAccess.open(path)
	if not dir:
		print("Error: Unable to open directory: ", path)
		return
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		var full_path = path + file_name
		if dir.current_is_dir():
			if file_name != "." and file_name != ".." and file_name != "addons" and not file_name.begins_with("temp"):
				collect_project_files(full_path + "/")
		else:
			# 保存特定类型的文件
			if full_path.ends_with(".tscn") or full_path.ends_with(".tres") or full_path.ends_with(".gd"):
				_files_to_save.append(full_path)
		file_name = dir.get_next()
	dir.list_dir_end()
