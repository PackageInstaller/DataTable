local var_0_0 = {}
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_5 = gameconfig.expedition_config

gamecore.UILoader:define("farfight", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:__init_data()
		self:__init_panel()
	end

	function arg_1_0:destroy_panel()
		self:destroy()
	end

	function arg_1_0:update_content(arg_4_1)
		local var_4_0 = var_0_2:getInstance("gotofight")

		if var_4_0 then
			var_4_0:set_current_far_toggle_index(arg_4_1)
		end

		self:__toggle_items_lock(not self:__check_unlock_state(arg_4_1), arg_4_1)
	end

	function arg_1_0:update()
		for iter_5_0, iter_5_1 in ipairs(self._item_tb) do
			iter_5_1:update()
		end
	end

	function arg_1_0.__get_table_length(arg_6_0, arg_6_1)
		if not arg_6_1 or arg_6_1 == {} then
			return 0
		end

		return #arg_6_1
	end

	function arg_1_0:__create_item_to_num(arg_7_1)
		self._item_tb = self._item_tb or {}

		local var_7_0 = arg_7_1 - self:__get_table_length(self._item_tb)

		if var_7_0 <= 0 then
			return
		end

		for iter_7_0 = 1, var_7_0 do
			local var_7_1 = self:loadUI("farfight_item")

			var_7_1._panel.transform:SetParent(self._control.scroll_view.viewport.content.transform, false)
			var_7_1:show()

			self._item_tb[#self._item_tb + 1] = var_7_1
		end
	end

	function arg_1_0:__init_panel()
		self:__create_item_to_num(#self._data[1])
	end

	function arg_1_0:__init_data()
		self._data = {}

		local var_9_0, var_9_1 = var_0_5.get_sequence()

		for iter_9_0, iter_9_1 in ipairs(var_9_0) do
			local var_9_2 = tonumber(iter_9_1.pve_id)

			if self._data[var_9_2] == nil then
				self._data[var_9_2] = {}
			end

			self._data[var_9_2][#self._data[var_9_2] + 1] = iter_9_1
		end
	end

	function arg_1_0.__check_unlock_state(arg_10_0, arg_10_1)
		if not var_0_3._data.expedition_open or not next(var_0_3._data.expedition_open) then
			return false
		end

		local var_10_0 = arg_10_1

		for iter_10_0, iter_10_1 in ipairs(var_0_3._data.expedition_open) do
			if tonumber(iter_10_1) == tonumber(var_10_0) then
				return true
			end
		end

		return false
	end

	function arg_1_0:__toggle_items_lock(arg_11_1, arg_11_2)
		if arg_11_2 <= var_0_3:get_main_line_max_chapter() / 100 then
			arg_11_1 = false
		end

		local var_11_0

		for iter_11_0, iter_11_1 in ipairs(self._item_tb) do
			local var_11_1 = self._data[tonumber(arg_11_2)]

			if var_11_1 then
				var_11_0 = var_11_1[iter_11_0]

				if var_11_1[iter_11_0] then
					iter_11_1:show()
				else
					iter_11_1:hide()
				end
			end

			iter_11_1:toggle_lock(arg_11_1, var_11_0, arg_11_2)
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_12_0)
	local var_12_0 = var_0_2:class("farfight")

	var_12_0._data = {}
	var_12_0._item_tb = {}

	return var_12_0
end

return var_0_0
