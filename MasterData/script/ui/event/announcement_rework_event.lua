local var_0_0 = {}
local var_0_2 = gamecore.UILoader
local var_0_3 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_main_info_viewport_content_single_announcement_single_announcement_one_info_btn()
		self._control.main_info.viewport:SetActive(false)
		self:set_detail_info(1)
		self._control.detail_info:SetActive(true)
		self:__set_scroll_to_top()
	end

	function arg_1_0:__onClick_main_info_viewport_content_single_announcement_single_announcement_two_info_btn()
		self._control.main_info.viewport:SetActive(false)
		self:set_detail_info(2)
		self._control.detail_info:SetActive(true)
		self:__set_scroll_to_top()
	end

	function arg_1_0:__onClick_main_info_viewport_content_single_announcement_single_announcement_three_info_btn()
		self._control.main_info.viewport:SetActive(false)
		self:set_detail_info(3)
		self._control.detail_info:SetActive(true)
		self:__set_scroll_to_top()
	end

	function arg_1_0:__onClick_main_info_viewport_content_single_announcement_single_announcement_four_info_btn()
		self._control.main_info.viewport:SetActive(false)
		self:set_detail_info(4)
		self._control.detail_info:SetActive(true)
		self:__set_scroll_to_top()
	end

	function arg_1_0:__onClick_main_info_viewport_content_single_announcement_single_announcement_five_info_btn()
		self._control.main_info.viewport:SetActive(false)
		self:set_detail_info(5)
		self._control.detail_info:SetActive(true)
		self:__set_scroll_to_top()
	end

	function arg_1_0:__onClick_detail_info_detail_announcement_info_btn()
		self._single_announcement_show = false

		self._control.main_info.viewport:SetActive(true)
		self._control.detail_info:SetActive(false)
	end

	function arg_1_0:__onClick_main_info_viewport_content_activity_pic()
		if self._now_pic_num ~= 0 then
			self._control.main_info.viewport:SetActive(false)
			self:set_detail_info(self._now_pic_num)
			self._control.detail_info:SetActive(true)
			self:__set_scroll_to_top()
		end
	end

	function arg_1_0.__onToggle_main_info_toggle(arg_9_0)
		return
	end

	function arg_1_0:__onScaleButtonClick_main_info_returnbtn()
		if self._single_announcement_show then
			self._single_announcement_show = false

			self._control.main_info.viewport:SetActive(true)
			self._control.detail_info:SetActive(false)
		else
			self._announc_seq:Pause()

			self.is_req_announcement = self._control.main_info.toggle:GetComponent("Toggle").isOn == true

			self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))

			if var_0_2:getInstance("announcement_rework") then
				var_0_2:destroyInstance("announcement_rework")
			end

			local var_10_0 = var_0_2:getInstance("home")

			if var_10_0 then
				var_10_0:init_issignin()
			end
		end
	end
end

function var_0_0.extend_obj(arg_11_0)
	return
end

return var_0_0
