extends Path2D

@onready var path_follow = $PathFollow2D
@onready var enemy = $PathFollow2D/Enemy


# Called when the node enters the scene tree for the first time.
func _ready():
	path_follow.set_progress_ratio(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	path_follow.progress_ratio -= 0.24 * delta
	if path_follow.progress <= 0:
		queue_free()
