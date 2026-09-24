local var_0_0 = {}
local var_0_1 = gamecore.prompt
local var_0_2 = gamecore.Language

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_border_top_close_btn()
		self._open_bathroom_rubdown._allow_mouse_move = true

		self:setVisible(false)
	end

	function arg_1_0:__onToggle_all_do_border_top_repair_switch_repair_off_btn()
		self._is_fast_repair = self._control.border_top.repair_switch.repair_off_btn.toggle.isOn
	end

	function arg_1_0:__onClick_all_repair_layer_info_repair_cancel_btn()
		self._control.all_repair_layer:SetActive(false)
	end

	function arg_1_0:__onClick_all_repair_layer_info_repair_btn()
		if self:__can_repair(self:__get_repair_list(true), true) then
			self:__all_quick_repair()
		end
	end

	function arg_1_0:__onScaleButtonClick_border_top_repair_all_btn()
		local var_6_0 = self:__get_repair_list(true)

		if #self:__sort_ship_by_repair_time(var_6_0, true) == 0 then
			var_0_1:show(var_0_2:getNowLang("no_need_repair"))
		elseif self:__can_repair(var_6_0, true) then
			self:__set_all_repair_layer(var_6_0, true)
			self._control.all_repair_layer:SetActive(true)
		end
	end

	function arg_1_0.__onToggle_border_top_repair_switch_repair_off_btn(arg_7_0)
		return
	end

	function arg_1_0:__onScaleButtonClick_border_top_select_all_btn()
		self:__all_select_repair()

		self._enough_oil = false
		self._enough_fe = false
		self._enough_repair_item = false
	end
end

function var_0_0.extend_obj(arg_9_0)
	return
end

return var_0_0
