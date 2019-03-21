/// @desc creates an oCamera if there isnt one

if (!instance_exists(oCamera)) {
	instance_create_layer(x, y, "Player", oCamera);
}