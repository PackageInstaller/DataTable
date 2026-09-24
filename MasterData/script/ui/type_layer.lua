local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gameconfig.ship_config
local var_0_4 = gameenum.common_type
local var_0_5 = gamecore.util_func
local var_0_6 = table.insert
local var_0_7 = gamecore.user

gamecore.UILoader:define("type_layer", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(arg_2_1)
		self:__init_panel()
	end

	function arg_1_0:change_type_text(arg_3_1)
		local var_3_0
		local var_3_1 = false

		if not self._type_toggle_data.all and var_0_5.dict_lenght(self._type_toggle_data) > 2 then
			var_3_0 = var_0_1:getNowLang("multiselect")
		elseif not self._type_toggle_data.all and var_0_5.dict_lenght(self._type_toggle_data) <= 2 then
			for iter_3_0, iter_3_1 in pairs(self._type_toggle_data) do
				if iter_3_0 == "CLT" then
					var_3_0 = var_0_1:getNowLang("shiptype9")
				elseif iter_3_0 ~= "all" then
					var_3_0 = var_0_1:getNowLang("shiptype" .. tostring(var_0_4.filter_type[iter_3_0]))
				end
			end
		elseif not self._type_toggle_data.all then
			var_3_1 = true
		end

		local var_3_2

		if not self._country_toggle_data.all and var_0_5.dict_lenght(self._country_toggle_data) <= 2 then
			for iter_3_2, iter_3_3 in pairs(self._country_toggle_data) do
				if iter_3_2 == "other_country" then
					var_3_2 = var_0_1:getNowLang("country9")
				elseif iter_3_2 ~= "all" then
					var_3_2 = var_0_1:getNowLang("country" .. tostring(var_0_4.filter_country[iter_3_2]))
				end
			end
		elseif not self._country_toggle_data.all then
			var_3_1 = true
		end

		local var_3_3

		if not self._abyss_type_toggle_data.all and var_0_5.dict_lenght(self._abyss_type_toggle_data) <= 2 then
			for iter_3_4, iter_3_5 in pairs(self._abyss_type_toggle_data) do
				if iter_3_4 == "CLT" then
					var_3_3 = var_0_1:getNowLang("shiptype9")
				elseif iter_3_4 ~= "all" then
					var_3_3 = var_0_1:getNowLang("shiptype" .. tostring(var_0_4.abyss_filter_type[iter_3_4]))
				end
			end
		elseif not self._abyss_type_toggle_data.all then
			var_3_1 = true
		end

		local var_3_4

		if self._character_toggle_select == "leaders" then
			var_3_4 = var_0_1:getNowLang("tip_boss")
		elseif self._character_toggle_select == "not_leaders" then
			var_3_4 = var_0_1:getNowLang("tip_not_boss")
		end

		if not self._is_type_limit then
			var_3_1 = not not (var_3_3 and var_3_4)
		end

		local var_3_5

		if not self._love_toggle_data.all and var_0_5.dict_lenght(self._love_toggle_data) <= 2 then
			for iter_3_6, iter_3_7 in pairs(self._love_toggle_data) do
				if iter_3_6 == "level_not_max" then
					var_3_5 = var_0_1:getNowLang("level_no_max")
				elseif iter_3_6 == "level_max" then
					var_3_5 = var_0_1:getNowLang("level_max")
				elseif iter_3_6 == "love_not_max" then
					var_3_5 = var_0_1:getNowLang("love_no_max")
				elseif iter_3_6 == "marry" then
					var_3_5 = var_0_1:getNowLang("state_can_vow")
				elseif iter_3_6 == "married" then
					var_3_5 = var_0_1:getNowLang("state_vow")
				end
			end
		elseif not self._love_toggle_data.all then
			var_3_1 = true
		end

		local var_3_6

		if self._tactics_num_4 == 0 and self._tactics_num_3 + self._tactics_num_2 + self._tactics_num_1 + self._tactics_num_0 > 1 then
			var_3_1 = true
		elseif self._tactics_num_3 == 1 then
			var_3_6 = "lv.3"
		elseif self._tactics_num_2 == 1 then
			var_3_6 = "lv.2"
		elseif self._tactics_num_1 == 1 then
			var_3_6 = "lv.1"
		elseif self._tactics_num_0 == 1 then
			var_3_6 = "lv.0"
		end

		local var_3_7

		if self._rebuild_toggle_data and not self._rebuild_toggle_data.all then
			local var_3_8 = 0
			local var_3_9

			if self._rebuild_toggle_data.has_rebuild then
				var_3_8 = var_3_8 + 1
				var_3_9 = var_3_9 or var_0_1:getNowLang("remake")
			end

			if self._rebuild_toggle_data.not_rebuild then
				var_3_8 = var_3_8 + 1
				var_3_9 = var_3_9 or var_0_1:getNowLang("unremake")
			end

			if self._rebuild_toggle_data.ship_lock then
				var_3_8 = var_3_8 + 1
				var_3_9 = var_3_9 or var_0_1:getNowLang("ship_lock")
			end

			if self._rebuild_toggle_data.ship_unlock then
				var_3_8 = var_3_8 + 1
				var_3_9 = var_3_9 or var_0_1:getNowLang("ship_unlock")
			end

			if var_3_8 == 1 then
				var_3_7 = var_3_9
			elseif var_3_8 > 1 then
				var_3_1 = true
			end
		end

		local var_3_10

		if var_3_1 then
			var_3_10 = var_0_1:getNowLang("multiselect")
		elseif var_3_0 and var_3_2 and not var_3_5 and not var_3_6 and not var_3_7 then
			var_3_10 = var_3_0 .. "+" .. var_3_2
		else
			local var_3_11 = 0
			local var_3_12

			for iter_3_8, iter_3_9 in pairs({
				var_3_0,
				var_3_2,
				var_3_3,
				var_3_4,
				var_3_5,
				var_3_6,
				var_3_7
			}) do
				if iter_3_9 then
					var_3_11 = var_3_11 + 1
					var_3_12 = var_3_12 or iter_3_9
				end
			end

			var_3_10 = var_3_11 >= 2 and var_0_1:getNowLang("multiselect") or var_3_11 == 1 and var_3_12 or var_0_1:getNowLang("questall")
		end

		arg_3_1.text.text = var_3_10
	end

	function arg_1_0:get_type_toggle_data()
		return self._type_toggle_data
	end

	function arg_1_0:get_country_toggle_data()
		return self._country_toggle_data
	end

	function arg_1_0:get_love_toggle_data()
		return self._love_toggle_data
	end

	function arg_1_0:get_skill_toggle_select()
		return self._skill_toggle_select or "all"
	end

	function arg_1_0:get_rebuild_toggle_select()
		if self._rebuild_toggle_data and self._rebuild_toggle_data.all then
			return "all"
		end

		return self._rebuild_toggle_data or {
			all = true
		}
	end

	function arg_1_0:get_character_toggle_select()
		return self._character_toggle_select or "all"
	end

	function arg_1_0:get_cost_toggle_select()
		return self._cost_toggle_select or "all"
	end

	function arg_1_0:get_abyss_type_toggle_data()
		return self._abyss_type_toggle_data
	end

	function arg_1_0.set_listener(arg_12_0, arg_12_1, arg_12_2)
		arg_12_0._source_data = arg_12_1
		arg_12_0._confirm_listener = arg_12_2
	end

	function arg_1_0:sort_table_by_type(arg_13_1)
		local var_13_0 = {}
		local var_13_1 = var_0_2:getInstance("select_member")

		if var_13_1 then
			if self._country_toggle_data.all and self._type_toggle_data.all then
				var_13_1:is_state(false)
			else
				var_13_1:is_state(true)
			end
		end

		if self._country_toggle_data.all == true then
			for iter_13_0, iter_13_1 in pairs(arg_13_1) do
				var_0_6(var_13_0, iter_13_1)
			end
		else
			for iter_13_2, iter_13_3 in pairs(self._country_toggle_data) do
				if iter_13_2 ~= "all" and iter_13_3 then
					if iter_13_2 == "other_country" then
						for iter_13_4, iter_13_5 in pairs(arg_13_1) do
							if self._exclude_list[iter_13_5.id] and self._exclude_list[iter_13_5.id] ~= "is_country_insert" then
								var_0_6(var_13_0, iter_13_5)

								self._exclude_list[iter_13_5.id] = "is_country_insert"
							elseif self._exclude_list[iter_13_5.id] then
								if self._exclude_list[iter_13_5.id] ~= "is_country_insert" then
									if var_0_5.have_data(var_0_4.filter_country[iter_13_2], var_0_3.find_object_by_cid(iter_13_5.cid).country) then
										var_0_6(var_13_0, iter_13_5)
									end
								end
							end
						end
					else
						for iter_13_6, iter_13_7 in pairs(arg_13_1) do
							if self._exclude_list[iter_13_7.id] and self._exclude_list[iter_13_7.id] ~= "is_country_insert" then
								var_0_6(var_13_0, iter_13_7)

								self._exclude_list[iter_13_7.id] = "is_country_insert"
							elseif (not self._exclude_list[iter_13_7.id] or self._exclude_list[iter_13_7.id] ~= "is_country_insert") and var_0_3.find_object_by_cid(iter_13_7.cid).country == var_0_4.filter_country[iter_13_2] then
								var_0_6(var_13_0, iter_13_7)
							end
						end
					end
				end
			end
		end

		local var_13_2 = {}

		if self._type_toggle_data.all == true then
			for iter_13_8, iter_13_9 in pairs(var_13_0) do
				var_0_6(var_13_2, iter_13_9)
			end
		else
			for iter_13_10, iter_13_11 in pairs(self._type_toggle_data) do
				if iter_13_10 ~= "all" and iter_13_11 then
					if iter_13_10 == "CLT" then
						for iter_13_12, iter_13_13 in pairs(var_13_0) do
							if self._exclude_list[iter_13_13.id] and self._exclude_list[iter_13_13.id] ~= "is_type_insert" then
								var_0_6(var_13_2, iter_13_13)

								self._exclude_list[iter_13_13.id] = "is_type_insert"
							elseif self._exclude_list[iter_13_13.id] then
								if self._exclude_list[iter_13_13.id] ~= "is_type_insert" then
									if var_0_5.have_data(var_0_4.filter_type[iter_13_10], var_0_3.find_object_by_cid(iter_13_13.cid).type) then
										var_0_6(var_13_2, iter_13_13)
									end
								end
							end
						end
					else
						for iter_13_14, iter_13_15 in pairs(var_13_0) do
							if self._exclude_list[iter_13_15.id] and self._exclude_list[iter_13_15.id] ~= "is_type_insert" then
								var_0_6(var_13_2, iter_13_15)

								self._exclude_list[iter_13_15.id] = "is_type_insert"
							elseif (not self._exclude_list[iter_13_15.id] or self._exclude_list[iter_13_15.id] ~= "is_type_insert") and var_0_3.find_object_by_cid(iter_13_15.cid).type == var_0_4.filter_type[iter_13_10] then
								var_0_6(var_13_2, iter_13_15)
							end
						end
					end
				end
			end
		end

		local var_13_3 = {}
		local var_13_4 = {}
		local var_13_6 = {}
		local var_13_7 = {}

		if self._love_toggle_data.all == true then
			for iter_13_16, iter_13_17 in pairs(var_13_2) do
				var_0_6(var_13_3, iter_13_17)
			end
		else
			var_13_4 = self:__have_data(self._love_toggle_data, "level_not_max") and self:_select_level_not_max_list(var_13_2) or var_13_2
			var_13_6 = self:__have_data(self._love_toggle_data, "love_not_max") and self:_select_love_not_max_list(var_13_4) or self:__have_data(self._love_toggle_data, "level_max") and self:_select_level_max_list(var_13_4) or var_13_4
			var_13_7 = self:__have_data(self._love_toggle_data, "marry") and self:_select_marry_list(var_13_6) or var_13_6
			var_13_3 = self:__have_data(self._love_toggle_data, "married") and self:_select_married_list(var_13_7) or var_13_7
		end

		local var_13_9 = {}

		if var_0_7:get_cook_common_state() then
			if self._cook_num_1 == 1 then
				for iter_13_18, iter_13_19 in pairs(var_13_3) do
					var_0_6(var_13_9, iter_13_19)
				end
			elseif self._cook_num_2 == 1 then
				for iter_13_20, iter_13_21 in pairs(var_13_3) do
					if iter_13_21.cook_exp == 100 then
						var_0_6(var_13_9, iter_13_21)
					end
				end
			elseif self._cook_num_3 == 1 then
				for iter_13_22, iter_13_23 in pairs(var_13_3) do
					if iter_13_23.cook_exp < 100 then
						var_0_6(var_13_9, iter_13_23)
					end
				end
			end
		else
			for iter_13_24, iter_13_25 in pairs(var_13_3) do
				var_0_6(var_13_9, iter_13_25)
			end
		end

		local var_13_10 = {}

		if var_0_7:get_statics_common_state() then
			if self._tactics_num_4 == 1 then
				for iter_13_26, iter_13_27 in pairs(var_13_9) do
					var_0_6(var_13_10, iter_13_27)
				end
			end

			if self._tactics_num_3 == 1 then
				for iter_13_28, iter_13_29 in pairs(var_13_9) do
					if iter_13_29.tactics_exp >= 900 then
						var_0_6(var_13_10, iter_13_29)
					end
				end
			end

			if self._tactics_num_2 == 1 then
				for iter_13_30, iter_13_31 in pairs(var_13_9) do
					if iter_13_31.tactics_exp >= 400 and iter_13_31.tactics_exp < 900 then
						var_0_6(var_13_10, iter_13_31)
					end
				end
			end

			if self._tactics_num_1 == 1 then
				for iter_13_32, iter_13_33 in pairs(var_13_9) do
					if iter_13_33.tactics_exp >= 100 and iter_13_33.tactics_exp < 400 then
						var_0_6(var_13_10, iter_13_33)
					end
				end
			end

			if self._tactics_num_0 == 1 then
				for iter_13_34, iter_13_35 in pairs(var_13_9) do
					if iter_13_35.tactics_exp < 100 then
						var_0_6(var_13_10, iter_13_35)
					end
				end
			end
		else
			for iter_13_36, iter_13_37 in pairs(var_13_9) do
				var_0_6(var_13_10, iter_13_37)
			end
		end

		if self:get_rebuild_toggle_select() ~= "all" then
			local var_13_12 = {}

			for iter_13_38, iter_13_39 in pairs(var_13_10) do
				if self:__check_rebuild(iter_13_39) then
					var_0_6(var_13_12, iter_13_39)
				end
			end

			var_13_10 = var_13_12
		end

		if self:get_skill_toggle_select() ~= "all" then
			local var_13_13 = {}

			for iter_13_40, iter_13_41 in pairs(var_13_10) do
				if self:__check_skill(iter_13_41.cid) then
					var_0_6(var_13_13, iter_13_41)
				end
			end

			var_13_10 = var_13_13
		end

		if self:get_character_toggle_select() ~= "all" then
			local var_13_14 = {}

			for iter_13_42, iter_13_43 in pairs(var_13_10) do
				if self:__check_character(iter_13_43.cid) then
					var_0_6(var_13_14, iter_13_43)
				end
			end

			var_13_10 = var_13_14
		end

		if self:get_cost_toggle_select() ~= "all" then
			local var_13_15 = {}

			for iter_13_44, iter_13_45 in pairs(var_13_10) do
				if self:__check_cost_num(iter_13_45.cid) then
					var_0_6(var_13_15, iter_13_45)
				end
			end

			var_13_10 = var_13_15
		end

		return var_13_10
	end

	function arg_1_0.__have_data(arg_14_0, arg_14_1, arg_14_2)
		local var_14_0 = false

		if arg_14_1 and next(arg_14_1) then
			for iter_14_0, iter_14_1 in pairs(arg_14_1) do
				if iter_14_0 == arg_14_2 and iter_14_1 then
					var_14_0 = true

					return true
				end
			end
		end

		return var_14_0
	end

	function arg_1_0._select_level_not_max_list(arg_15_0, arg_15_1)
		local var_15_0 = {}

		for iter_15_0, iter_15_1 in pairs(arg_15_1) do
			if iter_15_1.level < 110 then
				var_0_6(var_15_0, iter_15_1)
			end
		end

		return var_15_0
	end

	function arg_1_0._select_level_max_list(arg_16_0, arg_16_1)
		local var_16_0 = {}

		for iter_16_0, iter_16_1 in pairs(arg_16_1) do
			if iter_16_1.level == 110 then
				var_0_6(var_16_0, iter_16_1)
			end
		end

		return var_16_0
	end

	function arg_1_0._select_love_not_max_list(arg_17_0, arg_17_1)
		local var_17_0 = {}

		for iter_17_0, iter_17_1 in pairs(arg_17_1) do
			if iter_17_1.marry and iter_17_1.love < 20000 then
				var_0_6(var_17_0, iter_17_1)
			elseif not iter_17_1.marry and iter_17_1.love < 10000 then
				var_0_6(var_17_0, iter_17_1)
			end
		end

		return var_17_0
	end

	function arg_1_0._select_marry_list(arg_18_0, arg_18_1)
		local var_18_0 = {}

		for iter_18_0, iter_18_1 in pairs(arg_18_1) do
			if not iter_18_1.marry and iter_18_1.love == 10000 then
				var_0_6(var_18_0, iter_18_1)
			end
		end

		return var_18_0
	end

	function arg_1_0._select_married_list(arg_19_0, arg_19_1)
		local var_19_0 = {}

		for iter_19_0, iter_19_1 in pairs(arg_19_1) do
			if iter_19_1.marry then
				var_0_6(var_19_0, iter_19_1)
			end
		end

		return var_19_0
	end

	function arg_1_0:__check_cost_num(arg_20_1)
		if self:get_cost_toggle_select() == "all" then
			return true
		end

		local var_20_0 = var_0_3.find_object_by_cid(arg_20_1)
		local var_20_1

		if var_20_0 and var_20_0.cost and var_20_0.cost then
			var_20_1 = var_20_0.cost
		end

		if var_20_1 == self._cost_toggle_select then
			return true
		end

		return self._cost_toggle_select == 7 and var_20_1 > 7
	end

	function arg_1_0:__check_skill(arg_21_1)
		if self:get_skill_toggle_select() == "all" then
			return true
		end

		local var_21_0 = var_0_5.dict_lenght(var_0_3.find_object_by_cid(arg_21_1).skills)

		if self._skill_toggle_select == "one_skill" then
			return var_21_0 == 1
		elseif self._skill_toggle_select == "two_skill" then
			return var_21_0 == 2
		end

		return false
	end

	function arg_1_0:__check_rebuild(arg_22_1)
		if not self._rebuild_toggle_data or self._rebuild_toggle_data.all then
			return true
		end

		local var_22_0 = self._rebuild_toggle_data
		local var_22_1 = self._rebuild_toggle_data.has_rebuild or var_22_0.not_rebuild
		local var_22_2 = var_22_0.ship_lock or var_22_0.ship_unlock

		if not var_22_1 and not var_22_2 then
			return true
		end

		local var_22_3 = true

		if var_22_1 then
			var_22_3 = false

			local var_22_4 = math.floor((arg_22_1.cid or arg_22_1) / 1000000)

			if var_22_0.has_rebuild and var_22_4 == 11 then
				var_22_3 = true
			end

			if var_22_0.not_rebuild and var_22_4 == 10 then
				var_22_3 = true
			end
		end

		local var_22_5 = true

		if var_22_2 then
			var_22_5 = not not (var_22_0.ship_lock and arg_22_1.lock == true)

			if var_22_0.ship_unlock and arg_22_1.lock ~= true then
				var_22_5 = true
			end
		end

		return var_22_3 and var_22_5
	end

	function arg_1_0:__check_character(arg_23_1)
		if self:get_character_toggle_select() == "all" then
			return true
		end

		local var_23_0 = var_0_3.find_object_by_cid(arg_23_1).boss

		if self._character_toggle_select == "leaders" then
			return var_23_0 == 1
		elseif self._character_toggle_select == "not_leaders" then
			return var_23_0 == 0
		end

		return false
	end

	function arg_1_0:set_skill_group_visible(arg_24_1)
		self._control.bg.skill_group:SetActive(arg_24_1)
	end

	function arg_1_0:set_tactics_group_visible(arg_25_1)
		self._control.bg.tactics_panel:SetActive(arg_25_1)
	end

	function arg_1_0:set_cook_group_visible(arg_26_1)
		self._control.bg.cook_btn:SetActive(arg_26_1)
	end

	function arg_1_0:set_rebuild_group_visible(arg_27_1)
		self._control.bg.rebuild_group:SetActive(arg_27_1)

		if not arg_27_1 then
			self._rebuild_toggle_data = {
				all = true
			}
			self._rebuild_toggle_data_memory = {
				all = true
			}
		end
	end

	function arg_1_0:set_love_group_visible(arg_28_1)
		if arg_28_1 then
			self._control.bg.love_group:SetActive(true)
		end
	end

	function arg_1_0:set_cost_num_group_visible(arg_29_1)
		self._control.bg.cost_num_group:SetActive(arg_29_1)
	end

	function arg_1_0:set_character_group_visible(arg_30_1)
		self._control.bg.character_group:SetActive(arg_30_1)
		self._control.bg.abyss_type_group:SetActive(arg_30_1)
		self._control.bg.country_group:SetActive(not arg_30_1)
		self._control.bg.type_group:SetActive(not arg_30_1)
		self._control.bg.size_group:SetActive(not arg_30_1)
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self._control.bg.country_group.toggle_group.all.Label.text.text = var_0_1:getNowLang("country0")
			self._control.bg.filter_type.type_txt.text.text = var_0_1:getNowLang("type")
			self._control.bg.country_group.toggle_group.C_country.Label.text.text = var_0_1:getNowLang("country8")
			self._control.bg.country_group.toggle_group.E_country.Label.text.text = var_0_1:getNowLang("country3")
			self._control.bg.country_group.toggle_group.F_country.Label.text.text = var_0_1:getNowLang("country6")
			self._control.bg.country_group.toggle_group.G_country.Label.text.text = var_0_1:getNowLang("country2")
			self._control.bg.country_group.toggle_group.I_country.Label.text.text = var_0_1:getNowLang("country5")
			self._control.bg.country_group.toggle_group.J_country.Label.text.text = var_0_1:getNowLang("country1")
			self._control.bg.country_group.toggle_group.S_country.Label.text.text = var_0_1:getNowLang("country7")
			self._control.bg.country_group.toggle_group.U_country.Label.text.text = var_0_1:getNowLang("country4")
			self._control.bg.country_group.toggle_group.other_country.Label.text.text = var_0_1:getNowLang("country9")
			self._control.bg.love_group.toggle_group.all.Label.text.text = var_0_1:getNowLang("equip0")
			self._control.bg.love_group.toggle_group.level_not_max.Label.text.text = var_0_1:getNowLang("level_no_max")
			self._control.bg.love_group.toggle_group.level_max.Label.text.text = var_0_1:getNowLang("level_max")
			self._control.bg.love_group.toggle_group.love_not_max.Label.text.text = var_0_1:getNowLang("love_no_max")
			self._control.bg.love_group.toggle_group.marry.Label.text.text = var_0_1:getNowLang("state_can_vow")
			self._control.bg.love_group.toggle_group.married.Label.text.text = var_0_1:getNowLang("state_vow")
			self._control.bg.tactics_panel.toggle_btn.all.Label.text.text = var_0_1:getNowLang("skill0")
			self._control.bg.tactics_panel.toggle_btn.three_tactics.Label.text.text = "lv.3"
			self._control.bg.tactics_panel.toggle_btn.two_tactics.Label.text.text = "lv.2"
			self._control.bg.tactics_panel.toggle_btn.one_tactics.Label.text.text = "lv.1"
			self._control.bg.tactics_panel.toggle_btn.zero_tactics.Label.text.text = "lv.0"
			self._control.bg.cook_btn.cook_group.all.Label.text.text = var_0_1:getNowLang("equip0")
			self._control.bg.cook_btn.cook_group.max_cook.Label.text.text = var_0_1:getNowLang("goodat_max")
			self._control.bg.cook_btn.cook_group.min_cook.Label.text.text = var_0_1:getNowLang("goodat_no_max")

			for iter_31_0, iter_31_1 in pairs(var_0_4.filter_type) do
				self._control.bg.type_group.toggle_group[iter_31_0].Label.text.text = iter_31_0 == "CLT" and var_0_1:getNowLang("shiptype9") or var_0_1:getNowLang(string.format("shiptype%s", iter_31_1))
			end

			for iter_31_2, iter_31_3 in pairs(var_0_4.abyss_filter_type) do
				self._control.bg.abyss_type_group.toggle_group[iter_31_2].Label.text.text = iter_31_2 == "CLT" and var_0_1:getNowLang("shiptype9") or var_0_1:getNowLang(string.format("shiptype%s", iter_31_3))
			end

			self._control.bg.size_group.toggle_group.all.Label.text.text = var_0_1:getNowLang("shipbigtype0")
			self._control.bg.size_group.toggle_group.large.Label.text.text = var_0_1:getNowLang("shipbigtype1")
			self._control.bg.size_group.toggle_group.middle.Label.text.text = var_0_1:getNowLang("shipbigtype2")
			self._control.bg.size_group.toggle_group.small.Label.text.text = var_0_1:getNowLang("shipbigtype3")
			self._control.bg.size_group.toggle_group.maip.Label.text.text = var_0_1:getNowLang("guard_type1")
			self._control.bg.size_group.toggle_group.protect.Label.text.text = var_0_1:getNowLang("guard_type2")
			self._control.bg.btn_series.confirm_btn.confirm.text.text = var_0_1:getNowLang("confirm")
			self._control.bg.btn_series.cancel_btn.cancel.text.text = var_0_1:getNowLang("cancel")

			self:__init_filter_type_list()

			self._toggle_skill_group.all.Label.text.text = var_0_1:getNowLang("skill0")
			self._toggle_skill_group.one_skill.Label.text.text = var_0_1:getNowLang("skill1")
			self._toggle_skill_group.two_skill.Label.text.text = var_0_1:getNowLang("skill2")
			self._toggle_rebuild_group.all.Label.text.text = var_0_1:getNowLang("equip0")
			self._toggle_rebuild_group.has_rebuild.Label.text.text = var_0_1:getNowLang("remake")
			self._toggle_rebuild_group.not_rebuild.Label.text.text = var_0_1:getNowLang("unremake")
			self._toggle_rebuild_group.ship_lock.Label.text.text = var_0_1:getNowLang("ship_lock")
			self._toggle_rebuild_group.ship_unlock.Label.text.text = var_0_1:getNowLang("ship_unlock")
			self._toggle_character_group.all.Label.text.text = var_0_1:getNowLang("tip_all")
			self._toggle_character_group.leaders.Label.text.text = var_0_1:getNowLang("tip_boss")
			self._toggle_character_group.not_leaders.Label.text.text = var_0_1:getNowLang("tip_not_boss")
			self._cost_group[0].Label.text.text = var_0_1:getNowLang("tip_all")

			for iter_31_4 = 1, 6 do
				self._cost_group[iter_31_4].Label.text.text = tostring(iter_31_4)
			end

			self._cost_group[7].Label.text.text = "7+"
			self._is_already_init = true

			self._toggle_tactics_group.zero_tactics:SetActive(false)
			self._toggle_tactics_group.one_tactics:SetActive(false)
			self._toggle_tactics_group.two_tactics:SetActive(false)
			self._toggle_tactics_group.three_tactics:SetActive(false)
			self._toggle_tactics_group.all:SetActive(true)
		end

		if self._rebuild_toggle_data_memory and self._toggle_rebuild_group then
			local var_31_0 = self._rebuild_toggle_data_memory

			self._is_restoring_rebuild = true
			self._toggle_rebuild_group.all.toggle.isOn = not not var_31_0.all
			self._toggle_rebuild_group.has_rebuild.toggle.isOn = not not var_31_0.has_rebuild
			self._toggle_rebuild_group.not_rebuild.toggle.isOn = not not var_31_0.not_rebuild
			self._toggle_rebuild_group.ship_lock.toggle.isOn = not not var_31_0.ship_lock
			self._toggle_rebuild_group.ship_unlock.toggle.isOn = not not var_31_0.ship_unlock
			self._is_restoring_rebuild = false
		end

		if self._need_revert then
			self:__revert_toggle_group_all_set()

			self._need_revert = false
		end

		self:__save_toggle_group_all_set_data()
	end

	function arg_1_0:__init_filter_type_list()
		self._toggle_country_group = {
			all = self._control.bg.country_group.toggle_group.all,
			C_country = self._control.bg.country_group.toggle_group.C_country,
			E_country = self._control.bg.country_group.toggle_group.E_country,
			F_country = self._control.bg.country_group.toggle_group.F_country,
			G_country = self._control.bg.country_group.toggle_group.G_country,
			I_country = self._control.bg.country_group.toggle_group.I_country,
			J_country = self._control.bg.country_group.toggle_group.J_country,
			S_country = self._control.bg.country_group.toggle_group.S_country,
			U_country = self._control.bg.country_group.toggle_group.U_country,
			other_country = self._control.bg.country_group.toggle_group.other_country
		}
		self._toggle_country_group_obj = gamecore.toggle_group:create({
			"all"
		}, {
			"C_country",
			"E_country",
			"F_country",
			"G_country",
			"I_country",
			"J_country",
			"S_country",
			"U_country",
			"other_country"
		}, self._toggle_country_group)
		self._toggle_type_group = {
			all = self._control.bg.type_group.toggle_group.all,
			CV = self._control.bg.type_group.toggle_group.CV,
			CVL = self._control.bg.type_group.toggle_group.CVL,
			AV = self._control.bg.type_group.toggle_group.AV,
			BB = self._control.bg.type_group.toggle_group.BB,
			BBV = self._control.bg.type_group.toggle_group.BBV,
			BC = self._control.bg.type_group.toggle_group.BC,
			CA = self._control.bg.type_group.toggle_group.CA,
			CAV = self._control.bg.type_group.toggle_group.CAV,
			CLT = self._control.bg.type_group.toggle_group.CLT,
			CL = self._control.bg.type_group.toggle_group.CL,
			BM = self._control.bg.type_group.toggle_group.BM,
			DD = self._control.bg.type_group.toggle_group.DD,
			SSG = self._control.bg.type_group.toggle_group.SSG,
			SS = self._control.bg.type_group.toggle_group.SS,
			SC = self._control.bg.type_group.toggle_group.SC,
			AP = self._control.bg.type_group.toggle_group.AP,
			KP = self._control.bg.type_group.toggle_group.KP,
			CG = self._control.bg.type_group.toggle_group.CG,
			ASDG = self._control.bg.type_group.toggle_group.ASDG,
			AADG = self._control.bg.type_group.toggle_group.AADG,
			CBG = self._control.bg.type_group.toggle_group.CBG,
			BBG = self._control.bg.type_group.toggle_group.BBG,
			BG = self._control.bg.type_group.toggle_group.BG
		}
		self._toggle_type_group_obj = gamecore.toggle_group:create({
			"all"
		}, {
			"CV",
			"CVL",
			"AV",
			"BB",
			"BBV",
			"BC",
			"CA",
			"CAV",
			"CLT",
			"CL",
			"BM",
			"DD",
			"SSG",
			"SS",
			"SC",
			"AP",
			"KP",
			"CG",
			"ASDG",
			"AADG",
			"CBG",
			"BBG",
			"BG"
		}, self._toggle_type_group)
		self._toggle_abyss_type_group = {
			all = self._control.bg.abyss_type_group.toggle_group.all,
			CV = self._control.bg.abyss_type_group.toggle_group.CV,
			CVL = self._control.bg.abyss_type_group.toggle_group.CVL,
			AV = self._control.bg.abyss_type_group.toggle_group.AV,
			BB = self._control.bg.abyss_type_group.toggle_group.BB,
			BBV = self._control.bg.abyss_type_group.toggle_group.BBV,
			BC = self._control.bg.abyss_type_group.toggle_group.BC,
			CA = self._control.bg.abyss_type_group.toggle_group.CA,
			CAV = self._control.bg.abyss_type_group.toggle_group.CAV,
			CLT = self._control.bg.abyss_type_group.toggle_group.CLT,
			CL = self._control.bg.abyss_type_group.toggle_group.CL,
			BM = self._control.bg.abyss_type_group.toggle_group.BM,
			DD = self._control.bg.abyss_type_group.toggle_group.DD,
			SSG = self._control.bg.abyss_type_group.toggle_group.SSG,
			SS = self._control.bg.abyss_type_group.toggle_group.SS,
			SC = self._control.bg.abyss_type_group.toggle_group.SC,
			AP = self._control.bg.abyss_type_group.toggle_group.AP,
			Fortress = self._control.bg.abyss_type_group.toggle_group.Fortress,
			Airfield = self._control.bg.abyss_type_group.toggle_group.Airfield,
			ASDG = self._control.bg.abyss_type_group.toggle_group.ASDG,
			AADG = self._control.bg.abyss_type_group.toggle_group.AADG,
			CBG = self._control.bg.abyss_type_group.toggle_group.CBG,
			BBG = self._control.bg.abyss_type_group.toggle_group.BBG,
			TX = self._control.bg.abyss_type_group.toggle_group.TX,
			Elite = self._control.bg.abyss_type_group.toggle_group.Elite,
			BG = self._control.bg.abyss_type_group.toggle_group.BG
		}
		self._toggle_abyss_type_group_obj = gamecore.toggle_group:create({
			"all"
		}, {
			"CV",
			"CVL",
			"AV",
			"BB",
			"BBV",
			"BC",
			"CA",
			"CAV",
			"CLT",
			"CL",
			"BM",
			"DD",
			"SSG",
			"SS",
			"SC",
			"AP",
			"Fortress",
			"Airfield",
			"ASDG",
			"AADG",
			"CBG",
			"BBG",
			"TX",
			"Elite",
			"BG"
		}, self._toggle_abyss_type_group)
		self._toggle_size_group = {
			all = self._control.bg.size_group.toggle_group.all,
			large = self._control.bg.size_group.toggle_group.large,
			middle = self._control.bg.size_group.toggle_group.middle,
			small = self._control.bg.size_group.toggle_group.small,
			maip = self._control.bg.size_group.toggle_group.maip,
			protect = self._control.bg.size_group.toggle_group.protect
		}
		self._toggle_size_group_obj = gamecore.toggle_group:create({
			"all"
		}, {
			"large",
			"middle",
			"small",
			"maip",
			"protect"
		}, self._toggle_size_group)
		self._toggle_skill_group = {
			all = self._control.bg.skill_group.toggle_group.all,
			one_skill = self._control.bg.skill_group.toggle_group.one_skill,
			two_skill = self._control.bg.skill_group.toggle_group.two_skill
		}
		self._toggle_rebuild_group = {
			all = self._control.bg.rebuild_group.toggle_group.all,
			has_rebuild = self._control.bg.rebuild_group.toggle_group.has_rebuild,
			not_rebuild = self._control.bg.rebuild_group.toggle_group.not_rebuild,
			ship_lock = self._control.bg.rebuild_group.toggle_group.ship_lock,
			ship_unlock = self._control.bg.rebuild_group.toggle_group.ship_unlock
		}
		self._toggle_rebuild_group_obj = gamecore.toggle_group:create({
			"all"
		}, {
			"has_rebuild",
			"not_rebuild",
			"ship_lock",
			"ship_unlock"
		}, self._toggle_rebuild_group)

		if self._toggle_rebuild_group then
			local function var_32_2()
				if self._is_restoring_rebuild then
					return
				end

				if not self._toggle_rebuild_group then
					return
				end

				if not self._toggle_rebuild_group.all then
					return
				end

				if not self._toggle_rebuild_group.has_rebuild then
					return
				end

				if not self._toggle_rebuild_group.not_rebuild then
					return
				end

				if not self._toggle_rebuild_group.ship_lock then
					return
				end

				if not self._toggle_rebuild_group.ship_unlock then
					return
				end

				if not self._toggle_rebuild_group.has_rebuild.toggle.isOn and not self._toggle_rebuild_group.not_rebuild.toggle.isOn and not self._toggle_rebuild_group.ship_lock.toggle.isOn and not self._toggle_rebuild_group.ship_unlock.toggle.isOn and not self._toggle_rebuild_group.all.toggle.isOn then
					self._toggle_rebuild_group.all.toggle.isOn = true
				end
			end

			self._toggle_rebuild_group.all.toggle.onValueChanged:AddListener(var_32_2)
			self._toggle_rebuild_group.has_rebuild.toggle.onValueChanged:AddListener(var_32_2)
			self._toggle_rebuild_group.not_rebuild.toggle.onValueChanged:AddListener(var_32_2)
			self._toggle_rebuild_group.ship_lock.toggle.onValueChanged:AddListener(var_32_2)
			self._toggle_rebuild_group.ship_unlock.toggle.onValueChanged:AddListener(var_32_2)
		end

		self._toggle_character_group = {
			all = self._control.bg.character_group.toggle_group.all,
			leaders = self._control.bg.character_group.toggle_group.leaders,
			not_leaders = self._control.bg.character_group.toggle_group.not_leaders
		}
		self._cost_group = {
			[0] = self._control.bg.cost_num_group.toggle_group.all,
			self._control.bg.cost_num_group.toggle_group.one,
			self._control.bg.cost_num_group.toggle_group.two,
			self._control.bg.cost_num_group.toggle_group.three,
			self._control.bg.cost_num_group.toggle_group.four,
			self._control.bg.cost_num_group.toggle_group.five,
			self._control.bg.cost_num_group.toggle_group.six,
			self._control.bg.cost_num_group.toggle_group.bigger_then_six
		}
		self._toggle_love_group = {
			all = self._control.bg.love_group.toggle_group.all,
			level_not_max = self._control.bg.love_group.toggle_group.level_not_max,
			level_max = self._control.bg.love_group.toggle_group.level_max,
			love_not_max = self._control.bg.love_group.toggle_group.love_not_max,
			marry = self._control.bg.love_group.toggle_group.marry,
			married = self._control.bg.love_group.toggle_group.married
		}
		self._toggle_love_group_obj = gamecore.toggle_group:create({
			"all"
		}, {
			"level_not_max",
			"level_max",
			"love_not_max",
			"marry",
			"married"
		}, self._toggle_love_group)
		self._toggle_tactics_group = {
			all = self._control.bg.tactics_panel.toggle_btn.all.Background.Checkmark,
			three_tactics = self._control.bg.tactics_panel.toggle_btn.three_tactics.Background.Checkmark,
			two_tactics = self._control.bg.tactics_panel.toggle_btn.two_tactics.Background.Checkmark,
			one_tactics = self._control.bg.tactics_panel.toggle_btn.one_tactics.Background.Checkmark,
			zero_tactics = self._control.bg.tactics_panel.toggle_btn.zero_tactics.Background.Checkmark
		}
	end

	function arg_1_0:reset_select_state()
		self._toggle_size_group.all.toggle.isOn = true
		self._toggle_type_group.all.toggle.isOn = true
		self._toggle_abyss_type_group.all.toggle.isOn = true
		self._toggle_country_group.all.toggle.isOn = true
		self._toggle_love_group.all.toggle.isOn = true
		self._toggle_character_group.not_leaders.toggle.isOn = false
		self._toggle_character_group.leaders.toggle.isOn = false
		self._toggle_character_group.all.toggle.isOn = true
		self._rebuild_toggle_data = {
			all = true
		}
		self._rebuild_toggle_data_memory = {
			all = true
		}

		if self._toggle_rebuild_group then
			self._is_restoring_rebuild = true
			self._toggle_rebuild_group.all.toggle.isOn = true
			self._toggle_rebuild_group.has_rebuild.toggle.isOn = false
			self._toggle_rebuild_group.not_rebuild.toggle.isOn = false
			self._toggle_rebuild_group.ship_lock.toggle.isOn = false
			self._toggle_rebuild_group.ship_unlock.toggle.isOn = false
			self._is_restoring_rebuild = false
		end

		if self._toggle_rebuild_group_obj then
			self._toggle_rebuild_group_obj:toggleOn("all", true)
		end

		self._cost_group[0].toggle.isOn = true

		self:__onClick_bg_btn_series_confirm_btn()
	end

	function arg_1_0:set_sort_exclude(arg_35_1)
		self._exclude_list = {}

		if arg_35_1 then
			for iter_35_0, iter_35_1 in ipairs(arg_35_1) do
				if iter_35_1 and iter_35_1.id then
					self._exclude_list[iter_35_1.id] = true
				end
			end
		end
	end

	function arg_1_0:_init_statics_state()
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

	function arg_1_0:set_target_type_group_state(arg_37_1, arg_37_2)
		if arg_37_1 == "rebuild" then
			self._rebuild_toggle_data = not arg_37_2 and {
				all = true
			} or var_0_5.little_clone(self._rebuild_toggle_data_memory) or {
				all = true
			}

			return
		end

		self[string.format("_%s_toggle_select", arg_37_1)] = not arg_37_2 and "all" or self[string.format("_%s_toggle_select_memory", arg_37_1)]
	end

	function arg_1_0:set_type_limit(arg_38_1)
		self._control.bg.type_group:SetActive(false)
		self._control.bg.size_group:SetActive(false)

		self._type_toggle_data = {}
		self._type_toggle_data.all = false
		self._type_toggle_data[arg_38_1] = true
		self._is_type_limit = true
	end

	function arg_1_0.__onReset(arg_39_0)
		arg_39_0._is_type_limit = false
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_40_0)
	local var_40_0 = var_0_2:class("type_layer")

	var_40_0._is_already_init = false
	var_40_0._confirm_listener = nil
	var_40_0._source_data = nil
	var_40_0._exclude_list = {}
	var_40_0._rebuild_toggle_data = {
		all = true
	}
	var_40_0._rebuild_toggle_data_memory = {
		all = true
	}
	var_40_0._is_restoring_rebuild = false
	var_40_0._is_rebuild_syncing = false
	var_40_0._is_type_limit = false
	var_40_0._already_in_love_group = {}

	gamecore.extend_obj(var_40_0)

	return var_40_0
end

return var_0_0
