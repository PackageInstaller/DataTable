local var_0_0 = {}
local var_0_1 = table.insert
local var_0_2 = gameenum.common_type
local var_0_3 = gamecore.UILoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:get_special_task_list()
		return self._special_task_data
	end

	function arg_1_0:get_special_task_by_id(arg_3_1)
		return self._special_task_data[arg_3_1]
	end

	function arg_1_0:get_fearlessness_id()
		return self._fearlessness_id
	end

	function arg_1_0.set_fearlessness_id(arg_5_0, arg_5_1)
		arg_5_0._fearlessness_id = arg_5_1
	end

	function arg_1_0:get_fearlessness_is_hard()
		return self._is_hard
	end

	function arg_1_0.set_fearlessness_is_hard(arg_7_0, arg_7_1)
		arg_7_0._is_hard = arg_7_1
	end

	function arg_1_0:get_push_buff_list(arg_8_1)
		return self._get_easy_push_buff_list
	end

	function arg_1_0:get_push_buff_equip_list(arg_9_1)
		local var_9_0 = {}

		for iter_9_0, iter_9_1 in pairs(self._get_easy_push_buff_list) do
			if iter_9_1.is_equip then
				var_9_0[iter_9_0] = iter_9_1
			end
		end

		return var_9_0
	end

	function arg_1_0:get_push_info(arg_10_1)
		if not arg_10_1 then
			return self._easy_push_info
		else
			return self._hard_push_info
		end
	end

	function arg_1_0:get_push_info_coin()
		return self._push_info_coin
	end

	function arg_1_0:get_push_info_buff_count()
		local var_12_0 = self:get_push_info()

		if var_12_0 then
			return var_12_0.buff_count
		end
	end

	function arg_1_0:get_push_info_using_buff()
		local var_13_0 = self:get_push_info()

		if var_13_0 then
			return var_13_0.using_buff
		end
	end

	function arg_1_0:set_push_info_using_buff()
		self._easy_push_info.using_buff = nil
	end

	function arg_1_0:__special_task_add_task_info(arg_15_1)
		self._special_task_data[arg_15_1.id] = arg_15_1
	end

	function arg_1_0:__special_task_update_task_info(arg_16_1)
		self._special_task_data[arg_16_1.id] = arg_16_1

		if arg_16_1.state == var_0_2.task_state.complete then
			self._seven_special_task_data[arg_16_1.id] = arg_16_1.id
			self._eighth_special_task_data[arg_16_1.id] = arg_16_1.id

			self:set_open_fearless_sea_panel(true, arg_16_1.id)

			local var_16_0 = var_0_3:getInstance("fearlessness_sea")
			local var_16_1 = var_0_3:getInstance("mix_main_map")
			local var_16_2 = var_0_3:getInstance("seven_sea_map")
			local var_16_3 = var_0_3:getInstance("eighth_sea_map")

			if var_16_1 then
				var_16_1:__finish_special_task(arg_16_1.id)
			end

			if var_16_2 then
				var_16_2:__finish_special_task(arg_16_1.id)
			end

			if var_16_3 then
				var_16_3:__finish_special_task(arg_16_1.id)
			end
		end
	end

	function arg_1_0:get_seven_special_task_data()
		return self._seven_special_task_data
	end

	function arg_1_0.clear_open_seven_panel(arg_18_0)
		arg_18_0._seven_special_task_data = {}
	end

	function arg_1_0:get_eighth_special_task_data()
		return self._eighth_special_task_data
	end

	function arg_1_0.clear_open_eighth_panel(arg_20_0)
		arg_20_0._eighth_special_task_data = {}
	end

	function arg_1_0:__special_task__remove_task_info(arg_21_1)
		self._special_task_data[arg_21_1.id] = nil
	end

	function arg_1_0:__push_buff_update_buff_info(arg_22_1)
		self:__update_push_buff(arg_22_1)
	end

	function arg_1_0:__push_buff_add_buff_info(arg_23_1)
		self:__update_push_buff(arg_23_1)
	end

	function arg_1_0:__push_buff_remove_buff_info(arg_24_1)
		self:__update_push_buff(arg_24_1, true)
	end

	function arg_1_0:__update_push_buff(arg_25_1, arg_25_2)
		arg_25_1.is_equip = false

		if not arg_25_1.hard then
			self._get_easy_push_buff_list[arg_25_1.id] = not arg_25_2 and arg_25_1 or nil
		else
			self._get_hard_push_buff_list[arg_25_1.id] = not arg_25_2 and arg_25_1 or nil
		end

		self:__update_buff_level()
	end

	function arg_1_0:__push_info_update(arg_26_1)
		if arg_26_1.using_buff then
			self._easy_push_info.using_buff = arg_26_1.using_buff
		end

		self:__update_buff_equip_state()
	end

	function arg_1_0:__update_buff_equip_state()
		local function var_27_0(arg_28_0, arg_28_1)
			if arg_28_0 and next(arg_28_0) then
				for iter_28_0, iter_28_1 in pairs((not arg_28_1 or nil) and (self._get_easy_push_buff_list or self._get_hard_push_buff_list)) do
					local var_28_0 = false

					for iter_28_2, iter_28_3 in pairs(arg_28_0) do
						if iter_28_1 == iter_28_3 then
							var_28_0 = true
						end
					end

					iter_28_1.is_equip = var_28_0
				end
			end
		end

		var_27_0(self._easy_push_info.using_buff, false)
		var_27_0(self._hard_push_info.using_buff, true)
	end

	function arg_1_0:__update_buff_level()
		(function(arg_30_0)
			for iter_30_0, iter_30_1 in pairs(arg_30_0) do
				if iter_30_1.count <= 0 then
					return
				end

				local var_30_0 = 0
				local var_30_1 = 0
				local var_30_2 = 0
				local var_30_4

				if iter_30_1.count < 4 then
					var_30_0 = 1
					var_30_1 = 4 - iter_30_1.count
					var_30_2 = 3
					var_30_4 = false
				elseif iter_30_1.count >= 4 and iter_30_1.count < 10 then
					var_30_0 = 2
					var_30_1 = 10 - iter_30_1.count
					var_30_2 = 6
					var_30_4 = false
				else
					var_30_0 = 3
					var_30_1 = 0
					var_30_2 = 0
					var_30_4 = true
				end

				iter_30_1.level = var_30_0
				iter_30_1.exp = var_30_1
				iter_30_1.need_exp = var_30_2
				iter_30_1.is_max = var_30_4
			end
		end)(self._get_easy_push_buff_list)
	end

	function arg_1_0:is_equip_buff_content_full()
		if self._easy_push_info.using_buff then
			if #self._easy_push_info.using_buff == 6 then
				return true
			else
				return false
			end
		else
			return false
		end
	end

	function arg_1_0:get_push_active_info()
		return self._push_active_info
	end

	function arg_1_0.set_goto_fear_sea(arg_33_0, arg_33_1)
		arg_33_0._goto_fear_sea = arg_33_1
	end

	function arg_1_0:get_goto_fear_sea()
		return self._goto_fear_sea
	end

	function arg_1_0.set_save_now_fear(arg_35_0, arg_35_1)
		arg_35_0._now_sea_map = arg_35_1
	end

	function arg_1_0:get_save_now_fear()
		return self._now_sea_map
	end

	function arg_1_0.set_open_fearless_sea_panel(arg_37_0, arg_37_1, arg_37_2)
		arg_37_0._open_fearless_sea_panel = arg_37_1
		arg_37_0._open_fearless_sea_panel_data = arg_37_2
	end

	function arg_1_0:get_open_fearless_sea_panel()
		return self._open_fearless_sea_panel, self._open_fearless_sea_panel_data
	end

	function arg_1_0.set_fearlessness_update_buff_time(arg_39_0, arg_39_1)
		arg_39_0._fearless_sea_panel_buff_time = arg_39_1
	end

	function arg_1_0:get_fearlessness_update_buff_time()
		return self._fearless_sea_panel_buff_time
	end

	function arg_1_0:__special_push_update_random_buff_info(arg_41_1)
		for iter_41_0, iter_41_1 in pairs(self._special_push_random_data) do
			if iter_41_1.point_id == arg_41_1.point_id then
				self._special_push_random_data[iter_41_0] = nil

				break
			end
		end

		var_0_1(self._special_push_random_data, arg_41_1)
	end

	function arg_1_0:__special_push_add_random_buff_info(arg_42_1)
		for iter_42_0, iter_42_1 in pairs(self._special_push_random_data) do
			if iter_42_1.point_id == arg_42_1.point_id then
				self._special_push_random_data[iter_42_0] = nil

				break
			end
		end

		var_0_1(self._special_push_random_data, arg_42_1)
	end

	function arg_1_0:__special_push_remove_random_buff_info(arg_43_1)
		for iter_43_0, iter_43_1 in pairs(self._special_push_random_data) do
			if iter_43_1.point_id == arg_43_1.point_id then
				self._special_push_random_data[iter_43_0] = nil

				break
			end
		end
	end

	function arg_1_0:get_push_random_buff()
		return self._special_push_random_data
	end

	function arg_1_0.set_map_random_buff_info(arg_45_0, arg_45_1, arg_45_2)
		arg_45_0._small_map_info = arg_45_1
		arg_45_0._small_map_id = arg_45_2
	end

	function arg_1_0:get_map_random_buff_info()
		return self._small_map_info, self._small_map_id
	end

	function arg_1_0.set_random_buff_time(arg_47_0, arg_47_1)
		arg_47_0._random_buff_time_info = arg_47_1
	end

	function arg_1_0:get_random_buff_time()
		return self._random_buff_time_info + 3600
	end

	function arg_1_0.reset_push_random_buff_data(arg_49_0)
		arg_49_0._special_push_random_data = {}
	end

	function arg_1_0.set_now_common_panel_state(arg_50_0, arg_50_1)
		arg_50_0._common_panel_state = arg_50_1
	end

	function arg_1_0:get_now_common_panel_state(arg_51_1)
		return self._common_panel_state
	end

	function arg_1_0:set_bug_buff_index(arg_52_1)
		var_0_1(self._buy_buff_id, arg_52_1)
	end

	function arg_1_0.clear_bug_buff_index(arg_53_0)
		arg_53_0._buy_buff_id = {}
	end

	function arg_1_0:get_bug_buff_index()
		return self._buy_buff_id
	end

	function arg_1_0.set_disassemble_buff(arg_55_0, arg_55_1)
		arg_55_0._disassemble_buff = arg_55_1
	end

	function arg_1_0:get_disassemble_buff()
		return self._disassemble_buff
	end

	function arg_1_0:get_push_guide_state()
		return self._push_guide
	end

	function arg_1_0.show_panel_mix_panel(arg_58_0, arg_58_1, arg_58_2)
		local var_58_0 = var_0_3:getInstance("fearlessness_sea")

		if var_58_0 and next(var_58_0._map_levels_table) then
			for iter_58_0, iter_58_1 in pairs(var_58_0._map_levels_table) do
				if iter_58_1.id == arg_58_1 then
					var_58_0:show_map_info(iter_58_1)
				end
			end
		end
	end

	function arg_1_0:get_push_cia_buff_info()
		if self._push_buff_ids and next(self._push_buff_ids) then
			return self._push_buff_ids
		else
			return {}
		end
	end
end

function var_0_0.extend_obj(arg_60_0)
	arg_60_0._special_task_data = {}
	arg_60_0._fearlessness_id = nil
	arg_60_0._is_hard = false
	arg_60_0._get_easy_push_buff_list = {}
	arg_60_0._get_hard_push_buff_list = {}
	arg_60_0._easy_push_info = {}
	arg_60_0._hard_push_info = {}
	arg_60_0._push_active_info = {}
	arg_60_0._open_fearless_sea_panel = false
	arg_60_0.open_fearless_sea_panel_data = nil
	arg_60_0._fearless_sea_panel_buff_time = nil
	arg_60_0._special_push_random_data = {}
	arg_60_0._now_sea_map = false
	arg_60_0._small_map_info = {}
	arg_60_0._small_map_id = nil
	arg_60_0._random_buff_time_info = 0
	arg_60_0._seven_special_task_data = {}
	arg_60_0._eighth_special_task_data = {}
	arg_60_0._buy_buff_id = {}
	arg_60_0._disassemble_buff = 2
	arg_60_0._push_guide = 0
	arg_60_0._push_info_coin = 0
	arg_60_0._push_buff_ids = {}
end

return var_0_0
