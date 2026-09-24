local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_awardbox_bg_top_toptitle_back_btn()
		self:setVisible(false)

		if not var_0_1:getInstance("ocean_main_map") then
			local var_2_0 = var_0_1:createInstance("fifth_event")

			var_2_0:show()
			var_2_0:check_main_reward()
		end
	end

	function arg_1_0.__onClick_awardbox_bg_middle_lefthandle(arg_3_0)
		return
	end

	function arg_1_0.__onClick_awardbox_bg_middle_righthandle(arg_4_0)
		return
	end

	function arg_1_0:__onClick_award_msgbox_main_confirm()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.back))

		if self._close_func then
			self._close_func()
		end

		self._control.award_msgbox.gameObject:SetActive(false)
	end

	function arg_1_0:__onClick_award_msgbox_main_close()
		self._control.award_msgbox.gameObject:SetActive(false)
	end

	function arg_1_0:__onClick_detail_shadow()
		self._control.detail_shadow.gameObject:SetActive(false)
		self._equip_attr._panel.gameObject:SetActive(false)
		var_0_1:destroyInstance("equip_attr")
	end
end

function var_0_0.extend_obj(arg_8_0)
	return
end

return var_0_0
