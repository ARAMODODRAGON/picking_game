/// @description Initialize variables

camera_halfsizex = camera_get_view_width(view_camera[0]) / 2;
camera_halfsizey = camera_get_view_height(view_camera[0]) / 2;

if (oPlayer != noone) {
	x = oPlayer.x;
	y = oPlayer.y;
}