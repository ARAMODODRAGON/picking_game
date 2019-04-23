/// @desc take damage

if (invi_frames == 0 && other.image_yscale != -1){
	invi_frames = 90;

	health--;

	var dir = sign(x - other.x); // points away from enemy

	hsp = dir * max_spd * 2;
	vsp = jspd * 1.2;
} else if (invi_frames < 10) {
	invi_frames = 10;
}