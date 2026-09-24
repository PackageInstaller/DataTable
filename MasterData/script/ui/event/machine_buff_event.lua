local var_0_0 = {}
local var_0_3 = gamecore.UILoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_single_bg_equip_btn()
		var_0_3:createInstance("tactical_machine"):buff_equip_click(self._cur_index + 1)
	end

	function arg_1_0:__onClick_bg_replace_btn()
		if self._buff_id then
			var_0_3:createInstance("tactical_machine"):buff_equip_click(self._cur_index + 1, true, self._buff_id)
		end
	end
end

function var_0_0.extend_obj(arg_4_0)
	return
end

return var_0_0
