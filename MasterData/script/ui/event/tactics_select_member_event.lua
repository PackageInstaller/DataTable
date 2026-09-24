local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.Language
local var_0_4 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onScaleButtonClick_bg_container_back_btn()
		var_0_1:set_statics_common_state(false)
		var_0_1:set_tactics_all_select_member_list()
		self._type_layer:_init_statics_state()
		self._sort_layer:reset_select_state()
		self:setVisible(false)

		local var_2_0 = var_0_2:getInstance("change_instructor_view")
		local var_2_1 = var_0_2:getInstance("class_info_view")
		local var_2_2 = var_0_2:getInstance("school")

		if var_2_2 then
			var_2_2:setVisible(true)
		else
			local var_2_3 = var_0_2:createInstance("school")

			var_2_3:show()

			local var_2_4 = var_0_1:get_now_class_num()

			if var_2_4 == 2 then
				var_2_3:__onClick_class_btn_set_class_two()
			elseif var_2_4 == 3 then
				var_2_3:__onClick_class_btn_set_class_three()
			end
		end

		if var_2_0 then
			var_2_0:setVisible(true)
		end
	end

	function arg_1_0:__onClick_detail_btn()
		self._detail_index = self._detail_index + 1

		if self._detail_index <= var_0_4.dock_detail_layer.second then
			self._detail_index = self._detail_index or var_0_4.dock_detail_layer.once
		end

		self:__change_info_list_detail()
	end

	function arg_1_0:__change_info_list_detail()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.task_goto))

		if self._detail_index == var_0_4.dock_detail_layer.once then
			self._control.detail_btn.image.sprite = self:loadSprite(var_0_4.ship_detail_switch.close)
			self._control.detail_btn.detail_status.text.text = var_0_3:getNowLang("detailtypeclose")
		else
			self._control.detail_btn.image.sprite = self:loadSprite(var_0_4.ship_detail_switch.open)
			self._control.detail_btn.detail_status.text.text = var_0_3:getNowLang("detailtypeopen")
		end

		self:__update_reusable_cell()
	end

	function arg_1_0:__onClick_sort_order_btn()
		self._sort_layer = self._sort_layer or self:loadUI("sort_layer_2")

		self._sort_layer:setVisible(true)
	end

	function arg_1_0:__onClick_sort_type_btn()
		self:get_type_layer()
		self._type_layer:show(true)
	end

	function arg_1_0.__onClick_class_info_view_base_panel_return_btn(arg_7_0)
		return
	end

	function arg_1_0.__onClick_class_info_view_detail_panel_study_btn(arg_8_0)
		return
	end

	function arg_1_0.__onClick_class_info_view_detail_panel_left_btn(arg_9_0)
		return
	end

	function arg_1_0.__onClick_class_info_view_detail_panel_right_btn(arg_10_0)
		return
	end

	function arg_1_0.__onClick_class_info_view_detail_panel_show_ship_study_btn(arg_11_0)
		return
	end

	function arg_1_0.__onClick_class_info_view_stop_study_layer_quitbtn(arg_12_0)
		return
	end

	function arg_1_0.__onClick_class_info_view_stop_study_layer_confirmbtn(arg_13_0)
		return
	end
end

function var_0_0.extend_obj(arg_14_0)
	return
end

return var_0_0
