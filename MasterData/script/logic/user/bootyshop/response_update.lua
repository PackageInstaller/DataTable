local var_0_0 = {}
local var_0_2 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:SpoilsShopInfoUpdate(arg_2_1)
		for iter_2_0, iter_2_1 in pairs(arg_2_1.updates) do
			self:__spoils__action(iter_2_1.action, iter_2_1.info)
		end
	end

	function arg_1_0:__spoils__action(arg_3_1, arg_3_2)
		if arg_3_1 == var_0_2.update_modify then
			self:__spoils__update_spoils_info(arg_3_2)
		elseif arg_3_1 == var_0_2.update_add then
			self:__spoils__add_spoils_info(arg_3_2)
		elseif arg_3_1 == var_0_2.update_remove then
			self:__spoils__remove_spoils_info(arg_3_2)
		end
	end
end

function var_0_0.extend_obj(arg_4_0)
	return
end

return var_0_0
