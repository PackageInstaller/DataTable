local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_top_return_btn()
		self:setVisible(false)
		var_0_1:destroyInstance("eighth_support_layer")

		local var_2_0 = var_0_1:getInstance("eighth_main_map")

		if var_2_0 then
			var_2_0:setVisible(true)
		else
			var_0_1:createInstance("eighth_main_map"):show(data_id)
		end

		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.back))
	end
end

function var_0_0.extend_obj(arg_3_0)
	return
end

return var_0_0
