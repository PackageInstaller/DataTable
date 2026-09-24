local var_0_0 = {}
local var_0_1 = table.insert
local var_0_2 = rawget

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.reset_supportlist_data(arg_2_0)
		arg_2_0._support_notify_id = nil
		arg_2_0._support_notify_count = 0
		arg_2_0._support_rank_point = nil
		arg_2_0._support_active = nil
		arg_2_0._support_info = {}
	end

	function arg_1_0:find_rank_by_id(arg_3_1)
		return self:__rank__find_by_id(arg_3_1)
	end

	function arg_1_0:get_rank_list()
		return self._rank_data
	end

	function arg_1_0._set_rank_point(arg_5_0, arg_5_1)
		arg_5_0._rank_point_num = arg_5_1
	end

	function arg_1_0:get_rank_point()
		return self._rank_point_num
	end

	function arg_1_0._set_now_rank_point(arg_7_0, arg_7_1)
		arg_7_0._now_rank_point_num = arg_7_1
	end

	function arg_1_0:get_now_rank_point()
		return self._now_rank_point_num
	end

	function arg_1_0:get_supportInfo_data(arg_9_1)
		return self._support_info[arg_9_1]
	end

	function arg_1_0:find_rank_state_info(arg_10_1)
		self.__rank_state_info(arg_10_1)
	end

	function arg_1_0:get_support_rank_read(arg_11_1)
		for iter_11_0, iter_11_1 in pairs(self._support_rank_list) do
			if iter_11_1.info.id == arg_11_1 then
				return iter_11_1.info.read
			end
		end
	end

	function arg_1_0:find_rank_progresses_list(arg_12_1)
		return self.__rank_progresses_list[arg_12_1.id]
	end

	function arg_1_0:find_rank_node_id(arg_13_1)
		return self.__rank_node_id(arg_13_1)
	end

	function arg_1_0:get_support_notify()
		return self._support_notify_id, self._support_notify_count, self._support_rank_point, self._support_active
	end

	function arg_1_0:__rank__add_rank_info(arg_15_1)
		self._rank_data[arg_15_1.id] = arg_15_1
	end

	function arg_1_0:__rank__update_rank_info(arg_16_1)
		self._rank_data[arg_16_1.id] = arg_16_1
	end

	function arg_1_0:__rank__remove_rank_info(arg_17_1)
		self._rank_data[arg_17_1.id] = nil
	end

	function arg_1_0:__rank__find_by_id(arg_18_1)
		return self._rank_data[arg_18_1]
	end

	function arg_1_0:update_support_notify(arg_19_1)
		local var_19_0 = var_0_2(arg_19_1, "using_support")

		if var_19_0 then
			self._support_notify_id = var_19_0
		end

		if var_0_2(arg_19_1, "support_count") then
			self._support_notify_count = var_0_2(arg_19_1, "support_count")
		end

		local var_19_1 = var_0_2(arg_19_1, "rank_point")

		if var_19_1 then
			self._support_rank_point = var_19_1
		end

		local var_19_2 = var_0_2(arg_19_1, "is_active")

		if var_19_2 == true or var_19_2 == false then
			self._support_active = var_19_2
		end

		if var_0_2(arg_19_1, "updates") then
			for iter_19_0, iter_19_1 in pairs(arg_19_1.updates) do
				local var_19_3 = false

				for iter_19_2, iter_19_3 in pairs(self._support_rank_list) do
					if iter_19_3.info.id == iter_19_1.info.id then
						iter_19_3.info.read = iter_19_1.info.read
						var_19_3 = true
					end
				end

				if not var_19_3 then
					var_0_1(self._support_rank_list, iter_19_1)
				end
			end
		end
	end

	function arg_1_0:__support__update_support_info(arg_20_1)
		self._support_info[arg_20_1.map_id] = arg_20_1
	end

	function arg_1_0:__support__add_support_info(arg_21_1)
		self._support_info[arg_21_1.map_id] = arg_21_1
	end

	function arg_1_0:__support__remove_support_info(arg_22_1)
		self._support_info[arg_22_1.map_id] = nil
	end

	function arg_1_0.set_support_info(arg_23_0, arg_23_1)
		arg_23_0._support_active_1 = arg_23_1
	end

	function arg_1_0:get_support_info()
		return self._support_active_1
	end
end

function var_0_0.extend_obj(arg_25_0)
	arg_25_0._rank_data = {}
	arg_25_0._support_notify_id = nil
	arg_25_0._support_notify_count = 0
	arg_25_0._support_rank_point = nil
	arg_25_0._support_active = nil
	arg_25_0._support_active_1 = nil
	arg_25_0._support_info = {}
	arg_25_0._rank_point_num = nil
	arg_25_0._support_rank_list = {}
	arg_25_0._now_rank_point_num = {}
end

return var_0_0
