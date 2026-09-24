local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type
local var_0_3 = gamecore.user

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_bg_bg_btn()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))
		var_0_1:createInstance("enemy_ship_detail"):show(self._data)
		var_0_3:set_maneuver_target_info(self._data)
	end

	function arg_1_0:__onScaleButtonClick_bg_bg_btn_fight_btn()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))
		var_0_1:createInstance("enemy_ship_detail"):show(self._data)
		var_0_3:set_maneuver_target_info(self._data)
	end
end

function var_0_0.extend_obj(arg_4_0)
	return
end

return var_0_0
