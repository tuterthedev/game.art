dodge_left  = keyboard_check(vk_left)  && keyboard_check(ord("X"));
dodge_up    = keyboard_check(vk_up)    && keyboard_check(ord("X"));
dodge_down  = keyboard_check(vk_down)  && keyboard_check(ord("X"));
dodge_right = keyboard_check(vk_right) && keyboard_check(ord("X"));

if (cooldown > 0)
{
    cooldown -= 1;

    if (cooldown <= 0 && dodge_return)
    {
        target_x += return_x;
        target_y += return_y;
        dodge_return = false;
    }
}


switch(state){
	
	case pl_state.IDLE:
		if(dodge_down or dodge_left or dodge_right)
		{
			state = pl_state.DODGE
		}
	break;
	
	case pl_state.DODGE:
	
    if (dodge_left && cooldown <= 0)
    {
        target_x -= 30;
        return_x = 30;    
        return_y = 0;
        cooldown = 30;
        dodge_return = true;
    }
    if (dodge_down && cooldown <= 0)
    {
        target_y += 30;
        return_x = 0;
        return_y = -30;    
        cooldown = 30;
        dodge_return = true;
    }
    if (dodge_right && cooldown <= 0)
    {
        target_x += 30;
        return_x = -30;    
        return_y = 0;
        cooldown = 30;
        dodge_return = true;
    }

    state = pl_state.IDLE;
	break;
		


} 


obj_dummy.x = lerp(obj_dummy.x, target_x, 0.3);
obj_dummy.y = lerp(obj_dummy.y, target_y, 0.3);

if (abs(obj_dummy.x - target_x) < 0.5) obj_dummy.x = target_x;
if (abs(obj_dummy.y - target_y) < 0.5) obj_dummy.y = target_y;

if (hit_cooldown > 0) hit_cooldown--;

var _hit = instance_place(x, y, obj_death);
if (_hit != noone && hit_cooldown <= 0)
{
    hp -= _hit.atk;
    hit_cooldown = 30;
}
