local var_0_0 = {}
local var_0_1 = table.insert
local var_0_5 = gameconfig.workshop_config
local var_0_6 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:get_workshop_info_by_id(arg_2_1)
		return self._workshop_data.info[arg_2_1]
	end

	function arg_1_0:get_workshop_data()
		return self._workshop_data.info
	end

	function arg_1_0:get_all_workshop_id()
		local var_4_0 = {}

		for iter_4_0, iter_4_1 in pairs(self._workshop_data.info) do
			var_0_1(var_4_0, iter_4_1.id)
		end

		return var_4_0
	end

	function arg_1_0:get_wrokshop_skill_by_ship_type(arg_5_1, arg_5_2)
		if not self._workshop_skill_type then
			return {}
		end

		local var_5_0 = self._workshop_skill_type[arg_5_1]

		if not self._workshop_skill_type[arg_5_1] then
			return {}
		end

		if not var_5_0[arg_5_2] then
			return {}
		end

		local var_5_1 = self:get_skill_max_level(self._workshop_skill_type[arg_5_1][arg_5_2])

		return (var_5_1 ~= 0 or nil) and var_0_5.find_object_by_id(var_5_1)
	end

	function arg_1_0:get_skill_max_level(arg_6_1)
		local var_6_0 = 0
		local var_6_1 = 0

		if self._workshop_skill_data[arg_6_1] then
			for iter_6_0, iter_6_1 in pairs(self._workshop_skill_data[arg_6_1]) do
				if iter_6_1 == var_0_6.workshop_const.workshop_state.complete and var_6_0 < iter_6_0 then
					var_6_0 = iter_6_0
				end
			end

			var_6_1 = tonumber(string.sub(var_6_0, -1))
		end

		return var_6_0, var_6_1
	end

	function arg_1_0:get_score_by_ship_type(arg_7_1)
		local var_7_0 = 0

		for iter_7_0, iter_7_1 in pairs(self._workshop_data.info) do
			local var_7_1 = var_0_5.find_object_by_id(iter_7_1.id)

			var_7_0 = var_7_1.ship_type == arg_7_1 and var_7_1.score + var_7_0 or var_7_0
		end

		return var_7_0
	end

	function arg_1_0:get_workshop_cfg()
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in pairs(self._workshop_data.info) do
			local var_8_1 = var_0_5.find_object_by_id(iter_8_1.id)

			for iter_8_2, iter_8_3 in pairs(var_8_1.effect) do
				if iter_8_3.type == 11 or iter_8_3.type == 12 then
					var_8_0[var_8_1.base_id] = var_8_1
				end
			end
		end

		return var_8_0
	end

	function arg_1_0:reset_workshop_data()
		self._workshop_data.info = {}
		self._workshop_data.score = {}
		self._workshop_skill_data = {}
	end

	function arg_1_0:init_skill_config_type()
		if self._workshop_skill_type and next(self._workshop_skill_type) then
			return
		end

		for iter_10_0, iter_10_1 in pairs((var_0_5.get_sequence())) do
			for iter_10_2, iter_10_3 in pairs(iter_10_1.effect) do
				self._workshop_skill_type[iter_10_3.type] = self._workshop_skill_type[iter_10_3.type] or {}
				self._workshop_skill_type[iter_10_3.type][iter_10_1.ship_type] = self._workshop_skill_type[iter_10_3.type][iter_10_1.ship_type] or iter_10_1.base_id
			end
		end
	end

	function arg_1_0:__workshop_info__update(arg_11_1)
		self._workshop_data.info[arg_11_1.id] = arg_11_1
	end

	function arg_1_0:__workshop_info__add(arg_12_1)
		self._workshop_data.info[arg_12_1.id] = arg_12_1
	end

	function arg_1_0:__workshop_info__remove(arg_13_1)
		self._workshop_data.info[arg_13_1.id] = nil
	end
end

function var_0_0.extend_obj(arg_14_0)
	arg_14_0._workshop_data = {
		info = {},
		score = {}
	}
	arg_14_0._workshop_skill_data = {}
	arg_14_0._workshop_skill_type = {}
end

return var_0_0
