local var_0_0 = {}
local var_0_2 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:SixthBigMapInfoUpdate(arg_2_1)
		for iter_2_0, iter_2_1 in pairs(arg_2_1.updates) do
			self:__set_sixth_bigmap_info(iter_2_1.info)
			self:__sixbiginfo__action(iter_2_1.action, iter_2_1.info)
		end
	end

	function arg_1_0:SixthMapInfoUpdate(arg_3_1)
		for iter_3_0, iter_3_1 in pairs(arg_3_1.updates) do
			self:__set_sixth_map_info(iter_3_1.info)
		end
	end

	function arg_1_0:SixthInfoUpdate(arg_4_1)
		for iter_4_0, iter_4_1 in pairs(arg_4_1.sixth_info) do
			self._sixinfo_data[iter_4_0] = iter_4_1
		end
	end

	function arg_1_0:SixthCombatInfoUpdate(arg_5_1)
		self:__set_sixth_combat_info(arg_5_1.info)
	end

	function arg_1_0:SixthShopInfoUpdate(arg_6_1)
		for iter_6_0, iter_6_1 in pairs(arg_6_1.updates) do
			self:__sixinfo__action(iter_6_1.action, iter_6_1.info)
		end
	end

	function arg_1_0:__sixinfo__action(arg_7_1, arg_7_2)
		if arg_7_1 == var_0_2.update_modify then
			self:__sixinfo__update_info(arg_7_2)
		elseif arg_7_1 == var_0_2.update_add then
			self:__sixinfo__add_info(arg_7_2)
		elseif arg_7_1 == var_0_2.update_remove then
			self:__sixinfo__remove_info(arg_7_2)
		end
	end

	function arg_1_0:__sixbiginfo__action(arg_8_1, arg_8_2)
		if arg_8_1 == var_0_2.update_modify then
			self:__sixbiginfo__update_info(arg_8_2)
		elseif arg_8_1 == var_0_2.update_add then
			self:__sixbiginfo__add_info(arg_8_2)
		elseif arg_8_1 == var_0_2.update_remove then
			self:__sixbiginfo__remove_info(arg_8_2)
		end
	end
end

function var_0_0.extend_obj(arg_9_0)
	return
end

return var_0_0
