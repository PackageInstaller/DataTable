local var_0_0 = {}
local var_0_2 = gamecore.UILoader
local var_0_3 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_main_confirm()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))
		self:__show_special_item_detail()

		if self._enter_type == var_0_3.pve_active_type.score_event and self._func then
			self._func()
		end

		var_0_2:destroyInstance("mail_box")
	end
end

function var_0_0.extend_obj(arg_3_0)
	return
end

return var_0_0
