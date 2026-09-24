local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = gameenum.common_type
local var_0_5 = gamecore.util_func
local var_0_6 = string.format
local var_0_8 = table.insert
local var_0_9 = UnityEngine.Vector2
local var_0_10 = UnityEngine.Color
local var_0_14 = math.floor
local var_0_15 = gameconfig.sixth_map_node_config
local var_0_16 = gameconfig.sixth_map_config
local var_0_17 = lx.json_decode
local var_0_18 = gameconfig.sixth_adjutant_config
local var_0_19 = UnityEngine.Input
local var_0_20 = UnityEngine.RectTransformUtility
local var_0_21 = 0
local var_0_22 = string.sub
local var_0_23 = gameconfig.item_config
local var_0_24 = gameconfig.ship_pve_active_config
local var_0_25 = gameconfig.ship_config
local var_0_26 = gameconfig.equip_config
local var_0_27 = gamecore.prompt
local var_0_29 = gameconfig.sixth_combat_chapter_config
local var_0_30 = gameconfig.sixth_combat_buff_config
local var_0_31 = next

gamecore.UILoader:define("sixth_map_node", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)

		self._data = arg_2_1

		self:__init_panel(arg_2_1)
		var_0_3:set_to_six_fight_map(true)
	end

	function arg_1_0:show_sixth_input_node()
		local var_3_0 = var_0_3:get_account_id()

		if not app:isPC() then
			return
		end

		self._control.input_node:SetActive(true)
	end

	function arg_1_0:get_input_map_node()
		return tonumber(self._control.input_node.field.inputField.text)
	end

	function arg_1_0.get_map_all_info(arg_5_0, arg_5_1)
		local var_5_0 = {}

		for iter_5_0, iter_5_1 in pairs((var_0_15.get_sequence())) do
			if iter_5_1 and iter_5_1.pve_level_id == arg_5_1 then
				var_0_8(var_5_0, iter_5_1)
			end
		end

		return var_5_0
	end

	function arg_1_0.__close_panel(arg_6_0)
		var_0_2:destroyInstance("sixth_map_node")

		local var_6_0 = var_0_2:getInstance("six_year_main_interface")

		if var_6_0 then
			var_6_0:setVisible(false)
		end
	end

	function arg_1_0:__onUpdate()
		if var_0_19.GetMouseButton(0) and self._is_drag then
			var_0_21 = Time.deltaTime + var_0_21

			local var_7_0, var_7_1 = var_0_20.ScreenPointToLocalPointInRectangle(self._uiroot_canvas_rect, var_0_19.mousePosition, self._ui_camera, nil)

			if var_0_21 >= 0.1 and var_7_1.x ~= self._mouse_positionX then
				self:on_point_down_event()
			end
		end

		if self._is_drag_end then
			self:on_point_down_end_event()
		end
	end

	function arg_1_0:_get_end_point(arg_8_1)
		local var_8_0 = var_0_3:get_sixth_combat_info()

		for iter_8_0, iter_8_1 in pairs((var_0_15.get_sequence())) do
			if iter_8_1.id == arg_8_1 and #iter_8_1.next_node == 0 then
				for iter_8_2, iter_8_3 in pairs(var_8_0.point_grade) do
					if iter_8_3.point == iter_8_1.id then
						var_0_3:set_pass_id(arg_8_1)
						self._control.six_msgbox.gameObject:SetActive(true)
						var_0_4:play_in_out_animation(self._control.six_msgbox.black.uITweenSequence, true, function()
							self:select_msgbox(true)
							self._control.six_msgbox.main.gameObject:SetActive(true)

							if not self._control.six_msgbox.main.right.light.activeSelf then
								self._control.six_msgbox.main.left.light:SetActive(true)
								self._control.six_msgbox.main.left.select:SetActive(true)
							end
						end)
						self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))

						local var_8_1
						local var_8_2

						for iter_8_4, iter_8_5 in pairs(self._point_list) do
							if iter_8_4 == arg_8_1 then
								var_8_1 = iter_8_5
							end
						end

						for iter_8_6, iter_8_7 in pairs(self._now_map_point_list) do
							if iter_8_7.id == arg_8_1 then
								var_8_2 = iter_8_7.award[1]
							end
						end

						if self._save_activeDoubleCount and var_8_0.fleetdecisive_buff and var_8_0.fleetdecisive_buff ~= 0 then
							local var_8_3 = var_0_30.find_object_by_id(var_8_0.fleetdecisive_buff)

							if var_8_3 then
								for iter_8_8, iter_8_9 in pairs(var_8_3.effect) do
									if iter_8_9.type == 13 and var_8_1 and var_8_2 then
										var_8_1.node_image.reward_bg.reward_count.text.text = var_0_6("%s/%s", math.ceil(math.ceil(var_0_4.sixth_reward_coe[var_0_6("score_%s", var_0_4.rank_sore[iter_8_3.grade])] * var_8_2.value) * self._save_activeDoubleCount * (iter_8_9.num * 0.01 + 1)), var_8_2.value)
									end
								end
							end
						end
					end
				end
			end
		end
	end

	function arg_1_0:_get_other_add_point(arg_10_1, arg_10_2)
		if not self._save_activeDoubleCount then
			return
		end

		if not arg_10_1 then
			return
		end

		local var_10_0
		local var_10_1

		for iter_10_0, iter_10_1 in pairs(self._point_list) do
			if iter_10_0 == arg_10_1 then
				var_10_0 = iter_10_1
			end
		end

		for iter_10_2, iter_10_3 in pairs(self._now_map_point_list) do
			if iter_10_3.id == arg_10_1 then
				var_10_1 = iter_10_3.award[1]
			end
		end

		if arg_10_2 and #arg_10_2 then
			for iter_10_4, iter_10_5 in pairs(arg_10_2) do
				if iter_10_5.id == 23 and var_10_0 and var_10_1 then
					var_10_0.node_image.reward_bg.reward_count.text.text = iter_10_5.count .. "/" .. var_10_1.value
				end
			end
		end
	end

	function arg_1_0:set_buff_two_info()
		self._save_now_change = nil
		self._sixth_combat_info = var_0_3:get_sixth_combat_info()
		self._control.activity_select_two_buff.bg_image.bg.tip.text.text = var_0_1:getNowLang("combat_buff_desc")
		self._control.activity_select_two_buff.top.title_txt.text.text = var_0_1:getNowLang("combat_buff_choose")
		self._control.activity_select_two_buff.bottom.close.title.text.text = var_0_1:getNowLang("settingoff")
		self._control.activity_select_two_buff.bottom.confirm.title.text.text = var_0_1:getNowLang("ui_okbtntip")
		self._now_buff_array = {
			buff_1 = self._control.activity_select_two_buff.buff_array.buff_1,
			buff_2 = self._control.activity_select_two_buff.buff_array.buff_2,
			buff_3 = self._control.activity_select_two_buff.buff_array.buff_3
		}

		for iter_11_0, iter_11_1 in pairs(self._now_buff_array) do
			self._now_buff_array[iter_11_0].bottom_change:SetActive(true)
			self._now_buff_array[iter_11_0].bottom_use:SetActive(false)
			self._now_buff_array[iter_11_0].select:SetActive(false)
			self._now_buff_array[iter_11_0].no_money:SetActive(true)
		end

		local var_11_0

		if self._sixth_combat_info.big_id then
			var_11_0 = var_0_29.find_object_by_id(self._sixth_combat_info.big_id)
			self._now_map_buff = var_11_0
		end

		self._control.activity_select_two_buff.top.coin.coin_count.text.text = self._sixth_combat_info.coin

		local var_11_1 = {}

		if var_11_0.chapter_buff and var_0_31(var_11_0.chapter_buff) then
			local var_11_2 = var_11_0.chapter_buff
			local var_11_3 = "2997FFFF"

			for iter_11_2 = 1, var_0_5.dict_lenght(self._now_buff_array) do
				local var_11_4 = var_0_30.find_object_by_id(var_11_2[iter_11_2])

				self._now_buff_array["buff_" .. iter_11_2].buff_name.text.text = var_11_4.title
				self._now_buff_array["buff_" .. iter_11_2].buff_img.image.sprite = self:loadSprite(var_0_6(var_0_4.sixth_new_buff, var_11_4.buff_id))
				self._now_buff_array["buff_" .. iter_11_2].buff_bg.image.sprite = self:loadSprite(var_0_6(var_0_4.sixth_new_buff_bg, 0))
				self._now_buff_array["buff_" .. iter_11_2].bottom_change.num.text.text = var_11_4.strategic_point
				self._now_buff_array["buff_" .. iter_11_2].bottom_change.image.color = var_0_10.New(0.5333333333333333, 0.5333333333333333, 0.5333333333333333, 1)
				self._now_buff_array["buff_" .. iter_11_2].bottom_change.text_1.text.color = var_0_10.New(0.8745098039215686, 0.06274509803921569, 0.32941176470588235, 1)
				self._now_buff_array["buff_" .. iter_11_2].bottom_change.num.text.color = var_0_10.New(0.8745098039215686, 0.06274509803921569, 0.32941176470588235, 1)

				if var_11_4.level_buff_desc[1] then
					self._now_buff_array["buff_" .. iter_11_2].buff_text.buff_text_2:SetActive(true)

					self._now_buff_array["buff_" .. iter_11_2].buff_text.buff_text_1.text.text = var_0_6("<size=13>%s</size>", "◆") .. var_0_5.convert_rich_text(var_11_4.level_buff_desc[1], var_11_3)
				else
					self._now_buff_array["buff_" .. iter_11_2].buff_text.buff_text_1:SetActive(false)
				end

				if var_11_4.level_buff_desc[2] then
					self._now_buff_array["buff_" .. iter_11_2].buff_text.buff_text_2:SetActive(true)

					self._now_buff_array["buff_" .. iter_11_2].buff_text.buff_text_2.text.text = var_0_6("<size=13>%s</size>", "◆") .. var_0_5.convert_rich_text(var_11_4.level_buff_desc[2], var_11_3)
				else
					self._now_buff_array["buff_" .. iter_11_2].buff_text.buff_text_2:SetActive(false)
				end

				if var_11_4.level_buff_desc[3] then
					self._now_buff_array["buff_" .. iter_11_2].buff_text.buff_text_3:SetActive(true)

					self._now_buff_array["buff_" .. iter_11_2].buff_text.buff_text_3.text.text = var_0_6("<size=13>%s</size>", "◆") .. var_0_5.convert_rich_text(var_11_4.level_buff_desc[3], var_11_3)
				else
					self._now_buff_array["buff_" .. iter_11_2].buff_text.buff_text_3:SetActive(false)
				end

				if self._sixth_combat_info.coin >= var_11_4.strategic_point then
					self._now_buff_array["buff_" .. iter_11_2].bottom_change.image.color = var_0_10.New(0.1411764705882353, 0.5686274509803921, 0.9725490196078431, 1)
					self._now_buff_array["buff_" .. iter_11_2].bottom_change.text_1.text.color = var_0_10.New(1, 1, 1, 1)
					self._now_buff_array["buff_" .. iter_11_2].bottom_change.num.text.color = var_0_10.New(1, 1, 1, 1)

					self._now_buff_array["buff_" .. iter_11_2].no_money:SetActive(false)

					self._now_buff_array["buff_" .. iter_11_2].buff_bg.image.sprite = self:loadSprite(var_0_6(var_0_4.sixth_new_buff_bg, 1))
				end

				var_0_8(var_11_1, var_11_2[iter_11_2])
			end
		end

		self._click_array = var_11_1
		self._now_change_k = 0

		if self._sixth_combat_info.fleetdecisive_buff == 0 then
			return
		elseif self._click_array and var_0_31(self._click_array) then
			for iter_11_3, iter_11_4 in pairs(self._click_array) do
				if self._sixth_combat_info.fleetdecisive_buff == iter_11_4 then
					self._now_change_k = iter_11_3

					self._now_buff_array["buff_" .. iter_11_3].bottom_use:SetActive(true)
					self._now_buff_array["buff_" .. iter_11_3].select:SetActive(true)
					self._now_buff_array["buff_" .. iter_11_3].no_money:SetActive(false)

					self._now_buff_array["buff_" .. iter_11_3].buff_bg.image.sprite = self:loadSprite(var_0_6(var_0_4.sixth_new_buff_bg, 2))
				end
			end
		end
	end

	function arg_1_0:_set_new_buff_icon()
		self._control.buff_btn.buff_icon.image.sprite = self:loadSprite(var_0_6(var_0_4.sixth_new_buff_normal))

		local var_12_0 = var_0_3:get_sixth_combat_info()

		if var_12_0.fleetdecisive_buff == 0 then
			return
		else
			self._control.buff_btn.buff_icon.image.sprite = self:loadSprite(var_0_6(var_0_4.sixth_new_buff, var_0_30.find_object_by_id(var_12_0.fleetdecisive_buff).buff_id))
		end
	end

	function arg_1_0:_set_click_btn(arg_13_1, arg_13_2)
		local var_13_0 = var_0_30.find_object_by_id(arg_13_2)

		for iter_13_0, iter_13_1 in pairs(self._now_buff_array) do
			self._now_buff_array[iter_13_0].bottom_change:SetActive(true)
			self._now_buff_array[iter_13_0].bottom_use:SetActive(false)
			self._now_buff_array[iter_13_0].select:SetActive(false)
		end

		if self._now_change_k and self._now_change_k == arg_13_1 then
			self._now_buff_array["buff_" .. arg_13_1].bottom_use:SetActive(true)
		end

		for iter_13_2, iter_13_3 in pairs(self._click_array) do
			if self._sixth_combat_info.fleetdecisive_buff == iter_13_3 then
				self._now_buff_array["buff_" .. iter_13_2].bottom_use:SetActive(true)
			end
		end

		self._now_buff_array["buff_" .. arg_13_1].select:SetActive(true)
	end

	function arg_1_0:_confirm_click_btn(arg_14_1, arg_14_2)
		if not arg_14_2 and not arg_14_1 and self._now_change_k == 0 then
			var_0_27:show(var_0_1:getNowLang("combat_not_choose_buff"))
		end

		if not arg_14_2 then
			return
		end

		local var_14_0 = var_0_30.find_object_by_id(arg_14_2)

		if self._now_change_k == self._save_now_change or not arg_14_1 then
			return
		end

		if self._sixth_combat_info.coin < var_14_0.strategic_point then
			var_0_27:show(var_0_1:getNowLang("coin_notenough"))

			return
		end

		for iter_14_0, iter_14_1 in pairs(self._now_buff_array) do
			self._now_buff_array[iter_14_0].bottom_change:SetActive(true)
			self._now_buff_array[iter_14_0].bottom_use:SetActive(false)
			self._now_buff_array[iter_14_0].select:SetActive(false)
		end

		if self._now_change_k and self._now_change_k == arg_14_1 then
			self._now_buff_array["buff_" .. arg_14_1].bottom_use:SetActive(true)
		end

		for iter_14_2, iter_14_3 in pairs(self._click_array) do
			if self._sixth_combat_info.fleetdecisive_buff == iter_14_3 then
				self._now_buff_array["buff_" .. iter_14_2].bottom_use:SetActive(true)
			end
		end

		self._now_buff_array["buff_" .. arg_14_1].select:SetActive(true)
		self._now_buff_array["buff_" .. arg_14_1].bottom_change:SetActive(false)
		self._now_buff_array["buff_" .. arg_14_1].bottom_use:SetActive(true)
		var_0_3:req_SixthDecisiveBattleBuffReq(arg_14_2)
	end

	function arg_1_0:set_back_info()
		var_0_27:show(var_0_1:getNowLang("choose_success"))

		local var_15_0 = var_0_3:get_sixth_combat_info()

		self._control.activity_select_two_buff.top.coin.coin_count.text.text = var_15_0.coin
		self._control.left_bg.cur_count.text.text = var_15_0.coin

		self:_set_new_buff_icon()
	end

	function arg_1_0:__init_panel(arg_16_1)
		local var_16_0 = var_0_24.find_object_by_id((self:now_active_id({
			var_0_4.all_active.decisive_battle_sea_one,
			var_0_4.all_active.decisive_battle_sea_two,
			var_0_4.all_active.decisive_battle_sea_three
		})))
		local var_16_1 = var_0_3:get_sixth_combat_info()
		local var_16_2 = var_0_15.get_sequence()

		if var_16_0 then
			self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_16_0.bgm), true)
		end

		local var_16_3 = var_0_3:get_cur_sixth_map()

		self:show_sixth_input_node()

		self._cur_map_id = arg_16_1.id

		self._control.buff_btn:SetActive(false)
		self._control.activity_select_two_buff:SetActive(false)
		self:_set_new_buff_icon()

		self._uiroot_canvas_rect = var_0_5.get_ui_root_canvas_rect()
		self._ui_camera = var_0_5.get_ui_camera()
		self.uiMapWidth = self._control.bg.rectTransform.rect.width
		self.uiMapHeight = self._control.bg.rectTransform.rect.height
		self._adjutant_set, self._adjutant_cid, self._current_adjutant_index = var_0_3:get_six_adjutant()
		self._adjutant_config = var_0_18.find_object_by_id(self._adjutant_set[self._current_adjutant_index])
		self._control.left_people.image.sprite = self:loadSprite((var_0_6(var_0_4.sixth_adjutant_image, self._adjutant_config.id)))

		self._control.left_people.image:SetNativeSize()

		self._control.left_people.talk.canvasGroup.alpha = 0
		self._select_node_btn_index = nil
		self._start_point_position = 0

		local var_16_4 = var_0_3:get_sixth_combat_info()

		self._cur_node_point = var_16_4.point

		self:set_left_panel(arg_16_1)
		self:set_map_info(arg_16_1)
		self:__Move_sixth_Node_map_shipPos(arg_16_1)

		local var_16_5 = var_0_15.find_object_by_id(var_16_4.point)

		self:set_skill_info()

		if var_16_5.node_type == var_0_4.map_node_type.null then
			if #self._next_node_point > 1 then
				self:__play_random()
			else
				self:__click_select_point(1, true)
			end
		elseif var_16_4.battle and var_0_31(var_16_5.next_node) then
			if #self._next_node_point > 1 then
				self:__play_random()
			else
				self:__click_select_point(1, true)
			end
		else
			if var_0_3:get_open_sixth_select_and_buff() == "true" and not var_16_4.buy then
				var_0_2:createInstance("activity_select_ship_and_buff"):show(var_16_4.list)
			end

			self._cur_fight_point = var_16_4.point
		end

		self._control.return_btn.return_text.text.text = var_0_1:getNowLang("ui_combat_return")
		self._control.right_bg.goto_text.text.text = var_0_1:getNowLang("outfight")
		self._control.right_bg.select_text.text.text = var_0_1:getNowLang("dock_team_text")
		self._control.left_bg.buy_btn.info_text.text.text = var_0_6(var_0_1:getNowLang("sixth_buy_exp"), "<color='#56f9ff'><size=15>5点</size></color>")
		self._control.left_bg.buy_btn.count_text.text.text = var_0_4.sixth_exp_price
		self._control.left_bg.static_cur.text.text = var_0_1:getNowLang("ownnow")

		self._control.six_msgbox.select_msg_btn.button.onClick:RemoveAllListeners()

		self._control.six_msgbox.main.word.text_one.text.text = var_0_1:getNowLang("confirm_clear")
		self._control.six_msgbox.main.word.text_two.text.text = var_0_1:getNowLang("clear_now_small_map")
		self._control.six_msgbox.main.word.text_three.text.text = var_0_1:getNowLang("confirm_give_up")
		self._control.six_msgbox.main.word.text_four.text.text = var_0_1:getNowLang("restart_challenge")
		self._control.six_msgbox.select_msg_btn.text.text.text = var_0_1:getNowLang("space_confirm")

		self:_get_end_point(var_16_4.point)

		if arg_16_1.is_return_sixth_map_node then
			self._control.bg.rectTransform.anchoredPosition3D = arg_16_1._six_map_node_bg
		end
	end

	function arg_1_0:select_msgbox(arg_17_1)
		self._control.six_msgbox.select_msg_btn.button.onClick:RemoveAllListeners()
		self._control.six_msgbox.select_msg_btn.button.onClick:AddListener(function()
			self._control.six_msgbox:SetActive(false)

			if arg_17_1 then
				local var_18_0

				if self._now_index then
					var_18_0 = self._now_index == 1 and math.ceil((self._data.id - 9300) / 3) + 10000 or math.ceil((self._data.id - 9300) / 3) + 10000 - 1
				end

				if var_18_0 then
					var_0_3:set_repeat_map_id(var_18_0)
				end

				var_0_3:req_SixthCompleteMapReq()
			else
				self:next_select_status()
				var_0_3:req_SixthQuitMapReq()
				var_0_2:destroyInstance("sixth_map_node")
			end
		end)
	end

	function arg_1_0:next_select_status()
		self._control.six_msgbox.main.left.light:SetActive(true)
		self._control.six_msgbox.main.left.select:SetActive(true)
		self._control.six_msgbox.main.right.light:SetActive(false)
		self._control.six_msgbox.main.right.select:SetActive(false)
	end

	function arg_1_0:set_skill_info()
		local var_20_0 = var_0_3:get_sixth_combat_info()

		self._control.right_bg.goto_btn.spine_effect:SetActive(false)

		local var_20_1 = var_0_3:_get_six_info()

		if var_20_0.adjutant.id == 10182 and var_20_0.adjutant_buff then
			self._control.right_bg.goto_btn.spine_effect:SetActive(true)
			self:__play_animation(self._control.right_bg.goto_btn.spine_effect, "buff_arrow", true)
		end

		local var_20_2 = var_0_18.find_object_by_id(var_20_1.adjutant)

		self._control.left_bg.icon.image.sprite = self:loadSprite(var_0_6(var_0_4.sixth_skill_img, var_20_1.adjutant))
		self._control.left_bg.icon.image.material = var_20_0.adjutant.skill_count == 1 and self:loadMaterial(var_0_4.common_icon.furniture_gray_material) or nil

		local var_20_4 = 1

		for iter_20_0, iter_20_1 in pairs(var_0_4.skill_level_by_adjutant) do
			if iter_20_1 <= var_20_0.adjutant.level then
				var_20_4 = var_20_4 + 1
			end
		end

		self._control.left_bg.icon.skill_trans.skill_title.text.text = var_20_2.skill_title
		self._control.left_bg.icon.skill_trans.skill_info.text.text = var_0_5.convert_rich_text(var_20_2.effect_desc[var_20_4])

		self:set_left_panel()
	end

	function arg_1_0.__play_animation(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
		arg_21_1.skeletonGraphic.AnimationState:SetAnimation(0, arg_21_2, arg_21_3)
	end

	function arg_1_0:set_left_panel(arg_22_1)
		local var_22_0 = var_0_3:get_sixth_combat_info()

		self._control.left_bg.level_text.text.text = var_22_0.adjutant.level < #var_0_4.sixth_adjutant_exp and var_0_6("Lv.%s(%s/%s)", var_22_0.adjutant.level, var_22_0.adjutant.exp, var_0_4.sixth_adjutant_exp[var_22_0.adjutant.level]) or var_0_6("Lv.%s(Max)", var_22_0.adjutant.level)
		self._control.left_bg.cur_count.text.text = var_22_0.coin

		if var_22_0.adjutant then
			self._control.left_bg.slider.image.fillAmount = var_22_0.adjutant.exp and var_22_0.adjutant.level and (var_0_4.sixth_adjutant_exp[var_22_0.adjutant.level] and var_0_4.sixth_adjutant_exp[var_22_0.adjutant.level] ~= 0 and var_22_0.adjutant.exp / var_0_4.sixth_adjutant_exp[var_22_0.adjutant.level] or 0) or 0
		end
	end

	function arg_1_0:__Move_sixth_Node_map_shipPos(arg_23_1)
		local var_23_0 = var_0_3:get_sixth_combat_info()
		local var_23_1 = var_0_15.find_object_by_id(var_23_0.point)

		self._cur_node_point = var_23_0.point

		local var_23_2 = {}

		for iter_23_0, iter_23_1 in ipairs(var_23_0.point_grade or {}) do
			if tonumber(var_0_22(iter_23_1.point, 1, 4)) == var_23_0.id then
				local var_23_3 = false

				for iter_23_2, iter_23_3 in ipairs(var_23_2) do
					if iter_23_3 == iter_23_1.point then
						var_23_3 = true
					end
				end

				if not var_23_3 then
					var_0_8(var_23_2, iter_23_1.point)
				end
			end
		end

		self._next_node_point = var_23_1.next_node
		self._control.bg.ship_layer.rectTransform.anchoredPosition = self:__get_real_node_pos(var_23_1.position.x, var_23_1.position.y)

		if -self._last_node_point_x + 625 - 200 <= -625 - 220 * (#var_23_2 - 1) then
			self._control.bg.rectTransform.anchoredPosition = var_0_9(-625 - 220 * (#var_23_2 - 1), self._control.bg.rectTransform.anchoredPosition.y)
		elseif -625 - 220 * (#var_23_2 - 1) >= self._start_point_position then
			self._control.bg.rectTransform.anchoredPosition = var_0_9(self._start_point_position, self._control.bg.rectTransform.anchoredPosition.y)
		elseif -625 - 220 * (#var_23_2 - 1) < -self._last_node_point_x + 625 - 200 then
			self._control.bg.rectTransform.anchoredPosition = var_0_9(-self._last_node_point_x + 625 - 200, self._control.bg.rectTransform.anchoredPosition.y)
		end

		self._control.bg.button.onClick:RemoveAllListeners()
		self._control.bg.pointerDownUpEvent.onPointerDown:RemoveAllListeners()
		self._control.bg.pointerDownUpEvent.onPointerDown:AddListener(function()
			local var_24_0, var_24_1 = var_0_20.ScreenPointToLocalPointInRectangle(self._uiroot_canvas_rect, var_0_19.mousePosition, self._ui_camera, nil)

			self._mouse_positionX = var_24_1.x
			self._start_drag_position = var_24_1
			self._is_drag = true
		end)
		self._control.bg.pointerDownUpEvent.onPointerUp:RemoveAllListeners()
		self._control.bg.pointerDownUpEvent.onPointerUp:AddListener(function()
			self._is_drag = false
			var_0_21 = 0
			self._is_drag_end = true
		end)
	end

	function arg_1_0:on_point_down_end_event()
		local var_26_0, var_26_1 = var_0_20.ScreenPointToLocalPointInRectangle(self._uiroot_canvas_rect, var_0_19.mousePosition, self._ui_camera, nil)

		if var_26_0 and self._control.bg.rectTransform.anchoredPosition.x + (var_26_1.x - self._start_drag_position.x) <= -625 and -self._last_node_point_x + 625 - 200 <= self._control.bg.rectTransform.anchoredPosition.x + (var_26_1.x - self._start_drag_position.x) then
			self._control.bg.rectTransform.anchoredPosition = var_0_9(self._control.bg.rectTransform.anchoredPosition.x + (var_26_1.x - self._start_drag_position.x), self._control.bg.rectTransform.anchoredPosition.y)
		elseif -625 < self._control.bg.rectTransform.anchoredPosition.x + (var_26_1.x - self._start_drag_position.x) then
			self._control.bg.rectTransform.anchoredPosition = var_0_9(-625, self._control.bg.rectTransform.anchoredPosition.y)
		elseif self._control.bg.rectTransform.anchoredPosition.x + (var_26_1.x - self._start_drag_position.x) < -self._last_node_point_x + 625 - 200 then
			self._control.bg.rectTransform.anchoredPosition = var_0_9(-self._last_node_point_x + 625 - 200, self._control.bg.rectTransform.anchoredPosition.y)
		end

		self._start_drag_position = var_26_1
		self._is_drag_end = false
	end

	function arg_1_0:on_point_down_event()
		local var_27_0, var_27_1 = var_0_20.ScreenPointToLocalPointInRectangle(self._uiroot_canvas_rect, var_0_19.mousePosition, self._ui_camera, nil)

		self._mouse_positionX = var_27_1.x

		if var_27_0 and self._control.bg.rectTransform.anchoredPosition.x + (var_27_1.x - self._start_drag_position.x) <= -425 and -self._last_node_point_x + 625 - 350 <= self._control.bg.rectTransform.anchoredPosition.x + (var_27_1.x - self._start_drag_position.x) then
			self._control.bg.rectTransform.anchoredPosition = var_0_9(self._control.bg.rectTransform.anchoredPosition.x + (var_27_1.x - self._start_drag_position.x), self._control.bg.rectTransform.anchoredPosition.y)
		elseif -425 < self._control.bg.rectTransform.anchoredPosition.x + (var_27_1.x - self._start_drag_position.x) then
			self._control.bg.rectTransform.anchoredPosition = var_0_9(-425, self._control.bg.rectTransform.anchoredPosition.y)
		elseif self._control.bg.rectTransform.anchoredPosition.x + (var_27_1.x - self._start_drag_position.x) < -self._last_node_point_x + 625 - 350 then
			self._control.bg.rectTransform.anchoredPosition = var_0_9(-self._last_node_point_x + 625 - 350, self._control.bg.rectTransform.anchoredPosition.y)
		end

		self._start_drag_position = var_27_1
	end

	function arg_1_0:__play_move_ship(arg_28_1, arg_28_2, arg_28_3)
		local var_28_0 = var_0_3:get_sixth_combat_info()
		local var_28_1 = var_0_15.find_object_by_id(arg_28_1)
		local var_28_2 = var_0_15.find_object_by_id(arg_28_2)
		local var_28_3 = self:__get_real_node_pos(var_28_1.position.x, var_28_1.position.y)

		var_0_3:set_open_sixth_select_and_buff("true")

		local var_28_4 = var_0_2:createInstance("loading")

		var_28_4:show(true, nil, true)

		self._control.bg.ship_layer.rectTransform:DOAnchorPos(self:__get_real_node_pos(var_28_2.position.x, var_28_2.position.y), 1):SetEase(DG.Tweening.Ease.Linear):SetDelay(0):SetAutoKill(true).onComplete = function()
			local var_29_1 = {}

			for iter_29_0, iter_29_1 in ipairs(var_28_0.point_grade or {}) do
				if tonumber(var_0_22(iter_29_1.point, 1, 4)) == var_28_0.id then
					var_0_8(var_29_1, iter_29_1.point)
				end
			end

			local var_29_4 = var_0_16.find_object_by_id(self._cur_map_id)

			self._point_list[var_28_2.id].node_image.image.sprite = self:loadSprite(var_28_2.node_type == var_0_4.map_node_type.boss and var_0_4.sixth_map_node_icon.sixth_boss_blue or var_0_4.sixth_map_node_icon.sixth_point_blue)

			var_0_2:createInstance("activity_select_ship_and_buff"):show(arg_28_3)
			var_28_4:show(false)
		end

		self._control.bg.ship_layer.encounter_effect.encounter_spine.skeletonGraphic.AnimationState:ClearTracks()
		self._control.bg.ship_layer.encounter_effect.encounter_spine.skeletonGraphic.AnimationState:SetAnimation(0, "Cable_enemy", false)
	end

	function arg_1_0.now_active_id(arg_30_0, arg_30_1)
		for iter_30_0, iter_30_1 in pairs(arg_30_1) do
			if var_0_24.find_object_by_id(iter_30_1) then
				local var_30_1 = var_0_24.find_object_by_id(iter_30_1)

				arg_30_0._now_index = iter_30_0

				return iter_30_1
			end
		end
	end

	function arg_1_0:set_map_info(arg_31_1)
		self._collect_obj = {}

		local var_31_0 = var_0_3:get_sixth_combat_info().point_grade or {}
		local var_31_1 = self:get_map_all_info(arg_31_1.id)

		self._now_map_point_list = var_31_1

		local var_31_2 = var_0_16.find_object_by_id(arg_31_1.id)

		var_0_8(var_31_0, {
			grade = 0,
			point = var_31_2.init_node_id
		})

		local var_31_3

		if var_31_2.level_bg == 1 then
			var_31_3 = var_0_4.sixth_map_blue_bg
		elseif var_31_2.level_bg == 2 then
			var_31_3 = var_0_4.sixth_map_red_bg
		end

		self._control.empty_bg.image.sprite = self:loadSprite(var_31_3)
		self._control.bg.image.sprite = self:loadSprite(var_31_3)

		for iter_31_0, iter_31_1 in pairs(var_31_1) do
			if iter_31_1.next_node_path ~= "{}" then
				local var_31_4 = var_0_17(iter_31_1.next_node_path)
				local var_31_6 = 0

				table.sort(iter_31_1.next_node, function(arg_32_0, arg_32_1)
					return arg_32_0 < arg_32_1
				end)

				local var_31_7 = {}

				for iter_31_2, iter_31_3 in pairs(var_31_4) do
					var_0_8(var_31_7, {
						pos = iter_31_3,
						name = iter_31_2
					})
				end

				table.sort(var_31_7, function(arg_33_0, arg_33_1)
					local var_33_0 = tonumber(var_0_22(arg_33_0.name, 1, #arg_33_0.name - 4))
					local var_33_1 = tonumber(var_0_22(arg_33_1.name, 1, #arg_33_1.name - 4))

					if arg_33_0.pos.y < arg_33_1.pos.y and var_33_1 < var_33_0 then
						return var_33_1 < var_33_0
					elseif arg_33_1.pos.y < arg_33_0.pos.y and var_33_0 < var_33_1 then
						return var_33_1 < var_33_0
					else
						return var_33_0 < var_33_1
					end
				end)

				for iter_31_4, iter_31_5 in pairs(var_31_7) do
					var_31_6 = var_31_6 + 1

					local var_31_8, var_31_9 = self:loadUIPrefab("map_line_obj", self._control.bg.rectTransform)

					var_0_8(self._collect_obj, var_31_8._panel)
					var_31_8:setVisible(true)

					var_31_9.line_image.gameObject.name = "map_line_obj"
					var_31_9.line_image.rectTransform.parent.offsetMin = var_0_9(0, 0)
					var_31_9.line_image.rectTransform.parent.offsetMax = var_0_9(0, 0)
					var_31_9.line_image.rectTransform.anchoredPosition = self:__get_real_node_pos(iter_31_5.pos.x, iter_31_5.pos.y)
					var_31_9.line_image.rectTransform.localScale = Vector3(1, 1, 1)
					var_31_9.line_image.image.sprite = self:loadSprite((var_0_6(var_0_4.sixth_map_line, iter_31_5.name)))

					var_31_9.line_image.image:SetNativeSize()
					var_31_9.line_image:SetActive(true)

					self._liner_list[iter_31_1.id .. "-" .. iter_31_1.next_node[var_31_6]] = {
						lineImageName = iter_31_5.name,
						linePos = iter_31_5.pos,
						mapLineControl = var_31_9
					}
				end
			end

			local var_31_10, var_31_11 = self:loadUIPrefab("map_node_obj", self._control.bg.rectTransform)

			var_0_8(self._collect_obj, var_31_10._panel)
			var_31_10:setVisible(true)

			var_31_11.node_image.rectTransform.parent.offsetMin = var_0_9(0, 0)
			var_31_11.node_image.rectTransform.parent.offsetMax = var_0_9(0, 0)
			var_31_11.node_image.rectTransform.anchoredPosition = self:__get_real_node_pos(iter_31_1.position.x, iter_31_1.position.y)
			var_31_11.node_image.rectTransform.localScale = Vector3(1, 1, 1)

			if iter_31_1.flag ~= "" then
				var_31_11.node_image.name_bg.image.sprite = self:loadSprite(var_0_6(var_0_4.sixth_map_node_name, iter_31_1.flag))
				var_31_11.node_image.name_bg.rectTransform.localScale = Vector3(1, 1, 1)

				var_31_11.node_image.name_bg:SetActive(true)
			else
				var_31_11.node_image.name_bg:SetActive(false)
			end

			local var_31_13 = false
			local var_31_14

			for iter_31_6, iter_31_7 in ipairs(var_31_0) do
				if iter_31_7.point == iter_31_1.id then
					var_31_13 = true
					var_31_14 = iter_31_7.grade
				end
			end

			if var_0_31(iter_31_1.award) then
				var_31_11.node_image.reward_bg:SetActive(true)

				local var_31_15 = iter_31_1.award[1]
				local var_31_16 = var_0_23.find_object_by_cid(iter_31_1.award[1].id)

				var_31_11.node_image.reward_bg.reward_icon.image.sprite = var_31_16.type == 82 and self:loadSprite(var_0_6(var_0_4.sixth_reward_icon, "box")) or self:loadSprite(var_0_6(var_0_4.sixth_reward_icon, var_31_15.id))

				local var_31_17 = self:get_acticity_time((self:now_active_id({
					var_0_4.all_active.decisive_battle_sea_one,
					var_0_4.all_active.decisive_battle_sea_two,
					var_0_4.all_active.decisive_battle_sea_three
				}))) and 2 or 1

				self._save_activeDoubleCount = var_31_17

				if var_31_14 then
					var_31_11.node_image.reward_bg.reward_count.text.text = var_0_6("%s/%s", math.ceil(var_0_4.sixth_reward_coe[var_0_6("score_%s", var_0_4.rank_sore[var_31_14])] * var_31_15.value), var_31_15.value)

					if var_31_16.type == 1 then
						var_31_11.node_image.reward_bg.reward_count.text.text = var_0_6("%s/%s", math.ceil(var_0_4.sixth_reward_coe[var_0_6("score_%s", var_0_4.rank_sore[var_31_14])] * var_31_15.value) * var_31_17, var_31_15.value)
					end
				else
					var_31_11.node_image.reward_bg.reward_count.text.text = var_0_6("%s/%s", 0, var_31_15.value)
				end
			else
				var_31_11.node_image.reward_bg:SetActive(false)
			end

			var_31_11.node_image.image.sprite = self:loadSprite(iter_31_1.id == var_31_2.init_node_id and ((var_31_13 or self._cur_node_point == iter_31_1.id) and var_0_4.sixth_map_node_icon.sixth_start_blue or var_0_4.sixth_map_node_icon.sixth_start_white) or iter_31_1.node_type == var_0_4.map_node_type.boss and ((var_31_13 or self._cur_node_point == iter_31_1.id) and var_0_4.sixth_map_node_icon.sixth_boss_blue or var_0_4.sixth_map_node_icon.sixth_boss_white) or (var_31_13 or self._cur_node_point == iter_31_1.id) and var_0_4.sixth_map_node_icon.sixth_point_blue or var_0_4.sixth_map_node_icon.sixth_point_white)

			var_31_11.node_image.image:SetNativeSize()

			self._point_list[iter_31_1.id] = var_31_11

			var_31_11.night_atk_point:SetActive(false)

			if self._start_point_position == 0 then
				self._start_point_position = var_31_11.node_image.rectTransform.anchoredPosition.x
			end

			self._last_node_point_x = var_31_11.node_image.rectTransform.anchoredPosition.x
		end

		self._control.bg.ship_layer.transform:SetAsLastSibling()

		self._control.bg.transform.sizeDelta = self._last_node_point_x > 1920 and var_0_9(self._last_node_point_x + 100, self._control.bg.transform.sizeDelta.y) or var_0_9(1920, self._control.bg.transform.sizeDelta.y)

		table.sort(var_31_0, function(arg_34_0, arg_34_1)
			return arg_34_0.point < arg_34_1.point
		end)

		for iter_31_8 = 1, #var_31_0 - 1 do
			if self._liner_list[var_31_0[iter_31_8].point .. "-" .. var_31_0[iter_31_8 + 1].point] then
				self._liner_list[var_31_0[iter_31_8].point .. "-" .. var_31_0[iter_31_8 + 1].point].mapLineControl.line_image.image.sprite = self:loadSprite(var_0_6(var_0_4.sixth_map_line, self._liner_list[var_31_0[iter_31_8].point .. "-" .. var_31_0[iter_31_8 + 1].point].lineImageName .. "-02"))
			end
		end

		if #var_31_0 > 0 then
			if self._liner_list[var_31_0[#var_31_0].point .. "-" .. self._cur_node_point] then
				self._liner_list[var_31_0[#var_31_0].point .. "-" .. self._cur_node_point].mapLineControl.line_image.image.sprite = self:loadSprite(var_0_6(var_0_4.sixth_map_line, self._liner_list[var_31_0[#var_31_0].point .. "-" .. self._cur_node_point].lineImageName .. "-02"))
			end
		end
	end

	function arg_1_0:get_acticity_time(arg_35_1)
		local var_35_0 = var_0_24.find_object_by_id(arg_35_1)

		if var_35_0.start_time == 0 or var_35_0.end_time == 0 then
			self._control.buff_btn:SetActive(false)

			return false
		end

		if lx.ServerTime:getUtcTime() > var_35_0.start_time and lx.ServerTime:getUtcTime() < var_35_0.end_time then
			self._control.buff_btn:SetActive(true)

			return true
		end

		return false
	end

	function arg_1_0:__set_bg_width(arg_36_1)
		local var_36_0 = self:get_map_all_info(arg_36_1.id)

		self._control.bg.rectTransform.rect.width = var_36_0[#var_36_0].position.x + 50
	end

	function arg_1_0:__play_random()
		self._control.select_node_layer.static_text.Text.text.text = var_0_1:getNowLang("six_choosenode")
		self._control.select_node_layer.select_node_btn.text.text.text = var_0_1:getNowLang("ui_cbtn1")
		self._control.select_node_layer.node_trans.rectTransform.anchoredPosition = var_0_9(0, 0)
		self._control.select_node_layer.canvasGroup.alpha = 1
		self._control.select_node_layer.canvasGroup.blocksRaycasts = true

		for iter_37_0 = 1, #self._next_node_point do
			self._control.select_node_layer.node_trans[var_0_6("select_%s", iter_37_0)]:SetActive(true)
			self:__set_select_info(iter_37_0, self._next_node_point[iter_37_0])
		end

		for iter_37_1 = #self._next_node_point + 1, 3 do
			self._control.select_node_layer.node_trans[var_0_6("select_%s", iter_37_1)]:SetActive(false)
		end

		local var_37_1 = self._control.select_node_layer.node_trans.rectTransform:DOAnchorPos(var_0_9(0, 0), 0):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(0):SetAutoKill(true)
	end

	function arg_1_0:__set_select_info(arg_38_1, arg_38_2)
		local var_38_0 = var_0_15.find_object_by_id(arg_38_2)
		local var_38_1 = self._control.select_node_layer.node_trans[var_0_6("select_%s", arg_38_1)]

		var_38_1.point_text.text.text = var_0_6(var_38_0.flag)
		var_38_1.info_text.text.text = string.format("<size=16>%s</size>", (var_0_5.convert_rich_text(var_38_0.buff_desc)))
		var_38_1.image.sprite = self:loadSprite(var_0_4.single_bottom_01)
	end

	function arg_1_0:__click_select_point(arg_39_1, arg_39_2)
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.task_goto))

		self._select_node_btn_index = arg_39_1

		if arg_39_2 then
			var_0_3:req_SixthMoveReq(self._next_node_point[arg_39_1])
		end

		for iter_39_0 = 1, 3 do
			local var_39_0 = self._control.select_node_layer.node_trans[var_0_6("select_%s", iter_39_0)]

			if iter_39_0 == arg_39_1 then
				var_39_0.select_bg:SetActive(true)
				var_39_0.mask:SetActive(false)

				self._selected_point = var_39_0
				var_39_0.image.sprite = self:loadSprite(var_0_4.single_bottom_02)
				self._cur_fight_point = self._next_node_point[arg_39_1]
				self._cur_next_node = self._next_node_point[arg_39_1]
			else
				var_39_0.select_bg:SetActive(false)
				var_39_0.mask:SetActive(true)

				var_39_0.image.sprite = self:loadSprite(var_0_4.single_bottom_01)
			end
		end
	end

	function arg_1_0:__get_real_node_pos(arg_40_1, arg_40_2)
		return var_0_9(arg_40_1 / 1920 * self.uiMapWidth, -1 * arg_40_2 / 960 * self.uiMapHeight)
	end

	function arg_1_0:__resp_SixthMoveResp_close(arg_41_1)
		self._control.select_node_layer.node_trans.rectTransform:DOAnchorPos(var_0_9(0, 0), 0):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(0):SetAutoKill(true).onComplete = function()
			self._control.select_node_layer.canvasGroup.alpha = 0
			self._control.select_node_layer.canvasGroup.blocksRaycasts = false

			self:__play_move_ship(self._cur_node_point, self._cur_next_node, arg_41_1.list)

			local var_42_0 = var_0_3:get_sixth_combat_info().point_grade or {}
			local var_42_1 = var_0_16.find_object_by_id(self._data.id)

			var_0_8(var_42_0, {
				grade = 0,
				point = var_42_1.init_node_id
			})
			table.sort(var_42_0, function(arg_43_0, arg_43_1)
				return arg_43_0.point < arg_43_1.point
			end)

			if #var_42_0 > 0 then
				if self._liner_list[var_42_0[#var_42_0].point .. "-" .. self._cur_next_node] then
					self._liner_list[var_42_0[#var_42_0].point .. "-" .. self._cur_next_node].mapLineControl.line_image.image.sprite = self:loadSprite(var_0_6(var_0_4.sixth_map_line, self._liner_list[var_42_0[#var_42_0].point .. "-" .. self._cur_next_node].lineImageName .. "-02"))
				end
			else
				local var_42_2 = var_42_1.init_node_id .. "-" .. self._cur_next_node

				if self._liner_list[var_42_1.init_node_id .. "-" .. self._cur_next_node] then
					self._liner_list[var_42_2].mapLineControl.line_image.image.sprite = self:loadSprite(var_0_6(var_0_4.sixth_map_line, self._liner_list[var_42_2].lineImageName .. "-02"))
				end
			end
		end
	end

	function arg_1_0:__is_gotofight(arg_44_1, arg_44_2)
		local var_44_0 = 0
		local var_44_1 = 0
		local var_44_2 = 0
		local var_44_3 = var_0_3:get_use_info_data()

		if arg_44_1 then
			for iter_44_0, iter_44_1 in pairs(arg_44_2.id_array) do
				local var_44_4 = var_0_3:find_character_by_id(iter_44_1)

				var_44_0 = var_44_0 + var_44_4.oil - var_44_4.now_oil
				var_44_1 = var_44_1 + var_44_4.bullet - var_44_4.now_bullet
				var_44_2 = var_44_2 + self:__need_al(var_44_4)
			end

			if var_44_0 > var_44_3.oil then
				var_0_27:show(var_0_1:getNowLang("oilnotenough"))

				return false
			end

			if var_44_1 > var_44_3.bullet then
				var_0_27:show(var_0_1:getNowLang("ammonotenough"))

				return false
			end

			if var_44_2 > var_44_3.al then
				var_0_27:show(var_0_1:getNowLang("aluminumnotenough"))

				return false
			end

			var_0_3:req_ShipSupply(arg_44_2)
		end

		return true
	end

	function arg_1_0.__need_al(arg_45_0, arg_45_1)
		local var_45_0 = 0
		local var_45_1 = var_0_25.find_object_by_cid(arg_45_1.cid)

		for iter_45_0, iter_45_1 in pairs(arg_45_1.equips) do
			if iter_45_1.id ~= 0 and iter_45_1.carry_type ~= var_0_4.equip_carry_type.normal then
				var_45_0 = var_45_0 + (iter_45_1.carry_type == var_0_4.equip_carry_type.plane and var_45_1.capacity_slot[iter_45_0] - (iter_45_1.num or 0) or var_45_1.missile_slot[iter_45_0] - ((not iter_45_1.num or nil) and 0)) * var_0_26.find_object_by_cid(iter_45_1.id).aluminium_use
			end
		end

		return var_0_14(var_45_0)
	end

	function arg_1_0:_play_into_se(arg_46_1)
		self:playSE(arg_46_1, false)
	end

	function arg_1_0:_play_audio(arg_47_1, arg_47_2)
		self:playBackgroundMusic(arg_47_1, arg_47_2)
	end

	function arg_1_0:__onReset()
		self._control.six_msgbox.select_msg_btn.button.onClick:RemoveAllListeners()

		self._control.bg.rectTransform.sizeDelta = var_0_9(1920, 960)

		if self._collect_obj then
			for iter_48_0, iter_48_1 in ipairs(self._collect_obj) do
				self:destroyGameObject(iter_48_1)
			end
		end

		self._point_list = {}
		self._liner_list = {}
		self._collect_obj = {}
		self._select_node_btn_index = nil

		if self._selected_point then
			self._selected_point.select_bg:SetActive(false)
			self._selected_point.mask:SetActive(true)
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_49_0)
	local var_49_0 = var_0_2:class("sixth_map_node")

	var_49_0.uiMapWidth = 0
	var_49_0.uiMapHeight = 0
	var_49_0._liner_list = {}
	var_49_0._point_list = {}
	var_49_0._cur_next_node = nil
	var_49_0._cur_node_point = nil
	var_49_0._cur_fight_point = nil
	var_49_0._data = nil
	var_49_0._model_talk_seq = nil
	var_49_0._path_array = {}
	var_49_0._select_node_btn_index = nil
	var_49_0._last_node_point_x = 0
	var_49_0._is_drag_end = false
	var_49_0._start_point_position = 0
	var_49_0._cur_map_id = nil
	var_49_0._save_activeDoubleCount = false
	var_49_0._save_now_change = nil

	return var_49_0
end

return var_0_0
