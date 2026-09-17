
///@param text id
function scr_game_text(_text_id){
	
	switch(_text_id){
		case "npc 1":
		scr_text("hello guys ima mr beast cat", "dev")
		scr_text("can i. other? thing! to do", "dev", -1)
		
		
			break;
			
		case "npc 2":
		scr_text("tribal hello pal ima 2")
		scr_text("pale test ")
		scr_text("good job if you see that")
		scr_text("1 2 3 4 5 6 7 8 9 AAAAA")
		
			src_option("yeah","npc 2 - yes")
			
			src_option("nah","npc 2 - no")
		
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