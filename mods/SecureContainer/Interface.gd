extends "res://Scripts/Interface.gd"

# Override Drop to handle SecureContainer items that aren't in Database.gd
func Drop(target) -> void:
	var scene: PackedScene = _get_sc_pickup_scene(target)
	if scene:
		_drop_sc_item(target, scene)
		return
	super.Drop(target)

# Override ContextPlace (right-click → Place in world)
func ContextPlace() -> void:
	if contextItem:
		var scene: PackedScene = _get_sc_pickup_scene(contextItem)
		if scene:
			var map: Node = get_tree().current_scene.get_node_or_null("/root/Map")
			if not map:
				PlayError()
				return
			var pickup: Node = scene.instantiate()
			map.add_child(pickup)
			pickup.slotData.Update(contextItem.slotData)
			placer.ContextPlace(pickup)
			if contextGrid:
				contextGrid.Pick(contextItem)
			contextItem.reparent(self)
			contextItem.queue_free()
			Reset()
			HideContext()
			PlayClick()
			UIManager.ToggleInterface()
			return
	super.ContextPlace()

func _get_sc_pickup_scene(target: Node) -> PackedScene:
	if not target.slotData or not target.slotData.itemData:
		return null
	var sc_mod: Node = Engine.get_meta("SecureContainer", null)
	if not sc_mod:
		return null
	return sc_mod._pickup_scenes.get(target.slotData.itemData.file, null)

func _drop_sc_item(target: Node, scene: PackedScene) -> void:
	var map: Node = get_tree().current_scene.get_node_or_null("/root/Map")
	if not map:
		PlayError()
		return

	var dir: Vector3
	var pos: Vector3
	var rot: Vector3
	var force: float = 2.5

	if trader and hoverGrid == null:
		dir = trader.global_transform.basis.z
		pos = (trader.global_position + Vector3(0, 1.0, 0)) + dir / 2
		rot = Vector3(-25, trader.rotation_degrees.y + 180 + randf_range(-45, 45), 45)
	elif hoverGrid != null and hoverGrid.get_parent().name == "Container":
		dir = container.global_transform.basis.z
		pos = (container.global_position + Vector3(0, 0.5, 0)) + dir / 2
		rot = Vector3(-25, container.rotation_degrees.y + 180 + randf_range(-45, 45), 45)
	else:
		dir = -camera.global_transform.basis.z
		pos = (camera.global_position + Vector3(0, -0.25, 0)) + dir / 2
		rot = Vector3(-25, camera.rotation_degrees.y + 180 + randf_range(-45, 45), 45)

	var pickup: Node = scene.instantiate()
	map.add_child(pickup)
	pickup.position = pos
	pickup.rotation_degrees = rot
	pickup.linear_velocity = dir * force
	pickup.Unfreeze()

	var slot: SlotData = SlotData.new()
	slot.itemData = target.slotData.itemData
	slot.amount = 1
	pickup.slotData = slot

	target.reparent(self)
	target.queue_free()
	PlayDrop()
	UpdateStats(true)
