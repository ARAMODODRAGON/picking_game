/// @description After the player has moved, start moving the camera

if (instance_exists(oPlayer)) {
	//first is moving this object to the player
	var x_dir = oPlayer.x - x;
	var y_dir = oPlayer.y - y + v_displacement;
	
	if (abs(x_dir) > h_follow) {
		x += max(0.2, (abs(x_dir) - h_follow) / 4) * sign(x_dir);
	}
	
	if (abs(y_dir) > v_follow) {
		y += max(0.2, (abs(y_dir) - v_follow) / 4) * sign(y_dir);
	}
	
	//make sure that the position is still in bounds of the room
	x = clamp(x, camera_halfsizex + 16, room_width - camera_halfsizex - 16);
	y = clamp(y, camera_halfsizey + 16, room_height - camera_halfsizey - 16);
	
	//then move the camera to this object
	camera_set_view_pos(view_camera[0], x - camera_halfsizex, y - camera_halfsizey);
}

