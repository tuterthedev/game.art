if(cooldown > 0)
{
	cooldown --;
}

if (cooldown == 90 && instance_exists(obj_death))
{
	instance_destroy(obj_death)
}


if(!instance_exists(obj_death) && cooldown <= 0)
{
	var _atk = irandom_range(1,3)
	if(_atk == 1)
	{
		var _inst = instance_create_layer(obj_center_mark.x, obj_center_mark.y - 30 , obj_enemy.layer, obj_death)
		cooldown = 180;
		_inst.image_yscale += 1
		_inst.image_xscale += 0
	}	
	if(_atk == 2)
	{
		var _inst = instance_create_layer(obj_center_mark.x + 40,obj_center_mark.y - 30 , obj_enemy.layer, obj_death)
		cooldown = 180;
		_inst.image_yscale += 4
		_inst.image_xscale += 1
	}	
	if(_atk == 3)
	{
		var _inst = instance_create_layer(obj_center_mark.x - 40, obj_center_mark.y - 30 , obj_enemy.layer, obj_death)
		cooldown = 180;
		_inst.image_yscale += 4
		_inst.image_xscale += 1
	}	
	
}

