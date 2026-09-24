local var_0_0 = {}

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_return_btn()
		if self._control.buff_trans.activeSelf then
			return
		end

		self:__close_panel()
		self:__set_analysis_return_active(true)
	end

	function arg_1_0:__onClick_buff_trans_giveup_btn()
		if self._is_from_buff_map then
			self._new_card_id = 0

			self:__close_to_buffmap()

			return
		end

		self:__msg_box_show("确认分解", self._new_card_id, true)
	end

	function arg_1_0:__onClick_buff_list_buff_storage_tower_buff_storage0_extract_buff_btn()
		self:__extract_buff_click(1)
	end

	function arg_1_0:__onClick_buff_list_buff_storage_tower_buff_storage1_extract_buff_btn()
		self:__extract_buff_click(2)
	end

	function arg_1_0:__onClick_buff_list_buff_storage_tower_buff_storage0_storage_btn()
		self:__set_buff_select_mask(1, true)
	end

	function arg_1_0:__onClick_buff_list_buff_storage_tower_buff_storage1_storage_btn()
		self:__set_buff_select_mask(2, true)
	end

	function arg_1_0:__onClick_buff_list_buff_storage_tower_buff_storage0_buff_info_panel_replace_btn()
		self:__store_buff(1)
	end

	function arg_1_0:__onClick_buff_list_buff_storage_tower_buff_storage1_buff_info_panel_replace_btn()
		self:__store_buff(2)
	end

	function arg_1_0:__onClick_buff_list_buff_storage_tower_buff_storage0_buff_info_panel_decompose_btn()
		self:__decompose_btn_click(1)
	end

	function arg_1_0:__onClick_buff_list_buff_storage_tower_buff_storage1_buff_info_panel_decompose_btn()
		self:__decompose_btn_click(2)
	end

	function arg_1_0:__onClick_msg_box_main_quitbtn()
		self._control.msg_box:SetActive(false)
	end

	function arg_1_0.__onClick_msg_box_main_confirmbtn(arg_13_0)
		return
	end

	function arg_1_0:__onClick_msg_box_main_closebtn()
		self._control.msg_box:SetActive(false)
	end

	function arg_1_0:__onClick_bg()
		self:__onClick_return_btn()
	end
end

function var_0_0.extend_obj(arg_16_0)
	return
end

return var_0_0
