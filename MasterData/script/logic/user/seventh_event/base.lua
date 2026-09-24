local var_0_0 = {}
local var_0_1 = table.insert
local var_0_3 = gamecore.UserDataManager
local var_0_4 = gameconfig.ship_rule_config
local var_0_5 = gameconfig.ship_pve_active_config
local var_0_6 = {
	hard = "hard",
	normal = "normal"
}

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.reset_seventh_data(arg_2_0)
		arg_2_0._seventh_map_info_list = {}
		arg_2_0._seventh_buff_list = {}
		arg_2_0._seventh_buff_point = 0
	end

	function arg_1_0.set_seventh_event_activity_id(arg_3_0, arg_3_1)
		arg_3_0._seventh_event_activity_id = arg_3_1
	end

	function arg_1_0:get_seventh_event_activity_id()
		return self._seventh_event_activity_id
	end

	function arg_1_0.set_is_cur_seventh_difficulty_mode(arg_5_0, arg_5_1)
		arg_5_0._cur_seventh_difficulty_mode = arg_5_1
	end

	function arg_1_0:get_is_cur_seventh_difficulty_mode()
		return self._cur_seventh_difficulty_mode == var_0_6.hard
	end

	function arg_1_0:get_seventh_map_info()
		return self._seventh_map_info_list
	end

	function arg_1_0.is_cur_seventh_map_activity(arg_8_0, arg_8_1)
		local var_8_0 = var_0_4.find_object_by_id(26).content.activeId
		local var_8_1 = {}

		for iter_8_0, iter_8_1 in pairs(var_0_5.find_object_by_id(var_8_0).levels) do
			var_0_1(var_8_1, iter_8_1)
		end

		for iter_8_2, iter_8_3 in pairs(var_0_5.find_object_by_id(var_8_0).hardLevels) do
			var_0_1(var_8_1, iter_8_3)
		end

		for iter_8_4, iter_8_5 in pairs(var_8_1) do
			if arg_8_1 == iter_8_5 then
				return true
			end
		end

		return false
	end

	function arg_1_0:is_cur_seventh_map_open(arg_9_1)
		return self._seventh_map_info_list[arg_9_1] and next(self._seventh_map_info_list[arg_9_1]) ~= nil or false
	end

	function arg_1_0:is_cur_seventh_map_pass(arg_10_1)
		return self._seventh_map_info_list[arg_10_1] and self._seventh_map_info_list[arg_10_1].state == 2
	end

	function arg_1_0:is_pass_seventh_map_node(arg_11_1, arg_11_2)
		local var_11_0 = false
		local var_11_1 = true

		if self._seventh_map_info_list[arg_11_1] and self._seventh_map_info_list[arg_11_1].pass_point then
			local var_11_2 = 0

			for iter_11_0, iter_11_1 in ipairs(self._seventh_map_info_list[arg_11_1].pass_point) do
				if arg_11_2 == iter_11_1.id then
					for iter_11_2, iter_11_3 in pairs(iter_11_1.info) do
						if iter_11_3.grade <= 4 and iter_11_3.grade ~= 0 then
							var_11_0 = true
							var_11_2 = var_11_2 + 1
						end
					end
				end
			end

			if var_11_2 > 1 then
				var_11_1 = false
			end
		end

		return var_11_0, (not var_11_0 or nil) and false
	end

	function arg_1_0:record_seventh_fight_info_pass(arg_12_1, arg_12_2)
		self._seventh_fight_info_pass_objs = self._seventh_fight_info_pass_objs or {}
		self._seventh_fight_info_pass_objs[arg_12_1] = arg_12_2
	end

	function arg_1_0.reset_seventh_fight_info_pass(arg_13_0)
		arg_13_0._seventh_fight_info_pass_objs = {}
	end

	function arg_1_0:is_seventh_fight_info_pass(arg_14_1)
		return self._seventh_fight_info_pass_objs[arg_14_1]
	end

	function arg_1_0:is_cur_seventh_map_node_pass(arg_15_1, arg_15_2)
		local var_15_0 = false

		if self._seventh_map_info_list[arg_15_1] and self._seventh_map_info_list[arg_15_1].pass_point then
			for iter_15_0, iter_15_1 in ipairs(self._seventh_map_info_list[arg_15_1].pass_point) do
				if arg_15_2 == iter_15_1.id then
					var_15_0 = true
				end
			end
		end

		return var_15_0
	end

	function arg_1_0.set_now_seven_map_id(arg_16_0, arg_16_1)
		arg_16_0.now_seven_map_id = arg_16_1
	end

	function arg_1_0:get_now_seven_map_id()
		return self.now_seven_map_id
	end

	function arg_1_0:set_first_pass_seven_map_id(arg_18_1)
		var_0_3:setDataByID("first_pass_seven_map_id", self:get_account_id(), arg_18_1)
	end

	function arg_1_0:get_first_pass_seven_map_id()
		return (tonumber(var_0_3:getDataByID("first_pass_seven_map_id", (self:get_account_id()))))
	end

	function arg_1_0:get_seventh_guide_state()
		return self._seventh_guide_state
	end

	function arg_1_0.set_now_seven_map_fight_type(arg_21_0, arg_21_1)
		arg_21_0._seventh_fight_type = arg_21_1
	end

	function arg_1_0:get_now_seven_map_fight_type()
		return self._seventh_fight_type
	end

	function arg_1_0:get_seventh_buff_list()
		return self._seventh_buff_list
	end

	function arg_1_0:check_if_seventh_buff_id_is_unlocked(arg_24_1)
		local var_24_0 = false

		for iter_24_0, iter_24_1 in pairs(self._seventh_buff_list) do
			if arg_24_1 == iter_24_1 then
				var_24_0 = true
			end
		end

		return var_24_0
	end

	function arg_1_0:get_cur_seventh_buff_max_level_id(arg_25_1)
		local var_25_0 = tonumber(arg_25_1 .. ((arg_25_1 == 1001 or arg_25_1 == 2001 or arg_25_1 == 3001) and "00" or "01"))

		for iter_25_0, iter_25_1 in pairs(self._seventh_buff_list) do
			var_25_0 = math.floor(iter_25_1 / 100) == arg_25_1 and var_25_0 < iter_25_1 and iter_25_1 or var_25_0
		end

		return var_25_0
	end

	function arg_1_0:get_seventh_buff_point()
		return self._seventh_buff_point
	end

	function arg_1_0.Set_SeventhUpgradeBuffReq_CallBackFunc(arg_27_0, arg_27_1)
		arg_27_0._SeventhUpgradeBuffReq_CallBackFunc = arg_27_1
	end

	function arg_1_0:Do_SeventhUpgradeBuffReq_CallBackFunc()
		if self._SeventhUpgradeBuffReq_CallBackFunc then
			self._SeventhUpgradeBuffReq_CallBackFunc()

			self._SeventhUpgradeBuffReq_CallBackFunc = nil
		end
	end

	function arg_1_0.set_into_seven_fight(arg_29_0, arg_29_1)
		arg_29_0.into_seven_fight = arg_29_1
	end

	function arg_1_0:get_into_seven_fight()
		return self.into_seven_fight
	end

	function arg_1_0:get_seven_map_node_pass_count(arg_31_1, arg_31_2)
		local var_31_0 = false
		local var_31_1 = 0

		if self._seventh_map_info_list[arg_31_1] and self._seventh_map_info_list[arg_31_1].pass_point then
			for iter_31_0, iter_31_1 in ipairs(self._seventh_map_info_list[arg_31_1].pass_point) do
				if arg_31_2 == iter_31_1.id then
					for iter_31_2, iter_31_3 in pairs(iter_31_1.info) do
						if iter_31_3.grade <= 4 then
							var_31_1 = var_31_1 + iter_31_3.count
						end
					end

					var_31_0 = true
				end
			end
		end

		if var_31_0 then
			return var_31_1
		else
			return 0
		end
	end

	function arg_1_0:__seventh_map_info_update_info(arg_32_1)
		self:__update_seventh_map_info(arg_32_1)
	end

	function arg_1_0:__seventh_map_info_add_info(arg_33_1)
		self:__update_seventh_map_info(arg_33_1)
	end

	function arg_1_0:__seventh_map_info_remove_info(arg_34_1)
		self:__update_seventh_map_info(arg_34_1, true)
	end

	function arg_1_0:__update_seventh_map_info(arg_35_1, arg_35_2)
		self._seventh_map_info_list[arg_35_1.id] = not arg_35_2 and arg_35_1 or nil
	end

	function arg_1_0.__initia_lize(arg_36_0)
		arg_36_0._seventh_event_activity_id = 0
		arg_36_0._seventh_map_info_list = {}
		arg_36_0._first_pass_seven_map_id = nil
		arg_36_0._seventh_buff_list = {}
		arg_36_0._seventh_buff_point = 0
		arg_36_0._SeventhUpgradeBuffReq_CallBackFunc = nil
		arg_36_0._cur_seventh_difficulty_mode = var_0_6.normal
		arg_36_0._seventh_fight_info_pass_objs = {}
		arg_36_0._seventh_guide_state = false
	end

	function arg_1_0.set_mix_battle_plan_level(arg_37_0, arg_37_1, arg_37_2)
		arg_37_0._mix_battle_plan_level = arg_37_1
		arg_37_0._mix_battle_plan_order = arg_37_2
	end

	function arg_1_0:get_mix_battle_plan_level()
		return self._mix_battle_plan_level
	end

	function arg_1_0:get_mix_battle_plan_order()
		return self._mix_battle_plan_order
	end
end

function var_0_0:extend_obj()
	self:__initia_lize()

	self._come_in_panel = 0
	self._mix_battle_plan_level = 0
	self._open_seven_panel = false
	self._open_seven_panel_data = {}
end

return var_0_0
