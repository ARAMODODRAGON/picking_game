
//player is standing on top
if (other.x >= bbox_left && other.x <= bbox_right) {
	if (other.bbox_bottom > bbox_top) {
		other.y = bbox_top - 16;
	}
} else if (other.bbox_left < bbox_left) {
	x = other.bbox_left - sprite_get_width(mask_index) * image_xscale;
} else if (other.bbox_right > bbox_right) {
	x = other.bbox_right;
}

