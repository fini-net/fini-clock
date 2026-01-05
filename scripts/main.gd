extends Node2D

@onready var time_label = $time_label

func _ready():
	update_time()

func _process(_delta):
	update_time()

func update_time():
	var time_dict = Time.get_time_dict_from_system(true)  # true for UTC
	var hours = time_dict.hour
	var minutes = time_dict.minute
	time_label.text = "%02d:%02d" % [hours, minutes]
