local var_0_0 = {}
local var_0_2 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:MistBigMapInfoUpdate(arg_2_1)
		for iter_2_0, iter_2_1 in pairs(arg_2_1.updates) do
			self:__set_mist_bigmap_info(iter_2_1.info)
			self:__mistbiginfo__action(iter_2_1.action, iter_2_1.info)

			self._mist_clear_bigmap_info[iter_2_0] = iter_2_1
		end

		self:_set_updata_bigmap_info(self._mist_clear_bigmap_info)
	end

	function arg_1_0:MistMapInfoUpdate(arg_3_1)
		if not arg_3_1 then
			return
		end

		for iter_3_0, iter_3_1 in pairs(arg_3_1.updates) do
			self:__set_mist_map_info(iter_3_1.info)
		end
	end

	function arg_1_0:MistInfoUpdate(arg_4_1)
		for iter_4_0, iter_4_1 in pairs(arg_4_1.mist_info) do
			self._mist_info_data[iter_4_0] = iter_4_1
		end
	end

	function arg_1_0:MistCombatInfoUpdate(arg_5_1)
		self:_set_mist_combat_info(arg_5_1.info)
	end

	function arg_1_0:MistAwardInfoUpdate(arg_6_1)
		for iter_6_0, iter_6_1 in pairs(arg_6_1.updates) do
			self:__mist_award_info__action(iter_6_1.action, iter_6_1.id)
		end
	end

	function arg_1_0:__mist_award_info__action(arg_7_1, arg_7_2)
		if arg_7_1 == var_0_2.update_modify then
			self:__mist_award_info__update(arg_7_2)
		elseif arg_7_1 == var_0_2.update_add then
			self:__mist_award_info__update(arg_7_2)
		elseif arg_7_1 == var_0_2.update_remove then
			self:__mist_award_info__update(arg_7_2)
		end
	end

	function arg_1_0:__mistbiginfo__action(arg_8_1, arg_8_2)
		if arg_8_1 == var_0_2.update_modify then
			self:__mistinfo__update_info(arg_8_2)
		elseif arg_8_1 == var_0_2.update_add then
			self:__mistinfo__add_info(arg_8_2)
		elseif arg_8_1 == var_0_2.update_remove then
			self:__mistinfo__remove_info(arg_8_2)
		end
	end
end

function var_0_0.extend_obj(arg_9_0)
	return
end

return var_0_0
