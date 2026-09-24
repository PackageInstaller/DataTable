local var_0_0 = {}
local var_0_1 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:GuideUpdate(arg_2_1)
		for iter_2_0, iter_2_1 in pairs(arg_2_1.updates) do
			self:__guide_action(iter_2_1.action, iter_2_1.guide_id)
		end
	end

	function arg_1_0:__guide_action(arg_3_1, arg_3_2)
		if arg_3_1 == var_0_1.update_modify then
			self:__guide__update_info(arg_3_2)
		elseif arg_3_1 == var_0_1.update_add then
			self:__guide__add_info(arg_3_2)
		elseif arg_3_1 == var_0_1.update_remove then
			self:__guide__remove_info(arg_3_2)
		end
	end
end

function var_0_0.extend_obj(arg_4_0)
	return
end

return var_0_0
