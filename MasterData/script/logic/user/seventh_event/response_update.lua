local var_0_0 = {}
local var_0_2 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.SeventhInfoUpdate(arg_2_0, arg_2_1)
		arg_2_0._seventh_guide_state = arg_2_1.guide
		arg_2_0._seventh_buff_point = arg_2_1.buff_point
		arg_2_0._seventh_buff_list = arg_2_1.active_buff
	end

	function arg_1_0:SeventhMapInfoUpdate(arg_3_1)
		for iter_3_0, iter_3_1 in pairs(arg_3_1.updates) do
			self:__seventh_map_info_action(iter_3_1.action, iter_3_1.info)
		end
	end

	function arg_1_0:__seventh_map_info_action(arg_4_1, arg_4_2)
		if arg_4_1 == var_0_2.update_modify then
			self:__seventh_map_info_update_info(arg_4_2)
		elseif arg_4_1 == var_0_2.update_add then
			self:__seventh_map_info_add_info(arg_4_2)
		elseif arg_4_1 == var_0_2.update_remove then
			self:__seventh_map_info_remove_info(arg_4_2)
		end
	end

	function arg_1_0.SeventhBuffInfoUpdate(arg_5_0, arg_5_1)
		return
	end
end

function var_0_0.extend_obj(arg_6_0)
	return
end

return var_0_0
