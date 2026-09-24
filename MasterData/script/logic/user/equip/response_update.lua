local var_0_0 = {}
local var_0_1 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:EquipInfoUpdate(arg_2_1)
		for iter_2_0, iter_2_1 in pairs(arg_2_1.updates) do
			self:__equipment__action(iter_2_1.action, iter_2_1.info)
		end
	end

	function arg_1_0:EquipLockInfoUpdate(arg_3_1)
		for iter_3_0, iter_3_1 in pairs(arg_3_1.updates) do
			self:__equipment__lock__action(iter_3_1.action, iter_3_1.id)
		end
	end

	function arg_1_0:__equipment__action(arg_4_1, arg_4_2)
		if arg_4_1 == var_0_1.update_modify then
			self:__equipment__update_equipment_info(arg_4_2)
		elseif arg_4_1 == var_0_1.update_add then
			self:__equipment__add_equipment_info(arg_4_2)
		elseif arg_4_1 == var_0_1.update_remove then
			self:__equipment__remove_equipment_info(arg_4_2)
		end
	end

	function arg_1_0:__equipment__lock__action(arg_5_1, arg_5_2)
		if arg_5_1 == var_0_1.update_modify then
			self:__equipment__update_equipment_lock_id(arg_5_2)
		elseif arg_5_1 == var_0_1.update_add then
			self:__equipment__add_equipment_lock_id(arg_5_2)
		elseif arg_5_1 == var_0_1.update_remove then
			self:__equipment__remove_equipment_lock_id(arg_5_2)
		end
	end
end

function var_0_0.extend_obj(arg_6_0)
	return
end

return var_0_0
