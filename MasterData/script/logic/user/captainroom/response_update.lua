local var_0_0 = {}
local var_0_1 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:MansionStyleUpdate(arg_2_1)
		for iter_2_0, iter_2_1 in pairs(arg_2_1.updates) do
			self:__captainroom_style__action(iter_2_1.id, iter_2_1.action)
		end
	end

	function arg_1_0:ChatHeadUpdate(arg_3_1)
		for iter_3_0, iter_3_1 in pairs(arg_3_1.updates) do
			self:__captainroom_head__action(iter_3_1.id, iter_3_1.action)
		end
	end

	function arg_1_0:GrrisonUpdate(arg_4_1)
		self._captainroom_data.garrison_list = arg_4_1.members
	end

	function arg_1_0:__captainroom_style__action(arg_5_1, arg_5_2)
		if arg_5_2 == var_0_1.update_modify then
			self:__captainroom_style__update_id(arg_5_1)
		elseif arg_5_2 == var_0_1.update_add then
			self:__captainroom_style__add_id(arg_5_1)
		elseif arg_5_2 == var_0_1.update_remove then
			self:__captainroom_style__remove_id(arg_5_1)
		end
	end

	function arg_1_0:__captainroom_head__action(arg_6_1, arg_6_2)
		if arg_6_2 == var_0_1.update_modify then
			self:__captainroom_head__update_id(arg_6_1)
		elseif arg_6_2 == var_0_1.update_add then
			self:__captainroom_head__add_id(arg_6_1)
		elseif arg_6_2 == var_0_1.update_remove then
			self:__captainroom_head__remove_id(arg_6_1)
		end
	end
end

function var_0_0.extend_obj(arg_7_0)
	return
end

return var_0_0
