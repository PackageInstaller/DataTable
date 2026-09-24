local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gameconfig.equip_config
local var_0_4 = gameenum.common_type
local var_0_5 = string.format
local var_0_6 = table.sort
local var_0_7 = table.insert
local var_0_8 = gamecore.user
local var_0_9 = Vector2
local var_0_10 = gamecore.util_func
local var_0_11 = string.find
local var_0_12 = {
	gamecore.Language:getNowLang("range1"),
	gamecore.Language:getNowLang("range2"),
	gamecore.Language:getNowLang("range3"),
	gamecore.Language:getNowLang("range4")
}

gamecore.UILoader:define("equip_map", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))
		self:__init_panel()
	end

	function arg_1_0:show_back()
		self:setVisible(true)
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))
		self:__init_panel_back()
	end

	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0:__init_effect()
		var_0_10.set_type_of_shader_tint(self._control.shine)
	end

	function arg_1_0:__init_filter_type_list()
		self._toggle_type_group = {
			all = self._control.type_layer.type_group.toggle_group.all,
			main_gun = self._control.type_layer.type_group.toggle_group.main_gun,
			sub_gun = self._control.type_layer.type_group.toggle_group.sub_gun,
			torpedo = self._control.type_layer.type_group.toggle_group.torpedo,
			torpedo_plane = self._control.type_layer.type_group.toggle_group.torpedo_plane,
			fighter = self._control.type_layer.type_group.toggle_group.fighter,
			bomber = self._control.type_layer.type_group.toggle_group.bomber,
			spy_plane = self._control.type_layer.type_group.toggle_group.spy_plane,
			radar = self._control.type_layer.type_group.toggle_group.radar,
			module = self._control.type_layer.type_group.toggle_group.module,
			bullet = self._control.type_layer.type_group.toggle_group.bullet,
			aagun = self._control.type_layer.type_group.toggle_group.aagun,
			repairs = self._control.type_layer.type_group.toggle_group.repairs,
			anti_sub = self._control.type_layer.type_group.toggle_group.anti_sub,
			missile_launcher = self._control.type_layer.type_group.toggle_group.missile_launcher,
			missile = self._control.type_layer.type_group.toggle_group.missile
		}
		self._toggle_type_group_obj = gamecore.toggle_group:create({
			"all"
		}, {
			"main_gun",
			"sub_gun",
			"torpedo",
			"torpedo_plane",
			"fighter",
			"bomber",
			"spy_plane",
			"radar",
			"module",
			"bullet",
			"aagun",
			"repairs",
			"anti_sub",
			"missile_launcher",
			"missile"
		}, self._toggle_type_group)
		self._toggle_own_group = {
			all = self._control.type_layer.own_group.toggle_group.all,
			own_type = self._control.type_layer.own_group.toggle_group.own_type,
			not_own_type = self._control.type_layer.own_group.toggle_group.not_own_type
		}
		self._toggle_type_group_obj._rule_a.set = {
			all = true
		}
		self._toggle_type_group_obj._rule_b.set = {
			bomber = false,
			anti_sub = false,
			bullet = false,
			torpedo = false,
			module = false,
			spy_plane = false,
			missile = false,
			torpedo_plane = false,
			sub_gun = false,
			aagun = false,
			fighter = false,
			main_gun = false,
			missile_launcher = false,
			repairs = false,
			radar = false
		}
	end

	function arg_1_0:play_in_out_animation(arg_7_1, arg_7_2, arg_7_3)
		arg_7_3 = arg_7_3 or self._control.bg.uITweenSequence

		if arg_7_1 then
			arg_7_3:Play(function()
				if arg_7_2 then
					arg_7_2()
				end
			end)
		else
			arg_7_3:PlayReverse(function()
				if arg_7_2 then
					arg_7_2()
				end
			end)
		end
	end

	function arg_1_0:init_cell()
		self._reusable_cell = gamecore.reusable_cell:create(self, self._control.scrollview.viewport.content.endlessScrollView, self._control.scrollview.viewport.content, "single_equip_map", "equip_map")

		self._reusable_cell:init()
	end

	function arg_1_0:get_new_equip_list(arg_11_1)
		local var_11_0 = var_0_8:get_cardbook_equip_list()
		local var_11_1 = ""

		if self._type_toggle_data.all then
			var_11_1 = "all"
		else
			for iter_11_0, iter_11_1 in pairs(self._type_toggle_data) do
				if iter_11_0 ~= "all" then
					var_11_1 = iter_11_0
				end
			end
		end

		if var_11_1 == "all" and self._own_toggle_data == "all" then
			return arg_11_1
		end

		local var_11_2 = {}

		for iter_11_2, iter_11_3 in ipairs(arg_11_1) do
			local var_11_3 = false

			if var_11_1 == "missile_launcher" then
				if var_0_4.equip_type.anti_ship_missile_launcher == iter_11_3.type or var_0_4.equip_type.air_defense_missile_launcher == iter_11_3.type then
					var_11_3 = true
				end
			elseif var_11_1 == "missile" then
				if var_0_4.equip_type.anti_ship_missile == iter_11_3.type or var_0_4.equip_type.air_defense_missile == iter_11_3.type then
					var_11_3 = true
				end
			elseif var_11_1 == "all" then
				var_11_3 = true
			elseif var_0_4.equip_type[var_11_1] == iter_11_3.type then
				var_11_3 = true
			end

			local var_11_4 = not not var_0_10.have_data(var_11_0, iter_11_3.cid)

			if var_11_3 then
				if self._own_toggle_data == "own" and var_11_4 and iter_11_3.handbook_type == 1 then
					var_0_7(var_11_2, iter_11_3)
				elseif self._own_toggle_data == "not_own" and not var_11_4 and iter_11_3.handbook_type == 1 then
					var_0_7(var_11_2, iter_11_3)
				elseif self._own_toggle_data == "all" then
					var_0_7(var_11_2, iter_11_3)
				end
			end
		end

		return var_11_2
	end

	function arg_1_0.get_equip_attr(arg_12_0, arg_12_1)
		local var_12_0 = {}
		local var_12_1 = var_0_3.find_object_by_cid(arg_12_1)

		if var_12_1.hp ~= 0 then
			var_0_7(var_12_0, {
				type = "hp",
				sum = var_12_1.hp
			})
		end

		if var_12_1.atk ~= 0 then
			var_0_7(var_12_0, {
				type = "atk",
				sum = var_12_1.atk
			})
		end

		if var_12_1.torpedo ~= 0 then
			var_0_7(var_12_0, {
				type = "torpedo",
				sum = var_12_1.torpedo
			})
		end

		if var_12_1.def ~= 0 then
			var_0_7(var_12_0, {
				type = "def",
				sum = var_12_1.def
			})
		end

		if var_12_1.air_def ~= 0 then
			var_0_7(var_12_0, {
				type = "airdef",
				sum = var_12_1.air_def
			})
		end

		if var_12_1.aircraft_atk ~= 0 then
			var_0_7(var_12_0, {
				type = "aircraftatk",
				sum = var_12_1.aircraft_atk
			})
		end

		if var_12_1.radar ~= 0 then
			var_0_7(var_12_0, {
				type = "radar",
				sum = var_12_1.radar
			})
		end

		if var_12_1.antisub ~= 0 then
			var_0_7(var_12_0, {
				type = "antisub",
				sum = var_12_1.antisub
			})
		end

		if var_12_1.hit ~= 0 then
			var_0_7(var_12_0, {
				type = "hit",
				sum = var_12_1.hit
			})
		end

		if var_12_1.miss ~= 0 then
			var_0_7(var_12_0, {
				type = "miss",
				sum = var_12_1.miss
			})
		end

		if var_12_1.luck ~= 0 then
			var_0_7(var_12_0, {
				type = "luck",
				sum = var_12_1.luck
			})
		end

		if var_12_1.range ~= 0 then
			var_0_7(var_12_0, {
				type = "range",
				sum = var_12_1.range
			})
		end

		if var_12_1.missile_hit ~= 0 then
			var_0_7(var_12_0, {
				type = "missilehit",
				sum = var_12_1.missile_hit
			})
		end

		if var_12_1.missile_tmd ~= 0 then
			var_0_7(var_12_0, {
				type = "missiletmd",
				sum = var_12_1.missile_tmd
			})
		end

		return var_12_0
	end

	function arg_1_0.get_attr_str(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
		return arg_13_1 == "range" and var_0_12[arg_13_2] or arg_13_3 and (arg_13_2 > 0 and "+" .. arg_13_2 or arg_13_2) or arg_13_2
	end

	function arg_1_0.init_equip_config(arg_14_0)
		local var_14_0 = {}
		local var_14_1, var_14_2 = var_0_3:get_sequence()

		for iter_14_0, iter_14_1 in pairs(var_14_1) do
			if iter_14_1.handbook_type > 0 then
				var_0_7(var_14_0, iter_14_1)
			end
		end

		var_0_6(var_14_0, function(arg_15_0, arg_15_1)
			return arg_15_0.cid < arg_15_1.cid
		end)

		arg_14_0._equip_config = var_14_0
	end

	function arg_1_0:init_general_cell_list()
		local var_16_0 = var_0_8:get_cardbook_equip_list()
		local var_16_1 = self:__filter_table_by_name((self:get_new_equip_list(self._equip_config)))

		self._reusable_cell:set_data(var_16_1)

		function self._reusable_cell:_set_func(arg_17_1)
			local var_17_0 = var_16_1[arg_17_1 + 1]

			function self.show_by_state(arg_18_0, arg_18_1)
				local var_18_0 = {
					self.not_open_bg,
					self.not_get_bg,
					self.all_layer
				}

				for iter_18_0 = 1, #var_18_0 do
					var_18_0[iter_18_0]:SetActive(false)
				end

				if arg_18_1 == 1 then
					var_18_0[arg_18_1]:SetActive(true)
				elseif arg_18_1 == 2 then
					var_18_0[arg_18_1]:SetActive(true)
					var_18_0[arg_18_1 + 1]:SetActive(true)
				elseif arg_18_1 == 3 then
					var_18_0[arg_18_1]:SetActive(true)
				end
			end

			local var_17_1 = false

			for iter_17_0, iter_17_1 in ipairs(var_16_0) do
				if iter_17_1 == var_17_0.cid then
					var_17_1 = true

					break
				end
			end

			if var_17_0.handbook_type == 1 then
				local var_17_2 = self.all_layer.detail_layer
				local var_17_3 = self.all_layer.name_layer

				self.all_layer.icon_layer.icon_bg.image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.ship_equip_pic.equipbg, var_17_0.star))
				self.all_layer.icon_layer.icon.image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.equip_icon.large, var_17_0.pic_id))
				self.all_layer.txt2.text.text = var_0_5("No.%03d", var_17_0.equip_index)

				local var_17_4 = self:get_equip_attr(var_17_0.cid)

				if var_17_4[1] then
					var_17_2.attrib_1.title.text.text = var_0_1:getNowLang(var_17_4[1].type)
					var_17_2.attrib_1.count.text.text = self:get_attr_str(var_17_4[1].type, var_17_4[1].sum, true)

					var_17_2.attrib_1:SetActive(true)
				else
					var_17_2.attrib_1:SetActive(false)
				end

				if var_17_4[2] then
					var_17_2.attrib_2.title.text.text = var_0_1:getNowLang(var_17_4[2].type)
					var_17_2.attrib_2.count.text.text = self:get_attr_str(var_17_4[2].type, var_17_4[2].sum, true)

					var_17_2.attrib_2:SetActive(true)
				else
					var_17_2.attrib_2:SetActive(false)
				end

				var_17_3.equip_name.beyondBoxEllipsis:SetTextWithEllipsis(var_17_0.title)
				self.bg.button.onClick:RemoveAllListeners()
				self.bg.button.onClick:AddListener(function()
					if not self.all_layer.activeSelf then
						return
					end

					self._now_click_equip_data = var_17_0

					self:setVisible(false)
					var_0_2:createInstance("equip_datail"):show(0)
				end)

				if var_17_1 then
					self:show_by_state(3)
				else
					self.not_get_bg.txt.text.text = var_0_1:getNowLang("medaltypeungain")
					self.all_layer.txt2.text.text = var_0_5("No.%03d", var_17_0.equip_index)

					self:show_by_state(2)
				end
			elseif var_17_0.handbook_type == 2 then
				self.not_open_bg.txt.text.text = var_0_1:getNowLang("ui_notopen")

				self:show_by_state(1)
			end
		end
	end

	function arg_1_0:__clear_input_field_name()
		self._filter_name = nil
		self._control.search.inputField.text = ""
	end

	function arg_1_0:__set_inputField_info()
		self._control.search.inputField.onEndEdit:AddListener(function()
			if self._control.search.inputField.text ~= "" then
				self._filter_name = self._control.search.inputField.text

				local var_22_0, var_22_1 = var_0_11(self._filter_name, "%(")

				if var_22_0 ~= nil and var_22_1 ~= nil then
					self._filter_name = var_0_10._str_insert(self._filter_name, var_22_0, "%")
				end

				self:init_general_cell_list()
				self:__check_type_selection()

				self._type_toggle_data = {}
				self._type_toggle_data.all = self._toggle_type_group_obj._rule_a.set.all

				for iter_22_0, iter_22_1 in pairs(self._toggle_type_group_obj._rule_b.set) do
					if iter_22_1 then
						self._type_toggle_data[iter_22_0] = iter_22_1
					end
				end

				self:__change_type_text()
				self:__update_cell()
			end
		end)
	end

	function arg_1_0:__filter_table_by_name(arg_23_1)
		local var_23_0 = {}

		if not self._filter_name then
			return arg_23_1
		end

		local var_23_1 = var_0_10.little_clone(arg_23_1)
		local var_23_2 = {}

		if self._filter_name and next(var_23_1) then
			for iter_23_0, iter_23_1 in pairs(var_23_1) do
				if iter_23_1.handbook_type and iter_23_1.handbook_type ~= 2 then
					var_0_7(var_23_2, iter_23_1)
				end
			end
		end

		local var_23_3, var_23_4 = var_0_11(self._filter_name, "%(")

		if var_23_3 ~= nil and var_23_4 ~= nil then
			self._filter_name = var_0_10._str_insert(self._filter_name, var_23_3, "%")
		end

		local var_23_5, var_23_6 = var_0_11(self._filter_name, "%%")

		if var_23_5 ~= nil and var_23_6 ~= nil then
			self._filter_name = var_0_10._str_insert(self._filter_name, var_23_5, "%")
		end

		local var_23_7, var_23_8 = var_0_11(self._filter_name, "%[")

		if var_23_7 ~= nil and var_23_8 ~= nil then
			self._filter_name = var_0_10._str_insert(self._filter_name, var_23_7, "%")
		end

		local var_23_9, var_23_10 = var_0_11(self._filter_name, "%]")

		if var_23_9 ~= nil and var_23_10 ~= nil then
			self._filter_name = var_0_10._str_insert(self._filter_name, var_23_9, "%")
		end

		local var_23_11, var_23_12 = var_0_11(self._filter_name, "%-")

		if var_23_11 ~= nil and var_23_12 ~= nil then
			self._filter_name = var_0_10._str_insert(self._filter_name, var_23_11, "%")
		end

		for iter_23_2, iter_23_3 in pairs(var_23_2) do
			if var_0_10.name_filter_match(iter_23_3.title, self._filter_name) then
				var_0_7(var_23_0, iter_23_3)
			end
		end

		self:set_filter_table_name(var_23_0)

		return var_23_0
	end

	function arg_1_0:get_filter_table_name()
		return self._filter_table_name
	end

	function arg_1_0.set_filter_table_name(arg_25_0, arg_25_1)
		arg_25_0._filter_table_name = arg_25_1
	end

	function arg_1_0:__update_cell()
		local var_26_0 = var_0_8:get_cardbook_equip_list()
		local var_26_1 = self:__filter_table_by_name((self:get_new_equip_list(self._equip_config)))

		self._reusable_cell:set_data(var_26_1)

		function self._reusable_cell:_set_func(arg_27_1)
			local var_27_0 = var_26_1[arg_27_1 + 1]

			function self.show_by_state(arg_28_0, arg_28_1)
				local var_28_0 = {
					self.not_open_bg,
					self.not_get_bg,
					self.all_layer
				}

				for iter_28_0 = 1, #var_28_0 do
					var_28_0[iter_28_0]:SetActive(false)
				end

				if arg_28_1 == 1 then
					var_28_0[arg_28_1]:SetActive(true)
				elseif arg_28_1 == 2 then
					var_28_0[arg_28_1]:SetActive(true)
					var_28_0[arg_28_1 + 1]:SetActive(true)
				elseif arg_28_1 == 3 then
					var_28_0[arg_28_1]:SetActive(true)
				end
			end

			local var_27_1 = false

			for iter_27_0, iter_27_1 in ipairs(var_26_0) do
				if iter_27_1 == var_27_0.cid then
					var_27_1 = true

					break
				end
			end

			if var_27_0.handbook_type == 1 then
				local var_27_2 = self.all_layer.detail_layer
				local var_27_3 = self.all_layer.name_layer

				self.all_layer.icon_layer.icon_bg.image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.ship_equip_pic.equipbg, var_27_0.star))
				self.all_layer.icon_layer.icon.image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.equip_icon.large, var_27_0.pic_id))
				self.all_layer.txt2.text.text = var_0_5("No.%03d", var_27_0.equip_index)

				local var_27_4 = self:get_equip_attr(var_27_0.cid)

				if var_27_4[1] then
					var_27_2.attrib_1.title.text.text = var_0_1:getNowLang(var_27_4[1].type)
					var_27_2.attrib_1.count.text.text = self:get_attr_str(var_27_4[1].type, var_27_4[1].sum, true)

					var_27_2.attrib_1:SetActive(true)
				else
					var_27_2.attrib_1:SetActive(false)
				end

				if var_27_4[2] then
					var_27_2.attrib_2.title.text.text = var_0_1:getNowLang(var_27_4[2].type)
					var_27_2.attrib_2.count.text.text = self:get_attr_str(var_27_4[2].type, var_27_4[2].sum, true)

					var_27_2.attrib_2:SetActive(true)
				else
					var_27_2.attrib_2:SetActive(false)
				end

				var_27_3.equip_name.beyondBoxEllipsis:SetTextWithEllipsis(var_27_0.title)
				self.bg.button.onClick:RemoveAllListeners()
				self.bg.button.onClick:AddListener(function()
					if not self.all_layer.activeSelf then
						return
					end

					self._now_click_equip_data = var_27_0

					self:setVisible(false)
					var_0_2:createInstance("equip_datail"):show(0)
				end)

				if var_27_1 then
					self:show_by_state(3)
				else
					self.not_get_bg.txt.text.text = var_0_1:getNowLang("medaltypeungain")
					self.all_layer.txt2.text.text = var_0_5("No.%03d", var_27_0.equip_index)

					self:show_by_state(2)
				end
			elseif var_27_0.handbook_type == 2 then
				self.not_open_bg.txt.text.text = var_0_1:getNowLang("ui_notopen")

				self:show_by_state(1)
			end
		end
	end

	function arg_1_0:__init_panel()
		self:__onReset()
		self:__init_language()
		self:__init_filter_type_list()
		self:init_equip_config()
		self:init_cell()
		self:__set_inputField_info()
		self:init_general_cell_list()
		self:__init_effect()
		self:show_sort_layer(false)
		self:play_in_out_animation(true)

		if self._toggle_own_group then
			self._control.type_layer.own_group.toggle_group.own_type.toggle.isOn = false
			self._control.type_layer.own_group.toggle_group.not_own_type.toggle.isOn = false
			self._control.type_layer.own_group.toggle_group.all.toggle.isOn = true
		end

		if self._toggle_type_group_obj then
			self._toggle_type_group_obj:toggleOn("all", self._toggle_type_group.all.toggle.isOn)
		end

		for iter_30_0, iter_30_1 in pairs(self._toggle_type_group_obj._rule_b.set) do
			iter_30_1 = false
			self._control.type_layer.type_group.toggle_group[iter_30_0].toggle.isOn = false
		end

		self:__onClick_type_layer()
	end

	function arg_1_0:__init_panel_back()
		self:__set_inputField_info()
		self:init_general_cell_list()
		self:__init_effect()
		self:show_sort_layer(false)
		self:play_in_out_animation(true)
	end

	function arg_1_0:__init_language()
		self._control.top.title_txt.text.text = var_0_1:getNowLang("ui_collectionequip")
		self._control.type_btn.type.text.text = var_0_1:getNowLang("type")
		self._control.type_btn.type_txt.text.text = var_0_1:getNowLang("equip0")
		self._control.type_layer.filter_type.type_txt.text.text = var_0_1:getNowLang("type")
		self._control.type_layer.type_group.toggle_group.all.Label.text.text = var_0_1:getNowLang("shiptype0")

		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.type_group.toggle_group.main_gun.Label_mask, var_0_1:getNowLang("equip1"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.type_group.toggle_group.sub_gun.Label_mask, var_0_1:getNowLang("equip2"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.type_group.toggle_group.torpedo.Label_mask, var_0_1:getNowLang("equip3"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.type_group.toggle_group.torpedo_plane.Label_mask, var_0_1:getNowLang("equip4"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.type_group.toggle_group.fighter.Label_mask, var_0_1:getNowLang("equip5"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.type_group.toggle_group.bomber.Label_mask, var_0_1:getNowLang("equip6"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.type_group.toggle_group.spy_plane.Label_mask, var_0_1:getNowLang("equip7"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.type_group.toggle_group.radar.Label_mask, var_0_1:getNowLang("equip8"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.type_group.toggle_group.module.Label_mask, var_0_1:getNowLang("equip9"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.type_group.toggle_group.bullet.Label_mask, var_0_1:getNowLang("equip10"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.type_group.toggle_group.aagun.Label_mask, var_0_1:getNowLang("equip11"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.type_group.toggle_group.repairs.Label_mask, var_0_1:getNowLang("equip13"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.type_group.toggle_group.anti_sub.Label_mask, var_0_1:getNowLang("equip14"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.type_group.toggle_group.missile_launcher.Label_mask, var_0_1:getNowLang("equip32"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.type_group.toggle_group.missile.Label_mask, var_0_1:getNowLang("equip34"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.own_group.toggle_group.own_type.Label_mask, var_0_1:getNowLang("medaltypegain"))

		self._control.type_layer.own_group.toggle_group.all.Label.text.text = var_0_1:getNowLang("shiptype0")
		self._control.type_layer.own_group.toggle_group.not_own_type.Label.text.text = var_0_1:getNowLang("medaltypeungain")
	end

	function arg_1_0:__onReset()
		self._control.scrollview.viewport.content.rectTransform.anchoredPosition = var_0_9(0, 0)
		self._type_toggle_data = {
			"all"
		}
		self._control.type_btn.type_txt.text.text = var_0_1:getNowLang("equip0")
		self._last_toggle_type_group_obj_rule_a = {}
		self._last_toggle_type_group_obj_rule_b = {}
		self._toggle_type_group_obj = nil
		self._own_toggle_data = "all"
		self._last_type = ""

		self:destroyChildren("single_equip_map")
	end

	function arg_1_0:show_sort_layer(arg_34_1)
		self._control.type_layer:SetActive(arg_34_1)
	end

	function arg_1_0:_play_into_se(arg_35_1)
		self:playSE(arg_35_1, false)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_36_0)
	local var_36_0 = var_0_2:class("equip_map")

	var_36_0._is_already_init = false
	var_36_0._reusable_cell = nil
	var_36_0._equip_config = {}
	var_36_0._toggle_type_group_obj = nil
	var_36_0._type_toggle_data = {
		all = true
	}
	var_36_0._own_toggle_data = "all"
	var_36_0._now_click_equip_data = nil
	var_36_0._last_type = ""
	var_36_0._need_revert = false
	var_36_0._last_toggle_type_group_obj_rule_a = {}
	var_36_0._last_toggle_type_group_obj_rule_b = {}
	var_36_0._filter_table_name = nil

	gamecore.extend_obj(var_36_0)

	return var_36_0
end

return var_0_0
