local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language
local var_0_3 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onScaleButtonClick_top_layer_returnbtn()
		self:setVisible(false)
		self:return_lock_state()

		local var_2_0 = var_0_1:getInstance("dormitory")

		if var_2_0 then
			var_2_0:setVisible(true)
			var_2_0:set_special_sortingOrder()
		end
	end

	function arg_1_0:__onClick_order_layer()
		self:__set_order_layer_state(true)
	end

	function arg_1_0:__onClick_type_layer()
		self:__set_type_layer_state(true)
	end

	function arg_1_0:__onClick_recycle_btn()
		self:setVisible(false)

		local var_5_0 = var_0_1:createInstance("furniture_recycle_panel")

		var_5_0:show(self._furniture_sever_data)
		var_5_0:__reset_recycle_scroll_view_position()
	end

	function arg_1_0:__onClick_exchange_btn()
		self:setVisible(false)
		var_0_1:createInstance("exchange_shop_panel"):show()
	end

	function arg_1_0:__onClick_lock_btn()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.task_goto))
		self:switch_lock_state()
	end

	function arg_1_0:__onClick_order_layer_detail()
		self:__set_order_layer_state(false)
	end

	function arg_1_0:__onToggle_order_layer_detail_toggle_group_to_1()
		self:__set_select_order_text(var_0_3.order_sort.one)
	end

	function arg_1_0:__onToggle_order_layer_detail_toggle_group_to_2()
		self:__set_select_order_text(var_0_3.order_sort.two)
	end

	function arg_1_0:__onToggle_order_layer_detail_toggle_group_to_3()
		self:__set_select_order_text(var_0_3.order_sort.three)
	end

	function arg_1_0:__onToggle_order_layer_detail_toggle_group_to_4()
		self:__set_select_order_text(var_0_3.order_sort.four)
	end

	function arg_1_0:__onToggle_order_layer_detail_toggle_group_to_5()
		self:__set_select_order_text(var_0_3.order_sort.five)
	end

	function arg_1_0:__onClick_type_layer_detail()
		self:__set_type_layer_state(false)
	end

	function arg_1_0:__onToggle_type_layer_detail_toggle_group_ALL()
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

	function arg_1_0:__set_type_layer_state(arg_29_1)
		self._control.type_layer_detail.gameObject:SetActive(arg_29_1)
	end

	function arg_1_0:__set_order_layer_state(arg_30_1)
		self._control.order_layer_detail.gameObject:SetActive(arg_30_1)
	end

	function arg_1_0:__set_select_type_text(arg_31_1)
		self:__set_type_layer_state(false)

		if self._now_type == arg_31_1 then
			return
		end

		self._now_type = arg_31_1
		self._control.type_layer.type_des.text.text = var_0_2:getNowLang("furnituretype" .. arg_31_1)

		self:update_screen_data()
		self:__reset_scroll_view_position()
	end

	function arg_1_0:__set_select_order_text(arg_32_1)
		self:__set_order_layer_state(false)

		if self._now_order == arg_32_1 then
			return
		end

		self._now_order = arg_32_1
		self._control.order_layer.type_des.text.text = var_0_2:getNowLang("furnituresorttype_s" .. arg_32_1)

		self:update_screen_data()
		self:__reset_scroll_view_position()
	end
end

function var_0_0.extend_obj(arg_33_0)
	return
end

return var_0_0
