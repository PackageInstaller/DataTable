local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gameconfig.ship_config
local var_0_3 = gameconfig.equip_config
local var_0_4 = gameenum.common_type
local var_0_5 = gamecore.UILoader
local var_0_6 = gamecore.Language
local var_0_7 = table.insert
local var_0_9 = table.getn
local var_0_10 = string.format
local var_0_11 = gamecore.util_func
local var_0_12 = gamecore.prompt
local var_0_13 = gameenum.error_type
local var_0_14 = DG.Tweening.DOTween
local var_0_15 = gameconfig.sensitive_words_config
local var_0_16 = UnityEngine.Screen
local var_0_18 = gamecore.AudioManager
local var_0_19 = gameconfig.ship_research_config

gamecore.UILoader:define("dock_team", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		var_0_18:destroyCV()

		self._is_short_into = arg_2_1

		if not self._is_short_into then
			self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.shipbar_goto))
		end

		self:setVisible(true)

		if not self._is_already_init then
			self:__init_reusable_cell()
		end

		self:__init_panel()
	end

	function arg_1_0:register_toggle_event_by_guide()
		self:__onToggle_bg_top_menu_tab_toggle_tab_3()
	end

	function arg_1_0:reset_fleet()
		self._control.bg.top_menu.fleet_toggle.fleetid1.toggle.isOn = true
	end

	function arg_1_0:set_equipment_tab()
		self._control.bg.top_menu.tab_toggle.tab_4.toggle.isOn = true
	end

	function arg_1_0:sort_layer_toggle_on(arg_6_1)
		self._sort_layer:change_sort_text(self._control.bg.bot_menu.filter.sort_order_btn.sort_txt, arg_6_1)
		self:update_single_select_team_list()
	end

	function arg_1_0:type_layer_confirm_btn_on()
		self._type_layer:change_type_text(self._control.bg.bot_menu.filter.sort_type_btn.sort_txt)
		self:update_single_select_team_list()
	end

	function arg_1_0:word_is_conform()
		local var_8_0 = {
			id = self._current_team_index,
			name = self._control.bg.top_menu.fleet_toggle.fleet_name.text.text.text
		}
		local var_8_2, var_8_3 = var_0_11.calculate_utf8_char_length(var_8_0.name)

		for iter_8_0, iter_8_1 in pairs((var_0_15.get_sequence())) do
			if iter_8_1.word ~= "" and string.find(var_8_0.name, iter_8_1.word, 1, true) ~= nil then
				var_8_0.name = var_0_6:getNowLang(var_0_10("fleetid%s", self._current_team_index))

				break
			end

			if not var_0_11:filter_spec_chars(var_8_0.name) == false then
				self._control.bg.top_menu.fleet_toggle.fleet_name.text.text.text = var_0_6:getNowLang("fleetid1")
			end
		end

		var_0_1:req_TeamRename(var_8_0)
	end

	function arg_1_0:edit_team_name()
		local var_9_0 = {
			id = self._current_team_index,
			name = self._control.bg.top_menu.fleet_toggle.fleet_name.inputField.text
		}
		local var_9_1 = true

		if var_9_0.name == "" or var_9_0.name == nil then
			self:__update_team_name()
		else
			local var_9_2 = app:getSystem():getChannel()

			if (var_9_2 == var_0_4.channel.android_jp or var_9_2 == var_0_4.channel.iOS_jp) and var_0_11.calculate_utf8_char_length(var_9_0.name) > 40 then
				var_0_12:show(var_0_6:getNowLang("pre_formation_rename_tips"))

				return
			elseif var_9_2 ~= var_0_4.channel.android_jp and var_9_2 ~= var_0_4.channel.iOS_jp and var_0_11.calculate_utf8_char_length(var_9_0.name) > 16 then
				var_0_12:show(var_0_6:getNowLang("pre_formation_rename_tips"))

				return
			end

			local var_9_3, var_9_4 = var_0_11.calculate_utf8_char_length(var_9_0.name)

			for iter_9_0, iter_9_1 in pairs((var_0_15.get_sequence())) do
				if iter_9_1.word ~= "" and string.find(var_9_0.name, iter_9_1.word, 1, true) ~= nil then
					var_9_1 = false

					local var_9_5 = var_0_1:get_account_id()

					var_0_1:req_SensitiveWordsReq({
						type = var_0_4.sensitive_words_type.team_name,
						sensitive_words = var_9_0.name
					})

					var_9_0.name = var_0_6:getNowLang(var_0_10("fleetid%s", self._current_team_index))
					self._control.bg.top_menu.fleet_toggle.fleet_name.inputField.text = var_9_0.name

					break
				end

				var_9_1 = not var_0_11:filter_spec_chars(var_9_0.name)

				if var_9_1 == false then
					var_9_0.name = var_0_6:getNowLang("fleetid1")
				end
			end
		end

		if var_9_1 then
			var_0_1:req_TeamRename(var_9_0)
		end
	end

	function arg_1_0:edit_team_name_refresh()
		self:__update_team_name()
	end

	function arg_1_0.team_save_error(arg_11_0, arg_11_1)
		local var_11_0 = ""

		if arg_11_1 == 6 then
			var_11_0 = var_0_6:getNowLang("errorcode_107")
		elseif arg_11_1 == 60 then
			var_11_0 = var_0_6:getNowLang("errorcode_112")
		elseif arg_11_1 == 146 then
			var_11_0 = var_0_6:getNowLang("inguard")
		end

		var_0_12:show(var_11_0)
	end

	function arg_1_0:save_team_info_single(arg_12_1, arg_12_2)
		local var_12_0 = var_0_11.check_single_team_member_change_saveable(arg_12_1, arg_12_2, lx.clone_table(self._team_data), self._current_team_index)

		if var_12_0 then
			var_0_1:req_TeamSave(var_12_0)
		end
	end

	function arg_1_0:save_team_info_all(arg_13_1)
		local var_13_0 = {}
		local var_13_1 = {}

		for iter_13_0, iter_13_1 in pairs(arg_13_1 or self._team_data) do
			var_0_7(var_13_0, {
				keys = iter_13_0,
				id = iter_13_1
			})
		end

		table.sort(var_13_0, function(arg_14_0, arg_14_1)
			return arg_14_0.keys < arg_14_1.keys
		end)

		for iter_13_2, iter_13_3 in ipairs(var_13_0) do
			var_13_1[iter_13_2] = iter_13_3.id
		end

		if self._current_team_index and self._current_team_index == 1 and (not var_13_0 or not next(var_13_0)) then
			return false
		end

		var_0_1:req_TeamSave({
			quick = true,
			id = self._current_team_index,
			members = var_13_1
		})

		return true
	end

	function arg_1_0:refresh_info_list()
		self:__update_info_list(self._current_content_type, self._current_team_index)
		self._control.bg.middle_menu.team_content_obj.fade_content.team_content.rankableLayoutGroup:ReSetBoundaryPosXList()
		self:update_content(self._current_content_type or var_0_4.dock_team_toggle_type.formation, self._current_team_index)
	end

	function arg_1_0.__get_shell_info(arg_16_0, arg_16_1)
		local var_16_0 = {
			num = 0,
			carry_type = 1
		}
		local var_16_1 = 0
		local var_16_2 = var_0_2.find_object_by_cid(arg_16_1.cid)

		for iter_16_0, iter_16_1 in ipairs(arg_16_1.equips) do
			if iter_16_1.carry_type > var_0_4.equip_carry_type.normal then
				var_16_0.carry_type = iter_16_1.carry_type
				var_16_0.num = var_16_0.num + iter_16_1.num

				if iter_16_1.carry_type == var_0_4.equip_carry_type.plane then
					local var_16_3 = var_16_2.capacity_slot or var_16_2.missile_slot

					if var_16_3 and next(var_16_3) and var_16_3[iter_16_0] then
						var_16_1 = var_16_1 + var_16_3[iter_16_0]
					end
				end
			end
		end

		if var_16_0.carry_type ~= var_0_4.equip_carry_type.normal then
			if var_16_0.num / var_16_1 >= 0.5 then
				-- block empty
			elseif var_16_0.num / var_16_1 >= 0.25 and var_16_0.num / var_16_1 < 0.5 then
				-- block empty
			elseif var_16_0.num / var_16_1 < 0.25 then
				-- block empty
			end

			if var_16_1 > var_16_0.num then
				return true
			end
		end

		return false
	end

	function arg_1_0:ship_supply(arg_17_1, arg_17_2)
		local var_17_1 = var_0_1:get_use_info_data()

		if self:__calc_single_supply_oil(arg_17_1, arg_17_2) > var_17_1.oil then
			var_0_12:show(var_0_6:getNowLang("oilnotenough"))

			return
		end

		if self:__calc_single_supply_bullet(arg_17_1, arg_17_2) > var_17_1.bullet then
			var_0_12:show(var_0_6:getNowLang("ammonotenough"))

			return
		end

		if self:__calc_single_supply_fe(arg_17_1, arg_17_2) > var_17_1.al then
			var_0_12:show(var_0_6:getNowLang("aluminumnotenough"))

			return
		end

		if self._is_team_content_all then
			if self._single_select_team_list[arg_17_1].now_oil >= self._single_select_team_list[arg_17_1].oil and self._single_select_team_list[arg_17_1].now_bullet >= self._single_select_team_list[arg_17_1].bullet and not self:__get_shell_info(self._single_select_team_list[arg_17_1]) then
				var_0_12:show(var_0_6:getNowLang("supplyfullnotice"))

				return
			end

			self._supply_index = arg_17_1

			if self._single_select_team_list[arg_17_1] then
				self:__have_research_ship_info()
				var_0_1:req_ShipSupply({
					id_array = {
						self._single_select_team_list[arg_17_1].id
					}
				})
			end
		else
			local var_17_4 = self._info_list[arg_17_1]:get_data()

			if not self._info_list[arg_17_1]:get_need_supply() then
				var_0_12:show(var_0_6:getNowLang("supplyfullnotice"))

				return
			end

			self._supply_index = arg_17_1

			if var_17_4 then
				self:__have_research_ship_info()
				var_0_1:req_ShipSupply({
					id_array = {
						var_17_4.id
					}
				})
			end
		end
	end

	function arg_1_0:ship_supply_refresh(arg_18_1)
		if self._is_team_content_all then
			if self._supply_index then
				self:update_single_select_team_list()
			end
		elseif self._supply_index then
			self._info_list[self._supply_index]:refresh()
			self._info_list[self._supply_index]:__set_shell()

			if next(arg_18_1.tactics) then
				self._info_list[self._supply_index]:show_tactic(arg_18_1.tactics[1])
			end
		end

		if self._current_content_type == var_0_4.dock_team_toggle_type.supply then
			local var_18_0 = var_0_1:get_use_info_data()
			local var_18_1, var_18_2, var_18_3 = self:__calc_tol_supply()

			self._control.bg.bot_menu.supply.oil.num.text.text = var_18_1
			self._control.bg.bot_menu.supply.bullet.num.text.text = var_18_2
			self._control.bg.bot_menu.supply.mineral.num.text.text = var_18_3

			if type(self._last_oil) ~= "string" and type(var_0_11.get_simplify_num(var_18_0.oil)) ~= "string" then
				self._control.bg.top_menu.user_res.oil_num.fontJump:IncreaseAnim(self._last_oil, var_0_11.get_simplify_num(var_18_0.oil))
			end

			if type(self._last_bullet) ~= "string" and type(var_0_11.get_simplify_num(var_18_0.bullet)) ~= "string" then
				self._control.bg.top_menu.user_res.bullet_num.fontJump:IncreaseAnim(self._last_bullet, var_0_11.get_simplify_num(var_18_0.bullet))
			end

			if type(self._last_fe) ~= "string" and type(var_0_11.get_simplify_num(var_18_0.fe)) ~= "string" then
				self._control.bg.top_menu.user_res.iron_num.fontJump:IncreaseAnim(self._last_fe, var_0_11.get_simplify_num(var_18_0.fe))
			end

			if type(self._last_al) ~= "string" and type(var_0_11.get_simplify_num(var_18_0.al)) ~= "string" then
				self._control.bg.top_menu.user_res.mineral_num.fontJump:IncreaseAnim(self._last_al, var_0_11.get_simplify_num(var_18_0.al))
			end

			self._last_oil = var_0_11.get_simplify_num(var_18_0.oil)
			self._last_bullet = var_0_11.get_simplify_num(var_18_0.bullet)
			self._last_fe = var_0_11.get_simplify_num(var_18_0.fe)
			self._last_al = var_0_11.get_simplify_num(var_18_0.al)
		end
	end

	function arg_1_0:team_supply()
		local var_19_0 = var_0_1:get_team_data(1, self._current_team_index)

		if not not var_19_0 and var_19_0.station then
			var_0_12:show(var_0_6:getNowLang("guard_tip"))

			return
		end

		if self._is_team_content_all then
			if self._need_oil_num == 0 and self._need_bullet_num == 0 and self._need_al_num == 0 then
				var_0_12:show(var_0_6:getNowLang("supplyfullnotice"))

				return
			end

			local var_19_1 = self._control.bg.middle_menu.team_content_all.Sp_supply

			self._control.bg.middle_menu.team_content_all.Sp_supply:SetActive(true)
			self:play_skeGraphic_ani(var_19_1, 0, "normal", nil, true)

			local var_19_2 = var_0_1:get_use_info_data()

			if var_19_2.oil < self._need_oil_num then
				var_0_12:show(var_0_6:getNowLang("oilnotenough"))
				var_19_1:SetActive(false)

				return
			end

			if var_19_2.bullet < self._need_bullet_num then
				var_0_12:show(var_0_6:getNowLang("ammonotenough"))
				var_19_1:SetActive(false)

				return
			end

			if var_19_2.al < self._need_al_num then
				var_0_12:show(var_0_6:getNowLang("aluminumnotenough"))
				var_19_1:SetActive(false)

				return
			end

			local var_19_3 = {}

			self:__have_research_ship_info()
			var_0_1:req_AllShipSupply(var_19_3)
		else
			if self._need_oil_num == 0 and self._need_bullet_num == 0 and self._need_al_num == 0 then
				var_0_12:show(var_0_6:getNowLang("supplyfullnotice"))

				return
			end

			local var_19_4 = var_0_1:get_use_info_data()

			if var_19_4.oil < self._need_oil_num then
				var_0_12:show(var_0_6:getNowLang("oilnotenough"))

				return
			end

			if var_19_4.bullet < self._need_bullet_num then
				var_0_12:show(var_0_6:getNowLang("ammonotenough"))

				return
			end

			if var_19_4.al < self._need_al_num then
				var_0_12:show(var_0_6:getNowLang("aluminumnotenough"))

				return
			end

			if self._current_team_index then
				self:__have_research_ship_info()
				var_0_1:req_TeamSupply({
					id = self._current_team_index
				})
			end
		end
	end

	function arg_1_0:shut_down_sp_ani()
		self._control.bg.middle_menu.team_content_all.Sp_supply:SetActive(false)
	end

	function arg_1_0.play_skeGraphic_ani(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5)
		if arg_21_1.skeletonGraphic then
			arg_21_1 = arg_21_1.skeletonGraphic
		end

		arg_21_1.AnimationState:SetAnimation(arg_21_2, arg_21_3, arg_21_5 or false)
		arg_21_1.AnimationState:Update(0)

		if arg_21_4 and not arg_21_5 then
			local var_21_0 = arg_21_1.AnimationState.Complete

			local function var_21_1()
				arg_21_4()

				arg_21_1.AnimationState.Complete = var_21_0
			end

			var_21_0 = arg_21_1.AnimationState.Complete + var_21_1
			arg_21_1.AnimationState.Complete = arg_21_1.AnimationState.Complete + var_21_1
			var_21_0 = var_21_0 - var_21_1
		end
	end

	function arg_1_0:__onUpdate()
		if self._click_times >= 0 then
			self._click_times = self._click_times - 0.1
		end

		if self._select_team then
			-- block empty
		end

		if self._reusable_cell then
			self._reusable_cell:update()
		end

		if self._team_click_times > 0 then
			self._control.bg.top_menu.fleet_toggle.fleetid5.toggle.enabled = false
			self._team_click_times = self._team_click_times - 0.02
		elseif self._control.bg.top_menu.fleet_toggle.fleetid5.toggle.enabled == false then
			self._control.bg.top_menu.fleet_toggle.fleetid5.toggle.enabled = true

			return
		else
			return
		end
	end

	function arg_1_0:team_supply_refresh(arg_24_1)
		local var_24_0 = var_0_1:get_use_info_data()

		if arg_24_1.result == var_0_13.NOT_RESOURCE then
			if var_24_0.oil < self:__calc_supply_oil() then
				var_0_12:show(var_0_6:getNowLang("oilnotenough"))
			elseif var_24_0.bullet < self:__calc_supply_bullet() then
				var_0_12:show(var_0_6:getNowLang("ammonotenough"))
			elseif var_24_0.al < self:__calc_supply_fe() then
				var_0_12:show(var_0_6:getNowLang("aluminumnotenough"))
			end

			return
		end

		if self._is_team_content_all then
			self._control.bg.middle_menu.team_content_all.Sp_supply:SetActive(false)
			self:update_single_select_team_list()
		else
			self:update_content(var_0_4.dock_team_toggle_type.supply, self._current_team_index, arg_24_1)
		end
	end

	function arg_1_0:get_current_team_index()
		return self._current_team_index
	end

	function arg_1_0:update_content(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
		local var_26_0 = not arg_26_2 or arg_26_2 < 5

		self._control.bg.middle_menu.team_content_obj:SetActive((not arg_26_2 or arg_26_2 < 5) and true or false)
		self._control.bg.middle_menu.team_content_all:SetActive(not var_26_0)

		if arg_26_2 and arg_26_2 == 5 and self._current_team_index ~= arg_26_2 then
			self._control.bg.middle_menu.team_content_all.Scrollbar:GetComponent("Scrollbar").value = 1
		end

		local var_26_1 = self:get_four_three_height()

		if var_26_0 then
			local var_26_2 = 0.2

			if arg_26_4 then
				var_26_2 = 0
			end

			if self._cur_seq then
				self._cur_seq:Kill()
			end

			self._cur_seq = self:autoKillDOTween(var_0_14.Sequence()):Append(self._control.bg.middle_menu.team_content_all.rectTransform:DOAnchorPos(Vector2(1500, var_26_1), 0.4):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(var_26_2):SetAutoKill(true))
		else
			if self._cur_seq then
				self._cur_seq:Kill()
			end

			self._control.bg.middle_menu.team_content_all.rectTransform.anchoredPosition = Vector2(-4, var_26_1)
		end

		self._control.bg.top_menu.fleet_toggle.fleet_name:SetActive(var_26_0)

		for iter_26_0 = 1, 5 do
			if arg_26_2 == iter_26_0 then
				self._control.bg.top_menu.fleet_toggle[var_0_10("fleetid%s", iter_26_0)].text.text.color = Color.New(0.06274509803921569, 0.5058823529411764, 0.8745098039215686)
				self._control.bg.top_menu.fleet_toggle[var_0_10("fleetid%s", iter_26_0)].toggle.isOn = true
			else
				self._control.bg.top_menu.fleet_toggle[var_0_10("fleetid%s", iter_26_0)].text.text.color = Color.New(1, 1, 1)
				self._control.bg.top_menu.fleet_toggle[var_0_10("fleetid%s", iter_26_0)].toggle.isOn = false
			end
		end

		if var_26_0 then
			self._is_team_content_all = false

			local var_26_3 = lan_rand(1, 6)

			if arg_26_1 == var_0_4.dock_team_toggle_type.formation then
				self._control.bg.bot_menu.tips.ui_shiphint.text.text = var_0_6:getNowLang(var_0_10(var_0_4.help_info_language.help_info_1101, var_26_3))

				self._control.bg.bot_menu.tips:SetActive(true)
				self._control.bg.bot_menu.supply:SetActive(false)
				self._control.bg.top_menu.fleet_toggle.fleetid5:SetActive(false)

				local var_26_4 = app:getSystem():getChannel()

				self._control.bg.top_menu.fleet_toggle.fleetid_pre_formation.bg.image.sprite = (var_26_4 == var_0_4.channel.android_jp or var_26_4 == var_0_4.channel.iOS_jp) and self:loadSprite(var_0_4.pre_formation_bg) or self:loadSprite(var_0_4.pre_formation_bg)

				self._control.bg.top_menu.fleet_toggle.fleetid_pre_formation:SetActive(true)
				self._control.bg.bot_menu.filter:SetActive(false)

				self._control.bg.top_menu.tab_toggle.tab_1.sbt1.text.color = Color.New(1, 1, 1, 1)
				self._control.bg.top_menu.tab_toggle.tab_3.sbt3.text.color = Color.New(1, 1, 1, 0.3333333333333333)
				self._control.bg.top_menu.tab_toggle.tab_4.sbt4.text.color = Color.New(1, 1, 1, 0.3333333333333333)
				self._control.bg.top_menu.tab_toggle.tab_1.sbt1.text.fontSize = 28
				self._control.bg.top_menu.tab_toggle.tab_3.sbt3.text.fontSize = 26
				self._control.bg.top_menu.tab_toggle.tab_4.sbt4.text.fontSize = 26
			elseif arg_26_1 == var_0_4.dock_team_toggle_type.supply then
				self._control.bg.bot_menu.tips:SetActive(false)
				self._control.bg.bot_menu.supply:SetActive(true)
				self._control.bg.top_menu.fleet_toggle.fleetid5:SetActive(true)
				self._control.bg.top_menu.fleet_toggle.fleetid_pre_formation:SetActive(false)
				self._control.bg.bot_menu.filter:SetActive(false)

				self._control.bg.top_menu.tab_toggle.tab_1.sbt1.text.color = Color.New(1, 1, 1, 0.3333333333333333)
				self._control.bg.top_menu.tab_toggle.tab_3.sbt3.text.color = Color.New(1, 1, 1, 1)
				self._control.bg.top_menu.tab_toggle.tab_4.sbt4.text.color = Color.New(1, 1, 1, 0.3333333333333333)
				self._control.bg.top_menu.tab_toggle.tab_1.sbt1.text.fontSize = 26
				self._control.bg.top_menu.tab_toggle.tab_3.sbt3.text.fontSize = 28
				self._control.bg.top_menu.tab_toggle.tab_4.sbt4.text.fontSize = 26
			elseif arg_26_1 == var_0_4.dock_team_toggle_type.equipment then
				self._control.bg.bot_menu.tips.ui_shiphint.text.text = var_0_6:getNowLang(var_0_10(var_0_4.help_info_language.help_info_1401, var_26_3))

				self._control.bg.bot_menu.tips:SetActive(true)
				self._control.bg.bot_menu.supply:SetActive(false)
				self._control.bg.bot_menu.filter:SetActive(false)
				self._control.bg.top_menu.fleet_toggle.fleetid5:SetActive(true)
				self._control.bg.top_menu.fleet_toggle.fleetid_pre_formation:SetActive(false)

				self._control.bg.top_menu.tab_toggle.tab_1.sbt1.text.color = Color.New(1, 1, 1, 0.3333333333333333)
				self._control.bg.top_menu.tab_toggle.tab_3.sbt3.text.color = Color.New(1, 1, 1, 0.3333333333333333)
				self._control.bg.top_menu.tab_toggle.tab_4.sbt4.text.color = Color.New(1, 1, 1, 1)
				self._control.bg.top_menu.tab_toggle.tab_1.sbt1.text.fontSize = 26
				self._control.bg.top_menu.tab_toggle.tab_3.sbt3.text.fontSize = 26
				self._control.bg.top_menu.tab_toggle.tab_4.sbt4.text.fontSize = 28
			end

			self:__play_bot_menu_in_animation()

			local function var_26_5()
				self._current_team_index = arg_26_2 or 1
				self._current_content_type = arg_26_1

				self:__update_team_name()
				self:__update_info_list(self._current_content_type, self._current_team_index, arg_26_3)

				if self._current_content_type == var_0_4.dock_team_toggle_type.supply or self._current_content_type == var_0_4.dock_team_toggle_type.equipment then
					self:__cancel_btn_active(false)
				else
					self:__cancel_btn_active()
				end
			end

			if self._is_already_init then
				if arg_26_1 ~= self._current_content_type or self.switch_content_not_first_team then
					self:play_switch_tab_animation(var_26_5)

					self.switch_content_not_first_team = false
				else
					var_26_5()
				end
			else
				var_26_5()
			end
		end
	end

	function arg_1_0:__filter_fast_character_list()
		local var_28_0 = {}
		local var_28_1 = var_0_1:get_character_list()
		local var_28_2 = {}

		if self._is_custom_panel and self._current_content_type == var_0_4.dock_team_toggle_type.equipment then
			local var_28_3 = var_0_1:get_custom_ship_list()

			for iter_28_0, iter_28_1 in pairs(var_28_1) do
				for iter_28_2, iter_28_3 in pairs(var_28_3) do
					if iter_28_1.id == iter_28_3 then
						table.insert(var_28_2, iter_28_1)
					end
				end
			end
		end

		if self._is_custom_panel and self._current_content_type == var_0_4.dock_team_toggle_type.equipment then
			if var_28_2 and next(var_28_2) then
				for iter_28_4, iter_28_5 in pairs(var_28_2) do
					local var_28_4 = true

					if self._current_content_type ~= var_0_4.dock_team_toggle_type.supply and self._current_content_type ~= var_0_4.dock_team_toggle_type.equipment then
						for iter_28_6 = 1, 4 do
							local var_28_5 = var_0_1:get_team_data(1, iter_28_6)

							if var_28_5 and var_0_11.have_data(var_28_5.members, iter_28_5.id) then
								var_28_4 = false
							end
						end
					end

					if var_28_4 then
						local var_28_6 = iter_28_5 and var_0_11.little_clone(iter_28_5) or {}

						var_28_6.team_num = var_0_1:get_team_index_by_id(1, var_28_6.id)

						var_0_7(var_28_0, var_28_6)
					end
				end
			end
		else
			for iter_28_7, iter_28_8 in pairs(var_28_1) do
				local var_28_7 = true

				if self._current_content_type ~= var_0_4.dock_team_toggle_type.supply and self._current_content_type ~= var_0_4.dock_team_toggle_type.equipment then
					for iter_28_9 = 1, 4 do
						local var_28_8 = var_0_1:get_team_data(1, iter_28_9)

						if var_28_8 and var_0_11.have_data(var_28_8.members, iter_28_8.id) then
							var_28_7 = false
						end
					end
				end

				if var_28_7 then
					local var_28_9 = iter_28_8 and var_0_11.little_clone(iter_28_8) or {}

					var_28_9.team_num = var_0_1:get_team_index_by_id(1, var_28_9.id)

					var_0_7(var_28_0, var_28_9)
				end
			end
		end

		return var_28_0
	end

	function arg_1_0:update_single_select_team_list()
		self._current_team_index = 5

		self._control.bg.middle_menu.team_content_obj:SetActive(false)
		self._control.bg.middle_menu.team_content_all:SetActive(true)

		self._control.bg.middle_menu.team_content_all.rectTransform.anchoredPosition = Vector2(-4, (self:get_four_three_height()))

		self._control.bg.top_menu.fleet_toggle.fleet_name:SetActive(false)

		self._is_team_content_all = true

		local var_29_0 = self:__filter_fast_character_list()

		if self._current_content_type == var_0_4.dock_team_toggle_type.equipment then
			local var_29_1 = self:__sort_table_by_rule((self:__sort_table_by_type(var_29_0)))

			self._single_select_team_list = var_29_1

			local var_29_2 = {}

			for iter_29_0, iter_29_1 in pairs(var_29_1) do
				if iter_29_1 and iter_29_1.id then
					var_0_7(var_29_2, iter_29_1.id)
				end
			end

			var_0_1:set_all_select_member_list(var_29_2)
			self._reusable_cell:set_data(var_29_1)

			function self._reusable_cell:_set_func(arg_30_1)
				var_29_1[arg_30_1 + 1].is_exist = false

				self:show(var_29_1[arg_30_1 + 1], self._current_content_type, arg_30_1 + 1)
				self:set_enter_type(var_0_4.enter_select_member_type.dock_team)
			end

			self._control.bg.top_menu.fleet_toggle.equip_all_ship_info:SetActive(true)
		elseif self._current_content_type == var_0_4.dock_team_toggle_type.supply then
			table.sort(var_29_0, function(arg_31_0, arg_31_1)
				if arg_31_0.level == arg_31_1.level then
					if arg_31_0.type == arg_31_1.type then
						return arg_31_0.cid > arg_31_1.cid
					end

					return arg_31_0.type < arg_31_1.type
				end

				return arg_31_0.level > arg_31_1.level
			end)

			self._single_select_team_list = var_29_0

			local var_29_3 = {}

			for iter_29_2, iter_29_3 in pairs(var_29_0) do
				if iter_29_3 and iter_29_3.id then
					var_0_7(var_29_3, iter_29_3.id)
				end
			end

			var_0_1:set_all_select_member_list(var_29_3)
			self._reusable_cell:set_data(var_29_0)

			function self._reusable_cell:_set_func(arg_32_1)
				var_29_0[arg_32_1 + 1].is_exist = false

				self:show(var_29_0[arg_32_1 + 1], self._current_content_type, arg_32_1 + 1)
				self:set_enter_type(var_0_4.enter_select_member_type.dock_team)
			end

			if self._current_content_type == var_0_4.dock_team_toggle_type.supply then
				local var_29_4 = var_0_1:get_use_info_data()
				local var_29_5, var_29_6, var_29_7 = self:__calc_tol_supply()

				self._control.bg.bot_menu.supply.oil.num.text.text = var_29_5
				self._control.bg.bot_menu.supply.bullet.num.text.text = var_29_6
				self._control.bg.bot_menu.supply.mineral.num.text.text = var_29_7

				if type(self._last_oil) ~= "string" and type(var_0_11.get_simplify_num(var_29_4.oil)) ~= "string" then
					self._control.bg.top_menu.user_res.oil_num.fontJump:IncreaseAnim(self._last_oil, var_0_11.get_simplify_num(var_29_4.oil))
				end

				if type(self._last_bullet) ~= "string" and type(var_0_11.get_simplify_num(var_29_4.bullet)) ~= "string" then
					self._control.bg.top_menu.user_res.bullet_num.fontJump:IncreaseAnim(self._last_bullet, var_0_11.get_simplify_num(var_29_4.bullet))
				end

				if type(self._last_fe) ~= "string" and type(var_0_11.get_simplify_num(var_29_4.fe)) ~= "string" then
					self._control.bg.top_menu.user_res.iron_num.fontJump:IncreaseAnim(self._last_fe, var_0_11.get_simplify_num(var_29_4.fe))
				end

				if type(self._last_al) ~= "string" and type(var_0_11.get_simplify_num(var_29_4.al)) ~= "string" then
					self._control.bg.top_menu.user_res.mineral_num.fontJump:IncreaseAnim(self._last_al, var_0_11.get_simplify_num(var_29_4.al))
				end

				self._last_oil = var_0_11.get_simplify_num(var_29_4.oil)
				self._last_bullet = var_0_11.get_simplify_num(var_29_4.bullet)
				self._last_fe = var_0_11.get_simplify_num(var_29_4.fe)
				self._last_al = var_0_11.get_simplify_num(var_29_4.al)
			end
		end
	end

	function arg_1_0:get_guide_btn_pos_info(arg_33_1)
		if arg_33_1 == var_0_4.guide_const_id.third_group.two then
			return self._control.bg.top_menu.repair_btn.transform
		elseif arg_33_1 == var_0_4.guide_const_id.four_group.one then
			return self._control.bg.top_menu.tab_toggle.tab_3.transform
		elseif arg_33_1 == var_0_4.guide_const_id.four_group.three or arg_33_1 == var_0_4.guide_const_id.eight_group.four then
			return self._control.bg.top_menu.return_btn.transform
		elseif arg_33_1 == var_0_4.guide_const_id.four_group.two then
			return self._control.bg.bot_menu.supply.supply_btn.transform
		elseif arg_33_1 == var_0_4.guide_const_id.eight_group.one then
			return self._record_select_btn
		end
	end

	function arg_1_0:__init_panel()
		local var_34_0 = var_0_1:get_use_info_data()

		self._control.bg.top_menu.user_res.oil_num.text.text = var_0_11.get_simplify_num(var_34_0.oil)
		self._control.bg.top_menu.user_res.bullet_num.text.text = var_0_11.get_simplify_num(var_34_0.bullet)
		self._control.bg.top_menu.user_res.iron_num.text.text = var_0_11.get_simplify_num(var_34_0.fe)
		self._control.bg.top_menu.user_res.mineral_num.text.text = var_0_11.get_simplify_num(var_34_0.al)
		self._last_oil = var_0_11.get_simplify_num(var_34_0.oil)
		self._last_bullet = var_0_11.get_simplify_num(var_34_0.bullet)
		self._last_fe = var_0_11.get_simplify_num(var_34_0.fe)
		self._last_al = var_0_11.get_simplify_num(var_34_0.al)
		self._control.bg.top_menu.tab_toggle.tab_1.sbt1.text.text = var_0_6:getNowLang("dock_team_text")
		self._control.bg.top_menu.tab_toggle.tab_3.sbt3.text.text = var_0_6:getNowLang("activitysupply")
		self._control.bg.top_menu.tab_toggle.tab_4.sbt4.text.text = var_0_6:getNowLang("te")
		self._control.bg.top_menu.repair_btn.repairship.text.text = var_0_6:getNowLang("repairship")
		self._control.bg.top_menu.fleet_toggle.fleetid5.text.text.text = var_0_6:getNowLang("ui_all")
		self._control.bg.bot_menu.filter.sort_order_btn.sorttype.text.text = var_0_6:getNowLang("sortlabel")
		self._control.bg.bot_menu.filter.sort_order_btn.sort_txt.text.text = var_0_6:getNowLang("sorttypes3")
		self._control.bg.bot_menu.filter.sort_type_btn.type.text.text = var_0_6:getNowLang("type")
		self._control.bg.bot_menu.filter.sort_type_btn.sort_txt.text.text = var_0_6:getNowLang("questall")
		self._control.bg.bot_menu.supply.supply_btn.pvesupplyall.text.text = var_0_6:getNowLang("pvesupplyall")
		self._control.bg.bot_menu.supply.pvesuplycost.text.text = var_0_6:getNowLang("pvesupplycost")
		self._control.bg.middle_menu.cancel_station.Text.text.text = var_0_6:getNowLang("ui_activitydefendcancel")
		self._control.bg.top_menu.fleet_toggle.equip_all_ship_info.all_ship_btn_txt.text.text = var_0_6:getNowLang("equip0") .. var_0_6:getNowLang("leaderboardship")
		self._init_character_list = var_0_1:get_character_list()
		self._sort_layer = self._sort_layer or self:loadUI("sort_layer_2")

		self._sort_layer:show(false)
		self._sort_layer._panel.transform:SetParent(self._control.bg.sort_layer.rectTransform, false)
		self._sort_layer:set_listener(self, self.sort_layer_toggle_on)

		self._type_layer = self._type_layer or self:loadUI("type_layer")

		self._type_layer:show(false)
		self._type_layer._panel.transform:SetParent(self._control.bg.type_layer.rectTransform, false)
		self._type_layer:set_listener(self, self.type_layer_confirm_btn_on)

		self._control.bg.top_menu.fleet_toggle.fleet_name.placeholder.text.fontSize = 20
		self._control.bg.top_menu.fleet_toggle.fleet_name.text.text.fontSize = 20

		self._control.bg.top_menu.fleet_toggle.fleet_name.inputField.onEndEdit:RemoveAllListeners()
		self._control.bg.top_menu.fleet_toggle.fleet_name.inputField.onEndEdit:AddListener(function()
			self:edit_team_name()
		end)
		var_0_11:input_del_emoji(self._control.bg.top_menu.fleet_toggle.fleet_name.inputField)
		self:__close_custom_btn(false)

		if not self._is_custom_panel then
			self:set_all_ship_or_custom_ship_state(false)
		else
			self:set_all_ship_or_custom_ship_state(true)
		end

		self:__init_content()
		self:word_is_conform()
	end

	function arg_1_0:__close_custom_btn(arg_36_1)
		self._control.bg.top_menu.fleet_toggle.equip_all_ship_info:SetActive(arg_36_1)
	end

	function arg_1_0:set_all_ship_or_custom_ship_state(arg_37_1)
		self._control.bg.top_menu.fleet_toggle.equip_all_ship_info.custom_ship_btn:SetActive(arg_37_1)
		self._control.bg.top_menu.fleet_toggle.equip_all_ship_info.all_ship_btn_bg:SetActive(not arg_37_1)
	end

	function arg_1_0:__init_content()
		self:play_in_animation()
		self:reset_fleet()
		self:update_content(self._current_content_type or var_0_4.dock_team_toggle_type.formation, 1)

		for iter_38_0 = 1, 4 do
			local var_38_0 = "fleetid" .. tostring(iter_38_0)

			if not var_0_1:get_team_data(1, iter_38_0) then
				self._control.bg.top_menu.fleet_toggle[var_38_0].toggle.interactable = false
				self._control.bg.top_menu.fleet_toggle[var_38_0].bg.image.sprite = self:loadSprite(var_0_4.dock_team_bg.disable)

				self._control.bg.top_menu.fleet_toggle[var_38_0].text:SetActive(false)
			else
				self._max_team_index = iter_38_0
				self._control.bg.top_menu.fleet_toggle[var_38_0].toggle.interactable = true
				self._control.bg.top_menu.fleet_toggle[var_38_0].bg.image.sprite = self:loadSprite(var_0_4.dock_team_bg.activated)

				self._control.bg.top_menu.fleet_toggle[var_38_0].text:SetActive(true)
			end
		end
	end

	function arg_1_0:__update_team_name()
		if self._current_team_index then
			local var_39_0 = var_0_1:get_team_data(1, self._current_team_index)

			if var_39_0 then
				local var_39_1 = var_39_0.name
				local var_39_2 = (not var_39_0.name or var_39_1 == "") and var_0_6:getNowLang(var_0_10("fleetid%s", self._current_team_index)) or var_39_1

				if (not var_39_0.name or var_39_1 == "") and self._current_team_index == 1 then
					self._control.bg.top_menu.fleet_toggle.fleet_name.inputField.text = var_0_6:getNowLang("firstfleet")
				end
			end
		end
	end

	function arg_1_0:__update_info_list(arg_40_1, arg_40_2, arg_40_3)
		self._team_data = {}

		local var_40_0 = var_0_1:get_team_data(1, arg_40_2)

		if not var_40_0 then
			return
		end

		if self._is_already_init then
			for iter_40_0, iter_40_1 in pairs(self._info_list) do
				iter_40_1._panel:GetComponent("CanvasGroup").alpha = 1
			end

			for iter_40_2 = 1, 6 do
				local var_40_1 = self._info_list[iter_40_2]
				local var_40_2 = var_40_0.members[iter_40_2]

				if var_40_0.members[iter_40_2] then
					local var_40_3 = var_0_1:find_character_by_id(var_40_2)

					var_40_1:show(var_40_3, arg_40_1, iter_40_2)

					var_40_1._control.BG.all_layer.drag_layer.rankableLayoutItem.isFilled = true

					if arg_40_1 == var_0_4.dock_team_toggle_type.formation then
						var_40_1:set_active_rankable_layout_item(true)
						var_0_7(self._team_data, var_40_3.id)
					else
						var_40_1:set_active_rankable_layout_item(false)
					end

					if arg_40_3 and next(arg_40_3.tactics) then
						for iter_40_3, iter_40_4 in pairs(arg_40_3.tactics) do
							if iter_40_4.id == var_40_2 then
								var_40_1:show_tactic(arg_40_3.tactics[iter_40_3])
							end
						end
					end
				elseif arg_40_1 == var_0_4.dock_team_toggle_type.formation then
					var_40_1:show(nil, nil, iter_40_2)

					var_40_1._control.BG.all_layer.drag_layer.rankableLayoutItem.isFilled = false
				else
					var_40_1:setVisible(false)
				end

				if iter_40_2 == 1 then
					var_40_1:set_main()
				else
					var_40_1:set_main(false)
				end
			end

			if arg_40_1 == var_0_4.dock_team_toggle_type.supply then
				local var_40_4 = var_0_1:get_use_info_data()
				local var_40_5, var_40_6, var_40_7 = self:__calc_tol_supply()

				self._control.bg.bot_menu.supply.oil.num.text.text = var_40_5
				self._control.bg.bot_menu.supply.bullet.num.text.text = var_40_6
				self._control.bg.bot_menu.supply.mineral.num.text.text = var_40_7
				self._control.bg.top_menu.user_res.oil_num.text.text = var_0_11.get_simplify_num(var_40_4.oil)
				self._control.bg.top_menu.user_res.bullet_num.text.text = var_0_11.get_simplify_num(var_40_4.bullet)
				self._control.bg.top_menu.user_res.iron_num.text.text = var_0_11.get_simplify_num(var_40_4.fe)
				self._control.bg.top_menu.user_res.mineral_num.text.text = var_0_11.get_simplify_num(var_40_4.al)
				self._last_oil = var_0_11.get_simplify_num(var_40_4.oil)
				self._last_bullet = var_0_11.get_simplify_num(var_40_4.bullet)
				self._last_fe = var_0_11.get_simplify_num(var_40_4.fe)
				self._last_al = var_0_11.get_simplify_num(var_40_4.al)
			end
		else
			for iter_40_5 = 1, 6 do
				local var_40_8 = self._info_list[iter_40_5] or self:loadUI("single_ship")

				var_40_8._panel.transform:SetParent(self._control.bg.middle_menu.team_content_obj.fade_content.team_content.rectTransform, false)

				if iter_40_5 == 1 then
					if var_0_1:get_guide_state() then
						self._record_btn = var_40_8._control.BG.all_layer.transform
						var_40_8._control.BG.all_layer.gameObject.name = var_0_4.guide_const_name.dock_team_parent_guide_name
					end
				elseif iter_40_5 == 2 and var_0_1:get_guide_state() then
					self._record_select_btn = var_40_8._control.BG.all_layer.transform
					var_40_8._panel.gameObject.name = var_0_4.guide_const_name.team_single_parent_guide_name
				end

				if var_40_0.members[iter_40_5] then
					local var_40_9 = var_0_1:find_character_by_id(var_40_0.members[iter_40_5])

					var_40_8:show(var_40_9, arg_40_1, iter_40_5)

					var_40_8._control.BG.all_layer.drag_layer.rankableLayoutItem.isFilled = true

					var_0_7(self._team_data, var_40_9.id)
				else
					var_40_8:show(nil, nil, iter_40_5)

					var_40_8._control.BG.all_layer.drag_layer.rankableLayoutItem.isFilled = false
				end

				if iter_40_5 == 1 then
					var_40_8:set_main()
				end

				self._info_list[iter_40_5] = var_40_8
			end

			self._control.bg.middle_menu.team_content_obj.fade_content.team_content.rankableLayoutGroup.onItemExchange:RemoveAllListeners()
			self._control.bg.middle_menu.team_content_obj.fade_content.team_content.rankableLayoutGroup.onItemExchange:AddListener(function(arg_41_0, arg_41_1)
				self._team_data[arg_41_0] = self._team_data[arg_41_1]
				self._team_data[arg_41_1] = self._team_data[arg_41_0]
				self._info_list[arg_41_0] = self._info_list[arg_41_1]
				self._info_list[arg_41_1] = self._info_list[arg_41_0]
			end)
			self._control.bg.middle_menu.team_content_obj.fade_content.team_content.rankableLayoutGroup.onEndDrag:RemoveAllListeners()
			self._control.bg.middle_menu.team_content_obj.fade_content.team_content.rankableLayoutGroup.onEndDrag:AddListener(function()
				if not self:save_team_info_all() then
					var_0_12:show(var_0_6:getNowLang("needflagshipinfleet"))
				end
			end)
			self._control.bg.middle_menu.team_content_obj.fade_content.team_content.rankableLayoutGroup:Init()

			self._is_already_init = true
		end
	end

	function arg_1_0:__play_members_animation_start(arg_43_1)
		if arg_43_1 >= 6 then
			return
		end

		arg_43_1 = arg_43_1 + 1

		for iter_43_0 = arg_43_1, 6 do
			if self._info_list[iter_43_0] and not self._info_list[iter_43_0]._panel:Equals(nil) then
				self._info_list[iter_43_0]._panel:GetComponent("CanvasGroup").alpha = 0
			end
		end

		if not self._info_list[arg_43_1]._panel:Equals(nil) then
			local var_43_0 = self._info_list[arg_43_1]._panel:GetComponent("CanvasGroup"):DOFade(0.5, 0.25)
		end

		local var_43_1 = self:autoKillDOTween(var_0_14.Sequence())

		var_43_1:AppendInterval(0.01)
		var_43_1:AppendCallback(function()
			self:__play_members_animation_end(arg_43_1)
		end)
		var_43_1:Play()

		self._dock_tween_list[arg_43_1] = var_43_1
	end

	function arg_1_0:__play_members_animation_end(arg_45_1)
		self:__play_members_animation_start(arg_45_1)

		local var_45_0 = self._info_list[arg_45_1]._panel:GetComponent("CanvasGroup")

		if var_45_0.alpha < 1 then
			local var_45_1 = var_45_0:DOFade(1, 0.25)
			local var_45_2 = self:autoKillDOTween(var_0_14.Sequence())

			var_45_2:AppendInterval(0.1)
			var_45_2:Play()
		end
	end

	function arg_1_0:__play_scroll_animation()
		for iter_46_0 = 1, 6 do
			if self._info_list[iter_46_0] and not self._info_list[iter_46_0]._panel:Equals(nil) then
				self._info_list[iter_46_0]._panel:GetComponent("CanvasGroup").alpha = 0
			end
		end

		if self._info_list[1] and not self._info_list[1]._panel:Equals(nil) then
			local var_46_0 = self._info_list[1]._panel:GetComponent("CanvasGroup"):DOFade(0.5, 0.25)
			local var_46_1 = self:autoKillDOTween(var_0_14.Sequence())

			var_46_1:AppendInterval(0.1)
			var_46_1:AppendCallback(function()
				self:__play_members_animation_end(1)
			end)
			var_46_1:Play()

			self._dock_tween_list[1] = var_46_1
		end

		self:autoKillDOTween(var_0_14.Sequence()):AppendInterval(0.3)
	end

	function arg_1_0:__play_bot_menu_in_animation()
		self._control.bg.bot_menu.rectTransform.anchoredPosition = Vector2(0, 100)
		self._control.bg.bot_menu.rectTransform:DOAnchorPos(Vector2(0, 242), 0.4):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(0.2):SetAutoKill(true).onComplete = function()
			return
		end
	end

	function arg_1_0:__calc_supply_oil()
		local var_50_0 = 0

		if self._is_team_content_all then
			for iter_50_0, iter_50_1 in pairs(self._init_character_list) do
				var_50_0 = var_50_0 + iter_50_1.oil - iter_50_1.now_oil
			end
		else
			local var_50_1 = var_0_1:get_team_data(1, self._current_team_index)

			for iter_50_2 = 1, var_0_9(var_50_1.members) do
				local var_50_2 = var_0_1:find_character_by_id(var_50_1.members[iter_50_2])

				var_50_0 = var_50_0 + var_50_2.oil - var_50_2.now_oil
			end
		end

		var_50_0 = var_50_0 < 0 and 0 or math.floor(var_50_0)
		self._need_oil_num = var_50_0

		return var_50_0
	end

	function arg_1_0:__calc_supply_bullet()
		local var_51_0 = 0

		if self._is_team_content_all then
			for iter_51_0, iter_51_1 in pairs(self._init_character_list) do
				local var_51_1 = var_0_1:get_bullet_limit_by_tactic(iter_51_1.id)

				var_51_0 = var_51_0 + (var_51_1 - iter_51_1.now_bullet < 0 and 0 or var_51_1 - iter_51_1.now_bullet)
			end
		else
			local var_51_2 = var_0_1:get_team_data(1, self._current_team_index)

			for iter_51_2 = 1, var_0_9(var_51_2.members) do
				local var_51_3 = var_0_1:find_character_by_id(var_51_2.members[iter_51_2])
				local var_51_4 = var_0_1:get_bullet_limit_by_tactic(var_51_2.members[iter_51_2])

				var_51_0 = var_51_0 + (var_51_4 - var_51_3.now_bullet < 0 and 0 or var_51_4 - var_51_3.now_bullet)
			end
		end

		var_51_0 = var_51_0 < 0 and 0 or math.floor(var_51_0)
		self._need_bullet_num = var_51_0

		return var_51_0
	end

	function arg_1_0:__calc_supply_fe()
		local var_52_0 = 0

		if self._is_team_content_all then
			for iter_52_0, iter_52_1 in pairs(self._init_character_list) do
				local var_52_1 = var_0_2.find_object_by_cid(iter_52_1.cid)

				for iter_52_2, iter_52_3 in pairs(iter_52_1.equips) do
					if iter_52_3.id ~= 0 and iter_52_3.carry_type ~= var_0_4.equip_carry_type.normal then
						local var_52_2 = 0

						if iter_52_3.carry_type == var_0_4.equip_carry_type.plane then
							if var_52_1.capacity_slot[iter_52_2] then
								var_52_2 = var_52_1.capacity_slot[iter_52_2] - iter_52_3.num
							end
						else
							var_52_2 = var_52_1.missile_slot[iter_52_2] - iter_52_3.num
						end

						var_52_0 = var_52_0 + var_52_2 * var_0_3.find_object_by_cid(iter_52_3.id).aluminium_use
					end
				end
			end
		else
			local var_52_3 = var_0_1:get_team_data(1, self._current_team_index)

			for iter_52_4 = 1, var_0_9(var_52_3.members) do
				local var_52_4 = var_0_1:find_character_by_id(var_52_3.members[iter_52_4])
				local var_52_5 = var_0_2.find_object_by_cid(var_52_4.cid)

				for iter_52_5, iter_52_6 in pairs(var_52_4.equips) do
					if iter_52_6.id ~= 0 and iter_52_6.carry_type ~= var_0_4.equip_carry_type.normal then
						var_52_0 = var_52_0 + (iter_52_6.carry_type == var_0_4.equip_carry_type.plane and var_52_5.capacity_slot[iter_52_5] - iter_52_6.num or var_52_5.missile_slot[iter_52_5] - iter_52_6.num) * var_0_3.find_object_by_cid(iter_52_6.id).aluminium_use
					end
				end
			end
		end

		var_52_0 = var_52_0 < 0 and 0 or math.floor(var_52_0)
		self._need_al_num = var_52_0

		return var_52_0
	end

	function arg_1_0:__calc_single_supply_oil(arg_53_1, arg_53_2)
		local var_53_0 = arg_53_2 and var_0_1:find_character_by_id(arg_53_2) or var_0_1:find_character_by_id(var_0_1:get_team_data(1, self._current_team_index).members[arg_53_1])
		local var_53_1 = 0 + var_53_0.oil - var_53_0.now_oil

		var_53_1 = 0 + var_53_0.oil - var_53_0.now_oil < 0 and 0 or math.floor(var_53_1)

		return var_53_1
	end

	function arg_1_0:__calc_single_supply_bullet(arg_54_1, arg_54_2)
		local var_54_0
		local var_54_1

		if arg_54_2 then
			var_54_0 = var_0_1:find_character_by_id(arg_54_2)
			var_54_1 = var_0_1:get_bullet_limit_by_tactic(arg_54_2)
		else
			local var_54_2 = var_0_1:get_team_data(1, self._current_team_index).members[arg_54_1]

			var_54_0 = var_0_1:find_character_by_id(var_54_2)
			var_54_1 = var_0_1:get_bullet_limit_by_tactic(var_54_2)
		end

		local var_54_3 = 0 + (var_54_1 - var_54_0.now_bullet < 0 and 0 or var_54_1 - var_54_0.now_bullet)

		var_54_3 = 0 + (var_54_1 - var_54_0.now_bullet < 0 and 0 or var_54_1 - var_54_0.now_bullet) < 0 and 0 or math.floor(var_54_3)

		return var_54_3
	end

	function arg_1_0:__calc_single_supply_fe(arg_55_1, arg_55_2)
		local var_55_0 = 0
		local var_55_1
		local var_55_2

		if arg_55_2 then
			var_55_1 = var_0_1:find_character_by_id(arg_55_2)
			var_55_2 = var_0_2.find_object_by_cid(var_55_1.cid)
		else
			var_55_1 = var_0_1:find_character_by_id(var_0_1:get_team_data(1, self._current_team_index).members[arg_55_1])
			var_55_2 = var_0_2.find_object_by_cid(var_55_1.cid)
		end

		for iter_55_0, iter_55_1 in pairs(var_55_1.equips) do
			if iter_55_1.id ~= 0 and iter_55_1.carry_type ~= var_0_4.equip_carry_type.normal then
				var_55_0 = var_55_0 + (iter_55_1.carry_type == var_0_4.equip_carry_type.plane and var_55_2.capacity_slot[iter_55_0] - iter_55_1.num or var_55_2.missile_slot[iter_55_0] - iter_55_1.num) * var_0_3.find_object_by_cid(iter_55_1.id).aluminium_use
			end
		end

		var_55_0 = var_55_0 < 0 and 0 or math.floor(var_55_0)

		return var_55_0
	end

	function arg_1_0:__calc_tol_supply()
		local var_56_0 = 0
		local var_56_1 = 0
		local var_56_2 = 0
		local var_56_3 = var_0_1:get_character_list()

		if self._is_team_content_all then
			for iter_56_0, iter_56_1 in pairs(var_56_3) do
				var_56_0 = var_56_0 + iter_56_1.oil - iter_56_1.now_oil

				local var_56_4 = var_0_1:get_bullet_limit_by_tactic(iter_56_1.id, var_56_3)

				var_56_1 = var_56_1 + (var_56_4 - iter_56_1.now_bullet < 0 and 0 or var_56_4 - iter_56_1.now_bullet)

				local var_56_5 = var_0_2.find_object_by_cid(iter_56_1.cid)

				for iter_56_2, iter_56_3 in pairs(iter_56_1.equips) do
					if iter_56_3.id ~= 0 and iter_56_3.carry_type ~= var_0_4.equip_carry_type.normal then
						local var_56_6 = 0

						if iter_56_3.carry_type == var_0_4.equip_carry_type.plane then
							if var_56_5.capacity_slot[iter_56_2] then
								var_56_6 = var_56_5.capacity_slot[iter_56_2] - iter_56_3.num
							end
						else
							var_56_6 = var_56_5.missile_slot[iter_56_2] - iter_56_3.num
						end

						var_56_2 = var_56_2 + var_56_6 * var_0_3.find_object_by_cid(iter_56_3.id).aluminium_use
					end
				end
			end
		else
			local var_56_7 = var_0_1:get_team_data(1, self._current_team_index)

			for iter_56_4 = 1, var_0_9(var_56_7.members) do
				local var_56_8 = var_0_1:find_character_by_id(var_56_7.members[iter_56_4])
				local var_56_9 = var_0_2.find_object_by_cid(var_56_8.cid)

				var_56_0 = var_56_0 + var_56_8.oil - var_56_8.now_oil

				local var_56_10 = var_0_1:get_bullet_limit_by_tactic(var_56_7.members[iter_56_4], var_56_3)

				var_56_1 = var_56_1 + (var_56_10 - var_56_8.now_bullet < 0 and 0 or var_56_10 - var_56_8.now_bullet)

				for iter_56_5, iter_56_6 in pairs(var_56_8.equips) do
					if iter_56_6.id ~= 0 and iter_56_6.carry_type ~= var_0_4.equip_carry_type.normal then
						local var_56_11 = var_0_3.find_object_by_cid(iter_56_6.id)
						local var_56_12 = 0

						if iter_56_6.carry_type == var_0_4.equip_carry_type.plane then
							if next(var_56_9.capacity_slot) then
								var_56_12 = var_56_9.capacity_slot[iter_56_5] - iter_56_6.num
							end
						else
							var_56_12 = var_56_9.missile_slot[iter_56_5] - iter_56_6.num
						end

						var_56_2 = var_56_2 + var_56_12 * var_56_11.aluminium_use
					end
				end
			end
		end

		var_56_0 = var_56_0 < 0 and 0 or math.floor(var_56_0)
		self._need_oil_num = var_56_0
		var_56_1 = var_56_1 < 0 and 0 or math.floor(var_56_1)
		self._need_bullet_num = var_56_1
		var_56_2 = var_56_2 < 0 and 0 or math.floor(var_56_2)
		self._need_al_num = var_56_2

		return var_56_0, var_56_1, var_56_2
	end

	function arg_1_0.__destroy_single_select_team_list(arg_57_0)
		arg_57_0._single_select_team_list = {}
	end

	function arg_1_0:__destroy_info_list()
		for iter_58_0, iter_58_1 in pairs(self._info_list) do
			iter_58_1:destroy()
		end

		self._info_list = {}

		self._control.bg.middle_menu.team_content_obj.fade_content.team_content.rankableLayoutGroup:OnDestroy()
	end

	function arg_1_0:__sort_table_by_rule(arg_59_1)
		if self._sort_layer and arg_59_1 and next(arg_59_1) then
			for iter_59_0, iter_59_1 in ipairs(arg_59_1) do
				iter_59_1.ship_index = var_0_2.find_object_by_cid(iter_59_1.cid).ship_index
			end
		end

		return self._sort_layer:sort_table_by_rule(arg_59_1)
	end

	function arg_1_0:__sort_table_by_type(arg_60_1)
		return self._type_layer:sort_table_by_type(arg_60_1)
	end

	function arg_1_0:play_switch_tab_animation(arg_61_1)
		if arg_61_1 then
			arg_61_1()
		end

		if not self._is_already_init then
			self:play_switch_tab_in_animation()
		else
			self:play_switch_tab_out_animation(function()
				self:play_switch_tab_in_animation(self:reset_guide_state())
			end)
		end
	end

	function arg_1_0:play_switch_tab_in_animation(arg_63_1)
		if self._control then
			self._control.bg.middle_menu.uITweenSequence:Play(function()
				if arg_63_1 then
					arg_63_1()
				end
			end)
		end
	end

	function arg_1_0:play_switch_tab_out_animation(arg_65_1)
		if self._control then
			self._control.bg.middle_menu.uITweenSequence:PlayReverse(function()
				if arg_65_1 then
					arg_65_1()
				end
			end)
		end
	end

	function arg_1_0:play_in_animation(arg_67_1)
		if self._control then
			self._control.bg.uITweenSequence:Play(function()
				if arg_67_1 then
					arg_67_1()
				end
			end)
		end
	end

	function arg_1_0:play_out_animation(arg_69_1)
		if self._control then
			self._control.bg.uITweenSequence:PlayReverse(function()
				if arg_69_1 then
					arg_69_1()
				end
			end)
		end
	end

	function arg_1_0.reset_guide_state(arg_71_0)
		if var_0_1:get_guide_state() then
			local var_71_0 = var_0_5:getInstance("guide_panel")
			local var_71_1

			if var_71_0 then
				var_71_1 = var_71_0:get_next_step()
			else
				var_71_0 = var_0_5:createInstance("guide_panel")
				var_71_1 = var_71_0:get_next_step()
			end

			if var_71_1 == var_0_4.guide_const_id.four_group.two then
				var_71_0:reset_guide_panel()
			elseif var_71_1 == var_0_4.guide_const_id.eight_group.one then
				var_71_0:reset_guide_panel_eight_one()
			end
		end
	end

	function arg_1_0:_play_into_se(arg_72_1)
		self:playSE(arg_72_1, false)
	end

	function arg_1_0:__init_reusable_cell()
		if self._reusable_cell then
			return
		end

		local var_73_0 = self._control.bg.middle_menu.team_content_all.Viewport.Content

		if math.abs(var_0_16.width / var_0_16.height - 1.3333333333333333) < 0.1 then
			self._control.bg.middle_menu.team_content_all.rectTransform.sizeDelta = Vector2(1147.6, 973.3333333333333 / (var_0_16.width / var_0_16.height))
			self._control.bg.middle_menu.team_content_all.Scrollbar.rectTransform.sizeDelta = Vector2(13, 973.3333333333333 / (var_0_16.width / var_0_16.height))
			self._control.bg.middle_menu.team_content_all.rectTransform.anchoredPosition = Vector2(-4, -45)
		end

		self._reusable_cell = gamecore.reusable_cell:create(self, var_73_0.endlessScrollView, var_73_0, "single_select_team", "dock_team", true)

		self._reusable_cell:init()
	end

	function arg_1_0.get_four_three_height(arg_74_0)
		return math.abs(var_0_16.width / var_0_16.height - 1.3333333333333333) < 0.1 and -45 or -55
	end

	function arg_1_0.__onDestroy(arg_75_0)
		return
	end

	function arg_1_0:__calculate_team_index(arg_76_1, arg_76_2)
		if not var_0_1:get_team_data(1, arg_76_1) then
			if arg_76_2 == "plus" then
				arg_76_1 = arg_76_1 + 1

				if arg_76_1 > self._max_team_index then
					arg_76_1 = self._min_team_index
				end
			elseif arg_76_2 == "minus" then
				arg_76_1 = arg_76_1 - 1

				if arg_76_1 < self._min_team_index then
					arg_76_1 = self._max_team_index
				end
			end

			return self:__calculate_team_index(arg_76_1, arg_76_2)
		else
			return arg_76_1
		end
	end

	function arg_1_0:__cancel_btn_active(arg_77_1)
		local var_77_0 = var_0_1:get_team_data(1, self._current_team_index)
		local var_77_1 = not not var_77_0
		local var_77_2 = false
		local var_77_3 = var_0_1:get_fifth_station_info()

		if arg_77_1 ~= nil then
			var_77_2 = arg_77_1
		elseif next(var_77_3) then
			for iter_77_0, iter_77_1 in pairs(var_77_3) do
				if iter_77_1 == self._current_team_index then
					var_77_2 = true
				end
			end
		else
			var_77_2 = var_77_1 and var_77_0.station or false
		end

		self._control.bg.middle_menu.cancel_station:SetActive(var_77_2)
	end

	function arg_1_0.__is_have_research_data(arg_78_0)
		local var_78_0 = var_0_1:get_ship_task_info()
		local var_78_1 = var_0_1:get_equip_task_info()

		if var_78_0 and next(var_78_0) then
			for iter_78_0, iter_78_1 in ipairs(var_78_0) do
				if iter_78_1.task_num_1 > 0 then
					return true
				end
			end
		end

		if var_78_1 and next(var_78_1) then
			for iter_78_2, iter_78_3 in ipairs(var_78_1) do
				if iter_78_3.task_num_1 > 0 then
					return true
				end
			end
		end
	end

	function arg_1_0.get_research_max_status(arg_79_0, arg_79_1)
		local var_79_0

		if not arg_79_1 then
			do return end

			var_79_0 = {}
		end

		for iter_79_0, iter_79_1 in ipairs((var_0_1:get_ship_task_info())) do
			var_0_7(var_79_0, iter_79_1)
		end

		local var_79_1 = var_0_19.find_object_by_id(arg_79_1)

		table.sort(var_79_0, function(arg_80_0, arg_80_1)
			return arg_80_0.id > arg_80_1.id
		end)

		if var_79_0 and next(var_79_0) then
			local var_79_2 = lx.ServerTime:getUtcTime()

			for iter_79_2, iter_79_3 in ipairs(var_79_0) do
				local var_79_3 = var_0_19.find_object_by_id(iter_79_3.id)

				if var_79_1.stage == var_79_3.stage and var_79_3.stage == 3 and var_79_1.ship_id == var_79_3.ship_id and iter_79_3.status == 1 then
					return arg_79_1
				elseif var_79_1.stage == var_79_3.stage and var_79_3.stage == 2 and var_79_1.ship_id == var_79_3.ship_id and iter_79_3.status == 1 then
					if var_79_2 >= iter_79_3.complete_time + var_0_4.research_ship_time then
						return arg_79_1 + 1
					else
						return arg_79_1
					end
				elseif var_79_1.stage == var_79_3.stage and var_79_3.stage == 1 and var_79_1.ship_id == var_79_3.ship_id and iter_79_3.status == 1 then
					if var_79_2 >= iter_79_3.complete_time + var_0_4.research_ship_time then
						return arg_79_1 + 1
					else
						return arg_79_1
					end
				end
			end
		end

		return arg_79_1
	end

	function arg_1_0.__is_finish_all_equip_and_finish_ship_task(arg_81_0, arg_81_1)
		local var_81_0 = false
		local var_81_1 = var_0_19.find_object_by_id(arg_81_1)
		local var_81_2 = var_0_1:get_equip_task_info()
		local var_81_3 = var_0_1:get_ship_task_info()

		if not var_81_3 or not var_81_2 then
			return var_81_0
		end

		if var_81_2 and next(var_81_2) then
			for iter_81_0, iter_81_1 in pairs(var_81_2) do
				for iter_81_2, iter_81_3 in ipairs(var_81_1.equipment) do
					if iter_81_1.id == iter_81_3 and iter_81_1.status == 0 then
						var_81_0 = true

						return true
					end
				end
			end
		end

		if var_81_3 and next(var_81_3) then
			if var_81_1.stage == 1 then
				for iter_81_4, iter_81_5 in pairs(var_81_3) do
					if iter_81_5.id == arg_81_1 + 2 and iter_81_5.status == 0 then
						var_81_0 = true

						return true
					end
				end
			elseif var_81_1.stage == 2 then
				for iter_81_6, iter_81_7 in pairs(var_81_3) do
					if iter_81_7.id == arg_81_1 + 1 and iter_81_7.status == 0 then
						var_81_0 = true

						return true
					end
				end
			elseif var_81_1.stage == 3 then
				for iter_81_8, iter_81_9 in pairs(var_81_3) do
					if iter_81_9.id == arg_81_1 and iter_81_9.status == 0 then
						var_81_0 = true

						return true
					end
				end
			end
		end

		return var_81_0
	end

	function arg_1_0:__have_research_ship_info()
		if not self:__is_have_research_data() then
			return
		end

		local var_82_0
		local var_82_1 = var_0_1:get_now_research_ship_id()
		local var_82_2 = self:get_research_max_status(var_82_1)

		if not var_82_2 then
			local var_82_3 = lx.UserData:getKeyData("first_research_ship_id")

			if var_82_3 and string.sub(var_0_1:get_account_id(), -5) == string.sub(var_82_3, -5) then
				var_82_0 = self:get_research_max_status(tonumber((string.sub(var_82_3, 1, 6))))
			end
		end

		local var_82_4

		if var_82_0 then
			var_82_4 = self:__is_finish_all_equip_and_finish_ship_task(var_82_0)
		elseif var_82_2 then
			var_82_4 = self:__is_finish_all_equip_and_finish_ship_task(var_82_2)
		end

		if var_82_4 and var_82_1 ~= var_82_0 and var_82_1 ~= var_82_2 then
			if var_82_0 then
				var_0_1:req_ResearchBoatIdReq(var_82_0)
				var_0_1:set_now_research_ship_id(var_82_0)
			elseif var_82_2 then
				var_0_1:req_ResearchBoatIdReq(var_82_2)
				var_0_1:set_now_research_ship_id(var_82_2)
			end
		end
	end

	function arg_1_0:__onReset()
		if self._control.bg.top_menu.tab_toggle.tab_3.toggle.isOn then
			self._control.bg.top_menu.tab_toggle.tab_3.toggle.isOn = false
		end

		if self._control.bg.top_menu.tab_toggle.tab_4.toggle.isOn then
			self._control.bg.top_menu.tab_toggle.tab_4.toggle.isOn = false
		end

		self._control.bg.top_menu.tab_toggle.tab_1.toggle.isOn = true
		self._current_content_type = nil
		self._current_team_index = 1
		self._single_select_team_list = {}
		self._max_team_index = nil
		self._min_team_index = 1
		self._supply_index = nil
		self._need_oil_num = 0
		self._need_bullet_num = 0
		self._need_al_num = 0
		self._is_team_content_all = false
		self._click_times = 5
		self._team_click_times = 0
		self.switch_content_not_first_team = false
		self._last_oil = nil
		self._last_bullet = nil
		self._last_fe = nil
		self._last_al = nil
		self._dock_tween_list = {}
		self._init_character_list = {}
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_84_0)
	local var_84_0 = var_0_5:class("dock_team")

	var_84_0._is_already_init = false
	var_84_0._current_content_type = nil
	var_84_0._current_team_index = 1
	var_84_0._info_list = {}
	var_84_0._single_select_team_list = {}
	var_84_0._max_team_index = nil
	var_84_0._min_team_index = 1
	var_84_0._team_data = {}
	var_84_0._supply_index = nil
	var_84_0._need_oil_num = 0
	var_84_0._need_bullet_num = 0
	var_84_0._need_al_num = 0
	var_84_0._is_team_content_all = false
	var_84_0._click_times = 5
	var_84_0.switch_content_not_first_team = false
	var_84_0._last_oil = nil
	var_84_0._last_bullet = nil
	var_84_0._last_fe = nil
	var_84_0._last_al = nil
	var_84_0._reusable_cell = nil
	var_84_0._dock_tween_list = {}
	var_84_0._init_character_list = {}
	var_84_0._cur_seq = nil
	var_84_0._is_short_into = false
	var_84_0._team_click_times = 0
	var_84_0._is_custom_panel = false

	gamecore.extend_obj(var_84_0)

	return var_84_0
end

return var_0_0
