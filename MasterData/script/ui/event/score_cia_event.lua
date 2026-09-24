local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.Language
local var_0_5 = gamecore.util_func
local var_0_6 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_buy_msgbox_main_quitbtn()
		self._control.buy_msgbox.gameObject:SetActive(false)
	end

	function arg_1_0:__onClick_buy_msgbox_main_quitbtn_revert()
		self._control.buy_msgbox.gameObject:SetActive(false)
	end

	function arg_1_0.__onClick_buy_msgbox_main_confirmbtn(arg_4_0)
		return
	end

	function arg_1_0.__onClick_buy_msgbox_main_confirmbtn_revert(arg_5_0)
		return
	end

	function arg_1_0:__onClick_top_type_layer_btn()
		if self._need_revert then
			self:__revert_toggle_group_all_set()

			self._need_revert = false
		end

		self:__save_toggle_group_all_set_data()
		self:show_sort_layer(true)
	end

	function arg_1_0:__onClick_buy_msgbox_main_closebtn()
		self._control.buy_msgbox.gameObject:SetActive(false)
	end

	function arg_1_0:__onClick_top_return_btn()
		self:__onToggle_type_btn_group_all()

		self._control.top.ship_type_btn.type_text.text.text = var_0_2:getNowLang("skill0")

		self:enter_or_return_tween(false)
	end

	function arg_1_0:__onClick_top_type_btn()
		self._control.type.gameObject:SetActive(true)
	end

	function arg_1_0:__onClick_top_revert_btn()
		var_0_1:req_AnswerResetBuyReq()
		self._control.buy_msgbox.gameObject:SetActive(false)
		self:__update_cell()
	end

	function arg_1_0:__onClick_top_ship_type_btn()
		self._control.type_layer:SetActive(true)
	end

	function arg_1_0:__onClick_type_bg_shadow()
		self._control.type.gameObject:SetActive(false)
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

	function arg_1_0:__onClick_type_layer()
		self:__onClick_type_layer_btn_series_confirm_btn()
		self:show_sort_layer(false)
	end

	function arg_1_0:__onClick_type_layer_btn_series_confirm_btn()
		self._country_toggle_data = {}
		self._type_toggle_data = {}
		self._buff_type_toggle_data = {}
		self._type_toggle_data.all = self._toggle_type_group_obj._rule_a.set.all

		for iter_18_0, iter_18_1 in pairs(self._toggle_type_group_obj._rule_b.set) do
			if iter_18_1 then
				self._type_toggle_data[iter_18_0] = iter_18_1
			end
		end

		self._country_toggle_data.all = self._toggle_country_group_obj._rule_a.set.all

		for iter_18_2, iter_18_3 in pairs(self._toggle_country_group_obj._rule_b.set) do
			if iter_18_3 then
				self._country_toggle_data[iter_18_2] = iter_18_3
			end
		end

		self._buff_type_toggle_data.all = self._toggle_buff_type_group_obj._rule_a.set.all

		for iter_18_4, iter_18_5 in pairs(self._toggle_buff_type_group_obj._rule_b.set) do
			if iter_18_5 then
				self._buff_type_toggle_data[iter_18_4] = iter_18_5
			end
		end

		self._control.type_layer:SetActive(false)
		self:__change_type_text()
		self:__init_type_data()
	end

	function arg_1_0.__check_size_maip(arg_19_0, arg_19_1)
		local var_19_0 = true

		for iter_19_0, iter_19_1 in pairs(arg_19_1) do
			if not var_0_5.have_data(var_0_6.ship_size_type_list.maip, iter_19_0) and iter_19_1 then
				var_19_0 = false
			end
		end

		for iter_19_2, iter_19_3 in pairs(var_0_6.ship_size_type_list.maip) do
			if not arg_19_1[iter_19_3] then
				var_19_0 = false
			end
		end

		return var_19_0
	end

	function arg_1_0.__check_size_protect(arg_20_0, arg_20_1)
		local var_20_0 = true

		for iter_20_0, iter_20_1 in pairs(arg_20_1) do
			if not var_0_5.have_data(var_0_6.ship_size_type_list.protect, iter_20_0) and iter_20_1 then
				var_20_0 = false
			end
		end

		for iter_20_2, iter_20_3 in pairs(var_0_6.ship_size_type_list.protect) do
			if not arg_20_1[iter_20_3] then
				var_20_0 = false
			end
		end

		return var_20_0
	end

	function arg_1_0:__onClick_type_layer_btn_series_cancel_btn()
		self:show_sort_layer(false)

		self._need_revert = true
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_all(arg_22_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_C_country(arg_23_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_E_country(arg_24_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_F_country(arg_25_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_G_country(arg_26_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_I_country(arg_27_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_J_country(arg_28_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_S_country(arg_29_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_U_country(arg_30_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_country_group_toggle_group_other_country(arg_31_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_all(arg_32_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_CV(arg_33_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_CVL(arg_34_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_AV(arg_35_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_BB(arg_36_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_BBV(arg_37_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_BC(arg_38_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_CA(arg_39_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_CAV(arg_40_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_CLT(arg_41_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_CL(arg_42_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_BM(arg_43_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_DD(arg_44_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_SSG(arg_45_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_SS(arg_46_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_SC(arg_47_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_AP(arg_48_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_ASDG(arg_49_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_AADG(arg_50_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_CBG(arg_51_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_BBG(arg_52_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_BG(arg_53_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_size_group_toggle_group_all(arg_54_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_size_group_toggle_group_large(arg_55_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_size_group_toggle_group_middle(arg_56_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_size_group_toggle_group_small(arg_57_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_size_group_toggle_group_protect(arg_58_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_size_group_toggle_group_maip(arg_59_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_buff_type_group_toggle_group_all(arg_60_0)
		arg_60_0._buff_data_select = "all"
	end

	function arg_1_0.__onToggle_type_layer_buff_type_group_toggle_group_buff_type(arg_61_0)
		arg_61_0._buff_data_select = "buff_type"
	end

	function arg_1_0.__onToggle_type_layer_buff_type_group_toggle_group_nerf_type(arg_62_0)
		arg_62_0._buff_data_select = "nerf_type"
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

	function arg_1_0:__onToggle_all_do_type_layer_size_group_toggle_group_all(arg_97_1)
		self._toggle_size_group_obj:toggleOnOnly("all", self._toggle_size_group.all.toggle.isOn)
		self:__check_size_group_to_type_group("all")
	end

	function arg_1_0:__onToggle_all_do_type_layer_size_group_toggle_group_large(arg_98_1)
		self._toggle_size_group_obj:toggleOnOnly("large", self._toggle_size_group.large.toggle.isOn)

		if arg_98_1 then
			self:__check_size_group_to_type_group("large")

			self._is_click_type_toggle = false
		elseif not self._is_click_type_toggle then
			self._toggle_size_group.all.toggle.isOn = true
		end
	end

	function arg_1_0:__onToggle_all_do_type_layer_size_group_toggle_group_middle(arg_99_1)
		self._toggle_size_group_obj:toggleOnOnly("middle", self._toggle_size_group.middle.toggle.isOn)

		if arg_99_1 then
			self:__check_size_group_to_type_group("middle")

			self._is_click_type_toggle = false
		elseif not self._is_click_type_toggle then
			self._toggle_size_group.all.toggle.isOn = true
		end
	end

	function arg_1_0:__onToggle_all_do_type_layer_size_group_toggle_group_small(arg_100_1)
		self._toggle_size_group_obj:toggleOnOnly("small", self._toggle_size_group.small.toggle.isOn)

		if arg_100_1 then
			self:__check_size_group_to_type_group("small")

			self._is_click_type_toggle = false
		elseif not self._is_click_type_toggle then
			self._toggle_size_group.all.toggle.isOn = true
		end
	end

	function arg_1_0:__onToggle_all_do_type_layer_size_group_toggle_group_maip(arg_101_1)
		self._toggle_size_group_obj:toggleOnOnly("maip", self._toggle_size_group.maip.toggle.isOn)

		if arg_101_1 then
			self:__check_size_group_to_type_group("maip")

			self._is_click_type_toggle = false
		elseif not self._is_click_type_toggle then
			self._toggle_size_group.all.toggle.isOn = true
		end
	end

	function arg_1_0:__onToggle_all_do_type_layer_size_group_toggle_group_protect(arg_102_1)
		self._toggle_size_group_obj:toggleOnOnly("protect", self._toggle_size_group.protect.toggle.isOn)

		if arg_102_1 then
			self:__check_size_group_to_type_group("protect")

			self._is_click_type_toggle = false
		elseif not self._is_click_type_toggle then
			self._toggle_size_group.all.toggle.isOn = true
		end
	end

	function arg_1_0:__change_type_text()
		local var_103_0 = false
		local var_103_1

		if self._type_toggle_data.all then
			var_103_1 = false
		elseif var_0_5.dict_lenght(self._type_toggle_data) <= 2 then
			for iter_103_0, iter_103_1 in pairs(self._type_toggle_data) do
				if iter_103_0 == "CLT" then
					var_103_1 = var_0_2:getNowLang("shiptype9")
				elseif iter_103_0 ~= "all" then
					var_103_1 = var_0_2:getNowLang("shiptype" .. tostring(var_0_6.filter_type[iter_103_0]))
				end
			end
		else
			var_103_0 = true
		end

		local var_103_2

		if not self._country_toggle_data.all and var_0_5.dict_lenght(self._country_toggle_data) <= 2 then
			for iter_103_2, iter_103_3 in pairs(self._country_toggle_data) do
				if iter_103_2 == "other_country" then
					var_103_2 = var_0_2:getNowLang("country9")
				elseif iter_103_2 ~= "all" then
					var_103_2 = var_0_2:getNowLang("country" .. tostring(var_0_6.filter_country[iter_103_2]))
				end
			end
		elseif not self._country_toggle_data.all then
			var_103_0 = true
		end

		local var_103_3 = self._buff_data_select == "buff_type" and var_0_2:getNowLang("score_buff_growth") or self._buff_data_select == "nerf_type" and var_0_2:getNowLang("score_buff_weaken") or false

		self._control.top.ship_type_btn.type_text.text.text = var_103_0 and var_0_2:getNowLang("multiselect") or var_103_1 and var_103_2 and var_103_3 and var_0_2:getNowLang("multiselect") or var_103_1 and var_103_2 and var_103_1 .. "+" .. var_103_2 or var_103_1 and var_103_3 and var_103_1 .. "+" .. var_103_3 or var_103_2 and var_103_3 and var_103_2 .. "+" .. var_103_3 or (var_103_3 or var_103_1 or var_103_2) and (var_103_3 or var_103_1 or var_103_2) or var_0_2:getNowLang("questall")
	end

	function arg_1_0.__check_size_large(arg_104_0, arg_104_1)
		local var_104_0 = true

		for iter_104_0, iter_104_1 in pairs(arg_104_1) do
			if not var_0_5.have_data(var_0_6.ship_size_type_list.large, iter_104_0) and iter_104_1 then
				var_104_0 = false
			end
		end

		for iter_104_2, iter_104_3 in pairs(var_0_6.ship_size_type_list.large) do
			if not arg_104_1[iter_104_3] then
				var_104_0 = false
			end
		end

		return var_104_0
	end

	function arg_1_0.__check_size_middle(arg_105_0, arg_105_1)
		local var_105_0 = true

		for iter_105_0, iter_105_1 in pairs(arg_105_1) do
			if not var_0_5.have_data(var_0_6.ship_size_type_list.middle, iter_105_0) and iter_105_1 then
				var_105_0 = false
			end
		end

		for iter_105_2, iter_105_3 in pairs(var_0_6.ship_size_type_list.middle) do
			if not arg_105_1[iter_105_3] then
				var_105_0 = false
			end
		end

		return var_105_0
	end

	function arg_1_0.__check_size_small(arg_106_0, arg_106_1)
		local var_106_0 = true

		for iter_106_0, iter_106_1 in pairs(arg_106_1) do
			if not var_0_5.have_data(var_0_6.ship_size_type_list.small, iter_106_0) and iter_106_1 then
				var_106_0 = false
			end
		end

		for iter_106_2, iter_106_3 in pairs(var_0_6.ship_size_type_list.small) do
			if not arg_106_1[iter_106_3] then
				var_106_0 = false
			end
		end

		return var_106_0
	end

	function arg_1_0:__check_type_group_to_size_group(arg_107_1)
		local var_107_1 = self._toggle_type_group_obj._rule_b.set

		self._is_click_type_toggle = true

		if arg_107_1 == "all" then
			self._control.type_layer.size_group.toggle_group.all.toggle.isOn = true

			return
		else
			self._toggle_size_group_obj:toggleOnOnly("all", false, true)
		end

		self._control.type_layer.size_group.toggle_group.large.toggle.isOn = not not self:__check_size_large(var_107_1)
		self._control.type_layer.size_group.toggle_group.middle.toggle.isOn = not not self:__check_size_middle(var_107_1)
		self._control.type_layer.size_group.toggle_group.small.toggle.isOn = not not self:__check_size_small(var_107_1)
		self._control.type_layer.size_group.toggle_group.maip.toggle.isOn = not not self:__check_size_maip(var_107_1)
		self._control.type_layer.size_group.toggle_group.protect.toggle.isOn = not not self:__check_size_protect(var_107_1)
	end

	function arg_1_0:__check_size_group_to_type_group(arg_108_1)
		if arg_108_1 == "all" then
			self._control.type_layer.type_group.toggle_group.all.toggle.isOn = self._toggle_size_group_obj._rule_a.set.all

			return
		end

		if arg_108_1 == "middle" then
			for iter_108_0, iter_108_1 in pairs(self._toggle_type_group_obj._rule_b.set) do
				self._control.type_layer.type_group.toggle_group[iter_108_0].toggle.isOn = not not var_0_5.have_data(var_0_6.ship_size_type_list.middle, iter_108_0)
			end

			self._control.type_layer.type_group.toggle_group.all.toggle.isOn = not self._toggle_size_group_obj._rule_b.set.middle

			return
		end

		if arg_108_1 == "large" then
			for iter_108_2, iter_108_3 in pairs(self._toggle_type_group_obj._rule_b.set) do
				self._control.type_layer.type_group.toggle_group[iter_108_2].toggle.isOn = not not var_0_5.have_data(var_0_6.ship_size_type_list.large, iter_108_2)
			end

			self._control.type_layer.type_group.toggle_group.all.toggle.isOn = not self._toggle_size_group_obj._rule_b.set.large

			return
		end

		if arg_108_1 == "small" then
			for iter_108_4, iter_108_5 in pairs(self._toggle_type_group_obj._rule_b.set) do
				self._control.type_layer.type_group.toggle_group[iter_108_4].toggle.isOn = not not var_0_5.have_data(var_0_6.ship_size_type_list.small, iter_108_4)
			end

			self._control.type_layer.type_group.toggle_group.all.toggle.isOn = not self._toggle_size_group_obj._rule_b.set.small

			return
		end

		if arg_108_1 == "maip" then
			for iter_108_6, iter_108_7 in pairs(self._toggle_type_group_obj._rule_b.set) do
				self._control.type_layer.type_group.toggle_group[iter_108_6].toggle.isOn = not not var_0_5.have_data(var_0_6.ship_size_type_list.maip, iter_108_6)
			end

			self._control.type_layer.type_group.toggle_group.all.toggle.isOn = not self._toggle_size_group_obj._rule_b.set.maip

			return
		end

		if arg_108_1 == "protect" then
			for iter_108_8, iter_108_9 in pairs(self._toggle_type_group_obj._rule_b.set) do
				self._control.type_layer.type_group.toggle_group[iter_108_8].toggle.isOn = not not var_0_5.have_data(var_0_6.ship_size_type_list.protect, iter_108_8)
			end

			self._control.type_layer.type_group.toggle_group.all.toggle.isOn = not self._toggle_size_group_obj._rule_b.set.protect

			return
		end
	end

	function arg_1_0:__save_toggle_group_all_set_data()
		self._last_toggle_size_group_obj_rule_a = var_0_5.little_clone(self._toggle_size_group_obj._rule_a.set)
		self._last_toggle_size_group_obj_rule_b = var_0_5.little_clone(self._toggle_size_group_obj._rule_b.set)
		self._last_toggle_type_group_obj_rule_a = var_0_5.little_clone(self._toggle_type_group_obj._rule_a.set)
		self._last_toggle_type_group_obj_rule_b = var_0_5.little_clone(self._toggle_type_group_obj._rule_b.set)
		self._last_toggle_country_group_obj_rule_a = var_0_5.little_clone(self._toggle_country_group_obj._rule_a.set)
		self._last_toggle_country_group_obj_rule_b = var_0_5.little_clone(self._toggle_country_group_obj._rule_b.set)
		self._last_toggle_buff_type_group_obj_rule_a = var_0_5.little_clone(self._toggle_buff_type_group_obj._rule_a.set)
		self._last_toggle_buff_type_group_obj_rule_b = var_0_5.little_clone(self._toggle_buff_type_group_obj._rule_b.set)
	end

	function arg_1_0:__revert_toggle_group_all_set()
		if self._last_toggle_size_group_obj_rule_a.all ~= self._toggle_size_group_obj._rule_a.set.all then
			self._control.type_layer.size_group.toggle_group.all.toggle.isOn = self._last_toggle_size_group_obj_rule_a.all
		end

		for iter_110_0, iter_110_1 in pairs(self._last_toggle_size_group_obj_rule_b) do
			if iter_110_1 ~= self._toggle_size_group_obj._rule_b.set[iter_110_0] then
				self._control.type_layer.size_group.toggle_group[iter_110_0].toggle.isOn = iter_110_1
			end
		end

		if self._last_toggle_type_group_obj_rule_a.all ~= self._toggle_type_group_obj._rule_a.set.all then
			self._control.type_layer.type_group.toggle_group.all.toggle.isOn = self._last_toggle_type_group_obj_rule_a.all
		end

		for iter_110_2, iter_110_3 in pairs(self._last_toggle_type_group_obj_rule_b) do
			if iter_110_3 ~= self._toggle_type_group_obj._rule_b.set[iter_110_2] then
				self._control.type_layer.type_group.toggle_group[iter_110_2].toggle.isOn = iter_110_3
			end
		end

		if self._last_toggle_country_group_obj_rule_a.all ~= self._toggle_country_group_obj._rule_a.set.all then
			self._control.type_layer.country_group.toggle_group.all.toggle.isOn = self._last_toggle_country_group_obj_rule_a.all
		end

		for iter_110_4, iter_110_5 in pairs(self._last_toggle_country_group_obj_rule_b) do
			if iter_110_5 ~= self._toggle_country_group_obj._rule_b.set[iter_110_4] then
				self._control.type_layer.country_group.toggle_group[iter_110_4].toggle.isOn = iter_110_5
			end
		end

		if self._last_toggle_buff_type_group_obj_rule_a.all ~= self._toggle_buff_type_group_obj._rule_a.set.all then
			self._control.type_layer.buff_type_group.toggle_group.all.toggle.isOn = self._last_toggle_buff_type_group_obj_rule_a.all
		end

		for iter_110_6, iter_110_7 in pairs(self._last_toggle_buff_type_group_obj_rule_b) do
			if iter_110_7 ~= self._toggle_buff_type_group_obj._rule_b.set[iter_110_6] then
				self._control.type_layer.buff_type_group.toggle_group[iter_110_6].toggle.isOn = iter_110_7
			end
		end
	end

	function arg_1_0:_reset_type_layer()
		for iter_111_0, iter_111_1 in pairs(self._toggle_size_group) do
			iter_111_1.toggle.isOn = iter_111_0 == "all"
		end

		self._toggle_type_group_obj.all = true

		for iter_111_2, iter_111_3 in pairs(self._toggle_type_group) do
			iter_111_3.toggle.isOn = false
		end

		self._toggle_country_group_obj.all = true

		for iter_111_4, iter_111_5 in pairs(self._toggle_country_group) do
			iter_111_5.toggle.isOn = false
		end

		for iter_111_6, iter_111_7 in pairs(self._toggle_buff_type_group) do
			iter_111_7.toggle.isOn = iter_111_6 == "all"
		end
	end

	function arg_1_0.__onToggle_type_layer_buff_type_group_toggle_group_one_skill(arg_112_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_buff_type_group_toggle_group_two_skill(arg_113_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_KP(arg_114_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_CG(arg_115_0)
		return
	end
end

function var_0_0.extend_obj(arg_116_0)
	arg_116_0._need_revert = false
	arg_116_0._last_toggle_size_group_obj_rule_a = {}
	arg_116_0._last_toggle_size_group_obj_rule_b = {}
	arg_116_0._last_toggle_type_group_obj_rule_a = {}
	arg_116_0._last_toggle_type_group_obj_rule_b = {}
	arg_116_0._last_toggle_buff_type_group_obj_rule_a = {}
	arg_116_0._last_toggle_buff_type_group_obj_rule_b = {}
	arg_116_0._is_click_type_toggle = false
end

return var_0_0
