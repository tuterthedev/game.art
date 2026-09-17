var object = noone;

switch(type){
	case "A": object = obj_room_markerA; break;
		
	case "B": object = obj_room_markerB; break;
		
	case "C": object = obj_room_markerC; break;
		
	case "D": object = obj_room_markerD; break;
		
	case "E": object = obj_room_markerE; break;
		
	case "F": object = obj_room_markerF; break;
		
	case "G": object = obj_room_markerG; break;
		
}
if(object != noone){
	obj_main.x = object.x;
	obj_main.y = object.y;
}