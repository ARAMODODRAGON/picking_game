/// @description lerp the platform between 2 positions

movePlayer = place_meeting(x, y-1, oPlayer) && !place_meeting(x, y+1, oPlayer);

#region move
if (timer > 0) {
	timer--;
} else if (state == plafMov.left) {
	if (disp == 0) {
		state = plafMov.right;
		timer = rest;
	}
	x = lerp(inix, endx, disp);
	if (movePlayer) {
		var dir = -abs(inix - endx) * step;
		if (place_meeting(oPlayer.x + dir, oPlayer.y, oWall)) {
			while (!place_meeting(oPlayer.x + sign(dir), oPlayer.y, oWall)) {
				oPlayer.x += sign(dir);
			}
			dir = 0;
		}
		oPlayer.x += dir;
	}
	disp -= step;
	if (disp < 0) disp = 0;
} else if (state == plafMov.right) {
	if (disp == 1) {
		state = plafMov.left;
		timer = rest;
	}
	x = lerp(inix, endx, disp);
	if (movePlayer) {
		var dir = abs(inix - endx) * step;
		if (place_meeting(oPlayer.x + dir, oPlayer.y, oWall)) {
			while (!place_meeting(oPlayer.x + sign(dir), oPlayer.y, oWall)) {
				oPlayer.x += sign(dir);
			}
			hsp = 0;
		}
		oPlayer.x += dir;
	}
	disp += step;
	if (disp > 1) disp = 1;
}
#endregion
