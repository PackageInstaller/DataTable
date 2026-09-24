local var_0_0 = {}
local var_0_1 = gamecore.UILoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.__onClick_select_btn(arg_2_0)
		return
	end

	function arg_1_0:__onClick_item_bg_select_btn()
		if self._data_id and self._data_id == 10000113 then
			return
		end

		self.click_ship_info = self._data_id

		local var_3_0 = var_0_1:getInstance("research_bureau")

		if var_3_0 then
			var_3_0._now_click_ship_id = self.click_ship_info

			var_3_0:__update_reusable_cell()
			var_3_0:__set_now_ship_info(nil, nil, self.click_ship_info)
		end
	end

	function arg_1_0.__onClick_item_bg_add_btn(arg_4_0)
		return
	end

	function arg_1_0.__onClick_item_bg_subtract_btn(arg_5_0)
		return
	end
end

function var_0_0.extend_obj(arg_6_0)
	return
end

return var_0_0
