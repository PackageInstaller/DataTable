local var_0_0 = {}
local var_0_1 = table.insert
local var_0_3 = gamecore.UILoader
local var_0_6 = gamecore.UserDataManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.reset_mist_data(arg_2_0)
		arg_2_0._mist_big_map_info = {}
		arg_2_0._mist_pass_point_with_grade = nil
		arg_2_0._mist_map_info = {}
		arg_2_0._mist_bigmap_info = {}
		arg_2_0._mist_info_data = {}
		arg_2_0._mist_combat_info = {}
		arg_2_0._mist_clear_bigmap_info = {}
		arg_2_0._mist_award_data = {}
	end

	function arg_1_0:get_mist_info()
		return self._mist_info_data
	end

	function arg_1_0._set_updata_bigmap_info(arg_4_0, arg_4_1)
		arg_4_0._mist_clear_bigmap_info = arg_4_1
	end

	function arg_1_0:get_mist_clear_map_info()
		return self._mist_clear_bigmap_info
	end

	function arg_1_0:find_mist_now_bigmap(arg_6_1)
		for iter_6_0, iter_6_1 in pairs(self._mist_big_map_info or {}) do
			if arg_6_1 + 1 == iter_6_1.id then
				if iter_6_1.state == 1 then
					return iter_6_1
				end
			elseif iter_6_1.id == arg_6_1 then
				return iter_6_1
			end
		end
	end

	function arg_1_0:find_mist_prev_bigmap(arg_7_1)
		local var_7_1 = {}

		for iter_7_0, iter_7_1 in pairs(self._mist_big_map_info or {}) do
			var_0_1(var_7_1, iter_7_1)
		end

		for iter_7_2, iter_7_3 in pairs(var_7_1) do
			if iter_7_3.id == arg_7_1 then
				return iter_7_3
			end
		end
	end

	function arg_1_0:get_mist_adjutant()
		local var_8_0 = self._mist_info_data.adjutant
		local var_8_1 = 0

		for iter_8_0, iter_8_1 in pairs(self._mist_info_data.adjutant_set) do
			if var_8_0 == iter_8_1 then
				var_8_1 = iter_8_0

				break
			end
		end

		if var_8_1 == 0 then
			var_8_1 = 1
			var_8_0 = self._mist_info_data.adjutant_set[1]
		end

		return self._mist_info_data.adjutant_set, var_8_0, var_8_1
	end

	function arg_1_0:get_mist_map_info()
		return self._mist_map_info
	end

	function arg_1_0.set_mist_prepare_team_detail_data(arg_10_0, arg_10_1)
		arg_10_0._mist_prepare_team_detail_data = arg_10_1
	end

	function arg_1_0:get_mist_prepare_team_detail_data()
		return self._mist_prepare_team_detail_data
	end

	function arg_1_0:get_cur_mist_map()
		for iter_12_0, iter_12_1 in pairs(self._mist_map_info) do
			if iter_12_1.state == 1 then
				return iter_12_1
			end
		end
	end

	function arg_1_0:get_mist_point_pass(arg_13_1)
		local var_13_0 = false

		for iter_13_0, iter_13_1 in pairs(self._mist_combat_info.point_grade) do
			if iter_13_1.point == arg_13_1 then
				var_13_0 = true
			end
		end

		return var_13_0
	end

	function arg_1_0:get_mist_point_pass_by_grade(arg_14_1, arg_14_2, arg_14_3)
		self._mist_pass_point_with_grade = self._mist_pass_point_with_grade or {}

		return self._mist_pass_point_with_grade[arg_14_2] and arg_14_3 >= self._mist_pass_point_with_grade[arg_14_2]
	end

	function arg_1_0:__mist_award_info__update(arg_15_1)
		self._mist_award_data[arg_15_1] = arg_15_1
	end

	function arg_1_0:__mist_award_info__add(arg_16_1)
		self._mist_award_data[arg_16_1] = arg_16_1
	end

	function arg_1_0:__mist_award_info__remove(arg_17_1)
		self._mist_award_data[arg_17_1] = nil
	end

	function arg_1_0.set_mist_user_money(arg_18_0, arg_18_1)
		arg_18_0._user_money_total = arg_18_1 or 0
	end

	function arg_1_0:get_mist_user_money()
		return self._user_money_total or 0
	end

	function arg_1_0:get_mist_award_data()
		return self._mist_award_data
	end

	function arg_1_0:get_mist_award_data_by_level(arg_21_1)
		return self._mist_award_data[arg_21_1]
	end

	function arg_1_0._set_mist_combat_info(arg_22_0, arg_22_1)
		arg_22_0._mist_combat_info = arg_22_1
	end

	function arg_1_0:get_mist_combat_info()
		return self._mist_combat_info
	end

	function arg_1_0:__set_mist_map_info(arg_24_1)
		do return end

		local var_24_0 = false

		self._mist_pass_point_with_grade = self._mist_pass_point_with_grade or {}

		for iter_24_0, iter_24_1 in pairs(self._mist_map_info) do
			if iter_24_1.id == arg_24_1.id then
				iter_24_1.state = arg_24_1.state
				iter_24_1.pass_point = arg_24_1.pass_point
				iter_24_1.score_token = arg_24_1.score_token
				var_24_0 = true

				break
			end
		end

		if not var_24_0 then
			var_0_1(self._mist_map_info, arg_24_1)
		end

		for iter_24_2, iter_24_3 in pairs(self._mist_map_info) do
			if iter_24_3.pass_point then
				for iter_24_4, iter_24_5 in ipairs(iter_24_3.pass_point) do
					if iter_24_5.info then
						local var_24_1 = 99

						for iter_24_6, iter_24_7 in ipairs(iter_24_5.info) do
							if var_24_1 > iter_24_7.grade then
								var_24_1 = iter_24_7.grade
							end
						end

						if var_24_1 == 99 then
							-- block empty
						end

						self._mist_pass_point_with_grade[iter_24_5.id] = var_24_1
					end
				end
			end
		end
	end

	function arg_1_0.__set_mist_bigmap_info(arg_25_0, arg_25_1)
		arg_25_0._mist_bigmap_info = arg_25_1
	end

	function arg_1_0.__resp_MistMoveResp(arg_26_0, arg_26_1)
		local var_26_0 = var_0_3:getInstance("nf_map_node")

		if var_26_0 then
			var_26_0:__resp_MistMoveResp_close(arg_26_1)
		else
			var_0_3:createInstance("nf_map_node"):__resp_MistMoveResp_close(arg_26_1)
		end
	end

	function arg_1_0:get_instructions_mist_guide_state()
		return self._mist_info_data.guide
	end

	function arg_1_0:get_mist_bigmap_info()
		return self._mist_big_map_info
	end

	function arg_1_0:__mistinfo__update_info(arg_29_1)
		self._mist_big_map_info[arg_29_1.id] = arg_29_1
	end

	function arg_1_0:__mistinfo__add_info(arg_30_1)
		self._mist_big_map_info[arg_30_1.id] = arg_30_1
	end

	function arg_1_0:__smistinfo__remove_info(arg_31_1)
		self._mist_big_map_info[arg_31_1.id] = nil
	end

	function arg_1_0.set_mist_now_big_map(arg_32_0, arg_32_1)
		arg_32_0._now_big_map_level = arg_32_1
	end

	function arg_1_0:get_mist_now_map_level()
		return self._now_big_map_level
	end

	function arg_1_0:set_mist_open_sixth_select_and_buff(arg_34_1)
		var_0_6:setDataByID("open_mist_select_and_buff", self:get_account_id(), arg_34_1)
	end

	function arg_1_0:get_mist_open_sixth_select_and_buff()
		return var_0_6:getDataByID("open_mist_select_and_buff", (self:get_account_id()))
	end

	function arg_1_0.set_mist_repeat_map_id(arg_36_0, arg_36_1)
		arg_36_0._repeat_id = arg_36_1
	end

	function arg_1_0:get_mist_repeat_map_id()
		return self._repeat_id
	end

	function arg_1_0.set_select_into_nf(arg_38_0, arg_38_1)
		arg_38_0._now_into_nf_select = arg_38_1
	end

	function arg_1_0:get_select_into_nf()
		return self._now_into_nf_select
	end

	function arg_1_0.set_mist_bgm(arg_40_0, arg_40_1)
		arg_40_0._now_nf_bg = arg_40_1
	end

	function arg_1_0:get_mist_bgm()
		return self._now_nf_bg
	end

	function arg_1_0.set_mist_pass_id(arg_42_0, arg_42_1)
		arg_42_0._now_pass_id = arg_42_1
	end

	function arg_1_0:get_mist_pass_id()
		return self._now_pass_id
	end

	function arg_1_0.set_mist_pass_rank(arg_44_0, arg_44_1)
		arg_44_0._now_pass_rank = arg_44_1
	end

	function arg_1_0:get_mist_pass_rank()
		return self._now_pass_rank
	end

	function arg_1_0.set_to_nf_fight_map(arg_46_0, arg_46_1)
		arg_46_0._now_into_nf_fight_map = arg_46_1
	end

	function arg_1_0:get_to_nf_fight_map()
		return self._now_into_nf_fight_map
	end

	function arg_1_0.set_boss_point_is_fail(arg_48_0, arg_48_1)
		arg_48_0._now_boss_fail = arg_48_1
	end

	function arg_1_0:get_boss_point_is_fail()
		return self._now_boss_fail
	end
end

function var_0_0.extend_obj(arg_50_0)
	arg_50_0._now_into_nf_select = false
	arg_50_0._mist_clear_bigmap_info = {}
	arg_50_0._mist_award_data = {}
	arg_50_0._mist_info_data = {}
	arg_50_0._now_big_map_level = nil
	arg_50_0._mist_big_map_info = {}
	arg_50_0._mist_pass_point_with_grade = nil
	arg_50_0._mist_prepare_team_detail_data = {}
end

return var_0_0
