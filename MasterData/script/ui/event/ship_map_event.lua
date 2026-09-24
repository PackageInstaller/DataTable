local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gameenum.common_type
local var_0_4 = gamecore.util_func
local var_0_5 = gamecore.user

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_top_return_btn()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))
		self:play_in_out_animation(false, function()
			var_0_2:destroyInstance("ship_map")
			var_0_4.return_home_with_menu_active()
		end)

		local var_2_0 = var_0_2:getInstance("home")

		if var_2_0 and var_0_5:get_secretary_info().rand_secretary_flag == 1 then
			var_2_0:updata_model()
		end
	end

	function arg_1_0:__onClick_remould_btn()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.task_top_btn))

		self._now_label = self._now_label == 1 and 2 or 1

		self:show_scroll_by_index(self._now_label)
		self:init_general_cell_list()

		if not self._first_into then
			self._control.scrollview_2.scrollbarvertical.scrollbar.value = self._control.scrollview_1.scrollbarvertical.transform:GetComponent("Scrollbar").value
			self._first_into = true
		end
	end

	function arg_1_0:__onClick_type_btn()
		if self._need_revert then
			self:__revert_toggle_group_all_set()

			self._need_revert = false
		else
			self:__onToggle_all_do_type_layer_bg_country_group_toggle_group_all()
		end

		self:__save_toggle_group_all_set_data()
		self:show_sort_layer(true)
	end

	function arg_1_0.__onClick_type_layer(arg_6_0)
		return
	end

	function arg_1_0:__onClick_type_layer_bg()
		self:__clear_input_field_name()

		self._country_toggle_data = {}
		self._type_toggle_data = {}
		self._own_toggle_data = {}
		self._type_toggle_data.all = self._toggle_type_group_obj._rule_a.set.all

		for iter_7_0, iter_7_1 in pairs(self._toggle_type_group_obj._rule_b.set) do
			if iter_7_1 then
				self._type_toggle_data[iter_7_0] = iter_7_1
			end
		end

		self._country_toggle_data.all = self._toggle_country_group_obj._rule_a.set.all

		for iter_7_2, iter_7_3 in pairs(self._toggle_country_group_obj._rule_b.set) do
			if iter_7_3 then
				self._country_toggle_data[iter_7_2] = iter_7_3
			end
		end

		self._control.type_layer:SetActive(false)
		self:__change_type_text()

		self._is_limit_release = not (self._type_toggle_data.all and self._country_toggle_data.all)

		self:init_general_cell_list()
		self:show_sort_layer(false)
	end

	function arg_1_0:__onClick_type_layer_bg_btn_series_confirm_btn()
		self._country_toggle_data = {}
		self._type_toggle_data = {}
		self._own_toggle_data = {}

		self:__clear_input_field_name()

		self._type_toggle_data.all = self._toggle_type_group_obj._rule_a.set.all

		for iter_8_0, iter_8_1 in pairs(self._toggle_type_group_obj._rule_b.set) do
			if iter_8_1 then
				self._type_toggle_data[iter_8_0] = iter_8_1
			end
		end

		self._country_toggle_data.all = self._toggle_country_group_obj._rule_a.set.all

		for iter_8_2, iter_8_3 in pairs(self._toggle_country_group_obj._rule_b.set) do
			if iter_8_3 then
				self._country_toggle_data[iter_8_2] = iter_8_3
			end
		end

		self._control.type_layer:SetActive(false)
		self:__change_type_text()

		self._is_limit_release = not (self._type_toggle_data.all and self._country_toggle_data.all)

		self:init_general_cell_list()
	end

	function arg_1_0:__onClick_type_layer_bg_btn_series_cancel_btn()
		self:__clear_input_field_name()
		self:show_sort_layer(false)

		self._need_revert = true
		self._own_data_select = self._old_own_data_select
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_country_group_toggle_group_all()
		self._toggle_country_group_obj:toggleOn("all", self._toggle_country_group.all.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_country_group_toggle_group_C_country()
		self._toggle_country_group_obj:toggleOn("C_country", self._toggle_country_group.C_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_country_group_toggle_group_E_country()
		self._toggle_country_group_obj:toggleOn("E_country", self._toggle_country_group.E_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_country_group_toggle_group_F_country()
		self._toggle_country_group_obj:toggleOn("F_country", self._toggle_country_group.F_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_country_group_toggle_group_G_country()
		self._toggle_country_group_obj:toggleOn("G_country", self._toggle_country_group.G_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_country_group_toggle_group_I_country()
		self._toggle_country_group_obj:toggleOn("I_country", self._toggle_country_group.I_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_country_group_toggle_group_J_country()
		self._toggle_country_group_obj:toggleOn("J_country", self._toggle_country_group.J_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_country_group_toggle_group_S_country()
		self._toggle_country_group_obj:toggleOn("S_country", self._toggle_country_group.S_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_country_group_toggle_group_U_country()
		self._toggle_country_group_obj:toggleOn("U_country", self._toggle_country_group.U_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_country_group_toggle_group_other_country()
		self._toggle_country_group_obj:toggleOn("other_country", self._toggle_country_group.other_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_type_group_toggle_group_all()
		self._toggle_type_group_obj:toggleOn("all", self._toggle_type_group.all.toggle.isOn)
		self:__check_type_group_to_size_group()
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_type_group_toggle_group_CV()
		self._toggle_type_group_obj:toggleOn("CV", self._toggle_type_group.CV.toggle.isOn)
		self:__check_type_group_to_size_group(1)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_type_group_toggle_group_CVL()
		self._toggle_type_group_obj:toggleOn("CVL", self._toggle_type_group.CVL.toggle.isOn)
		self:__check_type_group_to_size_group(2)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_type_group_toggle_group_AV()
		self._toggle_type_group_obj:toggleOn("AV", self._toggle_type_group.AV.toggle.isOn)
		self:__check_type_group_to_size_group(3)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_type_group_toggle_group_BB()
		self._toggle_type_group_obj:toggleOn("BB", self._toggle_type_group.BB.toggle.isOn)
		self:__check_type_group_to_size_group(4)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_type_group_toggle_group_BBV()
		self._toggle_type_group_obj:toggleOn("BBV", self._toggle_type_group.BBV.toggle.isOn)
		self:__check_type_group_to_size_group(5)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_type_group_toggle_group_BC()
		self._toggle_type_group_obj:toggleOn("BC", self._toggle_type_group.BC.toggle.isOn)
		self:__check_type_group_to_size_group(6)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_type_group_toggle_group_CA()
		self._toggle_type_group_obj:toggleOn("CA", self._toggle_type_group.CA.toggle.isOn)
		self:__check_type_group_to_size_group(7)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_type_group_toggle_group_CAV()
		self._toggle_type_group_obj:toggleOn("CAV", self._toggle_type_group.CAV.toggle.isOn)
		self:__check_type_group_to_size_group(8)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_type_group_toggle_group_CLT()
		self._toggle_type_group_obj:toggleOn("CLT", self._toggle_type_group.CLT.toggle.isOn)
		self:__check_type_group_to_size_group(9)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_type_group_toggle_group_CL()
		self._toggle_type_group_obj:toggleOn("CL", self._toggle_type_group.CL.toggle.isOn)
		self:__check_type_group_to_size_group(10)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_type_group_toggle_group_BM()
		self._toggle_type_group_obj:toggleOn("BM", self._toggle_type_group.BM.toggle.isOn)
		self:__check_type_group_to_size_group(11)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_type_group_toggle_group_DD()
		self._toggle_type_group_obj:toggleOn("DD", self._toggle_type_group.DD.toggle.isOn)
		self:__check_type_group_to_size_group(12)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_type_group_toggle_group_SSG()
		self._toggle_type_group_obj:toggleOn("SSG", self._toggle_type_group.SSG.toggle.isOn)
		self:__check_type_group_to_size_group(13)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_type_group_toggle_group_SS()
		self._toggle_type_group_obj:toggleOn("SS", self._toggle_type_group.SS.toggle.isOn)
		self:__check_type_group_to_size_group(14)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_type_group_toggle_group_SC()
		self._toggle_type_group_obj:toggleOn("SC", self._toggle_type_group.SC.toggle.isOn)
		self:__check_type_group_to_size_group(15)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_type_group_toggle_group_AP()
		self._toggle_type_group_obj:toggleOn("AP", self._toggle_type_group.AP.toggle.isOn)
		self:__check_type_group_to_size_group(16)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_type_group_toggle_group_ASDG()
		self._toggle_type_group_obj:toggleOn("ASDG", self._toggle_type_group.ASDG.toggle.isOn)
		self:__check_type_group_to_size_group(23)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_type_group_toggle_group_AADG()
		self._toggle_type_group_obj:toggleOn("AADG", self._toggle_type_group.AADG.toggle.isOn)
		self:__check_type_group_to_size_group(24)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_type_group_toggle_group_KP()
		self._toggle_type_group_obj:toggleOn("KP", self._toggle_type_group.KP.toggle.isOn)
		self:__check_type_group_to_size_group(30)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_type_group_toggle_group_CG()
		self._toggle_type_group_obj:toggleOn("CG", self._toggle_type_group.CG.toggle.isOn)
		self:__check_type_group_to_size_group(29)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_type_group_toggle_group_CBG()
		self._toggle_type_group_obj:toggleOn("CBG", self._toggle_type_group.CBG.toggle.isOn)
		self:__check_type_group_to_size_group(26)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_type_group_toggle_group_BBG()
		self._toggle_type_group_obj:toggleOn("BBG", self._toggle_type_group.BBG.toggle.isOn)
		self:__check_type_group_to_size_group(27)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_type_group_toggle_group_BG()
		self._toggle_type_group_obj:toggleOn("BG", self._toggle_type_group.BG.toggle.isOn)
		self:__check_type_group_to_size_group()
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_size_group_toggle_group_all()
		self._toggle_size_group_obj:toggleOnOnly("all", self._toggle_size_group.all.toggle.isOn)
		self:__check_size_group_to_type_group("all")
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_size_group_toggle_group_large(arg_45_1)
		self._toggle_size_group_obj:toggleOnOnly("large", self._toggle_size_group.large.toggle.isOn)

		if arg_45_1 then
			self:__check_size_group_to_type_group("large")

			self._is_click_type_toggle = false
		elseif not self._is_click_type_toggle then
			self._control.type_layer.bg.size_group.toggle_group.all.toggle.isOn = true
		end
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_size_group_toggle_group_middle(arg_46_1)
		self._toggle_size_group_obj:toggleOnOnly("middle", self._toggle_size_group.middle.toggle.isOn)

		if arg_46_1 then
			self:__check_size_group_to_type_group("middle")

			self._is_click_type_toggle = false
		elseif not self._is_click_type_toggle then
			self._control.type_layer.bg.size_group.toggle_group.all.toggle.isOn = true
		end
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_size_group_toggle_group_small(arg_47_1)
		self._toggle_size_group_obj:toggleOnOnly("small", self._toggle_size_group.small.toggle.isOn)

		if arg_47_1 then
			self:__check_size_group_to_type_group("small")

			self._is_click_type_toggle = false
		elseif not self._is_click_type_toggle then
			self._control.type_layer.bg.size_group.toggle_group.all.toggle.isOn = true
		end
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_size_group_toggle_group_maip(arg_48_1)
		self._toggle_size_group_obj:toggleOnOnly("maip", self._toggle_size_group.maip.toggle.isOn)

		if arg_48_1 then
			self:__check_size_group_to_type_group("maip")

			self._is_click_type_toggle = false
		elseif not self._is_click_type_toggle then
			self._control.type_layer.bg.size_group.toggle_group.all.toggle.isOn = true
		end
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_size_group_toggle_group_protect(arg_49_1)
		self._toggle_size_group_obj:toggleOnOnly("protect", self._toggle_size_group.protect.toggle.isOn)

		if arg_49_1 then
			self:__check_size_group_to_type_group("protect")

			self._is_click_type_toggle = false
		elseif not self._is_click_type_toggle then
			self._control.type_layer.bg.size_group.toggle_group.all.toggle.isOn = true
		end
	end

	function arg_1_0:__onToggle_type_layer_bg_own_group_toggle_group_all()
		self._old_own_data_select = self._own_data_select
		self._own_data_select = "all"
		self._own_btn_count.own_type = 0
		self._own_btn_count.not_own_type = 0
		self._own_btn_count.not_get_type = 0
	end

	function arg_1_0:__onToggle_type_layer_bg_own_group_toggle_group_own_type()
		self._own_btn_count.own_type = self._own_btn_count.own_type + 1
		self._own_btn_count.not_own_type = 0
		self._own_btn_count.not_get_type = 0

		if self._own_btn_count.own_type == 2 then
			self:__onToggle_type_layer_bg_own_group_toggle_group_all()

			self._control.type_layer.bg.own_group.toggle_group.all.toggle.isOn = true
			self._control.type_layer.bg.own_group.toggle_group.own_type.toggle.isOn = false

			return
		end

		self._old_own_data_select = self._own_data_select
		self._own_data_select = "own_type"
	end

	function arg_1_0:__onToggle_type_layer_bg_own_group_toggle_group_not_own_type()
		self._own_btn_count.not_own_type = self._own_btn_count.not_own_type + 1
		self._own_btn_count.own_type = 0
		self._own_btn_count.not_get_type = 0

		if self._own_btn_count.not_own_type == 2 then
			self:__onToggle_type_layer_bg_own_group_toggle_group_all()

			self._control.type_layer.bg.own_group.toggle_group.all.toggle.isOn = true
			self._control.type_layer.bg.own_group.toggle_group.not_own_type.toggle.isOn = false

			return
		end

		self._old_own_data_select = self._own_data_select
		self._own_data_select = "not_own_type"
	end

	function arg_1_0:__onToggle_type_layer_bg_own_group_toggle_group_not_get_type()
		self._own_btn_count.not_get_type = self._own_btn_count.not_get_type + 1
		self._own_btn_count.own_type = 0
		self._own_btn_count.not_own_type = 0

		if self._own_btn_count.not_get_type == 2 then
			self:__onToggle_type_layer_bg_own_group_toggle_group_all()

			self._control.type_layer.bg.own_group.toggle_group.all.toggle.isOn = true
			self._control.type_layer.bg.own_group.toggle_group.not_get_type.toggle.isOn = false

			return
		end

		self._old_own_data_select = self._own_data_select
		self._own_data_select = "not_get_type"
	end

	function arg_1_0.__onToggle_type_layer_bg_country_group_toggle_group_all(arg_54_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_country_group_toggle_group_C_country(arg_55_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_country_group_toggle_group_E_country(arg_56_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_country_group_toggle_group_F_country(arg_57_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_country_group_toggle_group_G_country(arg_58_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_country_group_toggle_group_I_country(arg_59_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_country_group_toggle_group_J_country(arg_60_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_country_group_toggle_group_S_country(arg_61_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_country_group_toggle_group_U_country(arg_62_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_country_group_toggle_group_other_country(arg_63_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_type_group_toggle_group_all(arg_64_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_type_group_toggle_group_CV(arg_65_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_type_group_toggle_group_CVL(arg_66_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_type_group_toggle_group_AV(arg_67_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_type_group_toggle_group_BB(arg_68_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_type_group_toggle_group_BBV(arg_69_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_type_group_toggle_group_BC(arg_70_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_type_group_toggle_group_CA(arg_71_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_type_group_toggle_group_CAV(arg_72_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_type_group_toggle_group_CLT(arg_73_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_type_group_toggle_group_CL(arg_74_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_type_group_toggle_group_BM(arg_75_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_type_group_toggle_group_DD(arg_76_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_type_group_toggle_group_SSG(arg_77_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_type_group_toggle_group_SS(arg_78_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_type_group_toggle_group_SC(arg_79_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_type_group_toggle_group_AP(arg_80_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_type_group_toggle_group_ASDG(arg_81_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_type_group_toggle_group_AADG(arg_82_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_type_group_toggle_group_KP(arg_83_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_type_group_toggle_group_CG(arg_84_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_type_group_toggle_group_CBG(arg_85_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_type_group_toggle_group_BBG(arg_86_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_type_group_toggle_group_BG(arg_87_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_size_group_toggle_group_all(arg_88_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_size_group_toggle_group_large(arg_89_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_size_group_toggle_group_middle(arg_90_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_size_group_toggle_group_small(arg_91_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_size_group_toggle_group_maip(arg_92_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_size_group_toggle_group_protect(arg_93_0)
		return
	end

	function arg_1_0:__change_type_text()
		local var_94_0 = false
		local var_94_1

		if self._type_toggle_data.all then
			var_94_1 = false
		elseif var_0_4.dict_lenght(self._type_toggle_data) <= 2 then
			for iter_94_0, iter_94_1 in pairs(self._type_toggle_data) do
				if iter_94_0 == "CLT" then
					var_94_1 = var_0_1:getNowLang("shiptype9")
				elseif iter_94_0 ~= "all" then
					var_94_1 = var_0_1:getNowLang("shiptype" .. tostring(var_0_3.filter_type[iter_94_0]))
				end
			end
		else
			var_94_0 = true
		end

		local var_94_2

		if not self._country_toggle_data.all and var_0_4.dict_lenght(self._country_toggle_data) <= 2 then
			for iter_94_2, iter_94_3 in pairs(self._country_toggle_data) do
				if iter_94_2 == "other_country" then
					var_94_2 = var_0_1:getNowLang("country9")
				elseif iter_94_2 ~= "all" then
					var_94_2 = var_0_1:getNowLang("country" .. tostring(var_0_3.filter_country[iter_94_2]))
				end
			end
		elseif not self._country_toggle_data.all then
			var_94_0 = true
		end

		local var_94_3 = self._own_data_select == "own_type" and var_0_1:getNowLang("medaltypegain") or self._own_data_select == "not_own_type" and var_0_1:getNowLang("medaltypeungain") or self._own_data_select == "not_get_type" and var_0_1:getNowLang("nothave") or false

		self._control.type_btn.type_txt.text.text = var_94_0 and var_0_1:getNowLang("multiselect") or var_94_1 and var_94_2 and var_94_3 and var_0_1:getNowLang("multiselect") or var_94_1 and var_94_2 and var_94_1 .. "+" .. var_94_2 or var_94_1 and var_94_3 and var_94_1 .. "+" .. var_94_3 or var_94_2 and var_94_3 and var_94_2 .. "+" .. var_94_3 or (var_94_3 or var_94_1 or var_94_2) and (var_94_3 or var_94_1 or var_94_2) or var_0_1:getNowLang("questall")
	end

	function arg_1_0.__check_size_large(arg_95_0, arg_95_1)
		local var_95_0 = true

		for iter_95_0, iter_95_1 in pairs(arg_95_1) do
			if not var_0_4.have_data(var_0_3.ship_size_type_list.large, iter_95_0) and iter_95_1 then
				var_95_0 = false
			end
		end

		for iter_95_2, iter_95_3 in pairs(var_0_3.ship_size_type_list.large) do
			if not arg_95_1[iter_95_3] then
				var_95_0 = false
			end
		end

		return var_95_0
	end

	function arg_1_0.__check_size_middle(arg_96_0, arg_96_1)
		local var_96_0 = true

		for iter_96_0, iter_96_1 in pairs(arg_96_1) do
			if not var_0_4.have_data(var_0_3.ship_size_type_list.middle, iter_96_0) and iter_96_1 then
				var_96_0 = false
			end
		end

		for iter_96_2, iter_96_3 in pairs(var_0_3.ship_size_type_list.middle) do
			if not arg_96_1[iter_96_3] then
				var_96_0 = false
			end
		end

		return var_96_0
	end

	function arg_1_0.__check_size_small(arg_97_0, arg_97_1)
		local var_97_0 = true

		for iter_97_0, iter_97_1 in pairs(arg_97_1) do
			if not var_0_4.have_data(var_0_3.ship_size_type_list.small, iter_97_0) and iter_97_1 then
				var_97_0 = false
			end
		end

		for iter_97_2, iter_97_3 in pairs(var_0_3.ship_size_type_list.small) do
			if not arg_97_1[iter_97_3] then
				var_97_0 = false
			end
		end

		return var_97_0
	end

	function arg_1_0.__check_size_maip(arg_98_0, arg_98_1)
		local var_98_0 = true

		for iter_98_0, iter_98_1 in pairs(arg_98_1) do
			if not var_0_4.have_data(var_0_3.ship_size_type_list.maip, iter_98_0) and iter_98_1 then
				var_98_0 = false
			end
		end

		for iter_98_2, iter_98_3 in pairs(var_0_3.ship_size_type_list.maip) do
			if not arg_98_1[iter_98_3] then
				var_98_0 = false
			end
		end

		return var_98_0
	end

	function arg_1_0.__check_size_protect(arg_99_0, arg_99_1)
		local var_99_0 = true

		for iter_99_0, iter_99_1 in pairs(arg_99_1) do
			if not var_0_4.have_data(var_0_3.ship_size_type_list.protect, iter_99_0) and iter_99_1 then
				var_99_0 = false
			end
		end

		for iter_99_2, iter_99_3 in pairs(var_0_3.ship_size_type_list.protect) do
			if not arg_99_1[iter_99_3] then
				var_99_0 = false
			end
		end

		return var_99_0
	end

	function arg_1_0:__check_type_group_to_size_group(arg_100_1)
		local var_100_0 = self._toggle_type_group_obj._rule_b.set

		self._is_click_type_toggle = true

		if self._toggle_type_group_obj._rule_a.set.all then
			self._control.type_layer.bg.size_group.toggle_group.all.toggle.isOn = true

			return
		else
			self._toggle_size_group_obj:toggleOnOnly("all", false, true)
		end

		self._control.type_layer.bg.size_group.toggle_group.large.toggle.isOn = not not self:__check_size_large(var_100_0)
		self._control.type_layer.bg.size_group.toggle_group.middle.toggle.isOn = not not self:__check_size_middle(var_100_0)
		self._control.type_layer.bg.size_group.toggle_group.small.toggle.isOn = not not self:__check_size_small(var_100_0)
		self._control.type_layer.bg.size_group.toggle_group.maip.toggle.isOn = not not self:__check_size_maip(var_100_0)
		self._control.type_layer.bg.size_group.toggle_group.protect.toggle.isOn = not not self:__check_size_protect(var_100_0)
	end

	function arg_1_0:__check_size_group_to_type_group(arg_101_1)
		if arg_101_1 == "all" then
			self._control.type_layer.bg.type_group.toggle_group.all.toggle.isOn = self._toggle_size_group_obj._rule_a.set.all

			return
		end

		if arg_101_1 == "middle" then
			for iter_101_0, iter_101_1 in pairs(self._toggle_type_group_obj._rule_b.set) do
				self._control.type_layer.bg.type_group.toggle_group[iter_101_0].toggle.isOn = not not var_0_4.have_data(var_0_3.ship_size_type_list.middle, iter_101_0)
			end

			self._control.type_layer.bg.type_group.toggle_group.all.toggle.isOn = not self._toggle_size_group_obj._rule_b.set.middle

			return
		end

		if arg_101_1 == "large" then
			for iter_101_2, iter_101_3 in pairs(self._toggle_type_group_obj._rule_b.set) do
				self._control.type_layer.bg.type_group.toggle_group[iter_101_2].toggle.isOn = not not var_0_4.have_data(var_0_3.ship_size_type_list.large, iter_101_2)
			end

			self._control.type_layer.bg.type_group.toggle_group.all.toggle.isOn = not self._toggle_size_group_obj._rule_b.set.large

			return
		end

		if arg_101_1 == "small" then
			for iter_101_4, iter_101_5 in pairs(self._toggle_type_group_obj._rule_b.set) do
				self._control.type_layer.bg.type_group.toggle_group[iter_101_4].toggle.isOn = not not var_0_4.have_data(var_0_3.ship_size_type_list.small, iter_101_4)
			end

			self._control.type_layer.bg.type_group.toggle_group.all.toggle.isOn = not self._toggle_size_group_obj._rule_b.set.small

			return
		end

		if arg_101_1 == "maip" then
			for iter_101_6, iter_101_7 in pairs(self._toggle_type_group_obj._rule_b.set) do
				self._control.type_layer.bg.type_group.toggle_group[iter_101_6].toggle.isOn = not not var_0_4.have_data(var_0_3.ship_size_type_list.maip, iter_101_6)
			end

			self._control.type_layer.bg.type_group.toggle_group.all.toggle.isOn = not self._toggle_size_group_obj._rule_b.set.maip

			return
		end

		if arg_101_1 == "protect" then
			for iter_101_8, iter_101_9 in pairs(self._toggle_type_group_obj._rule_b.set) do
				self._control.type_layer.bg.type_group.toggle_group[iter_101_8].toggle.isOn = not not var_0_4.have_data(var_0_3.ship_size_type_list.protect, iter_101_8)
			end

			self._control.type_layer.bg.type_group.toggle_group.all.toggle.isOn = not self._toggle_size_group_obj._rule_b.set.protect

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
			self._control.type_layer.bg.size_group.toggle_group.all.toggle.isOn = self._last_toggle_size_group_obj_rule_a.all
		end

		for iter_103_0, iter_103_1 in pairs(self._last_toggle_size_group_obj_rule_b) do
			if iter_103_1 ~= self._toggle_size_group_obj._rule_b.set[iter_103_0] then
				self._control.type_layer.bg.size_group.toggle_group[iter_103_0].toggle.isOn = iter_103_1
			end
		end

		if self._last_toggle_type_group_obj_rule_a.all ~= self._toggle_type_group_obj._rule_a.set.all then
			self._control.type_layer.bg.type_group.toggle_group.all.toggle.isOn = self._last_toggle_type_group_obj_rule_a.all
		end

		for iter_103_2, iter_103_3 in pairs(self._last_toggle_type_group_obj_rule_b) do
			if iter_103_3 ~= self._toggle_type_group_obj._rule_b.set[iter_103_2] then
				self._control.type_layer.bg.type_group.toggle_group[iter_103_2].toggle.isOn = iter_103_3
			end
		end

		if self._last_toggle_country_group_obj_rule_a.all ~= self._toggle_country_group_obj._rule_a.set.all then
			self._control.type_layer.bg.country_group.toggle_group.all.toggle.isOn = self._last_toggle_country_group_obj_rule_a.all
		end

		for iter_103_4, iter_103_5 in pairs(self._last_toggle_country_group_obj_rule_b) do
			if iter_103_5 ~= self._toggle_country_group_obj._rule_b.set[iter_103_4] then
				self._control.type_layer.bg.country_group.toggle_group[iter_103_4].toggle.isOn = iter_103_5
			end
		end

		self._own_btn_count = {}
		self._own_btn_count.own_type = 0
		self._own_btn_count.not_own_type = 0
		self._own_btn_count.not_get_type = 0

		if self._old_own_data_select == "all" then
			self._control.type_layer.bg.own_group.toggle_group.all.toggle.isOn = true
			self._control.type_layer.bg.own_group.toggle_group.own_type.toggle.isOn = false
			self._control.type_layer.bg.own_group.toggle_group.not_own_type.toggle.isOn = false
			self._control.type_layer.bg.own_group.toggle_group.not_get_type.toggle.isOn = false
		elseif self._old_own_data_select == "own_type" then
			self._own_btn_count.own_type = 1
			self._control.type_layer.bg.own_group.toggle_group.all.toggle.isOn = false
			self._control.type_layer.bg.own_group.toggle_group.own_type.toggle.isOn = true
			self._control.type_layer.bg.own_group.toggle_group.not_own_type.toggle.isOn = false
			self._control.type_layer.bg.own_group.toggle_group.not_get_type.toggle.isOn = false
		elseif self._old_own_data_select == "not_own_type" then
			self._own_btn_count.not_own_type = 1
			self._control.type_layer.bg.own_group.toggle_group.all.toggle.isOn = false
			self._control.type_layer.bg.own_group.toggle_group.own_type.toggle.isOn = false
			self._control.type_layer.bg.own_group.toggle_group.not_own_type.toggle.isOn = true
			self._control.type_layer.bg.own_group.toggle_group.not_get_type.toggle.isOn = false
		elseif self._old_own_data_select == "not_get_type" then
			self._own_btn_count.not_get_type = 1
			self._control.type_layer.bg.own_group.toggle_group.all.toggle.isOn = false
			self._control.type_layer.bg.own_group.toggle_group.own_type.toggle.isOn = false
			self._control.type_layer.bg.own_group.toggle_group.not_own_type.toggle.isOn = false
			self._control.type_layer.bg.own_group.toggle_group.not_get_type.toggle.isOn = true
		end
	end

	function arg_1_0:_reset_type_layer()
		for iter_104_0, iter_104_1 in pairs(self._toggle_size_group) do
			iter_104_1.toggle.isOn = iter_104_0 == "all"
		end

		self._toggle_type_group_obj.all = true

		for iter_104_2, iter_104_3 in pairs(self._toggle_type_group) do
			iter_104_3.toggle.isOn = false
		end

		self._toggle_country_group_obj.all = true

		for iter_104_4, iter_104_5 in pairs(self._toggle_country_group) do
			iter_104_5.toggle.isOn = false
		end
	end
end

function var_0_0.extend_obj(arg_105_0)
	arg_105_0._need_revert = false
	arg_105_0._last_toggle_size_group_obj_rule_a = {}
	arg_105_0._last_toggle_size_group_obj_rule_b = {}
	arg_105_0._last_toggle_type_group_obj_rule_a = {}
	arg_105_0._last_toggle_type_group_obj_rule_b = {}
	arg_105_0._last_toggle_country_group_obj_rule_a = {}
	arg_105_0._last_toggle_country_group_obj_rule_b = {}
	arg_105_0._is_click_type_toggle = false
end

return var_0_0
