local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = gamecore.util_func
local var_0_5 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_buy_msgbox_main_quitbtn()
		self._control.buy_msgbox.gameObject:SetActive(false)
	end

	function arg_1_0.__onClick_buy_msgbox_main_quitbtn_revert(arg_3_0)
		return
	end

	function arg_1_0.__onClick_buy_msgbox_main_confirmbtn(arg_4_0)
		return
	end

	function arg_1_0.__onClick_buy_msgbox_main_confirmbtn_revert(arg_5_0)
		return
	end

	function arg_1_0:__onClick_buy_msgbox_main_closebtn()
		self._control.buy_msgbox.gameObject:SetActive(false)
	end

	function arg_1_0:__onClick_top_return_btn()
		self:__onToggle_type_btn_group_all()

		self._control.top.ship_type_btn.type_text.text.text = var_0_2:getNowLang("skill0")

		self:setVisible(false)

		self._country_toggle_data = {
			all = true
		}
		self._type_toggle_data = {
			all = true
		}
		self._buff_type_toggle_data = {
			all = true
		}
		self._need_revert = false

		self:_reset_type_layer()

		local var_7_0 = var_0_3:getInstance("fearlessness_sea")

		if var_7_0 then
			var_7_0:show()
		end
	end

	function arg_1_0:__onClick_top_type_btn()
		self._control.type.gameObject:SetActive(true)
	end

	function arg_1_0.__onClick_top_revert_btn(arg_9_0)
		var_0_1:req_PushResetBuffReq()
	end

	function arg_1_0:__onClick_top_ship_type_btn()
		self._control.type_layer:SetActive(true)
	end

	function arg_1_0:__onClick_type_bg_shadow()
		self._control.type.gameObject:SetActive(false)
	end

	function arg_1_0:__change_type_text()
		local var_12_0 = false
		local var_12_1

		if self._type_toggle_data.all then
			var_12_1 = false
		elseif var_0_4.dict_lenght(self._type_toggle_data) <= 2 then
			for iter_12_0, iter_12_1 in pairs(self._type_toggle_data) do
				if iter_12_0 == "CLT" then
					var_12_1 = var_0_2:getNowLang("shiptype9")
				elseif iter_12_0 ~= "all" then
					var_12_1 = var_0_2:getNowLang("shiptype" .. tostring(var_0_5.filter_type[iter_12_0]))
				end
			end
		else
			var_12_0 = true
		end

		local var_12_2

		if not self._country_toggle_data.all and var_0_4.dict_lenght(self._country_toggle_data) <= 2 then
			for iter_12_2, iter_12_3 in pairs(self._country_toggle_data) do
				if iter_12_2 == "other_country" then
					var_12_2 = var_0_2:getNowLang("country9")
				elseif iter_12_2 ~= "all" then
					var_12_2 = var_0_2:getNowLang("country" .. tostring(var_0_5.filter_country[iter_12_2]))
				end
			end
		elseif not self._country_toggle_data.all then
			var_12_0 = true
		end

		local var_12_3 = self._buff_data_select == "attribute_up" and var_0_2:getNowLang("ninth_buff_type_1") or self._buff_data_select == "damage_up" and var_0_2:getNowLang("ninth_buff_type_2") or self._buff_data_select == "ignore_hurt" and var_0_2:getNowLang("ninth_buff_type_3") or self._buff_data_select == " ignore_lack_ammu" and var_0_2:getNowLang("ninth_buff_type_4") or self._buff_data_select == "capacity_up" and var_0_2:getNowLang("ninth_buff_type_5") or self._buff_data_select == "support_atk" and var_0_2:getNowLang("ninth_buff_type_6") or false
		local var_12_4 = var_12_0 and var_0_2:getNowLang("multiselect") or var_12_1 and var_12_2 and var_12_3 and var_0_2:getNowLang("multiselect") or var_12_1 and var_12_2 and var_12_1 .. "+" .. var_12_2 or var_12_1 and var_12_3 and var_12_1 .. "+" .. var_12_3 or var_12_2 and var_12_3 and var_12_2 .. "+" .. var_12_3 or (var_12_3 or var_12_1 or var_12_2) and (var_12_3 or var_12_1 or var_12_2) or var_0_2:getNowLang("questall")

		if string.len(var_12_4) > 12 then
			var_12_4 = var_0_2:getNowLang("multiselect")
		end

		self._control.top.ship_type_btn.type_text.text.text = var_12_4
	end

	function arg_1_0.__check_size_large(arg_13_0, arg_13_1)
		local var_13_0 = true

		for iter_13_0, iter_13_1 in pairs(arg_13_1) do
			if not var_0_4.have_data(var_0_5.ship_size_type_list.large, iter_13_0) and iter_13_1 then
				var_13_0 = false
			end
		end

		for iter_13_2, iter_13_3 in pairs(var_0_5.ship_size_type_list.large) do
			if not arg_13_1[iter_13_3] then
				var_13_0 = false
			end
		end

		return var_13_0
	end

	function arg_1_0.__check_size_middle(arg_14_0, arg_14_1)
		local var_14_0 = true

		for iter_14_0, iter_14_1 in pairs(arg_14_1) do
			if not var_0_4.have_data(var_0_5.ship_size_type_list.middle, iter_14_0) and iter_14_1 then
				var_14_0 = false
			end
		end

		for iter_14_2, iter_14_3 in pairs(var_0_5.ship_size_type_list.middle) do
			if not arg_14_1[iter_14_3] then
				var_14_0 = false
			end
		end

		return var_14_0
	end

	function arg_1_0.__check_size_small(arg_15_0, arg_15_1)
		local var_15_0 = true

		for iter_15_0, iter_15_1 in pairs(arg_15_1) do
			if not var_0_4.have_data(var_0_5.ship_size_type_list.small, iter_15_0) and iter_15_1 then
				var_15_0 = false
			end
		end

		for iter_15_2, iter_15_3 in pairs(var_0_5.ship_size_type_list.small) do
			if not arg_15_1[iter_15_3] then
				var_15_0 = false
			end
		end

		return var_15_0
	end

	function arg_1_0:__check_type_group_to_size_group(arg_16_1)
		local var_16_1 = self._toggle_type_group_obj._rule_b.set

		self._is_click_type_toggle = true

		if arg_16_1 == "all" then
			self._control.type_layer.size_group.toggle_group.all.toggle.isOn = true

			return
		else
			self._toggle_size_group_obj:toggleOnOnly("all", false, true)
		end

		self._control.type_layer.size_group.toggle_group.large.toggle.isOn = not not self:__check_size_large(var_16_1)
		self._control.type_layer.size_group.toggle_group.middle.toggle.isOn = not not self:__check_size_middle(var_16_1)
		self._control.type_layer.size_group.toggle_group.small.toggle.isOn = not not self:__check_size_small(var_16_1)
		self._control.type_layer.size_group.toggle_group.maip.toggle.isOn = not not self:__check_size_maip(var_16_1)
		self._control.type_layer.size_group.toggle_group.protect.toggle.isOn = not not self:__check_size_protect(var_16_1)
	end

	function arg_1_0:__check_size_group_to_type_group(arg_17_1)
		if arg_17_1 == "all" then
			self._control.type_layer.type_group.toggle_group.all.toggle.isOn = self._toggle_size_group_obj._rule_a.set.all

			return
		end

		if arg_17_1 == "middle" then
			for iter_17_0, iter_17_1 in pairs(self._toggle_type_group_obj._rule_b.set) do
				self._control.type_layer.type_group.toggle_group[iter_17_0].toggle.isOn = not not var_0_4.have_data(var_0_5.ship_size_type_list.middle, iter_17_0)
			end

			self._control.type_layer.type_group.toggle_group.all.toggle.isOn = not self._toggle_size_group_obj._rule_b.set.middle

			return
		end

		if arg_17_1 == "large" then
			for iter_17_2, iter_17_3 in pairs(self._toggle_type_group_obj._rule_b.set) do
				self._control.type_layer.type_group.toggle_group[iter_17_2].toggle.isOn = not not var_0_4.have_data(var_0_5.ship_size_type_list.large, iter_17_2)
			end

			self._control.type_layer.type_group.toggle_group.all.toggle.isOn = not self._toggle_size_group_obj._rule_b.set.large

			return
		end

		if arg_17_1 == "small" then
			for iter_17_4, iter_17_5 in pairs(self._toggle_type_group_obj._rule_b.set) do
				self._control.type_layer.type_group.toggle_group[iter_17_4].toggle.isOn = not not var_0_4.have_data(var_0_5.ship_size_type_list.small, iter_17_4)
			end

			self._control.type_layer.type_group.toggle_group.all.toggle.isOn = not self._toggle_size_group_obj._rule_b.set.small

			return
		end

		if arg_17_1 == "maip" then
			for iter_17_6, iter_17_7 in pairs(self._toggle_type_group_obj._rule_b.set) do
				self._control.type_layer.type_group.toggle_group[iter_17_6].toggle.isOn = not not var_0_4.have_data(var_0_5.ship_size_type_list.maip, iter_17_6)
			end

			self._control.type_layer.type_group.toggle_group.all.toggle.isOn = not self._toggle_size_group_obj._rule_b.set.maip

			return
		end

		if arg_17_1 == "protect" then
			for iter_17_8, iter_17_9 in pairs(self._toggle_type_group_obj._rule_b.set) do
				self._control.type_layer.type_group.toggle_group[iter_17_8].toggle.isOn = not not var_0_4.have_data(var_0_5.ship_size_type_list.protect, iter_17_8)
			end

			self._control.type_layer.type_group.toggle_group.all.toggle.isOn = not self._toggle_size_group_obj._rule_b.set.protect

			return
		end
	end

	function arg_1_0:__onToggle_type_btn_group_all()
		self:__select_one("all")
		self._control.type.gameObject:SetActive(false)
	end

	function arg_1_0:__onToggle_type_btn_group_active()
		self._control.type.gameObject:SetActive(false)
		self:__select_one("active")
	end

	function arg_1_0:__onToggle_type_btn_group_disable()
		self._control.type.gameObject:SetActive(false)
		self:__select_one("disable")
	end

	function arg_1_0:__onToggle_type_btn_group_brought()
		self._control.type.gameObject:SetActive(false)
		self:__select_one("brought")
	end

	function arg_1_0:__save_toggle_group_all_set_data()
		self._last_toggle_size_group_obj_rule_a = var_0_4.little_clone(self._toggle_size_group_obj._rule_a.set)
		self._last_toggle_size_group_obj_rule_b = var_0_4.little_clone(self._toggle_size_group_obj._rule_b.set)
		self._last_toggle_type_group_obj_rule_a = var_0_4.little_clone(self._toggle_type_group_obj._rule_a.set)
		self._last_toggle_type_group_obj_rule_b = var_0_4.little_clone(self._toggle_type_group_obj._rule_b.set)
		self._last_toggle_country_group_obj_rule_a = var_0_4.little_clone(self._toggle_country_group_obj._rule_a.set)
		self._last_toggle_country_group_obj_rule_b = var_0_4.little_clone(self._toggle_country_group_obj._rule_b.set)
		self._last_toggle_buff_type_group_obj_rule_a = var_0_4.little_clone(self._toggle_buff_type_group_obj._rule_a.set)
		self._last_toggle_buff_type_group_obj_rule_b = var_0_4.little_clone(self._toggle_buff_type_group_obj._rule_b.set)
	end

	function arg_1_0:__revert_toggle_group_all_set()
		if self._last_toggle_size_group_obj_rule_a.all ~= self._toggle_size_group_obj._rule_a.set.all then
			self._control.type_layer.size_group.toggle_group.all.toggle.isOn = self._last_toggle_size_group_obj_rule_a.all
		end

		for iter_23_0, iter_23_1 in pairs(self._last_toggle_size_group_obj_rule_b) do
			if iter_23_1 ~= self._toggle_size_group_obj._rule_b.set[iter_23_0] then
				self._control.type_layer.size_group.toggle_group[iter_23_0].toggle.isOn = iter_23_1
			end
		end

		if self._last_toggle_type_group_obj_rule_a.all ~= self._toggle_type_group_obj._rule_a.set.all then
			self._control.type_layer.type_group.toggle_group.all.toggle.isOn = self._last_toggle_type_group_obj_rule_a.all
		end

		for iter_23_2, iter_23_3 in pairs(self._last_toggle_type_group_obj_rule_b) do
			if iter_23_3 ~= self._toggle_type_group_obj._rule_b.set[iter_23_2] then
				self._control.type_layer.type_group.toggle_group[iter_23_2].toggle.isOn = iter_23_3
			end
		end

		if self._last_toggle_country_group_obj_rule_a.all ~= self._toggle_country_group_obj._rule_a.set.all then
			self._control.type_layer.country_group.toggle_group.all.toggle.isOn = self._last_toggle_country_group_obj_rule_a.all
		end

		for iter_23_4, iter_23_5 in pairs(self._last_toggle_country_group_obj_rule_b) do
			if iter_23_5 ~= self._toggle_country_group_obj._rule_b.set[iter_23_4] then
				self._control.type_layer.country_group.toggle_group[iter_23_4].toggle.isOn = iter_23_5
			end
		end

		if self._last_toggle_buff_type_group_obj_rule_a.all ~= self._toggle_buff_type_group_obj._rule_a.set.all then
			self._control.type_layer.buff_type_group.toggle_group.all.toggle.isOn = self._last_toggle_buff_type_group_obj_rule_a.all
		end

		for iter_23_6, iter_23_7 in pairs(self._last_toggle_buff_type_group_obj_rule_b) do
			if iter_23_7 ~= self._toggle_buff_type_group_obj._rule_b.set[iter_23_6] then
				self._control.type_layer.buff_type_group.toggle_group[iter_23_6].toggle.isOn = iter_23_7
			end
		end
	end

	function arg_1_0:_reset_type_layer()
		for iter_24_0, iter_24_1 in pairs(self._toggle_size_group) do
			iter_24_1.toggle.isOn = iter_24_0 == "all"
		end

		self._toggle_type_group_obj.all = true

		for iter_24_2, iter_24_3 in pairs(self._toggle_type_group) do
			iter_24_3.toggle.isOn = false
		end

		self._toggle_country_group_obj.all = true

		for iter_24_4, iter_24_5 in pairs(self._toggle_country_group) do
			iter_24_5.toggle.isOn = false
		end

		for iter_24_6, iter_24_7 in pairs(self._toggle_buff_type_group) do
			iter_24_7.toggle.isOn = iter_24_6 == "all"
		end
	end

	function arg_1_0:__onClick_type_layer()
		self:__onClick_type_layer_btn_series_confirm_btn()
		self:show_sort_layer(false)
	end

	function arg_1_0:__onClick_type_layer_btn_series_confirm_btn()
		self._country_toggle_data = {}
		self._type_toggle_data = {}
		self._buff_type_toggle_data = {}
		self._type_toggle_data.all = self._toggle_type_group_obj._rule_a.set.all

		for iter_26_0, iter_26_1 in pairs(self._toggle_type_group_obj._rule_b.set) do
			if iter_26_1 then
				self._type_toggle_data[iter_26_0] = iter_26_1
			end
		end

		self._country_toggle_data.all = self._toggle_country_group_obj._rule_a.set.all

		for iter_26_2, iter_26_3 in pairs(self._toggle_country_group_obj._rule_b.set) do
			if iter_26_3 then
				self._country_toggle_data[iter_26_2] = iter_26_3
			end
		end

		self._buff_type_toggle_data.all = self._toggle_buff_type_group_obj._rule_a.set.all

		for iter_26_4, iter_26_5 in pairs(self._toggle_buff_type_group_obj._rule_b.set) do
			if iter_26_5 then
				self._buff_type_toggle_data[iter_26_4] = iter_26_5
			end
		end

		self._control.type_layer:SetActive(false)
		self:__change_type_text()
		self:__init_type_data()
	end

	function arg_1_0:__onClick_type_layer_btn_series_cancel_btn()
		self:show_sort_layer(false)

		self._need_revert = true
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_all(arg_28_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_C_country(arg_29_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_E_country(arg_30_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_F_country(arg_31_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_G_country(arg_32_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_I_country(arg_33_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_J_country(arg_34_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_S_country(arg_35_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_U_country(arg_36_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_other_country(arg_37_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_all(arg_38_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_CV(arg_39_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_CVL(arg_40_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_AV(arg_41_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_BB(arg_42_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_BBV(arg_43_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_BC(arg_44_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_CA(arg_45_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_CAV(arg_46_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_CLT(arg_47_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_CL(arg_48_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_BM(arg_49_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_DD(arg_50_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_SSG(arg_51_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_SS(arg_52_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_SC(arg_53_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_AP(arg_54_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_ASDG(arg_55_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_AADG(arg_56_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_KP(arg_57_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_CG(arg_58_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_CBG(arg_59_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_BBG(arg_60_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_BG(arg_61_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_size_group_toggle_group_all(arg_62_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_size_group_toggle_group_large(arg_63_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_size_group_toggle_group_middle(arg_64_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_size_group_toggle_group_small(arg_65_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_size_group_toggle_group_maip(arg_66_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_size_group_toggle_group_protect(arg_67_0)
		return
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
		self._toggle_type_group_obj:toggleOnOnly("all", self._toggle_type_group.all.toggle.isOn)
		self:__check_type_group_to_size_group("all")
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

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_KP()
		self._toggle_type_group_obj:toggleOn("KP", self._toggle_type_group.KP.toggle.isOn)
		self:__check_type_group_to_size_group(30)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_CG()
		self._toggle_type_group_obj:toggleOn("CG", self._toggle_type_group.CG.toggle.isOn)
		self:__check_type_group_to_size_group(29)
	end

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_BG()
		self._toggle_type_group_obj:toggleOn("BG", self._toggle_type_group.BG.toggle.isOn)
		self:__check_type_group_to_size_group()
	end

	function arg_1_0.__check_size_maip(arg_102_0, arg_102_1)
		local var_102_0 = true

		for iter_102_0, iter_102_1 in pairs(arg_102_1) do
			if not var_0_4.have_data(var_0_5.ship_size_type_list.maip, iter_102_0) and iter_102_1 then
				var_102_0 = false
			end
		end

		for iter_102_2, iter_102_3 in pairs(var_0_5.ship_size_type_list.maip) do
			if not arg_102_1[iter_102_3] then
				var_102_0 = false
			end
		end

		return var_102_0
	end

	function arg_1_0.__check_size_protect(arg_103_0, arg_103_1)
		local var_103_0 = true

		for iter_103_0, iter_103_1 in pairs(arg_103_1) do
			if not var_0_4.have_data(var_0_5.ship_size_type_list.protect, iter_103_0) and iter_103_1 then
				var_103_0 = false
			end
		end

		for iter_103_2, iter_103_3 in pairs(var_0_5.ship_size_type_list.protect) do
			if not arg_103_1[iter_103_3] then
				var_103_0 = false
			end
		end

		return var_103_0
	end

	function arg_1_0:__onToggle_all_do_type_layer_size_group_toggle_group_all(arg_104_1)
		self._toggle_size_group_obj:toggleOnOnly("all", self._toggle_size_group.all.toggle.isOn)
		self:__check_size_group_to_type_group("all")
	end

	function arg_1_0:__onToggle_all_do_type_layer_size_group_toggle_group_large(arg_105_1)
		self._toggle_size_group_obj:toggleOnOnly("large", self._toggle_size_group.large.toggle.isOn)

		if arg_105_1 then
			self:__check_size_group_to_type_group("large")

			self._is_click_type_toggle = false
		elseif not self._is_click_type_toggle then
			self._toggle_size_group.all.toggle.isOn = true
		end
	end

	function arg_1_0:__onToggle_all_do_type_layer_size_group_toggle_group_middle(arg_106_1)
		self._toggle_size_group_obj:toggleOnOnly("middle", self._toggle_size_group.middle.toggle.isOn)

		if arg_106_1 then
			self:__check_size_group_to_type_group("middle")

			self._is_click_type_toggle = false
		elseif not self._is_click_type_toggle then
			self._toggle_size_group.all.toggle.isOn = true
		end
	end

	function arg_1_0:__onToggle_all_do_type_layer_size_group_toggle_group_small(arg_107_1)
		self._toggle_size_group_obj:toggleOnOnly("small", self._toggle_size_group.small.toggle.isOn)

		if arg_107_1 then
			self:__check_size_group_to_type_group("small")

			self._is_click_type_toggle = false
		elseif not self._is_click_type_toggle then
			self._toggle_size_group.all.toggle.isOn = true
		end
	end

	function arg_1_0:__onToggle_all_do_type_layer_size_group_toggle_group_maip(arg_108_1)
		self._toggle_size_group_obj:toggleOnOnly("maip", self._toggle_size_group.maip.toggle.isOn)

		if arg_108_1 then
			self:__check_size_group_to_type_group("maip")

			self._is_click_type_toggle = false
		elseif not self._is_click_type_toggle then
			self._toggle_size_group.all.toggle.isOn = true
		end
	end

	function arg_1_0:__onToggle_all_do_type_layer_size_group_toggle_group_protect(arg_109_1)
		self._toggle_size_group_obj:toggleOnOnly("protect", self._toggle_size_group.protect.toggle.isOn)

		if arg_109_1 then
			self:__check_size_group_to_type_group("protect")

			self._is_click_type_toggle = false
		elseif not self._is_click_type_toggle then
			self._toggle_size_group.all.toggle.isOn = true
		end
	end

	function arg_1_0.__onToggle_type_layer_buff_type_group_toggle_group_all(arg_110_0)
		arg_110_0._buff_data_select = "all"
	end

	function arg_1_0.__onToggle_type_layer_buff_type_group_toggle_group_attribute_up(arg_111_0)
		arg_111_0._buff_data_select = "attribute_up"
	end

	function arg_1_0.__onToggle_type_layer_buff_type_group_toggle_group_damage_up(arg_112_0)
		arg_112_0._buff_data_select = "damage_up"
	end

	function arg_1_0.__onToggle_type_layer_buff_type_group_toggle_group_ignore_hurt(arg_113_0)
		arg_113_0._buff_data_select = "ignore_hurt"
	end

	function arg_1_0.__onToggle_type_layer_buff_type_group_toggle_group_ignore_lack_ammu(arg_114_0)
		arg_114_0._buff_data_select = "ignore_lack_ammu"
	end

	function arg_1_0.__onToggle_type_layer_buff_type_group_toggle_group_capacity_up(arg_115_0)
		arg_115_0._buff_data_select = "capacity_up"
	end

	function arg_1_0.__onToggle_type_layer_buff_type_group_toggle_group_support_atk(arg_116_0)
		arg_116_0._buff_data_select = "support_atk"
	end

	function arg_1_0.__onClick_npc(arg_117_0)
		return
	end
end

function var_0_0.extend_obj(arg_118_0)
	arg_118_0._need_revert = false
	arg_118_0._last_toggle_size_group_obj_rule_a = {}
	arg_118_0._last_toggle_size_group_obj_rule_b = {}
	arg_118_0._last_toggle_type_group_obj_rule_a = {}
	arg_118_0._last_toggle_type_group_obj_rule_b = {}
	arg_118_0._last_toggle_buff_type_group_obj_rule_a = {}
	arg_118_0._last_toggle_buff_type_group_obj_rule_b = {}
	arg_118_0._is_click_type_toggle = false
end

return var_0_0
