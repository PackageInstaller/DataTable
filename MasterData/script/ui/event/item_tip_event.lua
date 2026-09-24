local var_0_0 = {}
local var_0_1 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_content_close_btn()
		var_0_1:play_in_out_animation(self._control.bg.uITweenSequence, false, function()
			self:setVisible(false)
		end)
	end

	function arg_1_0.__onClick_content_detail_detail_btn(arg_4_0)
		return
	end
end

function var_0_0.extend_obj(arg_5_0)
	return
end

return var_0_0
