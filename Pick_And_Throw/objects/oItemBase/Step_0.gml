/// @description Move The Item

if (!is_held) {
	//move horizontally
	x += hsp;

	//calculate next velocity along y
	if (vsp < max_grv) {
		vsp += grv;
	} else if (vsp > max_grv) {
		vsp = max_grv;
	}

	//move vertically
	y += vsp;
}