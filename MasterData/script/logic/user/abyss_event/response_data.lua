local var_0_0 = {}
local var_0_1 = gamecore.prompt
local var_0_2 = gamecore.Language
local var_0_4 = gameenum.error_type
local var_0_5 = gamecore.UILoader
local var_0_6 = gameconfig.ship_config
local var_0_7 = gameenum.common_type
local var_0_10 = gamecore.util_func
local var_0_11 = gamecore.user
local var_0_14 = gameconfig.abyss_award_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:AbyssSaveTeamResp(arg_2_1)
		if arg_2_1.result == 0 then
			self:__abyss_select_member_func()
			self:__abyss_team__save_team_ok()
		else
			var_0_1:show(var_0_4:get_err_msg(arg_2_1.result))
		end
	end

	function arg_1_0:AbyssAbyssSaveTeamResp(arg_3_1)
		if arg_3_1.result == 0 then
			self:__abyss_select_member_func()
			self:__abyss_team__save_team_ok()
		elseif arg_3_1.result == 6 then
			var_0_1:show(var_0_2:getNowLang("nosameshipinteam"))

			return
		end
	end

	function arg_1_0.AbyssCombineResp(arg_4_0, arg_4_1)
		if arg_4_1.result == 0 then
			var_0_5:destroyInstance("msgbox")
			var_0_5:createInstance("abyss_dock_team"):__response_data_back()

			local var_4_0 = var_0_10.little_clone((var_0_6.find_object_by_cid(var_0_11:find_abyss_character_by_id(arg_4_1.id).cid)))

			var_4_0.is_new = arg_4_1.is_new

			var_0_5:createInstance("new_ship_or_equip"):show(true, {
				data = var_4_0
			}, var_0_7.enter_get_ship_type.abyss_combine_panel)
		else
			var_0_1:show(var_0_4:get_err_msg(arg_4_1.result))
		end
	end

	function arg_1_0.AbyssEvoResp(arg_5_0, arg_5_1)
		local var_5_0 = var_0_5:getInstance("abyss_dock_team")

		if arg_5_1.result == 0 then
			if var_5_0 then
				var_5_0:setVisible(false)
			end

			local var_5_1 = var_5_0:get_evo_data()

			var_5_1.is_new = nil
			var_5_1.is_new = arg_5_1.is_new

			var_0_5:createInstance("new_ship_or_equip"):show(true, {
				data = var_5_1
			}, var_0_7.enter_get_ship_type.abyss_evo_panel)
		else
			var_0_1:show(var_0_4:get_err_msg(arg_5_1.result))
		end
	end

	function arg_1_0.AbyssChooseBuffResp(arg_6_0, arg_6_1)
		if arg_6_1.result == 0 then
			local var_6_0 = var_0_5:getInstance("fight_info")

			if var_6_0 then
				var_6_0:toggle_continue_tip_box(true)
			end
		else
			var_0_1:show(var_0_4:get_err_msg(arg_6_1.result))
		end
	end

	function arg_1_0:AbyssEnterMapResp(arg_7_1)
		if arg_7_1.result == 0 then
			var_0_5:destroyInstance("loading")

			local var_7_0 = var_0_5:createInstance("abyss_event")

			if var_7_0 then
				var_7_0:setVisible(false)
			end

			local var_7_1 = var_0_5:createInstance("fight_info")

			if var_7_1 then
				local var_7_2 = self:get_abyss_fight_info_param()

				if not var_7_2 or not next(var_7_2) then
					return
				end

				var_7_1:show(var_7_2)
			end
		else
			var_0_1:show(var_0_4:get_err_msg(arg_7_1.result))
		end
	end

	function arg_1_0:AbyssMoveMapResp(arg_8_1)
		if arg_8_1.result == 0 then
			if self:call_abyss_ship_move_callback() then
				return
			end

			var_0_5:createInstance("fight_info"):__map_move_response(arg_8_1)
		else
			var_0_1:show(var_0_4:get_err_msg(arg_8_1.result))
		end
	end

	function arg_1_0.AbyssGetAwardResp(arg_9_0, arg_9_1)
		if arg_9_1.result == 0 then
			local var_9_0
			local var_9_1 = false
			local var_9_2 = false
			local var_9_3 = 0
			local var_9_4 = false

			for iter_9_0, iter_9_1 in ipairs(arg_9_1.reward) do
				local var_9_5 = var_0_14.get_sequence()

				if iter_9_1.type == 13 then
					local var_9_7 = gameconfig.ship_cg_config.find_object_by_cid(iter_9_1.id)
				end

				if iter_9_1.id % 100 == 81 then
					var_9_1 = true
					arg_9_1.reward = var_9_5[11].award

					break
				elseif iter_9_1.type == 4 then
					local var_9_8 = {}

					for iter_9_2, iter_9_3 in pairs(var_9_5[12].award) do
						if iter_9_3.id ~= 10046711 then
							table.insert(var_9_8, iter_9_3)
						end
					end

					var_9_1 = true
					var_9_2 = true
					var_9_3 = iter_9_1.id
					var_9_4 = iter_9_1.is_new
					arg_9_1.reward = var_9_8

					break
				end
			end

			if var_9_1 then
				var_0_5:createInstance("msgbox"):showOnes(arg_9_1.reward, function()
					var_0_5:destroyInstance("msgbox")

					if var_9_2 then
						local var_11_0 = var_0_6.find_object_by_cid(var_0_11:find_character_by_id(var_9_3).cid)

						var_11_0.is_new = var_9_4
						var_11_0.id = var_9_3

						var_0_5:createInstance("new_ship_or_equip"):show(true, {
							data = var_11_0,
							is_new = var_9_4
						}, var_0_7.enter_get_ship_type.abyss_get_awards)
					end

					var_9_0 = var_0_5:getInstance("abyss_quest")

					var_9_0:update_data()
				end, var_0_2:getNowLang("space_confirm"), var_0_2:getNowLang("award_preview"), var_0_7.msg_type.rewards, nil, true, true)
			else
				var_0_5:createInstance("msgbox"):showOnes(arg_9_1.reward, function()
					var_9_0 = var_0_5:getInstance("abyss_quest")

					var_9_0:update_data()

					for iter_10_0, iter_10_1 in ipairs(arg_9_1.reward) do
						if iter_10_1.type == var_0_7.reward_type.equipment then
							var_0_5:createInstance("new_ship_or_equip"):show(true, {
								iter_10_1
							})
						end
					end
				end, var_0_2:getNowLang("ui_okbtntip"), var_0_2:getNowLang("logget"), var_0_7.msg_type.abyss_rewards)
			end
		else
			var_0_1:show(var_0_4:get_err_msg(arg_9_1.result))
		end
	end

	function arg_1_0:AbyssAwardBoxResp(arg_12_1)
		if arg_12_1.result == 0 then
			self:set_award_item_info(arg_12_1.reward)
			self:AbyssAwardBoxRespCallback()
		else
			var_0_1:show(var_0_4:get_err_msg(arg_12_1.result))
		end
	end

	function arg_1_0.__abyss_select_member_func(arg_13_0)
		local var_13_0 = var_0_5:getInstance("abyss_select_member")
		local var_13_1 = var_0_5:getInstance("fight_prepare")

		if var_13_0 then
			var_13_0:setVisible(false)
		end

		if var_13_1 then
			var_13_1:update_abyss_model_team_list(var_13_1:get_curr_content_type(), (var_13_1:get_team_type()))
			var_13_1:__set_total_props_panel_data()
		end
	end

	function arg_1_0:AbyssQuitMapResp(arg_14_1)
		self:set_abyss_fight_cam(nil)
		self:is_abyss_fighting(false)
		self:reset_abyss_fight_start_point()
		self:reset_abyss_enter_repair_time()

		if arg_14_1.result ~= 0 then
			var_0_1:show(var_0_4:get_err_msg(arg_14_1.result))
		end
	end

	function arg_1_0:AbyssBossInfoResp(arg_15_1)
		if arg_15_1.result == 0 then
			self:set_abyss_world_boss_info(arg_15_1.info)
			self:AbyssBossInfoRespCallback()
		end
	end

	function arg_1_0.AbyssGuideResp(arg_16_0, arg_16_1)
		return
	end
end

function var_0_0.extend_obj(arg_17_0)
	return
end

return var_0_0
