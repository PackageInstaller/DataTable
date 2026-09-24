local var_0_0 = {}
local var_0_1 = gamecore.UILoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.__onClick_enemy_buff_back_btn(arg_2_0)
		return
	end

	function arg_1_0:__onClick_tip_layer_enemy_buff_back_btn()
		var_0_1:destroyInstance("eighth_enemy_buff")
		self:setVisible(false)

		local var_3_0 = var_0_1:getInstance("eighth_sea_map")

		if var_3_0 then
			var_3_0._control.cover_2:SetActive(false)
		end
	end
end

function var_0_0.extend_obj(arg_4_0)
	return
end

return var_0_0
