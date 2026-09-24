local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_main_closebtn()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.back))
		var_0_2:play_in_out_animation(self._control.maskbg.uITweenSequence, false, function()
			self:setVisible(false)
		end)
	end

	function arg_1_0:__onClick_main_detailsbtn()
		self:setVisible(false)

		if self._close_listener then
			self._close_listener()
		end

		local var_4_0 = var_0_1:createInstance("item_details_view")

		var_4_0:show(self._item_id)
		var_4_0:set_listener(function()
			self._confirm_listener()
		end)
	end
end

function var_0_0.extend_obj(arg_6_0)
	return
end

return var_0_0
