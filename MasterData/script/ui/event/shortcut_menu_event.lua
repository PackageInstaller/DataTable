local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.AudioManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_content_dock_team_btn()
		if self._is_hight_light then
			var_0_1:createInstance("home"):setVisible(false)
			var_0_1:createInstance("six_year_main_interface"):show()
			var_0_2:destroyCV()
		end

		var_0_1:destroyInstance("shortcut_menu")
	end

	function arg_1_0:__onClick_content_dock_btn()
		if self._is_hight_light then
			local var_3_0 = var_0_1:getInstance("shortcut_menu")

			if var_3_0 then
				var_3_0:setVisible(false)
			end

			var_0_1:createInstance("home"):setVisible(false)

			local var_3_1 = var_0_1:createInstance("dock")

			var_3_1:show(true)
			var_3_1:set_enter_type("home")
			var_0_2:destroyCV()
		end

		var_0_1:destroyInstance("shortcut_menu")
	end

	function arg_1_0:__onClick_content_remake_btn()
		if self._is_hight_light then
			var_0_1:createInstance("home"):setVisible(false)

			local var_4_0 = var_0_1:createInstance("remake")

			var_4_0:show(true)
			var_4_0:set_enter_type("home")
			var_0_2:destroyCV()
		end

		var_0_1:destroyInstance("shortcut_menu")
	end

	function arg_1_0:__onClick_content_restaurant_btn()
		if self._is_hight_light then
			var_0_1:createInstance("home"):setVisible(false)
			var_0_1:createInstance("restaurant"):show()
			var_0_2:destroyCV()
		end

		var_0_1:destroyInstance("shortcut_menu")
	end

	function arg_1_0:__onClick_content_repair_btn()
		if self._is_hight_light then
			self:setVisible(false)
			var_0_1:createInstance("home"):setVisible(false)
			var_0_1:createInstance("bathroom"):show()
			var_0_2:destroyCV()
		end

		var_0_1:destroyInstance("shortcut_menu")
	end

	function arg_1_0:__onClick_content_equipment_btn()
		if self._is_hight_light then
			var_0_1:createInstance("home"):setVisible(false)

			local var_7_0 = var_0_1:createInstance("dock_team")

			var_7_0:show(true)
			var_7_0:set_equipment_tab()
			var_0_2:destroyCV()
		end

		var_0_1:destroyInstance("shortcut_menu")
	end
end

function var_0_0.extend_obj(arg_8_0)
	return
end

return var_0_0
