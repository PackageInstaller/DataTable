local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type
local var_0_3 = gamecore.Language
local var_0_4 = string.format

function var_0_0.extend_method(arg_1_0)
	local var_1_0 = 1

	function arg_1_0.__onScaleButtonClick_return_btn(arg_2_0)
		var_1_0 = 1

		var_0_1:destroyInstance("show_room_medal")
		var_0_1:createInstance("show_room"):show()
	end

	function arg_1_0:__onClick_show_medal()
		if var_1_0 == 1 then
			self:set_user_madel_data()
			self:play_in_animation_1(self:play_out_animation_1())

			var_1_0 = 2
		else
			self:set_user_madel_data()
			self:play_in_animation_2(self:play_out_animation_2())

			var_1_0 = 1
		end

		self:init_medal_cell_list(1)
	end

	function arg_1_0:__onClick_use_medal()
		if #self.is_have_medal_list <= 1 or #self.is_have_medal_list == #self.show_medal_list or #self.show_medal_list == 5 then
			self:use_medal()
			self:__onScaleButtonClick_return_btn()
		elseif #self.is_have_medal_list < 5 then
			self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))

			self._control.supplement_tips.expand_des.text.text = var_0_4(var_0_3:getNowLang("titlesetmedalinfo"), #self.is_have_medal_list)

			self._control.supplement_tips:SetActive(true)
		elseif #self.is_have_medal_list >= 5 then
			self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))

			self._control.supplement_tips.expand_des.text.text = var_0_4(var_0_3:getNowLang("titlesetmedalinfo"), 5)

			self._control.supplement_tips:SetActive(true)
		end
	end

	function arg_1_0:__onClick_supplement_tips_supplement_btn()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))
		self._control.supplement_tips:SetActive(false)
		self:supplement_medal(true)
		self:__onScaleButtonClick_return_btn()
	end

	function arg_1_0:__onClick_supplement_tips_cancel_btn()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.back))
		self._control.supplement_tips:SetActive(false)
		self:supplement_medal(false)
		self:__onScaleButtonClick_return_btn()
	end

	function arg_1_0:__onClick_type()
		self:change_medal_type()
	end

	function arg_1_0.__onScaleButtonClick_bg_top_menu_return_btn(arg_8_0)
		var_1_0 = 1

		var_0_1:destroyInstance("show_room_medal")
		var_0_1:createInstance("show_room"):show()
	end
end

function var_0_0.extend_obj(arg_9_0)
	return
end

return var_0_0
