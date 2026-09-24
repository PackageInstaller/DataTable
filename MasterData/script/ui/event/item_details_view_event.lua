local var_0_0 = {}
local var_0_3 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_top_layer_returnbtn()
		self:setVisible(false)

		if self._confirm_listener then
			self._confirm_listener()
		end
	end

	function arg_1_0:__onClick_right_layer_type_layer()
		self:__set_detail_page_state(true)
	end

	function arg_1_0:__onClick_type_layer_detail()
		self:__set_detail_page_state(false)
	end

	function arg_1_0:__onToggle_type_layer_detail_toggle_group_all()
		self:__set_select_type_text(var_0_3.furniture_type.All)
	end

	function arg_1_0:__onToggle_type_layer_detail_toggle_group_item_parent_CV()
		self:__set_select_type_text(var_0_3.furniture_type.Ceiling)
	end

	function arg_1_0:__onToggle_type_layer_detail_toggle_group_item_parent_CVL()
		self:__set_select_type_text(var_0_3.furniture_type.Wall)
	end

	function arg_1_0:__onToggle_type_layer_detail_toggle_group_item_parent_AV()
		self:__set_select_type_text(var_0_3.furniture_type.Floor)
	end

	function arg_1_0:__onToggle_type_layer_detail_toggle_group_item_parent_BB()
		self:__set_select_type_text(var_0_3.furniture_type.Luminaire)
	end

	function arg_1_0:__onToggle_type_layer_detail_toggle_group_item_parent_BBV()
		self:__set_select_type_text(var_0_3.furniture_type.Hangings)
	end

	function arg_1_0:__onToggle_type_layer_detail_toggle_group_item_parent_BC()
		self:__set_select_type_text(var_0_3.furniture_type.Doors_Windows)
	end

	function arg_1_0:__onToggle_type_layer_detail_toggle_group_item_parent_CA()
		self:__set_select_type_text(var_0_3.furniture_type.Bed)
	end

	function arg_1_0:__onToggle_type_layer_detail_toggle_group_item_parent_CAV()
		self:__set_select_type_text(var_0_3.furniture_type.Tables_Chairs)
	end

	function arg_1_0:__onToggle_type_layer_detail_toggle_group_item_parent_CLT()
		self:__set_select_type_text(var_0_3.furniture_type.Sofa)
	end

	function arg_1_0:__onToggle_type_layer_detail_toggle_group_item_parent_CL()
		self:__set_select_type_text(var_0_3.furniture_type.Decorate)
	end

	function arg_1_0:__onToggle_type_layer_detail_toggle_group_item_parent_BM()
		self:__set_select_type_text(var_0_3.furniture_type.Carpet)
	end

	function arg_1_0:__onToggle_type_layer_detail_toggle_group_item_parent_DD()
		self:__set_select_type_text(var_0_3.furniture_type.Toys)
	end

	function arg_1_0:__onToggle_type_layer_detail_toggle_group_item_parent_SSG()
		self:__set_select_type_text(var_0_3.furniture_type.Pets)
	end

	function arg_1_0:__onToggle_type_layer_detail_toggle_group_item_parent_SS()
		self:__set_select_type_text(var_0_3.furniture_type.Menu)
	end

	function arg_1_0:__set_detail_page_state(arg_20_1)
		self._control.type_layer_detail.gameObject:SetActive(arg_20_1)
	end

	function arg_1_0:__set_select_type_text(arg_21_1)
		self:__set_detail_page_state(false)

		if self._record_select_type == arg_21_1 then
			return
		end

		self._record_select_type = arg_21_1

		self:__refesh_sort_text(arg_21_1)
		self:update_now_data(arg_21_1)
	end
end

function var_0_0.extend_obj(arg_22_0)
	return
end

return var_0_0
