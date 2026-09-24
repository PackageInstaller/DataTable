local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_3 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_cook_info_close_btn()
		self:setVisible(false)
	end

	function arg_1_0:__onClick_cook_info_set_btn()
		if self._tyle == 1 then
			if self._now_cookbook_info_tyle == 1 then
				var_0_1:req_SetCookBookReq(self._food_cid)
			else
				var_0_1:req_RemoveCookBookReq(self._food_cid)
			end

			self:setVisible(false)
		elseif self:is_have_buff() then
			self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.open))
			self._control.new_buff:SetActive(true)
		else
			self:__can_cook()
		end
	end

	function arg_1_0:__onClick_new_buff_confirm_btn()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.open))
		self:__can_cook()
		self._control.new_buff:SetActive(false)
	end

	function arg_1_0:__onClick_new_buff_cancel_btn()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))
		self._control.new_buff:SetActive(false)
	end

	function arg_1_0:__onClick_cook_get_info_close_btn()
		self:setVisible(false)
	end
end

function var_0_0.extend_obj(arg_7_0)
	return
end

return var_0_0
