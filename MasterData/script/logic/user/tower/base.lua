local var_0_0 = {}
local var_0_4 = gameenum.common_type
local var_0_5 = gameconfig.tower_map_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.reset_tower_data(arg_2_0)
		arg_2_0._tower_data = {
			info = {}
		}
		arg_2_0._tower_chip_info = {}
		arg_2_0._tower_node_info = nil
	end

	function arg_1_0:get_tower_data_by_level(arg_3_1)
		return self._tower_data.info[arg_3_1]
	end

	function arg_1_0:get_tower_awards()
		return self._tower_data.info
	end

	function arg_1_0:get_tower_max_level()
		local var_5_0 = 1

		for iter_5_0, iter_5_1 in pairs(self._tower_data.info) do
			if var_5_0 < iter_5_1.level then
				var_5_0 = iter_5_1.level
			end
		end

		return var_5_0
	end

	function arg_1_0:get_tower_used_ship()
		for iter_6_0, iter_6_1 in pairs(self._tower_data.info) do
			if self:_level_is_handing(iter_6_1.enemys) then
				return iter_6_1.use_ship, iter_6_1.level
			end
		end

		return nil
	end

	function arg_1_0._level_is_handing(arg_7_0, arg_7_1)
		local var_7_0 = 0

		if arg_7_1 then
			for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
				if iter_7_1.pass then
					var_7_0 = var_7_0 + 1
				end
			end
		end

		return var_7_0 > 0 and var_7_0 < 5
	end

	function arg_1_0:get_tower_open_level()
		local var_8_0 = 1

		for iter_8_0 = 1, var_0_4.tower_award_page.page4 do
			if self:__check_tower_open_time(var_0_5.find_object_by_level(iter_8_0).start_time) then
				var_8_0 = iter_8_0
			else
				return var_8_0
			end
		end

		return var_8_0
	end

	function arg_1_0:clear_tower_used_ship(arg_9_1)
		self._tower_data.info[arg_9_1].use_ship = {}
	end

	function arg_1_0:get_tower_chip_info()
		return self._tower_chip_info
	end

	function arg_1_0.set_tower_node_info(arg_11_0, arg_11_1)
		if arg_11_1 then
			arg_11_0._tower_node_info = arg_11_1
		end
	end

	function arg_1_0:get_tower_node_info()
		return self._tower_node_info
	end

	function arg_1_0:__tower_info__update(arg_13_1)
		self._tower_data.info[arg_13_1.level] = arg_13_1
	end

	function arg_1_0:__tower_info__add(arg_14_1)
		self._tower_data.info[arg_14_1.level] = arg_14_1
	end

	function arg_1_0:__tower_info__remove(arg_15_1)
		self._tower_data.info[arg_15_1.level] = nil
	end

	function arg_1_0.__set_tower_chip_info(arg_16_0, arg_16_1)
		arg_16_0._tower_chip_info = arg_16_1
	end

	function arg_1_0.set_into_tower(arg_17_0, arg_17_1)
		arg_17_0._is_into_tower = arg_17_1
	end

	function arg_1_0:get_into_tower()
		return self._is_into_tower
	end

	function arg_1_0.__check_tower_open_time(arg_19_0, arg_19_1)
		if arg_19_1 > lx.ServerTime:getUtcTime() then
			return false
		else
			return true
		end
	end
end

function var_0_0.extend_obj(arg_20_0)
	arg_20_0._tower_data = {
		info = {}
	}
	arg_20_0._tower_chip_info = {}
	arg_20_0._tower_node_info = nil
	arg_20_0._is_into_tower = false
end

return var_0_0
