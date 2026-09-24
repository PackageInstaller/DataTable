local var_0_0 = {}
local var_0_1 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:RepairStyleUpdate(arg_2_1)
		for iter_2_0, iter_2_1 in pairs(arg_2_1.updates) do
			self:__bathroom_style__action(iter_2_1.id, iter_2_1.action)
		end
	end

	function arg_1_0:__bathroom_style__action(arg_3_1, arg_3_2)
		if arg_3_2 == var_0_1.update_modify then
			self:__bathroom_style__update_id(arg_3_1)
		elseif arg_3_2 == var_0_1.update_add then
			self:__bathroom_style__add_id(arg_3_1)
		elseif arg_3_2 == var_0_1.update_remove then
			self:__bathroom_style__remove_id(arg_3_1)
		end
	end
end

function var_0_0.extend_obj(arg_4_0)
	return
end

return var_0_0
