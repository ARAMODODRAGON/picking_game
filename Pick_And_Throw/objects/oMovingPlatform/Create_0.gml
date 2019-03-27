/// @desc init vars

inix = x;
endx = inix + (endx * 16);

disp = 0;
step = 1 / frameTime;

timer = rest;

movePlayer = false;

enum plafMov {
	left,
	right
}

if (inix < endx) {
	state = plafMov.right;
	disp = 0;
} else {
	state = plafMov.left;
	disp = 1;
}