local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gameconfig.ship_config
local var_0_4 = gameenum.common_type
local var_0_5 = string.format
local var_0_6 = gamecore.util_func
local var_0_7 = table.insert
local var_0_10 = gamecore.user
local var_0_11 = table.remove
local var_0_12 = string.find

gamecore.UILoader:define("ship_map", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))
		self:__init_effects()
		self:__init_panel()

		self._is_already_init = true
	end

	function arg_1_0:__onUpdate()
		if self._reusable_cell_1 then
			self._reusable_cell_1:update()
		end

		if self._reusable_cell_2 then
			self._reusable_cell_2:update()
		end
	end

	function arg_1_0:__init_effects()
		var_0_6.set_type_of_shader_tint(self._control.shine)
	end

	function arg_1_0:play_in_out_animation(arg_5_1, arg_5_2, arg_5_3)
		arg_5_3 = arg_5_3 or self._control.bg.uITweenSequence

		if arg_5_1 then
			arg_5_3:Play(function()
				if arg_5_2 then
					arg_5_2()
				end
			end)
		else
			arg_5_3:PlayReverse(function()
				if arg_5_2 then
					arg_5_2()
				end
			end)
		end
	end

	function arg_1_0:show_scroll_by_index(arg_8_1)
		if self._scroll_value then
			self._scroll_value = 0
		end

		local var_8_0 = self._control.scrollview_1

		if arg_8_1 == 1 then
			self._control.remould_btn.remould_txt.text.text = var_0_1:getNowLang("pvebattletype1")

			var_8_0:SetActive(true)

			self._scroll_value = self._control.scrollview_2.scrollbarvertical.scrollbar.value
			var_8_0.scrollbarvertical.scrollbar.value = self._scroll_value

			self._control.scrollview_2:SetActive(false)

			self._now_label = 1
		else
			self._control.remould_btn.remould_txt.text.text = var_0_1:getNowLang("remake")

			var_8_0:SetActive(true)
			self._control.scrollview_2:SetActive(true)

			self._scroll_value = var_8_0.scrollbarvertical.scrollbar.value
			self._control.scrollview_2.scrollbarvertical.scrollbar.value = self._scroll_value

			var_8_0:SetActive(false)

			self._now_label = 2
		end
	end

	function arg_1_0:get_own_type_select()
		return self._own_data_select or "all"
	end

	function arg_1_0:show_sort_layer(arg_10_1)
		self._control.type_layer:SetActive(arg_10_1)
	end

	function arg_1_0:get_cell_by_now_lable()
		local var_11_0

		var_11_0 = self._now_label == 1 and self._reusable_cell_1 or self._now_label == 2 and self._reusable_cell_2 or var_11_0

		return var_11_0
	end

	function arg_1_0:init_cell()
		if not self._reusable_cell_1 then
			self._reusable_cell_1 = gamecore.reusable_cell:create(self, self._control.scrollview_1.viewport.content.endlessScrollView, self._control.scrollview_1.viewport.content, "single_ship_map", "ship_map")

			self._reusable_cell_1:init()
		end

		if not self._reusable_cell_2 then
			self._reusable_cell_2 = gamecore.reusable_cell:create(self, self._control.scrollview_2.viewport.content.endlessScrollView, self._control.scrollview_2.viewport.content, "single_ship_map", "ship_map")

			self._reusable_cell_2:init()
		end
	end

	function arg_1_0:get_new_ship_list(arg_13_1)
		local var_13_0 = self:_now_ship_num()
		local var_13_1 = {}
		local var_13_2 = {}

		for iter_13_0, iter_13_1 in ipairs((var_0_10:get_cardbook_ship_list())) do
			var_13_2[iter_13_1.id] = true
		end

		for iter_13_2, iter_13_3 in ipairs(arg_13_1) do
			local var_13_3 = iter_13_3

			function check_type()
				if var_0_6.dict_lenght(self._type_toggle_data) < 2 then
					return true
				end

				local var_14_0 = false

				for iter_14_0, iter_14_1 in pairs(self._type_toggle_data) do
					if iter_14_0 == "CLT" then
						for iter_14_2, iter_14_3 in pairs(var_0_4.filter_type[iter_14_0]) do
							if iter_14_3 == var_13_3.type then
								var_14_0 = true

								break
							end
						end
					elseif var_0_4.filter_type[iter_14_0] == var_13_3.type then
						var_14_0 = true
					end

					if var_14_0 then
						break
					end
				end

				return var_14_0
			end

			function check_country()
				if var_0_6.dict_lenght(self._country_toggle_data) < 2 then
					return true
				end

				local var_15_0 = false

				for iter_15_0, iter_15_1 in pairs(self._country_toggle_data) do
					if iter_15_0 == "other_country" then
						for iter_15_2, iter_15_3 in pairs(var_0_4.filter_country[iter_15_0]) do
							if iter_15_3 == var_13_3.country then
								var_15_0 = true

								break
							end
						end
					elseif var_0_4.filter_country[iter_15_0] == var_13_3.country then
						var_15_0 = true
					end

					if var_15_0 then
						break
					end
				end

				return var_15_0
			end

			local var_13_4 = false

			if self._country_toggle_data.all == true then
				var_13_4 = self._type_toggle_data.all == true and true or check_type()
			elseif check_country() then
				var_13_4 = self._type_toggle_data.all == true and true or check_type()
			end

			local var_13_5 = false

			if self:get_own_type_select() ~= "all" then
				local var_13_6 = var_13_2[var_13_3.cid] == true

				if self:get_own_type_select() == "own_type" and var_13_6 == true and var_13_3.release then
					var_13_5 = true
				elseif self:get_own_type_select() == "not_own_type" and var_13_6 == false and var_13_3.release then
					var_13_5 = true
				elseif self:get_own_type_select() == "not_get_type" and var_13_6 == true and var_13_3.release then
					if self._now_label == 1 and not var_0_10:find_character_by_cid(var_13_3.cid) and not var_0_10:find_character_by_cid(var_13_3.evo_to_cid) then
						var_13_5 = true
					elseif self._now_label == 2 and not var_0_10:find_character_by_cid(var_13_3.cid) then
						var_13_5 = true
					end
				end
			else
				var_13_5 = true
			end

			if not var_13_4 or var_13_0 <= #var_13_1 then
				-- block empty
			elseif var_13_5 then
				var_0_7(var_13_1, var_13_3)
			end
		end

		return var_13_1
	end

	function arg_1_0._now_ship_num(arg_16_0)
		local var_16_0, var_16_1 = var_0_3:get_sequence()
		local var_16_2 = 1

		for iter_16_0, iter_16_1 in ipairs(var_16_0) do
			if tonumber(string.sub(iter_16_1.cid, 7)) ~= 19 and tonumber(string.sub(iter_16_1.cid, 7)) ~= 18 and tonumber(iter_16_1.pic_id) > 0 and tonumber(iter_16_1.pic_id) < 8038 and iter_16_1.title ~= var_0_1:getNowLang("shiptypedetail98") and iter_16_1.evo_class then
				var_16_2 = var_16_2 + 1
			end
		end

		if var_16_2 % 8 ~= 0 then
			return (math.floor(var_16_2 / 8) + 1) * 8
		end

		return var_16_2
	end

	function arg_1_0:init_general_cell_list()
		local var_17_0 = var_0_10:get_cardbook_ship_list()
		local var_17_1, var_17_2 = var_0_3:get_sequence()
		local var_17_3 = {}
		local var_17_4 = {}
		local var_17_5 = self:_now_ship_num()

		for iter_17_0, iter_17_1 in ipairs(var_17_1) do
			if tonumber(string.sub(iter_17_1.cid, 7)) ~= 19 and tonumber(string.sub(iter_17_1.cid, 7)) ~= 18 and (tonumber(iter_17_1.pic_id) > 0 and tonumber(iter_17_1.pic_id) < var_17_5 + 1 or tonumber(iter_17_1.pic_id) > 1000 and tonumber(iter_17_1.pic_id) < 1000 + var_17_5 + 1 and tonumber(string.sub(iter_17_1.cid, 7)) ~= 19 and tonumber(string.sub(iter_17_1.cid, 7)) ~= 18) then
				if iter_17_1.evo_class then
					if self._is_limit_release and iter_17_1.release then
						var_0_7(var_17_4, iter_17_1)
					elseif not self._is_limit_release then
						var_0_7(var_17_4, iter_17_1)
					end
				elseif self._is_limit_release and iter_17_1.release then
					var_0_7(var_17_3, iter_17_1)
				elseif not self._is_limit_release then
					var_0_7(var_17_3, iter_17_1)
				end
			end
		end

		if self._now_label == 1 then
			var_17_3 = self:__filter_table_by_name(var_17_3)
		elseif self._now_label == 2 then
			var_17_3 = self:__filter_table_by_name(var_17_4)
		end

		local var_17_6 = self:get_new_ship_list(var_17_3)
		local var_17_7 = self:get_cell_by_now_lable()
		local var_17_8 = self._now_label == 1 and var_17_6 or self:get_new_ship_list(var_17_4)

		if self._now_label == 2 and type(self._filter_name) == "string" then
			var_17_8 = var_17_6
		end

		var_17_7:set_data(var_17_8)

		function var_17_7:_set_func(arg_18_1)
			local var_18_0 = var_17_8[arg_18_1 + 1]
			local var_18_1 = false

			for iter_18_0, iter_18_1 in ipairs(var_17_0) do
				if iter_18_1.id == var_17_8[arg_18_1 + 1].cid then
					var_18_1 = true

					break
				end
			end

			if var_17_8[arg_18_1 + 1].release == true then
				local var_18_2 = self.all_layer.icon_layer

				self.all_layer.icon_layer.image.sprite = self:loadSprite(var_0_4.ship_quality_s[var_17_8[arg_18_1 + 1].star])
				var_18_2.icon.image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.ship_icon.model_normal_xm, var_17_8[arg_18_1 + 1].pic_id, var_17_8[arg_18_1 + 1].pic_id))
				self.all_layer.info_layer.type_txt.text.text = var_0_1:getNowLang(var_0_4:get_ship_type_language_key(var_17_8[arg_18_1 + 1].type, 1))
				self.all_layer.info_layer.country_txt.text.text = var_0_5("(%s)", var_0_1:getNowLang(var_0_4:get_country_language_key(var_17_8[arg_18_1 + 1].country)))

				self:__set_level(self, var_17_8[arg_18_1 + 1].star, var_17_8[arg_18_1 + 1])

				self.all_layer.info_layer.name_level.name_level_1.text.text = var_17_8[arg_18_1 + 1].title

				self.all_layer.info_layer.name_level.textHorizonScroller:SetText(var_17_8[arg_18_1 + 1].title)
				var_18_2.ship_remake:SetActive(false)

				if var_18_1 then
					local var_18_4 = {}

					if #var_17_8[arg_18_1 + 1].skins > 0 then
						for iter_18_2, iter_18_3 in ipairs(var_17_8[arg_18_1 + 1].skins) do
							var_0_7(var_18_4, iter_18_3)
						end

						for iter_18_4, iter_18_5 in ipairs(var_18_4) do
							if (iter_18_5 - 1000000000) % 10000 % 1000 / 100 < 0.9 then
								var_0_11(var_18_4, iter_18_4)
							end
						end
					end

					var_18_2.clothes_bg:SetActive(#var_18_4 > 0)

					var_18_2.clothes_bg.clothes_num_txt.text.text = "x" .. #var_18_4

					self.all_layer.icon_layer.icon_not_get:SetActive(false)
					self:__show_by_state(self, 3)
				else
					self.not_get_bg.txt.text.text = var_0_1:getNowLang("medaltypeungain")

					self.all_layer.icon_layer.icon_not_get:SetActive(true)
					var_18_2.clothes_bg:SetActive(false)
					self:__show_by_state(self, 2)
				end

				self.all_layer.button.onClick:RemoveAllListeners()
				self.all_layer.button.onClick:AddListener(function()
					if var_18_0.release == true then
						if self:__have_data(var_17_0, var_18_0.cid) then
							self:setVisible(false)

							self._now_click_ship_data = var_18_0

							var_0_2:createInstance("ship_detail"):show(var_0_4.enter_ship_detail_type.ship_map, self._now_click_ship_data, nil, nil, self._now_label, var_18_1)
						else
							local var_19_0 = var_0_2:getInstance("msgbox_map")

							if var_19_0 then
								var_19_0:show(var_18_0, self._now_label)
							else
								var_0_2:createInstance("msgbox_map"):show(var_18_0, self._now_label)
							end
						end
					end
				end)
			else
				self.not_open_bg.txt.text.text = var_0_1:getNowLang("shipnotopen")

				self:__show_by_state(self, 1)
			end
		end
	end

	function arg_1_0.__have_data(arg_20_0, arg_20_1, arg_20_2)
		local var_20_0 = false

		if next(arg_20_1) then
			for iter_20_0, iter_20_1 in pairs(arg_20_1) do
				if iter_20_1.id == arg_20_2 then
					var_20_0 = true

					return true
				end
			end
		end

		return var_20_0
	end

	function arg_1_0:__init_language()
		self._control.top.title_txt.text.text = var_0_1:getNowLang("ui_collectionship")
		self._control.remould_btn.remould.text.text = var_0_1:getNowLang("filterlabel")
		self._control.type_btn.type.text.text = var_0_1:getNowLang("type")
		self._control.type_btn.type_txt.text.text = var_0_1:getNowLang("equip0")
		self._control.type_layer.bg.filter_type.type_txt.text.text = var_0_1:getNowLang("type")
		self._control.type_layer.bg.btn_series.cancel_btn.cancel.text.text = var_0_1:getNowLang("cancel")
		self._control.type_layer.bg.btn_series.confirm_btn.confirm.text.text = var_0_1:getNowLang("confirm")

		for iter_21_0, iter_21_1 in ipairs({
			self._control.type_layer.bg.country_group.toggle_group.all,
			self._control.type_layer.bg.country_group.toggle_group.J_country,
			self._control.type_layer.bg.country_group.toggle_group.G_country,
			self._control.type_layer.bg.country_group.toggle_group.E_country,
			self._control.type_layer.bg.country_group.toggle_group.U_country,
			self._control.type_layer.bg.country_group.toggle_group.I_country,
			self._control.type_layer.bg.country_group.toggle_group.F_country,
			self._control.type_layer.bg.country_group.toggle_group.S_country,
			self._control.type_layer.bg.country_group.toggle_group.C_country,
			self._control.type_layer.bg.country_group.toggle_group.other_country
		}) do
			iter_21_1.Label.text.text = var_0_1:getNowLang("country" .. iter_21_0 - 1)
		end

		for iter_21_2, iter_21_3 in pairs(var_0_4.filter_type) do
			self._control.type_layer.bg.type_group.toggle_group[iter_21_2].Label.text.text = iter_21_2 == "CLT" and var_0_1:getNowLang("shiptype9") or var_0_1:getNowLang(string.format("shiptype%s", iter_21_3))
		end

		self._control.type_layer.bg.size_group.toggle_group.all.Label.text.text = var_0_1:getNowLang("shipbigtype0")
		self._control.type_layer.bg.size_group.toggle_group.large.Label.text.text = var_0_1:getNowLang("shipbigtype1")
		self._control.type_layer.bg.size_group.toggle_group.middle.Label.text.text = var_0_1:getNowLang("shipbigtype2")
		self._control.type_layer.bg.size_group.toggle_group.small.Label.text.text = var_0_1:getNowLang("shipbigtype3")
		self._control.type_layer.bg.size_group.toggle_group.maip.Label.text.text = var_0_1:getNowLang("guard_type1")
		self._control.type_layer.bg.size_group.toggle_group.protect.Label.text.text = var_0_1:getNowLang("guard_type2")
		self._control.type_layer.bg.own_group.toggle_group.all.Label.text.text = var_0_1:getNowLang("shipbigtype0")
		self._control.type_layer.bg.own_group.toggle_group.not_own_type.Label.text.text = var_0_1:getNowLang("medaltypeungain")
		self._control.type_layer.bg.own_group.toggle_group.not_get_type.Label.text.text = var_0_1:getNowLang("nothave")

		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.bg.own_group.toggle_group.own_type.Label_mask, var_0_1:getNowLang("medaltypegain"))

		if gamecore.util_func.check_channel_is_en() then
			self._control.type_layer.bg.btn_series.confirm_btn.confirm_mask.rectTransform.anchoredPosition = Vector2(-73, 49)
			self._control.type_layer.bg.btn_series.cancel_btn.cancel.rectTransform.anchoredPosition = Vector2(-80, 49)
		end
	end

	function arg_1_0:__init_panel()
		self:__init_filter_type_list()

		if not self._is_already_init then
			self:__init_language()
		end

		self:__clear_input_field_name()
		self:show_sort_layer(false)
		self:show_scroll_by_index(1)
		self:__set_inputField_info()
		self:init_cell()
		self:init_general_cell_list()

		self._own_btn_count = {}
		self._own_btn_count.own_type = 0
		self._own_btn_count.not_own_type = 0
		self._own_btn_count.not_get_type = 0

		self:__onToggle_type_layer_bg_own_group_toggle_group_all()

		if self._toggle_own_group then
			self._control.type_layer.bg.own_group.toggle_group.own_type.toggle.isOn = false
			self._control.type_layer.bg.own_group.toggle_group.not_own_type.toggle.isOn = false
			self._control.type_layer.bg.own_group.toggle_group.all.toggle.isOn = true
		end

		self:play_in_out_animation(true)
	end

	function arg_1_0:__init_filter_type_list()
		self._toggle_country_group = {
			all = self._control.type_layer.bg.country_group.toggle_group.all,
			C_country = self._control.type_layer.bg.country_group.toggle_group.C_country,
			E_country = self._control.type_layer.bg.country_group.toggle_group.E_country,
			F_country = self._control.type_layer.bg.country_group.toggle_group.F_country,
			G_country = self._control.type_layer.bg.country_group.toggle_group.G_country,
			I_country = self._control.type_layer.bg.country_group.toggle_group.I_country,
			J_country = self._control.type_layer.bg.country_group.toggle_group.J_country,
			S_country = self._control.type_layer.bg.country_group.toggle_group.S_country,
			U_country = self._control.type_layer.bg.country_group.toggle_group.U_country,
			other_country = self._control.type_layer.bg.country_group.toggle_group.other_country
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
			all = self._control.type_layer.bg.type_group.toggle_group.all,
			CV = self._control.type_layer.bg.type_group.toggle_group.CV,
			CVL = self._control.type_layer.bg.type_group.toggle_group.CVL,
			AV = self._control.type_layer.bg.type_group.toggle_group.AV,
			BB = self._control.type_layer.bg.type_group.toggle_group.BB,
			BBV = self._control.type_layer.bg.type_group.toggle_group.BBV,
			BC = self._control.type_layer.bg.type_group.toggle_group.BC,
			CA = self._control.type_layer.bg.type_group.toggle_group.CA,
			CAV = self._control.type_layer.bg.type_group.toggle_group.CAV,
			CLT = self._control.type_layer.bg.type_group.toggle_group.CLT,
			CL = self._control.type_layer.bg.type_group.toggle_group.CL,
			BM = self._control.type_layer.bg.type_group.toggle_group.BM,
			DD = self._control.type_layer.bg.type_group.toggle_group.DD,
			SSG = self._control.type_layer.bg.type_group.toggle_group.SSG,
			SS = self._control.type_layer.bg.type_group.toggle_group.SS,
			SC = self._control.type_layer.bg.type_group.toggle_group.SC,
			AP = self._control.type_layer.bg.type_group.toggle_group.AP,
			ASDG = self._control.type_layer.bg.type_group.toggle_group.ASDG,
			AADG = self._control.type_layer.bg.type_group.toggle_group.AADG,
			KP = self._control.type_layer.bg.type_group.toggle_group.KP,
			CG = self._control.type_layer.bg.type_group.toggle_group.CG,
			CBG = self._control.type_layer.bg.type_group.toggle_group.CBG,
			BBG = self._control.type_layer.bg.type_group.toggle_group.BBG,
			BG = self._control.type_layer.bg.type_group.toggle_group.BG
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
			"ASDG",
			"AADG",
			"KP",
			"CG",
			"CBG",
			"BBG",
			"BG"
		}, self._toggle_type_group)
		self._toggle_size_group = {
			all = self._control.type_layer.bg.size_group.toggle_group.all,
			large = self._control.type_layer.bg.size_group.toggle_group.large,
			middle = self._control.type_layer.bg.size_group.toggle_group.middle,
			small = self._control.type_layer.bg.size_group.toggle_group.small,
			maip = self._control.type_layer.bg.size_group.toggle_group.maip,
			protect = self._control.type_layer.bg.size_group.toggle_group.protect
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
		self._toggle_own_group = {
			all = self._control.type_layer.bg.own_group.toggle_group.all,
			own_type = self._control.type_layer.bg.own_group.toggle_group.own_type,
			not_own_type = self._control.type_layer.bg.own_group.toggle_group.not_own_type,
			not_get_type = self._control.type_layer.bg.own_group.toggle_group.not_get_type
		}
	end

	function arg_1_0.__show_by_state(arg_24_0, arg_24_1, arg_24_2)
		local var_24_0 = {
			arg_24_1.not_open_bg,
			arg_24_1.not_get_bg,
			arg_24_1.all_layer
		}

		for iter_24_0 = 1, #var_24_0 do
			var_24_0[iter_24_0]:SetActive(false)
		end

		if arg_24_2 == 1 then
			var_24_0[arg_24_2]:SetActive(true)
		elseif arg_24_2 == 2 then
			var_24_0[arg_24_2]:SetActive(true)
			var_24_0[arg_24_2 + 1]:SetActive(true)
		elseif arg_24_2 == 3 then
			var_24_0[arg_24_2]:SetActive(true)
		end
	end

	function arg_1_0.__set_level(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
		arg_25_1.all_layer.level_layer.level_txt.text.text = var_0_5("/%04d/", arg_25_3.pic_id)

		local var_25_1 = {
			arg_25_1.all_layer.level_layer.star_layer.star_1,
			arg_25_1.all_layer.level_layer.star_layer.star_2,
			arg_25_1.all_layer.level_layer.star_layer.star_3,
			arg_25_1.all_layer.level_layer.star_layer.star_4,
			arg_25_1.all_layer.level_layer.star_layer.star_5,
			arg_25_1.all_layer.level_layer.star_layer.star_6,
			arg_25_1.all_layer.level_layer.star_layer.star_7
		}

		for iter_25_0 = 1, arg_25_1.all_layer.level_layer.star_layer.transform.childCount do
			if iter_25_0 <= arg_25_2 then
				var_25_1[iter_25_0].gameObject:SetActive(true)
			else
				var_25_1[iter_25_0].gameObject:SetActive(false)
			end
		end
	end

	function arg_1_0:_play_into_se(arg_26_1)
		self:playSE(arg_26_1, false)
	end

	function arg_1_0:__clear_input_field_name()
		self._filter_name = nil
		self._control.search.inputField.text = ""
	end

	function arg_1_0:__set_inputField_info()
		self._control.search.inputField.onEndEdit:AddListener(function()
			if self._control.search.inputField.text ~= "" then
				self._filter_name = self._control.search.inputField.text

				local var_29_0, var_29_1 = var_0_12(self._filter_name, "%(")

				if var_29_0 ~= nil and var_29_1 ~= nil then
					self._filter_name = var_0_6._str_insert(self._filter_name, var_29_0, "%")
				end

				self:init_cell()
				self:init_general_cell_list()
			end
		end)
	end

	function arg_1_0:__filter_table_by_name(arg_30_1)
		local var_30_0 = {}

		if not self._filter_name then
			return arg_30_1
		end

		local var_30_1 = var_0_6.little_clone(arg_30_1)
		local var_30_2 = {}

		if self._filter_name and next(var_30_1) then
			for iter_30_0, iter_30_1 in pairs(var_30_1) do
				if iter_30_1.release == true then
					var_0_7(var_30_2, iter_30_1)
				end
			end
		end

		local var_30_3, var_30_4 = var_0_12(self._filter_name, "%(")

		if var_30_3 ~= nil and var_30_4 ~= nil then
			self._filter_name = var_0_6._str_insert(self._filter_name, var_30_3, "%")
		end

		local var_30_5, var_30_6 = var_0_12(self._filter_name, "%%")

		if var_30_5 ~= nil and var_30_6 ~= nil then
			self._filter_name = var_0_6._str_insert(self._filter_name, var_30_5, "%")
		end

		local var_30_7, var_30_8 = var_0_12(self._filter_name, "%[")

		if var_30_7 ~= nil and var_30_8 ~= nil then
			self._filter_name = var_0_6._str_insert(self._filter_name, var_30_7, "%")
		end

		local var_30_9, var_30_10 = var_0_12(self._filter_name, "%]")

		if var_30_9 ~= nil and var_30_10 ~= nil then
			self._filter_name = var_0_6._str_insert(self._filter_name, var_30_9, "%")
		end

		local var_30_11, var_30_12 = var_0_12(self._filter_name, "%-")

		if var_30_11 ~= nil and var_30_12 ~= nil then
			self._filter_name = var_0_6._str_insert(self._filter_name, var_30_11, "%")
		end

		for iter_30_2, iter_30_3 in pairs(var_30_2) do
			if var_0_6.name_filter_match(iter_30_3.title, self._filter_name) then
				var_0_7(var_30_0, iter_30_3)
			end
		end

		return var_30_0
	end

	function arg_1_0:__onReset()
		if self._toggle_type_group then
			self._toggle_type_group.all.toggle.isOn = true
		end

		if self._toggle_country_group then
			self._toggle_country_group.all.toggle.isOn = true
		end

		if self._toggle_own_group then
			self._toggle_own_group.all.toggle.isOn = true
		end

		if self._toggle_size_group then
			self._toggle_size_group.all.toggle.isOn = true
		end

		if self._toggle_country_group_obj then
			self._toggle_country_group_obj:toggleOn("all", self._toggle_country_group.all.toggle.isOn)
		end

		if self._toggle_type_group_obj then
			self._toggle_type_group_obj:toggleOn("all", self._toggle_type_group.all.toggle.isOn)
		end

		self._is_already_init = false
		self._now_label = nil
		self._toggle_country_group_obj = nil
		self._toggle_country_group = nil
		self._toggle_size_group_obj = nil
		self._toggle_size_group = nil
		self._toggle_type_group_obj = nil
		self._toggle_type_group = nil
		self._toggle_own_group = nil
		self._now_click_ship_data = nil
		self._is_limit_release = false
		self._scroll_value = nil
		self._control.scrollview_1.viewport.content.rectTransform.anchoredPosition = Vector2(0, 0)
		self._control.scrollview_1.scrollbarvertical.scrollbar.value = 1
		self._control.scrollview_2.viewport.content.rectTransform.anchoredPosition = Vector2(0, 0)
		self._control.scrollview_2.scrollbarvertical.scrollbar.value = 1
		self._first_into = false
		self._country_toggle_data = {
			all = true
		}
		self._type_toggle_data = {
			all = true
		}
		self._need_revert = false
		self._filter_name = nil
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_32_0)
	local var_32_0 = var_0_2:class("ship_map")

	var_32_0._is_already_init = false
	var_32_0._reusable_cell_1 = nil
	var_32_0._reusable_cell_2 = nil
	var_32_0._now_label = nil
	var_32_0._toggle_country_group_obj = nil
	var_32_0._toggle_country_group = nil
	var_32_0._toggle_size_group_obj = nil
	var_32_0._toggle_type_group_obj = nil
	var_32_0._toggle_type_group = nil
	var_32_0._toggle_size_group = nil
	var_32_0._toggle_own_group_obj = nil
	var_32_0._toggle_own_group = nil
	var_32_0._country_toggle_data = {
		all = true
	}
	var_32_0._type_toggle_data = {
		all = true
	}
	var_32_0._now_click_ship_data = nil
	var_32_0._first_into = false
	var_32_0._is_limit_release = false
	var_32_0._own_data_select = nil
	var_32_0._own_btn_count = nil
	var_32_0._old_own_data_select = nil
	var_32_0._filter_name = nil

	gamecore.extend_obj(var_32_0)

	return var_32_0
end

return var_0_0
