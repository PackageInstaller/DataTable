local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.user
local var_0_3 = gameenum.common_type
local var_0_4 = gamecore.Language
local var_0_5 = gamecore.prompt
local var_0_6 = table.getn

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onScaleButtonClick_top_layer_returnbtn()
		self:setVisible(false)
		var_0_1:getInstance("dorm_warehouse"):show()
	end

	function arg_1_0:__onClick_order_layer()
		self._control.order_layer_detail.gameObject:SetActive(true)
		self:__show_tween_animation(self._control.order_layer_detail, true)
	end

	function arg_1_0:__onClick_type_layer()
		self:__reset_type_toggle()
		self._control.type_layer_detail.gameObject:SetActive(true)
		self:__show_tween_animation(self._control.type_layer_detail, true)
	end

	function arg_1_0:__onClick_confirm_btn()
		if var_0_6(self._select_furniture_list) == 0 then
			var_0_5:show(var_0_4:getNowLang("furnitureamounttip") .. var_0_4:getNowLang("notenough"))
		else
			var_0_2:req_ResolveFurnitureReq(self._select_furniture_list)
		end
	end

	function arg_1_0:__onClick_order_layer_detail()
		self:__show_tween_animation(self._control.order_layer_detail, false)
	end

	function arg_1_0:__onClick_type_layer_detail()
		self:__show_tween_animation(self._control.type_layer_detail, false)
	end

	function arg_1_0:__onToggle_order_layer_detail_parent_toggle_group_to_1()
		self:__set_select_order_text(var_0_3.order_sort.one)
	end

	function arg_1_0:__onToggle_order_layer_detail_parent_toggle_group_to_2()
		self:__set_select_order_text(var_0_3.order_sort.two)
	end

	function arg_1_0:__onToggle_order_layer_detail_parent_toggle_group_to_3()
		self:__set_select_order_text(var_0_3.order_sort.three)
	end

	function arg_1_0:__onToggle_order_layer_detail_parent_toggle_group_to_4()
		self:__set_select_order_text(var_0_3.order_sort.four)
	end

	function arg_1_0:__onToggle_order_layer_detail_parent_toggle_group_to_5()
		self:__set_select_order_text(var_0_3.order_sort.five)
	end

	function arg_1_0:__onToggle_type_layer_detail_parent_toggle_group_ALL()
		self:__set_select_type_text(var_0_3.furniture_type.All)
	end

	function arg_1_0:__onToggle_type_layer_detail_parent_toggle_group_CV()
		self:__set_select_type_text(var_0_3.furniture_type.Ceiling)
	end

	function arg_1_0:__onToggle_type_layer_detail_parent_toggle_group_CVL()
		self:__set_select_type_text(var_0_3.furniture_type.Wall)
	end

	function arg_1_0:__onToggle_type_layer_detail_parent_toggle_group_AV()
		self:__set_select_type_text(var_0_3.furniture_type.Floor)
	end

	function arg_1_0:__onToggle_type_layer_detail_parent_toggle_group_BB()
		self:__set_select_type_text(var_0_3.furniture_type.Luminaire)
	end

	function arg_1_0:__onToggle_type_layer_detail_parent_toggle_group_BBV()
		self:__set_select_type_text(var_0_3.furniture_type.Hangings)
	end

	function arg_1_0:__onToggle_type_layer_detail_parent_toggle_group_BC()
		self:__set_select_type_text(var_0_3.furniture_type.Doors_Windows)
	end

	function arg_1_0:__onToggle_type_layer_detail_parent_toggle_group_CA()
		self:__set_select_type_text(var_0_3.furniture_type.Bed)
	end

	function arg_1_0:__onToggle_type_layer_detail_parent_toggle_group_CAV()
		self:__set_select_type_text(var_0_3.furniture_type.Tables_Chairs)
	end

	function arg_1_0:__onToggle_type_layer_detail_parent_toggle_group_CLT()
		self:__set_select_type_text(var_0_3.furniture_type.Sofa)
	end

	function arg_1_0:__onToggle_type_layer_detail_parent_toggle_group_CL()
		self:__set_select_type_text(var_0_3.furniture_type.Decorate)
	end

	function arg_1_0:__onToggle_type_layer_detail_parent_toggle_group_BM()
		self:__set_select_type_text(var_0_3.furniture_type.Carpet)
	end

	function arg_1_0:__onToggle_type_layer_detail_parent_toggle_group_DD()
		self:__set_select_type_text(var_0_3.furniture_type.Toys)
	end

	function arg_1_0:__onToggle_type_layer_detail_parent_toggle_group_SSG()
		self:__set_select_type_text(var_0_3.furniture_type.Pets)
	end

	function arg_1_0:__set_select_type_text(arg_27_1)
		self:__show_tween_animation(self._control.type_layer_detail, false)

		if self._now_type == arg_27_1 then
			return
		end

		self._now_type = arg_27_1
		self._control.type_layer.type_des.text.text = var_0_4:getNowLang("furnituretype" .. arg_27_1)

		self:update_recycle_screen_data()
		self:__reset_recycle_scroll_view_position()
	end

	function arg_1_0:__set_select_order_text(arg_28_1)
		self:__show_tween_animation(self._control.order_layer_detail, false)

		if self._now_order == arg_28_1 then
			return
		end

		self._now_order = arg_28_1
		self._control.order_layer.type_des.text.text = var_0_4:getNowLang("furnituresorttype_s" .. arg_28_1)

		self:update_recycle_screen_data()
		self:__reset_recycle_scroll_view_position()
	end

	function arg_1_0:__show_tween_animation(arg_29_1, arg_29_2)
		self:play_bg_in_animation(arg_29_1, arg_29_2, function()
			if not arg_29_2 then
				arg_29_1.gameObject:SetActive(false)
			end
		end)
	end

	function arg_1_0:__reset_type_toggle()
		for iter_31_0 = 0, self._type_toggle_group.transform.childCount - 1 do
			self._type_toggle_group.transform:GetChild(iter_31_0):GetComponent("Toggle").isOn = false
		end
	end

	function arg_1_0:__onClick_fast_choose_btn()
		self:fast_choose_furniture()
		self:__update_cell()
		self:__show_fur_point_add_data()
	end
end

function var_0_0.extend_obj(arg_33_0)
	return
end

return var_0_0
