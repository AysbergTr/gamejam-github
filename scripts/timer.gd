extends Control

var total_time_in_secs: int = 0

var time_limit_in_secs = 180

signal out_of_time

func _ready() -> void:
	$Timer.start()



func _on_timer_timeout() -> void:
	time_limit_in_secs -= 1
	if time_limit_in_secs <= 0:
		$Timer.stop()
		emit_signal("out_of_time")
		
	if time_limit_in_secs < 45:
		$Label.set("theme_override_colors/font_color", Color(1, 0, 0))
		
	var m = int(time_limit_in_secs/60.0)
	var s = time_limit_in_secs - m * 60
	
	$Label.text = "%02d:%02d" % [m,s]
