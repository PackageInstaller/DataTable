local var_0_0 = {}
local var_0_1 = lx.UserData
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = gamecore.user
local var_0_5 = gameenum.common_type
local var_0_7 = string.format
local var_0_8 = table.insert
local var_0_9 = DG.Tweening.DOTween
local var_0_10 = UnityEngine.Vector2
local var_0_11 = UnityEngine.Vector3
local var_0_12 = gameconfig.tower_map_config
local var_0_14 = gameconfig.pve_guide_config
local var_0_15 = gameconfig.tower_buff_config
local var_0_16 = gamecore.util_func
local var_0_17 = Quaternion.Euler(0, 0, 0)
local var_0_18 = Quaternion.Euler(0, -90, 0)

gamecore.UILoader:define("climb_tower", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2)
		if arg_2_2 then
			self:set_animation_state(true)

			self._now_layer = var_0_4:get_tower_node_info().level

			self:__set_layer_info()
			self:__update_bnottom_bns()
			self:__check_this_layer()

			if arg_2_2.grade <= var_0_5.battle_score.s then
				self._last_battle_info = arg_2_2

				self:__rotate_card_after_battle(self._last_battle_info)
			else
				self:__set_card_info()
			end
		else
			self.isGray = arg_2_1
		end

		self:setVisible(true)
		var_0_4:set_into_tower(true)
		self:__init_panel(arg_2_2)
		self:__broken_first()
	end

	function arg_1_0:__card_anim(arg_3_1, arg_3_2)
		local var_3_0 = 1
		local var_3_1 = 5
		local var_3_2 = 1

		if arg_3_1 then
			for iter_3_0 = var_3_0, var_3_1, var_3_2 do
				self._item_list[iter_3_0].rectTransform.anchoredPosition = var_0_10(-850, self._item_list[iter_3_0].rectTransform.anchoredPosition.y)
			end

			var_3_0 = 5
			var_3_1 = 1
			var_3_2 = -1
		end

		local var_3_3 = {}

		for iter_3_1 = var_3_0, var_3_1, var_3_2 do
			var_3_3[#var_3_3 + 1] = self._item_list[iter_3_1].uITweenSequence
		end

		var_0_5:play_in_out_animation(var_3_3[1], arg_3_1, function()
			var_0_5:play_in_out_animation(var_3_3[2], arg_3_1, function()
				var_0_5:play_in_out_animation(var_3_3[3], arg_3_1, function()
					var_0_5:play_in_out_animation(var_3_3[4], arg_3_1, function()
						var_0_5:play_in_out_animation(var_3_3[5], arg_3_1, function()
							if arg_3_2 then
								arg_3_2()
							end
						end)
					end)
				end)
			end)
		end)
	end

	function arg_1_0:__card_rotate(arg_9_1)
		local var_9_0

		self._item_list = {
			self._control.main.middle.item_1,
			self._control.main.middle.item_2,
			self._control.main.middle.item_3,
			self._control.main.middle.item_4,
			self._control.main.middle.item_5
		}
		self._now_layer_map_cfg = var_0_12.find_object_by_level(self._now_layer)

		for iter_9_0, iter_9_1 in pairs(self._now_layer_map_cfg.enemys) do
			if iter_9_1 == arg_9_1 then
				var_9_0 = self._item_list[iter_9_0]
			end
		end

		if not var_9_0 then
			log.print_r("NO CARD!!!")

			return
		end

		for iter_9_2, iter_9_3 in ipairs(self._now_layer_map_cfg.enemys) do
			local var_9_1 = self._item_list[iter_9_2]

			if iter_9_3 ~= arg_9_1 then
				if not self:__get_monster_state(iter_9_3) then
					local var_9_2
					local var_9_3

					if self._now_layer_map_cfg.special_enemy[iter_9_2] == 0 then
						var_9_2 = var_0_5.tower_const.normal_bg
						var_9_3 = var_0_5.tower_const.card_spine_name.yellow
					else
						var_9_2 = var_0_5.tower_const.special_bg
						var_9_3 = var_0_5.tower_const.card_spine_name.red
					end

					var_9_1.monster.bg.icon.image.sprite = self:loadSprite(var_0_5:get_ship_icon(var_0_5.ship_icon.model_normal_m, self._now_layer_map_cfg.enemy_icon[iter_9_2]))
					var_9_1.monster.bg.image.sprite = self:loadSprite(var_9_2)

					self:__set_card_spine_skin(var_9_1, var_9_3)
				else
					var_9_1.bg.rectTransform.rotation = var_0_17
					var_9_1.monster.rectTransform.rotation = var_0_18
				end
			end
		end

		if self._last_battle_info then
			if self._last_battle_info.monster == arg_9_1 and not self:__check_after_battle_rotated(arg_9_1) then
				self._seq_bg = self:autoKillDOTween(var_0_9.Sequence())

				self._seq_bg:Append(var_9_0.monster.transform:DOLocalRotate(var_0_11(0, 90, 0), 1))
				self._seq_bg:InsertCallback(1, function()
					var_9_0.bg:SetActive(true)
					self._seq_bg:Append(var_9_0.bg.transform:DOLocalRotate(var_0_11(0, 0, 0), 1))
					var_9_0.monster:SetActive(false)
				end)

				self._last_battle_info = nil
			end
		else
			self._seq_bg = self:autoKillDOTween(var_0_9.Sequence())

			self._seq_bg:Append(var_9_0.bg.transform:DOLocalRotate(var_0_11(0, 90, 0), 1))
			self._seq_bg:InsertCallback(1, function()
				var_9_0.monster:SetActive(true)
				self._seq_bg:Append(var_9_0.monster.transform:DOLocalRotate(var_0_11(0, 0, 0), 1))
				var_9_0.bg:SetActive(false)
			end)
		end
	end

	function arg_1_0:__check_after_battle_rotated(arg_12_1)
		if self._after_battle_rotated and next(self._after_battle_rotated) then
			for iter_12_0, iter_12_1 in pairs(self._after_battle_rotated) do
				if arg_12_1 == iter_12_1 then
					return true
				end
			end
		end

		return false
	end

	function arg_1_0:__can_reset_this_layer()
		for iter_13_0, iter_13_1 in pairs(var_0_4:get_tower_data_by_level(self._now_layer).enemys) do
			if iter_13_1.pass == true then
				return true
			end
		end

		return false
	end

	function arg_1_0:__get_monster_state(arg_14_1)
		local var_14_0 = false

		for iter_14_0, iter_14_1 in pairs(var_0_4:get_tower_data_by_level(self._now_layer).enemys) do
			if iter_14_1.id == arg_14_1 then
				var_14_0 = iter_14_1.pass

				break
			end
		end

		return var_14_0
	end

	function arg_1_0:set_layer_from_fight_prepare(arg_15_1)
		self._now_layer = self._now_layer_map_cfg.level
	end

	function arg_1_0:__play_into_bgm(arg_16_1)
		self:playBackgroundMusic(arg_16_1)
	end

	function arg_1_0:__play_se(arg_17_1)
		self:playSE(arg_17_1, false)
	end

	function arg_1_0:__set_layer_info()
		self._now_layer_map_cfg = var_0_12.find_object_by_level(self._now_layer)
		self._now_layer_data = var_0_4:get_tower_data_by_level(self._now_layer)

		local var_18_0 = self:__add_slot_cost()

		self._control.main.top.res_bg.count.text.text = tostring(self._now_layer_map_cfg.cost + var_18_0 - self._now_layer_data.cost)
		self._control.main.top.res_bg.count.text.color = var_18_0 and var_18_0 > 0 and Color(0.43137254901960786, 0.8588235294117647, 0.30196078431372547) or Color.white
		self._control.main.bottom.layer_info.num.text.text = tostring(self._now_layer)
	end

	function arg_1_0:__update_bnottom_bns()
		self._control.main.bottom.last_layer:SetActive(self._now_layer > 1)
		self._control.main.bottom.next_layer:SetActive(var_0_4:get_tower_data_by_level(self._now_layer + 1) ~= nil)

		local var_19_0 = {
			1,
			11,
			21,
			31
		}
		local var_19_1
		local var_19_2

		if self._now_layer <= var_19_0[1] then
			var_19_1 = var_19_0[1]
			var_19_2 = var_19_0[2]
		elseif self._now_layer > var_19_0[1] and self._now_layer < var_19_0[2] then
			var_19_1 = var_19_0[1]
			var_19_2 = var_19_0[2]
		elseif self._now_layer == var_19_0[2] then
			var_19_1 = var_19_0[1]
			var_19_2 = var_19_0[3]
		elseif self._now_layer > var_19_0[2] and self._now_layer < var_19_0[3] then
			var_19_1 = var_19_0[2]
			var_19_2 = var_19_0[3]
		elseif self._now_layer == var_19_0[3] then
			var_19_1 = var_19_0[2]
			var_19_2 = var_19_0[4]
		elseif self._now_layer > var_19_0[3] and self._now_layer < var_19_0[4] then
			var_19_1 = var_19_0[3]
			var_19_2 = var_19_0[4]
		elseif self._now_layer == var_19_0[4] then
			var_19_1 = var_19_0[3]
			var_19_2 = self._max_layer
		elseif self._now_layer > var_19_0[4] then
			var_19_1 = var_19_0[4]
			var_19_2 = self._max_layer
		end

		self._fast_jump_last_layer = var_19_1

		self._control.main.bottom.last_fast:SetActive(self._now_layer > 1)

		self._fast_jump_next_layer = var_0_4:get_tower_data_by_level(var_19_2) ~= nil and var_19_2 or self._max_layer

		self._control.main.bottom.next_fast:SetActive(var_0_4:get_tower_data_by_level(self._now_layer + 1) ~= nil)
		self:__set_reset_btn_clickable(self:__can_reset_this_layer())
	end

	function arg_1_0:__set_reset_btn_clickable(arg_20_1)
		local var_20_0 = self._control.main.bottom.reset

		var_20_0.image.sprite = arg_20_1 and self:loadSprite(var_0_5.common_icon.common_btn_bg_08) or self:loadSprite(var_0_7(var_0_5.exchange_btn, 17))
		var_20_0.image.raycastTarget = arg_20_1 or false
	end

	function arg_1_0:__set_card_info()
		self._item_list = {
			self._control.main.middle.item_1,
			self._control.main.middle.item_2,
			self._control.main.middle.item_3,
			self._control.main.middle.item_4,
			self._control.main.middle.item_5
		}

		if not self._last_battle_info then
			for iter_21_0 = 1, 5 do
				self._item_list[iter_21_0].bg.rectTransform.rotation = var_0_17
				self._item_list[iter_21_0].monster.rectTransform.rotation = var_0_18

				self:__show_card(self._item_list[iter_21_0], false)
			end
		end

		for iter_21_1, iter_21_2 in ipairs(self._now_layer_map_cfg.enemys) do
			local var_21_0 = self._item_list[iter_21_1]
			local var_21_1 = self:__get_monster_state(iter_21_2)
			local var_21_2
			local var_21_3

			if self._now_layer_map_cfg.special_enemy[iter_21_1] == 0 then
				var_21_2 = var_0_5.tower_const.normal_bg
				var_21_3 = var_0_5.tower_const.card_spine_name.yellow
			else
				var_21_2 = var_0_5.tower_const.special_bg
				var_21_3 = var_0_5.tower_const.card_spine_name.red
			end

			var_21_0.monster.bg.icon.image.sprite = self:loadSprite(var_0_5:get_ship_icon(var_0_5.ship_icon.model_normal_m, self._now_layer_map_cfg.enemy_icon[iter_21_1]))
			var_21_0.monster.bg.image.sprite = self:loadSprite(var_21_2)

			self:__set_card_spine_skin(var_21_0, var_21_3)

			if not var_21_1 then
				var_21_0.bg.rectTransform.rotation = var_0_18
				var_21_0.monster.rectTransform.rotation = var_0_17

				self:__show_card(var_21_0, true)
			else
				var_21_0.bg.rectTransform.rotation = var_0_17
				var_21_0.monster.rectTransform.rotation = var_0_18

				self:__show_card(var_21_0, false)
			end
		end

		local var_21_4 = self:autoKillDOTween(var_0_9.Sequence())

		var_21_4:AppendInterval(0.05)
		var_21_4:AppendCallback(function()
			self:set_animation_state(true)
		end)
		var_21_4:Play()
	end

	function arg_1_0.__show_card(arg_23_0, arg_23_1, arg_23_2)
		arg_23_1.bg:SetActive(not arg_23_2)
		arg_23_1.monster:SetActive(arg_23_2)
	end

	function arg_1_0.__set_card_spine_skin(arg_24_0, arg_24_1, arg_24_2)
		arg_24_1.monster.spine_bg.skeletonGraphic.AnimationState:SetAnimation(0, arg_24_2, true)
		arg_24_1.monster.spine_bg.skeletonGraphic:Initialize(true)
	end

	function arg_1_0:__init_show_instructions()
		if var_0_1:getKeyData("climb_tower_already") == "climb_tower_already" then
			return
		else
			var_0_1:setKeyData("climb_tower_already", "climb_tower_already")
			self._control.instructions.gameObject:SetActive(true)
		end

		log.print_r(var_0_1:getKeyData("climb_tower_already"), "UserData:getKeyData(\"climb_tower_already\")")
	end

	function arg_1_0:__set_instructions_info(arg_26_1)
		self._control.instructions.page.page_1.text.text = arg_26_1

		self._control.instructions.prev.gameObject:SetActive(arg_26_1 ~= self._page_first)
		self._control.instructions.next.gameObject:SetActive(arg_26_1 ~= self._page_end)

		self._control.instructions.main.main_tip.main_pic.image.sprite = self:loadSprite(var_0_7(var_0_5.tower_instructions_pic, arg_26_1))
		self._control.instructions.main.main_tip.tip_word.text.text = var_0_2:convert_rich_text(self._guide_data[arg_26_1].desc)
		self._control.instructions.main.title.text.text = var_0_2:get(self._guide_data[arg_26_1].title)
	end

	function arg_1_0:show_now_layer(arg_27_1)
		self._now_layer = arg_27_1
		self._now_layer_data = var_0_4:get_tower_data_by_level(arg_27_1)
		self._now_layer_map_cfg = var_0_12.find_object_by_level(arg_27_1)

		if self._now_layer_data == nil then
			log.errorlog("当前层数据空" .. arg_27_1)

			return
		end

		self:__set_layer_info()
		self:__update_bnottom_bns()
		self:__set_card_info()
		self:__check_this_layer()
	end

	function arg_1_0.__add_slot_cost(arg_28_0)
		local var_28_0 = 0

		for iter_28_0, iter_28_1 in ipairs(var_0_4:get_tower_chip_info().slot) do
			for iter_28_2, iter_28_3 in ipairs(var_0_5.add_cost_chip) do
				if iter_28_1 == iter_28_2 then
					var_28_0 = var_28_0 + iter_28_3
				end
			end
		end

		return var_28_0
	end

	function arg_1_0:on_click_situation_buff_btn_event(arg_29_1)
		if arg_29_1 and self._last_click_layer ~= self._now_layer then
			local var_29_0 = ""

			for iter_29_0, iter_29_1 in pairs(self._now_layer_map_cfg.tower_buff) do
				var_29_0 = var_29_0 .. var_0_15.find_object_by_id(iter_29_1).desc .. "\n"
			end

			self._control.main.situation_buff.info_panel.text.text = var_0_16.only_extract_word(var_29_0)
			self._control.main.situation_buff.info_panel.buff_bg.info_txt.text.text = var_0_16.convert_rich_text(var_29_0)
			self._last_click_layer = self._now_layer
		end

		self._control.main.situation_buff:SetActive(arg_29_1)
	end

	function arg_1_0:__on_click_card_event(arg_30_1)
		local var_30_0, var_30_1 = var_0_4:get_tower_used_ship()

		if var_30_1 and var_30_1 ~= self._now_layer then
			(var_0_3:getInstance("msgbox") or var_0_3:createInstance("msgbox")):show(var_0_2:getNowLang("sixthquitlayertip"), function()
				self._old_reset_data = var_0_4:get_tower_data_by_level(self._now_layer)

				var_0_4:req_TowerResetLevelReq(var_30_1)
				var_0_4:clear_tower_used_ship(var_30_1)
				self:__go_tower_fight(arg_30_1)
			end, function()
				self:__play_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.back))
			end, var_0_2:getNowLang("sixthquitlayertiptitle"), var_0_5.msg_type.tip, nil)

			return
		end

		self:__go_tower_fight(arg_30_1)
	end

	function arg_1_0:__go_tower_fight(arg_33_1)
		var_0_4:set_tower_node_info(self._now_layer_data)
		self:setVisible(false)
		var_0_3:createInstance("fight_prepare"):show({
			tower_monster = self._now_layer_map_cfg.enemys[arg_33_1],
			fight_prepare_type = var_0_5.fight_type.tower_fight,
			now_layer_map_cfg = self._now_layer_map_cfg,
			now_layer = self._now_layer,
			card_index = arg_33_1
		}, self.isGray)
	end

	function arg_1_0:set_tower_panel_block_raycasts(arg_34_1)
		self._panel.transform:GetComponent("CanvasGroup").blocksRaycasts = arg_34_1

		if arg_34_1 then
			self:__play_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.back))
		end
	end

	function arg_1_0.__reset_btn_msgbox(arg_35_0)
		var_0_3:createInstance("msgbox"):show(var_0_2:getNowLang("ui_tower_reset_content"), function()
			arg_35_0._last_battle_info = nil
			arg_35_0._after_battle_rotated = {}
			arg_35_0._old_reset_data = var_0_4:get_tower_data_by_level(arg_35_0._now_layer)

			var_0_4:req_TowerResetLevelReq(arg_35_0._now_layer)
		end, nil, var_0_2:getNowLang("ui_tower_reset_title"))
	end

	function arg_1_0:reset_event_resp()
		for iter_37_0, iter_37_1 in pairs(self._old_reset_data.enemys) do
			if iter_37_1.pass == true then
				self:__card_rotate(iter_37_1.id)
			end
		end

		self:__set_reset_btn_clickable(self:__can_reset_this_layer())
	end

	function arg_1_0:__init_language()
		self._control.main.top.title.text.text = var_0_2:getNowLang("ui_tower_title")
		self._control.main.bottom.last_layer.txt.text.text = var_0_2:getNowLang("ui_tower_floor_left")
		self._control.main.bottom.reset.txt.text.text = var_0_2:getNowLang("ui_tower_floor_reset")
		self._control.main.bottom.next_layer.txt.text.text = var_0_2:getNowLang("ui_tower_floor_right")
		self._control.main.bottom.layer_info.txt.text.text = var_0_2:getNowLang("ui_tower_current_floor")
		self._control.main.top.res_bg.title.text.text = var_0_2:getNowLang("ui_tower_user_cost")
	end

	function arg_1_0:__init_constant()
		self._item_list = {
			self._control.main.middle.item_1,
			self._control.main.middle.item_2,
			self._control.main.middle.item_3,
			self._control.main.middle.item_4,
			self._control.main.middle.item_5
		}
		self._guide_data = var_0_14.get_sequence()
		self._page_first = 1
		self._page_end = var_0_5.tower_instructions_page
		self._page_move = 1
	end

	function arg_1_0:__init_active()
		self._control.instructions.gameObject:SetActive(false)
		self._control.main.situation_buff:SetActive(false)
		self._control.instructions.prev:SetActive(false)

		self._control.instructions.main.main_tip.main_pic.image.sprite = self:loadSprite(var_0_7(var_0_5.tower_instructions_pic, 1))
		self._control.instructions.main.main_tip.tip_word.text.text = var_0_2:convert_rich_text(self._guide_data[1].desc)
		self._control.instructions.main.title.text.text = var_0_2:get(self._guide_data[1].title)
		self._control.instructions.page.page_1.text.text = self._page_first
		self._control.instructions.page.page_2.text.text = self._page_end
	end

	function arg_1_0:__show_last_unlock_layer()
		self._max_layer = var_0_4:get_tower_max_level()

		self:show_now_layer(self._max_layer)
	end

	function arg_1_0:check_if_has_reward_not_receive()
		local var_42_0 = false

		self._max_layer = var_0_4:get_tower_max_level()

		for iter_42_0 = 1, self._max_layer - 1 do
			if var_0_4:get_tower_data_by_level(iter_42_0).get_reward == false then
				var_42_0 = true

				break
			end
		end

		self._control.main.top.btns.award.tips:SetActive(var_42_0)
	end

	function arg_1_0:__check_card()
		local var_43_0 = var_0_4:get_tower_node_info()
		local var_43_1 = var_0_4:get_tower_data_by_level(var_43_0.level)

		self:show_now_layer(var_43_0.level)

		for iter_43_0 = 1, #var_43_0.enemys do
			if var_43_0.enemys[iter_43_0].pass == false and var_43_1.enemys[iter_43_0].pass == true then
				self:__card_rotate(var_43_0.enemys[iter_43_0].id)
			end
		end
	end

	function arg_1_0:__rotate_card_after_battle(arg_44_1)
		local var_44_0

		self._item_list = {
			self._control.main.middle.item_1,
			self._control.main.middle.item_2,
			self._control.main.middle.item_3,
			self._control.main.middle.item_4,
			self._control.main.middle.item_5
		}

		for iter_44_0, iter_44_1 in pairs(self._now_layer_map_cfg.enemys) do
			if iter_44_1 == arg_44_1.monster then
				var_44_0 = self._item_list[iter_44_0]
			end
		end

		self:__update_bnottom_bns()

		for iter_44_2, iter_44_3 in ipairs(self._now_layer_map_cfg.enemys) do
			local var_44_1 = self._item_list[iter_44_2]
			local var_44_2 = self:__get_monster_state(iter_44_3)
			local var_44_3
			local var_44_4

			if self._now_layer_map_cfg.special_enemy[iter_44_2] == 0 then
				var_44_3 = var_0_5.tower_const.normal_bg
				var_44_4 = var_0_5.tower_const.card_spine_name.yellow
			else
				var_44_3 = var_0_5.tower_const.special_bg
				var_44_4 = var_0_5.tower_const.card_spine_name.red
			end

			var_44_1.monster.bg.icon.image.sprite = self:loadSprite(var_0_5:get_ship_icon(var_0_5.ship_icon.model_normal_m, self._now_layer_map_cfg.enemy_icon[iter_44_2]))
			var_44_1.monster.bg.image.sprite = self:loadSprite(var_44_3)

			self:__set_card_spine_skin(var_44_1, var_44_4)
		end

		if arg_44_1.grade <= var_0_5.battle_score.s then
			var_44_0.monster.bg:GetComponent("Button").interactable = false
			self._seq_bg2 = self:autoKillDOTween(var_0_9.Sequence())

			self._seq_bg2:Append(var_44_0.monster.transform:DOLocalRotate(var_0_11(0, 90, 0), 1))
			self._seq_bg2:InsertCallback(1, function()
				var_44_0.bg:SetActive(true)
				self._seq_bg2:Append(var_44_0.bg.transform:DOLocalRotate(var_0_11(0, 0, 0), 1))
				var_44_0.monster:SetActive(false)

				var_44_0.monster.bg:GetComponent("Button").interactable = true
			end)
		end

		var_0_8(self._after_battle_rotated, arg_44_1.monster)
	end

	function arg_1_0:__check_this_layer()
		self._now_layer_data = var_0_4:get_tower_data_by_level(self._now_layer)

		log.print_r(self._now_layer_data.enemys, "self._now_layer_data.enemys")
		log.print_r(self._now_layer_data.use_ship, "self._now_layer_data.use_ship")

		if self._now_layer_data and self._now_layer_data.enemys and next(self._now_layer_data.enemys) and self._now_layer_data.use_ship and next(self._now_layer_data.use_ship) then
			for iter_46_0, iter_46_1 in pairs(self._now_layer_data.enemys) do
				if not iter_46_1.pass then
					return
				end
			end

			var_0_4:clear_tower_used_ship(self._now_layer)
		end
	end

	function arg_1_0:__init_panel(arg_47_1)
		if not self._is_already_init then
			self:__init_language()
			self:__init_constant()
			self:__init_active()
			self:__init_show_instructions()
			self:__play_into_bgm(var_0_5:get_audio_url(var_0_5.common_icon.music_path, "move5"))
		end

		self._tower_node_info = var_0_4:get_tower_node_info()

		if arg_47_1 then
			self:__card_rotate(arg_47_1.monster)
		elseif not self._now_layer then
			self:__show_last_unlock_layer()
			self:__card_anim(true, nil)
		else
			self:show_now_layer(self._now_layer)
			self:__card_anim(true, nil)
		end

		self:check_if_has_reward_not_receive()

		self._is_already_init = true
	end

	function arg_1_0.__destroy_panel(arg_48_0)
		var_0_4:set_tower_node_info(nil)
		var_0_3:destroyInstance("climb_tower")
	end

	function arg_1_0:back_tower_ranking_list()
		self:__onClick_main_top_btns_rank()
	end

	function arg_1_0.show_first_award(arg_50_0, arg_50_1)
		var_0_3:createInstance("mail_box"):show_awards_enter_from_other_ways(arg_50_1)

		arg_50_0._is_first_enter = false
	end

	function arg_1_0:__broken_first()
		self:__check_if_first_enter()

		if self._is_first_enter then
			self._control.instructions:SetActive(true)
			self._control.instructions.colse.button.onClick:AddListener(function()
				if self._is_first_enter then
					var_0_4:req_TowerGetNewReq()
				end
			end)
		end
	end

	function arg_1_0.__check_if_first_enter(arg_53_0)
		local var_53_0 = var_0_4:get_tower_chip_info()

		arg_53_0._is_first_enter = not not (var_53_0 and not var_53_0.get_new)
	end

	function arg_1_0.__onReset(arg_54_0)
		arg_54_0._is_already_init = false
		arg_54_0._now_layer_data = nil
		arg_54_0._now_layer_map_cfg = nil
		arg_54_0._last_click_layer = nil
		arg_54_0._is_first_enter = false
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_55_0)
	local var_55_0 = var_0_3:class("climb_tower")

	var_55_0._is_already_init = false
	var_55_0._now_layer = nil
	var_55_0._max_layer = 1
	var_55_0._now_layer_data = nil
	var_55_0._now_layer_map_cfg = nil
	var_55_0._fast_jump_last_layer = 1
	var_55_0._fast_jump_next_layer = 1
	var_55_0._last_click_layer = nil
	var_55_0._tower_node_info = nil
	var_55_0._last_battle_info = nil
	var_55_0._old_reset_data = nil
	var_55_0._after_battle_rotated = {}
	var_55_0._page_first = nil
	var_55_0._page_end = nil
	var_55_0._page_move = nil
	var_55_0._guide_data = nil

	gamecore.extend_obj(var_55_0)

	return var_55_0
end

return var_0_0
