local var_0_0 = {}
local var_0_2 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:TowerInfoUpdate(arg_2_1)
		for iter_2_0, iter_2_1 in pairs(arg_2_1.updates) do
			self:__tower_info__action(iter_2_1.info, iter_2_1.action)
		end
	end

	function arg_1_0:ChipInfoUpdate(arg_3_1)
		self:__set_tower_chip_info(arg_3_1.info)
	end

	function arg_1_0:__tower_info__action(arg_4_1, arg_4_2)
		if arg_4_2 == var_0_2.update_modify then
			self:__tower_info__update(arg_4_1)
		elseif arg_4_2 == var_0_2.update_add then
			self:__tower_info__add(arg_4_1)
		elseif arg_4_2 == var_0_2.update_remove then
			self:__tower_info__remove(arg_4_1)
		end
	end
end

function var_0_0.extend_obj(arg_5_0)
	return
end

return var_0_0
