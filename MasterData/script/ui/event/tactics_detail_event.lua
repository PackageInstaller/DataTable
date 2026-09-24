local var_0_0 = {}

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_tactics_bg_close_btn()
		self:setVisible(false)
	end

	function arg_1_0:__onClick_tactics_bg_left_btn()
		self:show(nil, self._now_sort - 1)
	end

	function arg_1_0:__onClick_tactics_bg_right_btn()
		self:show(nil, self._now_sort + 1)
	end
end

function var_0_0.extend_obj(arg_5_0)
	return
end

return var_0_0
