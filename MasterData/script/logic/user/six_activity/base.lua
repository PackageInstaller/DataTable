local var_0_0 = {}
local var_0_1 = table.insert
local var_0_3 = gamecore.UILoader
local var_0_5 = gameconfig.sixth_combat_buff_config
local var_0_7 = gamecore.UserDataManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.reset_six_year_data(arg_2_0)
		arg_2_0._sixbigmap_info = {}
		arg_2_0._sixth_pass_point_with_grade = nil
		arg_2_0._sixinfo_all_data = {}
		arg_2_0._sixth_combat_info = {}
		arg_2_0._sixth_map_info = {}
		arg_2_0._sixth_bigmap_info = {}
		arg_2_0._sixinfo_map_data = {}
		arg_2_0._user_info = nil
		arg_2_0._sixinfo_data = {}
		arg_2_0._combats_data = {}
		arg_2_0.sixth_info = {}
		arg_2_0._all_bigmap_info = {}
		arg_2_0._sixbigmap_info = {}
	end

	function arg_1_0:_get_six_info()
		return self._sixinfo_data
	end

	function arg_1_0._set_updata_bigmap_info(arg_4_0, arg_4_1)
		arg_4_0._six_clear_bigmap_info = arg_4_1
	end

	function arg_1_0:get_clear_map_info()
		return self._six_clear_bigmap_info
	end

	function arg_1_0:find_now_bigmap(arg_6_1)
		for iter_6_0, iter_6_1 in pairs(self._sixbigmap_info or {}) do
			if arg_6_1 + 1 == iter_6_1.id then
				if iter_6_1.state == 1 then
					return iter_6_1
				end
			elseif iter_6_1.id == arg_6_1 then
				return iter_6_1
			end
		end
	end

	function arg_1_0:find_prev_bigmap(arg_7_1)
		for iter_7_0, iter_7_1 in pairs(self._sixbigmap_info or {}) do
			if iter_7_1.id == arg_7_1 then
				return iter_7_1
			end
		end
	end

	function arg_1_0:get_sixth_map_info()
		return self._sixth_map_info
	end

	function arg_1_0.set_sixth_prepare_team_detail_data(arg_9_0, arg_9_1)
		arg_9_0._sixth_prepare_team_detail_data = arg_9_1
	end

	function arg_1_0:get_sixth_prepare_team_detail_data()
		return self._sixth_prepare_team_detail_data
	end

	function arg_1_0:get_sixth_bigmap_info()
		return self._sixth_bigmap_info
	end

	function arg_1_0:get_cur_sixth_map()
		for iter_12_0, iter_12_1 in pairs(self._sixth_map_info) do
			if iter_12_1.state == 1 then
				return iter_12_1
			end
		end
	end

	function arg_1_0:get_sixth_point_pass(arg_13_1)
		local var_13_0 = false

		for iter_13_0, iter_13_1 in pairs(self._sixth_combat_info.point_grade) do
			if iter_13_1.point == arg_13_1 then
				var_13_0 = true
			end
		end

		return var_13_0
	end

	function arg_1_0:get_sixth_point_pass_by_grade(arg_14_1, arg_14_2, arg_14_3)
		self._sixth_pass_point_with_grade = self._sixth_pass_point_with_grade or {}

		return self._sixth_pass_point_with_grade[arg_14_2] and arg_14_3 >= self._sixth_pass_point_with_grade[arg_14_2]
	end

	function arg_1_0._six_info(arg_15_0, arg_15_1)
		arg_15_0._sixinfo_all_data = arg_15_1
	end

	function arg_1_0.__set_sixth_combat_info(arg_16_0, arg_16_1)
		arg_16_0._sixth_combat_info = arg_16_1
	end

	function arg_1_0:get_sixth_combat_info()
		return self._sixth_combat_info
	end

	function arg_1_0:__set_sixth_map_info(arg_18_1)
		local var_18_0 = false

		self._sixth_pass_point_with_grade = self._sixth_pass_point_with_grade or {}

		for iter_18_0, iter_18_1 in pairs(self._sixth_map_info) do
			if iter_18_1.id == arg_18_1.id then
				iter_18_1.state = arg_18_1.state
				iter_18_1.pass_point = arg_18_1.pass_point
				var_18_0 = true

				break
			end
		end

		if not var_18_0 then
			var_0_1(self._sixth_map_info, arg_18_1)
		end

		for iter_18_2, iter_18_3 in pairs(self._sixth_map_info) do
			if iter_18_3.pass_point then
				for iter_18_4, iter_18_5 in ipairs(iter_18_3.pass_point) do
					if iter_18_5.info then
						local var_18_1 = 99

						for iter_18_6, iter_18_7 in ipairs(iter_18_5.info) do
							if var_18_1 > iter_18_7.grade then
								var_18_1 = iter_18_7.grade
							end
						end

						if var_18_1 == 99 then
							-- block empty
						end

						self._sixth_pass_point_with_grade[iter_18_5.id] = var_18_1
					end
				end
			end
		end
	end

	function arg_1_0.__set_sixth_bigmap_info(arg_19_0, arg_19_1)
		arg_19_0._sixth_bigmap_info = arg_19_1
	end

	function arg_1_0.__resp_SixthMoveResp(arg_20_0, arg_20_1)
		local var_20_0 = var_0_3:getInstance("sixth_map_node")

		if var_20_0 then
			var_20_0:__resp_SixthMoveResp_close(arg_20_1)
		end
	end

	function arg_1_0:get_six_adjutant()
		local var_21_0 = self:get_curr_adjutant_data()
		local var_21_1 = 0

		for iter_21_0, iter_21_1 in pairs(self._sixinfo_data.adjutant_set) do
			if var_21_0 == iter_21_1 then
				var_21_1 = iter_21_0

				break
			end
		end

		if var_21_1 == 0 then
			var_21_1 = 1
			var_21_0 = self._sixinfo_data.adjutant_set[1]
		end

		return self._sixinfo_data.adjutant_set, var_21_0, var_21_1
	end

	function arg_1_0:get_six_adjutant_buff()
		return self._sixth_combat_info.adjutant_buff
	end

	function arg_1_0:get_curr_adjutant_data()
		return self._sixinfo_data.adjutant
	end

	function arg_1_0:get_instructions_guide_state()
		return self._sixinfo_data.guide
	end

	function arg_1_0.get_sixth_buff_config(arg_25_0, arg_25_1)
		local var_25_0
		local var_25_1, var_25_2 = var_0_5.get_sequence()

		for iter_25_0, iter_25_1 in pairs(var_25_1) do
			if iter_25_1.buff_id == arg_25_1 then
				var_25_0 = iter_25_1

				break
			end
		end

		return var_25_0
	end

	function arg_1_0:get_bigmap_info()
		return self._sixbigmap_info
	end

	function arg_1_0:__sixbiginfo__update_info(arg_27_1)
		self._sixbigmap_info[arg_27_1.id] = arg_27_1
	end

	function arg_1_0:__sixbiginfo__add_info(arg_28_1)
		self._sixbigmap_info[arg_28_1.id] = arg_28_1
	end

	function arg_1_0:__sixbiginfo__remove_info(arg_29_1)
		self._sixbigmap_info[arg_29_1.id] = nil
	end

	function arg_1_0.reset_combatshop_data(arg_30_0)
		arg_30_0._combats_data = {}
	end

	function arg_1_0:get_combats_list()
		return self._combats_data
	end

	function arg_1_0:__sixinfo__add_info(arg_32_1)
		self._combats_data[arg_32_1.id] = arg_32_1
	end

	function arg_1_0:__sixinfo__update_info(arg_33_1)
		self._combats_data[arg_33_1.id] = arg_33_1
	end

	function arg_1_0:__sixinfo__remove_info(arg_34_1)
		self._combats_data[arg_34_1.id] = nil
	end

	function arg_1_0._set_now_big_map(arg_35_0, arg_35_1)
		arg_35_0._now_big_map_level = arg_35_1
	end

	function arg_1_0:get_now_map_level()
		return self._now_big_map_level
	end

	function arg_1_0.set_now_have_sp(arg_37_0, arg_37_1)
		arg_37_0._have_six_sp = arg_37_1
	end

	function arg_1_0:get_now_have_sp()
		return self._have_six_sp
	end

	function arg_1_0:set_open_sixth_select_and_buff(arg_39_1)
		var_0_7:setDataByID("open_sixth_select_and_buff", self:get_account_id(), arg_39_1)
	end

	function arg_1_0:get_open_sixth_select_and_buff()
		return var_0_7:getDataByID("open_sixth_select_and_buff", (self:get_account_id()))
	end

	function arg_1_0.set_repeat_map_id(arg_41_0, arg_41_1)
		arg_41_0._repeat_id = arg_41_1
	end

	function arg_1_0:get_repeat_map_id()
		return self._repeat_id
	end

	function arg_1_0.set_to_six_year(arg_43_0, arg_43_1)
		arg_43_0._now_is_six_year = arg_43_1
	end

	function arg_1_0:get_to_six_year()
		return self._now_is_six_year
	end

	function arg_1_0.set_now_six_bgm(arg_45_0, arg_45_1)
		arg_45_0._now_six_bg = arg_45_1
	end

	function arg_1_0:get_now_six_bgm()
		return self._now_six_bg
	end

	function arg_1_0.set_pass_id(arg_47_0, arg_47_1)
		arg_47_0._now_pass_id = arg_47_1
	end

	function arg_1_0:get_pass_id()
		return self._now_pass_id
	end

	function arg_1_0.set_to_six_fight_map(arg_49_0, arg_49_1)
		arg_49_0._now_into_fight_map = arg_49_1
	end

	function arg_1_0:get_to_six_fight_map()
		return self._now_into_fight_map
	end
end

function var_0_0.extend_obj(arg_51_0)
	arg_51_0._six_clear_bigmap_info = {}
	arg_51_0._sixinfo_all_data = {}
	arg_51_0._sixth_combat_info = {}
	arg_51_0._sixth_map_info = {}
	arg_51_0._sixth_bigmap_info = {}
	arg_51_0._sixinfo_map_data = {}
	arg_51_0._user_info = nil
	arg_51_0._sixinfo_data = {}
	arg_51_0._combats_data = {}
	arg_51_0.sixth_info = {}
	arg_51_0._all_bigmap_info = {}
	arg_51_0._now_big_map_level = nil
	arg_51_0._sixbigmap_info = {}
	arg_51_0._have_six_sp = nil
	arg_51_0._sixth_pass_point_with_grade = nil
	arg_51_0._sixth_prepare_team_detail_data = {}
	arg_51_0._repeat_id = nil
end

return var_0_0
