local var_0_0 = {}
local var_0_1 = gameenum.common_type
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.Language
local var_0_4 = gamecore.user

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_bg_container_back_btn()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.back))
		var_0_1:play_in_out_animation(self._control.bg_container.uITweenSequence, false, function()
			self:setVisible(false)

			local var_3_0 = var_0_2:getInstance("ship_detail")

			if var_3_0 then
				var_3_0:setVisible(true)
			end

			self._filter_name = nil
		end)
	end

	function arg_1_0.__onClick_content_type_btn(arg_4_0)
		local var_4_0 = var_0_2:createInstance("equip_type_layer")

		var_4_0:show()
		var_4_0:__revert_toggle_group_all_set()
		var_4_0:__save_toggle_group_all_set_data()
	end

	function arg_1_0:__onClick_content_change_lock_btn()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.task_goto))
		self:switch_btn()
	end

	function arg_1_0.__onClick_content_all_equip_viewport_content_single_equip_select_layer_takeoff_btn(arg_6_0)
		return
	end

	function arg_1_0.__onClick_content_all_equip_viewport_content_single_equip_info_layer_add_btn(arg_7_0)
		return
	end

	function arg_1_0.__onClick_content_all_equip_viewport_content_single_equip_info_layer_detail_btn(arg_8_0)
		return
	end

	function arg_1_0.__onClick_content_all_equip_viewport_content_single_equip_dismantle_layer_minus_btn(arg_9_0)
		return
	end

	function arg_1_0:__onClick_tip_layer()
		self:__show_equip_attr_panel(false)
	end

	function arg_1_0:__onScaleButtonClick_bg_container_back_btn()
		self:__onClick_bg_container_back_btn()
	end

	function arg_1_0.__onClick_equip_content_type_btn(arg_12_0)
		var_0_2:createInstance("equip_type_layer"):show()
	end

	function arg_1_0:__onClick_equip_content_change_lock_btn()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.task_goto))
		self:switch_btn()
	end

	function arg_1_0:__onClick_equip_content_show_use_btn()
		self:__update_search_name()

		if self._is_use_equip then
			self._is_use_equip = false
			self._control.equip_content.show_use_btn.show_use_btn_btn.text.text = var_0_3:getNowLang("hidden_use")
		else
			self._is_use_equip = true
			self._control.equip_content.show_use_btn.show_use_btn_btn.text.text = var_0_3:getNowLang("display_use")
		end

		local var_14_0 = self._is_use_equip

		var_0_4:set_show_panel_equip_state(self._is_use_equip)

		if self._is_use_equip then
			self:_show_already_use_equip(var_14_0)
		else
			self:__update_cell_list()
		end
	end

	function arg_1_0:__onClick_equip_content_sort_type_btn()
		local var_15_0 = var_0_2:createInstance("equip_sort_layer")

		var_15_0:set_listener(self, self.sort_layer_toggle_on)
		var_15_0:show()
	end
end

function var_0_0.extend_obj(arg_16_0)
	return
end

return var_0_0
