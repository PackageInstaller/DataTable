local var_0_0 = {}
local var_0_1 = table.insert
local var_0_3 = gamecore.UILoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.reset_strike_data(arg_2_0)
		return
	end

	function arg_1_0:get_strike_data()
		return self._strike_data
	end

	function arg_1_0:get_strike_data_by_level(arg_4_1)
		return self._strike_data[arg_4_1]
	end

	function arg_1_0:get_strike_team_data()
		return self._strike_team_data
	end

	function arg_1_0:get_strike_award_data()
		return self._strike_award_data
	end

	function arg_1_0:get_strike_award_data_by_level(arg_7_1)
		return self._strike_award_data[arg_7_1]
	end

	function arg_1_0:get_strike_point_info()
		return self._strike_info_data
	end

	function arg_1_0.set_strike_point_info(arg_9_0, arg_9_1)
		arg_9_0._strike_info_data = arg_9_1
	end

	function arg_1_0.set_user_strike_map_data(arg_10_0, arg_10_1)
		arg_10_0._user_strike_map_data = arg_10_1
	end

	function arg_1_0:get_user_strike_map_data()
		return self._user_strike_map_data
	end

	function arg_1_0:get_strike_battle_data()
		return self._strike_battle_data
	end

	function arg_1_0:get_is_into_map()
		return self.__is_into_map
	end

	function arg_1_0.set_strike_pass_buff(arg_14_0, arg_14_1)
		arg_14_0._strike_pass_buff = arg_14_1
	end

	function arg_1_0:get_strike_pass_buff()
		return self._strike_pass_buff
	end

	function arg_1_0.set_strike_first_get_in(arg_16_0, arg_16_1)
		arg_16_0.first_get_in_state = arg_16_1
	end

	function arg_1_0:get_strike_first_get_in()
		return self.first_get_in_state
	end

	function arg_1_0.set_fight_info_for_strike(arg_18_0, arg_18_1)
		arg_18_0.fight_info_for_strike = arg_18_1
	end

	function arg_1_0:get_fight_info_for_strike()
		return self.fight_info_for_strike
	end

	function arg_1_0:set_solid_server_honor_list(arg_20_1)
		if arg_20_1 and arg_20_1.info and next(arg_20_1.info) then
			self.solid_server_honor_list = {}

			for iter_20_0, iter_20_1 in pairs(arg_20_1.info) do
				table.insert(self.solid_server_honor_list, iter_20_1)
			end
		end
	end

	function arg_1_0:get_solid_server_honor_list()
		if self.solid_server_honor_list and next(self.solid_server_honor_list) then
			return self.solid_server_honor_list
		else
			return {}
		end
	end

	function arg_1_0.set_is_into_map(arg_22_0, arg_22_1)
		arg_22_0.__is_into_map = arg_22_1
	end

	function arg_1_0.reset_strike_award_data(arg_23_0)
		arg_23_0._strike_award_data = {}
		arg_23_0._strike_team_data = {}
		arg_23_0._strike_data = {}
		arg_23_0._strike_info_data = {}
		arg_23_0._strike_battle_data = {}
	end

	function arg_1_0.set_strike_team_data(arg_24_0, arg_24_1)
		arg_24_0._strike_team_data = arg_24_1.members
	end

	function arg_1_0.set_strike_battle_data(arg_25_0, arg_25_1)
		arg_25_0._strike_battle_data = arg_25_1
	end

	function arg_1_0:__strike_map_info__update(arg_26_1)
		self._strike_data[arg_26_1.id] = arg_26_1
	end

	function arg_1_0:__strike_map_info__add(arg_27_1)
		self._strike_data[arg_27_1.id] = arg_27_1
	end

	function arg_1_0:__strike_map_info__remove(arg_28_1)
		self._strike_data[arg_28_1.id] = nil
	end

	function arg_1_0:__strike_award_info__update(arg_29_1)
		self._strike_award_data[arg_29_1] = arg_29_1
	end

	function arg_1_0:__strike_award_info__add(arg_30_1)
		self._strike_award_data[arg_30_1] = arg_30_1
	end

	function arg_1_0:__strike_award_info__remove(arg_31_1)
		self._strike_award_data[arg_31_1] = nil
	end

	function arg_1_0.set_strike_page_id(arg_32_0, arg_32_1)
		arg_32_0.__save_page_id = arg_32_1
	end

	function arg_1_0:get_strike_page_id()
		return self.__save_page_id
	end

	function arg_1_0.set_strike_cur_page_index(arg_34_0, arg_34_1)
		arg_34_0._cur_strike_page_index = arg_34_1
	end

	function arg_1_0:get_strike_cur_page_index()
		return self._cur_strike_page_index or 1
	end

	function arg_1_0.set_strike_config(arg_36_0, arg_36_1)
		arg_36_0.__save_config = arg_36_1
	end

	function arg_1_0:get_strike_config()
		return self.__save_config
	end

	function arg_1_0.set_strike_flag(arg_38_0, arg_38_1)
		arg_38_0.__save_flag = arg_38_1
	end

	function arg_1_0:get_strike_flag()
		return self.__save_flag
	end

	function arg_1_0.set_now_strike_first_node(arg_40_0, arg_40_1)
		arg_40_0.__start_node_id = arg_40_1
	end

	function arg_1_0:get_now_strike_first_node()
		return self.__start_node_id
	end

	function arg_1_0.set_now_strike_fight_node(arg_42_0, arg_42_1)
		arg_42_0.__fight_node_id = arg_42_1
	end

	function arg_1_0:get_now_strike_fight_node()
		return self.__fight_node_id
	end

	function arg_1_0.set_save_buff(arg_44_0, arg_44_1)
		arg_44_0.__save_node_buff = arg_44_1
	end

	function arg_1_0:get_save_buff()
		return self.__save_node_buff
	end

	function arg_1_0.set_have_buff_point(arg_46_0, arg_46_1)
		arg_46_0.__save_buff_flag = arg_46_1
	end

	function arg_1_0:get_have_buff_point()
		return self.__save_buff_flag
	end

	function arg_1_0.set_now_ship_point(arg_48_0, arg_48_1)
		arg_48_0.__now_ship_point = arg_48_1
	end

	function arg_1_0:get_now_ship_point()
		return self.__now_ship_point
	end

	function arg_1_0.set_next_ship_point(arg_50_0, arg_50_1)
		arg_50_0.__next_ship_point = arg_50_1
	end

	function arg_1_0:get_next_ship_point()
		return self.__next_ship_point
	end

	function arg_1_0.set_strike_user_money(arg_52_0, arg_52_1)
		arg_52_0._user_money_total = arg_52_1 or 0
	end

	function arg_1_0:get_strike_user_money()
		return self._user_money_total or 0
	end

	function arg_1_0.set_strike_cur_map_total_money(arg_54_0, arg_54_1)
		arg_54_0._strike_cur_map_total_money = arg_54_1
	end

	function arg_1_0:get_strike_cur_map_total_money()
		return self._strike_cur_map_total_money or 0
	end

	function arg_1_0.set_strike_cur_map_money(arg_56_0, arg_56_1)
		arg_56_0._strike_cur_map_money = arg_56_1
	end

	function arg_1_0:get_strike_cur_map_money()
		return self._strike_cur_map_money or 0
	end

	function arg_1_0.set_save_weather(arg_58_0, arg_58_1)
		arg_58_0.__save_map_weather = arg_58_1
	end

	function arg_1_0:get_save_weather()
		return self.__save_map_weather or 0
	end

	function arg_1_0:set_strike_map_panel_buff()
		self.strike_map_panel_buff = self.__save_node_buff
	end

	function arg_1_0:get_strike_map_panel_buff()
		return self.strike_map_panel_buff
	end

	function arg_1_0:record_strike_enter_battle_nunber()
		self._strike_enter_battle_nunber = self._strike_enter_battle_nunber + 1
	end

	function arg_1_0:get_strike_enter_battle_nunber()
		return self._strike_enter_battle_nunber
	end

	function arg_1_0.reset_strike_enter_battle_nunber(arg_64_0)
		arg_64_0._strike_enter_battle_nunber = 0
	end

	function arg_1_0.set_strike_now_state(arg_65_0, arg_65_1)
		arg_65_0._strike_now_state = arg_65_1
	end

	function arg_1_0:get_strike_now_state()
		return self._strike_now_state
	end

	function arg_1_0:get_strike_map_point_pass_by_state_1(arg_67_1, arg_67_2, arg_67_3)
		local var_67_0 = false

		if next(self._strike_data) then
			for iter_67_0, iter_67_1 in pairs(self._strike_data) do
				if arg_67_1 == iter_67_0 and iter_67_1.state == 2 then
					for iter_67_2, iter_67_3 in pairs(iter_67_1.pass_point) do
						if iter_67_3 == arg_67_2 then
							var_0_1(self._strike_pass_map_state, arg_67_2)
						end
					end
				end
			end
		end

		if next(self._strike_pass_map_state) then
			for iter_67_4, iter_67_5 in pairs(self._strike_pass_map_state) do
				if iter_67_5 == arg_67_2 and arg_67_3 == 1 then
					var_67_0 = true
				end
			end
		end

		return var_67_0
	end

	function arg_1_0:get_strike_map_point_pass_by_state_2(arg_68_1, arg_68_2, arg_68_3)
		local var_68_0 = false

		if next(self._strike_data) then
			for iter_68_0, iter_68_1 in pairs(self._strike_data) do
				if arg_68_1 == iter_68_0 and iter_68_1.state_hard == 2 then
					for iter_68_2, iter_68_3 in pairs(iter_68_1.hard_pass_point) do
						if iter_68_3 == arg_68_2 then
							var_0_1(self._strike_pass_map_state_2, arg_68_2)
						end
					end
				end
			end
		end

		if next(self._strike_pass_map_state_2) then
			for iter_68_4, iter_68_5 in pairs(self._strike_pass_map_state_2) do
				if iter_68_5 == arg_68_2 and arg_68_3 == 2 then
					var_68_0 = true
				end
			end
		end

		return var_68_0
	end

	function arg_1_0.set_come_in_panel_style(arg_69_0, arg_69_1)
		arg_69_0._common_fight_type = arg_69_1
	end

	function arg_1_0:get_come_in_panel_style()
		return self._common_fight_type
	end

	function arg_1_0.set_buff_item_color(arg_71_0, arg_71_1)
		arg_71_0.buff_item_color = arg_71_1
	end

	function arg_1_0:get_buff_item_color()
		return self.buff_item_color
	end

	function arg_1_0.set_return_type(arg_73_0, arg_73_1)
		arg_73_0.return_type = arg_73_1
	end

	function arg_1_0:get_return_type()
		return self.return_type
	end

	function arg_1_0.set_whole_buff_state(arg_75_0, arg_75_1)
		arg_75_0.whole_buff_state = arg_75_1
	end

	function arg_1_0:get_whole_buff_state()
		return self.whole_buff_state
	end

	function arg_1_0.set_whole_buff_number(arg_77_0, arg_77_1)
		arg_77_0.whole_buff_number = arg_77_1

		local var_77_0 = var_0_3:getInstance("strike_main")

		if var_77_0 and not var_0_3:getInstance("ninth_honor_list") then
			var_77_0:__init_reusable_cell()
			var_77_0:update_cell()
		end
	end

	function arg_1_0:get_whole_buff_number()
		return self.whole_buff_number
	end

	function arg_1_0.set_to_strike(arg_79_0, arg_79_1)
		arg_79_0._into_strike = arg_79_1
	end

	function arg_1_0:get_to_strike()
		return self._into_strike
	end

	function arg_1_0.set_strike_map_info(arg_81_0, arg_81_1)
		arg_81_0.__map_point_info = arg_81_1
	end

	function arg_1_0:get_strike_map_info()
		return self.__map_point_info
	end
