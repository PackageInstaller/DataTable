local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.UILoader
local var_0_3 = gameenum.common_type
local var_0_4 = gamecore.Language

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_base_mask_btn()
		if self._current_step + 1 < #self._guide_conifg_list and self._guide_conifg_list[self._current_step + 1].step == var_0_3.guide_const_id.first_group.six then
			self._base_view:SetActive(false)

			return
		end

		self:reset_guide_panel()
	end

	function arg_1_0:__onClick_base_guide_prompt_quitbtn()
		self._control.base.guide_prompt.gameObject:SetActive(false)
		self:set_new_player_data(function()
			var_0_1:req_GuideStepReq(self._comlete_step_data)
		end)
		var_0_1:set_is_preload_completed(true)
		var_0_2:getInstance("home"):init_announcement(true)
	end

	function arg_1_0:__onClick_base_guide_prompt_confirmbtn()
		self:__show_guide_mask_view()
		self._control.base.guide_prompt.gameObject:SetActive(false)
		self:reset_guide_panel()
	end

	function arg_1_0.__onClick_base_left_guide_role_back_btn(arg_6_0)
		return
	end

	function arg_1_0.__onClick_base_left_guide_role_back_left_btn(arg_7_0)
		var_0_2:createInstance("jump_msgbox"):show(var_0_4:getNowLang("newbie_guide_exit"), function()
			var_0_1:set_is_preload_completed(true)

			if var_0_2:getInstance("guide_panel") then
				var_0_2:destroyInstance("guide_panel")
			end

			if var_0_2:getInstance("guide_panel_mask") then
				var_0_2:destroyInstance("guide_panel_mask")
			end

			arg_7_0:set_new_player_data(function()
				var_0_1:req_GuideStepReq(arg_7_0._comlete_step_data)
			end)
		end, function()
			return
		end, var_0_4:getNowLang("confirm_quit"), var_0_3.msg_type.tip)
	end

	function arg_1_0.__onClick_base_rightt_guide_role_back_right_btn(arg_11_0)
		var_0_2:createInstance("jump_msgbox"):show(var_0_4:getNowLang("newbie_guide_exit"), function()
			if var_0_2:getInstance("guide_panel") then
				var_0_2:destroyInstance("guide_panel")
			end

			if var_0_2:getInstance("guide_panel_mask") then
				var_0_2:destroyInstance("guide_panel_mask")
			end

			arg_11_0:set_new_player_data(function()
				var_0_1:req_GuideStepReq(arg_11_0._comlete_step_data)
			end)
		end, function()
			return
		end, var_0_4:getNowLang("confirm_quit"), var_0_3.msg_type.tip)
	end

	function arg_1_0:__onClick_base_break_guide_prompt_quitbtn()
		self._control.base.break_guide_prompt:SetActive(false)
	end

	function arg_1_0:__onClick_base_break_guide_prompt_confirmbtn()
		if var_0_2:getInstance("guide_panel") then
			var_0_2:destroyInstance("guide_panel")
		end

		if var_0_2:getInstance("guide_panel_mask") then
			var_0_2:destroyInstance("guide_panel_mask")
		end

		self:set_new_player_data(function()
			var_0_1:req_GuideStepReq(self._comlete_step_data)
		end)
	end
end

function var_0_0.extend_obj(arg_18_0)
	return
end

return var_0_0
