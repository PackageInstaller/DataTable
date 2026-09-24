local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.error_type
local var_0_3 = gamecore.prompt
local var_0_4 = gamecore.Language
local var_0_5 = gamecore.user
local var_0_6 = gameenum.common_type
local var_0_11 = gameconfig.chat_head_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.NinthBuyResp(arg_2_0, arg_2_1)
		if arg_2_1.result == 0 then
			local var_2_0 = var_0_1:getInstance("ninth_cia")

			if var_2_0 then
				var_2_0:__init_panel()
			end
		end
	end

	function arg_1_0.NinthResetBuyResp(arg_3_0, arg_3_1)
		if arg_3_1.result == 0 then
			local var_3_0 = var_0_1:getInstance("ninth_cia")

			if var_3_0 then
				var_3_0:__init_panel()
				var_0_3:show(var_0_4:getNowLang("ui_4th_buff_reset_tip"))
			end
		end
	end

	function arg_1_0:NinthGetAwardResp(arg_4_1)
		if arg_4_1.result == 0 then
			local var_4_0 = var_0_1:getInstance("ninth_awardbox")
			local var_4_1 = {}
			local var_4_2 = {}
			local var_4_3 = {}

			for iter_4_0 = 1, #arg_4_1.reward do
				if arg_4_1.reward[iter_4_0].type ~= 4 then
					if arg_4_1.reward[iter_4_0].type == 1 then
						var_4_2 = {
							is_new = true,
							count = 1,
							type = 1,
							id = arg_4_1.reward[iter_4_0].id
						}
					elseif self:__check_award_type(arg_4_1.reward[iter_4_0].id) == "picture" then
						var_0_1:createInstance("reward_tip"):show_by_enter_type(nil, var_0_6.enter_icon_detail_type.picture_panel, nil, arg_4_1.reward[iter_4_0].id)

						break
					elseif self:__check_award_type(arg_4_1.reward[iter_4_0].id) == "icon" then
						var_0_1:createInstance("reward_tip"):show_by_enter_type(var_0_11.find_object_by_cid(arg_4_1.reward[iter_4_0].id).icon, var_0_6.enter_get_ship_type.task_award)
					elseif self:__check_award_type(arg_4_1.reward[iter_4_0].id) == "item" or self:__check_award_type(arg_4_1.reward[iter_4_0].id) == "collection" then
						table.insert(var_4_1, {
							is_new = false,
							type = 2,
							id = arg_4_1.reward[iter_4_0].id,
							count = arg_4_1.reward[iter_4_0].count
						})
					end
				end
			end

			for iter_4_1 = 1, #arg_4_1.reward do
				if arg_4_1.reward[iter_4_1].type == 4 then
					local var_4_4 = var_0_5:find_character_by_id(arg_4_1.reward[iter_4_1].id)

					var_4_3 = {
						is_new = true,
						count = 1,
						type = 4,
						id = arg_4_1.reward[iter_4_1].id
					}
				end
			end

			if var_4_1 and next(var_4_1) then
				var_0_1:createInstance("mail_box"):show(var_4_1)
			end

			if var_4_3 and next(var_4_3) then
				var_0_1:createInstance("new_ship_or_equip"):show(true, var_4_3, var_0_6.enter_get_ship_type.sign_and_task)
			elseif var_4_2 and next(var_4_2) then
				local var_4_5 = var_0_1:createInstance("new_equip_only")

				var_4_5:show(true, var_4_2, var_0_6.enter_get_ship_type.sign_and_task)
				var_4_5:setVisible(true)
			end

			var_4_0:__update_award_cell()

			local var_4_6 = var_0_1:getInstance("ninth_main_map")

			if var_4_6 then
				var_4_6:_show_reward_red_point()
			end
		else
			var_0_3:show(var_0_2:get_err_msg(arg_4_1.result))
		end
	end

	function arg_1_0.NinthRemindResp(arg_5_0)
		return
	end

	function arg_1_0.NinthGuideResp(arg_6_0)
		return
	end

	function arg_1_0.NinthEnterMapResp(arg_7_0, arg_7_1)
		if arg_7_1.result == 0 then
			local var_7_0 = var_0_1:getInstance("fight_prepare")

			if var_7_0 then
				var_7_0:enter_map_resp()
				var_0_1:destroyInstance("fight_prepare")
			else
				var_0_1:createInstance("fight_prepare"):enter_map_resp()
			end
		else
			var_0_3:show(var_0_2:get_err_msg(arg_7_1.result))
		end
	end

	function arg_1_0:NinthMapMoveResp(arg_8_1)
		if arg_8_1.result == 0 then
			self._map_data.map_move = arg_8_1

			if arg_8_1.result == 0 then
				var_0_1:getInstance("fight_info"):__map_move_response(arg_8_1)
			else
				var_0_3:show(var_0_2:get_err_msg(arg_8_1.result))
			end
		end
	end

	function arg_1_0.NinthQuitMapResp(arg_9_0)
		return
	end

	function arg_1_0.NinthMaxScoreLevelPassResp(arg_10_0)
		return
	end

	function arg_1_0.__check_award_type(arg_11_0, arg_11_1)
		if arg_11_1 % 100 == 21 then
			return "equipment"
		elseif arg_11_1 % 100 == 11 or arg_11_1 % 100 == 12 or arg_11_1 % 100 == 13 then
			return "ship"
		elseif arg_11_1 % 100 == 61 then
			return "icon"
		elseif arg_11_1 % 100 == 81 then
			return "picture"
		elseif arg_11_1 % 100 == 43 then
			return "collection"
		else
			return "item"
		end
	end
end

function var_0_0.extend_obj(arg_12_0)
	return
end

return var_0_0
