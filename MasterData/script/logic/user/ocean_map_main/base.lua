local var_0_0 = {}
local var_0_2 = gameenum.common_type
local var_0_3 = gamecore.UILoader
local var_0_4 = gameconfig.ocean_map_node_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:get_ocean_map_buff_data()
		return self._ocean_map_buff_data
	end

	function arg_1_0:get_ocean_map_buff_list()
		return self._ocean_map_buff_list
	end

	function arg_1_0:set_ocean_all_buff_for_fight_list(arg_4_1, arg_4_2)
		self._all_buff_for_fight_list = {
			buff = {},
			debuff = {}
		}

		if arg_4_1 then
			self._all_buff_for_fight_list.buff = arg_4_2
		else
			self._all_buff_for_fight_list.debuff = arg_4_2
		end
	end

	function arg_1_0:get_ocean_all_buff_for_fight_list(arg_5_1)
		if arg_5_1 then
			return self._all_buff_for_fight_list.buff
		else
			return self._all_buff_for_fight_list.debuff
		end
	end

	function arg_1_0:set_ocean_map_buff_list(arg_6_1)
		table.insert(self._ocean_map_buff_list, arg_6_1)
	end

	function arg_1_0.clear_ocean_map_buff_list(arg_7_0)
		arg_7_0._ocean_map_buff_list = {}
	end

	function arg_1_0:get_ocean_map_buff_by_id(arg_8_1)
		return self._ocean_map_buff_data[arg_8_1]
	end

	function arg_1_0:__ocean_map_buff_add_task_info(arg_9_1)
		self._ocean_map_buff_data[arg_9_1.id] = arg_9_1
	end

	function arg_1_0:__ocean_map_buff_update_task_info(arg_10_1)
		self._ocean_map_buff_data[arg_10_1.id] = arg_10_1

		if arg_10_1.state == var_0_2.task_state.complete then
			local var_10_0 = var_0_3:getInstance("fearlessness_sea")

			if var_10_0 then
				var_10_0:__finish_ocean_map_buff(arg_10_1.id)
			end
		end
	end

	function arg_1_0:__ocean_map_buff_remove_task_info(arg_11_1)
		self._ocean_map_buff_data[arg_11_1.id] = nil
	end

	function arg_1_0:get_ocean_map_data()
		return self._ocean_map_data
	end

	function arg_1_0:get_current_ocean_map_data(arg_13_1)
		local var_13_0 = string.sub(arg_13_1, 1, 4) + 0

		if not self._ocean_map_data[var_13_0] then
			return
		end

		for iter_13_0, iter_13_1 in pairs(self._ocean_map_data[var_13_0].start_point) do
			if iter_13_1 == arg_13_1 then
				return self._ocean_map_data[var_13_0]
			end
		end

		return nil
	end

	function arg_1_0:is_ocean_map_node_pass(arg_14_1, arg_14_2)
		local var_14_0 = false
		local var_14_1 = {}
		local var_14_2 = self:get_current_ocean_map_data(arg_14_1)

		if not var_14_2 then
			return var_14_0
		end

		for iter_14_0, iter_14_1 in ipairs(var_14_2.pass_point) do
			if iter_14_1.id == arg_14_2 then
				var_14_1 = iter_14_1
			end
		end

		if var_14_1.info ~= nil and var_14_1.info ~= {} then
			var_14_0 = true
		end

		return var_14_0
	end

	function arg_1_0:is_ocean_map_pass(arg_15_1)
		return self._ocean_map_data[arg_15_1] ~= nil and self._ocean_map_data[arg_15_1].state == 2
	end

	function arg_1_0:get_ocean_map_by_id(arg_16_1)
		return self._ocean_map_data[arg_16_1]
	end

	function arg_1_0:__ocean_map_add_task_info(arg_17_1, arg_17_2)
		self._ocean_map_data[arg_17_1] = arg_17_2

		for iter_17_0, iter_17_1 in pairs(arg_17_2.pass_point) do
			local var_17_0 = var_0_4.find_object_by_id_start_node_id(iter_17_1.id, (var_0_4.get_start_node_id_by_id(iter_17_1.id)))

			if next(var_17_0.treasure_box) then
				for iter_17_2, iter_17_3 in pairs(iter_17_1.info) do
					if iter_17_3.grade == 1 or iter_17_3.grade == 2 then
						self:set_ocean_map_box_list(var_17_0.map_id)

						break
					end
				end
			end

			if var_17_0.score ~= 0 then
				self:set_ocean_map_point_list(arg_17_1, var_17_0.score)
			end
		end
	end

	function arg_1_0.set_current_ocean_map_start_point(arg_18_0, arg_18_1)
		arg_18_0._current_ocean_map_start_point = arg_18_1
	end

	function arg_1_0:get_current_ocean_map_start_point()
		return self._current_ocean_map_start_point
	end

	function arg_1_0.set_strike_map_start_point(arg_20_0, arg_20_1)
		arg_20_0._current_ocean_map_start_point = arg_20_1
	end

	function arg_1_0:get_strike_map_start_point()
		return self._current_ocean_map_start_point
	end

	function arg_1_0.set_current_node_config(arg_22_0, arg_22_1)
		arg_22_0._current_node_config = arg_22_1
	end

	function arg_1_0:get_current_node_config()
		return self._current_node_config
	end

	function arg_1_0:set_ocean_map_tmp_icon_list(arg_24_1, arg_24_2)
		self._tmp_icon_list[arg_24_1] = arg_24_2 ~= nil and arg_24_2 or {}
	end

	function arg_1_0:get_ocean_map_tmp_icon_list()
		return self._tmp_icon_list
	end

	function arg_1_0:get_unlocked_ocean_map_list()
		return self._unlocked_ocean_map_list
	end

	function arg_1_0:set_unlocked_ocean_map_list(arg_27_1)
		table.insert(self._unlocked_ocean_map_list, arg_27_1)
	end

	function arg_1_0:__ocean_map_update_task_info(arg_28_1, arg_28_2)
		self._ocean_map_data[arg_28_1] = arg_28_2

		if arg_28_2.state == var_0_2.task_state.complete then
			local var_28_0 = var_0_3:getInstance("fearlessness_sea")

			if var_28_0 then
				var_28_0:__finish_ocean_map(arg_28_2.id)
			end
		end
	end

	function arg_1_0:__ocean_map__remove_task_info(arg_29_1, arg_29_2)
		self._ocean_map_data[arg_29_1][arg_29_2.id] = nil
	end

	function arg_1_0:get_ocean_team_data()
		return self._ocean_team_data
	end

	function arg_1_0.set_ocean_team_data(arg_31_0, arg_31_1)
		arg_31_0._ocean_team_data = arg_31_1.members
	end

	function arg_1_0:get_ocean_team_detail_data()
		return self._team_detail_data
	end

	function arg_1_0.set_ocean_team_detail_data(arg_33_0, arg_33_1)
		arg_33_0._team_detail_data = arg_33_1
	end

	function arg_1_0:get_ocean_shop_data()
		return self._ocean_struct_data
	end

	function arg_1_0:set_ocean_shop_data(arg_35_1)
		if arg_35_1 and not self._ocean_struct_data then
			self._ocean_struct_data = arg_35_1
		end

		if arg_35_1 then
			for iter_35_0, iter_35_1 in pairs(arg_35_1) do
				self._ocean_struct_data[iter_35_0] = iter_35_1
			end
		end
	end

	function arg_1_0:set_ocean_map_point_list(arg_36_1, arg_36_2)
		local var_36_0 = false

		for iter_36_0, iter_36_1 in pairs(self._ocean_map_point_list) do
			if iter_36_0 == arg_36_1 then
				var_36_0 = true
			end
		end

		self._ocean_map_point_list[arg_36_1] = not var_36_0 and arg_36_2 or self._ocean_map_point_list[arg_36_1] + arg_36_2
	end

	function arg_1_0:get_ocean_map_point_list()
		return self._ocean_map_point_list
	end

	function arg_1_0:set_ocean_map_box_list(arg_38_1)
		self._ocean_map_box_list[arg_38_1] = 1
	end

	function arg_1_0:get_ocean_map_box_list()
		return self._ocean_map_box_list
	end

	function arg_1_0.set_user_now_question(arg_40_0)
		arg_40_0._score_push_buff_data = {}
	end

	function arg_1_0:get_user_now_question()
		return self._score_push_buff_data
	end

	function arg_1_0.reset_ocean_data(arg_42_0)
		arg_42_0._ocean_map_data = {}
		arg_42_0._ocean_map_buff_data = {}
		arg_42_0._score_push_buff_data = {}
	end
end

function var_0_0.extend_obj(arg_43_0)
	arg_43_0._boss_hp_info = {}
	arg_43_0._ocean_map_data = {}
	arg_43_0._ocean_map_node_data = {}
	arg_43_0._ocean_map_buff_data = {}
	arg_43_0._ocean_map_buff_list = {}
	arg_43_0._ocean_buff_node_data = {}
	arg_43_0._ocean_team_data = {}
	arg_43_0._ocean_struct_data = {}
	arg_43_0._team_detail_data = {}
	arg_43_0._current_ocean_map_start_point = 961301
	arg_43_0._tmp_icon_list = {}
	arg_43_0._current_node_config = {}
	arg_43_0._unlocked_ocean_map_list = {}
	arg_43_0._ocean_map_box_list = {}
	arg_43_0._ocean_map_point_list = {}
	arg_43_0._all_buff_for_fight_list = {}
end

return var_0_0
