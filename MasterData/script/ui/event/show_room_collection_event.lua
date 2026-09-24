local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_7 = gameenum.common_type
local var_0_8 = gamecore.util_func

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_btn_l()
		self:colliection_move_in_animation(true)
		self:show_scroll_by_index(2)
		self._control.type_btn.gameObject:SetActive(false)
		self:init_collection_cell_list()
	end

	function arg_1_0:__onClick_btn_r()
		self:colliection_move_in_animation(false)
		self:show_scroll_by_index(1)
		self._control.type_btn.gameObject:SetActive(true)
		self:__update_cell()
	end

	function arg_1_0:__onClick_return_btn()
		self.table = {}
		self.collection_desk_config_list = {}
		self.collection_wall_config_list = {}
		self._control.scrollview_1.viewport.content.transform.anchoredPosition = Vector2(0, 0)
		self._control.scrollview_2.viewport.content.transform.anchoredPosition = Vector2(0, 0)

		self:setVisible(false)
	end

	function arg_1_0.__onPointerDown_collection_move_collection_wall_showcase_l_wall_area_1(arg_5_0)
		return
	end

	function arg_1_0.__onPointerUp_collection_move_collection_wall_showcase_l_wall_area_1(arg_6_0)
		return
	end

	function arg_1_0.__onPointerDown_collection_move_collection_wall_showcase_l_wall_area_2(arg_7_0)
		return
	end

	function arg_1_0.__onPointerUp_collection_move_collection_wall_showcase_l_wall_area_2(arg_8_0)
		return
	end

	function arg_1_0.__onPointerDown_collection_move_collection_wall_showcase_l_wall_area_3(arg_9_0)
		return
	end

	function arg_1_0.__onPointerUp_collection_move_collection_wall_showcase_l_wall_area_3(arg_10_0)
		return
	end

	function arg_1_0.__onPointerDown_collection_move_collection_wall_showcase_l_wall_area_4(arg_11_0)
		return
	end

	function arg_1_0.__onPointerUp_collection_move_collection_wall_showcase_l_wall_area_4(arg_12_0)
		return
	end

	function arg_1_0.__onPointerDown_collection_move_collection_wall_showcase_l_wall_area_5(arg_13_0)
		return
	end

	function arg_1_0.__onPointerUp_collection_move_collection_wall_showcase_l_wall_area_5(arg_14_0)
		return
	end

	function arg_1_0.__onPointerDown_collection_move_collection_wall_showcase_l_wall_area_6(arg_15_0)
		return
	end

	function arg_1_0.__onPointerUp_collection_move_collection_wall_showcase_l_wall_area_6(arg_16_0)
		return
	end

	function arg_1_0.__onPointerDown_collection_move_collection_wall_showcase_r_wall_area_1(arg_17_0)
		return
	end

	function arg_1_0.__onPointerUp_collection_move_collection_wall_showcase_r_wall_area_1(arg_18_0)
		return
	end

	function arg_1_0.__onPointerDown_collection_move_collection_wall_showcase_r_wall_area_2(arg_19_0)
		return
	end

	function arg_1_0.__onPointerUp_collection_move_collection_wall_showcase_r_wall_area_2(arg_20_0)
		return
	end

	function arg_1_0.__onPointerDown_collection_move_collection_wall_showcase_r_wall_area_3(arg_21_0)
		return
	end

	function arg_1_0.__onPointerUp_collection_move_collection_wall_showcase_r_wall_area_3(arg_22_0)
		return
	end

	function arg_1_0.__onPointerDown_collection_move_collection_wall_showcase_r_wall_area_4(arg_23_0)
		return
	end

	function arg_1_0.__onPointerUp_collection_move_collection_wall_showcase_r_wall_area_4(arg_24_0)
		return
	end

	function arg_1_0.__onPointerDown_collection_move_collection_wall_showcase_r_wall_area_5(arg_25_0)
		return
	end

	function arg_1_0.__onPointerUp_collection_move_collection_wall_showcase_r_wall_area_5(arg_26_0)
		return
	end

	function arg_1_0.__onPointerDown_collection_move_collection_wall_showcase_r_wall_area_6(arg_27_0)
		return
	end

	function arg_1_0.__onPointerUp_collection_move_collection_wall_showcase_r_wall_area_6(arg_28_0)
		return
	end

	function arg_1_0.__onPointerDown_collection_move_collection_desk_desktop_1_desk_area_1(arg_29_0)
		return
	end

	function arg_1_0.__onPointerUp_collection_move_collection_desk_desktop_1_desk_area_1(arg_30_0)
		return
	end

	function arg_1_0.__onPointerDown_collection_move_collection_desk_desktop_2_desk_area_2(arg_31_0)
		return
	end

	function arg_1_0.__onPointerUp_collection_move_collection_desk_desktop_2_desk_area_2(arg_32_0)
		return
	end

	function arg_1_0.__onPointerDown_collection_move_collection_desk_desktop_3_desk_area_3(arg_33_0)
		return
	end

	function arg_1_0.__onPointerUp_collection_move_collection_desk_desktop_3_desk_area_3(arg_34_0)
		return
	end

	function arg_1_0.__onBeginDrag_drag_icon(arg_35_0, arg_35_1, arg_35_2)
		return
	end

	function arg_1_0.__onDrag_drag_icon(arg_36_0, arg_36_1, arg_36_2)
		return
	end

	function arg_1_0.__onEndDrag_drag_icon(arg_37_0)
		return
	end

	function arg_1_0.__onPointerDown_drag_icon(arg_38_0)
		return
	end

	function arg_1_0.__onPointerUp_drag_icon(arg_39_0)
		return
	end

	function arg_1_0.__onPointerDown_collection_move_collection_wall_showcase_l_image_1(arg_40_0)
		return
	end

	function arg_1_0.__onPointerUp_collection_move_collection_wall_showcase_l_image_1(arg_41_0)
		return
	end

	function arg_1_0.__onPointerDown_collection_move_collection_wall_showcase_l_image_2(arg_42_0)
		return
	end

	function arg_1_0.__onPointerUp_collection_move_collection_wall_showcase_l_image_2(arg_43_0)
		return
	end

	function arg_1_0.__onPointerDown_collection_move_collection_wall_showcase_l_image_3(arg_44_0)
		return
	end

	function arg_1_0.__onPointerUp_collection_move_collection_wall_showcase_l_image_3(arg_45_0)
		return
	end

	function arg_1_0.__onPointerDown_collection_move_collection_wall_showcase_l_image_4(arg_46_0)
		return
	end

	function arg_1_0.__onPointerUp_collection_move_collection_wall_showcase_l_image_4(arg_47_0)
		return
	end

	function arg_1_0.__onPointerDown_collection_move_collection_wall_showcase_l_image_5(arg_48_0)
		return
	end

	function arg_1_0.__onPointerUp_collection_move_collection_wall_showcase_l_image_5(arg_49_0)
		return
	end

	function arg_1_0.__onPointerDown_collection_move_collection_wall_showcase_l_image_6(arg_50_0)
		return
	end

	function arg_1_0.__onPointerUp_collection_move_collection_wall_showcase_l_image_6(arg_51_0)
		return
	end

	function arg_1_0.__onPointerDown_collection_move_collection_wall_showcase_r_image_1(arg_52_0)
		return
	end

	function arg_1_0.__onPointerUp_collection_move_collection_wall_showcase_r_image_1(arg_53_0)
		return
	end

	function arg_1_0.__onPointerDown_collection_move_collection_wall_showcase_r_image_2(arg_54_0)
		return
	end

	function arg_1_0.__onPointerUp_collection_move_collection_wall_showcase_r_image_2(arg_55_0)
		return
	end

	function arg_1_0.__onPointerDown_collection_move_collection_wall_showcase_r_image_3(arg_56_0)
		return
	end

	function arg_1_0.__onPointerUp_collection_move_collection_wall_showcase_r_image_3(arg_57_0)
		return
	end

	function arg_1_0.__onPointerDown_collection_move_collection_wall_showcase_r_image_4(arg_58_0)
		return
	end

	function arg_1_0.__onPointerUp_collection_move_collection_wall_showcase_r_image_4(arg_59_0)
		return
	end

	function arg_1_0.__onPointerDown_collection_move_collection_wall_showcase_r_image_5(arg_60_0)
		return
	end

	function arg_1_0.__onPointerUp_collection_move_collection_wall_showcase_r_image_5(arg_61_0)
		return
	end

	function arg_1_0.__onPointerDown_collection_move_collection_wall_showcase_r_image_6(arg_62_0)
		return
	end

	function arg_1_0.__onPointerUp_collection_move_collection_wall_showcase_r_image_6(arg_63_0)
		return
	end

	function arg_1_0.__onPointerDown_collection_move_collection_desk_desktop_1_image_1(arg_64_0)
		return
	end

	function arg_1_0.__onPointerUp_collection_move_collection_desk_desktop_1_image_1(arg_65_0)
		return
	end

	function arg_1_0.__onPointerDown_collection_move_collection_desk_desktop_2_image_2(arg_66_0)
		return
	end

	function arg_1_0.__onPointerUp_collection_move_collection_desk_desktop_2_image_2(arg_67_0)
		return
	end

	function arg_1_0.__onPointerDown_collection_move_collection_desk_desktop_3_image_3(arg_68_0)
		return
	end

	function arg_1_0.__onPointerUp_collection_move_collection_desk_desktop_3_image_3(arg_69_0)
		return
	end

	function arg_1_0:__onPointerEnter_collection_move_collection_wall_showcase_l_wall_area_1()
		self:on_point_enter_event(4)
	end

	function arg_1_0:__onPointerExit_collection_move_collection_wall_showcase_l_wall_area_1()
		self:on_point_exit_event(4)
	end

	function arg_1_0:__onPointerEnter_collection_move_collection_wall_showcase_l_wall_area_2()
		self:on_point_enter_event(5)
	end

	function arg_1_0:__onPointerExit_collection_move_collection_wall_showcase_l_wall_area_2()
		self:on_point_exit_event(5)
	end

	function arg_1_0:__onPointerEnter_collection_move_collection_wall_showcase_l_wall_area_3()
		self:on_point_enter_event(6)
	end

	function arg_1_0:__onPointerExit_collection_move_collection_wall_showcase_l_wall_area_3()
		self:on_point_exit_event(6)
	end

	function arg_1_0:__onPointerEnter_collection_move_collection_wall_showcase_l_wall_area_4()
		self:on_point_enter_event(7)
	end

	function arg_1_0:__onPointerExit_collection_move_collection_wall_showcase_l_wall_area_4()
		self:on_point_exit_event(7)
	end

	function arg_1_0:__onPointerEnter_collection_move_collection_wall_showcase_l_wall_area_5()
		self:on_point_enter_event(8)
	end

	function arg_1_0:__onPointerExit_collection_move_collection_wall_showcase_l_wall_area_5()
		self:on_point_exit_event(8)
	end

	function arg_1_0:__onPointerEnter_collection_move_collection_wall_showcase_l_wall_area_6()
		self:on_point_enter_event(9)
	end

	function arg_1_0:__onPointerExit_collection_move_collection_wall_showcase_l_wall_area_6()
		self:on_point_exit_event(9)
	end

	function arg_1_0:__onPointerEnter_collection_move_collection_wall_showcase_r_wall_area_1()
		self:on_point_enter_event(10)
	end

	function arg_1_0:__onPointerExit_collection_move_collection_wall_showcase_r_wall_area_1()
		self:on_point_exit_event(10)
	end

	function arg_1_0:__onPointerEnter_collection_move_collection_wall_showcase_r_wall_area_2()
		self:on_point_enter_event(11)
	end

	function arg_1_0:__onPointerExit_collection_move_collection_wall_showcase_r_wall_area_2()
		self:on_point_exit_event(11)
	end

	function arg_1_0:__onPointerEnter_collection_move_collection_wall_showcase_r_wall_area_3()
		self:on_point_enter_event(12)
	end

	function arg_1_0:__onPointerExit_collection_move_collection_wall_showcase_r_wall_area_3()
		self:on_point_exit_event(12)
	end

	function arg_1_0:__onPointerEnter_collection_move_collection_wall_showcase_r_wall_area_4()
		self:on_point_enter_event(13)
	end

	function arg_1_0:__onPointerExit_collection_move_collection_wall_showcase_r_wall_area_4()
		self:on_point_exit_event(13)
	end

	function arg_1_0:__onPointerEnter_collection_move_collection_wall_showcase_r_wall_area_5()
		self:on_point_enter_event(14)
	end

	function arg_1_0:__onPointerExit_collection_move_collection_wall_showcase_r_wall_area_5()
		self:on_point_exit_event(14)
	end

	function arg_1_0:__onPointerEnter_collection_move_collection_wall_showcase_r_wall_area_6()
		self:on_point_enter_event(15)
	end

	function arg_1_0:__onPointerExit_collection_move_collection_wall_showcase_r_wall_area_6()
		self:on_point_exit_event(15)
	end

	function arg_1_0:__onPointerEnter_collection_move_collection_desk_desktop_1_desk_area_1()
		self:on_point_enter_event(1)
	end

	function arg_1_0:__onPointerExit_collection_move_collection_desk_desktop_1_desk_area_1()
		self:on_point_exit_event(1)
	end

	function arg_1_0:__onPointerEnter_collection_move_collection_desk_desktop_2_desk_area_2()
		self:on_point_enter_event(2)
	end

	function arg_1_0:__onPointerExit_collection_move_collection_desk_desktop_2_desk_area_2()
		self:on_point_exit_event(2)
	end

	function arg_1_0:__onPointerEnter_collection_move_collection_desk_desktop_3_desk_area_3()
		self:on_point_enter_event(3)
	end

	function arg_1_0:__onPointerExit_collection_move_collection_desk_desktop_3_desk_area_3()
		self:on_point_exit_event(3)
	end

	function arg_1_0:__onClick_collection_move_collection_wall_showcase_l_image_1()
		if self._drag_index == 2 then
			return
		elseif self._drag_index == 0 then
			self:collection_onclick_event(4)
		end
	end

	function arg_1_0:__onLongClick_collection_move_collection_wall_showcase_l_image_1()
		self._drag_index = 2

		if self._drag_index == 0 then
			return
		end

		self:collection_drag_event(4)
	end

	function arg_1_0:__onClick_collection_move_collection_wall_showcase_l_image_2()
		if self._drag_index == 2 then
			return
		elseif self._drag_index == 0 then
			self:collection_onclick_event(5)
		end
	end

	function arg_1_0:__onLongClick_collection_move_collection_wall_showcase_l_image_2()
		self._drag_index = 2

		if self._drag_index == 0 then
			return
		end

		self:collection_drag_event(5)
	end

	function arg_1_0:__onClick_collection_move_collection_wall_showcase_l_image_3()
		if self._drag_index == 2 then
			return
		elseif self._drag_index == 0 then
			self:collection_onclick_event(6)
		end
	end

	function arg_1_0:__onLongClick_collection_move_collection_wall_showcase_l_image_3()
		self._drag_index = 2

		if self._drag_index == 0 then
			return
		end

		self:collection_drag_event(6)
	end

	function arg_1_0:__onClick_collection_move_collection_wall_showcase_l_image_4()
		if self._drag_index == 2 then
			return
		elseif self._drag_index == 0 then
			self:collection_onclick_event(7)
		end
	end

	function arg_1_0:__onLongClick_collection_move_collection_wall_showcase_l_image_4()
		self._drag_index = 2

		if self._drag_index == 0 then
			return
		end

		self:collection_drag_event(7)
	end

	function arg_1_0:__onClick_collection_move_collection_wall_showcase_l_image_5()
		if self._drag_index == 2 then
			return
		elseif self._drag_index == 0 then
			self:collection_onclick_event(8)
		end
	end

	function arg_1_0:__onLongClick_collection_move_collection_wall_showcase_l_image_5()
		self._drag_index = 2

		if self._drag_index == 0 then
			return
		end

		self:collection_drag_event(8)
	end

	function arg_1_0:__onClick_collection_move_collection_wall_showcase_l_image_6()
		if self._drag_index == 2 then
			return
		elseif self._drag_index == 0 then
			self:collection_onclick_event(9)
		end
	end

	function arg_1_0:__onLongClick_collection_move_collection_wall_showcase_l_image_6()
		self._drag_index = 2

		if self._drag_index == 0 then
			return
		end

		self:collection_drag_event(9)
	end

	function arg_1_0:__onClick_collection_move_collection_desk_desktop_1_image_1()
		if self._drag_index == 2 then
			return
		elseif self._drag_index == 0 then
			self:collection_onclick_event(1)
		end
	end

	function arg_1_0:__onLongClick_collection_move_collection_desk_desktop_1_image_1()
		self._drag_index = 2

		if self._drag_index == 0 then
			return
		end

		self:collection_drag_event(1)
	end

	function arg_1_0:__onClick_collection_move_collection_desk_desktop_2_image_2()
		if self._drag_index == 2 then
			return
		elseif self._drag_index == 0 then
			self:collection_onclick_event(2)
		end
	end

	function arg_1_0:__onLongClick_collection_move_collection_desk_desktop_2_image_2()
		self._drag_index = 2

		if self._drag_index == 0 then
			return
		end

		self:collection_drag_event(2)
	end

	function arg_1_0:__onClick_collection_move_collection_desk_desktop_3_image_3()
		if self._drag_index == 2 then
			return
		elseif self._drag_index == 0 then
			self:collection_onclick_event(3)
		end
	end

	function arg_1_0:__onLongClick_collection_move_collection_desk_desktop_3_image_3()
		self._drag_index = 2

		if self._drag_index == 0 then
			return
		end

		self:collection_drag_event(3)
	end

	function arg_1_0:__onClick_collection_move_collection_wall_showcase_r_image_1()
		if self._drag_index == 2 then
			return
		elseif self._drag_index == 0 then
			self:collection_onclick_event(10)
		end
	end

	function arg_1_0:__onLongClick_collection_move_collection_wall_showcase_r_image_1()
		self._drag_index = 2

		if self._drag_index == 0 then
			return
		end

		self:collection_drag_event(10)
	end

	function arg_1_0:__onClick_collection_move_collection_wall_showcase_r_image_2()
		if self._drag_index == 2 then
			return
		elseif self._drag_index == 0 then
			self:collection_onclick_event(11)
		end
	end

	function arg_1_0:__onLongClick_collection_move_collection_wall_showcase_r_image_2()
		self._drag_index = 2

		if self._drag_index == 0 then
			return
		end

		self:collection_drag_event(11)
	end

	function arg_1_0:__onClick_collection_move_collection_wall_showcase_r_image_3()
		if self._drag_index == 2 then
			return
		elseif self._drag_index == 0 then
			self:collection_onclick_event(12)
		end
	end

	function arg_1_0:__onLongClick_collection_move_collection_wall_showcase_r_image_3()
		self._drag_index = 2

		if self._drag_index == 0 then
			return
		end

		self:collection_drag_event(12)
	end

	function arg_1_0:__onClick_collection_move_collection_wall_showcase_r_image_4()
		if self._drag_index == 2 then
			return
		elseif self._drag_index == 0 then
			self:collection_onclick_event(13)
		end
	end

	function arg_1_0:__onLongClick_collection_move_collection_wall_showcase_r_image_4()
		self._drag_index = 2

		if self._drag_index == 0 then
			return
		end

		self:collection_drag_event(13)
	end

	function arg_1_0:__onClick_collection_move_collection_wall_showcase_r_image_5()
		if self._drag_index == 2 then
			return
		elseif self._drag_index == 0 then
			self:collection_onclick_event(14)
		end
	end

	function arg_1_0:__onLongClick_collection_move_collection_wall_showcase_r_image_5()
		self._drag_index = 2

		if self._drag_index == 0 then
			return
		end

		self:collection_drag_event(14)
	end

	function arg_1_0:__onClick_collection_move_collection_wall_showcase_r_image_6()
		if self._drag_index == 2 then
			return
		elseif self._drag_index == 0 then
			self:collection_onclick_event(15)
		end
	end

	function arg_1_0:__onLongClick_collection_move_collection_wall_showcase_r_image_6()
		self._drag_index = 2

		if self._drag_index == 0 then
			return
		end

		self:collection_drag_event(15)
	end

	function arg_1_0:__onClick_type_btn()
		if self._need_revert then
			self:__revert_toggle_group_all_set()

			self._need_revert = false
		else
			self:__onToggle_all_do_type_layer_country_group_toggle_group_all()
			self:__onToggle_all_do_type_layer_effect_group_toggle_group_all()
		end

		self:__save_toggle_group_all_set_data()

		self._temp_effect_data = 0

		for iter_130_0, iter_130_1 in pairs(self._effect_toggle_data) do
			self._temp_effect_data = self._temp_effect_data + 1
		end

		self._temp_effect_data = self._temp_effect_data - 1

		self._control.type_layer:SetActive(true)
	end

	function arg_1_0:__onClick_type_layer()
		self._country_toggle_data = {}
		self._type_toggle_data = {}
		self._effect_toggle_data = {}
		self._type_toggle_data.all = self._toggle_type_group_obj._rule_a.set.all

		for iter_131_0, iter_131_1 in pairs(self._toggle_type_group_obj._rule_b.set) do
			if iter_131_1 then
				self._type_toggle_data[iter_131_0] = iter_131_1
			end
		end

		self._country_toggle_data.all = self._toggle_country_group_obj._rule_a.set.all

		for iter_131_2, iter_131_3 in pairs(self._toggle_country_group_obj._rule_b.set) do
			if iter_131_3 then
				self._country_toggle_data[iter_131_2] = iter_131_3
			end
		end

		self._effect_toggle_data.all = self._toggle_effect_group_obj._rule_a.set.all

		for iter_131_4, iter_131_5 in pairs(self._toggle_effect_group_obj._rule_b.set) do
			if iter_131_5 then
				self._effect_toggle_data[iter_131_4] = iter_131_5
			end
		end

		self._control.type_layer:SetActive(false)
		self:__change_type_text()

		self._is_limit_release = not (self._type_toggle_data.all and self._country_toggle_data.all and self._effect_toggle_data.all)

		self:__update_cell()
		self._control.type_layer:SetActive(false)
	end

	function arg_1_0:__onClick_type_layer_btn_series_confirm_btn()
		self._control.type_layer:SetActive(false)

		self._country_toggle_data = {}
		self._type_toggle_data = {}
		self._effect_toggle_data = {}
		self._type_toggle_data.all = self._toggle_type_group_obj._rule_a.set.all

		for iter_132_0, iter_132_1 in pairs(self._toggle_type_group_obj._rule_b.set) do
			if iter_132_1 then
				self._type_toggle_data[iter_132_0] = iter_132_1
			end
		end

		self._country_toggle_data.all = self._toggle_country_group_obj._rule_a.set.all

		for iter_132_2, iter_132_3 in pairs(self._toggle_country_group_obj._rule_b.set) do
			if iter_132_3 then
				self._country_toggle_data[iter_132_2] = iter_132_3
			end
		end

		self._effect_toggle_data.all = self._toggle_effect_group_obj._rule_a.set.all

		for iter_132_4, iter_132_5 in pairs(self._toggle_effect_group_obj._rule_b.set) do
			if iter_132_5 then
				self._effect_toggle_data[iter_132_4] = iter_132_5
			end
		end

		self._control.type_layer:SetActive(false)
		self:__change_type_text()

		self._is_limit_release = not (self._type_toggle_data.all and self._country_toggle_data.all and self._effect_toggle_data.all)

		self:__update_cell()
	end

	function arg_1_0:__onClick_type_layer_btn_series_cancel_btn()
		self._control.type_layer:SetActive(false)

		self._need_revert = true
	end

	function arg_1_0:__onToggle_all_do_type_layer_country_group_toggle_group_all()
		self._toggle_country_group_obj:toggleOn("all", self._toggle_country_group.all.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_country_group_toggle_group_C_country()
		self._toggle_country_group_obj:toggleOn("C_country", self._toggle_country_group.C_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_country_group_toggle_group_E_country()
		self._toggle_country_group_obj:toggleOn("E_country", self._toggle_country_group.E_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_country_group_toggle_group_F_country()
		self._toggle_country_group_obj:toggleOn("F_country", self._toggle_country_group.F_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_country_group_toggle_group_G_country()
		self._toggle_country_group_obj:toggleOn("G_country", self._toggle_country_group.G_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_country_group_toggle_group_I_country()
		self._toggle_country_group_obj:toggleOn("I_country", self._toggle_country_group.I_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_country_group_toggle_group_J_country()
		self._toggle_country_group_obj:toggleOn("J_country", self._toggle_country_group.J_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_country_group_toggle_group_S_country()
		self._toggle_country_group_obj:toggleOn("S_country", self._toggle_country_group.S_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_country_group_toggle_group_U_country()
		self._toggle_country_group_obj:toggleOn("U_country", self._toggle_country_group.U_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_country_group_toggle_group_other_country()
		self._toggle_country_group_obj:toggleOn("other_country", self._toggle_country_group.other_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_all()
		self._toggle_type_group_obj:toggleOn("all", self._toggle_type_group.all.toggle.isOn)
		self:__check_type_group_to_size_group()
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_CV()
		self._toggle_type_group_obj:toggleOn("CV", self._toggle_type_group.CV.toggle.isOn)
		self:__check_type_group_to_size_group(1)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_CVL()
		self._toggle_type_group_obj:toggleOn("CVL", self._toggle_type_group.CVL.toggle.isOn)
		self:__check_type_group_to_size_group(2)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_AV()
		self._toggle_type_group_obj:toggleOn("AV", self._toggle_type_group.AV.toggle.isOn)
		self:__check_type_group_to_size_group(3)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_BB()
		self._toggle_type_group_obj:toggleOn("BB", self._toggle_type_group.BB.toggle.isOn)
		self:__check_type_group_to_size_group(4)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_BBV()
		self._toggle_type_group_obj:toggleOn("BBV", self._toggle_type_group.BBV.toggle.isOn)
		self:__check_type_group_to_size_group(5)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_BC()
		self._toggle_type_group_obj:toggleOn("BC", self._toggle_type_group.BC.toggle.isOn)
		self:__check_type_group_to_size_group(6)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_CA()
		self._toggle_type_group_obj:toggleOn("CA", self._toggle_type_group.CA.toggle.isOn)
		self:__check_type_group_to_size_group(7)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_CAV()
		self._toggle_type_group_obj:toggleOn("CAV", self._toggle_type_group.CAV.toggle.isOn)
		self:__check_type_group_to_size_group(8)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_CLT()
		self._toggle_type_group_obj:toggleOn("CLT", self._toggle_type_group.CLT.toggle.isOn)
		self:__check_type_group_to_size_group(9)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_CL()
		self._toggle_type_group_obj:toggleOn("CL", self._toggle_type_group.CL.toggle.isOn)
		self:__check_type_group_to_size_group(10)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_BM()
		self._toggle_type_group_obj:toggleOn("BM", self._toggle_type_group.BM.toggle.isOn)
		self:__check_type_group_to_size_group(11)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_DD()
		self._toggle_type_group_obj:toggleOn("DD", self._toggle_type_group.DD.toggle.isOn)
		self:__check_type_group_to_size_group(12)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_SSG()
		self._toggle_type_group_obj:toggleOn("SSG", self._toggle_type_group.SSG.toggle.isOn)
		self:__check_type_group_to_size_group(13)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_SS()
		self._toggle_type_group_obj:toggleOn("SS", self._toggle_type_group.SS.toggle.isOn)
		self:__check_type_group_to_size_group(14)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_SC()
		self._toggle_type_group_obj:toggleOn("SC", self._toggle_type_group.SC.toggle.isOn)
		self:__check_type_group_to_size_group(15)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_AP()
		self._toggle_type_group_obj:toggleOn("AP", self._toggle_type_group.AP.toggle.isOn)
		self:__check_type_group_to_size_group(16)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_ASDG()
		self._toggle_type_group_obj:toggleOn("ASDG", self._toggle_type_group.ASDG.toggle.isOn)
		self:__check_type_group_to_size_group(23)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_AADG()
		self._toggle_type_group_obj:toggleOn("AADG", self._toggle_type_group.AADG.toggle.isOn)
		self:__check_type_group_to_size_group(24)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_CBG()
		self._toggle_type_group_obj:toggleOn("CBG", self._toggle_type_group.CBG.toggle.isOn)
		self:__check_type_group_to_size_group(26)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_BBG()
		self._toggle_type_group_obj:toggleOn("BBG", self._toggle_type_group.BBG.toggle.isOn)
		self:__check_type_group_to_size_group(27)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_CG()
		self._toggle_type_group_obj:toggleOn("CG", self._toggle_type_group.CG.toggle.isOn)
		self:__check_type_group_to_size_group(29)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_KP()
		self._toggle_type_group_obj:toggleOn("KP", self._toggle_type_group.KP.toggle.isOn)
		self:__check_type_group_to_size_group(30)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_BG()
		self._toggle_type_group_obj:toggleOn("BG", self._toggle_type_group.BG.toggle.isOn)
		self:__check_type_group_to_size_group()
	end

	function arg_1_0:__onToggle_all_do_type_layer_size_group_toggle_group_all()
		self._toggle_size_group_obj:toggleOnOnly("all", self._toggle_size_group.all.toggle.isOn)
		self:__check_size_group_to_type_group("all")
	end

	function arg_1_0:__onToggle_all_do_type_layer_size_group_toggle_group_large(arg_169_1)
		self._toggle_size_group_obj:toggleOnOnly("large", self._toggle_size_group.large.toggle.isOn)

		if arg_169_1 then
			self:__check_size_group_to_type_group("large")

			self._is_click_type_toggle = false
		elseif not self._is_click_type_toggle then
			self._control.type_layer.size_group.toggle_group.all.toggle.isOn = true
		end
	end

	function arg_1_0:__onToggle_all_do_type_layer_size_group_toggle_group_middle(arg_170_1)
		self._toggle_size_group_obj:toggleOnOnly("middle", self._toggle_size_group.middle.toggle.isOn)

		if arg_170_1 then
			self:__check_size_group_to_type_group("middle")

			self._is_click_type_toggle = false
		elseif not self._is_click_type_toggle then
			self._control.type_layer.size_group.toggle_group.all.toggle.isOn = true
		end
	end

	function arg_1_0:__onToggle_all_do_type_layer_size_group_toggle_group_small(arg_171_1)
		self._toggle_size_group_obj:toggleOnOnly("small", self._toggle_size_group.small.toggle.isOn)

		if arg_171_1 then
			self:__check_size_group_to_type_group("small")

			self._is_click_type_toggle = false
		elseif not self._is_click_type_toggle then
			self._control.type_layer.size_group.toggle_group.all.toggle.isOn = true
		end
	end

	function arg_1_0:__onToggle_all_do_type_layer_size_group_toggle_group_maip(arg_172_1)
		self._toggle_size_group_obj:toggleOnOnly("maip", self._toggle_size_group.maip.toggle.isOn)

		if arg_172_1 then
			self:__check_size_group_to_type_group("maip")

			self._is_click_type_toggle = false
		elseif not self._is_click_type_toggle then
			self._control.type_layer.size_group.toggle_group.all.toggle.isOn = true
		end
	end

	function arg_1_0:__onToggle_all_do_type_layer_size_group_toggle_group_protect(arg_173_1)
		self._toggle_size_group_obj:toggleOnOnly("protect", self._toggle_size_group.protect.toggle.isOn)

		if arg_173_1 then
			self:__check_size_group_to_type_group("protect")

			self._is_click_type_toggle = false
		elseif not self._is_click_type_toggle then
			self._control.type_layer.size_group.toggle_group.all.toggle.isOn = true
		end
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_all(arg_174_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_C_country(arg_175_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_E_country(arg_176_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_F_country(arg_177_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_G_country(arg_178_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_I_country(arg_179_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_J_country(arg_180_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_U_country(arg_181_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_S_country(arg_182_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_other_country(arg_183_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_all(arg_184_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_CV(arg_185_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_CVL(arg_186_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_AV(arg_187_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_BB(arg_188_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_BBV(arg_189_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_BC(arg_190_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_CA(arg_191_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_CAV(arg_192_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_CLT(arg_193_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_CL(arg_194_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_BM(arg_195_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_DD(arg_196_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_SSG(arg_197_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_SS(arg_198_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_SC(arg_199_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_AP(arg_200_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_ASDG(arg_201_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_AADG(arg_202_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_KP(arg_203_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_CG(arg_204_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_CBG(arg_205_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_BBG(arg_206_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_BG(arg_207_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_size_group_toggle_group_all(arg_208_0)
		return
	end

	function arg_1_0:__change_type_text()
		local var_209_0 = false
		local var_209_1

		if self._type_toggle_data.all then
			var_209_1 = false
		elseif var_0_8.dict_lenght(self._type_toggle_data) <= 2 then
			for iter_209_0, iter_209_1 in pairs(self._type_toggle_data) do
				if iter_209_0 == "CLT" then
					var_209_1 = var_0_1:getNowLang("shiptype9")
				elseif iter_209_0 ~= "all" then
					var_209_1 = var_0_1:getNowLang("shiptype" .. tostring(var_0_7.filter_type[iter_209_0]))
				end
			end
		else
			var_209_0 = true
		end

		local var_209_2

		if not self._country_toggle_data.all and var_0_8.dict_lenght(self._country_toggle_data) <= 2 then
			for iter_209_2, iter_209_3 in pairs(self._country_toggle_data) do
				if iter_209_2 == "other_country" then
					var_209_2 = var_0_1:getNowLang("country9")
				elseif iter_209_2 ~= "all" then
					var_209_2 = var_0_1:getNowLang("country" .. tostring(var_0_7.filter_country[iter_209_2]))
				end
			end
		elseif not self._country_toggle_data.all then
			var_209_0 = true
		end

		self._control.type_btn.type_txt.text.text = var_209_0 and var_0_1:getNowLang("multiselect") or var_209_1 and var_209_2 and var_0_1:getNowLang("multiselect") or (var_209_1 or var_209_2) and (var_209_1 or var_209_2) or var_0_1:getNowLang("questall")
	end

	function arg_1_0.__check_size_large(arg_210_0, arg_210_1)
		local var_210_0 = true

		for iter_210_0, iter_210_1 in pairs(arg_210_1) do
			if not var_0_8.have_data(var_0_7.ship_size_type_list.large, iter_210_0) and iter_210_1 then
				var_210_0 = false
			end
		end

		for iter_210_2, iter_210_3 in pairs(var_0_7.ship_size_type_list.large) do
			if not arg_210_1[iter_210_3] then
				var_210_0 = false
			end
		end

		return var_210_0
	end

	function arg_1_0.__check_size_middle(arg_211_0, arg_211_1)
		local var_211_0 = true

		for iter_211_0, iter_211_1 in pairs(arg_211_1) do
			if not var_0_8.have_data(var_0_7.ship_size_type_list.middle, iter_211_0) and iter_211_1 then
				var_211_0 = false
			end
		end

		for iter_211_2, iter_211_3 in pairs(var_0_7.ship_size_type_list.middle) do
			if not arg_211_1[iter_211_3] then
				var_211_0 = false
			end
		end

		return var_211_0
	end

	function arg_1_0.__check_size_small(arg_212_0, arg_212_1)
		local var_212_0 = true

		for iter_212_0, iter_212_1 in pairs(arg_212_1) do
			if not var_0_8.have_data(var_0_7.ship_size_type_list.small, iter_212_0) and iter_212_1 then
				var_212_0 = false
			end
		end

		for iter_212_2, iter_212_3 in pairs(var_0_7.ship_size_type_list.small) do
			if not arg_212_1[iter_212_3] then
				var_212_0 = false
			end
		end

		return var_212_0
	end

	function arg_1_0.__check_size_maip(arg_213_0, arg_213_1)
		local var_213_0 = true

		for iter_213_0, iter_213_1 in pairs(arg_213_1) do
			if not var_0_8.have_data(var_0_7.ship_size_type_list.maip, iter_213_0) and iter_213_1 then
				var_213_0 = false
			end
		end

		for iter_213_2, iter_213_3 in pairs(var_0_7.ship_size_type_list.maip) do
			if not arg_213_1[iter_213_3] then
				var_213_0 = false
			end
		end

		return var_213_0
	end

	function arg_1_0.__check_size_protect(arg_214_0, arg_214_1)
		local var_214_0 = true

		for iter_214_0, iter_214_1 in pairs(arg_214_1) do
			if not var_0_8.have_data(var_0_7.ship_size_type_list.protect, iter_214_0) and iter_214_1 then
				var_214_0 = false
			end
		end

		for iter_214_2, iter_214_3 in pairs(var_0_7.ship_size_type_list.protect) do
			if not arg_214_1[iter_214_3] then
				var_214_0 = false
			end
		end

		return var_214_0
	end

	function arg_1_0:__check_type_group_to_size_group(arg_215_1)
		local var_215_0 = self._toggle_type_group_obj._rule_b.set

		self._is_click_type_toggle = true

		if self._toggle_type_group_obj._rule_a.set.all then
			self._control.type_layer.size_group.toggle_group.all.toggle.isOn = true

			return
		else
			self._toggle_size_group_obj:toggleOnOnly("all", false, true)
		end

		self._control.type_layer.size_group.toggle_group.large.toggle.isOn = not not self:__check_size_large(var_215_0)
		self._control.type_layer.size_group.toggle_group.middle.toggle.isOn = not not self:__check_size_middle(var_215_0)
		self._control.type_layer.size_group.toggle_group.small.toggle.isOn = not not self:__check_size_small(var_215_0)
		self._control.type_layer.size_group.toggle_group.maip.toggle.isOn = not not self:__check_size_maip(var_215_0)
		self._control.type_layer.size_group.toggle_group.protect.toggle.isOn = not not self:__check_size_protect(var_215_0)
	end

	function arg_1_0:__check_size_group_to_type_group(arg_216_1)
		if arg_216_1 == "all" then
			self._control.type_layer.type_group.toggle_group.all.toggle.isOn = self._toggle_size_group_obj._rule_a.set.all

			return
		end

		if arg_216_1 == "middle" then
			for iter_216_0, iter_216_1 in pairs(self._toggle_type_group_obj._rule_b.set) do
				self._control.type_layer.type_group.toggle_group[iter_216_0].toggle.isOn = not not var_0_8.have_data(var_0_7.ship_size_type_list.middle, iter_216_0)
			end

			self._control.type_layer.type_group.toggle_group.all.toggle.isOn = not self._toggle_size_group_obj._rule_b.set.middle

			return
		end

		if arg_216_1 == "large" then
			for iter_216_2, iter_216_3 in pairs(self._toggle_type_group_obj._rule_b.set) do
				self._control.type_layer.type_group.toggle_group[iter_216_2].toggle.isOn = not not var_0_8.have_data(var_0_7.ship_size_type_list.large, iter_216_2)
			end

			self._control.type_layer.type_group.toggle_group.all.toggle.isOn = not self._toggle_size_group_obj._rule_b.set.large

			return
		end

		if arg_216_1 == "small" then
			for iter_216_4, iter_216_5 in pairs(self._toggle_type_group_obj._rule_b.set) do
				self._control.type_layer.type_group.toggle_group[iter_216_4].toggle.isOn = not not var_0_8.have_data(var_0_7.ship_size_type_list.small, iter_216_4)
			end

			self._control.type_layer.type_group.toggle_group.all.toggle.isOn = not self._toggle_size_group_obj._rule_b.set.small

			return
		end

		if arg_216_1 == "maip" then
			for iter_216_6, iter_216_7 in pairs(self._toggle_type_group_obj._rule_b.set) do
				self._control.type_layer.type_group.toggle_group[iter_216_6].toggle.isOn = not not var_0_8.have_data(var_0_7.ship_size_type_list.maip, iter_216_6)
			end

			self._control.type_layer.type_group.toggle_group.all.toggle.isOn = not self._toggle_size_group_obj._rule_b.set.maip

			return
		end

		if arg_216_1 == "protect" then
			for iter_216_8, iter_216_9 in pairs(self._toggle_type_group_obj._rule_b.set) do
				self._control.type_layer.type_group.toggle_group[iter_216_8].toggle.isOn = not not var_0_8.have_data(var_0_7.ship_size_type_list.protect, iter_216_8)
			end

			self._control.type_layer.type_group.toggle_group.all.toggle.isOn = not self._toggle_size_group_obj._rule_b.set.protect

			return
		end
	end

	function arg_1_0:__save_toggle_group_all_set_data()
		self._last_toggle_size_group_obj_rule_a = var_0_8.little_clone(self._toggle_size_group_obj._rule_a.set)
		self._last_toggle_size_group_obj_rule_b = var_0_8.little_clone(self._toggle_size_group_obj._rule_b.set)
		self._last_toggle_type_group_obj_rule_a = var_0_8.little_clone(self._toggle_type_group_obj._rule_a.set)
		self._last_toggle_type_group_obj_rule_b = var_0_8.little_clone(self._toggle_type_group_obj._rule_b.set)
		self._last_toggle_country_group_obj_rule_a = var_0_8.little_clone(self._toggle_country_group_obj._rule_a.set)
		self._last_toggle_country_group_obj_rule_b = var_0_8.little_clone(self._toggle_country_group_obj._rule_b.set)
		self._last_toggle_effect_group_obj_rule_a = var_0_8.little_clone(self._toggle_effect_group_obj._rule_a.set)
		self._last_toggle_effect_group_obj_rule_b = var_0_8.little_clone(self._toggle_effect_group_obj._rule_b.set)
	end

	function arg_1_0:__revert_toggle_group_all_set()
		if self._last_toggle_size_group_obj_rule_a.all ~= self._toggle_size_group_obj._rule_a.set.all then
			self._control.type_layer.size_group.toggle_group.all.toggle.isOn = self._last_toggle_size_group_obj_rule_a.all
		end

		for iter_218_0, iter_218_1 in pairs(self._last_toggle_size_group_obj_rule_b) do
			if iter_218_1 ~= self._toggle_size_group_obj._rule_b.set[iter_218_0] then
				self._control.type_layer.size_group.toggle_group[iter_218_0].toggle.isOn = iter_218_1
			end
		end

		if self._last_toggle_type_group_obj_rule_a.all ~= self._toggle_type_group_obj._rule_a.set.all then
			self._control.type_layer.type_group.toggle_group.all.toggle.isOn = self._last_toggle_type_group_obj_rule_a.all
		end

		for iter_218_2, iter_218_3 in pairs(self._last_toggle_type_group_obj_rule_b) do
			if iter_218_3 ~= self._toggle_type_group_obj._rule_b.set[iter_218_2] then
				self._control.type_layer.type_group.toggle_group[iter_218_2].toggle.isOn = iter_218_3
			end
		end

		if self._last_toggle_country_group_obj_rule_a.all ~= self._toggle_country_group_obj._rule_a.set.all then
			self._control.type_layer.country_group.toggle_group.all.toggle.isOn = self._last_toggle_country_group_obj_rule_a.all
		end

		for iter_218_4, iter_218_5 in pairs(self._last_toggle_country_group_obj_rule_b) do
			if iter_218_5 ~= self._toggle_country_group_obj._rule_b.set[iter_218_4] then
				self._control.type_layer.country_group.toggle_group[iter_218_4].toggle.isOn = iter_218_5
			end
		end

		if self._last_toggle_effect_group_obj_rule_a.all ~= self._toggle_effect_group_obj._rule_a.set.all then
			self._control.type_layer.effect_group.toggle_group.all.toggle.isOn = self._last_toggle_effect_group_obj_rule_a.all
		end

		for iter_218_6, iter_218_7 in pairs(self._last_toggle_effect_group_obj_rule_b) do
			if iter_218_7 ~= self._toggle_effect_group_obj._rule_b.set[iter_218_6] then
				self._control.type_layer.effect_group.toggle_group[iter_218_6].toggle.isOn = iter_218_7
			end
		end
	end

	function arg_1_0:_reset_type_layer()
		for iter_219_0, iter_219_1 in pairs(self._toggle_size_group) do
			iter_219_1.toggle.isOn = iter_219_0 == "all"
		end

		self._toggle_type_group_obj.all = true

		for iter_219_2, iter_219_3 in pairs(self._toggle_type_group) do
			iter_219_3.toggle.isOn = false
		end

		self._toggle_country_group_obj.all = true

		for iter_219_4, iter_219_5 in pairs(self._toggle_country_group) do
			iter_219_5.toggle.isOn = false
		end

		self._toggle_effect_group_obj.all = true

		for iter_219_6, iter_219_7 in pairs(self._toggle_effect_group) do
			iter_219_7.toggle.isOn = false
		end
	end

	function arg_1_0:__onToggle_all_do_type_layer_effect_group_toggle_group_all()
		self._toggle_effect_group_obj:toggleOn("all", self._toggle_effect_group.all.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_effect_group_toggle_group_atk()
		self._toggle_effect_group_obj:toggleOn("atk", self._toggle_effect_group.atk.toggle.isOn)
		self:__check_effect_layer("atk")
	end

	function arg_1_0:__onToggle_all_do_type_layer_effect_group_toggle_group_def()
		self._toggle_effect_group_obj:toggleOn("def", self._toggle_effect_group.def.toggle.isOn)
		self:__check_effect_layer("def")
	end

	function arg_1_0:__onToggle_all_do_type_layer_effect_group_toggle_group_torpedo()
		self._toggle_effect_group_obj:toggleOn("torpedo", self._toggle_effect_group.torpedo.toggle.isOn)
		self:__check_effect_layer("torpedo")
	end

	function arg_1_0:__onToggle_all_do_type_layer_effect_group_toggle_group_air_def()
		self._toggle_effect_group_obj:toggleOn("air_def", self._toggle_effect_group.air_def.toggle.isOn)
		self:__check_effect_layer("air_def")
	end

	function arg_1_0:__onToggle_all_do_type_layer_effect_group_toggle_group_hit()
		self._toggle_effect_group_obj:toggleOn("hit", self._toggle_effect_group.hit.toggle.isOn)
		self:__check_effect_layer("hit")
	end

	function arg_1_0:__onToggle_all_do_type_layer_effect_group_toggle_group_miss()
		self._toggle_effect_group_obj:toggleOn("miss", self._toggle_effect_group.miss.toggle.isOn)
		self:__check_effect_layer("miss")
	end

	function arg_1_0:__onToggle_all_do_type_layer_effect_group_toggle_group_antisub()
		self._toggle_effect_group_obj:toggleOn("antisub", self._toggle_effect_group.antisub.toggle.isOn)
		self:__check_effect_layer("antisub")
	end

	function arg_1_0:__onToggle_all_do_type_layer_effect_group_toggle_group_speed()
		self._toggle_effect_group_obj:toggleOn("speed", self._toggle_effect_group.speed.toggle.isOn)
		self:__check_effect_layer("speed")
	end

	function arg_1_0:__onToggle_all_do_type_layer_effect_group_toggle_group_radar()
		self._toggle_effect_group_obj:toggleOn("radar", self._toggle_effect_group.radar.toggle.isOn)
		self:__check_effect_layer("radar")
	end

	function arg_1_0:__onToggle_all_do_type_layer_effect_group_toggle_group_luck()
		self._toggle_effect_group_obj:toggleOn("luck", self._toggle_effect_group.luck.toggle.isOn)
		self:__check_effect_layer("luck")
	end

	function arg_1_0:__check_effect_layer(arg_231_1)
		if self._toggle_effect_group[arg_231_1].toggle.isOn then
			self._temp_effect_data = self._temp_effect_data + 1

			if self._temp_effect_data == 9 then
				self._toggle_effect_group.all.toggle.isOn = true
			end
		else
			self._temp_effect_data = self._temp_effect_data - 1
		end
	end
end

function var_0_0.extend_obj(arg_232_0)
	arg_232_0._need_revert = false
	arg_232_0._last_toggle_size_group_obj_rule_a = {}
	arg_232_0._last_toggle_size_group_obj_rule_b = {}
	arg_232_0._last_toggle_type_group_obj_rule_a = {}
	arg_232_0._last_toggle_type_group_obj_rule_b = {}
	arg_232_0._last_toggle_country_group_obj_rule_a = {}
	arg_232_0._last_toggle_country_group_obj_rule_b = {}
	arg_232_0._last_toggle_effect_group_obj_rule_a = {}
	arg_232_0._last_toggle_effect_group_obj_rule_b = {}
	arg_232_0._is_click_type_toggle = false
end

return var_0_0
