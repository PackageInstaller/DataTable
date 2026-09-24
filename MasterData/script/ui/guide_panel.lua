local var_0_0 = {}
local var_0_1 = lx.split
local var_0_2 = gamecore.user
local var_0_3 = table.insert
local var_0_4 = table.remove
local var_0_5 = gamecore.Language
local var_0_6 = gamecore.UILoader
local var_0_7 = string.format
local var_0_8 = UnityEngine.Vector4
local var_0_9 = UnityEngine.Vector3
local var_0_11 = gamecore.util_func
local var_0_12 = gameenum.common_type
local var_0_13 = gameconfig.guide_config
local var_0_14 = UnityEngine.RectTransformUtility
local var_0_15 = gamecore.AuditServerManager

gamecore.UILoader:define("guide_panel", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:__init_panel()
	end

	function arg_1_0:__onUpdate()
		if self._diff_time > 0 then
			self._diff_time = self._diff_time - 0.08
		end

		if self._diff_time < 0 then
			self._base_view:SetActive(true)
			self:show_guide_mask_panel()

			self._diff_time = 0
		end

		if self._mask_diff_time > 0 then
			self._mask_diff_time = self._mask_diff_time - 0.05
		end

		if self._mask_diff_time < 0 then
			self:__set_guide_mask_state(false)

			self._mask_diff_time = 0
		end
	end

	function arg_1_0:update_guide_data()
		self._server_complete_list = var_0_2:get_guide_info()

		for iter_4_0, iter_4_1 in pairs(self._server_complete_list) do
			self:__get_now_data(iter_4_1)
		end

		self:__remove_complete_step()
	end

	function arg_1_0:show_guide_mask_panel()
		self._guide_mask.gameObject:SetActive(true)

		self._current_step = self._current_step + 1

		if #self._guide_conifg_list >= self._current_step then
			if self._guide_conifg_list[self._current_step].step == var_0_12.guide_const_id.special_group.two or self._guide_conifg_list[self._current_step].step == var_0_12.guide_const_id.special_group.one then
				self:set_curr_step_skip()
			end

			if self._is_exist_task_error and self._guide_conifg_list[self._current_step].step == var_0_12.guide_const_id.five_group.one then
				self:set_curr_step_skip()
			end

			if self._guide_conifg_list[self._current_step].step == var_0_12.guide_const_id.four_group.two then
				self._guide_mask_panel:set_mask_bg_state(false)
			end

			self:__show_now_guide_info(self._current_step)
		else
			self:setVisible(false)

			if self._guide_mask_panel then
				self._guide_mask_panel:setVisible(false)
			end
		end
	end

	function arg_1_0:set_curr_step_skip()
		self._current_step = self._current_step + 2
	end

	function arg_1_0:reset_guide_panel()
		self:__set_guide_mask_state(true)
		self._base_view:SetActive(false)

		self._diff_time = var_0_12.guide_const_num.delay_min_time
		self._mask_diff_time = var_0_12.guide_const_num.delay_max_time
	end

	function arg_1_0:reset_guide_panel_eight_one()
		self:__set_guide_mask_state(true)
		self._base_view:SetActive(false)

		self._diff_time = var_0_12.guide_const_num.delay_min_time_eight_one
		self._mask_diff_time = var_0_12.guide_const_num.delay_max_time_eight_one
	end

	function arg_1_0:set_new_player_data(arg_9_1)
		for iter_9_0, iter_9_1 in pairs((var_0_13:get_hinge_set())) do
			var_0_3(self._comlete_step_data, iter_9_1)
		end

		if arg_9_1 then
			arg_9_1()
		end
	end

	function arg_1_0:get_current_step()
		return self._guide_conifg_list[self._current_step - 1].step
	end

	function arg_1_0:get_next_step()
		return self._guide_conifg_list[self._current_step + 1].step
	end

	function arg_1_0.set_current_step(arg_12_0, arg_12_1)
		arg_12_0._current_step = arg_12_1
	end

	function arg_1_0:get_current_client_complete_list()
		return self._current_client_complete_list
	end

	function arg_1_0:set_limit_step_to_complate(arg_14_1)
		local var_14_0 = {}

		var_0_3(var_14_0, arg_14_1)

		if self:__get_sever_point_progress(arg_14_1) then
			var_0_2:req_GuideStepReq(var_14_0)
		end
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self:__init_language()
			self:__init_click_event()

			self._is_already_init = true
		end

		self._first_is_complete = false

		self._guide_mask.gameObject:SetActive(false)

		self._is_exist_task_error = false
		self._current_client_complete_list = {}

		self:__init_config_data()
		self:update_guide_data()
		self._control.base.break_guide_prompt:SetActive(false)

		if self:__get_document_guide_data() then
			return
		end

		if var_0_15:isAuditVersion() then
			self:set_new_player_data(function()
				var_0_2:req_GuideStepReq(self._comlete_step_data)
			end)
			var_0_6:getInstance("home"):init_announcement(true)

			return
		end

		if not self._first_is_complete then
			self:__show_guide_prompt()
		else
			self:__show_guide_mask_view()
			self:reset_guide_panel()
			self:__get_task_reward_list()
		end
	end

	function arg_1_0:__init_language()
		self._control.base.guide_prompt.title.text.text = var_0_5:getNowLang("tutorialconfirm")
		self._control.base.guide_prompt.main_text.text.text = var_0_5:getNowLang("tutorialcontinue")
		self._control.base.guide_prompt.confirmbtn.text.text.text = var_0_5:getNowLang("ui_cbtn1")
		self._control.base.guide_prompt.quitbtn.text.text.text = var_0_5:getNowLang("ui_cbtn2")
		self._control.base.break_guide_prompt.title.text.text = var_0_5:getNowLang("confirm_quit")
		self._control.base.break_guide_prompt.main_text.text.text = var_0_5:getNowLang("newbie_guide_exit")
		self._control.base.break_guide_prompt.confirmbtn.text.text.text = var_0_5:getNowLang("skip2")
		self._control.base.break_guide_prompt.quitbtn.text.text.text = var_0_5:getNowLang("ui_cbtn2")
		self._guide_frame = {
			left_rect_obj = self._control.base.left_guide,
			right_rect_obj = self._control.base.rightt_guide,
			circle_obj = self._control.base.circlre_layer
		}
		self._guide_frame.left_rect_obj.role_name.text.text = var_0_5:getNowLang("ui_tutorialnpcname")
		self._guide_frame.right_rect_obj.role_name.text.text = var_0_5:getNowLang("ui_tutorialnpcname")
		self._guide_frame.left_rect_obj.role.back_left_btn.back_txt = var_0_5:getNowLang("skip")
		self._guide_frame.right_rect_obj.role.back_right_btn.back_txt = var_0_5:getNowLang("skip")
		self._guide_mask = self._control.base.guide_bg
		self._arrow_state = self._control.base.parent.arrow_parent
		self._media_obj = self._control.base:GetComponent("GuidePostEvent")
		self._base_view = self._control.base.base
	end

	function arg_1_0.__init_config_data(arg_18_0)
		local var_18_0, var_18_1 = var_0_13:get_sequence()

		arg_18_0._guide_conifg_list = var_0_11.little_clone(var_18_0)
	end

	function arg_1_0:__get_now_data(arg_19_1)
		local var_19_0 = self:__get_step_group(arg_19_1)

		for iter_19_0, iter_19_1 in pairs(self._guide_conifg_list) do
			if iter_19_1.group == var_19_0 then
				self:__set_prompt_state(iter_19_1)
				var_0_3(self._client_complete_list, iter_19_1)
			end
		end
	end

	function arg_1_0:__remove_complete_step()
		for iter_20_0, iter_20_1 in pairs(self._client_complete_list) do
			self:__set_config_list_data(iter_20_1.step)
		end
	end

	function arg_1_0:__set_config_list_data(arg_21_1)
		for iter_21_0, iter_21_1 in pairs(self._guide_conifg_list) do
			if iter_21_1.step == arg_21_1 then
				var_0_4(self._guide_conifg_list, iter_21_0)
			end
		end
	end

	function arg_1_0:__get_step_group(arg_22_1)
		for iter_22_0, iter_22_1 in pairs(self._guide_conifg_list) do
			if iter_22_1.step == arg_22_1 then
				return iter_22_1.group
			end
		end
	end

	function arg_1_0.__set_prompt_state(arg_23_0, arg_23_1)
		if arg_23_1.group == 1 and arg_23_1.is_hinge == true then
			arg_23_0._first_is_complete = true
		end
	end

	function arg_1_0:__show_guide_prompt()
		self._control.base.guide_prompt.gameObject:SetActive(true)
		var_0_12:play_in_out_animation(self._control.base.parent.uITweenSequence, true)
	end

	function arg_1_0:__reset_frame_state()
		self._guide_frame.left_rect_obj.gameObject:SetActive(false)
		self._guide_frame.right_rect_obj.gameObject:SetActive(false)
		self._guide_frame.circle_obj.gameObject:SetActive(false)
	end

	function arg_1_0:__show_now_guide_info(arg_26_1)
		self:__set_guide_btn_info((self:__get_limit_view_info()))
		self:__change_to_req(arg_26_1)
		self:__set_mask_state(arg_26_1)
		self:__set_arrow_state(arg_26_1)
		self:__set_frame_state(arg_26_1)
	end

	function arg_1_0:__set_arrow_state(arg_27_1)
		self._arrow_state.gameObject:SetActive(false)

		if self._guide_conifg_list[arg_27_1].direction == var_0_12.guide_arrow_type.arrow_no then
			return
		end

		self._arrow_state.transform.anchoredPosition = var_0_9.New(self._record_hollow_pos.x + self._guide_conifg_list[arg_27_1].arrow_offset[1], self._record_hollow_pos.y + self._guide_conifg_list[arg_27_1].arrow_offset[2], 0)

		if self._guide_conifg_list[arg_27_1].direction == var_0_12.guide_arrow_type.arrow_up then
			self._arrow_state.gameObject:SetActive(true)

			self._arrow_state.transform.rotation = var_0_9.New(0, 0, 180)
		elseif self._guide_conifg_list[arg_27_1].direction == var_0_12.guide_arrow_type.arrow_down then
			self._arrow_state.gameObject:SetActive(true)

			self._arrow_state.transform.rotation = var_0_9.New(0, 0, 0)
		end
	end

	function arg_1_0:__set_frame_state(arg_28_1)
		self:__reset_frame_state()

		if self._guide_conifg_list[arg_28_1].circle_image == var_0_12.guide_frame_type.frame_rect then
			if self._guide_conifg_list[arg_28_1].image_direction == var_0_12.guide_frame_pos_type.frame_pos_left then
				self._guide_frame.left_rect_obj.gameObject:SetActive(true)

				self._guide_frame.left_rect_obj.guide_des.text.text = var_0_5:convert_rich_text(self._guide_conifg_list[arg_28_1].desc)

				self._guide_frame.left_rect_obj.arrow.gameObject:SetActive(self._guide_conifg_list[arg_28_1].is_angle)

				self._guide_frame.left_rect_obj.transform.anchoredPosition = var_0_9.New(self._guide_conifg_list[arg_28_1].frame_pos[1], self._guide_conifg_list[arg_28_1].frame_pos[2], 0)
			elseif self._guide_conifg_list[arg_28_1].image_direction == var_0_12.guide_frame_pos_type.frame_pos_right then
				self._guide_frame.right_rect_obj.gameObject:SetActive(true)

				self._guide_frame.right_rect_obj.guide_des.text.text = var_0_5:convert_rich_text(self._guide_conifg_list[arg_28_1].desc)

				self._guide_frame.right_rect_obj.arrow.gameObject:SetActive(self._guide_conifg_list[arg_28_1].is_angle)

				self._guide_frame.right_rect_obj.transform.anchoredPosition = var_0_9.New(self._guide_conifg_list[arg_28_1].frame_pos[1], self._guide_conifg_list[arg_28_1].frame_pos[2], 0)
			end
		elseif self._guide_conifg_list[arg_28_1].circle_image == var_0_12.guide_frame_type.frame_circle then
			self._guide_frame.circle_obj.gameObject:SetActive(true)

			self._guide_frame.circle_obj.guide_des.text.text = var_0_5:convert_rich_text(self._guide_conifg_list[arg_28_1].desc)

			self._guide_frame.circle_obj.arrow.gameObject:SetActive(self._guide_conifg_list[arg_28_1].is_angle)

			self._guide_frame.circle_obj.transform.anchoredPosition = var_0_9.New(self._guide_conifg_list[arg_28_1].frame_pos[1], self._guide_conifg_list[arg_28_1].frame_pos[2], 0)
		end

		self._control.base.left_guide.role.back_left_btn.back_txt = var_0_5:getNowLang("skip")
		self._control.base.rightt_guide.role.back_right_btn.back_txt = var_0_5:getNowLang("skip")
	end

	function arg_1_0:__set_mask_state(arg_29_1)
		local var_29_0 = self._guide_conifg_list[arg_29_1].hollow_offset[1]
		local var_29_1 = self._guide_conifg_list[arg_29_1].hollow_offset[2]
		local var_29_2 = self._guide_conifg_list[arg_29_1].hollow_pos[1]
		local var_29_3 = self._guide_conifg_list[arg_29_1].hollow_pos[2]
		local var_29_4 = self._guide_conifg_list[arg_29_1].step_name

		self._control.base.mask_btn.gameObject:SetActive(self._guide_conifg_list[arg_29_1].step_name == "null")
		self._guide_mask.gameObject:SetActive(var_29_4 ~= "null")

		if var_29_4 == "null" then
			return
		end

		local var_29_5 = self._guide_btn_pos.x + var_29_2

		self._record_hollow_pos = {
			x = self._guide_btn_pos.x + var_29_2,
			y = self._guide_btn_pos.y + var_29_3
		}

		self._guide_mask.image.material:SetFloat("_SliderX", self._guide_btn_pos.width + var_29_0)
		self._guide_mask.image.material:SetFloat("_SliderY", self._guide_btn_pos.height + var_29_1)
		self._guide_mask.image.material:SetVector("_Center", (var_0_8(var_29_5, self._guide_btn_pos.y + var_29_3, 0, 0)))

		if self._guide_btn_pos.width + var_29_0 ~= 0 then
			self._now_step_name = self._guide_conifg_list[arg_29_1].step_name

			if self._guide_conifg_list[self._current_step].step == var_0_12.guide_const_id.four_group.two or self._guide_conifg_list[self._current_step].step == var_0_12.guide_const_id.five_group.one or self._guide_conifg_list[self._current_step].step == var_0_12.guide_const_id.six_group.four or self._guide_conifg_list[self._current_step].step == var_0_12.guide_const_id.eight_group.three or self._guide_conifg_list[self._current_step].step == var_0_12.guide_const_id.eight_group.one or self._guide_conifg_list[self._current_step].step == var_0_12.guide_const_id.third_group.four then
				self._now_step_name, self._config_parent_name = self:__get_curr_parent_name(self._now_step_name)
			else
				self._config_parent_name = nil
			end

			self._media_obj:Show(self._now_step_name, self._config_parent_name)
		end
	end

	function arg_1_0.__get_curr_parent_name(arg_30_0, arg_30_1)
		local var_30_0 = var_0_1(arg_30_1, "/")

		return var_30_0[2], var_30_0[1]
	end

	function arg_1_0:__change_to_req(arg_31_1)
		if arg_31_1 - 1 == 0 then
			return
		end

		if self._guide_conifg_list[arg_31_1].is_hinge then
			self._comlete_step_data = {}

			if self._guide_conifg_list[arg_31_1].step == var_0_12.guide_const_id.ten_group.one then
				return
			end

			if self:__get_sever_point_progress(self._guide_conifg_list[arg_31_1].step) then
				var_0_3(self._comlete_step_data, self._guide_conifg_list[arg_31_1].step)
				var_0_2:req_GuideStepReq(self._comlete_step_data)
			end
		end
	end

	function arg_1_0.__get_sever_point_progress(arg_32_0, arg_32_1)
		for iter_32_0, iter_32_1 in pairs((var_0_2:get_guide_info())) do
			if arg_32_1 == iter_32_1 then
				return false
			end
		end

		return true
	end

	function arg_1_0:__init_click_event()
		local var_33_0 = self._control.base:GetComponent(typeof(GuidePostEvent))

		var_33_0.onClick:RemoveAllListeners()
		var_33_0.onClick:AddListener(function()
			self._base_view:SetActive(false)
			var_0_3(self._current_client_complete_list, self._current_step)

			if self:__show_panel_delay(self._guide_conifg_list[self._current_step + 1].step) then
				self._diff_time = var_0_12.guide_const_num.delay_min_time
				self._mask_diff_time = var_0_12.guide_const_num.delay_max_time

				self:__set_guide_mask_state(true)
			end
		end)
	end

	function arg_1_0:__show_panel_delay(arg_35_1)
		local var_35_0 = true

		if arg_35_1 == var_0_12.guide_const_id.first_group.five or arg_35_1 == var_0_12.guide_const_id.first_group.six or arg_35_1 == var_0_12.guide_const_id.first_group.seven or arg_35_1 == var_0_12.guide_const_id.nine_group.zero or arg_35_1 == var_0_12.guide_const_id.ten_group.zero or arg_35_1 == var_0_12.guide_const_id.special_group.one or arg_35_1 == var_0_12.guide_const_id.second_group.three or arg_35_1 == var_0_12.guide_const_id.five_group.zero then
			var_35_0 = false
		elseif arg_35_1 == var_0_12.guide_const_id.four_group.two then
			self._guide_mask_panel:set_mask_state(true)
			self._guide_mask_panel:set_mask_bg_state(true)

			UnityEngine.GameObject.Find("tab_3"):GetComponent("Toggle").isOn = true

			var_0_6:getInstance("dock_team"):register_toggle_event_by_guide()

			var_35_0 = false
		elseif arg_35_1 == var_0_12.guide_const_id.seven_group.zero then
			self:__reset_main_panel()
		elseif arg_35_1 == var_0_12.guide_const_id.second_group.zero and not var_0_6:getInstance("home") then
			var_35_0 = false
		end

		return var_35_0
	end

	function arg_1_0.__reset_main_panel(arg_36_0)
		local var_36_0 = var_0_6:createInstance("main_menu")

		var_36_0:play_out_animation(function()
			var_36_0:setVisible(false)
		end)
		var_0_6:createInstance("home"):play_open_ui_animation(true)
	end

	function arg_1_0:__get_document_guide_data()
		local var_38_0 = false

		for iter_38_0, iter_38_1 in pairs(self._client_complete_list) do
			if iter_38_1.step == var_0_12.guide_const_id.nine_group.two then
				var_38_0 = true

				self:set_limit_step_to_complate(var_0_12.guide_const_id.ten_group.one)
			end
		end

		return var_38_0
	end

	function arg_1_0:__show_guide_mask_view()
		self._guide_mask_panel = var_0_6:createInstance("guide_panel_mask")

		self._guide_mask_panel:show()
	end

	function arg_1_0:__set_guide_mask_state(arg_40_1)
		if not self._guide_mask_panel then
			self:__show_guide_mask_view()
		end

		self._guide_mask_panel:set_mask_state(arg_40_1)
	end

	function arg_1_0:__get_task_reward_list()
		if self._current_step == 0 then
			self._current_step = self._current_step + 1
		end

		if not self._guide_conifg_list[self._current_step] then
			self._current_step = self._current_step - 1

			return
		end

		if self._guide_conifg_list[self._current_step].step == var_0_12.guide_const_id.five_group.zero and var_0_2:get_task_reward_num() == 1 then
			self._is_exist_task_error = true
		end

		self._current_step = self._current_step - 1
	end

	function arg_1_0:__get_limit_view_info()
		local var_42_0 = var_0_7("__on_btn_func_%s", (var_0_12:get_guide_method_type(self._guide_conifg_list[self._current_step].step)))

		if not self[var_42_0] then
			return
		end

		return self[var_42_0](self, self._guide_conifg_list[self._current_step].step)
	end

	function arg_1_0:__set_guide_btn_info(arg_43_1)
		if not arg_43_1 then
			self:__reset_guide_btn_info()

			return
		end

		local var_43_0 = Vector2()
		local var_43_1, var_43_2 = var_0_14.ScreenPointToLocalPointInRectangle(var_0_11.get_ui_root_canvas_rect(), arg_43_1.position, nil, nil)

		self._guide_btn_pos = {
			x = var_43_2.x,
			y = var_43_2.y,
			width = arg_43_1.rect.width / 2,
			height = arg_43_1.rect.height / 2
		}
	end

	function arg_1_0.__reset_guide_btn_info(arg_44_0)
		arg_44_0._guide_btn_pos = {
			width = 0,
			height = 0,
			x = 0,
			y = 0
		}
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_45_0)
	local var_45_0 = var_0_6:class("guide_panel")

	var_45_0._guide_frame = {}
	var_45_0._guide_conifg_list = {}
	var_45_0._client_complete_list = {}
	var_45_0._first_is_complete = false
	var_45_0._server_complete_list = {}
	var_45_0._guide_mask = nil
	var_45_0._arrow_state = nil
	var_45_0._current_step = 0
	var_45_0._media_obj = nil
	var_45_0._now_step_name = nil
	var_45_0._diff_time = 0
	var_45_0._mask_diff_time = 0
	var_45_0._comlete_step_data = {}
	var_45_0._current_client_complete_list = {}
	var_45_0._guide_mask_panel = nil
	var_45_0._config_parent_name = nil
	var_45_0._is_exist_task_error = false
	var_45_0._guide_btn_pos = {}
	var_45_0._record_hollow_pos = {}
	var_45_0._base_view = nil
	var_45_0._is_already_init = false

	return var_45_0
end

return var_0_0
