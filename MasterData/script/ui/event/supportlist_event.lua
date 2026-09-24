local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_cardintroduce_mainintroduce_btn()
		local var_2_0, var_2_1, var_2_2 = var_0_1:get_support_notify()

		if var_2_2 >= self._support_config.need_achievement and self._support_up == false then
			var_0_1:req_changeranksupportreq(self._support_config.id)
		end
	end

	function arg_1_0:__onClick_cardintroduce_top_back()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.back))
		self:setVisible(false)
	end

	function arg_1_0.__onClick_cardintroduce_allcards_cardscell_main_btn(arg_4_0)
		return
	end

	function arg_1_0.__onClick_cardintroduce_allcards_cardscell_select(arg_5_0)
		return
	end
end

function var_0_0.extend_obj(arg_6_0)
	return
end

return var_0_0
