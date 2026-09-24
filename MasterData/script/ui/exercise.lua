local var_0_0 = {}
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user

gamecore.UILoader:define("exercise", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:__init_panel()
	end

	function arg_1_0:destroy_panel()
		for iter_3_0, iter_3_1 in ipairs(self._item_tb) do
			iter_3_1:destroy()
		end

		self:destroy()
	end

	function arg_1_0:__init_panel()
		self:set_panel_info()
	end

	function arg_1_0:set_panel_info()
		self._data = var_0_3:get_maneuver_data()

		for iter_5_0, iter_5_1 in ipairs(self._data) do
			local var_5_0 = not self._item_tb[iter_5_0] and self:loadUI("exercise_item") or self._item_tb[iter_5_0]

			var_5_0._panel.transform:SetParent(self._control.scroll_view.viewport.content.transform, false)
			var_5_0:show(iter_5_1)

			self._item_tb[iter_5_0] = var_5_0
		end

		local var_5_1 = lan_rand(1, 5)
	end

	function arg_1_0:update_exercise_item_panel(arg_6_1)
		for iter_6_0, iter_6_1 in ipairs(self._data) do
			if arg_6_1.id == iter_6_1.id then
				self._item_tb[iter_6_0]:update_exercise_item_panel(arg_6_1)
			end
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_7_0)
	local var_7_0 = var_0_2:class("exercise")

	var_7_0._data = nil
	var_7_0._item_tb = {}

	return var_7_0
end

return var_0_0
