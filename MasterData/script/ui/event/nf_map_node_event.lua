local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_5 = gamecore.Language
local var_0_6 = gameconfig.sixth_adjutant_config
local var_0_7 = lan_rand
local var_0_8 = DG.Tweening.DOTween
local var_0_9 = gamecore.prompt

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.__onClick_bg(arg_2_0)
		return
	end

	function arg_1_0.__onPointerDown_bg(arg_3_0)
		return
	end

	function arg_1_0.__onPointerUp_bg(arg_4_0)
		return
	end

	function arg_1_0.__onPointerClick_bg(arg_5_0)
		return
	end

	function arg_1_0.__onClick_return_btn(arg_6_0)
		local var_6_0 = var_0_2:createInstance("msgbox")

		arg_6_0._msgbox = var_6_0

		var_6_0:show(var_0_5:getNowLang("ui_combat_return_tip"), function()
			var_0_1:set_to_nf_fight_map(false)

			arg_6_0._msgbox._control.main.confirm.text.text.text = var_0_5:getNowLang("ui_cbtn1")
			arg_6_0._msgbox._control.main.back.text.text.text = var_0_5:getNowLang("ui_cbtn2")

			arg_6_0._msgbox._control.main.close.gameObject:SetActive(false)
			arg_6_0:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))
			var_0_1:set_can_show(true)
			arg_6_0:__close_panel()
		end, function()
			var_0_1:set_to_nf_fight_map(false)

			arg_6_0._msgbox._control.main.confirm.text.text.text = var_0_5:getNowLang("ui_cbtn1")
			arg_6_0._msgbox._control.main.back.text.text.text = var_0_5:getNowLang("ui_cbtn2")

			arg_6_0._msgbox._control.main.close.gameObject:SetActive(false)
			var_0_1:set_can_show(true)
			var_0_1:req_MistQuitMapReq()
			arg_6_0:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.back))
		end, var_0_5:getNowLang("sure_exit"), nil, nil, true)

		var_6_0._control.main.confirm.text.text.text = var_0_5:getNowLang("activityholdon")
		var_6_0._control.main.back.text.text.text = var_0_5:getNowLang("ui_combat_return")

		var_6_0._control.main.close.gameObject:SetActive(true)
	end

	function arg_1_0:__onClick_left_people()
		local var_9_0 = var_0_6.find_object_by_id(var_0_1:get_mist_combat_info().adjutant.id)
		local var_9_2 = var_0_7(1, #var_9_0.touch_dialogue)

		if self._control.left_people.talk.activeSelf and self._model_talk_seq then
			if self._model_talk_seq:IsPlaying() then
				self._model_talk_seq:Pause()
				self._model_talk_seq:Kill()
				self._control.left_people.talk.popVerticalAdaptive:SetText("")

				self._control.left_people.talk.label_txt.text.text = ""
			end

			self._control.left_people.talk.gameObject:SetActive(false)
			self._model_talk_seq:Append(self._control.left_people.talk.canvasGroup:DOFade(0, 0.3))
		end

		local var_9_3 = var_9_0.touch_dialogue[var_9_2]

		if var_9_0.touch_dialogue[var_9_2] == "" then
			return
		end

		self._control.left_people.talk.popVerticalAdaptive:SetText(var_9_3)

		self._control.left_people.talk.label_txt.text.text = ""
		self._model_talk_seq = self:autoKillDOTween(var_0_8.Sequence())

		self._control.left_people.talk.gameObject:SetActive(true)
		self._model_talk_seq:AppendInterval(0.2)
		self._model_talk_seq:Append(self._control.left_people.talk.canvasGroup:DOFade(1, 0.3))
		self._model_talk_seq:Append(self._control.left_people.talk.label_txt.text:DOText(var_9_3, #var_9_3 * 0.025):SetEase(DG.Tweening.Ease.Linear))
		self._model_talk_seq:AppendInterval(#var_9_3 * 0.03 + 3)
		self._model_talk_seq:Append(self._control.left_people.talk.canvasGroup:DOFade(0, 0.5):OnComplete(function()
			self._model_talk_seq:Kill()

			self._model_talk_seq = nil
		end))
		self._model_talk_seq:OnKill(function()
			self._control.left_people.talk.popVerticalAdaptive:SetText("")

			if not self._control.left_people.talk.label_txt:Equals(nil) then
				self._control.left_people.talk.label_txt.text.text = ""
			end
		end)
		self._model_talk_seq:Play()
	end

	function arg_1_0.__onClick_left_bg_icon(arg_12_0)
		if var_0_1:get_mist_combat_info().adjutant.skill_count == 0 then
			var_0_1:req_MistUseAdjutantSkillReq()
		else
			var_0_9:show(var_0_5:getNowLang("sixth_skill_over_use"))
		end
	end

	function arg_1_0:__onLongClick_left_bg_icon()
		self._control.left_bg.icon.skill_trans:SetActive(true)
		var_0_2:getInstance("nf_map_node"):set_skill_info()
	end

	function arg_1_0:__onPointerUp_left_bg_icon()
		if self._control.left_bg.icon.skill_trans.activeSelf then
			self._control.left_bg.icon.skill_trans:SetActive(false)
		end
	end

	function arg_1_0:__onClick_left_bg_icon_skill_trans()
		if self._control.left_bg.icon.skill_trans.activeSelf then
			self._control.left_bg.icon.skill_trans:SetActive(false)
		end
	end

	function arg_1_0.__onClick_left_bg_buy_btn(arg_16_0)
		local var_16_0 = var_0_1:get_mist_combat_info()

		if var_16_0.coin < var_0_4.sixth_exp_price then
			var_0_9:show(var_0_5:getNowLang("coin_notenough"))
		elseif var_16_0.adjutant.level >= #var_0_4.sixth_adjutant_exp then
			var_0_9:show(var_0_5:getNowLang("adjutant_full_level"))
		else
			var_0_1:req_MistBuyAdjutantExpReq()
		end
	end

	function arg_1_0.__onClick_buff_btn(arg_17_0)
		return
	end

	function arg_1_0:__onClick_right_bg_select_team_btn()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.back))
		self:setVisible(false)
		var_0_2:destroyInstance("nf_map_node")

		local var_18_0 = var_0_2:getInstance("nf_main_interface")

		if var_18_0 then
			var_18_0:setVisible(false)
		end

		var_0_2:createInstance("fight_prepare"):show({
			fight_prepare_type = var_0_4.fight_type.mist_attack,
			mist_map = self._data.id,
			bg_pos = self._control.bg.rectTransform.anchoredPosition3D
		})
	end

	function arg_1_0:__onClick_right_bg_goto_btn()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.begin_to_fight))

		if self._cur_fight_point then
			local var_19_0 = var_0_1:get_mist_combat_info()

			if var_19_0.members and next(var_19_0.members) then
				var_0_1:set_back_type(var_0_4.select_back_type.mist_fight)
				self:goto_mist_scene()
			else
				var_0_9:show(var_0_5:getNowLang("not_ship"))
			end
		end
	end

	function arg_1_0:__onClick_select_node_layer_node_trans_select_1()
		self:__click_select_point(1)
	end

	function arg_1_0:__onClick_select_node_layer_node_trans_select_2()
		self:__click_select_point(2)
	end

	function arg_1_0:__onClick_select_node_layer_node_trans_select_3()
		self:__click_select_point(3)
	end

	function arg_1_0:__onClick_select_node_layer_select_node_btn()
		if self._select_node_btn_index then
			var_0_1:req_MistMoveReq(self._next_node_point[self._select_node_btn_index])
		end
	end

	function arg_1_0:__onClick_input_node_enter()
		local var_24_0 = self:get_input_map_node()

		if var_24_0 == 0 then
			return
		end

		self._cur_next_node = var_24_0

		var_0_1:req_MistMoveReq(var_24_0)
	end

	function arg_1_0:__onClick_six_msgbox_main_left()
		self._control.six_msgbox.main.left.light:SetActive(true)
		self._control.six_msgbox.main.left.select:SetActive(true)
		self._control.six_msgbox.main.right.light:SetActive(false)
		self._control.six_msgbox.main.right.select:SetActive(false)
		self:select_msgbox(true)
	end

	function arg_1_0:__onClick_six_msgbox_main_right()
		self._control.six_msgbox.main.left.light:SetActive(false)
		self._control.six_msgbox.main.left.select:SetActive(false)
		self._control.six_msgbox.main.right.light:SetActive(true)
		self._control.six_msgbox.main.right.select:SetActive(true)
		self:select_msgbox(false)
	end

	function arg_1_0.__onClick_six_msgbox_select_msg_btn(arg_27_0)
		return
	end

	function arg_1_0.__onClick_activity_select_two_buff_bg(arg_28_0)
		return
	end

	function arg_1_0.__onClick_activity_select_two_buff_buff_array_buff_1(arg_29_0)
		return
	end

	function arg_1_0.__onClick_activity_select_two_buff_buff_array_buff_1_bottom_change(arg_30_0)
		return
	end

	function arg_1_0.__onClick_activity_select_two_buff_buff_array_buff_2(arg_31_0)
		return
	end

	function arg_1_0.__onClick_activity_select_two_buff_buff_array_buff_2_bottom_change(arg_32_0)
		return
	end

	function arg_1_0.__onClick_activity_select_two_buff_buff_array_buff_3(arg_33_0)
		return
	end

	function arg_1_0.__onClick_activity_select_two_buff_buff_array_buff_3_bottom_change(arg_34_0)
		return
	end

	function arg_1_0.__onClick_activity_select_two_buff_bottom_refresh_btn(arg_35_0)
		return
	end

	function arg_1_0.__onClick_activity_select_two_buff_bottom_confirm_btn(arg_36_0)
		return
	end

	function arg_1_0.__onClick_activity_select_two_buff_bottom_close(arg_37_0)
		return
	end

	function arg_1_0.__onClick_activity_select_two_buff_bottom_confirm(arg_38_0)
		return
	end
end

function var_0_0.extend_obj(arg_39_0)
	return
end

return var_0_0
