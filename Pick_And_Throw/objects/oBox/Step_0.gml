/// @desc Gravity

if (!place_meeting(x, y+1, oWall)) {
	vsp += grv;
} else { 
	vsp = 0;
}


if (place_meeting(x, y + vsp, oWall)) {
	while (!place_meeting(x, y + sign(vsp), oWall)) {
		y += sign(vsp);
	}
	vsp = 0;
}

y += vsp;
