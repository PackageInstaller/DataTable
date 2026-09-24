local var_0_0 = {}
local var_0_1 = {
	hard = "hard",
	normal = "normal"
}

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.set_now_eighth_map_id(arg_2_0, arg_2_1)
		arg_2_0.now_eighth_map_id = arg_2_1
	end

	function arg_1_0:get_now_eighth_map_id()
		return self.now_eighth_map_id
	end

	function arg_1_0:get_eighth_guide_state()
		return self._eighth_guide_state
	end

	function arg_1_0.set_now_eighth_map_fight_type(arg_5_0, arg_5_1)
		arg_5_0._eighth_fight_type = arg_5_1
	end

	function arg_1_0:get_now_eighth_map_fight_type()
		return self._eighth_fight_type
	end

	function arg_1_0:is_cur_eighth_map_open(arg_7_1)
		return self._eighth_map_info_list[arg_7_1] and next(self._eighth_map_info_list[arg_7_1]) ~= nil or false
	end

	function arg_1_0:is_cur_eighth_pass(arg_8_1)
		return self._eighth_map_info_list[arg_8_1] and self._eighth_map_info_list[arg_8_1].state == 2
	end

	function arg_1_0:__eighth_map_info_update_info(arg_9_1)
		self:__update_eighth_map_info(arg_9_1)
	end

	function arg_1_0:__eighth_map_info_add_info(arg_10_1)
		self:__update_eighth_map_info(arg_10_1)
	end

	function arg_1_0:__eighth_map_info_remove_info(arg_11_1)
		self:__update_eighth_map_info(arg_11_1, true)
	end

	function arg_1_0:__update_eighth_map_info(arg_12_1, arg_12_2)
		self._eighth_map_info_list[arg_12_1.id] = not arg_12_2 and arg_12_1 or nil
	end

	function arg_1_0.set_eighth_event_activity_id(arg_13_0, arg_13_1)
		arg_13_0._eighth_event_activity_id = arg_13_1
	end

	function arg_1_0:get_eighth_event_activity_id()
		return self._eighth_event_activity_id
	end

	function arg_1_0.set_common_eighth_map_id(arg_15_0, arg_15_1)
		arg_15_0._common_eighth_map_id = arg_15_1
	end

	function arg_1_0:get_common_eighth_map_id()
		return self._common_eighth_map_id
	end

	function arg_1_0:get_eighth_map_info()
		return self._eighth_map_info_list
	end

	function arg_1_0:get_eighth_buff_list()
		return self._eighth_buff_list
	end

	function arg_1_0:check_if_eighth_buff_id_is_unlocked(arg_19_1)
		local var_19_0 = false

		for iter_19_0, iter_19_1 in pairs(self._eighth_buff_list) do
			if arg_19_1 == iter_19_1 then
				var_19_0 = true
			end
		end

		return var_19_0
	end

	function arg_1_0:get_eighth_task_finished_table()
		return self._eighth_task_finished
	end

	function arg_1_0:get_eighth_task_finished_table_by_main()
		local var_21_0 = {}

		for iter_21_0, iter_21_1 in pairs(self._eighth_task_finished) do
			var_21_0[iter_21_1] = true
		end

		return var_21_0
	end

	function arg_1_0:is_pass_eighth_map_node(arg_22_1, arg_22_2)
		local var_22_0 = false
		local var_22_1 = true

		if self._eighth_map_info_list[arg_22_1] and self._eighth_map_info_list[arg_22_1].pass_point then
			local var_22_2 = 0

			for iter_22_0, iter_22_1 in ipairs(self._eighth_map_info_list[arg_22_1].pass_point) do
				if arg_22_2 == iter_22_1.id then
					for iter_22_2, iter_22_3 in pairs(iter_22_1.info) do
						if iter_22_3.grade <= 4 and iter_22_3.grade ~= 0 then
							var_22_0 = true
							var_22_2 = var_22_2 + 1
						end
					end
				end
			end

			if var_22_2 > 1 then
				var_22_1 = false
			end
		end

		return var_22_0, (not var_22_0 or nil) and false
	end

	function arg_1_0:is_cur_eighth_map_node_pass(arg_23_1, arg_23_2)
		local var_23_0 = false

		if self._eighth_map_info_list[arg_23_1] and self._eighth_map_info_list[arg_23_1].pass_point then
			for iter_23_0, iter_23_1 in ipairs(self._eighth_map_info_list[arg_23_1].pass_point) do
				if arg_23_2 == iter_23_1.id then
					var_23_0 = true
				end
			end
		end

		return var_23_0
	end

	function arg_1_0:get_eighth_map_node_pass_count(arg_24_1, arg_24_2)
		local var_24_0 = false
		local var_24_1 = 0

		if self._eighth_map_info_list[arg_24_1] and self._eighth_map_info_list[arg_24_1].pass_point then
			for iter_24_0, iter_24_1 in ipairs(self._eighth_map_info_list[arg_24_1].pass_point) do
				if arg_24_2 == iter_24_1.id then
					for iter_24_2, iter_24_3 in pairs(iter_24_1.info) do
						if iter_24_3.grade <= 4 then
							var_24_1 = var_24_1 + iter_24_3.count
						end
					end

					var_24_0 = true
				end
			end
		end

		if var_24_0 then
			return var_24_1
		else
			return 0
		end
	end

	function arg_1_0:get_eighth_buff_point()
		return self._eighth_buff_point
	end

	function arg_1_0.Set_EighthUpgradeBuffReq_CallBackFunc(arg_26_0, arg_26_1)
		arg_26_0._EighthUpgradeBuffReq_CallBackFunc = arg_26_1
	end

	function arg_1_0.set_eighth_battle_plan_level(arg_27_0, arg_27_1, arg_27_2)
		arg_27_0._eighth_battle_plan_level = arg_27_1
		arg_27_0._eighth_battle_plan_order = arg_27_2
	end

	function arg_1_0:get_eighth_battle_plan_level()
		return self._eighth_battle_plan_level
	end

	function arg_1_0:get_eighth_battle_plan_order()
		return self._eighth_battle_plan_order
	end

	function arg_1_0:record_eighth_fight_info_pass(arg_30_1, arg_30_2)
		self._eighth_fight_info_pass_objs = self._eighth_fight_info_pass_objs or {}
		self._eighth_fight_info_pass_objs[arg_30_1] = arg_30_2
	end

	function arg_1_0.reset_eighth_fight_info_pass(arg_31_0)
		arg_31_0._eighth_fight_info_pass_objs = {}
	end

	function arg_1_0:is_eighth_fight_info_pass(arg_32_1)
		return self._eighth_fight_info_pass_objs[arg_32_1]
	end

	function arg_1_0.set_is_cur_eighth_difficulty_mode(arg_33_0, arg_33_1)
		arg_33_0._cur_eighth_difficulty_mode = arg_33_1
	end

	function arg_1_0:get_is_cur_eighth_difficulty_mode()
		return self._cur_eighth_difficulty_mode == var_0_1.hard
	end

	function arg_1_0:get_cur_eighth_buff_max_level_id(arg_35_1)
		local var_35_0 = tonumber(arg_35_1 .. ((arg_35_1 == 1001 or arg_35_1 == 2001 or arg_35_1 == 3001) and "00" or "01"))

		for iter_35_0, iter_35_1 in pairs(self._eighth_buff_list) do
			var_35_0 = math.floor(iter_35_1 / 100) == arg_35_1 and var_35_0 < iter_35_1 and iter_35_1 or var_35_0
		end

		return var_35_0
	end

	function arg_1_0.__initia_lize(arg_36_0)
		arg_36_0._eighth_fight_info_pass_objs = {}
		arg_36_0._cur_eighth_difficulty_mode = var_0_1.normal
		arg_36_0._eighth_guide_state = false
	end

	function arg_1_0:Do_EighthUpgradeBuffReq_CallBackFunc()
		if self._EighthUpgradeBuffReq_CallBackFunc then
			self._EighthUpgradeBuffReq_CallBackFunc()

			self._EighthUpgradeBuffReq_CallBackFunc = nil
		end
	end

	function arg_1_0:get_eight_monster_hurt_id()
		return self._eight_monster_hurt_id
	end

	function arg_1_0.set_eight_monster_hurt_id(arg_39_0, arg_39_1)
		arg_39_0._eight_monster_hurt_id = arg_39_1
	end

	function arg_1_0.set_eighth_elite_move(arg_40_0, arg_40_1)
		arg_40_0._eighth_elite_move = arg_40_1
	end

	function arg_1_0:get_eighth_elite_move()
		return self._eighth_elite_move
	end

	function arg_1_0.set_monster_is_move(arg_42_0, arg_42_1)
		arg_42_0._can_move = arg_42_1
	end

	function arg_1_0:get_monster_is_move()
		return self._can_move
	end

	function arg_1_0.set_eighth_team(arg_44_0, arg_44_1)
		arg_44_0._eighth_team_id = arg_44_1
	end

	function arg_1_0:get_eighth_team()
		return self._eighth_team_id
	end
end

function var_0_0:extend_obj()
	self:__initia_lize()

	self._data_init = nil
	self._eighth_map_info_list = {}
	self._eighth_buff_point = 0
	self._eighth_event_activity_id = nil
	self._EighthUpgradeBuffReq_CallBackFunc = nil
	self._eight_monster_hurt_id = nil
	self._eighth_elite_move = nil
	self._can_move = false
	self._eighth_battle_plan_level = nil
	self._eighth_battle_plan_order = nil
	self._common_eighth_map_id = nil
	self._eighth_team_id = nil
end

return var_0_0
