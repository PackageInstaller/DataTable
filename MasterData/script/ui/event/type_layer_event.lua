local var_0_0 = {}
local var_0_1 = gameenum.common_type
local var_0_2 = gamecore.util_func

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_bg()
		self._country_toggle_data = {}
		self._country_toggle_data.all = self._toggle_country_group_obj._rule_a.set.all

		for iter_2_0, iter_2_1 in pairs(self._toggle_country_group_obj._rule_b.set) do
			if iter_2_1 then
				self._country_toggle_data[iter_2_0] = iter_2_1
			end
		end

		if not self._is_type_limit then
			self._type_toggle_data = {}
			self._type_toggle_data.all = self._toggle_type_group_obj._rule_a.set.all

			for iter_2_2, iter_2_3 in pairs(self._toggle_type_group_obj._rule_b.set) do
				if iter_2_3 then
					self._type_toggle_data[iter_2_2] = iter_2_3
				end
			end
		end

		self._love_toggle_data = {}
		self._love_toggle_data.all = self._toggle_love_group_obj._rule_a.set.all

		for iter_2_4, iter_2_5 in pairs(self._toggle_love_group_obj._rule_b.set) do
			if iter_2_5 then
				self._love_toggle_data[iter_2_4] = iter_2_5
			end
		end

		self._rebuild_toggle_data = {
			all = self._toggle_rebuild_group.all.toggle.isOn,
			has_rebuild = self._toggle_rebuild_group.has_rebuild.toggle.isOn,
			not_rebuild = self._toggle_rebuild_group.not_rebuild.toggle.isOn,
			ship_lock = self._toggle_rebuild_group.ship_lock.toggle.isOn,
			ship_unlock = self._toggle_rebuild_group.ship_unlock.toggle.isOn
		}
		self._rebuild_toggle_data_memory = var_0_2.little_clone(self._rebuild_toggle_data)
		self._abyss_type_toggle_data = {}
		self._abyss_type_toggle_data.all = self._toggle_abyss_type_group_obj._rule_a.set.all

		for iter_2_6, iter_2_7 in pairs(self._toggle_abyss_type_group_obj._rule_b.set) do
			if iter_2_7 then
				self._abyss_type_toggle_data[iter_2_6] = iter_2_7
			end
		end

		self:setVisible(false)
		self:__update_parent_data()
	end

	function arg_1_0:__onClick_bg_btn_series_confirm_btn()
		self._country_toggle_data = {}
		self._country_toggle_data.all = self._toggle_country_group_obj._rule_a.set.all

		for iter_3_0, iter_3_1 in pairs(self._toggle_country_group_obj._rule_b.set) do
			if iter_3_1 then
				self._country_toggle_data[iter_3_0] = iter_3_1
			end
		end

		if not self._is_type_limit then
			self._type_toggle_data = {}
			self._type_toggle_data.all = self._toggle_type_group_obj._rule_a.set.all

			for iter_3_2, iter_3_3 in pairs(self._toggle_type_group_obj._rule_b.set) do
				if iter_3_3 then
					self._type_toggle_data[iter_3_2] = iter_3_3
				end
			end
		end

		self._love_toggle_data = {}
		self._love_toggle_data.all = self._toggle_love_group_obj._rule_a.set.all

		for iter_3_4, iter_3_5 in pairs(self._toggle_love_group_obj._rule_b.set) do
			if iter_3_5 then
				self._love_toggle_data[iter_3_4] = iter_3_5
			end
		end

		self._rebuild_toggle_data = {
			all = self._toggle_rebuild_group.all.toggle.isOn,
			has_rebuild = self._toggle_rebuild_group.has_rebuild.toggle.isOn,
			not_rebuild = self._toggle_rebuild_group.not_rebuild.toggle.isOn,
			ship_lock = self._toggle_rebuild_group.ship_lock.toggle.isOn,
			ship_unlock = self._toggle_rebuild_group.ship_unlock.toggle.isOn
		}
		self._rebuild_toggle_data_memory = var_0_2.little_clone(self._rebuild_toggle_data)
		self._abyss_type_toggle_data = {}
		self._abyss_type_toggle_data.all = self._toggle_abyss_type_group_obj._rule_a.set.all

		for iter_3_6, iter_3_7 in pairs(self._toggle_abyss_type_group_obj._rule_b.set) do
			if iter_3_7 then
				self._abyss_type_toggle_data[iter_3_6] = iter_3_7
			end
		end

		self:setVisible(false)
		self:__update_parent_data()
	end

	function arg_1_0:__onClick_bg_btn_series_cancel_btn()
		self:setVisible(false)

		self._need_revert = true

		self:__revert_toggle_group_all_set()
	end

	function arg_1_0:__onToggle_all_do_bg_country_group_toggle_group_all()
		self._toggle_country_group_obj:toggleOn("all", self._toggle_country_group.all.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_country_group_toggle_group_C_country()
		self._toggle_country_group_obj:toggleOn("C_country", self._toggle_country_group.C_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_country_group_toggle_group_E_country()
		self._toggle_country_group_obj:toggleOn("E_country", self._toggle_country_group.E_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_country_group_toggle_group_F_country()
		self._toggle_country_group_obj:toggleOn("F_country", self._toggle_country_group.F_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_country_group_toggle_group_G_country()
		self._toggle_country_group_obj:toggleOn("G_country", self._toggle_country_group.G_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_country_group_toggle_group_I_country()
		self._toggle_country_group_obj:toggleOn("I_country", self._toggle_country_group.I_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_country_group_toggle_group_J_country()
		self._toggle_country_group_obj:toggleOn("J_country", self._toggle_country_group.J_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_country_group_toggle_group_S_country()
		self._toggle_country_group_obj:toggleOn("S_country", self._toggle_country_group.S_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_country_group_toggle_group_U_country()
		self._toggle_country_group_obj:toggleOn("U_country", self._toggle_country_group.U_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_country_group_toggle_group_other_country()
		self._toggle_country_group_obj:toggleOn("other_country", self._toggle_country_group.other_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_type_group_toggle_group_all()
		self._toggle_type_group_obj:toggleOn("all", self._toggle_type_group.all.toggle.isOn)
		self:__check_type_group_to_size_group()
	end

	function arg_1_0:__onToggle_all_do_bg_type_group_toggle_group_CV()
		self._toggle_type_group_obj:toggleOn("CV", self._toggle_type_group.CV.toggle.isOn)
		self:__check_type_group_to_size_group(1)
	end

	function arg_1_0:__onToggle_all_do_bg_type_group_toggle_group_CVL()
		self._toggle_type_group_obj:toggleOn("CVL", self._toggle_type_group.CVL.toggle.isOn)
		self:__check_type_group_to_size_group(2)
	end

	function arg_1_0:__onToggle_all_do_bg_type_group_toggle_group_AV()
		self._toggle_type_group_obj:toggleOn("AV", self._toggle_type_group.AV.toggle.isOn)
		self:__check_type_group_to_size_group(3)
	end

	function arg_1_0:__onToggle_all_do_bg_type_group_toggle_group_BB()
		self._toggle_type_group_obj:toggleOn("BB", self._toggle_type_group.BB.toggle.isOn)
		self:__check_type_group_to_size_group(4)
	end

	function arg_1_0:__onToggle_all_do_bg_type_group_toggle_group_BBV()
		self._toggle_type_group_obj:toggleOn("BBV", self._toggle_type_group.BBV.toggle.isOn)
		self:__check_type_group_to_size_group(5)
	end

	function arg_1_0:__onToggle_all_do_bg_type_group_toggle_group_BC()
		self._toggle_type_group_obj:toggleOn("BC", self._toggle_type_group.BC.toggle.isOn)
		self:__check_type_group_to_size_group(6)
	end

	function arg_1_0:__onToggle_all_do_bg_type_group_toggle_group_CA()
		self._toggle_type_group_obj:toggleOn("CA", self._toggle_type_group.CA.toggle.isOn)
		self:__check_type_group_to_size_group(7)
	end

	function arg_1_0:__onToggle_all_do_bg_type_group_toggle_group_CAV()
		self._toggle_type_group_obj:toggleOn("CAV", self._toggle_type_group.CAV.toggle.isOn)
		self:__check_type_group_to_size_group(8)
	end

	function arg_1_0:__onToggle_all_do_bg_type_group_toggle_group_CLT()
		self._toggle_type_group_obj:toggleOn("CLT", self._toggle_type_group.CLT.toggle.isOn)
		self:__check_type_group_to_size_group(9)
	end

	function arg_1_0:__onToggle_all_do_bg_type_group_toggle_group_CL()
		self._toggle_type_group_obj:toggleOn("CL", self._toggle_type_group.CL.toggle.isOn)
		self:__check_type_group_to_size_group(10)
	end

	function arg_1_0:__onToggle_all_do_bg_type_group_toggle_group_BM()
		self._toggle_type_group_obj:toggleOn("BM", self._toggle_type_group.BM.toggle.isOn)
		self:__check_type_group_to_size_group(11)
	end

	function arg_1_0:__onToggle_all_do_bg_type_group_toggle_group_DD()
		self._toggle_type_group_obj:toggleOn("DD", self._toggle_type_group.DD.toggle.isOn)
		self:__check_type_group_to_size_group(12)
	end

	function arg_1_0:__onToggle_all_do_bg_type_group_toggle_group_SSG()
		self._toggle_type_group_obj:toggleOn("SSG", self._toggle_type_group.SSG.toggle.isOn)
		self:__check_type_group_to_size_group(13)
	end

	function arg_1_0:__onToggle_all_do_bg_type_group_toggle_group_SS()
		self._toggle_type_group_obj:toggleOn("SS", self._toggle_type_group.SS.toggle.isOn)
		self:__check_type_group_to_size_group(14)
	end

	function arg_1_0:__onToggle_all_do_bg_type_group_toggle_group_SC()
		self._toggle_type_group_obj:toggleOn("SC", self._toggle_type_group.SC.toggle.isOn)
		self:__check_type_group_to_size_group(15)
	end

	function arg_1_0:__onToggle_all_do_bg_type_group_toggle_group_AP()
		self._toggle_type_group_obj:toggleOn("AP", self._toggle_type_group.AP.toggle.isOn)
		self:__check_type_group_to_size_group(16)
	end

	function arg_1_0:__onToggle_all_do_bg_type_group_toggle_group_ASDG()
		self._toggle_type_group_obj:toggleOn("ASDG", self._toggle_type_group.ASDG.toggle.isOn)
		self:__check_type_group_to_size_group(23)
	end

	function arg_1_0:__onToggle_all_do_bg_type_group_toggle_group_AADG()
		self._toggle_type_group_obj:toggleOn("AADG", self._toggle_type_group.AADG.toggle.isOn)
		self:__check_type_group_to_size_group(24)
	end

	function arg_1_0:__onToggle_all_do_bg_type_group_toggle_group_KP()
		self._toggle_type_group_obj:toggleOn("KP", self._toggle_type_group.KP.toggle.isOn)
		self:__check_type_group_to_size_group(30)
	end

	function arg_1_0:__onToggle_all_do_bg_type_group_toggle_group_CG()
		self._toggle_type_group_obj:toggleOn("CG", self._toggle_type_group.CG.toggle.isOn)
		self:__check_type_group_to_size_group(29)
	end

	function arg_1_0:__onToggle_all_do_bg_type_group_toggle_group_CBG()
		self._toggle_type_group_obj:toggleOn("CBG", self._toggle_type_group.CBG.toggle.isOn)
		self:__check_type_group_to_size_group(26)
	end

	function arg_1_0:__onToggle_all_do_bg_type_group_toggle_group_BBG()
		self._toggle_type_group_obj:toggleOn("BBG", self._toggle_type_group.BBG.toggle.isOn)
		self:__check_type_group_to_size_group(27)
	end

	function arg_1_0:__onToggle_all_do_bg_type_group_toggle_group_BG()
		self._toggle_type_group_obj:toggleOn("BG", self._toggle_type_group.BG.toggle.isOn)
		self:__check_type_group_to_size_group(31)
	end

	function arg_1_0:__onToggle_all_do_bg_size_group_toggle_group_all()
		self._toggle_size_group_obj:toggleOnOnly("all", self._toggle_size_group.all.toggle.isOn)
		self:__check_size_group_to_type_group("all")
	end

	function arg_1_0:__onToggle_all_do_bg_size_group_toggle_group_large(arg_40_1)
		self._toggle_size_group_obj:toggleOnOnly("large", self._toggle_size_group.large.toggle.isOn)

		if arg_40_1 then
			self:__check_size_group_to_type_group("large")

			self._is_click_type_toggle = false
		elseif not self._is_click_type_toggle then
			self._control.bg.size_group.toggle_group.all.toggle.isOn = true
		end
	end

	function arg_1_0:__onToggle_all_do_bg_size_group_toggle_group_middle(arg_41_1)
		self._toggle_size_group_obj:toggleOnOnly("middle", self._toggle_size_group.middle.toggle.isOn)

		if arg_41_1 then
			self:__check_size_group_to_type_group("middle")

			self._is_click_type_toggle = false
		elseif not self._is_click_type_toggle then
			self._control.bg.size_group.toggle_group.all.toggle.isOn = true
		end
	end

	function arg_1_0:__onToggle_all_do_bg_size_group_toggle_group_small(arg_42_1)
		self._toggle_size_group_obj:toggleOnOnly("small", self._toggle_size_group.small.toggle.isOn)

		if arg_42_1 then
			self:__check_size_group_to_type_group("small")

			self._is_click_type_toggle = false
		elseif not self._is_click_type_toggle then
			self._control.bg.size_group.toggle_group.all.toggle.isOn = true
		end
	end

	function arg_1_0:__onToggle_all_do_bg_size_group_toggle_group_maip(arg_43_1)
		self._toggle_size_group_obj:toggleOnOnly("maip", self._toggle_size_group.maip.toggle.isOn)

		if arg_43_1 then
			self:__check_size_group_to_type_group("maip")

			self._is_click_type_toggle = false
		elseif not self._is_click_type_toggle then
			self._control.bg.size_group.toggle_group.all.toggle.isOn = true
		end
	end

	function arg_1_0:__onToggle_all_do_bg_size_group_toggle_group_protect(arg_44_1)
		self._toggle_size_group_obj:toggleOnOnly("protect", self._toggle_size_group.protect.toggle.isOn)

		if arg_44_1 then
			self:__check_size_group_to_type_group("protect")

			self._is_click_type_toggle = false
		elseif not self._is_click_type_toggle then
			self._control.bg.size_group.toggle_group.all.toggle.isOn = true
		end
	end

	function arg_1_0:__rebuild_sync_all_if_empty()
		if not self._toggle_rebuild_group.has_rebuild.toggle.isOn and not self._toggle_rebuild_group.not_rebuild.toggle.isOn and not self._toggle_rebuild_group.ship_lock.toggle.isOn and not self._toggle_rebuild_group.ship_unlock.toggle.isOn then
			self._toggle_rebuild_group_obj:toggleOn("all", true)
		end
	end

	function arg_1_0:__onToggle_bg_rebuild_group_toggle_group_all()
		self._toggle_rebuild_group_obj:toggleOn("all", self._toggle_rebuild_group.all.toggle.isOn)
	end

	function arg_1_0:__onToggle_bg_rebuild_group_toggle_group_has_rebuild()
		if self._toggle_rebuild_group.not_rebuild.toggle.isOn then
			self._toggle_rebuild_group_obj:toggleOn("all", self._toggle_rebuild_group.all.toggle.isOn)

			self._toggle_rebuild_group.all.toggle.isOn = true
			self._toggle_rebuild_group.has_rebuild.toggle.isOn = false
			self._toggle_rebuild_group.not_rebuild.toggle.isOn = false

			return
		end

		self._toggle_rebuild_group_obj:toggleOn("has_rebuild", self._toggle_rebuild_group.has_rebuild.toggle.isOn)
		self:__rebuild_sync_all_if_empty()
	end

	function arg_1_0:__onToggle_bg_rebuild_group_toggle_group_not_rebuild()
		if self._toggle_rebuild_group.has_rebuild.toggle.isOn then
			self._toggle_rebuild_group_obj:toggleOn("all", self._toggle_rebuild_group.all.toggle.isOn)

			self._toggle_rebuild_group.all.toggle.isOn = true
			self._toggle_rebuild_group.has_rebuild.toggle.isOn = false
			self._toggle_rebuild_group.not_rebuild.toggle.isOn = false

			return
		end

		self._toggle_rebuild_group_obj:toggleOn("not_rebuild", self._toggle_rebuild_group.not_rebuild.toggle.isOn)
		self:__rebuild_sync_all_if_empty()
	end

	function arg_1_0:__onToggle_bg_rebuild_group_toggle_group_ship_lock()
		if self._toggle_rebuild_group.ship_unlock.toggle.isOn then
			self._toggle_rebuild_group_obj:toggleOn("all", self._toggle_rebuild_group.all.toggle.isOn)

			self._toggle_rebuild_group.all.toggle.isOn = true
			self._toggle_rebuild_group.ship_lock.toggle.isOn = false
			self._toggle_rebuild_group.ship_unlock.toggle.isOn = false

			return
		end

		self._toggle_rebuild_group_obj:toggleOn("ship_lock", self._toggle_rebuild_group.ship_lock.toggle.isOn)
		self:__rebuild_sync_all_if_empty()
	end

	function arg_1_0:__onToggle_bg_rebuild_group_toggle_group_ship_unlock()
		if self._toggle_rebuild_group.ship_lock.toggle.isOn then
			self._toggle_rebuild_group_obj:toggleOn("all", self._toggle_rebuild_group.all.toggle.isOn)

			self._toggle_rebuild_group.all.toggle.isOn = true
			self._toggle_rebuild_group.ship_lock.toggle.isOn = false
			self._toggle_rebuild_group.ship_unlock.toggle.isOn = false

			return
		end

		self._toggle_rebuild_group_obj:toggleOn("ship_unlock", self._toggle_rebuild_group.ship_unlock.toggle.isOn)
		self:__rebuild_sync_all_if_empty()
	end

	function arg_1_0.__onToggle_bg_skill_group_toggle_group_all(arg_51_0)
		arg_51_0._skill_toggle_select = "all"
	end

	function arg_1_0.__onToggle_bg_skill_group_toggle_group_one_skill(arg_52_0)
		arg_52_0._skill_toggle_select = "one_skill"
	end

	function arg_1_0.__onToggle_bg_skill_group_toggle_group_two_skill(arg_53_0)
		arg_53_0._skill_toggle_select = "two_skill"
	end

	function arg_1_0.__onToggle_bg_character_group_toggle_group_all(arg_54_0)
		arg_54_0._character_toggle_select = "all"
	end

	function arg_1_0.__onToggle_bg_character_group_toggle_group_leaders(arg_55_0)
		arg_55_0._character_toggle_select = "leaders"
	end

	function arg_1_0.__onToggle_bg_character_group_toggle_group_not_leaders(arg_56_0)
		arg_56_0._character_toggle_select = "not_leaders"
	end

	function arg_1_0.__onToggle_bg_cost_num_group_toggle_group_all(arg_57_0)
		arg_57_0._cost_toggle_select = "all"
	end

	function arg_1_0.__onToggle_bg_cost_num_group_toggle_group_one(arg_58_0)
		arg_58_0._cost_toggle_select = 1
	end

	function arg_1_0.__onToggle_bg_cost_num_group_toggle_group_two(arg_59_0)
		arg_59_0._cost_toggle_select = 2
	end

	function arg_1_0.__onToggle_bg_cost_num_group_toggle_group_three(arg_60_0)
		arg_60_0._cost_toggle_select = 3
	end

	function arg_1_0.__onToggle_bg_cost_num_group_toggle_group_four(arg_61_0)
		arg_61_0._cost_toggle_select = 4
	end

	function arg_1_0.__onToggle_bg_cost_num_group_toggle_group_five(arg_62_0)
		arg_62_0._cost_toggle_select = 5
	end

	function arg_1_0.__onToggle_bg_cost_num_group_toggle_group_six(arg_63_0)
		arg_63_0._cost_toggle_select = 6
	end

	function arg_1_0.__onToggle_bg_cost_num_group_toggle_group_bigger_then_six(arg_64_0)
		arg_64_0._cost_toggle_select = 7
	end

	function arg_1_0:__onToggle_all_do_bg_love_group_toggle_group_all()
		self._toggle_love_group_obj:toggleOn("all", self._toggle_love_group.all.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_love_group_toggle_group_level_not_max()
		if self._toggle_love_group.level_max.toggle.isOn then
			self._toggle_love_group_obj:toggleOn("all", self._toggle_love_group.all.toggle.isOn)

			self._toggle_love_group.all.toggle.isOn = true
			self._toggle_love_group.level_max.toggle.isOn = false
			self._toggle_love_group.level_not_max.toggle.isOn = false

			return
		end

		self._toggle_love_group_obj:toggleOn("level_not_max", self._toggle_love_group.level_not_max.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_love_group_toggle_group_level_max()
		if self._toggle_love_group.level_not_max.toggle.isOn then
			self._toggle_love_group_obj:toggleOn("all", self._toggle_love_group.all.toggle.isOn)

			self._toggle_love_group.all.toggle.isOn = true
			self._toggle_love_group.level_max.toggle.isOn = false
			self._toggle_love_group.level_not_max.toggle.isOn = false

			return
		end

		self._toggle_love_group_obj:toggleOn("level_max", self._toggle_love_group.level_max.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_love_group_toggle_group_love_not_max()
		if self._toggle_love_group.marry.toggle.isOn and self._toggle_love_group.married.toggle.isOn then
			self._toggle_love_group_obj:toggleOn("all", self._toggle_love_group.all.toggle.isOn)

			self._toggle_love_group.all.toggle.isOn = true
			self._toggle_love_group.love_not_max.toggle.isOn = false
			self._toggle_love_group.marry.toggle.isOn = false
			self._toggle_love_group.married.toggle.isOn = false

			return
		end

		self._toggle_love_group_obj:toggleOn("love_not_max", self._toggle_love_group.love_not_max.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_love_group_toggle_group_marry()
		if self._toggle_love_group.love_not_max.toggle.isOn and self._toggle_love_group.married.toggle.isOn then
			self._toggle_love_group_obj:toggleOn("all", self._toggle_love_group.all.toggle.isOn)

			self._toggle_love_group.all.toggle.isOn = true
			self._toggle_love_group.love_not_max.toggle.isOn = false
			self._toggle_love_group.marry.toggle.isOn = false
			self._toggle_love_group.married.toggle.isOn = false

			return
		end

		self._toggle_love_group_obj:toggleOn("marry", self._toggle_love_group.marry.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_love_group_toggle_group_married()
		if self._toggle_love_group.love_not_max.toggle.isOn and self._toggle_love_group.marry.toggle.isOn then
			self._toggle_love_group_obj:toggleOn("all", self._toggle_love_group.all.toggle.isOn)

			self._toggle_love_group.all.toggle.isOn = true
			self._toggle_love_group.love_not_max.toggle.isOn = false
			self._toggle_love_group.marry.toggle.isOn = false
			self._toggle_love_group.married.toggle.isOn = false

			return
		end

		self._toggle_love_group_obj:toggleOn("married", self._toggle_love_group.married.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_abyss_type_group_toggle_group_all()
		self._toggle_abyss_type_group_obj:toggleOn("all", self._toggle_abyss_type_group.all.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_abyss_type_group_toggle_group_CV()
		self._toggle_abyss_type_group_obj:toggleOn("CV", self._toggle_abyss_type_group.CV.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_abyss_type_group_toggle_group_CVL()
		self._toggle_abyss_type_group_obj:toggleOn("CVL", self._toggle_abyss_type_group.CVL.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_abyss_type_group_toggle_group_AV()
		self._toggle_abyss_type_group_obj:toggleOn("AV", self._toggle_abyss_type_group.AV.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_abyss_type_group_toggle_group_BB()
		self._toggle_abyss_type_group_obj:toggleOn("BB", self._toggle_abyss_type_group.BB.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_abyss_type_group_toggle_group_BBV()
		self._toggle_abyss_type_group_obj:toggleOn("BBV", self._toggle_abyss_type_group.BBV.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_abyss_type_group_toggle_group_BC()
		self._toggle_abyss_type_group_obj:toggleOn("BC", self._toggle_abyss_type_group.BC.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_abyss_type_group_toggle_group_CA()
		self._toggle_abyss_type_group_obj:toggleOn("CA", self._toggle_abyss_type_group.CA.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_abyss_type_group_toggle_group_CAV()
		self._toggle_abyss_type_group_obj:toggleOn("CAV", self._toggle_abyss_type_group.CAV.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_abyss_type_group_toggle_group_CLT()
		self._toggle_abyss_type_group_obj:toggleOn("CLT", self._toggle_abyss_type_group.CLT.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_abyss_type_group_toggle_group_CL()
		self._toggle_abyss_type_group_obj:toggleOn("CL", self._toggle_abyss_type_group.CL.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_abyss_type_group_toggle_group_BM()
		self._toggle_abyss_type_group_obj:toggleOn("BM", self._toggle_abyss_type_group.BM.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_abyss_type_group_toggle_group_DD()
		self._toggle_abyss_type_group_obj:toggleOn("DD", self._toggle_abyss_type_group.DD.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_abyss_type_group_toggle_group_SSG()
		self._toggle_abyss_type_group_obj:toggleOn("SSG", self._toggle_abyss_type_group.SSG.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_abyss_type_group_toggle_group_SS()
		self._toggle_abyss_type_group_obj:toggleOn("SS", self._toggle_abyss_type_group.SS.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_abyss_type_group_toggle_group_SC()
		self._toggle_abyss_type_group_obj:toggleOn("SC", self._toggle_abyss_type_group.SC.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_abyss_type_group_toggle_group_AP()
		self._toggle_abyss_type_group_obj:toggleOn("AP", self._toggle_abyss_type_group.AP.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_abyss_type_group_toggle_group_Fortress()
		self._toggle_abyss_type_group_obj:toggleOn("Fortress", self._toggle_abyss_type_group.Fortress.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_abyss_type_group_toggle_group_Airfield()
		self._toggle_abyss_type_group_obj:toggleOn("Airfield", self._toggle_abyss_type_group.Airfield.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_abyss_type_group_toggle_group_ASDG()
		self._toggle_abyss_type_group_obj:toggleOn("ASDG", self._toggle_abyss_type_group.ASDG.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_abyss_type_group_toggle_group_AADG()
		self._toggle_abyss_type_group_obj:toggleOn("AADG", self._toggle_abyss_type_group.AADG.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_abyss_type_group_toggle_group_CBG()
		self._toggle_abyss_type_group_obj:toggleOn("CBG", self._toggle_abyss_type_group.CBG.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_abyss_type_group_toggle_group_BBG()
		self._toggle_abyss_type_group_obj:toggleOn("BBG", self._toggle_abyss_type_group.BBG.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_abyss_type_group_toggle_group_TX()
		self._toggle_abyss_type_group_obj:toggleOn("TX", self._toggle_abyss_type_group.TX.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_abyss_type_group_toggle_group_Elite()
		self._toggle_abyss_type_group_obj:toggleOn("Elite", self._toggle_abyss_type_group.Elite.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_bg_abyss_type_group_toggle_group_BG()
		self._toggle_abyss_type_group_obj:toggleOn("BG", self._toggle_abyss_type_group.BG.toggle.isOn)
	end

	function arg_1_0:__save_toggle_group_all_set_data()
		self._last_toggle_size_group_obj_rule_a = var_0_2.little_clone(self._toggle_size_group_obj._rule_a.set)
		self._last_toggle_size_group_obj_rule_b = var_0_2.little_clone(self._toggle_size_group_obj._rule_b.set)
		self._last_toggle_type_group_obj_rule_a = var_0_2.little_clone(self._toggle_type_group_obj._rule_a.set)
		self._last_toggle_type_group_obj_rule_b = var_0_2.little_clone(self._toggle_type_group_obj._rule_b.set)
		self._last_toggle_abyss_type_group_obj_rule_a = var_0_2.little_clone(self._toggle_abyss_type_group_obj._rule_a.set)
		self._last_toggle_abyss_type_group_obj_rule_b = var_0_2.little_clone(self._toggle_abyss_type_group_obj._rule_b.set)
		self._last_toggle_country_group_obj_rule_a = var_0_2.little_clone(self._toggle_country_group_obj._rule_a.set)
		self._last_toggle_country_group_obj_rule_b = var_0_2.little_clone(self._toggle_country_group_obj._rule_b.set)
	end

	function arg_1_0:__revert_toggle_group_all_set()
		if self._last_toggle_size_group_obj_rule_a.all ~= self._toggle_size_group_obj._rule_a.set.all then
			self._control.bg.size_group.toggle_group.all.toggle.isOn = self._last_toggle_size_group_obj_rule_a.all
		end

		for iter_98_0, iter_98_1 in pairs(self._last_toggle_size_group_obj_rule_b) do
			if iter_98_1 ~= self._toggle_size_group_obj._rule_b.set[iter_98_0] then
				self._control.bg.size_group.toggle_group[iter_98_0].toggle.isOn = iter_98_1
			end
		end

		if self._last_toggle_type_group_obj_rule_a.all ~= self._toggle_type_group_obj._rule_a.set.all then
			self._control.bg.type_group.toggle_group.all.toggle.isOn = self._last_toggle_type_group_obj_rule_a.all
		end

		for iter_98_2, iter_98_3 in pairs(self._last_toggle_type_group_obj_rule_b) do
			if iter_98_3 ~= self._toggle_type_group_obj._rule_b.set[iter_98_2] then
				self._control.bg.type_group.toggle_group[iter_98_2].toggle.isOn = iter_98_3
			end
		end

		if self._last_toggle_abyss_type_group_obj_rule_a.all ~= self._toggle_abyss_type_group_obj._rule_a.set.all then
			self._control.bg.abyss_type_group.toggle_group.all.toggle.isOn = self._last_toggle_abyss_type_group_obj_rule_a.all
		end

		for iter_98_4, iter_98_5 in pairs(self._last_toggle_abyss_type_group_obj_rule_b) do
			if iter_98_5 ~= self._toggle_abyss_type_group_obj._rule_b.set[iter_98_4] then
				self._control.bg.abyss_type_group.toggle_group[iter_98_4].toggle.isOn = iter_98_5
			end
		end

		if self._last_toggle_country_group_obj_rule_a.all ~= self._toggle_country_group_obj._rule_a.set.all then
			self._control.bg.country_group.toggle_group.all.toggle.isOn = self._last_toggle_country_group_obj_rule_a.all
		end

		for iter_98_6, iter_98_7 in pairs(self._last_toggle_country_group_obj_rule_b) do
			if iter_98_7 ~= self._toggle_country_group_obj._rule_b.set[iter_98_6] then
				self._control.bg.country_group.toggle_group[iter_98_6].toggle.isOn = iter_98_7
			end
		end
	end

	function arg_1_0.__check_size_large(arg_99_0, arg_99_1)
		local var_99_0 = true

		for iter_99_0, iter_99_1 in pairs(arg_99_1) do
			if not var_0_2.have_data(var_0_1.ship_size_type_list.large, iter_99_0) and iter_99_1 then
				var_99_0 = false
			end
		end

		for iter_99_2, iter_99_3 in pairs(var_0_1.ship_size_type_list.large) do
			if not arg_99_1[iter_99_3] then
				var_99_0 = false
			end
		end

		return var_99_0
	end

	function arg_1_0.__check_size_middle(arg_100_0, arg_100_1)
		local var_100_0 = true

		for iter_100_0, iter_100_1 in pairs(arg_100_1) do
			if not var_0_2.have_data(var_0_1.ship_size_type_list.middle, iter_100_0) and iter_100_1 then
				var_100_0 = false
			end
		end

		for iter_100_2, iter_100_3 in pairs(var_0_1.ship_size_type_list.middle) do
			if not arg_100_1[iter_100_3] then
				var_100_0 = false
			end
		end

		return var_100_0
	end

	function arg_1_0.__check_size_small(arg_101_0, arg_101_1)
		local var_101_0 = true

		for iter_101_0, iter_101_1 in pairs(arg_101_1) do
			if not var_0_2.have_data(var_0_1.ship_size_type_list.small, iter_101_0) and iter_101_1 then
				var_101_0 = false
			end
		end

		for iter_101_2, iter_101_3 in pairs(var_0_1.ship_size_type_list.small) do
			if not arg_101_1[iter_101_3] then
				var_101_0 = false
			end
		end

		return var_101_0
	end

	function arg_1_0.__check_size_maip(arg_102_0, arg_102_1)
		local var_102_0 = true

		for iter_102_0, iter_102_1 in pairs(arg_102_1) do
			if not var_0_2.have_data(var_0_1.ship_size_type_list.maip, iter_102_0) and iter_102_1 then
				var_102_0 = false
			end
		end

		for iter_102_2, iter_102_3 in pairs(var_0_1.ship_size_type_list.maip) do
			if not arg_102_1[iter_102_3] then
				var_102_0 = false
			end
		end

		return var_102_0
	end

	function arg_1_0.__check_size_protect(arg_103_0, arg_103_1)
		local var_103_0 = true

		for iter_103_0, iter_103_1 in pairs(arg_103_1) do
			if not var_0_2.have_data(var_0_1.ship_size_type_list.protect, iter_103_0) and iter_103_1 then
				var_103_0 = false
			end
		end

		for iter_103_2, iter_103_3 in pairs(var_0_1.ship_size_type_list.protect) do
			if not arg_103_1[iter_103_3] then
				var_103_0 = false
			end
		end

		return var_103_0
	end

	function arg_1_0:__check_type_group_to_size_group(arg_104_1)
		local var_104_0 = self._toggle_type_group_obj._rule_b.set

		self._is_click_type_toggle = true

		if self._toggle_type_group_obj._rule_a.set.all then
			self._control.bg.size_group.toggle_group.all.toggle.isOn = true

			return
		else
			self._toggle_size_group_obj:toggleOnOnly("all", false, true)
		end

		self._control.bg.size_group.toggle_group.large.toggle.isOn = not not self:__check_size_large(var_104_0)
		self._control.bg.size_group.toggle_group.middle.toggle.isOn = not not self:__check_size_middle(var_104_0)
		self._control.bg.size_group.toggle_group.small.toggle.isOn = not not self:__check_size_small(var_104_0)
		self._control.bg.size_group.toggle_group.maip.toggle.isOn = not not self:__check_size_maip(var_104_0)
		self._control.bg.size_group.toggle_group.protect.toggle.isOn = not not self:__check_size_protect(var_104_0)
	end

	function arg_1_0:__check_size_group_to_type_group(arg_105_1)
		if arg_105_1 == "all" then
			self._control.bg.type_group.toggle_group.all.toggle.isOn = self._toggle_size_group_obj._rule_a.set.all

			return
		end

		if arg_105_1 == "middle" then
			for iter_105_0, iter_105_1 in pairs(self._toggle_type_group_obj._rule_b.set) do
				self._control.bg.type_group.toggle_group[iter_105_0].toggle.isOn = not not var_0_2.have_data(var_0_1.ship_size_type_list.middle, iter_105_0)
			end

			self._control.bg.type_group.toggle_group.all.toggle.isOn = not self._toggle_size_group_obj._rule_b.set.middle

			return
		end

		if arg_105_1 == "large" then
			for iter_105_2, iter_105_3 in pairs(self._toggle_type_group_obj._rule_b.set) do
				self._control.bg.type_group.toggle_group[iter_105_2].toggle.isOn = not not var_0_2.have_data(var_0_1.ship_size_type_list.large, iter_105_2)
			end

			self._control.bg.type_group.toggle_group.all.toggle.isOn = not self._toggle_size_group_obj._rule_b.set.large

			return
		end

		if arg_105_1 == "small" then
			for iter_105_4, iter_105_5 in pairs(self._toggle_type_group_obj._rule_b.set) do
				self._control.bg.type_group.toggle_group[iter_105_4].toggle.isOn = not not var_0_2.have_data(var_0_1.ship_size_type_list.small, iter_105_4)
			end

			self._control.bg.type_group.toggle_group.all.toggle.isOn = not self._toggle_size_group_obj._rule_b.set.small

			return
		end

		if arg_105_1 == "maip" then
			for iter_105_6, iter_105_7 in pairs(self._toggle_type_group_obj._rule_b.set) do
				self._control.bg.type_group.toggle_group[iter_105_6].toggle.isOn = not not var_0_2.have_data(var_0_1.ship_size_type_list.maip, iter_105_6)
			end

			self._control.bg.type_group.toggle_group.all.toggle.isOn = not self._toggle_size_group_obj._rule_b.set.maip

			return
		end

		if arg_105_1 == "protect" then
			for iter_105_8, iter_105_9 in pairs(self._toggle_type_group_obj._rule_b.set) do
				self._control.bg.type_group.toggle_group[iter_105_8].toggle.isOn = not not var_0_2.have_data(var_0_1.ship_size_type_list.protect, iter_105_8)
			end

			self._control.bg.type_group.toggle_group.all.toggle.isOn = not self._toggle_size_group_obj._rule_b.set.protect

			return
		end
	end

	function arg_1_0:__update_parent_data()
		if self._confirm_listener then
			self._confirm_listener(self._source_data)
		end
	end

	function arg_1_0:__onClick_bg_tactics_panel_toggle_btn_three_tactics()
		if self._tactics_num_3 == 0 and self._tactics_num_2 + self._tactics_num_1 + self._tactics_num_0 == 3 then
			self._tactics_num_0 = 0
			self._tactics_num_1 = 0
			self._tactics_num_2 = 0
			self._tactics_num_3 = 0
			self._tactics_num_4 = 1

			self._toggle_tactics_group.zero_tactics:SetActive(false)
			self._toggle_tactics_group.one_tactics:SetActive(false)
			self._toggle_tactics_group.two_tactics:SetActive(false)
			self._toggle_tactics_group.three_tactics:SetActive(false)
			self._toggle_tactics_group.all:SetActive(true)
		elseif self._tactics_num_3 == 1 and self._tactics_num_2 + self._tactics_num_1 + self._tactics_num_0 > 0 then
			self._tactics_num_3 = 0
			self._tactics_num_4 = 0

			self._toggle_tactics_group.three_tactics:SetActive(false)
		elseif self._tactics_num_3 == 1 and self._tactics_num_2 + self._tactics_num_1 + self._tactics_num_0 == 0 then
			self._tactics_num_3 = 0
			self._tactics_num_4 = 0

			self._toggle_tactics_group.three_tactics:SetActive(false)
			self._toggle_tactics_group.all:SetActive(true)
		else
			self._tactics_num_3 = 1
			self._tactics_num_4 = 0

			self._toggle_tactics_group.three_tactics:SetActive(true)
			self._toggle_tactics_group.all:SetActive(false)
		end
	end

	function arg_1_0:__onClick_bg_tactics_panel_toggle_btn_two_tactics()
		if self._tactics_num_2 == 0 and self._tactics_num_3 + self._tactics_num_1 + self._tactics_num_0 == 3 then
			self._tactics_num_0 = 0
			self._tactics_num_1 = 0
			self._tactics_num_2 = 0
			self._tactics_num_3 = 0
			self._tactics_num_4 = 1

			self._toggle_tactics_group.zero_tactics:SetActive(false)
			self._toggle_tactics_group.one_tactics:SetActive(false)
			self._toggle_tactics_group.two_tactics:SetActive(false)
			self._toggle_tactics_group.three_tactics:SetActive(false)
			self._toggle_tactics_group.all:SetActive(true)
		elseif self._tactics_num_2 == 1 and self._tactics_num_3 + self._tactics_num_1 + self._tactics_num_0 > 0 then
			self._tactics_num_2 = 0
			self._tactics_num_4 = 0

			self._toggle_tactics_group.two_tactics:SetActive(false)
		elseif self._tactics_num_2 == 1 and self._tactics_num_3 + self._tactics_num_1 + self._tactics_num_0 == 0 then
			self._tactics_num_2 = 0
			self._tactics_num_4 = 0

			self._toggle_tactics_group.two_tactics:SetActive(false)
			self._toggle_tactics_group.all:SetActive(true)
		else
			self._tactics_num_2 = 1
			self._tactics_num_4 = 0

			self._toggle_tactics_group.two_tactics:SetActive(true)
			self._toggle_tactics_group.all:SetActive(false)
		end
	end

	function arg_1_0:__onClick_bg_tactics_panel_toggle_btn_one_tactics()
		if self._tactics_num_1 == 0 and self._tactics_num_3 + self._tactics_num_2 + self._tactics_num_0 == 3 then
			self._tactics_num_0 = 0
			self._tactics_num_1 = 0
			self._tactics_num_2 = 0
			self._tactics_num_3 = 0
			self._tactics_num_4 = 1

			self._toggle_tactics_group.zero_tactics:SetActive(false)
			self._toggle_tactics_group.one_tactics:SetActive(false)
			self._toggle_tactics_group.two_tactics:SetActive(false)
			self._toggle_tactics_group.three_tactics:SetActive(false)
			self._toggle_tactics_group.all:SetActive(true)
		elseif self._tactics_num_1 == 1 and self._tactics_num_3 + self._tactics_num_2 + self._tactics_num_0 > 0 then
			self._tactics_num_1 = 0
			self._tactics_num_4 = 0

			self._toggle_tactics_group.one_tactics:SetActive(false)
		elseif self._tactics_num_1 == 1 and self._tactics_num_3 + self._tactics_num_2 + self._tactics_num_0 == 0 then
			self._tactics_num_1 = 0
			self._tactics_num_4 = 0

			self._toggle_tactics_group.one_tactics:SetActive(false)
			self._toggle_tactics_group.all:SetActive(true)
		else
			self._tactics_num_1 = 1
			self._tactics_num_4 = 0

			self._toggle_tactics_group.one_tactics:SetActive(true)
			self._toggle_tactics_group.all:SetActive(false)
		end
	end

	function arg_1_0:__onClick_bg_tactics_panel_toggle_btn_zero_tactics()
		if self._tactics_num_0 == 0 and self._tactics_num_3 + self._tactics_num_2 + self._tactics_num_1 == 3 then
			self._tactics_num_0 = 0
			self._tactics_num_1 = 0
			self._tactics_num_2 = 0
			self._tactics_num_3 = 0
			self._tactics_num_4 = 1

			self._toggle_tactics_group.zero_tactics:SetActive(false)
			self._toggle_tactics_group.one_tactics:SetActive(false)
			self._toggle_tactics_group.two_tactics:SetActive(false)
			self._toggle_tactics_group.three_tactics:SetActive(false)
			self._toggle_tactics_group.all:SetActive(true)
		elseif self._tactics_num_0 == 1 and self._tactics_num_3 + self._tactics_num_2 + self._tactics_num_1 > 0 then
			self._tactics_num_0 = 0
			self._tactics_num_4 = 0

			self._toggle_tactics_group.zero_tactics:SetActive(false)
		elseif self._tactics_num_0 == 1 and self._tactics_num_3 + self._tactics_num_2 + self._tactics_num_1 == 0 then
			self._tactics_num_0 = 0
			self._tactics_num_4 = 0

			self._toggle_tactics_group.zero_tactics:SetActive(false)
			self._toggle_tactics_group.all:SetActive(true)
		else
			self._tactics_num_0 = 1
			self._tactics_num_4 = 0

			self._toggle_tactics_group.zero_tactics:SetActive(true)
			self._toggle_tactics_group.all:SetActive(false)
		end
	end

	function arg_1_0:__onClick_bg_tactics_panel_toggle_btn_all()
		self._tactics_num_4 = 1
		self._tactics_num_3 = 0
		self._tactics_num_2 = 0
		self._tactics_num_1 = 0
		self._tactics_num_0 = 0

		self._toggle_tactics_group.zero_tactics:SetActive(false)
		self._toggle_tactics_group.one_tactics:SetActive(false)
		self._toggle_tactics_group.two_tactics:SetActive(false)
		self._toggle_tactics_group.three_tactics:SetActive(false)
		self._toggle_tactics_group.all:SetActive(true)
	end

	function arg_1_0:__onClick_bg_cook_btn_cook_group_all()
		self._cook_num_1 = 1
		self._cook_num_2 = 0
		self._cook_num_3 = 0

		self:set_cook_panel_state(true, false, false)
	end

	function arg_1_0:__onClick_bg_cook_btn_cook_group_max_cook()
		if self._cook_num_2 == 0 and self._cook_num_3 == 0 then
			self._cook_num_1 = 0
			self._cook_num_2 = 1
			self._cook_num_3 = 0

			self:set_cook_panel_state(false, true, false)
		elseif self._cook_num_2 == 1 and self._cook_num_3 == 0 then
			self._cook_num_1 = 1
			self._cook_num_2 = 0
			self._cook_num_3 = 0

			self:set_cook_panel_state(true, false, false)
		elseif self._cook_num_2 == 1 and self._cook_num_3 == 1 then
			self._cook_num_1 = 0
			self._cook_num_2 = 0
			self._cook_num_3 = 1

			self:set_cook_panel_state(false, false, true)
		elseif self._cook_num_2 == 0 and self._cook_num_3 == 1 then
			self._cook_num_1 = 1
			self._cook_num_2 = 0
			self._cook_num_3 = 0

			self:set_cook_panel_state(true, false, false)
		end
	end

	function arg_1_0:__onClick_bg_cook_btn_cook_group_min_cook()
		if self._cook_num_3 == 0 and self._cook_num_2 == 0 then
			self._cook_num_1 = 0
			self._cook_num_2 = 0
			self._cook_num_3 = 1

			self:set_cook_panel_state(false, false, true)
		elseif self._cook_num_3 == 1 and self._cook_num_2 == 0 then
			self._cook_num_1 = 1
			self._cook_num_2 = 0
			self._cook_num_3 = 0

			self:set_cook_panel_state(true, false, false)
		elseif self._cook_num_3 == 1 and self._cook_num_2 == 1 then
			self._cook_num_1 = 0
			self._cook_num_2 = 1
			self._cook_num_3 = 0

			self:set_cook_panel_state(false, true, false)
		elseif self._cook_num_3 == 0 and self._cook_num_2 == 1 then
			self._cook_num_1 = 1
			self._cook_num_2 = 0
			self._cook_num_3 = 0

			self:set_cook_panel_state(true, false, false)
		end
	end

	function arg_1_0:set_cook_panel_state(arg_115_1, arg_115_2, arg_115_3)
		self._control.bg.cook_btn.cook_group.all.Background.Checkmark:SetActive(arg_115_1)
		self._control.bg.cook_btn.cook_group.max_cook.Background.Checkmark:SetActive(arg_115_2)
		self._control.bg.cook_btn.cook_group.min_cook.Background.Checkmark:SetActive(arg_115_3)
	end
end

function var_0_0.extend_obj(arg_116_0)
	arg_116_0._last_toggle_size_group_obj_rule_a = {}
	arg_116_0._last_toggle_size_group_obj_rule_b = {}
	arg_116_0._last_toggle_type_group_obj_rule_a = {}
	arg_116_0._last_toggle_type_group_obj_rule_b = {}
	arg_116_0._last_toggle_country_group_obj_rule_a = {}
	arg_116_0._last_toggle_country_group_obj_rule_b = {}
	arg_116_0._last_toggle_love_group_obj_rule_a = {}
	arg_116_0._last_toggle_love_group_obj_rule_b = {}
	arg_116_0._last_toggle_abyss_type_group_obj_rule_a = {}
	arg_116_0._last_toggle_abyss_type_group_obj_rule_b = {}
	arg_116_0._last_toggle_tactics_group_obj_rule_a = {}
	arg_116_0._last_toggle_tactics_group_obj_rule_b = {}
	arg_116_0._toggle_country_group = nil
	arg_116_0._toggle_type_group = nil
	arg_116_0._toggle_size_group = nil
	arg_116_0._toggle_country_group_obj = nil
	arg_116_0._toggle_size_group_obj = nil
	arg_116_0._toggle_type_group_obj = nil
	arg_116_0._toggle_love_group = nil
	arg_116_0._toggle_tactics_group_obj = nil
	arg_116_0._toggle_tactics_group = nil
	arg_116_0._toggle_love_group_obj = nil
	arg_116_0._toggle_abyss_type_group_obj = nil
	arg_116_0._country_toggle_data = {
		all = true
	}
	arg_116_0._type_toggle_data = {
		all = true
	}
	arg_116_0._love_toggle_data = {
		all = true
	}
	arg_116_0._abyss_type_toggle_data = {
		all = true
	}
	arg_116_0._is_click_type_toggle = false
	arg_116_0._tactics_num_0 = 0
	arg_116_0._tactics_num_1 = 0
	arg_116_0._tactics_num_2 = 0
	arg_116_0._tactics_num_3 = 0
	arg_116_0._tactics_num_4 = 1
	arg_116_0._cook_num_1 = 1
	arg_116_0._cook_num_2 = 0
	arg_116_0._cook_num_3 = 0
end

return var_0_0
