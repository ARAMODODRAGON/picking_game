/// @description Move The Item and Bounce

if (!is_held) {
	//calculate next velocity along y
	if (vsp < max_grv) {
		vsp += grv;
	} else if (vsp > max_grv) {
		vsp = max_grv;
	}
	
	if (last_bounce >= 2) {
		if (place_meeting(x + hsp, y, oWall)) {
			while (!place_meeting(x + sign(hsp), y, oWall)) {
				x += sign(hsp);
			}
			hsp = -hsp * 0.4;
			image_xscale = -image_xscale;
		} else {
			x += hsp;
		}
	
		if (place_meeting(x, y + vsp, oWall)) {
			while (!place_meeting(x, y + sign(vsp), oWall)) {
				y += sign(vsp);
			}
			vsp = -vsp * 0.8;
			last_bounce = abs(vsp);
			image_xscale = -image_xscale;
		} else {
			y += vsp;
		}
	} else {
		image_alpha -= 0.05;
	}
}