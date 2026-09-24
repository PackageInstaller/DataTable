local var_0_0 = {}
local var_0_1 = table.insert

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:get_total_dock_data()
		return self._dock_data
	end

	function arg_1_0:get_previous_dock_data()
		return self._previous_dock_data
	end

	function arg_1_0:get_dock_group(arg_4_1)
		return self._dock_data[arg_4_1]
	end

	function arg_1_0:get_single_dock_data(arg_5_1, arg_5_2)
		return self._team_data[arg_5_1][arg_5_2]
	end

	function arg_1_0:set_dock_data(arg_6_1)
		self._dock_data[arg_6_1.type] = self._dock_data[arg_6_1.type] or {}

		for iter_6_0, iter_6_1 in pairs(arg_6_1.data) do
			self._dock_data[arg_6_1.type][iter_6_1.pos_id] = {
				pos_id = iter_6_1.pos_id,
				id = iter_6_1.id,
				state = iter_6_1.state,
				time = iter_6_1.time,
				available = iter_6_1.available
			}
		end
	end

	function arg_1_0.set_previous_dock_data(arg_7_0, arg_7_1)
		arg_7_0._previous_dock_data = arg_7_1
	end

	function arg_1_0:get_collect_record_by_type(arg_8_1)
		if not self._collect_record_data[arg_8_1] then
			return
		end

		local var_8_0 = {}

		for iter_8_0, iter_8_1 in pairs(self._collect_record_data[arg_8_1]) do
			var_0_1(var_8_0, iter_8_1)
		end

		return var_8_0
	end

	function arg_1_0:get_records_by_type(arg_9_1)
		if not self._build_records[arg_9_1] then
			return
		end

		local var_9_0 = {}

		for iter_9_0, iter_9_1 in pairs(self._build_records[arg_9_1]) do
			var_0_1(var_9_0, iter_9_1)
		end

		return var_9_0
	end

	function arg_1_0:__dock__update_collect_record_info(arg_10_1, arg_10_2)
		self._collect_record_data[arg_10_1] = self._collect_record_data[arg_10_1] or {}
		self._collect_record_data[arg_10_1][arg_10_2.id] = arg_10_2
	end

	function arg_1_0:__dock__add_collect_record_info(arg_11_1, arg_11_2)
		self._collect_record_data[arg_11_1] = self._collect_record_data[arg_11_1] or {}
		self._collect_record_data[arg_11_1][arg_11_2.id] = arg_11_2
	end

	function arg_1_0:__dock__remove_collect_record_info(arg_12_1, arg_12_2)
		self._collect_record_data[arg_12_1] = self._collect_record_data[arg_12_1] or {}
		self._collect_record_data[arg_12_1][arg_12_2.id] = nil
	end
end

function var_0_0.extend_obj(arg_13_0)
	arg_13_0._dock_data = {}
	arg_13_0._collect_record_data = {}
	arg_13_0._previous_dock_data = {}
	arg_13_0._build_records = {}
end

return var_0_0
