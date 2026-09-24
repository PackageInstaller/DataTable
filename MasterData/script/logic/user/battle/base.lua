return {
	extend_method = function(arg_1_0)
		function arg_1_0.reset_battle_data(arg_2_0)
			arg_2_0._last_map_node = nil
		end

		function arg_1_0:get_battle_data()
			return self._battle_data
		end

		function arg_1_0.set_battle_data_whithout_server(arg_4_0, arg_4_1)
			arg_4_0._battle_data = arg_4_1
		end

		function arg_1_0:get_cur_click_team_index()
			return self.cur_click_team_index
		end

		function arg_1_0:get_battle_result()
			return self._battle_settlement_info
		end

		function arg_1_0.set_battle_result(arg_7_0, arg_7_1)
			arg_7_0._battle_settlement_info = arg_7_1
		end

		function arg_1_0.set_last_map_node(arg_8_0, arg_8_1)
			arg_8_0._last_map_node = arg_8_1
		end

		function arg_1_0.set_battle_type(arg_9_0, arg_9_1)
			arg_9_0._battle_type = arg_9_1
		end

		function arg_1_0.set_new_battle_type(arg_10_0, arg_10_1)
			arg_10_0._new_battle_type = arg_10_1
		end

		function arg_1_0:get_new_battle_type()
			return self._new_battle_type
		end

		function arg_1_0.set_cur_formation(arg_12_0, arg_12_1)
			arg_12_0._cur_formation = arg_12_1
		end

		function arg_1_0:get_battle_type()
			return self._battle_type
		end

		function arg_1_0:get_cur_formation()
			return self._cur_formation
		end

		function arg_1_0.set_back_type(arg_15_0, arg_15_1)
			arg_15_0._back_type = arg_15_1
		end

		function arg_1_0:get_back_type()
			return self._back_type
		end

		function arg_1_0.set_cur_click_team_index(arg_17_0, arg_17_1)
			arg_17_0.cur_click_team_index = arg_17_1
		end

		function arg_1_0:get_last_map_node()
			return self._last_map_node
		end

		function arg_1_0.set_campaign_difficulty(arg_19_0, arg_19_1)
			arg_19_0._difficulty = arg_19_1
		end

		function arg_1_0:get_campaign_difficulty()
			return self._difficulty
		end

		function arg_1_0.set_boss_hp_info(arg_21_0, arg_21_1)
			arg_21_0._boss_hp_info = arg_21_1
		end

		function arg_1_0:get_boss_hp_info()
			return self._boss_hp_info
		end

		function arg_1_0.set_bvr_damage_info(arg_23_0, arg_23_1)
			arg_23_0._save_bvr_damage_info = arg_23_1
		end

		function arg_1_0:get_bvr_damage_info()
			return self._save_bvr_damage_info
		end

		function arg_1_0.set_formation_id(arg_25_0, arg_25_1)
			arg_25_0._save_team_formation = arg_25_1
		end

		function arg_1_0:get_formation_id()
			return self._save_team_formation
		end

		function arg_1_0.set_night_battle(arg_27_0, arg_27_1)
			arg_27_0._save_night_battle = arg_27_1
		end

		function arg_1_0:get_night_battle()
			return self._save_night_battle
		end
	end,
	extend_obj = function(arg_29_0)
		arg_29_0.cur_click_team_index = 1
		arg_29_0._battle_type = nil
		arg_29_0._last_map_node = nil
		arg_29_0._back_type = nil
		arg_29_0._cur_formation = 1
		arg_29_0._new_battle_type = nil
		arg_29_0._difficulty = 1
	end
}
