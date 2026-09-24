local var_0_0 = {}
local var_0_2 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:RankTaskUpdate(arg_2_1)
		for iter_2_0, iter_2_1 in pairs(arg_2_1.updates) do
			self:__rank__action(iter_2_1.action, iter_2_1.info)
		end
	end

	function arg_1_0:SupportInfoUpdate(arg_3_1)
		for iter_3_0, iter_3_1 in pairs(arg_3_1.updates) do
			if iter_3_1.action == var_0_2.update_modify then
				self:__support__update_support_info(iter_3_1.info)
			elseif iter_3_1.action == var_0_2.update_add then
				self:__support__add_support_info(iter_3_1.info)
			elseif iter_3_1.action == var_0_2.update_remove then
				self:__support__remove_support_info(iter_3_1.info)
			end
		end
	end

	function arg_1_0:__rank__action(arg_4_1, arg_4_2)
		if arg_4_1 == var_0_2.update_modify then
			self:__rank__update_rank_info(arg_4_2)
		elseif arg_4_1 == var_0_2.update_add then
			self:__rank__add_rank_info(arg_4_2)
		elseif arg_4_1 == var_0_2.update_remove then
			self:__rank__remove_rank_info(arg_4_2)
		end
	end

	function arg_1_0:RankSupportInfoUpdate(arg_5_1)
		self:update_support_notify(arg_5_1)

		for iter_5_0, iter_5_1 in pairs(arg_5_1) do
			self._now_rank_point_num[iter_5_0] = iter_5_1
		end

		if arg_5_1.rank_point then
			self:_set_rank_point(arg_5_1.rank_point)
		end
	end
end

function var_0_0.extend_obj(arg_6_0)
	return
end

return var_0_0
