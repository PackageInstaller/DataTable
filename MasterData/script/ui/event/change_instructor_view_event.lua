local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.UILoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_return_btn()
		self:setVisible(false)
		var_0_1:set_statics_common_state(false)

		local var_2_0 = var_0_2:getInstance("school")
	end

	function arg_1_0:__set_now_select_ship_data(arg_3_1)
		local var_3_0 = arg_3_1 <= 3 and self._attack_tactics_table[arg_3_1] or arg_3_1 <= 6 and self._defense_tactics_table[arg_3_1 - 3] or self._special_tactics_table[arg_3_1 - 6]
		local var_3_1 = var_0_2:getInstance("school")

		var_0_2:createInstance("class_info_view"):show(var_3_0, nil, (var_3_1 or nil) and var_3_1._now_class)
		self:__set_select_state(arg_3_1)
	end

	function arg_1_0:__onClick_chat_set_teach()
		var_0_1:req_ReplaceTeacherReq({
			teacher = self._teacher_config_data[self._now_teacher_index].cid,
			class = var_0_2:getInstance("school"):get_curr_class()
		})
	end

	function arg_1_0:__set_select_state(arg_5_1)
		if self._now_select_bg_index then
			self._last_select_bg_index = self._now_select_bg_index

			self._tactics_item_panel[self._last_select_bg_index].control.select:SetActive(false)
		end

		self._now_select_bg_index = arg_5_1

		self._tactics_item_panel[self._now_select_bg_index].control.select:SetActive(true)
	end
end

function var_0_0.extend_obj(arg_6_0)
	arg_6_0._now_select_bg_index = nil
	arg_6_0._last_select_bg_index = nil
	arg_6_0._now_index = nil
end

return var_0_0
