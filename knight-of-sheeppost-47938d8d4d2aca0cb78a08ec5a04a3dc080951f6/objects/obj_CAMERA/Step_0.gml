if(instance_exists(obj_main)){
	xx = clamp(target.x - width/2,0,room_width - width);
	yy = clamp(target.y - height/2,0,room_height - height);
	
	camera_set_view_pos(camera,xx,yy)
}


global.camx = xx;
global.camy = yy;