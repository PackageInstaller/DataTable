local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.prompt
local var_0_3 = table.insert
local var_0_4 = gamecore.Language
local var_0_5 = gamecore.UILoader
local var_0_7 = gameenum.error_type
local var_0_8 = gameenum.common_type
local var_0_9 = gameconfig.chat_head_config
local var_0_10 = gameconfig.pve_score_award_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:AnswerBuyResp(arg_2_1)
		if arg_2_1.result == 0 then
			local var_2_0 = var_0_5:getInstance("score_cia")

			if var_2_0 then
				var_2_0._score_map_buff_list = self:get_score_map_buff_list()

				var_2_0:after_buy_succeed_update()
				var_0_2:show(var_0_4:getNowLang("settingcouponsuccess"))
			else
				var_0_2:show(var_0_4:getNowLang("settingcouponfail"))
			end
		end
	end

	function arg_1_0.AnswerResetBuyResp(arg_3_0, arg_3_1)
		if arg_3_1.result == 0 then
			local var_3_0 = var_0_5:getInstance("score_cia")

			if var_3_0 then
				var_3_0:after_reset_succeed_update()
				var_0_2:show(var_0_4:getNowLang("ui_4th_buff_reset_tip"))
			end
		else
			var_0_2:show(var_0_7:get_err_msg(arg_3_1.result))
		end
	end

	function arg_1_0:AnswerQuestionResp(arg_4_1)
		if arg_4_1.result == 0 then
			local var_4_0 = var_0_5:getInstance("score_push")
			local var_4_1 = var_0_5:getInstance("score_push_map")

			if var_4_0 then
				var_4_0:_update_answer_select(var_4_0._pos_id)

				var_4_0._next_answer = true

				if var_4_0._pos_id == #self._score_question_team then
					var_4_0._control.awardbox_bg.down.confirm:SetActive(false)
					var_4_0._control.awardbox_bg.down.next_btn:SetActive(false)
				else
					var_4_0._control.awardbox_bg.down.confirm:SetActive(false)
					var_4_0._control.awardbox_bg.down.next_btn:SetActive(true)
					var_4_0:set_is_next_answer()
				end
			end

			if var_4_1 then
				var_4_1:get_answer_all_score()
			end
		else
			var_0_2:show(var_0_7:get_err_msg(arg_4_1.result))
		end
	end

	function arg_1_0.AnswerEnterMapResp(arg_5_0, arg_5_1)
		if arg_5_1.result == 0 then
			local var_5_0 = var_0_5:getInstance("fight_prepare")

			if var_5_0 then
				var_5_0:enter_map_resp()
				var_0_5:destroyInstance("fight_prepare")
			else
				var_0_5:createInstance("fight_prepare"):enter_map_resp()
			end
		else
			var_0_2:show(var_0_7:get_err_msg(arg_5_1.result))
		end
	end

	function arg_1_0:AnswerMoveMapResp(arg_6_1)
		self._map_data.map_move = arg_6_1

		if arg_6_1.result == 0 then
			var_0_5:createInstance("fight_info"):__map_move_response(arg_6_1)
		else
			var_0_2:show(var_0_7:get_err_msg(arg_6_1.result))
		end
	end

	function arg_1_0.AnswerQuitMapResp(arg_7_0)
		return
	end

	function arg_1_0.__check_award_type(arg_8_0, arg_8_1)
		if arg_8_1 % 100 == 21 then
			return "equipment"
		elseif arg_8_1 % 100 == 11 or arg_8_1 % 100 == 12 or arg_8_1 % 100 == 13 then
			return "ship"
		elseif arg_8_1 % 100 == 61 then
			return "icon"
		elseif arg_8_1 % 100 == 81 then
			return "picture"
		elseif arg_8_1 % 100 == 43 then
			return "collection"
		else
			return "item"
		end
	end

	function arg_1_0:AnswerGetAwardResp(arg_9_1)
		if arg_9_1.result == 0 then
			local var_9_0 = var_0_5:getInstance("answer_award")

			var_9_0:__update_award_cell()

			local var_9_1, var_9_2 = var_0_10.get_sequence()
			local var_9_3 = var_0_5:createInstance("new_ship_or_equip")
			local var_9_4 = {}

			if var_0_5:getInstance("mail_box") then
				var_0_5:destroyInstance("mail_box")
			end

			for iter_9_0, iter_9_1 in pairs(var_9_1[var_9_0:get_now_award()].award) do
				if self:__check_award_type(iter_9_1.id) == "equipment" then
					var_9_3:show(true, {
						is_new = true,
						count = 1,
						type = 1,
						id = iter_9_1.id
					}, var_0_8.enter_get_ship_type.combats_shop)

					break
				elseif self:__check_award_type(iter_9_1.id) == "ship" then
					self.ship_data = var_0_1:get_new_ship_info()

					var_9_3:show(true, {
						is_new = true,
						count = 1,
						type = 4,
						id = self.ship_data[1].info.id
					}, var_0_8.enter_get_ship_type.sign_and_task)

					break
				elseif self:__check_award_type(iter_9_1.id) == "picture" then
					var_0_5:createInstance("reward_tip"):show_by_enter_type(nil, var_0_8.enter_icon_detail_type.picture_panel, nil, iter_9_1.id)
				elseif self:__check_award_type(iter_9_1.id) == "icon" then
					var_0_5:createInstance("reward_tip"):show_by_enter_type(var_0_9.find_object_by_cid(iter_9_1.id).icon, var_0_8.enter_get_ship_type.task_award)
				elseif self:__check_award_type(iter_9_1.id) == "item" or self:__check_award_type(iter_9_1.id) == "collection" then
					var_0_3(var_9_4, {
						is_new = false,
						type = 2,
						id = iter_9_1.id,
						count = iter_9_1.count
					})
				end
			end

			var_0_5:createInstance("mail_box"):show(var_9_4)
			var_9_0:__init_data()
		else
			var_0_2:show(var_0_7:get_err_msg(arg_9_1.result))
		end
	end

	function arg_1_0:AnswerRemindResp(arg_10_1)
		if arg_10_1.result == 0 then
			local var_10_0 = var_0_5:getInstance("score_push_map")

			if var_10_0 and arg_10_1.remind == true then
				if #self:get_score_question_team() > 0 then
					var_10_0:__show_answer_question_panel()
				end
			elseif var_10_0 and not arg_10_1.remind then
				var_10_0:__show_answer_question_point()
			end
		end
	end

	function arg_1_0:AnswerGuideResp(arg_11_1)
		if arg_11_1.result == 0 then
			var_0_5:getInstance("score_push_map"):__tween_score_guide_ainimation_2(true)
		else
			local var_11_0 = var_0_5:getInstance("score_push_map")

			self:req_AnswerRemindReq()
		end
	end

	function arg_1_0.AnswerMaxScoreLevelPassResp(arg_12_0)
		return
	end
end

function var_0_0.extend_obj(arg_13_0)
	return
end

return var_0_0
