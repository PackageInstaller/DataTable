local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = table.insert
local var_0_3 = gamecore.Language
local var_0_4 = gamecore.UILoader
local var_0_5 = DG.Tweening.DOTween
local var_0_6 = string.format
local var_0_7 = lx.clone_table
local var_0_8 = gameenum.common_type
local var_0_9 = gamecore.reusable_cell
local var_0_10 = table.remove
local var_0_11 = gamecore.prompt
local var_0_12 = gamecore.util_func
local var_0_13 = gameconfig.ship_config

gamecore.UILoader:define("abyss_select_member", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
		self._enter_ship_id = arg_2_1
		self._no_fast_team = arg_2_2
		self._is_abyss_dock_team_synthesis = arg_2_6 == true and arg_2_6 or false
		self._filter_team = self:_init_filter(arg_2_3 or {})
		self._callback = arg_2_4
		self._long_click_callback = arg_2_5

		self:setVisible(true)
		self:_play_into_se(var_0_8:get_audio_url(var_0_8.common_icon.music_path, var_0_8.open))
		self:__init_panel()
		self:play_enlarge_animation()

		local var_2_0 = var_0_4:getInstance("fight_prepare")

		if var_2_0 then
			self._panel.transform:GetComponent("Canvas").sortingOrder = var_2_0._panel.transform:GetComponent("Canvas").sortingOrder + 1
		end
	end

	function arg_1_0:update_content()
		self._control.fast_btn.changefleetfast.text.text = self._is_fast_formation and var_0_3:getNowLang("changefleetnormal") or var_0_3:getNowLang("changefleetfast")

		self._control.confirm_btn:SetActive(self._is_fast_formation)

		if self._is_abyss_dock_team_synthesis then
			self._control.confirm_btn:SetActive(self._is_abyss_dock_team_synthesis)
		end

		if self._show_detail_state == 2 then
			self._control.detail_btn.image.sprite = self:loadSprite(var_0_8.ship_detail_switch.open)
			self._control.detail_btn.detail_status.text.text = var_0_3:getNowLang("detailtypeopen")
		elseif self._show_detail_state == 1 then
			self._control.detail_btn.image.sprite = self:loadSprite(var_0_8.ship_detail_switch.close)
			self._control.detail_btn.detail_status.text.text = var_0_3:getNowLang("detailtypeclose")
		end

		self:__update_data()
		self:__update_reusable_cell()
	end

	function arg_1_0.set_back_func(arg_4_0, arg_4_1)
		arg_4_0._back_func = arg_4_1
	end

	function arg_1_0.set_enter_team(arg_5_0, arg_5_1)
		if not arg_5_1 then
			return
		end

		arg_5_0._enter_team = arg_5_1
	end

	function arg_1_0.set_synthesis_enter_team(arg_6_0, arg_6_1)
		if not arg_6_1 then
			return
		end

		arg_6_0._synthesis_enter_team = arg_6_1
	end

	function arg_1_0.close_formation_layer(arg_7_0)
		arg_7_0._donot_show_formation_layer = true
	end

	function arg_1_0.open_formation_layer(arg_8_0)
		arg_8_0._donot_show_formation_layer = false
	end

	function arg_1_0:set_right_up_text(arg_9_1)
		self._control.bg_container.select_team_basic.text.text = arg_9_1 or ""
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self:__init_language()

			self._sort_layer = self:loadUI("sort_layer")

			self._sort_layer._panel.transform:SetParent(self._control.sort_layer.transform)
			self._sort_layer:close_preference_screening_visible(true)
			self._sort_layer:set_listener(self, self.__sort_order_btn_callback)
			self._sort_layer:show(false)

			self._type_layer = self:loadUI("type_layer")

			self._type_layer._panel.transform:SetParent(self._control.type_layer.transform)
			self._type_layer:set_character_group_visible(true)
			self._type_layer:set_listener(self, self.__sort_type_btn_callback)
			self._type_layer:show(false)

			if not self._reusable_cell then
				self._reusable_cell = var_0_9:create(self, self._control.all_ship.Viewport.edge_mask.Content.endlessScrollView, self._control.all_ship.Viewport.edge_mask.Content, "select_abyss_item", "abyss_select_member", false)

				self._reusable_cell:init()
			end

			self._back_func = nil
			self._is_fast_formation = nil
			self._show_detail_state = 1
			self._enter_team = nil
			self._synthesis_enter_team = nil
			self._is_already_init = true
		end

		self._control.fast_btn.gameObject:SetActive(not self._no_fast_team)
		self:update_content()
	end

	function arg_1_0:_init_filter(arg_11_1)
		local var_11_0 = {}

		if self._is_abyss_dock_team_synthesis then
			local var_11_1 = var_0_7(self._synthesis_enter_team)

			if var_11_1 then
				if var_11_1[1] then
					var_0_2(arg_11_1, var_11_1[1].id)
				end

				if var_11_1[2] then
					var_0_2(arg_11_1, var_11_1[2].id)
				end
			end

			for iter_11_0, iter_11_1 in pairs(arg_11_1) do
				var_11_0[iter_11_1] = true
			end
		else
			for iter_11_2, iter_11_3 in pairs(arg_11_1) do
				var_11_0[iter_11_3] = true
			end
		end

		return var_11_0
	end

	function arg_1_0:__update_data()
		if self._is_fast_formation then
			self:close_formation_layer()
		else
			self:open_formation_layer()
		end

		self._exit_btn = nil
		self._all_character = var_0_7(var_0_1:get_abyss_character_list()) or {}

		local var_12_0 = {}

		self._fast_team_list = {}
		self._fast_team_list_for_cid = {}
		self._synthesis_team_list = var_0_7(self._synthesis_enter_team)
		self._synthesis_team_list_for_cid = {}

		for iter_12_0, iter_12_1 in pairs(self._all_character) do
			if self._is_fast_formation then
				if self._enter_team then
					local var_12_1

					for iter_12_2, iter_12_3 in ipairs(self._enter_team) do
						if iter_12_3.id == iter_12_1.id then
							iter_12_1._team_idx = iter_12_2
							self._fast_team_list[iter_12_2] = iter_12_1
							self._fast_team_list_for_cid[iter_12_1.evo_cid] = true
							var_12_1 = true

							break
						end
					end

					if not var_12_1 then
						var_0_2(var_12_0, iter_12_1)
					end
				else
					var_0_2(var_12_0, iter_12_1)
				end
			else
				local var_12_2

				if self._enter_ship_id and iter_12_1.id == self._enter_ship_id then
					self._exit_btn = var_0_7(iter_12_1)
					self._exit_btn._is_exit = true
					var_12_2 = true
				end

				if not var_12_2 and not self._filter_team[iter_12_1.id] then
					var_0_2(var_12_0, iter_12_1)
				end
			end
		end

		self._all_character = var_12_0
		self._filtered_character = self._type_layer:sort_table_by_type(self._all_character) or {}
		self._sorted_character = self._is_default_sort and (self._sort_layer:abyss_special_sort_table_by_rule(self._filtered_character, true, self._control.sort_order_btn.sort_txt) or {}) or self._sort_layer:abyss_special_sort_table_by_rule(self._filtered_character) or {}

		if self._exit_btn and not self._is_fast_formation then
			var_0_2(self._sorted_character, 1, self._exit_btn)
		end

		if self._is_fast_formation then
			for iter_12_4, iter_12_5 in ipairs(self._fast_team_list) do
				var_0_2(self._sorted_character, iter_12_4, iter_12_5)
			end
		end

		if self._is_abyss_dock_team_synthesis then
			for iter_12_6, iter_12_7 in ipairs(self._synthesis_team_list) do
				var_0_2(self._sorted_character, iter_12_6, iter_12_7)
			end
		end
	end

	function arg_1_0:__reset_ship_team_index()
		if not self._fast_team_list then
			return
		end

		for iter_13_0, iter_13_1 in ipairs(self._fast_team_list) do
			iter_13_1._team_idx = iter_13_0
		end
	end

	function arg_1_0:__reset_synthesis_ship_team_index()
		if not self._synthesis_team_list then
			return
		end

		for iter_14_0, iter_14_1 in ipairs(self._synthesis_team_list) do
			iter_14_1._team_idx = iter_14_0
		end
	end

	function arg_1_0:__sort_order_btn_callback(arg_15_1)
		self._is_default_sort = false

		self._sort_layer:change_sort_text(self._control.sort_order_btn.sort_txt, arg_15_1)
		self:update_content()
	end

	function arg_1_0:__sort_type_btn_callback()
		self._type_layer:change_type_text(self._control.sort_type_btn.sort_txt)
		self:update_content()
	end

	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0:play_enlarge_animation()
		if self._enter_req then
			return
		end

		self._enter_req = self:autoKillDOTween(var_0_5.Sequence())

		local var_18_0 = self._panel.transform:GetComponent("CanvasGroup")

		var_18_0.blocksRaycasts = false
		self._control.all_ship.transform.parent.localScale = Vector3.New(0, 0, 0)

		self._enter_req:Append(self._control.all_ship.transform.parent:DOScale(1, 0.3):SetEase(DG.Tweening.Ease.OutBack):OnComplete(function()
			var_18_0.blocksRaycasts = true
			self._enter_req = nil
		end))
		self._enter_req:Play()
	end

	function arg_1_0:__init_language()
		self._control.sort_order_btn.sorttype.text.text = var_0_3:getNowLang("sorttype")
		self._control.sort_order_btn.sort_txt.text.text = var_0_3:getNowLang("sorttypes3")
		self._control.sort_type_btn.type.text.text = var_0_3:getNowLang("type")
		self._control.sort_type_btn.sort_txt.text.text = var_0_3:getNowLang("questall")
		self._control.detail_btn.pvpdetailbtn.text.text = var_0_3:getNowLang("pvpdetailbtn")
		self._control.confirm_btn.confirm.text.text = var_0_3:getNowLang("confirm")
		self._control.fast_btn.changefleetfast.text.text = var_0_3:getNowLang("changefleetfast")
		self._control.bg_container.select_team_basic.text.text = var_0_3:getNowLang("ui_ny21_select_team")
	end

	function arg_1_0:__update_reusable_cell()
		if not self._reusable_cell then
			return
		end

		local var_21_0 = self._sorted_character

		if not self._sorted_character then
			return
		end

		self._reusable_cell:set_data(var_21_0)

		function self._reusable_cell:_set_func(arg_22_1)
			local var_22_0 = arg_22_1 + 1
			local var_22_1 = var_0_13.find_abyss_object_by_cid(var_21_0[arg_22_1 + 1].cid)

			self.BG.all_layer.evo_image:SetActive(var_22_1.evo_class)

			self.BG.image.sprite = self:loadSprite(var_0_8.fight_prepare_ship_item.ship_leave)

			if var_21_0[arg_22_1 + 1].atk <= var_22_1.atk then
				var_0_12:caculate_ship_attr_with_equips(var_21_0[arg_22_1 + 1])
			end

			if var_21_0[arg_22_1 + 1] then
				if var_21_0[arg_22_1 + 1]._is_exit then
					self.BG.all_layer.gameObject:SetActive(false)
				else
					self.BG.all_layer.gameObject:SetActive(true)
					self.BG.all_layer.ship_level_image.gameObject:SetActive(false)
					self.BG.all_layer.love_layer.gameObject:SetActive(false)
					self.BG.all_layer.formation_type_layer.level_layer.lock_tag.gameObject:SetActive(false)
					self.BG.all_layer.formation_layer.gameObject:SetActive(false)

					self.BG.all_layer.icon_layer.image.sprite = var_21_0[arg_22_1 + 1].boss == 1 and self:loadSprite(var_0_8.abyss_select_member_ground_2) or self:loadSprite(var_0_8.abyss_select_member_ground_1)
					self.BG.all_layer.icon_layer.icon.image.sprite = self:loadSprite(var_0_8:get_ship_icon(var_0_8.ship_icon.model_normal_xm, var_21_0[arg_22_1 + 1].pic_id))

					self.BG.all_layer.formation_type_layer.info_layer.textHorizonScroller:SetText(var_21_0[arg_22_1 + 1].name)

					if self._show_detail_state == 2 then
						self.BG.all_layer.formation_type_layer.detail_layer.txt_1.tip.text.text = var_0_3:getNowLang("atk")
						self.BG.all_layer.formation_type_layer.detail_layer.txt_1.num.text.text = var_21_0[arg_22_1 + 1].atk
						self.BG.all_layer.formation_type_layer.detail_layer.txt_2.tip.text.text = var_0_3:getNowLang("torpedo")
						self.BG.all_layer.formation_type_layer.detail_layer.txt_2.num.text.text = var_21_0[arg_22_1 + 1].torpedo
						self.BG.all_layer.formation_type_layer.detail_layer.txt_3.tip.text.text = var_0_3:getNowLang("def")
						self.BG.all_layer.formation_type_layer.detail_layer.txt_3.num.text.text = var_21_0[arg_22_1 + 1].def
						self.BG.all_layer.formation_type_layer.detail_layer.txt_4.tip.text.text = var_0_3:getNowLang("air_def")
						self.BG.all_layer.formation_type_layer.detail_layer.txt_4.num.text.text = var_21_0[arg_22_1 + 1].air_def

						self.BG.all_layer.formation_type_layer.level_layer.gameObject:SetActive(false)
						self.BG.all_layer.formation_type_layer.detail_layer.gameObject:SetActive(true)
					elseif self._show_detail_state == 3 then
						self.BG.all_layer.formation_type_layer.detail_layer.txt_1.tip.text.text = var_0_3:getNowLang("radar")
						self.BG.all_layer.formation_type_layer.detail_layer.txt_1.num.text.text = var_21_0[arg_22_1 + 1].radar
						self.BG.all_layer.formation_type_layer.detail_layer.txt_2.tip.text.text = var_0_3:getNowLang("shiptype")
						self.BG.all_layer.formation_type_layer.detail_layer.txt_2.num.text.text = var_0_8:get_ship_size_language(var_21_0[arg_22_1 + 1].type)
						self.BG.all_layer.formation_type_layer.detail_layer.txt_3.tip.text.text = var_0_3:getNowLang("luck")
						self.BG.all_layer.formation_type_layer.detail_layer.txt_3.num.text.text = var_21_0[arg_22_1 + 1].luck
						self.BG.all_layer.formation_type_layer.detail_layer.txt_4.tip.text.text = var_0_3:getNowLang("speed")
						self.BG.all_layer.formation_type_layer.detail_layer.txt_4.num.text.text = var_21_0[arg_22_1 + 1].speed
					else
						self.BG.all_layer.formation_type_layer.level_layer.type_txt.text.text = var_0_3:getNowLang(var_0_8:get_ship_type_language_key(var_21_0[arg_22_1 + 1].type))
						self.BG.all_layer.formation_type_layer.level_layer.country_txt.text.text = var_0_6("(%s)", var_0_3:getNowLang(var_0_8:get_country_language_key(var_21_0[arg_22_1 + 1].country)))
						self.BG.all_layer.formation_type_layer.level_layer.level_txt.text.text = var_0_6("Lv.%s", var_21_0[arg_22_1 + 1].level)

						for iter_22_0 = 1, 7 do
							self.BG.all_layer.formation_type_layer.level_layer.star_layer["star_" .. iter_22_0].gameObject:SetActive(iter_22_0 <= var_21_0[arg_22_1 + 1].star)
						end

						self.BG.all_layer.formation_type_layer.level_layer.gameObject:SetActive(true)
						self.BG.all_layer.formation_type_layer.detail_layer.gameObject:SetActive(false)
					end

					if self._is_fast_formation then
						if self._enter_team then
							for iter_22_1, iter_22_2 in ipairs(self._enter_team) do
								if iter_22_2.id == var_21_0[arg_22_1 + 1].id then
									self.BG.all_layer.formation_layer.gameObject:SetActive(false)

									break
								end
							end
						end

						if var_21_0[arg_22_1 + 1]._team_idx then
							self.BG.all_layer.mask_img.number_info.num.text.text = var_21_0[arg_22_1 + 1]._team_idx

							self.BG.all_layer.mask_img.gameObject:SetActive(true)
						else
							self.BG.all_layer.mask_img.gameObject:SetActive(false)
						end
					else
						self.BG.all_layer.mask_img.gameObject:SetActive(false)

						if not self._donot_show_formation_layer then
							if self._enter_team then
								for iter_22_3, iter_22_4 in ipairs(self._enter_team) do
									if iter_22_4.id == var_21_0[arg_22_1 + 1].id then
										self.BG.all_layer.formation_layer.gameObject:SetActive(true)

										break
									end
								end
							end
						else
							self.BG.all_layer.formation_layer.gameObject:SetActive(false)
						end
					end

					if self._is_abyss_dock_team_synthesis == true then
						if self._synthesis_enter_team then
							for iter_22_5, iter_22_6 in ipairs(self._synthesis_enter_team) do
								if iter_22_6.id == var_21_0[arg_22_1 + 1].id then
									self.BG.all_layer.mask_img.number_info.num.text.text = var_21_0[arg_22_1 + 1]._team_idx

									self.BG.all_layer.mask_img:SetActive(true)

									break
								end
							end
						end

						if var_21_0[arg_22_1 + 1]._team_idx then
							self.BG.all_layer.mask_img.number_info.num.text.text = var_21_0[arg_22_1 + 1]._team_idx

							self.BG.all_layer.mask_img.gameObject:SetActive(true)
						else
							self.BG.all_layer.mask_img.gameObject:SetActive(false)
						end
					end
				end

				self.BG.clickAndLongClickEvent.onClick:RemoveAllListeners()
				self.BG.clickAndLongClickEvent.onClick:AddListener(function()
					if self._is_fast_formation then
						if var_21_0[var_22_0]._team_idx then
							var_0_10(self._fast_team_list, var_21_0[var_22_0]._team_idx)

							self._fast_team_list_for_cid[var_21_0[var_22_0].evo_cid] = nil
							var_21_0[var_22_0]._team_idx = nil

							self:__reset_ship_team_index()
							self:__update_reusable_cell()

							return
						end

						if #self._fast_team_list >= 6 then
							var_0_11:show(var_0_6(var_0_3:getNowLang("selectstrenmaterialmax"), 6))

							return
						end

						if self._fast_team_list_for_cid[var_21_0[var_22_0].evo_cid] then
							var_0_11:show(var_0_3:getNowLang("formation_tip1"))

							return
						end

						var_21_0[var_22_0]._team_idx = #self._fast_team_list + 1

						var_0_2(self._fast_team_list, var_21_0[var_22_0])

						self._fast_team_list_for_cid[var_21_0[var_22_0].evo_cid] = true

						self:__update_reusable_cell()
					elseif self._is_abyss_dock_team_synthesis then
						if var_21_0[var_22_0]._team_idx then
							var_0_10(self._synthesis_team_list, var_21_0[var_22_0]._team_idx)

							self._synthesis_team_list_for_cid[var_21_0[var_22_0].evo_cid] = nil
							var_21_0[var_22_0]._team_idx = nil

							self:__reset_synthesis_ship_team_index()
							self:__update_reusable_cell()

							return
						end

						if #self._synthesis_team_list >= 2 then
							var_0_11:show(var_0_6(var_0_3:getNowLang("selectstrenmaterialmax"), 2))

							return
						end

						var_21_0[var_22_0]._team_idx = #self._synthesis_team_list + 1

						var_0_2(self._synthesis_team_list, var_21_0[var_22_0])

						self._synthesis_team_list_for_cid[var_21_0[var_22_0].evo_cid] = true

						self:__update_reusable_cell()
					else
						self:setVisible(false)

						self._is_fast_formation = false
						self._show_detail_state = 1

						if self._callback then
							self._callback({
								var_21_0[var_22_0]
							})
						end

						if self._back_func then
							self._back_func()
						end
					end
				end)
				self.BG.clickAndLongClickEvent.onLongClick:RemoveAllListeners()

				if not var_21_0[arg_22_1 + 1]._is_exit then
					self.BG.clickAndLongClickEvent.onLongClick:AddListener(function()
						if self._long_click_callback then
							self._long_click_callback(var_21_0[var_22_0])

							return
						end

						var_0_4:createInstance("abyss_ship_detail"):show(var_0_8.enter_ship_detail_type.abyss_single_ship, var_21_0[var_22_0])
					end)
				end
			end
		end
	end

	function arg_1_0:_play_into_se(arg_25_1)
		self:playSE(arg_25_1, false)
	end

	function arg_1_0:__onReset()
		self._control.bg_container.select_team_basic.text.text = var_0_3:getNowLang("ui_ny21_select_team")
		self._enter_ship_id = {}
		self._is_already_init = false
		self._is_fast_formation = false
		self._donot_show_formation_layer = false
		self._show_detail_state = 1
		self._long_click_callback = nil
		self._callback = nil
		self._filter_team = {}
		self._no_fast_team = nil
		self._is_default_sort = true

		self._sort_layer:reset_select_state()
		self._type_layer:reset_select_state()
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_27_0)
	local var_27_0 = var_0_4:class("abyss_select_member")

	var_27_0._enter_ship_id = {}
	var_27_0._is_already_init = false
	var_27_0._is_fast_formation = false
	var_27_0._reusable_cell = nil
	var_27_0._is_default_sort = true
	var_27_0._is_already_add_aquip = true
	var_27_0._is_abyss_dock_team_synthesis = false

	gamecore.extend_obj(var_27_0)

	return var_27_0
end

return var_0_0
