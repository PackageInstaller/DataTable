local var_0_0 = {}
local var_0_2 = gamecore.UILoader
local var_0_7 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.__onClick_awardbox_bg_top_close(arg_2_0)
		var_0_2:destroyInstance("awardbox")

		local var_2_0 = var_0_2:getInstance("climb_tower")

		if var_2_0 then
			var_2_0:set_tower_panel_block_raycasts(true)
		else
			var_0_2:createInstance("climb_tower"):show()
		end
	end

	function arg_1_0:__onClick_awardbox_bg_middle_lefthandle()
		self.__now_page = self.__now_page - 1

		self:__init_select()
	end

	function arg_1_0:__onClick_awardbox_bg_middle_righthandle()
		self.__now_page = self.__now_page + 1

		self:__init_select()
	end

	function arg_1_0:__onClick_detail_shadow()
		self._control.detail_shadow.gameObject:SetActive(false)
		self._equip_attr:setVisible(false)
	end

	function arg_1_0:__onClick_award_msgbox_main_close()
		self._control.award_msgbox.gameObject:SetActive(false)
	end

	function arg_1_0:__onClick_award_msgbox_main_confirm()
		self:_play_into_se(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.back))
		self._control.award_msgbox.gameObject:SetActive(false)
	end
end

function var_0_0.extend_obj(arg_8_0)
	return
end

return var_0_0
