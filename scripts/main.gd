extends Node2D

@onready var time_label = $CenterContainer/time_label

func _ready():
	var timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(update_time)
	timer.wait_time = 1.0
	timer.start()
	update_time()

func update_time():
	if not time_label:
		return
	var time_dict = Time.get_time_dict_from_system(true)
	var hours = time_dict.hour
	var minutes = time_dict.minute
	var seconds = time_dict.second
	time_label.text = "%02d:%02d:%02d" % [hours, minutes, seconds]
