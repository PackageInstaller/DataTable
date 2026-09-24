local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_3 = gameenum.common_type
local var_0_4 = gamecore.util_func
local var_0_5 = gamecore.user

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_top_return_btn()
		self:enter_or_return_tween(false)
	end

	function arg_1_0:__onClick_top_type_layer_btn()
		if self._need_revert then
			self:__revert_toggle_group_all_set()

			self._need_revert = false
		end

		self:__save_toggle_group_all_set_data()
		self:show_sort_layer(true)
	end

	function arg_1_0:__onClick_top_type_btn()
		self._control.type.gameObject:SetActive(true)
	end

	function arg_1_0:__onClick_top_revert_btn()
		if not self.__if_revert_btn then
			return
		end

		self._control.buy_msgbox.main.title_text.text.text = var_0_1:getNowLang("campaignresettitle")
		self._control.buy_msgbox.main.main_text.text.text.text = var_0_1:getNowLang("ui_4th_buff_reset_content")

		self._control.buy_msgbox.gameObject:SetActive(true)
		self._control.buy_msgbox.main.confirmbtn.gameObject:SetActive(false)
		self._control.buy_msgbox.main.quitbtn.gameObject:SetActive(false)
		self._control.buy_msgbox.main.confirmbtn_revert.gameObject:SetActive(true)
		self._control.buy_msgbox.main.quitbtn_revert.gameObject:SetActive(true)
	end

	function arg_1_0:__onClick_buy_msgbox_main_quitbtn()
		self._control.buy_msgbox.gameObject:SetActive(false)
	end

	function arg_1_0.__onClick_buy_msgbox_main_confirmbtn(arg_7_0)
		return
	end

	function arg_1_0:__onClick_buy_msgbox_main_closebtn()
		self._control.buy_msgbox.gameObject:SetActive(false)
	end

	function arg_1_0:__onClick_type_bg_shadow()
		self._control.type.gameObject:SetActive(false)
	end

	function arg_1_0:__onToggle_type_btn_group_all()
		self:__select_one("all")
		self._control.type.gameObject:SetActive(false)
	end

	function arg_1_0:__onToggle_type_btn_group_unlock()
		self._control.type.gameObject:SetActive(false)
		self:__select_one("unlock")
	end

	function arg_1_0:__onToggle_type_btn_group_lock()
		self._control.type.gameObject:SetActive(false)
		self:__select_one("lock")
	end

	function arg_1_0:__onToggle_type_btn_group_active()
		self._control.type.gameObject:SetActive(false)
		self:__select_one("active")
	end

	function arg_1_0:__onToggle_type_btn_group_disable()
		self._control.type.gameObject:SetActive(false)
		self:__select_one("disable")
	end

	function arg_1_0:__onClick_type_layer()
		self:show_sort_layer(false)
	end

	function arg_1_0:__onClick_type_layer_btn_series_confirm_btn()
		self._country_toggle_data = {}
		self._type_toggle_data = {}
		self._type_toggle_data.all = self._toggle_type_group_obj._rule_a.set.all

		for iter_16_0, iter_16_1 in pairs(self._toggle_type_group_obj._rule_b.set) do
			if iter_16_1 then
				self._type_toggle_data[iter_16_0] = iter_16_1
			end
		end

		self._country_toggle_data.all = self._toggle_country_group_obj._rule_a.set.all

		for iter_16_2, iter_16_3 in pairs(self._toggle_country_group_obj._rule_b.set) do
			if iter_16_3 then
				self._country_toggle_data[iter_16_2] = iter_16_3
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

	function arg_1_0:__onToggle_all_do_type_layer_type_group_toggle_group_BG()
		self._toggle_type_group_obj:toggleOn("BG", self._toggle_type_group.BG.toggle.isOn)
		self:__check_type_group_to_size_group()
	end

	function arg_1_0:__onToggle_all_do_type_layer_size_group_toggle_group_all()
		self._toggle_size_group_obj:toggleOnOnly("all", self._toggle_size_group.all.toggle.isOn)
		self:__check_size_group_to_type_group("all")
	end

	function arg_1_0:__onToggle_all_do_type_layer_size_group_toggle_group_large()
		self._toggle_size_group_obj:toggleOnOnly("large", self._toggle_size_group.large.toggle.isOn)
		self:__check_size_group_to_type_group("large")
	end

	function arg_1_0:__onToggle_all_do_type_layer_size_group_toggle_group_middle()
		self._toggle_size_group_obj:toggleOnOnly("middle", self._toggle_size_group.middle.toggle.isOn)
		self:__check_size_group_to_type_group("middle")
	end

	function arg_1_0:__onToggle_all_do_type_layer_size_group_toggle_group_small()
		self._toggle_size_group_obj:toggleOnOnly("small", self._toggle_size_group.small.toggle.isOn)
		self:__check_size_group_to_type_group("small")
	end

	function arg_1_0:__change_type_text()
		local var_54_0 = false
		local var_54_1

		if self._type_toggle_data.all then
			var_54_1 = var_0_1:getNowLang("shiptype0")
		elseif var_0_4.dict_lenght(self._type_toggle_data) <= 2 then
			for iter_54_0, iter_54_1 in pairs(self._type_toggle_data) do
				if iter_54_0 == "CLT" then
					var_54_1 = var_0_1:getNowLang("shiptype9")
				elseif iter_54_0 ~= "all" then
					var_54_1 = var_0_1:getNowLang("shiptype" .. tostring(var_0_3.filter_type[iter_54_0]))
				end
			end
		else
			var_54_0 = true
		end

		local var_54_2

		if not self._country_toggle_data.all and var_0_4.dict_lenght(self._country_toggle_data) <= 2 then
			for iter_54_2, iter_54_3 in pairs(self._country_toggle_data) do
				if iter_54_2 == "other_country" then
					var_54_2 = var_0_1:getNowLang("country9")
				elseif iter_54_2 ~= "all" then
					var_54_2 = var_0_1:getNowLang("country" .. tostring(var_0_3.filter_country[iter_54_2]))
				end
			end
		elseif not self._country_toggle_data.all then
			var_54_0 = true
		end

		self._control.top.ship_type_btn.type_text.text.text = var_54_0 and var_0_1:getNowLang("multiselect") or var_54_1 and var_54_2 and var_54_1 .. "+" .. var_54_2 or (var_54_1 or var_54_2) and (var_54_1 or var_54_2) or var_0_1:getNowLang("questall")
	end

	function arg_1_0.__check_size_large(arg_55_0, arg_55_1)
		local var_55_0 = true

		for iter_55_0, iter_55_1 in pairs(arg_55_1) do
			if not var_0_4.have_data(var_0_3.ship_size_type_list.large, iter_55_0) and iter_55_1 then
				var_55_0 = false
			end
		end

		for iter_55_2, iter_55_3 in pairs(var_0_3.ship_size_type_list.large) do
			if not arg_55_1[iter_55_3] then
				var_55_0 = false
			end
		end

		return var_55_0
	end

	function arg_1_0.__check_size_middle(arg_56_0, arg_56_1)
		local var_56_0 = true

		for iter_56_0, iter_56_1 in pairs(arg_56_1) do
			if not var_0_4.have_data(var_0_3.ship_size_type_list.middle, iter_56_0) and iter_56_1 then
				var_56_0 = false
			end
		end

		for iter_56_2, iter_56_3 in pairs(var_0_3.ship_size_type_list.middle) do
			if not arg_56_1[iter_56_3] then
				var_56_0 = false
			end
		end

		return var_56_0
	end

	function arg_1_0.__check_size_small(arg_57_0, arg_57_1)
		local var_57_0 = true

		for iter_57_0, iter_57_1 in pairs(arg_57_1) do
			if not var_0_4.have_data(var_0_3.ship_size_type_list.small, iter_57_0) and iter_57_1 then
				var_57_0 = false
			end
		end

		for iter_57_2, iter_57_3 in pairs(var_0_3.ship_size_type_list.small) do
			if not arg_57_1[iter_57_3] then
				var_57_0 = false
			end
		end

		return var_57_0
	end

	function arg_1_0:__check_type_group_to_size_group(arg_58_1)
		local var_58_0 = self._toggle_type_group_obj._rule_b.set

		if self._toggle_type_group_obj._rule_a.set.all then
			self._control.type_layer.size_group.toggle_group.all.toggle.isOn = true

			return
		else
			self._toggle_size_group_obj:toggleOnOnly("all", false, true)
		end

		self._control.type_layer.size_group.toggle_group.large.toggle.isOn = not not self:__check_size_large(var_58_0)
		self._control.type_layer.size_group.toggle_group.middle.toggle.isOn = not not self:__check_size_middle(var_58_0)
		self._control.type_layer.size_group.toggle_group.small.toggle.isOn = not not self:__check_size_small(var_58_0)
	end

	function arg_1_0:__check_size_group_to_type_group(arg_59_1)
		if arg_59_1 == "all" then
			self._control.type_layer.type_group.toggle_group.all.toggle.isOn = self._toggle_size_group_obj._rule_a.set.all

			return
		end

		if arg_59_1 == "middle" then
			for iter_59_0, iter_59_1 in pairs(self._toggle_type_group_obj._rule_b.set) do
				self._control.type_layer.type_group.toggle_group[iter_59_0].toggle.isOn = not not var_0_4.have_data(var_0_3.ship_size_type_list.middle, iter_59_0)
			end

			self._control.type_layer.type_group.toggle_group.all.toggle.isOn = not self._toggle_size_group_obj._rule_b.set.middle

			return
		end

		if arg_59_1 == "large" then
			for iter_59_2, iter_59_3 in pairs(self._toggle_type_group_obj._rule_b.set) do
				self._control.type_layer.type_group.toggle_group[iter_59_2].toggle.isOn = not not var_0_4.have_data(var_0_3.ship_size_type_list.large, iter_59_2)
			end

			self._control.type_layer.type_group.toggle_group.all.toggle.isOn = not self._toggle_size_group_obj._rule_b.set.large

			return
		end

		if arg_59_1 == "small" then
			for iter_59_4, iter_59_5 in pairs(self._toggle_type_group_obj._rule_b.set) do
				self._control.type_layer.type_group.toggle_group[iter_59_4].toggle.isOn = not not var_0_4.have_data(var_0_3.ship_size_type_list.small, iter_59_4)
			end

			self._control.type_layer.type_group.toggle_group.all.toggle.isOn = not self._toggle_size_group_obj._rule_b.set.small

			return
		end
	end

	function arg_1_0:__save_toggle_group_all_set_data()
		self._last_toggle_size_group_obj_rule_a = var_0_4.little_clone(self._toggle_size_group_obj._rule_a.set)
		self._last_toggle_size_group_obj_rule_b = var_0_4.little_clone(self._toggle_size_group_obj._rule_b.set)
		self._last_toggle_type_group_obj_rule_a = var_0_4.little_clone(self._toggle_type_group_obj._rule_a.set)
		self._last_toggle_type_group_obj_rule_b = var_0_4.little_clone(self._toggle_type_group_obj._rule_b.set)
		self._last_toggle_country_group_obj_rule_a = var_0_4.little_clone(self._toggle_country_group_obj._rule_a.set)
		self._last_toggle_country_group_obj_rule_b = var_0_4.little_clone(self._toggle_country_group_obj._rule_b.set)
	end

	function arg_1_0:__revert_toggle_group_all_set()
		if self._last_toggle_size_group_obj_rule_a.all ~= self._toggle_size_group_obj._rule_a.set.all then
			self._control.type_layer.size_group.toggle_group.all.toggle.isOn = self._last_toggle_size_group_obj_rule_a.all
		end

		for iter_61_0, iter_61_1 in pairs(self._last_toggle_size_group_obj_rule_b) do
			if iter_61_1 ~= self._toggle_size_group_obj._rule_b.set[iter_61_0] then
				self._control.type_layer.size_group.toggle_group[iter_61_0].toggle.isOn = iter_61_1
			end
		end

		if self._last_toggle_type_group_obj_rule_a.all ~= self._toggle_type_group_obj._rule_a.set.all then
			self._control.type_layer.type_group.toggle_group.all.toggle.isOn = self._last_toggle_type_group_obj_rule_a.all
		end

		for iter_61_2, iter_61_3 in pairs(self._last_toggle_type_group_obj_rule_b) do
			if iter_61_3 ~= self._toggle_type_group_obj._rule_b.set[iter_61_2] then
				self._control.type_layer.type_group.toggle_group[iter_61_2].toggle.isOn = iter_61_3
			end
		end

		if self._last_toggle_country_group_obj_rule_a.all ~= self._toggle_country_group_obj._rule_a.set.all then
			self._control.type_layer.country_group.toggle_group.all.toggle.isOn = self._last_toggle_country_group_obj_rule_a.all
		end

		for iter_61_4, iter_61_5 in pairs(self._last_toggle_country_group_obj_rule_b) do
			if iter_61_5 ~= self._toggle_country_group_obj._rule_b.set[iter_61_4] then
				self._control.type_layer.country_group.toggle_group[iter_61_4].toggle.isOn = iter_61_5
			end
		end
	end

	function arg_1_0:_reset_type_layer()
		for iter_62_0, iter_62_1 in pairs(self._toggle_size_group) do
			iter_62_1.toggle.isOn = iter_62_0 == "all"
		end

		self._toggle_type_group_obj.all = true

		for iter_62_2, iter_62_3 in pairs(self._toggle_type_group) do
			iter_62_3.toggle.isOn = false
		end

		self._toggle_country_group_obj.all = true

		for iter_62_4, iter_62_5 in pairs(self._toggle_country_group) do
			iter_62_5.toggle.isOn = false
		end
	end

	function arg_1_0:__onClick_buy_msgbox_main_quitbtn_revert()
		self._control.buy_msgbox.gameObject:SetActive(false)
	end

	function arg_1_0:__onClick_buy_msgbox_main_confirmbtn_revert()
		if self.__if_revert_btn then
			var_0_5:req_OceanResetBuyReq()
			self._control.buy_msgbox.gameObject:SetActive(false)
		end
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_all(arg_65_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_C_country(arg_66_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_E_country(arg_67_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_F_country(arg_68_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_G_country(arg_69_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_I_country(arg_70_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_J_country(arg_71_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_S_country(arg_72_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_U_country(arg_73_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_other_country(arg_74_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_all(arg_75_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_CV(arg_76_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_CVL(arg_77_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_AV(arg_78_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_BB(arg_79_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_BBV(arg_80_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_BC(arg_81_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_CA(arg_82_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_CAV(arg_83_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_CLT(arg_84_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_CL(arg_85_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_BM(arg_86_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_DD(arg_87_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_SSG(arg_88_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_SS(arg_89_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_SC(arg_90_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_AP(arg_91_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_ASDG(arg_92_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_AADG(arg_93_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_CBG(arg_94_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_BBG(arg_95_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_BG(arg_96_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_size_group_toggle_group_all(arg_97_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_size_group_toggle_group_large(arg_98_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_size_group_toggle_group_middle(arg_99_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_size_group_toggle_group_small(arg_100_0)
		return
	end

	function arg_1_0:__onClick_top_ship_type_btn()
		self._control.type_layer:SetActive(true)
	end
end

function var_0_0.extend_obj(arg_102_0)
	arg_102_0._need_revert = false
	arg_102_0._last_toggle_size_group_obj_rule_a = {}
	arg_102_0._last_toggle_size_group_obj_rule_b = {}
	arg_102_0._last_toggle_type_group_obj_rule_a = {}
	arg_102_0._last_toggle_type_group_obj_rule_b = {}
end

return var_0_0
