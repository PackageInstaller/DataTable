local var_0_0 = {}
local var_0_1 = table.insert
local var_0_2 = table.remove

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.reset_equipment_data(arg_2_0)
		arg_2_0._equipment_data = {}
		arg_2_0._equipment_get_locked = {}
	end

	function arg_1_0:get_lock_equipment_data()
		return self._lock_equipment_data
	end

	function arg_1_0:find_equipment_by_id(arg_4_1)
		return self:__equipment__find_by_id(arg_4_1)
	end

	function arg_1_0:find_lock_equipment_by_id(arg_5_1)
		return self:__lock_equipment__find_by_id(arg_5_1)
	end

	function arg_1_0:get_equipment_list()
		return self._equipment_data
	end

	function arg_1_0.set_show_panel_equip_state(arg_7_0, arg_7_1)
		arg_7_0._is_equip_show_state = arg_7_1
	end

	function arg_1_0:get_show_panel_equip_state()
		return self._is_equip_show_state
	end

	function arg_1_0:get_equipment_count()
		if not self._equipment_data then
			return 0
		end

		local var_9_0 = 0

		for iter_9_0, iter_9_1 in pairs(self._equipment_data) do
			var_9_0 = var_9_0 + iter_9_1.num
		end

		return var_9_0
	end

	function arg_1_0:__equipment__add_equipment_info(arg_10_1)
		self._equipment_data[arg_10_1.id] = arg_10_1
		self._equipment_get_locked[arg_10_1.id] = arg_10_1
	end

	function arg_1_0:__equipment__update_equipment_info(arg_11_1)
		self._equipment_data[arg_11_1.id] = arg_11_1
		self._equipment_get_locked[arg_11_1.id] = arg_11_1
	end

	function arg_1_0:__equipment__remove_equipment_info(arg_12_1)
		self._equipment_data[arg_12_1.id] = nil
		self._equipment_get_locked[arg_12_1.id] = nil
	end

	function arg_1_0:__equipment__find_by_id(arg_13_1)
		return self._equipment_data[arg_13_1]
	end

	function arg_1_0:__lock_equipment__find_by_id(arg_14_1)
		for iter_14_0, iter_14_1 in pairs(self._lock_equipment_data) do
			if iter_14_1 == arg_14_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__equipment__add_equipment_lock_id(arg_15_1)
		var_0_1(self._lock_equipment_data, #self._lock_equipment_data + 1, arg_15_1)
	end

	function arg_1_0:__equipment__remove_equipment_lock_id(arg_16_1)
		local var_16_0 = 0

		for iter_16_0, iter_16_1 in pairs(self._lock_equipment_data) do
			if iter_16_1 == arg_16_1 then
				var_16_0 = iter_16_0

				break
			end
		end

		if var_16_0 > 0 then
			var_0_2(self._lock_equipment_data, var_16_0)
		end
	end

	function arg_1_0:__equipment__update_equipment_lock_id(arg_17_1)
		local var_17_0 = 0

		for iter_17_0, iter_17_1 in pairs(self._lock_equipment_data) do
			if iter_17_1.id == arg_17_1.id then
				var_17_0 = iter_17_0
			end
		end

		if var_17_0 == 0 then
			var_0_1(self._lock_equipment_data, #self._lock_equipment_data + 1, arg_17_1)
		else
			self._lock_equipment_data[var_17_0] = arg_17_1
		end
	end

	function arg_1_0:get_equipment_lock_state(arg_18_1)
		return self._equipment_get_locked[arg_18_1] or false
	end
end

function var_0_0.extend_obj(arg_19_0)
	arg_19_0._equipment_data = {}
	arg_19_0._lock_equipment_data = {}
	arg_19_0._equipment_get_locked = {}
	arg_19_0._is_equip_show_state = nil
end

return var_0_0
