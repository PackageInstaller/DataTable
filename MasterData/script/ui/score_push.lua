local var_0_0 = {}
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = gamecore.user
local var_0_5 = gamecore.util_func
local var_0_6 = gameenum.common_type
local var_0_7 = gameconfig.pve_score_answer_config

gamecore.UILoader:define("score_push", function(arg_1_0)
	function arg_1_0:__onUpdate()
		if self._answer_content_cell then
			self._answer_content_cell:update()
		end

		if self._opean_up_btn then
			self:__onClick_awardbox_bg_down_up_btn()
		end

		if self._is_start_time and self._answer_is_right_or_error == false then
			if self._old_time and lx.ServerTime:getUtcTime() >= self._old_time + var_0_6.click_error_next_time then
				self:__onClick_awardbox_bg_down_next_btn()

				self._is_start_time = false
			end
		end
	end

	function arg_1_0:show()
		self:setVisible(true)
		self:__init_language()
		self:__init_panel()
		self:update_answer_data()
	end

	function arg_1_0:__init_panel()
		self:destroyChildren("answer_select")

		self._answer_content_cell = gamecore.reusable_cell:create(self, self._control.awardbox.scrollview.viewport.content.endlessScrollView, self._control.awardbox.scrollview.viewport.content, "answer_select", "score_push")

		self._answer_content_cell:init()
	end

	function arg_1_0:__init_language()
		self._control.awardbox_bg.down.confirm:SetActive(true)
		self._control.awardbox_bg.down.next_btn:SetActive(false)

		self._control.awardbox_bg.top.toptitle.title_txt.text.text = var_0_2:getNowLang("answer")
		self._control.awardbox_bg.top.topdescribe.prestige_bg.prestigedes_text.text.text = var_0_2:getNowLang("score")
		self._control.awardbox_bg.down.up_btn.up_txt.text.text = var_0_2:getNowLang("last_question")
		self._control.awardbox_bg.down.confirm.confirm_txt.text.text = var_0_2:getNowLang("ui_cbtn1")
		self._control.awardbox_bg.down.next_btn.next_txt.text.text = var_0_2:getNowLang("next_question")
		self._control.interpretation.interpretation_tip.text.text = var_0_2:getNowLang("view_explain_title")
		self._control.interpretation.interpretation_confirm.interpretation_confirm_txt.text.text = var_0_2:getNowLang("ensure")

		self._control.top_titile:SetActive(true)
		self._control.awardbox:SetActive(true)
		self._control.interpretation:SetActive(false)
		self._control.awardbox_bg.down.interpretation_btn:SetActive(false)
		self:get_answer_all_score()
	end

	function arg_1_0:get_palyer_answer_data()
		self._say_num = 1

		for iter_6_0, iter_6_1 in ipairs((var_0_4:get_score_question_team())) do
			if iter_6_1.state == 1 then
				return iter_6_1.pos, iter_6_1.id
			end

			self._say_num = self._say_num + 1
		end
	end

	function arg_1_0:update_answer_data(arg_7_1)
		self._pos_id, self._answer_id = self:get_palyer_answer_data()

		local var_7_0 = var_0_4:get_score_question_team()

		if not next(var_7_0) then
			return
		end

		if not self._pos_id then
			self._pos_id = #var_7_0
			self._answer_id = var_7_0[self._pos_id].id
			self._is_last = true
		end

		self._all_question_data = lx.clone_table(var_7_0)

		for iter_7_0, iter_7_1 in ipairs(var_7_0) do
			if self._pos_id == iter_7_1.pos then
				self._answer_state = iter_7_1.state

				if self._answer_state == 1 then
					self._answer_state = true
				elseif self._answer_state == 2 then
					self._answer_state = false
				end

				local var_7_2 = #var_0_7.find_object_by_id(iter_7_1.id).correct_answer
			end
		end

		self._is_more_answer = true

		if arg_7_1 then
			self._pos_id = arg_7_1
		end

		local var_7_3 = var_0_7.find_object_by_id(self._answer_id)

		if self._pos_id <= 1 then
			self._opean_up_btn = false

			self._control.awardbox_bg.down.up_btn:SetActive(false)
		else
			self._control.awardbox_bg.down.up_btn:SetActive(true)
		end

		if arg_7_1 and arg_7_1 < #var_7_0 - self._say_num then
			self._control.awardbox_bg.down.confirm:SetActive(false)
			self._control.awardbox_bg.down.next_btn:SetActive(true)
		else
			self._control.awardbox_bg.down.confirm:SetActive(true)
			self._control.awardbox_bg.down.next_btn:SetActive(false)
		end

		if self._is_last then
			self._control.awardbox_bg.down.confirm:SetActive(false)
		end

		self._control.awardbox_bg.top.toptitle.title_txt.title_num.text.text = "(" .. self._pos_id .. "/" .. #var_7_0 .. ")"
		self._control.top_titile.answer_subject_title.scrollview.content.label_desc.text.text = var_7_3.question

		if self._answer_state == 2 then
			self._control.awardbox_bg.down.interpretation_btn:SetActive(true)
		else
			self._control.awardbox_bg.down.interpretation_btn:SetActive(false)
		end

		if self._is_more_answer then
			self._select_answer_id = {}

			self._answer_content_cell:set_data(var_7_3.answer)

			function self._answer_content_cell:_set_func(arg_8_1)
				local var_8_0 = arg_8_1 + 1

				self.answer_top.answer_txt.text.text = var_7_3.answer[arg_8_1 + 1]
				self.answer_top.select_img_4.answer_text.text.text = var_0_2:getNowLang("correct_answer")

				self.answer_top.select_image:SetActive(false)
				self.select_btn.button.onClick:RemoveAllListeners()
				self.select_btn.button.onClick:AddListener(function()
					self.answer_top.select_image:SetActive(true)
					self.answer_top.select_img_1:SetActive(false)
					self.answer_top.select_img_2:SetActive(false)

					if not self._select_answer_id and not next(self._select_answer_id) then
						table.insert(self._select_answer_id, var_8_0)
						table.sort(self._select_answer_id)
					elseif self:_have_data(self._select_answer_id, var_8_0) then
						for iter_9_0, iter_9_1 in ipairs(self._select_answer_id) do
							if iter_9_1 == var_8_0 then
								table.remove(self._select_answer_id, iter_9_0)
								self.answer_top.select_image:SetActive(false)
								self.answer_top.select_img_1:SetActive(true)
								self.answer_top.select_img_2:SetActive(true)
							end
						end
					else
						table.insert(self._select_answer_id, var_8_0)
						table.sort(self._select_answer_id)
					end
				end)
			end
		else
			self._select_answer_id = {}

			self._answer_content_cell:set_data(var_7_3.answer)

			function self._answer_content_cell:_set_func(arg_10_1)
				local var_10_0 = arg_10_1 + 1

				self.answer_top.answer_txt.text.text = var_7_3.answer[arg_10_1 + 1]
				self.answer_top.select_img_4.answer_text.text.text = var_0_2:getNowLang("correct_answer")

				self.answer_top.select_image:SetActive(false)
				self.select_btn.button.onClick:RemoveAllListeners()
				self.select_btn.button.onClick:AddListener(function()
					for iter_11_0, iter_11_1 in pairs(self._answer_content_cell._items) do
						iter_11_1.control.answer_top.select_image:SetActive(false)
						iter_11_1.control.answer_top.select_img_2:SetActive(true)
						iter_11_1.control.answer_top.select_img_1:SetActive(true)
					end

					self.answer_top.select_image:SetActive(true)
					self.answer_top.select_img_1:SetActive(false)
					self.answer_top.select_img_2:SetActive(false)

					self._select_answer_id = {
						var_10_0
					}
				end)
			end
		end

		if var_7_0[self._pos_id].state == 2 then
			for iter_7_2, iter_7_3 in pairs(self._answer_content_cell._items) do
				iter_7_3.control.select_btn:GetComponent("Button").enabled = false
			end

			self:_update_have_answer_question(self._pos_id)
			self._control.awardbox_bg.down.interpretation_btn:SetActive(true)
		else
			self._control.awardbox_bg.down.interpretation_btn:SetActive(false)
		end

		if var_7_3.explain and var_7_3.explain ~= "0" then
			self._control.interpretation.scrollview_2.content_2.label_desc_2.text.text = var_0_5.convert_rich_text(var_7_3.explain)
		else
			self._control.awardbox_bg.down.interpretation_btn:SetActive(false)
		end
	end

	function arg_1_0._have_data(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_1 and next(arg_12_1) then
			for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
				if iter_12_1 == arg_12_2 then
					return true
				end
			end
		end

		return false
	end

	function arg_1_0:_init_answer_select()
		local var_13_0 = var_0_4:get_score_question_team()

		if self._pos_id ~= #var_13_0 and var_13_0[self._pos_id].state == 2 then
			self._control.awardbox_bg.down.confirm:SetActive(false)
			self._control.awardbox_bg.down.next_btn:SetActive(true)
		else
			self._control.awardbox_bg.down.confirm:SetActive(true)
			self._control.awardbox_bg.down.next_btn:SetActive(false)
		end

		if self._is_last then
			self._control.awardbox_bg.down.confirm:SetActive(false)
		end

		for iter_13_0, iter_13_1 in pairs(self._answer_content_cell._items) do
			iter_13_1.control.answer_top.select_image:SetActive(false)
			iter_13_1.control.answer_top.select_img_1:SetActive(true)
			iter_13_1.control.answer_top.select_img_2:SetActive(true)
			iter_13_1.control.answer_top.select_img_3:SetActive(true)

			iter_13_1.control.answer_top.select_img_1.image.sprite = self:loadSprite(var_0_6.select_answer.select_answer_init)
			iter_13_1.control.answer_top.select_img_2.image.sprite = self:loadSprite(var_0_6.select_answer.select_answer_init)
			iter_13_1.control.answer_top.select_img_3.image.sprite = self:loadSprite(var_0_6.select_answer.select_answer_init)

			iter_13_1.control.answer_top.select_img_4:SetActive(false)

			iter_13_1.control.answer_top.answer_txt.text.color = Color.New(1, 1, 1, 1)
		end
	end

	function arg_1_0:_update_answer_select(arg_14_1)
		self:_init_answer_select()

		local var_14_0 = var_0_4:get_score_question_team()

		if var_14_0[arg_14_1].state == 2 then
			self._control.awardbox_bg.down.confirm:SetActive(false)
			self._control.awardbox_bg.down.next_btn:SetActive(true)
		else
			self._control.awardbox_bg.down.confirm:SetActive(true)
			self._control.awardbox_bg.down.next_btn:SetActive(false)
		end

		self:get_answer_all_score()

		local var_14_1 = var_0_7.find_object_by_id(var_14_0[arg_14_1].id)

		if self:_is_true_list(var_14_1.correct_answer, self._select_answer_id) then
			self._answer_is_right_or_error = true

			for iter_14_0, iter_14_1 in ipairs(self._select_answer_id) do
				self._answer_content_cell._items[iter_14_1 - 1].control.answer_top.select_image:SetActive(false)
				self._answer_content_cell._items[iter_14_1 - 1].control.answer_top.select_img_4:SetActive(true)

				self._answer_content_cell._items[iter_14_1 - 1].control.answer_top.select_img_1.image.sprite = self:loadSprite(var_0_6.select_answer.select_answer_correct)
				self._answer_content_cell._items[iter_14_1 - 1].control.answer_top.answer_txt.text.color = Color.New(0.2980392156862745, 0.9490196078431372, 0.4980392156862745, 1)

				self._answer_content_cell._items[iter_14_1 - 1].control.answer_top.select_img_1:SetActive(true)
				self._answer_content_cell._items[iter_14_1 - 1].control.answer_top.select_img_2:SetActive(true)

				self._answer_content_cell._items[iter_14_1 - 1].control.answer_top.select_img_2.image.sprite = self:loadSprite(var_0_6.select_answer.select_answer_correct_bg)
			end

			local var_14_2 = {}

			for iter_14_2, iter_14_3 in pairs(var_14_1.award) do
				var_14_2 = {
					{
						is_new = false,
						type = 2,
						id = iter_14_3.id,
						count = iter_14_3.value
					}
				}
			end

			local function var_14_3()
				if self._is_start_time then
					self:__onClick_awardbox_bg_down_next_btn()
				end
			end

			if var_0_3:getInstance("mail_box") then
				var_0_3:destroyInstance("mail_box")
				var_0_3:createInstance("mail_box"):show(var_14_2, var_0_6.pve_active_type.score_event, var_14_3)
			else
				var_0_3:createInstance("mail_box"):show(var_14_2, var_0_6.pve_active_type.score_event, var_14_3)
			end
		else
			self._answer_is_right_or_error = false

			local var_14_4 = {}
			local var_14_5 = {}

			for iter_14_4, iter_14_5 in ipairs(var_14_1.correct_answer) do
				for iter_14_6, iter_14_7 in ipairs(self._select_answer_id) do
					if iter_14_5 == iter_14_7 then
						table.insert(var_14_4, iter_14_7)
					elseif var_14_5 and next(var_14_5) and not self:_have_data(var_14_5, iter_14_7) then
						table.insert(var_14_5, iter_14_7)
					end
				end
			end

			for iter_14_8, iter_14_9 in pairs(self._select_answer_id) do
				if not self:_have_data(var_14_1.correct_answer, iter_14_9) then
					table.insert(var_14_5, iter_14_9)
				end
			end

			if var_14_5 and next(var_14_5) then
				for iter_14_10, iter_14_11 in pairs(var_14_5) do
					self._answer_content_cell._items[iter_14_11 - 1].control.answer_top.select_img_1:SetActive(true)

					self._answer_content_cell._items[iter_14_11 - 1].control.answer_top.select_img_1.image.sprite = self:loadSprite(var_0_6.select_answer.select_answer_error)
					self._answer_content_cell._items[iter_14_11 - 1].control.answer_top.answer_txt.text.color = Color.New(0.9725490196078431, 0.21176470588235294, 0.4470588235294118, 1)

					self._answer_content_cell._items[iter_14_11 - 1].control.answer_top.select_image:SetActive(true)
				end
			end

			if var_14_4 and next(var_14_4) then
				for iter_14_12, iter_14_13 in pairs(var_14_4) do
					self._answer_content_cell._items[iter_14_13 - 1].control.answer_top.select_img_1:SetActive(true)

					self._answer_content_cell._items[iter_14_13 - 1].control.answer_top.select_img_1.image.sprite = self:loadSprite(var_0_6.select_answer.select_answer_correct)
					self._answer_content_cell._items[iter_14_13 - 1].control.answer_top.select_img_2.image.sprite = self:loadSprite(var_0_6.select_answer.select_answer_correct_bg)
				end

				for iter_14_14, iter_14_15 in pairs(var_14_1.correct_answer) do
					self._answer_content_cell._items[iter_14_15 - 1].control.answer_top.select_img_4:SetActive(true)
				end
			else
				for iter_14_16, iter_14_17 in pairs(self._select_answer_id) do
					self._answer_content_cell._items[iter_14_17 - 1].control.answer_top.select_img_1:SetActive(true)
					self._answer_content_cell._items[iter_14_17 - 1].control.answer_top.select_image:SetActive(true)
					self._answer_content_cell._items[iter_14_17 - 1].control.answer_top.select_img_2:SetActive(true)

					self._answer_content_cell._items[iter_14_17 - 1].control.answer_top.select_img_1.image.sprite = self:loadSprite(var_0_6.select_answer.select_answer_error)
					self._answer_content_cell._items[iter_14_17 - 1].control.answer_top.answer_txt.text.color = Color.New(0.9725490196078431, 0.21176470588235294, 0.4470588235294118, 1)
				end

				for iter_14_18, iter_14_19 in pairs(var_14_1.correct_answer) do
					self._answer_content_cell._items[iter_14_19 - 1].control.answer_top.select_img_4:SetActive(true)
				end
			end

			if var_14_1.explain and var_14_1.explain ~= "0" then
				local var_14_6 = var_0_3:createInstance("msgbox")

				if var_14_6 then
					self._control.awardbox_bg.down.interpretation_btn:SetActive(true)
					var_14_6:show(var_0_2:getNowLang("view_explain"), function()
						self._control.interpretation:SetActive(true)
						self._control.top_titile:SetActive(false)
						self._control.awardbox:SetActive(false)
					end, function()
						if self._is_start_time then
							self:__onClick_awardbox_bg_down_next_btn()
						end
					end, var_0_2:getNowLang("whether_to_view"), var_0_6.msg_type.tip, nil)
				end
			else
				self:set_is_next_answer(true)
			end
		end
	end

	function arg_1_0._is_true_list(arg_18_0, arg_18_1, arg_18_2)
		if type(arg_18_1) ~= "table" or type(arg_18_2) ~= "table" then
			return arg_18_1 == arg_18_1
		end

		if arg_18_1 and arg_18_2 and next(arg_18_1) and next(arg_18_2) then
			if #arg_18_1 ~= #arg_18_2 then
				return false
			end

			for iter_18_0 = 1, #arg_18_1 do
				if arg_18_1[iter_18_0] ~= arg_18_2[iter_18_0] then
					return false
				end
			end

			return true
		end
	end

	function arg_1_0:_update_have_answer_question(arg_19_1)
		if arg_19_1 < 1 then
			arg_19_1 = 1
			self._opean_up_btn = false

			return
		end

		self:_init_answer_select()
		self:get_answer_all_score()

		local var_19_0 = var_0_4:get_score_question_team()

		if arg_19_1 > #var_19_0 then
			arg_19_1 = #var_19_0

			self._control.awardbox_bg.down.next_btn:SetActive(false)

			return
		elseif arg_19_1 == #var_19_0 and var_19_0[arg_19_1].state == 2 then
			self._control.awardbox_bg.down.next_btn:SetActive(false)
		end

		self._control.awardbox_bg.top.toptitle.title_txt.title_num.text.text = "(" .. self._pos_id .. "/" .. #var_19_0 .. ")"

		local var_19_1 = var_0_7.find_object_by_id(var_19_0[arg_19_1].id)

		self._control.top_titile.answer_subject_title.scrollview.content.label_desc.text.text = var_19_1.question

		local var_19_2 = var_19_1.correct_answer
		local var_19_3 = var_19_0[arg_19_1].answer

		if var_19_1.explain and var_19_1.explain ~= "0" then
			self._control.awardbox_bg.down.interpretation_btn:SetActive(true)

			self._control.interpretation.scrollview_2.content_2.label_desc_2.text.text = var_0_5.convert_rich_text(var_19_1.explain)
		else
			self._control.awardbox_bg.down.interpretation_btn:SetActive(false)
		end

		local var_19_4 = self:_is_true_list(var_19_2, var_19_3)

		for iter_19_0, iter_19_1 in pairs(self._answer_content_cell._items) do
			iter_19_1.control.answer_top.answer_txt.text.text = var_19_1.answer[iter_19_0 + 1]
		end

		if var_19_4 then
			for iter_19_2, iter_19_3 in ipairs(var_19_3) do
				self._answer_content_cell._items[iter_19_3 - 1].control.answer_top.select_image:SetActive(false)
				self._answer_content_cell._items[iter_19_3 - 1].control.answer_top.select_img_4:SetActive(true)

				self._answer_content_cell._items[iter_19_3 - 1].control.answer_top.select_img_1.image.sprite = self:loadSprite(var_0_6.select_answer.select_answer_correct)
				self._answer_content_cell._items[iter_19_3 - 1].control.answer_top.answer_txt.text.color = Color.New(0.2980392156862745, 0.9490196078431372, 0.4980392156862745, 1)

				self._answer_content_cell._items[iter_19_3 - 1].control.answer_top.select_img_1:SetActive(true)
				self._answer_content_cell._items[iter_19_3 - 1].control.answer_top.select_img_2:SetActive(true)

				self._answer_content_cell._items[iter_19_3 - 1].control.answer_top.select_img_2.image.sprite = self:loadSprite(var_0_6.select_answer.select_answer_correct_bg)
			end
		else
			local var_19_5 = {}
			local var_19_6 = {}

			for iter_19_4, iter_19_5 in ipairs(var_19_2) do
				for iter_19_6, iter_19_7 in ipairs(var_19_3) do
					if iter_19_5 == iter_19_7 then
						table.insert(var_19_5, iter_19_7)
					elseif var_19_6 and next(var_19_6) and not self:_have_data(var_19_6, iter_19_7) then
						table.insert(var_19_6, iter_19_7)
					end
				end
			end

			for iter_19_8, iter_19_9 in pairs(var_19_3) do
				if not self:_have_data(var_19_2, iter_19_9) then
					table.insert(var_19_6, iter_19_9)
				end
			end

			if var_19_6 and next(var_19_6) then
				for iter_19_10, iter_19_11 in pairs(var_19_6) do
					self._answer_content_cell._items[iter_19_11 - 1].control.answer_top.select_img_1:SetActive(true)

					self._answer_content_cell._items[iter_19_11 - 1].control.answer_top.select_img_1.image.sprite = self:loadSprite(var_0_6.select_answer.select_answer_error)
					self._answer_content_cell._items[iter_19_11 - 1].control.answer_top.answer_txt.text.color = Color.New(0.9725490196078431, 0.21176470588235294, 0.4470588235294118, 1)

					self._answer_content_cell._items[iter_19_11 - 1].control.answer_top.select_image:SetActive(true)
				end
			end

			if var_19_5 and next(var_19_5) then
				for iter_19_12, iter_19_13 in pairs(var_19_5) do
					self._answer_content_cell._items[iter_19_13 - 1].control.answer_top.select_img_1:SetActive(true)

					self._answer_content_cell._items[iter_19_13 - 1].control.answer_top.select_img_1.image.sprite = self:loadSprite(var_0_6.select_answer.select_answer_correct)
					self._answer_content_cell._items[iter_19_13 - 1].control.answer_top.select_img_2.image.sprite = self:loadSprite(var_0_6.select_answer.select_answer_correct_bg)
				end

				for iter_19_14, iter_19_15 in pairs(var_19_2) do
					self._answer_content_cell._items[iter_19_15 - 1].control.answer_top.select_img_4:SetActive(true)
				end
			else
				for iter_19_16, iter_19_17 in pairs(var_19_3) do
					self._answer_content_cell._items[iter_19_17 - 1].control.answer_top.select_img_1:SetActive(true)
					self._answer_content_cell._items[iter_19_17 - 1].control.answer_top.select_image:SetActive(true)
					self._answer_content_cell._items[iter_19_17 - 1].control.answer_top.select_img_2:SetActive(true)

					self._answer_content_cell._items[iter_19_17 - 1].control.answer_top.select_img_1.image.sprite = self:loadSprite(var_0_6.select_answer.select_answer_error)
					self._answer_content_cell._items[iter_19_17 - 1].control.answer_top.answer_txt.text.color = Color.New(0.9725490196078431, 0.21176470588235294, 0.4470588235294118, 1)
				end

				for iter_19_18, iter_19_19 in pairs(var_19_2) do
					self._answer_content_cell._items[iter_19_19 - 1].control.answer_top.select_img_4:SetActive(true)
				end
			end
		end
	end

	function arg_1_0:set_panel_select_btn(arg_20_1)
		for iter_20_0, iter_20_1 in pairs(self._answer_content_cell._items) do
			iter_20_1.control.select_btn:SetActive(arg_20_1)
		end
	end

	function arg_1_0:get_answer_all_score()
		self._control.awardbox_bg.top.topdescribe.prestige_bg.prestigeimg.prestigenum_text.text.text = var_0_4:get_score_cia_num().coin
	end

	function arg_1_0:set_is_next_answer(arg_22_1)
		if self._answer_is_right_or_error == false then
			if arg_22_1 then
				self._old_time = lx.ServerTime:getUtcTime()
				self._is_start_time = true

				return
			end

			self._old_time = nil
			self._is_start_time = true
		else
			self._old_time = nil
		end

		if self._answer_is_right_or_error then
			self._is_start_time = true
		end
	end

	function arg_1_0.__onReset(arg_23_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_24_0)
	local var_24_0 = var_0_3:class("score_push")

	var_24_0._answer_content_cell = nil
	var_24_0._select_answer_id = nil
	var_24_0._next_answer = false
	var_24_0._pos_id = nil
	var_24_0._answer_id = nil
	var_24_0._opean_up_btn = false
	var_24_0._answer_state = nil
	var_24_0._say_num = 0
	var_24_0._now_click_time = 0
	var_24_0._is_start_time = false
	var_24_0._old_time = 0
	var_24_0._answer_is_right_or_error = nil
	var_24_0._is_more_answer = true

	return var_24_0
end

return var_0_0
