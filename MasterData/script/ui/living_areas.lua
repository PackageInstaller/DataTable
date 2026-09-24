local var_0_0 = {}
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = gameenum.common_type

gamecore.UILoader:define("living_areas", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)
		self:__set_school_panel_state()

		if not self._already_init then
			self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.living_bgm))
		end

		self._already_init = true

		if not arg_2_1 then
			var_0_4:play_in_out_animation(self._control.background.uITweenSequence, true)
		end
	end

	function arg_1_0:__set_school_panel_state()
		local var_3_0 = var_0_3:get_character_level_data()

		self._control.background.school_btn.button.interactable = var_3_0
		self._control.background.school_title_btn.button.interactable = var_3_0
	end

	function arg_1_0:_play_audio(arg_4_1)
		self:playBackgroundMusic(arg_4_1)
	end

	function arg_1_0:_play_into_se(arg_5_1)
		self:playSE(arg_5_1, false)
	end

	function arg_1_0.__onDestroy(arg_6_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_7_0)
	local var_7_0 = var_0_2:class("living_areas")

	var_7_0._already_init = false

	return var_7_0
end

return var_0_0
