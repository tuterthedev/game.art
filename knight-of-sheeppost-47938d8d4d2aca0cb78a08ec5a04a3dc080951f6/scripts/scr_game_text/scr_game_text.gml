
///@param text id
function scr_game_text(_text_id){
	
	switch(_text_id){
		case "npc 1":
		scr_text("hello guys ima mr beast cat", "dev")
		scr_text("can i. other? thing! to do", "dev", -1)
		scr_text("wanna see smth cool?", "dev")
			scr_option("hell yeah", "npc 1 - yes")
			scr_option("hell no", "npc 1 - no")
			break;
			
		case "npc 1 - yes":
		scr_text("now i can speak LGBT", "dev")
			scr_text_color(16, 20, c_yellow,c_yellow,c_white,c_white); scr_text_float(16,20); scr_text_shake(6,9);
		break;
		case "npc 1 - no":
		scr_text(". . . bruh doochbag", "dev")
		break
			
			
			
			
		case "npc 2":
		scr_text("tribal hello pal ima 2")
		scr_text("pale test ")
		scr_text("good job if you see that")
		scr_text("1 2 3 4 5 6 7 8 9 AAAAA")
		
			scr_option("yeah","npc 2 - yes")
			
			scr_option("nah","npc 2 - no")
		
			break;
			
			case "npc 2 - yes":
				scr_text("good that work")
				break;
			case "npc 2 - no":
				scr_text("good no")
				break;
			
			
		case "npc 3":
		scr_text("hello guys ima mr beast cat", "dev")
		
			break;
	
	
	
	
}

}