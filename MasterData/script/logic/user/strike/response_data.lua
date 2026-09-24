local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_3 = gamecore.prompt
local var_0_5 = table.insert
local var_0_6 = gamecore.UILoader
local var_0_8 = gameenum.error_type
local var_0_9 = gameenum.common_type
local var_0_11 = gameconfig.chat_head_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.SolidEnterMapResp(arg_2_0, arg_2_1)
		if arg_2_1.result == 0 then
			var_0_6:destroyInstance("fight_prepare")

			local var_2_0 = var_0_6:createInstance("strike_map")

			var_2_0:set_show_lock(true)
			var_2_0:show(var_0_1:get_strike_point_info().id)
		else
			var_0_3:show(var_0_8:get_err_msg(arg_2_1.result))
		end
	end

	function arg_1_0.__check_award_type(arg_3_0, arg_3_1)
		if arg_3_1 % 100 == 21 then
			return "equipment"
		elseif arg_3_1 % 100 == 11 or arg_3_1 % 100 == 12 or arg_3_1 % 100 == 13 then
			return "ship"
		elseif arg_3_1 % 100 == 61 then
			return "icon"
		elseif arg_3_1 % 100 == 81 then
			return "picture"
		elseif arg_3_1 % 100 == 43 then
			return "collection"
		else
			return "item"
		end
	end

	function arg_1_0:SolidGetAwardResp(arg_4_1)
		if arg_4_1.result == 0 then
			local var_4_0 = var_0_6:getInstance("strike_awardbox")
			local var_4_1 = {}
			local var_4_2 = {}
			local var_4_3 = {}

			for iter_4_0 = 1, #arg_4_1.reward do
				if arg_4_1.reward[iter_4_0].type ~= 4 then
					if arg_4_1.reward[iter_4_0].type == 1 then
						var_4_2 = {
							count = 1,
							type = 1,
							id = arg_4_1.reward[iter_4_0].id,
							is_new = arg_4_1.reward[iter_4_0].is_new
						}
					elseif self:__check_award_type(arg_4_1.reward[iter_4_0].id) == "picture" then
						var_0_6:createInstance("reward_tip"):show_by_enter_type(nil, var_0_9.enter_icon_detail_type.picture_panel, nil, arg_4_1.reward[iter_4_0].id)

						break
					elseif self:__check_award_type(arg_4_1.reward[iter_4_0].id) == "icon" then
						var_0_6:createInstance("reward_tip"):show_by_enter_type(var_0_11.find_object_by_cid(arg_4_1.reward[iter_4_0].id).icon, var_0_9.enter_get_ship_type.task_award)
					elseif self:__check_award_type(arg_4_1.reward[iter_4_0].id) == "item" or self:__check_award_type(arg_4_1.reward[iter_4_0].id) == "collection" then
						var_0_5(var_4_1, {
							is_new = false,
							type = 2,
							id = arg_4_1.reward[iter_4_0].id,
							count = arg_4_1.reward[iter_4_0].count
						})
					end
				end
			end

			local function var_4_4()
				if var_4_1 and next(var_4_1) then
					var_0_6:createInstance("mail_box"):show(var_4_1)
				end

				if var_4_2 and next(var_4_2) then
					local var_5_0 = var_0_6:createInstance("new_equip_only")

					var_5_0:show(true, var_4_2, var_0_9.enter_get_ship_type.combats_shop)
					var_5_0:setVisible(true)
				end

				if var_0_6:getInstance("cinema_cg_info") then
					local var_5_1 = var_0_6:createInstance("mail_box")

					if var_5_1 then
						var_5_1:setVisible(false)
					end
				end
			end

			for iter_4_1 = 1, #arg_4_1.reward do
				if arg_4_1.reward[iter_4_1].type == 4 then
					local var_4_5 = var_0_1:find_character_by_id(arg_4_1.reward[iter_4_1].id)

					var_0_5(var_4_3, {
						count = 1,
						type = 4,
						id = arg_4_1.reward[iter_4_1].id,
						is_new = arg_4_1.reward[iter_4_1].is_new
					})
				end
			end

			if var_4_3 and next(var_4_3) then
				var_0_6:createInstance("new_ship_or_equip"):show(true, var_4_3, var_0_9.enter_get_ship_type.combats_shop, var_4_4)
			else
				if var_4_1 and next(var_4_1) then
					var_0_6:createInstance("mail_box"):show(var_4_1)
				end

				if var_4_2 and next(var_4_2) then
					local var_4_6 = var_0_6:createInstance("new_equip_only")

					var_4_6:show(true, var_4_2, var_0_9.enter_get_ship_type.combats_shop)
					var_4_6:setVisible(true)
				end
			end

			var_4_0:__update_cell()

			local var_4_7 = var_0_6:getInstance("strike_main")

			if var_4_7 then
				var_4_7:update_reward()
			end
		end
	end

	function arg_1_0:SolidEnterPointResp(arg_6_1)
		if arg_6_1.result == 0 then
			self:set_strike_battle_data(arg_6_1)

			if arg_6_1.result == 0 then
				local var_6_0 = {}

				for iter_6_0, iter_6_1 in pairs(self._strike_team_data) do
					var_0_5(var_6_0, (self:find_character_by_id(iter_6_1)))
				end

				var_0_6:createInstance("campaign_select"):show(arg_6_1, var_0_9.select_prepare_type.strike, var_6_0)
			end
		else
			var_0_3:show(var_0_8:get_err_msg(arg_6_1.result))
		end

		local var_6_1 = var_0_6:getInstance("strike_map")

		if var_6_1 then
			var_6_1:set_can_click(true)
		end
	end

	function arg_1_0.SolidSaveTeamResp(arg_7_0, arg_7_1)
		if arg_7_1.result == 0 then
			local var_7_0 = var_0_6:getInstance("fight_prepare")

			if var_7_0 then
				var_7_0:refresh_strike_info_list()
			end

			local var_7_1 = var_0_6:getInstance("pre_formation")

			if var_7_1 then
				var_7_1:refresh_info_list()
			end
		else
			var_0_3:show(var_0_8:get_err_msg(arg_7_1.result))
		end
	end

	function arg_1_0.SolidQuitMapResp(arg_8_0, arg_8_1)
		if arg_8_1.result == 0 then
			var_0_6:destroyInstance("fight_prepare")

			local var_8_0 = var_0_6:getInstance("strike_map")

			if var_8_0 then
				var_8_0:__destroy_pool()
			end

			var_0_6:destroyInstance("strike_map")

			if var_0_6:getInstance("strike_weather") then
				var_0_6:destroyInstance("strike_weather")
			end

			local var_8_1 = var_0_6:getInstance("home"):get_strike_info_id()
			local var_8_2 = var_0_6:createInstance("strike_main")

			if var_8_2 then
				var_8_2:show(var_0_1:get_strike_cur_page_index(), var_8_1)
			end

			var_0_1:set_return_type(false)
		else
			var_0_3:show(var_0_8:get_err_msg(arg_8_1.result))
		end
	end

	function arg_1_0.SoildChooseBuffResp(arg_9_0, arg_9_1)
		if arg_9_1.result == 0 then
			-- block empty
		end
	end

	function arg_1_0.SolidExtendBuffStatusResp(arg_10_0, arg_10_1)
		if arg_10_1 and arg_10_1.result and arg_10_1.result == 0 then
			var_0_6:getInstance("strike_main"):update_cell()
		end
	end

	function arg_1_0.SolidExtendBuffNumResp(arg_11_0, arg_11_1)
		if arg_11_1 and arg_11_1.result and arg_11_1.result == 0 then
			-- block empty
		end
	end

	function arg_1_0.SolidInitBattleDataResp(arg_12_0, arg_12_1)
		if arg_12_1 and arg_12_1.result and arg_12_1.result == 0 then
			-- block empty
		end
	end

	function arg_1_0.SolidMaxScoreLevelPassResp(arg_13_0)
		return
	end
end

function var_0_0.extend_obj(arg_14_0)
	return
end

return var_0_0
