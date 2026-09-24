local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.util_func
local var_0_3 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_type_layer()
		self._type_toggle_data = {}
		self._type_toggle_data.all = self._toggle_type_group_obj._rule_a.set.all

		for iter_2_0, iter_2_1 in pairs(self._toggle_type_group_obj._rule_b.set) do
			if iter_2_1 then
				self._type_toggle_data[iter_2_0] = iter_2_1
			end
		end

		self._effect_toggle_data = {}
		self._effect_toggle_data.all = self._toggle_effect_group_obj._rule_a.set.all

		for iter_2_2, iter_2_3 in pairs(self._toggle_effect_group_obj._rule_b.set) do
			if iter_2_3 then
				self._effect_toggle_data[iter_2_2] = iter_2_3
			end
		end

		self:__change_type_text()
		self:__set_search_result()
		self:setVisible(false)
	end

	function arg_1_0:__onClick_type_layer_btn_series_confirm_btn()
		self._type_toggle_data = {}
		self._type_toggle_data.all = self._toggle_type_group_obj._rule_a.set.all

		for iter_3_0, iter_3_1 in pairs(self._toggle_type_group_obj._rule_b.set) do
			if iter_3_1 then
				self._type_toggle_data[iter_3_0] = iter_3_1
			end
		end

		self._effect_toggle_data = {}
		self._effect_toggle_data.all = self._toggle_effect_group_obj._rule_a.set.all

		for iter_3_2, iter_3_3 in pairs(self._toggle_effect_group_obj._rule_b.set) do
			if iter_3_3 then
				self._effect_toggle_data[iter_3_2] = iter_3_3
			end
		end

		self:__change_type_text()
		self:__set_search_result()
		self:setVisible(false)
	end

	function arg_1_0:__onClick_type_layer_btn_series_cancel_btn()
		self._need_revert = true

		self:setVisible(false)
	end

	function arg_1_0:__revert_toggle_group_all_set()
		if self._toggle_effect_group_obj and self._last_toggle_effect_group_obj_rule_a.all ~= self._toggle_effect_group_obj._rule_a.set.all then
			self._control.type_layer.effect_group.toggle_group.all.toggle.isOn = self._last_toggle_effect_group_obj_rule_a.all
		end

		for iter_5_0, iter_5_1 in pairs(self._last_toggle_effect_group_obj_rule_b) do
			if iter_5_1 ~= self._toggle_effect_group_obj._rule_b.set[iter_5_0] then
				self._control.type_layer.effect_group.toggle_group[iter_5_0].toggle.isOn = iter_5_1
			end
		end

		if self._toggle_type_group_obj and self._last_toggle_type_group_obj_rule_a.all ~= self._toggle_type_group_obj._rule_a.set.all then
			self._control.type_layer.type_group.toggle_group.all.toggle.isOn = self._last_toggle_type_group_obj_rule_a.all
		end

		for iter_5_2, iter_5_3 in pairs(self._last_toggle_type_group_obj_rule_b) do
			if iter_5_3 ~= self._toggle_type_group_obj._rule_b.set[iter_5_2] then
				self._control.type_layer.type_group.toggle_group[iter_5_2].toggle.isOn = iter_5_3
			end
		end

		self._type_toggle_txt = ""
	end

	function arg_1_0:__save_toggle_group_all_set_data()
		self._last_toggle_effect_group_obj_rule_a = var_0_2.little_clone(self._toggle_effect_group_obj._rule_a.set)
		self._last_toggle_effect_group_obj_rule_b = var_0_2.little_clone(self._toggle_effect_group_obj._rule_b.set)
		self._last_toggle_type_group_obj_rule_a = var_0_2.little_clone(self._toggle_type_group_obj._rule_a.set)
		self._last_toggle_type_group_obj_rule_b = var_0_2.little_clone(self._toggle_type_group_obj._rule_b.set)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_all()
		self._toggle_type_group_obj:toggleOn("all", self._toggle_type_group.all.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_main_gun()
		self._toggle_type_group_obj:toggleOn("main_gun", self._toggle_type_group.main_gun.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_sub_gun()
		self._toggle_type_group_obj:toggleOn("sub_gun", self._toggle_type_group.sub_gun.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_torpedo()
		self._toggle_type_group_obj:toggleOn("torpedo", self._toggle_type_group.torpedo.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_torpedo_plane()
		self._toggle_type_group_obj:toggleOn("torpedo_plane", self._toggle_type_group.torpedo_plane.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_fighter()
		self._toggle_type_group_obj:toggleOn("fighter", self._toggle_type_group.fighter.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_bomber()
		self._toggle_type_group_obj:toggleOn("bomber", self._toggle_type_group.bomber.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_spy_plane()
		self._toggle_type_group_obj:toggleOn("spy_plane", self._toggle_type_group.spy_plane.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_radar()
		self._toggle_type_group_obj:toggleOn("radar", self._toggle_type_group.radar.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_module()
		self._toggle_type_group_obj:toggleOn("module", self._toggle_type_group.module.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_bullet()
		self._toggle_type_group_obj:toggleOn("bullet", self._toggle_type_group.bullet.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_aagun()
		self._toggle_type_group_obj:toggleOn("aagun", self._toggle_type_group.aagun.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_special_torpedo()
		self._toggle_type_group_obj:toggleOn("special_torpedo", self._toggle_type_group.special_torpedo.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_repairs()
		self._toggle_type_group_obj:toggleOn("repairs", self._toggle_type_group.repairs.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_anti_sub()
		self._toggle_type_group_obj:toggleOn("anti_sub", self._toggle_type_group.anti_sub.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_missile_launcher()
		self._toggle_type_group_obj:toggleOn("missile_launcher", self._toggle_type_group.missile_launcher.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_missile()
		self._toggle_type_group_obj:toggleOn("missile", self._toggle_type_group.missile.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_effect_group_toggle_group_all()
		self._toggle_effect_group_obj:toggleOn("all", self._toggle_effect_group.all.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_effect_group_toggle_group_attack()
		self._toggle_effect_group_obj:toggleOn("attack", self._toggle_effect_group.attack.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_effect_group_toggle_group_extra_damage()
		self._toggle_effect_group_obj:toggleOn("extra_damage", self._toggle_effect_group.extra_damage.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_effect_group_toggle_group_exp_up()
		self._toggle_effect_group_obj:toggleOn("exp_up", self._toggle_effect_group.exp_up.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_effect_group_toggle_group_armor_pene()
		self._toggle_effect_group_obj:toggleOn("armor_pene", self._toggle_effect_group.armor_pene.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_effect_group_toggle_group_expedition_resource()
		self._toggle_effect_group_obj:toggleOn("expedition_resource", self._toggle_effect_group.expedition_resource.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_effect_group_toggle_group_hit_rate()
		self._toggle_effect_group_obj:toggleOn("hit_rate", self._toggle_effect_group.hit_rate.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_effect_group_toggle_group_miss()
		self._toggle_effect_group_obj:toggleOn("miss", self._toggle_effect_group.miss.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_effect_group_toggle_group_critical_rate()
		self._toggle_effect_group_obj:toggleOn("critical_rate", self._toggle_effect_group.critical_rate.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_effect_group_toggle_group_anti_air()
		self._toggle_effect_group_obj:toggleOn("anti_air", self._toggle_effect_group.anti_air.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_effect_group_toggle_group_atk_top()
		self._toggle_effect_group_obj:toggleOn("atk_top", self._toggle_effect_group.atk_top.toggle.isOn)
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_all(arg_35_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_main_gun(arg_36_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_sub_gun(arg_37_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_torpedo(arg_38_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_torpedo_plane(arg_39_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_fighter(arg_40_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_bomber(arg_41_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_spy_plane(arg_42_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_radar(arg_43_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_module(arg_44_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_bullet(arg_45_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_aagun(arg_46_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_special_torpedo(arg_47_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_repairs(arg_48_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_anti_sub(arg_49_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_missile_launcher(arg_50_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_missile(arg_51_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_effect_group_toggle_group_all(arg_52_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_effect_group_toggle_group_attack(arg_53_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_effect_group_toggle_group_extra_damage(arg_54_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_effect_group_toggle_group_exp_up(arg_55_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_effect_group_toggle_group_armor_pene(arg_56_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_effect_group_toggle_group_expedition_resource(arg_57_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_effect_group_toggle_group_hit_rate(arg_58_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_effect_group_toggle_group_miss(arg_59_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_effect_group_toggle_group_critical_rate(arg_60_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_effect_group_toggle_group_anti_air(arg_61_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_effect_group_toggle_group_atk_top(arg_62_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_effect_group_toggle_group_other(arg_63_0)
		return
	end

	function arg_1_0:__toggle_event(arg_64_1, arg_64_2)
		if not self._is_init_type_layer then
			return
		end

		if arg_64_2 then
			self._type_toggle_data = {
				arg_64_1
			}
			self._type_toggle_txt = arg_64_1 == "all" and "equip0" or arg_64_1 == "missile_launcher" and "equip32" or arg_64_1 == "missile" and "equip34" or "equip" .. tostring(var_0_3.equip_type[arg_64_1])

			if self._confirm_listener then
				self._confirm_listener()
			end

			self:setVisible(false)
			self:__set_search_result()
		end
	end

	function arg_1_0:__change_type_text()
		local var_65_0 = false
		local var_65_1

		if self._type_toggle_data.all then
			var_65_1 = false
		elseif var_0_2.dict_lenght(self._type_toggle_data) <= 2 then
			for iter_65_0, iter_65_1 in pairs(self._type_toggle_data) do
				if iter_65_0 == "missile_launcher" then
					var_65_1 = var_0_1:getNowLang("equip32")
				elseif iter_65_0 == "missile" then
					var_65_1 = var_0_1:getNowLang("equip34")
				elseif iter_65_0 ~= "all" then
					var_65_1 = var_0_1:getNowLang("equip" .. tostring(var_0_3.equip_type[iter_65_0]))
				end
			end
		else
			var_65_0 = true
		end

		local var_65_2

		if var_0_2.dict_lenght(self._effect_toggle_data) <= 2 then
			for iter_65_2, iter_65_3 in pairs(self._effect_toggle_data) do
				if iter_65_2 == "attack" then
					var_65_2 = var_0_1:getNowLang("equipment_effect_type_1")
				elseif iter_65_2 == "extra_damage" then
					var_65_2 = var_0_1:getNowLang("equipment_effect_type_2")
				elseif iter_65_2 == "exp_up" then
					var_65_2 = var_0_1:getNowLang("equipment_effect_type_3")
				elseif iter_65_2 == "armor_pene" then
					var_65_2 = var_0_1:getNowLang("equipment_effect_type_4")
				elseif iter_65_2 == "expedition_resource" then
					var_65_2 = var_0_1:getNowLang("equipment_effect_type_5")
				elseif iter_65_2 == "hit_rate" then
					var_65_2 = var_0_1:getNowLang("equipment_effect_type_6")
				elseif iter_65_2 == "miss" then
					var_65_2 = var_0_1:getNowLang("equipment_effect_type_7")
				elseif iter_65_2 == "critical_rate" then
					var_65_2 = var_0_1:getNowLang("equipment_effect_type_8")
				elseif iter_65_2 == "anti_air" then
					var_65_2 = var_0_1:getNowLang("equipment_effect_type_9")
				elseif iter_65_2 == "atk_top" then
					var_65_2 = var_0_1:getNowLang("equipment_effect_type_10")
				end
			end
		elseif not self._effect_toggle_data.all then
			var_65_0 = true
		end

		self._type_toggle_txt = var_65_0 and var_0_1:getNowLang("multiselect") or var_65_1 and var_65_2 and var_0_1:getNowLang("multiselect") or var_65_1 and not var_65_2 and var_65_1 or not var_65_1 and var_65_2 and var_65_2 or var_0_1:getNowLang("questall")
	end
end

function var_0_0.extend_obj(arg_66_0)
	arg_66_0._need_revert = false
	arg_66_0._last_toggle_type_group_obj_rule_a = {}
	arg_66_0._last_toggle_type_group_obj_rule_b = {}
	arg_66_0._last_toggle_effect_group_obj_rule_a = {}
	arg_66_0._last_toggle_effect_group_obj_rule_b = {}
end

return var_0_0
