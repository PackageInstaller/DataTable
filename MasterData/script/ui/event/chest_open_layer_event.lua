local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_3 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_chest_layer_close_btn()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))
		self:show_layer(self._chest_layer_seq, false, function()
			self:setVisible(false)
		end)
	end

	function arg_1_0:__onClick_chest_info_close_btn()
		self:show_layer(self._chest_info_seq, false, function()
			self._control.chest_info:SetActive(false)
			self:show_layer(self._chest_layer_seq, true, nil)
		end)
	end

	function arg_1_0:__onClick_chest_info_detail_btn()
		local var_6_0 = var_0_1:getInstance("captainroom")

		self:setVisible(false)
		var_6_0:setVisible(false)

		local var_6_1 = var_0_1:createInstance("item_details_view")

		var_6_1:show(self._now_click_chest_cid)
		var_6_1:set_listener(function()
			var_6_0:setVisible(true)
			self:setVisible(true)
		end)
	end

	function arg_1_0:__onClick_chest_info_minus_btn()
		self:__click_minus_btn_event()
	end

	function arg_1_0:__onClick_chest_info_plus_btn()
		self:__click_plus_btn_event()
	end

	function arg_1_0:__onClick_chest_info_use_btn()
		self:show_chest_open()
	end

	function arg_1_0:__onClick_chest_list_cofirm_btn()
		for iter_11_0 = 1, self._control.chest_list.chest.transform.childCount do
			self._control.chest_list.chest.transform:GetChild(iter_11_0 - 1).gameObject:SetActive(false)
		end

		self:init_chest_list()
	end

	function arg_1_0.__onClick_chest_layer_scrollview_content_chest_cell_bg(arg_12_0)
		return
	end

	function arg_1_0:__onClick_chest_open_chest_btn()
		if self._open_box_once then
			return
		end

		self:click_chest_event()
	end

	function arg_1_0.__onClick_jump_warehouse_coonfirm_btn(arg_14_0)
		local var_14_0 = var_0_1:createInstance("dormitory")

		var_14_0:show()
		var_14_0:setVisible(false)
		var_0_1:getInstance("captainroom"):__destroy_panel()

		local var_14_1 = var_0_1:createInstance("dorm_warehouse")

		var_14_1:set_sort_data()
		var_14_1:show()
	end

	function arg_1_0:__onClick_jump_warehouse_cancel_btn()
		self._control.jump_warehouse:SetActive(false)
	end

	function arg_1_0.__onLongClick_chest_info_minus_btn(arg_16_0)
		arg_16_0._is_long_click_minus_btn = true
	end

	function arg_1_0.__onLongClick_chest_info_plus_btn(arg_17_0)
		arg_17_0._is_long_click_plus_btn = true
	end

	function arg_1_0.__onClick_chest_list_chest_chest_cell_frame(arg_18_0)
		return
	end

	function arg_1_0:__onClick_chest_open_skip_btn()
		if self._open_box_once then
			return
		end

		self:click_chest_event(true)
	end

	function arg_1_0:__onClick_chest_role_skip_btn()
		if self._open_box_once then
			return
		end

		self:click_chest_event(true)
	end
end

function var_0_0.extend_obj(arg_21_0)
	return
end

return var_0_0
