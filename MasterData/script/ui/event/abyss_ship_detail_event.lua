local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onLeftDragEnd_left_drag_for_switch()
		var_0_2:play_in_out_animation(self._control.bg.uITweenSequence, true, function()
			self._index = self._index == #self._members and 1 or self._index + 1

			self:set_data_by_index(self._index)
			self:__init_panel()
			self:show_layer(1)
			var_0_2:play_in_out_animation(self._control.left.drag_for_switch.uITweenSequence, false)
		end)
	end

	function arg_1_0:__onRightDragEnd_left_drag_for_switch()
		var_0_2:play_in_out_animation(self._control.left.drag_for_switch.uITweenSequence, true, function()
			self._index = self._index == 1 and #self._members or self._index - 1

			self:set_data_by_index(self._index)
			self:__init_panel()
			self:show_layer(1)
			var_0_2:play_in_out_animation(self._control.bg.uITweenSequence, false)
		end)
	end

	function arg_1_0:__onClick_left_return_btn()
		self:play_in_out_animation(true, function()
			self:play_in_out_animation(false, nil, self._control.left_seq.uITweenSequence)
		end, self._control.left_seq.uITweenSequence)
		self:play_in_out_animation(true, function()
			self:play_in_out_animation(false, function()
				if self._is_single or self._is_team then
					if self._enter_type == var_0_2.enter_ship_detail_type.abyss_remake or self._enter_type == var_0_2.enter_ship_detail_type.abyss_synthesis then
						var_0_1:destroyInstance("abyss_ship_detail")

						local var_9_0 = var_0_1:getInstance("abyss_dock_team")

						if var_9_0 then
							var_9_0:setVisible(true)
						else
							var_0_1:createInstance("abyss_dock_team"):setVisible(true)
						end
					elseif self._enter_type == var_0_2.enter_ship_detail_type.abyss_synthesis_explain then
						self:setVisible(false)
						var_0_1:destroyInstance("abyss_ship_detail")
					elseif self._enter_type == var_0_2.enter_ship_detail_type.abyss_single_ship or self._enter_type == var_0_2.enter_ship_detail_type.abyss_fight_prepare then
						var_0_1:destroyInstance("abyss_ship_detail")

						if self._special_abyss_enter_type == var_0_2.enter_ship_detail_type.abyss_fight_prepare then
							local var_9_1 = var_0_1:getInstance("fight_prepare")

							if var_9_1 then
								var_9_1:setVisible(true)
								var_9_1:update_abyss_model_team_list(var_0_2.fight_prepare_right_panel_type.abyss_model, var_0_2.team_type.abyss_team)
							end
						else
							local var_9_2 = var_0_1:getInstance("abyss_select_member")

							if var_9_2 then
								var_9_2:setVisible(true)
							else
								var_0_1:createInstance("abyss_select_member"):setVisible(true)
							end
						end
					elseif self._enter_type == var_0_2.enter_ship_detail_type.abyss_dock_team then
						var_0_1:destroyInstance("abyss_ship_detail")

						local var_9_3 = var_0_1:getInstance("abyss_dock_team")

						if var_9_3 then
							var_9_3:setVisible(true)
						else
							var_0_1:createInstance("abyss_dock_team"):setVisible(true)
						end
					elseif self._enter_type == var_0_2.enter_ship_detail_type.pre_formation then
						var_0_1:destroyInstance("abyss_ship_detail")

						local var_9_4 = var_0_1:getInstance("pre_formation")

						if var_9_4 then
							var_9_4:setVisible(true)
							var_9_4:refresh_info_list()
						end
					end
				end

				self:reset_enter_type()
			end, self._control.right_seq.uITweenSequence)
		end, self._control.right_seq.uITweenSequence)
		self:play_mall_anim(false)
	end

	function arg_1_0:__onClick_left_alone_view_btn()
		self._control.left.ship_role.image.raycastTarget = true
		self._control.role_scale.slide.slider.value = 0

		self._control.left.ship_role.shipViewControl:PlayViewAni()
		self:__look_over_view(true)

		if self._is_team and #self._members > 1 then
			self._control.left.drag_for_switch:SetActive(false)
		end
	end

	function arg_1_0:__onLongClick_right_ship_detail_ship_equip_equip_1_equipment_change_btn()
		self:__show_equip_att(self._control.right.ship_detail.ship_equip.equip_1.equipment.change_btn, 1)
	end

	function arg_1_0:__onPointerUp_right_ship_detail_ship_equip_equip_1_equipment_change_btn()
		self:__show_equip_attr_panel(false)
	end

	function arg_1_0:__onLongClick_right_ship_detail_ship_equip_equip_2_equipment_change_btn()
		self:__show_equip_att(self._control.right.ship_detail.ship_equip.equip_2.equipment.change_btn, 2)
	end

	function arg_1_0:__onPointerUp_right_ship_detail_ship_equip_equip_2_equipment_change_btn()
		self:__show_equip_attr_panel(false)
	end

	function arg_1_0:__onLongClick_right_ship_detail_ship_equip_equip_3_equipment_change_btn()
		self:__show_equip_att(self._control.right.ship_detail.ship_equip.equip_3.equipment.change_btn, 3)
	end

	function arg_1_0:__onPointerUp_right_ship_detail_ship_equip_equip_3_equipment_change_btn()
		self:__show_equip_attr_panel(false)
	end

	function arg_1_0:__onLongClick_right_ship_detail_ship_equip_equip_4_equipment_change_btn()
		self:__show_equip_att(self._control.right.ship_detail.ship_equip.equip_4.equipment.change_btn, 4)
	end

	function arg_1_0:__onPointerUp_right_ship_detail_ship_equip_equip_4_equipment_change_btn()
		self:__show_equip_attr_panel(false)
	end

	function arg_1_0:__onClick_right_btn_ship_view_btn()
		self._control.left.ship_role.image.sprite = self._now_paint_sprite
		self._control.left.ship_role.image.raycastTarget = false

		self._control.left.ship_role.shipViewControl:PlayReverseAni()
		self:__look_over_view(false)

		if self._is_team and #self._members > 1 then
			self._control.left.drag_for_switch:SetActive(true)
		end
	end

	function arg_1_0:__onClick_role_scale_add_btn()
		self._control.role_scale.slide.slider.value = self._control.role_scale.slide.slider.value + 0.1 > 1 and 1 or self._control.role_scale.slide.slider.value + 0.1
	end

	function arg_1_0:__onClick_role_scale_reduce_btn()
		self._control.role_scale.slide.slider.value = self._control.role_scale.slide.slider.value - 0.1 < 0 and 0 or self._control.role_scale.slide.slider.value - 0.1
	end

	function arg_1_0.__onClick_right_ship_detail_ship_title_strengthen_btn(arg_22_0)
		return
	end

	function arg_1_0.__onClick_right_ship_detail_ship_equip_equip_1_add_equip(arg_23_0)
		return
	end

	function arg_1_0.__onClick_right_ship_detail_ship_equip_equip_1_equipment_change_btn(arg_24_0)
		return
	end

	function arg_1_0.__onClick_right_ship_detail_ship_equip_equip_1_equipment_off_btn(arg_25_0)
		return
	end

	function arg_1_0.__onClick_right_ship_detail_ship_equip_equip_2_add_equip(arg_26_0)
		return
	end

	function arg_1_0.__onClick_right_ship_detail_ship_equip_equip_2_equipment_change_btn(arg_27_0)
		return
	end

	function arg_1_0.__onClick_right_ship_detail_ship_equip_equip_2_equipment_off_btn(arg_28_0)
		return
	end

	function arg_1_0.__onClick_right_ship_detail_ship_equip_equip_3_add_equip(arg_29_0)
		return
	end

	function arg_1_0.__onClick_right_ship_detail_ship_equip_equip_3_equipment_change_btn(arg_30_0)
		return
	end

	function arg_1_0.__onClick_right_ship_detail_ship_equip_equip_3_equipment_off_btn(arg_31_0)
		return
	end

	function arg_1_0.__onClick_right_ship_detail_ship_equip_equip_4_add_equip(arg_32_0)
		return
	end

	function arg_1_0.__onClick_right_ship_detail_ship_equip_equip_4_equipment_change_btn(arg_33_0)
		return
	end

	function arg_1_0.__onClick_right_ship_detail_ship_equip_equip_4_equipment_off_btn(arg_34_0)
		return
	end

	function arg_1_0.__onClick_right_btn_ship_change_btn(arg_35_0)
		return
	end

	function arg_1_0.__onToggle_right_btn_ship_switch_btn(arg_36_0)
		return
	end

	function arg_1_0.__onClick_tip_layer(arg_37_0)
		return
	end
end

function var_0_0.extend_obj(arg_38_0)
	return
end

return var_0_0
