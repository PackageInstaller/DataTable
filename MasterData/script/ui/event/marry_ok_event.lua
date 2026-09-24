local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type
local var_0_3 = gamecore.AudioManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_bg()
		self:setVisible(false)
		var_0_3:destroyCV()

		if self._enter_type == "marry" then
			local var_2_0 = var_0_1:getInstance("ship_detail")

			if var_2_0 then
				var_2_0:setVisible(true)
				var_2_0:update_data()
			else
				local var_2_1 = var_0_1:createInstance("ship_detail")

				var_2_1:setVisible(true)
				var_2_1:update_data()
			end

			var_0_1:createInstance("msgbox_marry"):show()
		elseif self._enter_type == var_0_2.enter_marry_ok_type.ship_map then
			local var_2_2 = var_0_1:getInstance("ship_detail")

			if var_2_2 then
				var_2_2:setVisible(true)
			else
				var_0_1:createInstance("ship_detail"):setVisible(true)
			end
		end

		local var_2_3 = var_0_1:getInstance("select_member")

		if var_2_3 then
			var_2_3:__init_character_data_list()
			var_2_3:update_data()
		end

		local var_2_4 = var_0_1:getInstance("ship_map")
		local var_2_5 = var_0_1:getInstance("ship_detail")

		if var_2_4 and var_2_5 then
			var_2_5:setVisible(true)
		elseif var_2_4 and not var_2_5 then
			var_0_1:createInstance("ship_detail"):setVisible(true)
		end

		self:_play_bgm()
	end
end

function var_0_0.extend_obj(arg_3_0)
	return
end

return var_0_0
