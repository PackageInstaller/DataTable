local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = gameenum.common_type
local var_0_5 = table.insert
local var_0_6 = gameconfig.ship_config
local var_0_7 = gameconfig.skin_config
local var_0_8 = string.format
local var_0_9 = math.ceil
local var_0_10 = gamecore.util_func
local var_0_12 = gamecore.prompt
local var_0_13 = DG.Tweening.DOTween
local var_0_14 = math.sqrt
local var_0_15 = gameconfig.bathhouse_config
local var_0_16 = gameconfig.workshop_config
local var_0_17 = table.sort

gamecore.UILoader:define("bathroom_repair", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)

		local var_2_0 = var_0_2:getInstance("bathroom")

		if var_2_0 then
			var_2_0._panel.transform:GetComponent("Canvas").sortingOrder = self._panel.transform:GetComponent("Canvas").sortingOrder - 1
			self._panel.transform:GetComponent("Canvas").sortingOrder = self._panel.transform:GetComponent("Canvas").sortingOrder + 1
		end

		self:__init_panel()
		self:_set_stop_bathroom_mouse()
	end

	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0:_set_stop_bathroom_mouse()
		self._open_bathroom_rubdown = var_0_2:getInstance("bathroom")

		if self._open_bathroom_rubdown then
			self._open_bathroom_rubdown._allow_mouse_move = false
			self._open_bathroom_rubdown._room_end_pos = nil
			self._open_bathroom_rubdown._room_start_pos = nil
		end
	end

	function arg_1_0:get_guide_btn_pos_info(arg_5_1)
		if arg_5_1 == var_0_4.guide_const_id.third_group.four then
			return self._record_btn
		end
	end

	function arg_1_0.__get_repair_need_consume(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0 = var_0_6.find_object_by_cid(arg_6_1.cid)
		local var_6_1 = 0
		local var_6_2 = 0
		local var_6_3 = 0
		local var_6_5 = 1

		for iter_6_0, iter_6_1 in pairs((var_0_3:get_bathroom_style())) do
			var_6_5 = var_6_5 * var_0_15.find_object_by_id(iter_6_1).effect.res
		end

		if arg_6_1.hp - arg_6_1.now_hp > 0 then
			var_6_1 = var_0_9((arg_6_1.hp - arg_6_1.now_hp) * var_6_0.repair_oil_modulus * var_6_5)
			var_6_2 = var_0_9((arg_6_1.hp - arg_6_1.now_hp) * var_6_0.repair_steel_modulus * var_6_5)
			var_6_3 = arg_6_2 and 1 or 0
		end

		return {
			oil_need = var_6_1,
			fe_need = var_6_2,
			repair_item_need = var_6_3
		}
	end

	function arg_1_0.__set_work_buff_reduce(arg_7_0, arg_7_1)
		local var_7_0 = 0

		for iter_7_0, iter_7_1 in pairs((var_0_3:get_workshop_data())) do
			local var_7_1 = var_0_16.find_object_by_id(iter_7_1.id).effect[1]

			if var_7_1.type == var_0_4.workshop_const.work_type.reduce_repair_time and arg_7_1 == var_7_1.shipTypes[1] then
				var_7_0 = var_7_1.num

				return var_7_1.num
			end
		end

		return var_7_0
	end

	function arg_1_0:__get_repair_need_time(arg_8_1)
		local var_8_0 = self:__set_formation_type_layer(var_0_6.find_object_by_cid(arg_8_1.cid), arg_8_1)
		local var_8_1 = var_8_0.hp_max - arg_8_1.now_hp
		local var_8_2 = var_0_9((var_8_0.hp_max - arg_8_1.now_hp) * var_8_0.repair_oil_modulus)
		local var_8_3 = var_0_9((var_8_0.hp_max - arg_8_1.now_hp) * var_8_0.repair_steel_modulus)
		local var_8_5 = 1
		local var_8_6 = 1
		local var_8_7 = arg_8_1.level <= 11 and 0 or var_0_14(arg_8_1.level - 11) * 10 + 50

		if arg_8_1.marry then
			var_8_6 = var_8_6 * var_0_4.bathroom_const.repair_marry_reduce
		end

		for iter_8_0, iter_8_1 in pairs((var_0_3:get_bathroom_style())) do
			var_8_5 = var_8_5 * var_0_15.find_object_by_id(iter_8_1).effect.time
		end

		local var_8_8 = self:__set_work_buff_reduce(var_8_0.type)
		local var_8_9 = 1

		if var_8_8 ~= 0 then
			var_8_9 = var_8_9 - var_8_8 / 100
		end

		return (var_0_9(var_0_9(var_0_9(var_0_9((arg_8_1.level * 5 + var_8_7) * var_8_0.repair_time * var_8_1 + 30) * var_8_6) * var_8_9) * var_8_5))
	end

	function arg_1_0:__get_repair_list(arg_9_1)
		local var_9_0 = {}

		for iter_9_0, iter_9_1 in ipairs((self:get_repair_ship_list(arg_9_1))) do
			if iter_9_1.state ~= var_0_4.ship_state.expedition then
				if iter_9_1.state == var_0_4.ship_state.free or iter_9_1.state == var_0_4.ship_state.expedition then
					var_0_5(var_9_0, iter_9_1)
				end

				if arg_9_1 and iter_9_1.state == var_0_4.ship_state.repair then
					var_0_5(var_9_0, iter_9_1)
				end
			end
		end

		return var_9_0
	end

	function arg_1_0.__can_repaired(arg_10_0)
		local var_10_0 = false
		local var_10_1 = var_0_2:getInstance("bathroom")

		var_10_1:_now_room_info()

		local var_10_2 = {}

		var_10_2[#var_10_2 + 1] = var_10_1._all_ship_data.one_room
		var_10_2[#var_10_2 + 1] = var_10_1._all_ship_data.two_room
		var_10_2[#var_10_2 + 1] = var_10_1._all_ship_data.three_room

		local var_10_3 = var_10_1._all_ship_data.one_room

		if var_10_1._now_room_num == 2 then
			var_10_3 = var_10_1._all_ship_data.two_room
		elseif var_10_1._now_room_num == 3 then
			var_10_3 = var_10_1._all_ship_data.three_room
		end

		for iter_10_0, iter_10_1 in pairs(var_10_3) do
			if iter_10_1.available and iter_10_1.state == var_0_4.pool_state.free then
				var_10_0 = true

				break
			end
		end

		arg_10_0._room_id = var_10_1._now_room_num

		if not var_10_0 then
			for iter_10_2, iter_10_3 in ipairs(var_10_2) do
				if var_10_1._now_room_num ~= iter_10_2 and not var_10_0 then
					for iter_10_4, iter_10_5 in pairs(iter_10_3) do
						if iter_10_5.available and iter_10_5.state == var_0_4.pool_state.free then
							var_10_0 = true
							arg_10_0._room_id = iter_10_2

							break
						end
					end
				end
			end
		end

		return var_10_0
	end

	function arg_1_0:__set_all_repair_layer(arg_11_1, arg_11_2)
		local var_11_0 = 0
		local var_11_1 = 0
		local var_11_2 = 0

		for iter_11_0, iter_11_1 in pairs(arg_11_1) do
			if iter_11_1.state == var_0_4.ship_state.repair then
				-- block empty
			else
				local var_11_3 = self:__get_repair_need_consume(iter_11_1, arg_11_2)

				var_11_0 = var_11_0 + var_11_3.oil_need
				var_11_1 = var_11_1 + var_11_3.fe_need
			end
		end

		var_11_2 = arg_11_2 and #arg_11_1 or 0

		local var_11_4 = self._control.all_repair_layer.info

		self._control.all_repair_layer.info.oil.oil_num_txt.text.text = tostring(var_11_0)
		var_11_4.steel.steel_num_txt.text.text = tostring(var_11_1)
		var_11_4.fast_repair.fast_repair_num_txt.text.text = var_11_2 .. "/" .. var_0_3:get_fast_item_count()

		return {
			enough_oil = var_11_0 <= self._user_data.oil,
			enough_fe = var_11_1 <= self._user_data.fe,
			enough_repair_item = var_11_2 <= var_0_3:get_fast_item_count()
		}
	end

	function arg_1_0:__can_repair(arg_12_1, arg_12_2)
		local var_12_0 = self:__set_all_repair_layer(arg_12_1, arg_12_2)

		self._enough_repair_item = false

		if not var_12_0.enough_oil then
			var_0_12:show(var_0_1:getNowLang("oilnotenough"))

			return false
		end

		if not var_12_0.enough_fe then
			self._enough_fe = true

			var_0_12:show(var_0_1:getNowLang("steelnotenough"))

			return false
		end

		if not var_12_0.enough_repair_item then
			self._enough_repair_item = true

			var_0_12:show(var_0_1:getNowLang("quick_item_not_enough"))

			return false
		end

		return true
	end

	function arg_1_0:__init_rank_list()
		self._reusable_cell = gamecore.reusable_cell:create(self, self._control.scrollview.viewport.content.endlessScrollView, self._control.scrollview.viewport.content, "single_repair_ship", "bathroom_repair")

		self._reusable_cell:init()
	end

	function arg_1_0.__set_level(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
		arg_14_1.all_layer.level_layer.level_txt.text.color = arg_14_2.level < 110 and Color.New(1, 1, 1) or Color.New(0.996078431372549, 0.9882352941176471, 0)
		arg_14_1.all_layer.level_layer.level_txt.text.text = var_0_8("Lv.%d", arg_14_2.level)

		for iter_14_0 = 1, arg_14_1.all_layer.level_layer.star_layer.transform.childCount do
			if iter_14_0 <= arg_14_3.star then
				arg_14_1.all_layer.level_layer.star_layer.transform:GetChild(iter_14_0 - 1).gameObject:SetActive(true)
			else
				arg_14_1.all_layer.level_layer.star_layer.transform:GetChild(iter_14_0 - 1).gameObject:SetActive(false)
			end
		end
	end

	function arg_1_0.__set_team_id(arg_15_0, arg_15_1, arg_15_2)
		local var_15_0 = var_0_3:get_team_index_by_id(1, arg_15_2.id)

		if var_15_0 and var_15_0 ~= 0 then
			arg_15_1.team_id_info:SetActive(true)

			arg_15_1.team_id_info.team_id.text.text = var_15_0
		else
			arg_15_1.team_id_info:SetActive(false)
		end
	end

	function arg_1_0:__set_ship_info(arg_16_1, arg_16_2)
		local var_16_0 = self:__set_formation_type_layer(var_0_6.find_object_by_cid(arg_16_2.cid), arg_16_2)
		local var_16_1 = var_16_0.pic_id

		if arg_16_2.skin ~= 0 then
			var_16_1 = var_0_7.find_object_by_cid(arg_16_2.skin).icon
		end

		arg_16_2.hp = var_16_0.hp_max
		arg_16_1.all_layer.icon_layer.icon.image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_10:use_big_break_painting(arg_16_2, var_0_4.ship_icon_type.model_m, true), var_16_1))
		arg_16_1.all_layer.icon_layer.image.sprite = self:loadSprite(var_0_4.ship_quality_frame[arg_16_2.star])
		arg_16_1.all_layer.love_layer.love.image.sprite = self:loadSprite(var_0_4:get_love_path(arg_16_2))

		self:__set_team_id(arg_16_1, arg_16_2)

		arg_16_1.all_layer.level_layer.type_txt.text.text = var_0_1:getNowLang(var_0_4:get_ship_type_language_key(var_16_0.type, 1))
		arg_16_1.all_layer.level_layer.country_txt.text.text = var_0_8("(%s)", var_0_1:getNowLang(var_0_4:get_country_language_key(var_16_0.country)))

		self:__set_level(arg_16_1, arg_16_2, var_16_0)

		arg_16_1.all_layer.hp_layer.hp_num.text.text = var_0_8("%d/%d", arg_16_2.now_hp, var_16_0.hp_max)

		local var_16_2 = var_0_4.ship_hp_slider.ship_hp_l_green
		local var_16_3 = arg_16_2.now_hp / var_16_0.hp_max

		if arg_16_2.now_hp / var_16_0.hp_max >= 0.25 and var_16_3 < 0.5 then
			var_16_2 = var_0_4.ship_hp_slider.ship_hp_l_yellow
		elseif var_16_3 < 0.25 then
			var_16_2 = var_0_4.ship_hp_slider.ship_hp_l_red
		end

		arg_16_1.all_layer.hp_layer.full_img.image.sprite = self:loadSprite(var_16_2)
		arg_16_1.all_layer.hp_layer.full_img.image.fillAmount = var_16_3
		arg_16_1.all_layer.name_layer.name_dd.text.text = arg_16_2.name
		arg_16_1.all_layer.name_layer.name_level.text.text = var_0_8("/%s/", var_16_0.class_no)
	end

	function arg_1_0:__set_formation_type_layer(arg_17_1, arg_17_2)
		local var_17_1 = var_0_6.find_object_by_cid(arg_17_2.cid)
		local var_17_2 = self:__set_work_add(var_17_1, (var_0_10:get_ship_attr(var_0_3:find_character_by_id(arg_17_2.id), var_17_1)))

		if not arg_17_1 then
			return
		end

		local var_17_3 = var_0_10.little_clone(arg_17_1)

		var_17_3.hp_max = var_17_2.hp

		return var_17_3
	end

	function arg_1_0:__set_repair_consume(arg_18_1, arg_18_2)
		local var_18_0 = self:__get_repair_need_consume(arg_18_2, false)

		arg_18_1.all_layer.repair_type_layer.material_layer.oil.text.text = tostring(var_18_0.oil_need)
		arg_18_1.all_layer.repair_type_layer.material_layer.fe.text.text = tostring(var_18_0.fe_need)
		arg_18_1.all_layer.repair_type_layer.time_layer.title.text.text = var_0_1:getNowLang("ui_shiptip2")
		arg_18_1.all_layer.repair_type_layer.time_layer.time.text.text = var_0_10.secondsToTime(arg_18_2.repair_time)
	end

	function arg_1_0.__set_work_add(arg_19_0, arg_19_1, arg_19_2)
		for iter_19_0, iter_19_1 in pairs((var_0_3:get_workshop_data())) do
			local var_19_1
			local var_19_3 = var_0_16.find_object_by_id(iter_19_1.id)

			if var_19_3.pre_id ~= 0 then
				var_19_1 = var_0_16.find_object_by_id(var_19_3.pre_id)
			end

			local var_19_4 = var_19_3.effect[1]

			if var_19_4.shipTypes then
				for iter_19_2, iter_19_3 in pairs(var_19_4.shipTypes) do
					if var_19_4.shipTypes[iter_19_2] == arg_19_1.type then
						local var_19_6 = var_0_4:get_attr_name(var_19_4.num4)

						if (var_19_1 or nil) and var_19_1.effect[1] then
							-- block empty
						end

						if var_19_4.type == var_0_4.workshop_const.work_type.add_attribute then
							if var_19_4.countrys then
								for iter_19_4, iter_19_5 in pairs(var_19_4.countrys) do
									if iter_19_5 == arg_19_1.country and arg_19_2[var_19_6] then
										arg_19_2[var_19_6] = arg_19_2[var_19_6] + var_19_4.num
									end
								end
							end
						elseif var_19_4.type == var_0_4.workshop_const.work_type.add_torpedo_damage and arg_19_1[var_19_6] ~= 0 and arg_19_2[var_19_6] then
							arg_19_2[var_19_6] = arg_19_2[var_19_6] + var_19_4.num
						end
					end
				end
			end
		end

		return arg_19_2
	end

	function arg_1_0.__set_work_cut_down(arg_20_0, arg_20_1)
		for iter_20_0, iter_20_1 in pairs((var_0_3:get_workshop_data())) do
			local var_20_2 = var_0_16.find_object_by_id(iter_20_1.id)

			if var_20_2.pre_id ~= 0 then
				local var_20_3 = var_0_16.find_object_by_id(var_20_2.pre_id)
			end

			local var_20_4 = var_20_2.effect[1]

			if var_20_2.effect[1].shipTypes then
				for iter_20_2, iter_20_3 in pairs(var_20_4.shipTypes) do
					if var_20_4.shipTypes[iter_20_2] == arg_20_1.type then
						if var_20_4.type == var_0_4.workshop_const.work_type.reduce_repair_time and var_20_2.ship_type == arg_20_1.type and arg_20_1 ~= nil then
							arg_20_1.repair_time = arg_20_1.repair_time - arg_20_1.repair_time * var_20_4.num * 0.01
						end
					end
				end
			end
		end
	end

	function arg_1_0:__all_quick_repair()
		self._control.repair_spine_bg.repair_bg.repair_text.image.sprite = self:loadSprite(var_0_4.bathroom_repair.ship_repairing)

		self._control.all_repair_layer:SetActive(false)

		local var_21_0 = self:autoKillDOTween(var_0_13.Sequence())

		var_21_0:AppendCallback(function()
			self._control.repair_spine_bg:SetActive(true)
		end)
		var_21_0:AppendInterval(1.4)
		var_21_0:AppendCallback(function()
			self._control.repair_spine_bg:SetActive(false)

			local var_23_0 = {}

			for iter_23_0, iter_23_1 in pairs((self:__get_repair_list(true))) do
				var_0_5(var_23_0, iter_23_1.id)
			end

			if #var_23_0 > 0 then
				var_0_2:getInstance("bathroom")._is_all_fast_repair = true

				var_0_3:req_QuickRepairReq(var_23_0)
			end

			self._open_bathroom_rubdown._allow_mouse_move = true

			self:setVisible(false)
		end)
		var_21_0:Play()
	end

	function arg_1_0:__all_select_repair()
		local var_24_0 = self:__get_repair_list(false)
		local var_24_1 = self:__sort_ship_by_repair_time(var_24_0, true)

		self._repair_character_array = {}

		local var_24_2 = true
		local var_24_3 = true
		local var_24_4 = self:__get_repaired_room_id(var_24_0)
		local var_24_5 = 0
		local var_24_6 = 0

		for iter_24_0, iter_24_1 in pairs(var_24_0) do
			local var_24_7 = self:__get_repair_need_consume(iter_24_1, true)

			var_24_5 = var_24_5 + var_24_7.oil_need
			var_24_6 = var_24_6 + var_24_7.fe_need

			if var_24_5 > self._user_data.oil then
				var_24_2 = false
			elseif var_24_6 > self._user_data.fe then
				var_24_3 = false
			end
		end

		if var_24_1 and next(var_24_1) then
			if var_24_4 and next(var_24_4) and var_24_2 and var_24_3 then
				var_0_3:req_MultiShipRepairReq(var_24_4)
			else
				if not var_24_2 then
					var_0_12:show(var_0_1:getNowLang("oilnotenough"))
				elseif not var_24_3 then
					var_0_12:show(var_0_1:getNowLang("steelnotenough"))
				elseif self._enough_repair_item then
					var_0_12:show(var_0_1:getNowLang("quick_item_not_enough"))
				else
					var_0_12:show(var_0_1:getNowLang("errorcode_186"))
				end

				return
			end
		else
			var_0_12:show(var_0_1:getNowLang("no_need_repair"))

			return
		end
	end

	function arg_1_0:__get_repaired_room_id(arg_25_1)
		local var_25_0 = var_0_2:getInstance("bathroom")

		var_25_0:_now_room_info()

		local var_25_2 = {}
		local var_25_3 = {}
		local var_25_4 = {}

		var_25_4[#var_25_4 + 1] = var_25_0._all_ship_data.one_room
		var_25_4[#var_25_4 + 1] = var_25_0._all_ship_data.two_room
		var_25_4[#var_25_4 + 1] = var_25_0._all_ship_data.three_room

		local var_25_5 = 0
		local var_25_6 = 0

		for iter_25_0, iter_25_1 in pairs(arg_25_1) do
			for iter_25_2, iter_25_3 in ipairs(var_25_4) do
				var_25_2[iter_25_2] = var_25_2[iter_25_2] or {}

				local var_25_7 = false

				for iter_25_4, iter_25_5 in pairs(iter_25_3) do
					if var_25_2[iter_25_2] and not var_25_2[iter_25_2][iter_25_4] and iter_25_5.available and iter_25_5.state == var_0_4.pool_state.free then
						local var_25_8 = self:__get_repair_need_consume(iter_25_1, true)

						var_25_5 = var_25_5 + var_25_8.oil_need
						var_25_6 = var_25_6 + var_25_8.fe_need

						if var_25_5 > self._user_data.oil then
							self._enough_oil = true
						elseif var_25_6 > self._user_data.fe then
							self._enough_fe = true
						elseif self:__can_repair({
							iter_25_1
						}, false) then
							var_0_5(var_25_3, {
								id = iter_25_1.id,
								room_id = iter_25_2
							})

							var_25_2[iter_25_2][iter_25_4] = true

							if var_25_0._now_room_num == iter_25_2 then
								self._repair_character_array[#self._repair_character_array + 1] = iter_25_1
							end

							var_25_7 = true

							break
						end
					end
				end

				if var_25_7 then
					break
				end
			end
		end

		return var_25_3
	end

	function arg_1_0:init_layer_info()
		self._control.border_top.oil.oil_num_txt.text.text = var_0_10.get_simplify_num(self._user_data.oil)
		self._control.border_top.steel.steel_num_txt.text.text = var_0_10.get_simplify_num(self._user_data.fe)
		self._control.border_top.fast_repair.fast_repair_num_txt.text.text = var_0_10.get_simplify_num(var_0_3:get_fast_item_count())
	end

	function arg_1_0:__set_repair_state()
		self._is_fast_repair = self._control.border_top.repair_switch.repair_off_btn.toggle.isOn
	end

	function arg_1_0:__sort_ship_by_repair_time(arg_28_1, arg_28_2)
		arg_28_2 = arg_28_2 or false

		if not arg_28_1 then
			return
		end

		for iter_28_0, iter_28_1 in pairs(arg_28_1) do
			arg_28_1[iter_28_0].repair_time = self:__get_repair_need_time(iter_28_1)
		end

		table.sort(arg_28_1, function(arg_29_0, arg_29_1)
			if arg_28_2 then
				return arg_29_0.repair_time < arg_29_1.repair_time
			else
				return arg_29_0.repair_time > arg_29_1.repair_time
			end
		end)

		return arg_28_1
	end

	function arg_1_0:init_repair_list()
		local var_30_0 = var_0_3:get_guide_state()
		local var_30_1 = self:__get_repair_list(false)
		local var_30_2 = var_0_2:getInstance("bathroom")

		self._reusable_cell:set_data((self:__sort_ship_by_repair_time(var_30_1)))

		function self._reusable_cell:_set_func(arg_31_1)
			local var_31_0 = var_30_1[arg_31_1 + 1]

			self:__set_ship_info(self, var_30_1[arg_31_1 + 1])

			self.all_layer.expedition_cover.ship_on_expedition.expedition_txt.text.text = var_0_1:getNowLang("errorcode_139")

			self:__set_repair_consume(self, var_30_1[arg_31_1 + 1])
			self.all_layer.level_layer.lock_tag:SetActive(var_30_1[arg_31_1 + 1].lock)
			self.all_layer.expedition_cover:SetActive(false)

			if var_30_1[arg_31_1 + 1].state == var_0_4.ship_state.expedition then
				self.all_layer.expedition_cover:SetActive(true)

				local var_31_1 = self.all_layer.expedition_cover:GetComponent(typeof(ClickAndLongClickEvent))

				var_31_1.onClick:RemoveAllListeners()
				var_31_1.onClick:AddListener(function()
					var_0_12:show(var_0_1:getNowLang("noticeshipisinexplore"))
				end)
				var_31_1.onLongClick:RemoveAllListeners()
				var_31_1.onLongClick:AddListener(function()
					self:setVisible(false)
					var_0_2:createInstance("ship_detail"):show(var_0_4.enter_ship_detail_type.single_ship, var_31_0)
					var_0_3:set_enter_ship_detail_type(var_0_4.enter_ship_detail_type.bathroom_repair)
				end)
			end

			if not var_30_0 then
				self.all_layer.repair_btn.gameObject:SetActive(true)

				self.all_layer.icon_layer.image.raycastTarget = false
				self.all_layer.icon_layer.button.enabled = false

				local var_31_2 = self.all_layer.repair_btn:GetComponent(typeof(ClickAndLongClickEvent))

				var_31_2.onClick:RemoveAllListeners()
				var_31_2.onClick:AddListener(function()
					self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.task_goto))

					if self._is_fast_repair then
						if self:__can_repair({
							var_31_0
						}, true) then
							var_0_3:req_QuickRepairReq({
								var_31_0.id
							})
							var_31_2.onClick:RemoveAllListeners()
						end
					elseif self:__can_repaired() then
						self._repair_character_array = {}

						if self._room_id == var_30_2._now_room_num then
							self._repair_character_array[1] = var_31_0
							self._now_general_repair_character_data = var_31_0
						else
							self._now_general_repair_character_data = nil
						end

						if self:__can_repair({
							var_31_0
						}, false) then
							var_0_3:req_ShipRepairReq({
								id = var_31_0.id,
								room_id = self._room_id
							})
							var_31_2.onClick:RemoveAllListeners()
						end
					else
						var_0_12:show(var_0_1:getNowLang("errorcode_186"))
					end
				end)
			end

			if var_30_0 and arg_31_1 == 0 then
				self.all_layer.gameObject.name = var_0_4.guide_const_name.bathroom_parent_guide_name

				self.all_layer.repair_btn.gameObject:SetActive(false)

				self.all_layer.icon_layer.image.raycastTarget = true
				self.all_layer.icon_layer.button.enabled = true
				self._record_btn = self.all_layer.icon_layer.transform

				self.all_layer.icon_layer.button.onClick:RemoveAllListeners()
				self.all_layer.icon_layer.button.onClick:AddListener(function()
					if self._is_fast_repair then
						if self:__can_repair({
							var_31_0
						}, true) then
							var_0_3:req_QuickRepairReq({
								var_31_0.id
							})
						end
					elseif self:__can_repaired() then
						self._repair_character_array = {}

						if self._room_id == var_30_2._now_room_num then
							self._repair_character_array[1] = var_31_0
							self._now_general_repair_character_data = var_31_0
						else
							self._now_general_repair_character_data = nil
						end

						if self:__can_repair({
							var_31_0
						}, false) then
							var_0_3:req_ShipRepairReq({
								id = var_31_0.id,
								room_id = self._room_id
							})
						end
					else
						var_0_12:show(var_0_1:getNowLang("no_repair_slot_is_available"))
					end
				end)
			end

			local var_31_3 = self.all_layer.repair_btn:GetComponent(typeof(ClickAndLongClickEvent))

			var_31_3.onLongClick:RemoveAllListeners()
			var_31_3.onLongClick:AddListener(function()
				self:setVisible(false)
				var_0_3:set_enter_ship_detail_type(var_0_4.enter_ship_detail_type.bathroom_repair)
				var_0_2:createInstance("ship_detail"):show(var_0_4.enter_ship_detail_type.single_ship, var_31_0)
			end)
		end
	end

	function arg_1_0.get_repair_ship_list(arg_37_0, arg_37_1)
		local var_37_0 = {}

		for iter_37_0, iter_37_1 in pairs((var_0_3:get_character_list())) do
			local var_37_1 = var_0_10:get_ship_attr(iter_37_1, (var_0_6.find_object_by_cid(iter_37_1.cid)))

			if iter_37_1.hp ~= var_37_1.hp then
				iter_37_1 = var_0_10.little_clone(iter_37_1)
				iter_37_1.hp = var_37_1.hp
			end

			if (iter_37_1.now_hp < iter_37_1.hp or nil) and true then
				if iter_37_1.state == var_0_4.ship_state.free or iter_37_1.state == var_0_4.ship_state.expedition then
					var_0_5(var_37_0, var_0_10.little_clone(iter_37_1))
				end

				if arg_37_1 and iter_37_1.state == 4 then
					var_0_5(var_37_0, var_0_10.little_clone(iter_37_1))
				end
			end
		end

		var_0_17(var_37_0, function(arg_38_0, arg_38_1)
			return arg_38_0.id < arg_38_1.id
		end)

		return var_37_0
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self:__init_language()
			self:__init_rank_list()
		end

		self:__init_constant()
		self:__set_repair_state()
		self:init_layer_info()
		self:init_repair_list()

		self._is_already_init = true
	end

	function arg_1_0:__init_language()
		self._control.border_top.selectdamageship.text.text = var_0_1:getNowLang("selectdamagedship")
		self._control.border_top.repair_switch.confirmfastbuildtitle3.text.text = var_0_1:getNowLang("confirmfastbuildtitle3")
		self._control.border_top.repair_all_btn.pvefastrepairall.text.text = var_0_1:getNowLang("pvefastrepairall")
		self._control.all_repair_layer.info.repairallneed.text.text = var_0_1:getNowLang("repairallneed")
		self._control.all_repair_layer.info.oil.resource2.text.text = var_0_1:getNowLang("resource2")
		self._control.all_repair_layer.info.steel.resource4.text.text = var_0_1:getNowLang("resource4")
		self._control.all_repair_layer.info.fast_repair.item541.text.text = var_0_1:getNowLang("item541")
		self._control.all_repair_layer.info.repair_cancel_btn.cancel.text.text = var_0_1:getNowLang("cancel")
		self._control.all_repair_layer.info.repair_btn.pvefastrepairall.text.text = var_0_1:getNowLang("pvefastrepairall")
		self._control.border_top.select_all_btn.select_all_text.text.text = var_0_1:getNowLang("all_bath")
	end

	function arg_1_0.__init_constant(arg_41_0)
		arg_41_0._user_data = var_0_3:get_use_info_data()
	end

	function arg_1_0:_play_into_se(arg_42_1)
		self:playSE(arg_42_1, false)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_43_0)
	local var_43_0 = var_0_2:class("bathroom_repair")

	var_43_0._is_already_init = false
	var_43_0._reusable_cell = nil
	var_43_0._is_fast_repair = false
	var_43_0._test_ship = nil
	var_43_0._now_general_repair_character_data = nil
	var_43_0._user_data = {}
	var_43_0._room_id = 0
	var_43_0._repair_character_array = {}
	var_43_0._enough_oil = false
	var_43_0._enough_fe = false
	var_43_0._enough_repair_item = false

	gamecore.extend_obj(var_43_0)

	return var_43_0
end

return var_0_0