end

function var_0_0.extend_obj(arg_83_0)
	arg_83_0._strike_data = {}
	arg_83_0._strike_award_data = {}
	arg_83_0._strike_team_data = {}
	arg_83_0._strike_info_data = {}
	arg_83_0._strike_battle_data = {}
	arg_83_0._button__change_flag = true
	arg_83_0.__is_into_map = false
	arg_83_0.__save_page_id = nil
	arg_83_0._cur_strike_page_index = nil
	arg_83_0.__save_config = {}
	arg_83_0.__save_flag = nil
	arg_83_0.__start_node_id = nil
	arg_83_0.__fight_node_id = nil
	arg_83_0.__save_node_buff = nil
	arg_83_0.__save_buff_flag = nil
	arg_83_0.__now_ship_point = nil
	arg_83_0.__next_ship_point = nil
	arg_83_0._strike_cur_map_total_money = nil
	arg_83_0._strike_cur_map_money = nil
	arg_83_0.__save_map_weather = nil
	arg_83_0.strike_map_panel_buff = nil
	arg_83_0._strike_enter_battle_nunber = 0
	arg_83_0._user_strike_map_data = nil
	arg_83_0._strike_now_state = nil
	arg_83_0._strike_pass_map_state = {}
	arg_83_0._strike_pass_map_state_2 = {}
	arg_83_0._common_fight_type = nil
	arg_83_0.first_get_in_state = false
	arg_83_0.fight_info_for_strike = nil
	arg_83_0.buff_item_color = {}
	arg_83_0.return_type = false
	arg_83_0.whole_buff_state = true
	arg_83_0.whole_buff_number = 0
	arg_83_0.__map_point_info = {}
	arg_83_0.solid_server_honor_list = {}
end

return var_0_0
