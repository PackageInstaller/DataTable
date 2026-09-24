local var_0_0 = {}
local var_0_1 = gamecore.UILoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_Button()
		self:show_weather_detail()
	end

	function arg_1_0:__onClick_extra_btn()
		local var_3_0 = var_0_1:getInstance("fight_prepare")

		if var_3_0 then
			var_3_0:show_strike_buff(self._data_id)
		end
	end
end

function var_0_0.extend_obj(arg_4_0)
	return
end

return var_0_0
