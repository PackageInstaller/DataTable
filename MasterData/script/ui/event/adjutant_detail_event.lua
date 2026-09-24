local var_0_0 = {}
local var_0_1 = gamecore.user

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_tactics_bg_close_btn()
		self:setVisible(false)
	end

	function arg_1_0:__onClick_tactics_bg_center_bottom_btn()
		if self._is_nf then
			var_0_1:req_MistChangeAdjutantReq(self._adjutant_set[self._current_card_index])
		else
			var_0_1:req_SixthChangeAdjutantReq(self._adjutant_set[self._current_card_index])
		end

		self:setVisible(false)
	end

	function arg_1_0:__onClick_left_btn()
		self:__move_animation(true, self._current_card_index == self._min_card_index and self._max_card_index or self._current_card_index - 1)
	end

	function arg_1_0:__onClick_right_btn()
		self:__move_animation(false, self._current_card_index == self._max_card_index and self._min_card_index or self._current_card_index + 1)
	end

	function arg_1_0:__onClick_tactics_bg_left_btn()
		self:__move_animation(true, self._current_card_index == self._min_card_index and self._max_card_index or self._current_card_index - 1)
	end

	function arg_1_0:__onClick_tactics_bg_right_btn()
		self:__move_animation(false, self._current_card_index == self._max_card_index and self._min_card_index or self._current_card_index + 1)
	end
end

function var_0_0.extend_obj(arg_8_0)
	return
end

return var_0_0
