local var_0_0 = {}
local var_0_1 = gamecore.UILoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_returnbtn()
		for iter_2_0 = 1, #self:__filtrate_by_rule() do
			self:__hide_all_furniture_to_pool(iter_2_0 - 1)
		end

		var_0_1:destroyInstance("dormitory_design_list")
		var_0_1:destroyInstance("dormitory_design_detail")

		local var_2_0 = var_0_1:getInstance("dormitory")

		var_2_0:setVisible(true)
		var_2_0:set_special_sortingOrder()
	end

	function arg_1_0:__onClick_search_btn()
		self:__click_search_btn_event()
	end

	function arg_1_0:__onClick_order_layer()
		self:__show_order_type_layer(true)
	end

	function arg_1_0:__onClick_type_layer()
		self:__show_heat_type_layer(true)
	end

	function arg_1_0:__onClick_my_favorite_btn()
		self:__click_my_favorite_btn_event()
	end

	function arg_1_0:__onClick_order_layer_detail()
		self:__show_order_type_layer(false)
	end

	function arg_1_0:__onClick_order_layer_detail_order1()
		self:__click_order_type_btns_event(self._sort_type_list.designsorttype1)
	end

	function arg_1_0:__onClick_order_layer_detail_order2()
		self:__click_order_type_btns_event(self._sort_type_list.designsorttype2)
	end

	function arg_1_0:__onClick_order_layer_detail_order3()
		self:__click_order_type_btns_event(self._sort_type_list.designsorttype3)
	end

	function arg_1_0:__onClick_order_layer_detail_order4()
		self:__click_order_type_btns_event(self._sort_type_list.designsorttype4)
	end

	function arg_1_0:__onClick_type_layer_detail()
		self:__show_heat_type_layer(false)
	end

	function arg_1_0:__onClick_type_layer_detail_type1()
		self:__click_heat_type_btns_event(self._heat_type_list.roomdesigntype1)
	end

	function arg_1_0:__onClick_type_layer_detail_type2()
		self:__click_heat_type_btns_event(self._heat_type_list.roomdesigntype2)
	end

	function arg_1_0:__onClick_type_layer_detail_type3()
		self:__click_heat_type_btns_event(self._heat_type_list.roomdesigntype3)
	end

	function arg_1_0:__onClick_type_layer_detail_type4()
		self:__click_heat_type_btns_event(self._heat_type_list.roomdesigntype4)
	end

	function arg_1_0:__onScaleButtonClick_search_layer_bg_close_btn()
		self:__show_search_layer(false)
	end

	function arg_1_0:__onClick_search_layer_bg_confirm_btn()
		self:__click_search_confirm_btn_event()
	end
end

function var_0_0.extend_obj(arg_19_0)
	return
end

return var_0_0
