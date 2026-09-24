local var_0_0 = {}
local var_0_1 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:ShipArchiveUpdate(arg_2_1)
		for iter_2_0, iter_2_1 in pairs(arg_2_1.updates) do
			self:__cardbook__action(iter_2_1.info, iter_2_1.action, 1)
		end
	end

	function arg_1_0:EquipmentArchiveUpdate(arg_3_1)
		for iter_3_0, iter_3_1 in pairs(arg_3_1.updates) do
			self:__cardbook__action(iter_3_1.info, iter_3_1.action, 2)
		end
	end

	function arg_1_0:MusicArchiveUpdate(arg_4_1)
		for iter_4_0, iter_4_1 in pairs(arg_4_1.updates) do
			self:__cardbook__action(iter_4_1.info, iter_4_1.action, 3)
		end
	end

	function arg_1_0:BuffArchiveUpdate(arg_5_1)
		for iter_5_0, iter_5_1 in pairs(arg_5_1.updates) do
			self:__cardbook__action(iter_5_1.info, iter_5_1.action, 4)
		end
	end

	function arg_1_0:__cardbook__action(arg_6_1, arg_6_2, arg_6_3)
		if arg_6_2 == var_0_1.update_modify then
			self:__cardbook__update_info(arg_6_1, arg_6_3)
		elseif arg_6_2 == var_0_1.update_add then
			self:__cardbook__add_info(arg_6_1, arg_6_3)
		elseif arg_6_2 == var_0_1.update_remove then
			self:__cardbook__remove_info(arg_6_1, arg_6_3)
		end
	end
end

function var_0_0.extend_obj(arg_7_0)
	return
end

return var_0_0
