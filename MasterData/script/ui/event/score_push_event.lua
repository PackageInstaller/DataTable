local var_0_0 = {}
local var_0_1 = gamecore.prompt
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.user
local var_0_4 = gamecore.UILoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_awardbox_bg_top_toptitle_back_btn()
		self._select_answer_id = nil

		self:setVisible(false)

		local var_2_0 = var_0_4:getInstance("score_push_map")

		if var_2_0 then
			var_2_0:setVisible(true)
			var_2_0:__show_answer_question_point()
			var_2_0:__show_answer_award_tips()
		else
			local var_2_1 = var_0_4:createInstance("score_push_map")

			var_2_1:show()
			var_2_1:__show_answer_question_point()
		end
	end

	function arg_1_0:__onClick_awardbox_bg_down_up_btn()
		self._select_answer_id = nil
		self._pos_id = self._pos_id - 1

		if self._pos_id <= 1 then
			self._control.awardbox_bg.down.up_btn:SetActive(false)

			self._opean_up_btn = false
			self._pos_id = 1
		end

		self._control.top_titile:SetActive(true)
		self._control.awardbox:SetActive(true)
		self._control.interpretation:SetActive(false)

		if var_0_3:get_score_question_team()[self._pos_id].state == 2 then
			self:set_panel_select_btn(false)
		else
			self:set_panel_select_btn(true)
		end

		self:_update_have_answer_question(self._pos_id)
		self._control.awardbox_bg.down.confirm:SetActive(false)
		self._control.awardbox_bg.down.next_btn:SetActive(true)
	end

	function arg_1_0:__onClick_awardbox_bg_down_confirm()
		if self._select_answer_id and next(self._select_answer_id) then
			self:set_panel_select_btn(false)
			var_0_3:req_AnswerQuestionReq(self._pos_id, self._select_answer_id)
		else
			var_0_1:show((var_0_2:getNowLang("not_answer")))
		end
	end

	function arg_1_0.__onLongClick_awardbox_bg_down_up_btn(arg_5_0)
		arg_5_0._opean_up_btn = true
	end

	function arg_1_0:__onClick_awardbox_bg_down_next_btn()
		self._pos_id = self._pos_id + 1

		local var_6_0 = var_0_3:get_score_question_team()

		if self._pos_id >= #var_6_0 then
			self._pos_id = #var_6_0
		end

		local var_6_1 = var_6_0[self._pos_id].state

		self._is_start_time = false

		self._control.top_titile:SetActive(true)
		self._control.awardbox:SetActive(true)
		self._control.interpretation:SetActive(false)

		if var_6_1 == 1 then
			self._select_answer_id = nil
			self._next_answer = false

			self:_init_answer_select()
			self._control.top_titile:SetActive(true)
			self._control.awardbox:SetActive(true)
			self._control.interpretation:SetActive(false)
			self:update_answer_data(self._pos_id)
			self:set_panel_select_btn(self._answer_state)
			self._control.awardbox_bg.down.confirm:SetActive(true)
			self._control.awardbox_bg.down.next_btn:SetActive(false)

			return
		end

		if var_6_1 == 2 then
			self._control.awardbox_bg.down.up_btn:SetActive(true)
			self._control.top_titile:SetActive(true)
			self._control.awardbox:SetActive(true)
			self._control.interpretation:SetActive(false)
			self:_update_have_answer_question(self._pos_id)
			self:set_panel_select_btn(false)

			if self._pos_id == #var_6_0 and var_6_1 == 2 then
				self._control.awardbox_bg.down.confirm:SetActive(false)
				self._control.awardbox_bg.down.next_btn:SetActive(false)
			end

			return
		end

		if self._pos_id > self._say_num then
			self:_init_answer_select()
			self:update_answer_data(self._pos_id)
			self:set_panel_select_btn(true)
			self._control.awardbox_bg.down.confirm:SetActive(true)
			self._control.awardbox_bg.down.next_btn:SetActive(false)
		end
	end

	function arg_1_0:__onClick_awardbox_bg_down_interpretation_btn()
		self._control.top_titile:SetActive(false)
		self._control.awardbox:SetActive(false)
		self._control.interpretation:SetActive(true)
	end

	function arg_1_0:__onClick_interpretation_interpretation_confirm()
		self._control.top_titile:SetActive(true)
		self._control.awardbox:SetActive(true)
		self._control.interpretation:SetActive(false)
	end
end

function var_0_0.extend_obj(arg_9_0)
	return
end

return var_0_0
