local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = gameenum.common_type
local var_0_5 = gameconfig.map_config
local var_0_6 = gameconfig.map_node_config
local var_0_7 = gameconfig.sixth_adjutant_config
local var_0_8 = gameconfig.ship_config
local var_0_9 = gameconfig.skin_config
local var_0_10 = gameconfig.skill_config
local var_0_11 = gameconfig.monster_formation_config
local var_0_12 = gameconfig.monster_config
local var_0_13 = gameconfig.sixth_map_node_config
local var_0_14 = gameconfig.sixth_map_config
local var_0_15 = gameconfig.pve_fifth_level_config
local var_0_16 = gameconfig.fifth_map_node_config
local var_0_17 = gameconfig.pve_score_buff_config
local var_0_18 = gameconfig.pve_score_level_config
local var_0_19 = gameconfig.score_map_node_config
local var_0_20 = gameconfig.cinema_story_id_list_config
local var_0_22 = gameconfig.pve_mix_level_node_config
local var_0_23 = string.format
local var_0_24 = string.gsub
local var_0_25 = string.sub
local var_0_26 = UnityEngine.Vector2
local var_0_27 = UnityEngine.Vector3
local var_0_28 = UnityEngine.Color
local var_0_29 = UnityEngine.Time
local var_0_30 = gamecore.SceneManager
local var_0_31 = math.floor
local var_0_32 = table.insert
local var_0_33 = DG.Tweening.DOTween
local var_0_34 = gamecore.util_func
local var_0_35 = gameconfig.ship_pve_buff_config
local var_0_36 = gameconfig.abyss_buff_config
local var_0_38 = gameenum.battle_type
local var_0_39 = gameconfig.pve_active_map_node_config
local var_0_40 = gameconfig.pve_active_buff_config
local var_0_41 = gameconfig.ship_pve_active_config
local var_0_42 = gameconfig.pve_mix_map_config
local var_0_43 = gameconfig.pve_mix_buff_config
local var_0_44 = gameconfig.pve_eighth_buff_config
local var_0_45 = gameconfig.pve_active_map_config
local var_0_46 = gameconfig.pve_ninth_level_config
local var_0_47 = gameconfig.pve_ninth_level_node_config
local var_0_48 = {
	10,
	10,
	10,
	10,
	10,
	10,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	10,
	10,
	10,
	nil,
	10,
	10,
	10,
	10,
	nil,
	10,
	[99] = 10,
	[98] = 10
}
local var_0_49 = {
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	10,
	10,
	10,
	10,
	10,
	10,
	nil,
	nil,
	nil,
	10,
	[20] = 10
}
local var_0_50 = {
	[15] = 1,
	[13] = 1,
	[14] = 1
}
local var_0_51 = gameconfig.item_config

gamecore.UILoader:define("fight_info", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self._now_into_param = arg_2_1

		self:setVisible(true)
		self:__init_language()
		self:__init_effects()
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))
		self:__init_panel(arg_2_1)
	end

	function arg_1_0:__onUpdate()
		if not var_0_3:isGameIng() then
			return
		end

		if not self._time_execute_task_list then
			return
		end

		for iter_3_0, iter_3_1 in ipairs(self._time_execute_task_list) do
			if iter_3_1.execute_time > 0 then
				iter_3_1.execute_time = iter_3_1.execute_time - var_0_29.deltaTime

				if iter_3_1.execute_time <= 0 and iter_3_1.execute_func then
					if iter_3_0 == #self._time_execute_task_list then
						self._time_execute_task_list = nil
					end

					iter_3_1.execute_func()
				end
			end
		end
	end

	function arg_1_0:back_to_gotofight()
		if self._fight_type == var_0_4.fight_type.event_story then
			local var_4_0 = var_0_14.find_object_by_id(self._map_id).level_id
			local var_4_1 = var_0_2:createInstance("six_year_main_interface")

			var_4_1.now_map_level = var_4_0

			self:__reset_panel()
			var_0_2:destroyInstance("fight_info")
			var_4_1:show(var_4_0)
			var_0_3:set_battle_type(nil)

			return
		elseif self._fight_type == var_0_4.fight_type.fearlessness_sea then
			var_0_2:destroyInstance("fight_info")

			local var_4_2 = var_0_2:createInstance("fearlessness_sea")

			var_4_2:show()
			var_4_2:__change_hard_map((var_0_3:get_fearlessness_is_hard()))
			self:__reset_panel()
			var_0_3:show_panel_mix_panel(self._map_id)

			return
		elseif self._fight_type == var_0_4.fight_type.war_concerto_play then
			local var_4_3 = var_0_2:createInstance("fifth_event")

			if var_4_3 then
				var_0_2:destroyInstance("fight_info")
				var_4_3:show()
				var_4_3:__change_btn_event(false)
			end

			self:__reset_panel()

			return
		elseif self._fight_type == var_0_4.fight_type.war_concerto or self._fight_type == gameenum.battle_type.fight_type.war_concerto then
			local var_4_4 = var_0_2:createInstance("fifth_event")

			if var_4_4 then
				var_0_2:destroyInstance("fight_info")
				var_4_4:show()
			end

			self:__reset_panel()

			return
		elseif self._fight_type == var_0_4.fight_type.ocean_attack then
			self:__reset_panel()
			var_0_2:destroyInstance("fight_info")

			local var_4_5 = var_0_2:createInstance("ocean_main_map")

			if var_4_5 then
				var_4_5:show()
			end

			var_0_3:req_OceanQuitMapReq()

			return
		elseif self._fight_type == var_0_4.fight_type.score_attack then
			self:__reset_panel()
			var_0_2:destroyInstance("fight_info")

			local var_4_6 = var_0_2:createInstance("score_push_map")

			if var_4_6 then
				var_4_6:show()
				var_4_6:show_score_panel_mix_panel(self._map_id, var_0_3:get_is_cur_score_difficulty_mode())
			end

			var_0_3:req_AnswerQuitMapReq()

			return
		elseif self._fight_type == var_0_4.fight_type.abyss_model_first_phase then
			self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.abyss_activity_bgm))
			var_0_3:req_AbyssQuitMapReq()
			self:__reset_panel()
			var_0_2:destroyInstance("fight_info")

			if var_0_2:getInstance("abyss_preview") then
				var_0_2:destroyInstance("abyss_preview")
			end

			self._abyss_buff_select = {}

			;(var_0_2:getInstance("abyss_event") or var_0_2:createInstance("abyss_event")):show()

			return
		elseif self._fight_type == var_0_4.fight_type.seventh then
			var_0_2:destroyInstance("fight_info")
			self:__reset_panel()
			var_0_3:req_SeventhQuitMapReq()

			local var_4_7 = var_0_3:get_now_seven_map_id()
			local var_4_8 = var_0_2:getInstance("seven_sea_map")

			if var_4_8 then
				var_4_8._panel.transform:GetComponent("Canvas").sortingOrder = 500

				var_4_8:show(var_4_7)
				var_4_8:set_boss_func()
			else
				var_4_8 = var_0_2:createInstance("seven_sea_map")
				var_4_8._panel.transform:GetComponent("Canvas").sortingOrder = 500

				var_4_8:show(var_4_7)
				var_4_8:set_boss_func()
			end

			var_4_8:show_cover_func(false)

			return
		elseif self._fight_type == var_0_4.fight_type.eighth_attack then
			var_0_2:destroyInstance("fight_info")
			self:__reset_panel()
			var_0_3:req_EighthQuitMapReq()

			local var_4_9 = var_0_3:get_now_eighth_map_id()
			local var_4_10 = var_0_2:getInstance("eighth_sea_map")

			if var_4_10 then
				var_4_10._panel.transform:GetComponent("Canvas").sortingOrder = 500

				var_4_10:show(var_4_9)
				var_4_10:set_boss_func()
			else
				var_4_10 = var_0_2:createInstance("eighth_sea_map")
				var_4_10._panel.transform:GetComponent("Canvas").sortingOrder = 500

				var_4_10:show(var_4_9)
				var_4_10:set_boss_func()
			end

			var_4_10:show_cover_func(false)

			return
		else
			local var_4_12

			if self._fight_type == var_0_4.fight_type.ninth_attack then
				self:__reset_panel()
				var_0_2:destroyInstance("fight_info")
				var_0_2:destroyInstance("combat_result")

				local var_4_11 = var_0_2:createInstance("ninth_main_map")

				if var_4_11 then
					var_4_11:show()

					if var_0_3:get_is_ninth_boss() then
						if var_0_3:ninth_map_is_pass(var_4_11._active_config.levels[5]) then
							for iter_4_0 = 1, 4 do
								var_4_11:_show_map_panel(self._map_id, iter_4_0, var_4_11._ninth_hard_map_data[5].init_nodes)
							end
						else
							for iter_4_1 = 1, 4 do
								var_4_11:_show_map_panel(self._map_id, iter_4_1, var_4_11._ninth_normal_map_data[5].init_nodes)
							end
						end
					else
						var_4_11:_show_map_panel(self._map_id, 1, (var_0_3:get_ninth_map_start_point()))
					end
				end

				var_0_3:req_NinthQuitMapReq()

				do return end

				var_4_12 = {
					is_open_init = true,
					toggle_index = var_0_4.fight_type.gotofight
				}
			end
		end

		var_4_12.init_chapter_index = var_0_5.find_object_by_id(self._map_id).pve_id
		var_4_12.init_map_index = tonumber(self._map_id) % 100

		var_0_2:destroyInstance("fight_info")
		var_0_2:createInstance("gotofight"):show(var_4_12, false)
		self:__reset_panel()
	end

	function arg_1_0:toggle_continue_tip_box(arg_5_1)
		self._control.mask.gameObject:SetActive(arg_5_1)

		if arg_5_1 then
			self._control.bg.info_bg.select_formation.canvasGroup.alpha = 0

			self:__get_new_guide_state_info(2)

			for iter_5_0, iter_5_1 in pairs(self._map_node_data) do
				local var_5_0 = var_0_3:get_cur_butter_list(iter_5_1.pve_level_id)
				local var_5_1 = self._liner_list[iter_5_1.id]

				if self._liner_list[iter_5_1.id] and var_5_0 and next(var_5_0) then
					local var_5_3 = var_0_6.find_object_by_id(iter_5_1.id)

					if self._fight_type == var_0_4.fight_type.war_concerto_play then
						var_5_3 = var_0_16.find_object_by_id(iter_5_1.id)
					elseif self._fight_type == var_0_4.fight_type.ocean_attack then
						local var_5_4 = ocean_map_node_config.find_object_by_id_start_node_id(iter_5_1.id, (var_0_3:get_current_ocean_map_start_point()))
					elseif self._fight_type == var_0_4.fight_type.score_attack then
						local var_5_5 = var_0_19.find_object_by_id_start_node_id(iter_5_1.id, (var_0_3:get_current_score_map_start_point()))
					elseif self._fight_type == var_0_4.fight_type.fearlessness_sea then
						var_5_3 = var_0_39.find_object_by_id(iter_5_1.id)
					end

					if (var_5_0[iter_5_1.id] or nil) and true then
						for iter_5_2, iter_5_3 in pairs(iter_5_1.next_node) do
							local var_5_6 = var_0_6.find_object_by_id(iter_5_3)

							if self._fight_type == var_0_4.fight_type.war_concerto_play then
								var_5_6 = var_0_16.find_object_by_id(iter_5_3)
							elseif self._fight_type == var_0_4.fight_type.ocean_attack then
								var_5_6 = ocean_map_node_config.find_object_by_id_start_node_id(iter_5_3, (var_0_3:get_current_ocean_map_start_point()))
							elseif self._fight_type == var_0_4.fight_type.score_attack then
								var_5_6 = var_0_19.find_object_by_id_start_node_id(iter_5_3, (var_0_3:get_current_score_map_start_point()))
							elseif self._fight_type == var_0_4.fight_type.fearlessness_sea then
								var_5_6 = var_0_39.find_object_by_id(iter_5_3)
							end

							if var_5_3 ~= nil and not not var_5_0[iter_5_3] then
								local var_5_7 = var_5_3.flag

								if self._fight_type == var_0_4.fight_type.ocean_attack and (var_5_3.flag == "α" or var_5_3.flag == "β") then
									var_5_3.flag = 0
								end

								if self._fight_type == var_0_4.fight_type.score_attack and (var_5_3.flag == "α" or var_5_3.flag == "β") then
									var_5_3.flag = 0
								end

								local var_5_8 = var_0_23("%s-%s-%s", var_5_3.pve_level_id, var_5_3.flag == "" and 0 or var_5_3.flag, var_5_6.flag)

								for iter_5_4, iter_5_5 in pairs(var_5_1) do
									if iter_5_5.lineImageName == var_5_8 then
										iter_5_5.mapLineControl.line_image.image.color = var_0_28.New(0.2, 0.5686274509803921, 0.8666666666666667)

										if self._fight_type == var_0_4.fight_type.fearlessness_sea and var_0_3:get_fearlessness_is_hard() then
											iter_5_5.mapLineControl.line_image.image.color = var_0_28.New(0.6196078431372549, 0.2, 0.2)
										end

										if iter_5_5.isCanNeedClose then
											iter_5_5.mapLineControl.line_image.image.color = var_0_28.New(1, 1, 1)
										end
									end
								end

								if self._fight_type == var_0_4.fight_type.ocean_attack then
									var_5_3.flag = var_5_7
								end

								if self._fight_type == var_0_4.fight_type.score_attack then
									var_5_3.flag = var_5_7
								end
							end
						end
					end
				end
			end
		end

		if self._fight_type == var_0_4.fight_type.event_story then
			self._control.mask.gameObject:SetActive(false)
			self:__show_fight_info(self._start_node_id)

			return
		end

		if self._fight_type == var_0_4.fight_type.war_concerto_play then
			self._control.mask.frame.ui_combatcontinuetip:SetActive(false)
			self._control.mask.frame.bullet:SetActive(false)
			self._control.mask.frame.oil:SetActive(false)
			self._control.mask.frame.damagecontrol:SetActive(false)
			self._control.mask.frame.buy:SetActive(false)
			self._control.mask.frame.ui_tip_mid:SetActive(true)
		elseif self._fight_type == var_0_4.fight_type.abyss_model_first_phase then
			local var_5_9 = var_0_3:get_abyss_preview_now_page()

			if var_5_9 and var_5_9 == 1 then
				self._control.mask.frame.ui_combatcontinuetip.text.text = var_0_1:getNowLang("ui_ny21_fleet_deep_energy")

				self._control.mask.frame.bullet:SetActive(false)
				self._control.mask.frame.oil:SetActive(false)
				self._control.mask.frame.damagecontrol:SetActive(false)
				self._control.mask.frame.buy:SetActive(false)

				local var_5_10 = var_0_3:get_abyss_power()

				var_5_10 = var_5_10 > 100 and 100 or var_5_10

				local var_5_11 = var_5_10 / 100
				local var_5_12 = ""

				if var_5_10 > 0 and var_5_10 < 30 then
					var_5_12 = var_0_4.abyss_converter.abyss_converter_red
				elseif var_5_10 >= 30 and var_5_10 < 60 then
					var_5_12 = var_0_4.abyss_converter.abyss_converter_yellow
				elseif var_5_10 >= 60 and var_5_10 <= 100 then
					var_5_12 = var_0_4.abyss_converter.abyss_converter_green
				end

				self._control.mask.frame.abyss_power.fill.image.sprite = self:loadSprite(var_5_12)
				self._control.mask.frame.abyss_power.fill.image.fillAmount = var_5_10 / 100
				self._control.mask.frame.abyss_power.tip.num.text.text = var_5_11 * 100 .. "/" .. 100

				self._control.mask.frame.abyss_power:SetActive(true)
			end
		end
	end

	function arg_1_0:set_return_home_layer()
		self._control.return_home:SetActive(self._show_return_home)

		local var_6_0 = 0.3
		local var_6_1 = self._show_return_home and 0.2 or 0

		self._control.return_home.left_layer.rectTransform.anchoredPosition = var_0_26(-1500, -360)

		self._control.return_home.left_layer.rectTransform:DOAnchorPos(var_0_26(-300, 0), var_6_0):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(var_6_1):SetAutoKill(true)

		self._control.return_home.right_layer.rectTransform.anchoredPosition = var_0_26(1500, -360)

		self._control.return_home.right_layer.rectTransform:DOAnchorPos(var_0_26(300, 0), var_6_0):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(var_6_1):SetAutoKill(true)

		self._control.return_home.right_layer.language_image.image.sprite = self._fighting_status == var_0_4.fighting_status.oil_none and self:loadSprite(var_0_4.fighting_status_image.oil_none) or self:loadSprite(var_0_4.fighting_status_image.is_big_poor)

		local var_6_3 = self._fight_type == var_0_4.fight_type.abyss_model_first_phase and self.is_abyss_team and var_0_3:find_abyss_character_by_id(self._people_icon_id) or var_0_3:find_character_by_id(self._people_icon_id)
		local var_6_4 = var_0_8.find_object_by_cid(var_6_3.cid)
		local var_6_5 = var_0_34:use_big_break_painting(var_6_3, var_0_4.ship_icon_type.model_l, true)
		local var_6_6

		if var_6_3.skin ~= 0 then
			var_6_6 = var_0_4:get_ship_icon(var_6_5, var_0_9.find_object_by_cid(var_6_3.skin).icon)
			live_2d = var_0_9.find_object_by_cid(var_6_3.skin).live2d
		else
			var_6_6 = var_0_4:get_ship_icon(var_6_5, var_6_4.pic_id)
		end

		local var_6_7, var_6_8 = self:loadSprite(var_6_6)

		self._save_have_hd_sprite = var_6_8
		self._control.return_home.left_layer.people_icon.image.sprite = var_6_7

		if var_6_8 then
			var_0_4:hd_sprite_half_scale(self._control.return_home.left_layer.people_icon.transform)
		end
	end

	function arg_1_0:set_damagecontrol_num()
		local var_7_0 = var_0_3:get_item_count(gameconfig.shop_config.find_object_by_id(var_0_4.shop_damage_control_cid).content[1].id)

		self._control.mask.frame.damagecontrol.gross.text.text = var_0_23("x%d", var_7_0)

		if var_7_0 >= 5 then
			self._control.mask.frame.buy:SetActive(false)
		else
			self._control.mask.frame.buy:SetActive(true)
		end

		local var_7_1 = self:autoKillDOTween(var_0_33.Sequence())

		var_7_1:Append(self._control.mask.frame.danger_layer.danger_tips.image:DOFade(0, 1))
		var_7_1:Append(self._control.mask.frame.danger_layer.danger_tips.image:DOFade(1, 1))
		var_7_1:Append(self._control.mask.frame.danger_layer.danger_tips.image:DOFade(1, 0))
		var_7_1:SetLoops(-1)
		var_7_1:Play()
	end

	function arg_1_0.set_guide_fight_state(arg_8_0)
		if var_0_3:get_guide_state() then
			local var_8_0 = var_0_2:getInstance("guide_panel")
			local var_8_1

			if var_8_0 then
				var_8_1 = var_8_0:get_current_step()
			else
				var_8_0 = var_0_2:createInstance("guide_panel")
				var_8_1 = var_8_0:get_current_step()
			end

			if var_8_1 == var_0_4.guide_const_id.ten_group.one then
				var_8_0:set_limit_step_to_complate(var_0_4.guide_const_id.ten_group.one)

				return
			end

			if var_8_0:get_next_step() == var_0_4.guide_const_id.first_group.five then
				var_8_0:set_limit_step_to_complate(var_0_4.guide_const_id.first_group.five)
			end
		end
	end

	function arg_1_0:get_guide_btn_pos_info(arg_9_1)
		if arg_9_1 == var_0_4.guide_const_id.first_group.six then
			return self._control.mask.frame.quit.transform
		end
	end

	function arg_1_0.set_send_req_state(arg_10_0, arg_10_1)
		arg_10_0._can_send_req = arg_10_1
	end

	function arg_1_0:__init_language()
		self._control.bg.info_bg.enemy_info_bg.back_btn.text.text.text = var_0_1:getNowLang("ui_combat_return")
		self._control.bg.info_bg.enemy_info_bg.fight_btn.text.text.text = var_0_1:getNowLang("ui_combat_fight")
		self._control.bg.info_bg.enemy_info_bg.circuity_btn.text.text.text = var_0_1:getNowLang("pveskipwar")
		self._control.bg.info_bg.select_formation.right_widget.title_txt.text.text = var_0_1:getNowLang("pveselectformation")
		self._control.return_home.right_layer.return_text.text.text = var_0_1:getNowLang("pvequit")
		self._control.bg.info_bg.round_about_lock_enemy_txt.text.text = var_0_1:getNowLang("combat_radar_probability")

		for iter_11_0 = 1, 5 do
			gamecore.util_func.setTextHorizonInfo(self._control.bg.info_bg.select_formation.right_widget["select" .. iter_11_0].title_mask, var_0_1:getNowLang("warformation" .. iter_11_0))
		end

		self._control.broken_info.broken_info_name.text.text = var_0_1:getNowLang("danger_tips")
		self._control.broken_info.broken_content.text.text = var_0_1:getNowLang("danger_tips_desc")
	end

	function arg_1_0:__init_panel(arg_12_1)
		self._fight_type = arg_12_1.fight_type
		self._abyss_map_id = arg_12_1.start_node_id

		self._control.bg.info_bg.enemy_info_bg.line_bottom.random_tip_Text:SetActive(false)

		self._input_map_node = arg_12_1.input_map_node_id or 0

		self._control.fearlessness_buff_msgbox:SetActive(false)

		self._can_send_req = true

		self._control.bg.info_bg.enemy_info_bg.fight_btn:SetActive(true)
		self._control.bg.info_bg.enemy_info_bg.back_btn:SetActive(true)

		self._set_bvr_btn_isOn = false
		self._control.bg.info_bg.enemy_info_bg.bvr_btn.text.text.text = var_0_1:getNowLang("beyond_line_of_sight")
		self._have_bvr_ship = self:__set_bvr_btn(arg_12_1.team_detail_data, arg_12_1)

		self._control.bg.info_bg.enemy_info_bg.bvr_btn:SetActive(false)
		self._control.bg.info_bg.enemy_info_bg.bvr_btn.spine_effect:SetActive(false)

		self._now_btn_pos = self._control.bg.info_bg.enemy_info_bg.back_btn.transform.localPosition

		if self._fight_type ~= var_0_4.fight_type.event_story then
			self._control.bg.return_btn:SetActive(false)
			self._control.bg.big_bg:SetActive(false)
			self._control.bg.left_people:SetActive(false)
			self._control.bg.select_node_layer:SetActive(false)
		end

		if self._fight_type == var_0_4.fight_type.gotofight then
			self._map_id = arg_12_1.map_id
			self._start_node_id = arg_12_1.start_node_id
		elseif self._fight_type == var_0_4.fight_type.exercise then
			-- block empty
		elseif self._fight_type == var_0_4.fight_type.farfight then
			-- block empty
		elseif self._fight_type == var_0_4.fight_type.campaign then
			self._map_id = arg_12_1.map_id
			self._start_node_id = arg_12_1.start_node_id
		elseif self._fight_type == var_0_4.fight_type.event_story then
			self._map_id = arg_12_1.id
			self._bg_id = arg_12_1.map_id
			self._start_node_id = arg_12_1.start_node_id

			self._control.bg.return_btn:SetActive(true)
			self._control.bg.big_bg:SetActive(true)
			self._control.bg.left_people:SetActive(true)

			self._adjutant_set, self._adjutant_cid, self._current_adjutant_index = var_0_3:get_six_adjutant()
			self._adjutant_config = var_0_7.find_object_by_id(self._adjutant_set[self._current_adjutant_index])
			self._control.bg.left_people.image.sprite = self:loadSprite((var_0_23(var_0_4.sixth_adjutant_image, self._adjutant_config.id)))

			self._control.bg.left_people:GetComponent("Image"):SetNativeSize()
		elseif self._fight_type == var_0_4.fight_type.fearlessness_sea then
			self._map_id = arg_12_1.map_id
			self._start_node_id = arg_12_1.start_node_id

			self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_45.find_object_by_id(self._map_id).music))
		elseif self._fight_type == var_0_4.fight_type.strike then
			self:__init_strike_active()

			self._map_id = arg_12_1.map_id
			self._start_node_id = arg_12_1.start_node_id
		elseif self._fight_type == var_0_4.fight_type.war_concerto or self._fight_type == var_0_4.fight_type.war_concerto_play or self._fight_type == gameenum.battle_type.fight_type.war_concerto or self._fight_type == gameenum.battle_type.fight_type.war_concerto_play then
			self._map_id = arg_12_1.map_id
			self._start_node_id = arg_12_1.start_node_id
		elseif self._fight_type == var_0_4.fight_type.ocean_attack then
			self._map_id = arg_12_1.map_id
			self._start_node_id = arg_12_1.start_node_id
		elseif self._fight_type == var_0_4.fight_type.score_attack then
			self._map_id = arg_12_1.map_id
			self._start_node_id = arg_12_1.start_node_id
			self._score_bgm = var_0_18.find_object_by_id(self._map_id).music

			self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, self._score_bgm))
		elseif self._fight_type == var_0_4.fight_type.abyss_model_first_phase then
			self._map_id = arg_12_1.map_id
			self._start_node_id = arg_12_1.start_node_id
			self.is_abyss_team = arg_12_1.is_abyss_team

			self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.battle_event_ten))
		elseif self._fight_type == var_0_4.fight_type.seventh then
			self._map_id = arg_12_1.map_id
			self._seven_bgm = var_0_42.find_object_by_id(self._map_id).music_battle

			self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, self._seven_bgm))

			self._start_node_id = arg_12_1.start_node_id
		elseif self._fight_type == var_0_4.fight_type.eighth_attack then
			self._map_id = arg_12_1.map_id
			self._eighth_bgm = gameconfig.pve_eighth_level_config.find_object_by_id(self._map_id).music

			self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, self._eighth_bgm))

			self._start_node_id = arg_12_1.start_node_id
		elseif self._fight_type == var_0_4.fight_type.ninth_attack then
			self._map_id = arg_12_1.map_id
			self._start_node_id = arg_12_1.start_node_id
			self._ninth_bgm = var_0_46.find_object_by_id(self._map_id).music

			self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, self._ninth_bgm))
		end

		self._team_detail_data = arg_12_1.team_detail_data or {}

		if not next(self._team_detail_data) then
			self:__init_team_detail_data(arg_12_1.members)
		end

		self._control.bg_r.image.sprite = self._fight_type == var_0_4.fight_type.event_story and self:loadSprite(var_0_23(var_0_4.map_path, self._bg_id, self._bg_id)) or self._fight_type == var_0_4.fight_type.abyss_model_first_phase and self:loadSprite(var_0_23(var_0_4.abyss_const.abyss_fight_bg, self._map_id)) or self._fight_type == var_0_4.fight_type.score_attack and self:loadSprite(var_0_23(var_0_4.map_path_score, self._map_id, self._map_id)) or self._fight_type == var_0_4.fight_type.ninth_attack and self:loadSprite(var_0_23(var_0_4.map_path_score, self._map_id, self._map_id)) or self:loadSprite(var_0_23(var_0_4.map_path, self._map_id, self._map_id))

		local var_12_0 = var_0_5.find_object_by_id(self._map_id)

		if self._fight_type == var_0_4.fight_type.event_story then
			var_12_0 = var_0_14.find_object_by_id(self._map_id)
		elseif self._fight_type == gameenum.battle_type.fight_type.war_concerto or self._fight_type == gameenum.battle_type.fight_type.war_concerto_play or self._fight_type == var_0_4.fight_type.war_concerto or self._fight_type == var_0_4.fight_type.war_concerto_play then
			var_12_0 = var_0_15.find_object_by_id(self._map_id)
		elseif self._fight_type == var_0_4.fight_type.ocean_attack then
			self._map_id = tonumber(self._map_id)
			var_12_0 = gameconfig.pve_ocean_level_config.find_object_by_id(self._map_id)
		elseif self._fight_type == var_0_4.fight_type.score_attack then
			self._map_id = tonumber(self._map_id)
			var_12_0 = var_0_18.find_object_by_id(self._map_id)
		elseif self._fight_type == var_0_4.fight_type.abyss_model_first_phase then
			var_12_0 = gameconfig.abyss_map_config.find_object_by_id(self._map_id)
		elseif self._fight_type == var_0_4.fight_type.fearlessness_sea then
			var_12_0 = var_0_45.find_object_by_id(self._map_id)
			self._control.bg.title_bg.image.sprite = var_0_3:get_fearlessness_is_hard() and self:loadSprite(var_0_4.fearlessness_sea_top_bg.hard) or self:loadSprite(var_0_4.fearlessness_sea_top_bg.normal)

			self._control.bg.title_bg.image:SetNativeSize()

			if not self._already_init then
				self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_12_0.music))
			end
		elseif self._fight_type == var_0_4.fight_type.seventh then
			var_12_0 = var_0_42.find_object_by_id(self._map_id)
		elseif self._fight_type == var_0_4.fight_type.eighth_attack then
			var_12_0 = gameconfig.pve_eighth_map_config.find_object_by_id(self._map_id)
		elseif self._fight_type == var_0_4.fight_type.ninth_attack then
			self._map_id = tonumber(self._map_id)
			var_12_0 = var_0_46.find_object_by_id(self._map_id)
		end

		if var_12_0 ~= nil then
			if self._fight_type == var_0_4.fight_type.fearlessness_sea then
				self._control.bg.title_bg.content.textHorizonScroller:SetText(var_12_0.sub_title)
			else
				self._control.bg.title_bg.content.textHorizonScroller:SetText(var_0_23("%s|%s", var_12_0.title, var_12_0.sub_title))
			end
		end

		if self._fight_type == var_0_4.fight_type.abyss_model_first_phase then
			if self._map_title == nil then
				self._map_title = var_12_0.sub_title
			elseif self._map_title ~= var_12_0.sub_title then
				self._abyss_buff_select = {}
				self._map_title = var_12_0.sub_title
			end
		end

		if self._fight_type == var_0_4.fight_type.event_story then
			self._control.bg.title_bg.content.textHorizonScroller:SetText(var_12_0.sub_title)
			self._control.bg.title_bg:SetActive(false)
		end

		self._map_node_data = self:__get_node_data_by_map_id()

		if #self._map_node_data == 0 then
			return
		end

		if self._map_id == 704 then
			if arg_12_1.start_node_id == 70401 then
				var_0_3:set_special_node_count(var_0_3:get_map_node_pass_count(self._map_id, 70405))
			end

			self._contain_miss = false

			for iter_12_0, iter_12_1 in pairs(var_0_3:get_map_list()[self._map_id].node_miss) do
				if iter_12_1.point_id == 70405 then
					self._contain_miss = true
				end
			end
		end

		self:__set_map_node()

		if self._fight_type == var_0_4.fight_type.gotofight then
			self:__update_boss_hp(var_12_0, var_12_0.need_pve_level_id)
		end

		self:__init_continue_box()

		local var_12_3 = var_0_6.find_object_by_id(self._start_node_id)

		if self._fight_type == var_0_4.fight_type.event_story then
			var_12_3 = var_0_13.find_object_by_id(self._start_node_id)
		elseif self._fight_type == var_0_4.fight_type.war_concerto or self._fight_type == var_0_4.fight_type.war_concerto_play or self._fight_type == gameenum.battle_type.fight_type.war_concerto or self._fight_type == gameenum.battle_type.fight_type.war_concerto_play then
			var_12_3 = var_0_16.find_object_by_id(self._start_node_id)
		elseif self._fight_type == var_0_4.fight_type.ocean_attack then
			var_12_3 = ocean_map_node_config.find_object_by_id_start_node_id(self._start_node_id, (var_0_3:get_current_ocean_map_start_point()))
		elseif self._fight_type == var_0_4.fight_type.score_attack then
			var_12_3 = var_0_19.find_object_by_id_start_node_id(self._start_node_id, (var_0_3:get_current_score_map_start_point()))
		elseif self._fight_type == var_0_4.fight_type.abyss_model_first_phase then
			var_12_3 = abyss_map_node_config.find_object_by_id(self._start_node_id)
		elseif self._fight_type == var_0_4.fight_type.fearlessness_sea then
			var_12_3 = var_0_39.find_object_by_id(self._start_node_id)
		elseif self._fight_type == var_0_4.fight_type.seventh then
			var_12_3 = var_0_22.find_object_by_id(self._start_node_id)
		elseif self._fight_type == var_0_4.fight_type.eighth_attack then
			var_12_3 = gameconfig.pve_eighth_level_node_config.find_object_by_id(self._start_node_id)
		elseif self._fight_type == var_0_4.fight_type.ninth_attack then
			var_12_3 = var_0_47.find_object_by_id_start_node_id(self._start_node_id, (var_0_3:get_ninth_map_start_point()))
		end

		local var_12_6

		if next(var_12_3) then
			var_12_6 = self.now_node_list[var_12_3.id]
		end

		if not var_12_6 then
			return
		end

		local var_12_8
		local var_12_9

		if self._fight_type == var_0_4.fight_type.abyss_model_first_phase then
			local var_12_10

			var_12_10, var_12_8 = var_0_3:get_abyss_fight_cam(self._map_id)

			if self._map_start_point then
				local var_12_11 = self._control.bg.rectTransform.rect.width / 2 > self._map_start_point.node_image.rectTransform.anchoredPosition.x and var_0_26(320, 0) or var_0_26(-320, 0)

				self._control.bg_r.rectTransform.anchoredPosition = nil or var_12_11
				self._control.bg.map_path.rectTransform.anchoredPosition = nil or var_12_11
				self._control.bg.ship_layer.rectTransform.anchoredPosition = nil or var_12_11
			end
		elseif self._fight_type == var_0_4.fight_type.ninth_attack then
			local var_12_12 = var_0_3:get_ninth_active_common_num()
			local var_12_13 = var_0_3:get_is_ninth_boss()

			if var_12_12 and next(var_12_12) and var_12_13 then
				local var_12_14

				var_12_14, var_12_9 = var_0_3:get_ninth_fight_cam(self._map_id)

				if var_12_12.stage == 1 then
					if var_12_13 then
						self._control.bg_r.rectTransform.anchoredPosition = var_0_26(320, -120)
						self._control.bg.map_path.rectTransform.anchoredPosition = var_0_26(0, 0)
					end
				elseif var_12_12.stage == 2 then
					if var_12_13 then
						self._control.bg_r.rectTransform.anchoredPosition = var_0_26(320, -120 + 240)
						self._control.bg.map_path.rectTransform.anchoredPosition = var_0_26(0, 240)
						self._control.bg.ship_layer.rectTransform.anchoredPosition = var_0_26(0, 240)
					end
				elseif var_12_12.stage == 3 then
					if var_12_13 then
						self._control.bg_r.rectTransform.anchoredPosition = var_0_26(320 - 640, -120 + 160)
						self._control.bg.map_path.rectTransform.anchoredPosition = var_0_26(-640, 160)
						self._control.bg.ship_layer.rectTransform.anchoredPosition = var_0_26(-640, 160)
					end
				elseif var_12_12.stage == 4 and var_12_13 then
					self._control.bg_r.rectTransform.anchoredPosition = var_0_26(320 - 520, -120)
					self._control.bg.map_path.rectTransform.anchoredPosition = var_0_26(-520, 0)
					self._control.bg.ship_layer.rectTransform.anchoredPosition = var_0_26(-520, 0)
				end
			end
		end

		self._control.bg.ship_layer.ship_icon.rectTransform.anchoredPosition = var_12_8 or var_12_9 or var_12_6.node_image.rectTransform.anchoredPosition

		local var_12_18

		if var_12_3.next_node and next(var_12_3.next_node) and self.now_node_list[var_12_3.next_node[1]].node_image then
			var_12_18 = self.now_node_list[var_12_3.next_node[1]].node_image.rectTransform.anchoredPosition
		end

		if var_12_18 then
			self._control.bg.ship_layer.ship_icon.transform.localRotation = var_12_18.x >= var_12_6.node_image.rectTransform.anchoredPosition.x and var_0_27(0, 0, 0) or var_0_27(0, 180, 0)
		end

		self._show_continue_tip = arg_12_1.show_continue_tip

		if arg_12_1.show_continue_tip then
			if not self._show_return_home then
				if self._fight_type == var_0_4.fight_type.abyss_model_first_phase and var_0_3:get_battle_result().grade <= 4 then
					self._control.abyss_msgbox.gameObject:SetActive(true)
					self:__set_select_info()
				else
					self:toggle_continue_tip_box(true)
				end
			else
				self:set_return_home_layer(true)
			end

			return
		end

		self._control.bg.info_bg.round_about_lock_enemy_txt:SetActive(false)
		self:__show_fight_info(self._start_node_id)

		self._already_init = true
		self._control.bg.info_bg.enemy_info_bg.circuity_btn.button.interactable = true
	end

	function arg_1_0:__init_effects()
		local function var_13_0(arg_14_0, arg_14_1)
			arg_14_0.skeletonDataAsset = self:loadSkeletonDataAsset(self:convertToJP(var_0_23(var_0_4.effect_path, arg_14_1, arg_14_1), "effect"))
			arg_14_0.material = self:loadMaterial(self:convertToJP(var_0_23(var_0_4.effect_material, arg_14_1, arg_14_1), "effect"))
			arg_14_0.initialSkinName = "default"

			arg_14_0:Initialize(true)
		end

		var_13_0(self._control.bg.info_bg.encounter_bg.encounter_spine.skeletonGraphic, "encounter_new")
		var_13_0(self._control.bg.info_bg.lock_enemy_bg.lock_enemy_spine.skeletonGraphic, "lock_the_enemy")

		self._control.bg.info_bg.lock_enemy_bg.canvasGroup.alpha = 0
	end

	function arg_1_0:__set_bvr_btn(arg_15_1, arg_15_2)
		if not arg_15_1 and not arg_15_2 then
			return false
		end

		local var_15_0 = 0
		local var_15_1 = 0
		local var_15_2 = 0

		if arg_15_1 then
			if self._fight_type ~= var_0_4.fight_type.exercise then
				for iter_15_0, iter_15_1 in pairs(arg_15_1) do
					if iter_15_1.data.type == 30 or iter_15_1.data.type == 13 then
						local var_15_4 = var_0_3:find_character_by_id(iter_15_1.data.id)

						var_15_1 = var_15_1 + 1

						if var_15_4 and var_15_4.now_hp / var_15_4.hp < 0.25 then
							var_15_0 = var_15_0 + 1
						end

						for iter_15_2, iter_15_3 in pairs(var_15_4.equips) do
							local var_15_5 = gameconfig.equip_config.find_object_by_cid(iter_15_3.id)

							if iter_15_3.carry_type == 3 and iter_15_3.num >= 2 and var_15_5 then
								if var_15_5.bore_type == 41 then
									var_15_3 = true

									break
								end

								if iter_15_1.data.type == 13 then
									var_15_3 = true
								end
							end
						end

						for iter_15_4, iter_15_5 in pairs(var_15_4.equips) do
							local var_15_6 = gameconfig.equip_config.find_object_by_cid(iter_15_5.id)

							if var_15_6 and var_15_6.type == 32 then
								break
							end
						end

						if false and false then
							var_15_2 = var_15_2 + 1
						end
					end
				end
			end

			if var_15_1 == var_15_0 then
				return false
			end

			if var_15_2 > 0 then
				return true
			end
		elseif not arg_15_1 and arg_15_2 then
			for iter_15_6, iter_15_7 in pairs(arg_15_2.members) do
				local var_15_8 = false
				local var_15_9 = false
				local var_15_10 = var_0_3:find_character_by_id(iter_15_7)

				if var_15_10.type == 30 or var_15_10.type == 13 then
					var_15_1 = var_15_1 + 1

					if var_15_10.now_hp / var_15_10.hp < 0.25 then
						var_15_0 = var_15_0 + 1
					end

					for iter_15_8, iter_15_9 in pairs(var_15_10.equips) do
						local var_15_11 = gameconfig.equip_config.find_object_by_cid(iter_15_9.id)

						if var_15_11 and var_15_11.type == 32 then
							var_15_8 = true

							break
						end
					end

					for iter_15_10, iter_15_11 in pairs(var_15_10.equips) do
						local var_15_12 = gameconfig.equip_config.find_object_by_cid(iter_15_11.id)

						if iter_15_11.carry_type == 3 and iter_15_11.num >= 2 and var_15_12 then
							if var_15_12.bore_type == 41 then
								var_15_9 = true

								break
							end

							if var_15_10.type == 13 then
								var_15_9 = true
							end
						end
					end

					if var_15_9 and var_15_8 then
						var_15_2 = var_15_2 + 1
					end
				end
			end

			if var_15_1 == var_15_0 then
				return false
			end

			if var_15_2 > 0 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__init_continue_box()
		if self._fight_type == var_0_4.fight_type.event_story then
			self._control.mask.frame.ui_combatcontinuetip.text.text = var_0_1:getNowLang("ui_combatcontinuetip")
			self._control.mask.frame.bullet.bullet.text.text = var_0_1:getNowLang("ammo")
			self._control.mask.frame.oil.oil.text.text = var_0_1:getNowLang("fuel")

			gamecore.util_func.setTextHorizonInfo(self._control.mask.frame.continue.pvecontinue_mask, var_0_1:getNowLang("pvecontinue"))

			self._control.mask.frame.quit.pvequit.text.text = var_0_1:getNowLang("pvequit")

			return
		end

		self:set_damagecontrol_num()

		self._control.mask.frame.ui_combatcontinuetip.text.text = var_0_1:getNowLang("ui_combatcontinuetip")
		self._control.mask.frame.bullet.bullet.text.text = var_0_1:getNowLang("ammo")
		self._control.mask.frame.oil.oil.text.text = var_0_1:getNowLang("fuel")

		gamecore.util_func.setTextHorizonInfo(self._control.mask.frame.continue.pvecontinue_mask, var_0_1:getNowLang("pvecontinue"))

		self._control.mask.frame.quit.pvequit.text.text = var_0_1:getNowLang("pvequit")

		if not self._team_detail_data then
			return
		end

		local var_16_0
		local var_16_2 = var_0_3:get_battle_info().team

		if self._fight_type == var_0_4.fight_type.campaign then
			var_16_0 = var_0_3:get_campaign_data(self._map_id).info
		elseif self._fight_type == var_0_4.fight_type.event_story then
			var_16_0 = var_0_12.find_object_by_id(self._team_detail_data)
		elseif self._fight_type == var_0_4.fight_type.war_concerto_play then
			var_16_0 = var_0_12.find_object_by_id(self._team_detail_data)
		elseif self._fight_type == var_0_4.fight_type.ocean_attack then
			var_16_0 = {
				members = {}
			}
			var_16_0.members = var_0_3:get_ocean_team_data()
		elseif self._fight_type == var_0_4.fight_type.abyss_model_first_phase then
			var_16_0 = {}
			var_16_0.members = self.is_abyss_team and var_0_3:get_abyss_team_info() or var_0_3:get_normal_team_info()
		else
			var_16_0 = self._fight_type == var_0_4.fight_type.score_attack and var_0_3:get_team_group(var_0_4.team_type.normal)[var_16_2] or var_0_3:get_team_group(var_0_4.team_type.normal)[var_16_2]
		end

		if var_16_0 and next(var_16_0) then
			for iter_16_0, iter_16_1 in ipairs(var_16_0.members) do
				self._team_detail_data[iter_16_0].data.id = iter_16_1
			end
		end

		local var_16_3 = 0
		local var_16_4 = 0
		local var_16_5 = 0
		local var_16_6 = 0
		local var_16_7 = false
		local var_16_8 = false
		local var_16_9 = {}
		local var_16_10 = {}

		if self._fight_type == var_0_4.fight_type.war_concerto_play then
			self._control.mask.frame.ui_tip_mid.text.text = var_0_1:getNowLang("ui_continue_to_next")

			return
		elseif self._fight_type == var_0_4.fight_type.abyss_model_first_phase and self.is_abyss_team then
			for iter_16_2, iter_16_3 in ipairs(var_0_3:get_abyss_team_info() or {}) do
				local var_16_11 = var_0_3:find_abyss_character_by_id(iter_16_3)

				if var_16_11 and var_16_11.now_hp / var_16_11.hp < 0.25 then
					if iter_16_2 == 1 then
						self._people_icon_id = var_16_11.id
						self._show_return_home = true
						self._fighting_status = var_0_4.fighting_status.is_big_poor
					else
						var_16_7 = true
					end
				end
			end

			self._control.mask.frame.danger_layer:SetActive(false)

			return
		else
			for iter_16_4, iter_16_5 in pairs(var_16_0.members) do
				local var_16_12 = var_0_3:find_character_by_id(iter_16_5)
				local var_16_13 = var_16_12 and var_0_34.little_clone(var_16_12) or {}

				var_16_13.hp = var_0_34:get_ship_attr(var_16_13, (var_0_8.find_object_by_cid(var_16_13.cid))).hp

				if var_16_13 then
					var_0_32(var_16_9, var_16_13.now_bullet / var_16_13.bullet)
					var_0_32(var_16_10, var_16_13.now_oil / var_16_13.oil)

					var_16_3 = var_16_3 + var_16_13.bullet
					var_16_4 = var_16_4 + var_16_13.oil
					var_16_5 = var_16_5 + var_16_13.now_bullet
					var_16_6 = var_16_6 + var_16_13.now_oil

					if var_16_13.now_oil <= 0 then
						self._show_return_home = true
						var_16_8 = true
						self._fighting_status = var_0_4.fighting_status.oil_none
					end

					if var_16_13.now_hp / var_16_13.hp < 0.25 then
						if iter_16_4 == 1 then
							self._people_icon_id = var_16_13.id
							self._show_return_home = true
							self._fighting_status = var_0_4.fighting_status.is_big_poor
						else
							var_16_7 = true
						end
					end
				end
			end
		end

		if var_16_8 then
			self._people_icon_id = var_16_0.members[1]
		end

		local var_16_14 = self:__get_config_min_num(var_16_9)
		local var_16_15 = self:__get_config_min_num(var_16_10)
		local var_16_16 = var_0_4:get_supply_img((var_16_5 * 10 / var_16_3 > 10 and 10 or var_16_5 * 10 / var_16_3) / 10, "bullet")
		local var_16_17 = var_0_4:get_supply_img((var_16_6 * 10 / var_16_4 > 10 and 10 or var_16_6 * 10 / var_16_4) / 10, "oil")
		local var_16_18 = math.floor(var_16_14 * 10) > 10 and 10 or math.floor(var_16_14 * 10)

		for iter_16_6 = 1, var_16_18 do
			if self._control.mask.frame.bullet["bullet_" .. iter_16_6] then
				self._control.mask.frame.bullet["bullet_" .. iter_16_6].image.sprite = self:loadSprite(var_16_16)
			end
		end

		for iter_16_7 = var_16_18 + 1, 10 do
			if self._control.mask.frame.bullet["bullet_" .. iter_16_7] then
				self._control.mask.frame.bullet["bullet_" .. iter_16_7].image.sprite = self:loadSprite(var_0_4.supply_rule.bullet_path)
			end
		end

		local var_16_19 = math.floor(var_16_15 * 10) > 10 and 10 or math.floor(var_16_15 * 10)

		for iter_16_8 = 1, var_16_19 do
			if self._control.mask.frame.oil["oil_" .. iter_16_8] then
				self._control.mask.frame.oil["oil_" .. iter_16_8].image.sprite = self:loadSprite(var_16_17)
			end
		end

		for iter_16_9 = var_16_19 + 1, 10 do
			if self._control.mask.frame.oil["oil_" .. iter_16_9] then
				self._control.mask.frame.oil["oil_" .. iter_16_9].image.sprite = self:loadSprite(var_0_4.supply_rule.path)
			end
		end

		self._control.mask.frame.danger_layer.infotext.text.text = var_0_1:getNowLang("ui_combatpreparetip1")

		self._control.mask.frame.danger_layer:SetActive(var_16_7)

		self._control.mask.frame.bullet.percent.text.text = string.format("%.1f%%", var_16_14 * 100)
		self._control.mask.frame.oil.percent.text.text = string.format("%.1f%%", var_16_15 * 100)
	end

	function arg_1_0:__init_team_detail_data(arg_17_1)
		if not arg_17_1 then
			return
		end

		local var_17_0 = var_0_3:get_battle_info()

		self._team_detail_data = {}

		for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
			local var_17_1 = var_0_3:find_character_by_id(iter_17_1)
			local var_17_2

			if self._fight_type == var_0_4.fight_type.abyss_model_first_phase and self.is_abyss_team then
				var_17_1 = var_0_3:find_abyss_character_by_id(iter_17_1)
				var_17_2 = {
					data = var_0_34.little_clone(var_17_1)
				}
			end

			var_17_2.config = var_0_34.little_clone((var_0_8.find_object_by_cid(var_17_1.cid)))
			self._team_detail_data[#self._team_detail_data + 1] = var_17_2
		end
	end

	function arg_1_0:__reset_panel()
		if not self._control.bg.map_mask:Equals(nil) then
			self._control.bg.map_mask.image.enabled = true
		end

		self._control.bg.info_bg.condition_bg.canvasGroup.alpha = 0
		self._control.bg.info_bg.mask.canvasGroup.alpha = 0
		self._control.bg.info_bg.random_bg.canvasGroup.alpha = 0
		self._control.bg.ship_layer.encounter_effect.canvasGroup.alpha = 0

		self._control.mask.frame.ui_combatcontinuetip:SetActive(true)
		self._control.mask.frame.bullet:SetActive(true)
		self._control.mask.frame.oil:SetActive(true)
		self._control.mask.frame.damagecontrol:SetActive(true)
		self._control.mask.frame.buy:SetActive(true)
		self._control.mask.frame.ui_tip_mid:SetActive(false)
		self._control.mask.frame.abyss_power:SetActive(false)
		self:__toggle_encounter(false)
		self:__toggle_lock_enemy(false)
		self:__toggle_enemy_info(false)
		self:__toggle_lost_enemy(false)
		self:__toggle_select_formation(false)

		self._need_condition = false
		self._has_random = false
		self._has_condition = false
		self._has_miss = false
		self._has_hide = false
		self._has_hide_2 = false
		self._has_garrison_open = false
		self._has_garrison_close = false
		self._choices_data = {}
		self._miss_node_data = {}
		self._hide_node_data = {}
		self._garrison_open_node_data = {}
		self._garrison_close_node_data = {}

		self:destroyChildren("fight_info_condition")
		self:destroyChildren("fight_info_random")
		self:destroyChildren("fight_info_item")

		self._random_prob = nil
		self._random = nil
	end

	function arg_1_0:__show_fight_info(arg_19_1)
		self:__reset_panel()
		self:__parse_team_detail_data()

		local var_19_0, var_19_1 = self:__get_start_next_node(arg_19_1 or self._map_node_data[1].id)

		if not var_19_0 or not var_19_1 then
			self:back_to_gotofight()

			return
		end

		if self._fight_type == var_0_4.fight_type.ocean_attack and next(var_19_0.route_award) then
			self._control.mask:SetActive(true)
			self._control.mask.frame:SetActive(false)

			local var_19_2 = var_0_2:createInstance("ocean_box_unselected")

			var_19_2._panel.transform:SetParent(self._control.mask.rectTransform, false)
			var_19_2:show(var_19_0.id, var_19_0.start_node_id)

			return
		end

		if self._fight_type == var_0_4.fight_type.abyss_model_first_phase then
			local var_19_3 = var_0_3:gm_abyss_get_jump_node()

			if var_19_3 then
				var_19_1 = self:__get_node_by_id(var_19_3)

				if var_19_1 then
					self:__play_ship_move(var_19_0, var_19_1)
				end

				return
			end
		end

		if not self._need_condition and not self._has_random then
			self:__play_ship_move(var_19_0, var_19_1)
		elseif self._need_condition then
			if self._has_miss then
				self:__play_miss(var_19_0, var_19_1)
			elseif self._has_hide then
				self:__play_hide(var_19_0, var_19_1)
			elseif self._has_hide_2 then
				self:__play_hide_2(var_19_0, var_19_1)
			elseif self._has_garrison_open then
				self:__play_garrison_node_open(var_19_0, var_19_1)
			elseif self._has_garrison_close then
				self:__play_garrison_node_close(var_19_0, var_19_1)
			elseif self._has_condition then
				self:__play_condition(var_19_0, var_19_1)
			end
		else
			self:__play_random(var_19_0, var_19_1)
		end
	end

	function arg_1_0:__route_condition_ui_cleanup()
		self:destroyChildren("fight_info_condition")

		self._control.bg.info_bg.condition_bg.canvasGroup.alpha = 0
	end

	function arg_1_0:__continue_route_after_miss(arg_21_1, arg_21_2)
		if self._has_hide then
			self:__play_hide(arg_21_1, arg_21_2)
		elseif self._has_hide_2 then
			self:__play_hide_2(arg_21_1, arg_21_2)
		elseif self._has_garrison_open then
			self:__play_garrison_node_open(arg_21_1, arg_21_2)
		elseif self._has_garrison_close then
			self:__play_garrison_node_close(arg_21_1, arg_21_2)
		elseif self._has_condition then
			self:__play_condition(arg_21_1, arg_21_2)
		elseif not self._has_random then
			self._control.bg.map_mask.image.enabled = false
			self._control.bg.info_bg.mask.canvasGroup.alpha = 0

			self:__play_ship_move(arg_21_1, arg_21_2)
		else
			self:__play_random(arg_21_1, arg_21_2)
		end
	end

	function arg_1_0:__continue_route_after_hide(arg_22_1, arg_22_2)
		if self._has_hide_2 then
			self:__play_hide_2(arg_22_1, arg_22_2)
		else
			self:__continue_route_after_hide_2(arg_22_1, arg_22_2)
		end
	end

	function arg_1_0:__continue_route_after_hide_2(arg_23_1, arg_23_2)
		if self._has_garrison_open then
			self:__play_garrison_node_open(arg_23_1, arg_23_2)
		else
			self:__continue_route_after_garrison_node_open(arg_23_1, arg_23_2)
		end
	end

	function arg_1_0:__continue_route_after_garrison_node_open(arg_24_1, arg_24_2)
		if self._has_garrison_close then
			self:__play_garrison_node_close(arg_24_1, arg_24_2)
		else
			self:__continue_route_after_garrison_node_close(arg_24_1, arg_24_2)
		end
	end

	function arg_1_0:__continue_route_after_garrison_node_close(arg_25_1, arg_25_2)
		if self._has_condition then
			self:__play_condition(arg_25_1, arg_25_2)
		elseif not self._has_random then
			self._control.bg.map_mask.image.enabled = false
			self._control.bg.info_bg.mask.canvasGroup.alpha = 0

			self:__play_ship_move(arg_25_1, arg_25_2)
		else
			self:__play_random(arg_25_1, arg_25_2)
		end
	end

	function arg_1_0:__play_miss(arg_26_1, arg_26_2)
		self:__play_condition_animation(self._miss_node_data, function(arg_27_0)
			self:__route_condition_ui_cleanup()
			self:__continue_route_after_miss(arg_26_1, arg_26_2)
		end)
	end

	function arg_1_0:__play_hide(arg_28_1, arg_28_2)
		self:__play_condition_animation(self._hide_node_data, function(arg_29_0)
			self:__route_condition_ui_cleanup()
			self:__continue_route_after_hide(arg_28_1, arg_28_2)
		end)
	end

	function arg_1_0:__play_hide_2(arg_30_1, arg_30_2)
		self:__play_condition_animation(self._hide_node_data_2, function(arg_31_0)
			self:__route_condition_ui_cleanup()
			self:__continue_route_after_hide_2(arg_30_1, arg_30_2)
		end)
	end

	function arg_1_0:__play_garrison_node_open(arg_32_1, arg_32_2)
		self:__play_condition_animation(self._garrison_open_node_data, function(arg_33_0)
			self:__route_condition_ui_cleanup()
			self:__continue_route_after_garrison_node_open(arg_32_1, arg_32_2)
		end)
	end

	function arg_1_0:__play_garrison_node_close(arg_34_1, arg_34_2)
		self:__play_condition_animation(self._garrison_close_node_data, function(arg_35_0)
			self:__route_condition_ui_cleanup()
			self:__continue_route_after_garrison_node_close(arg_34_1, arg_34_2)
		end)
	end

	function arg_1_0.__play_condition(arg_36_0, arg_36_1, arg_36_2)
		local var_36_0 = {}

		for iter_36_0, iter_36_1 in pairs((var_0_3:get_player_story_unlock_data())) do
			var_0_32(var_36_0, iter_36_0, iter_36_1.id)
		end

		;(function()
			arg_36_0:__play_condition_animation(arg_36_0._choices_data, function(arg_38_0)
				arg_36_0._control.bg.info_bg.condition_bg.canvasGroup.alpha = 0

				if arg_38_0 then
					arg_36_0._control.bg.map_mask.image.enabled = false
					arg_36_0._control.bg.info_bg.mask.canvasGroup.alpha = 0

					arg_36_0:__play_ship_move(arg_36_1, arg_36_2)
				else
					arg_36_0:__play_random(arg_36_1, arg_36_2)
				end
			end)
		end)()
	end

	function arg_1_0:__play_condition_animation(arg_39_1, arg_39_2)
		self._condition_control_list = {}

		for iter_39_0, iter_39_1 in pairs(arg_39_1) do
			if iter_39_1.condition_need_ok_num > 0 then
				local var_39_0, var_39_1 = self:loadUIPrefab("fight_info_condition", self._control.bg.info_bg.condition_bg.rectTransform)

				var_39_0:setVisible(true)

				if self._fight_type ~= var_0_4.fight_type.score_attack or self._fight_type ~= var_0_4.fight_type.ninth_attack then
					var_39_1.bg.top_bg.node_title.text.text = self:__get_node_by_id(iter_39_1.choice_node_id).flag
				end

				var_39_1.bg.condition_bg.title_txt.text.text = var_0_23(var_0_1:getNowLang("ui_combatconditiontip", true), iter_39_1.condition_need_ok_num)

				for iter_39_2 = 1, 5 do
					var_39_1.bg.condition_bg.condition_list[var_0_23("condition%d", iter_39_2)].gameObject:SetActive(false)
				end

				for iter_39_3, iter_39_4 in ipairs(iter_39_1.condition_arr) do
					var_39_1.bg.condition_bg.condition_list[var_0_23("condition%d", iter_39_3)].gameObject:SetActive(true)

					var_39_1.bg.condition_bg.condition_list[var_0_23("condition%d", iter_39_3)].check_img.image.sprite = self:loadSprite("data/ui/login/empty.png")

					if iter_39_4.type == var_0_4.map_next_node_condition_type.node_not_pass or iter_39_4.type == var_0_4.map_next_node_condition_type.hide_pass then
						var_39_1.bg.condition_bg.condition_list[var_0_23("condition%d", iter_39_3)].text.color = var_0_28.New(1, 1, 1)
						var_39_1.bg.condition_bg.condition_list[var_0_23("condition%d", iter_39_3)].text.text.text = self:__get_condition_text_for_hide(iter_39_4)
					elseif iter_39_4.type == var_0_4.map_next_node_condition_type.hide_pass_2 then
						var_39_1.bg.condition_bg.condition_list[var_0_23("condition%d", iter_39_3)].text.text.text = self:__get_condition_text_for_hide_2(iter_39_4)
					elseif iter_39_4.type == var_0_4.map_next_node_condition_type.garrison_open then
						var_39_1.bg.condition_bg.condition_list[var_0_23("condition%d", iter_39_3)].text.color = var_0_28.New(1, 1, 1)
						var_39_1.bg.condition_bg.condition_list[var_0_23("condition%d", iter_39_3)].text.text.text = self:__get_condition_text_for_garrison_node_open(iter_39_4)
					elseif iter_39_4.type == var_0_4.map_next_node_condition_type.garrison_close then
						var_39_1.bg.condition_bg.condition_list[var_0_23("condition%d", iter_39_3)].text.color = var_0_28.New(1, 1, 1)
						var_39_1.bg.condition_bg.condition_list[var_0_23("condition%d", iter_39_3)].text.text.text = self:__get_condition_text_for_garrison_node_close(iter_39_4)
					else
						var_39_1.bg.condition_bg.condition_list[var_0_23("condition%d", iter_39_3)].text.text.text = self:__get_condition_text(iter_39_4)
					end
				end

				self._condition_control_list[iter_39_1.choice_node_id] = var_39_1
				var_39_1.bg.condition_bg.title_num.text.text = var_0_23("%d/%d", self:__get_condition_title_ok_num_for_panel(iter_39_1), iter_39_1.condition_need_ok_num)
			end
		end

		local var_39_2 = 0.3
		local var_39_3 = 0

		self._control.bg.info_bg.condition_bg.rectTransform.anchoredPosition = var_0_26(1280, 0)
		self._control.bg.info_bg.condition_bg.canvasGroup.alpha = 1
		self._control.bg.info_bg.mask.canvasGroup.alpha = 1
		self._control.bg.info_bg.condition_bg.rectTransform:DOAnchorPos(var_0_26(0, 0), 0.3):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(0):SetAutoKill(true).onComplete = function()
			local var_40_0 = {}
			local var_40_1 = 1
			local var_40_2 = false

			for iter_40_0, iter_40_1 in pairs(arg_39_1) do
				if iter_40_1.condition_need_ok_num > 0 then
					for iter_40_2, iter_40_3 in ipairs(iter_40_1.condition_arr) do
						var_40_0[#var_40_0 + 1] = {
							execute_time = var_40_1 * 0.8,
							execute_func = function()
								if self._condition_control_list[iter_40_1.choice_node_id] and self._condition_control_list[iter_40_1.choice_node_id].bg and not self._condition_control_list[iter_40_1.choice_node_id].bg:Equals(nil) then
									local var_41_0 = "data/ui/combat/combat_select2.png"

									if (iter_40_3.type == var_0_4.map_next_node_condition_type.garrison_close or nil) and self:__is_map_cid_in_garrison(iter_40_3.map_cid) then
										var_41_0 = "data/ui/combat/combat_select.png"
										self._condition_control_list[iter_40_1.choice_node_id].bg.condition_bg.condition_list[var_0_23("condition%d", iter_40_2)].text.text.color = var_0_28(0.11, 0.55, 0.9)
									end

									self._condition_control_list[iter_40_1.choice_node_id].bg.condition_bg.condition_list[var_0_23("condition%d", iter_40_2)].check_img.image.sprite = self:loadSprite(var_41_0)
								end
							end
						}
						var_40_1 = var_40_1 + 1
					end

					if iter_40_1.is_ok then
						var_40_0[#var_40_0 + 1] = {
							execute_time = var_40_1 * 0.8,
							execute_func = function()
								if self._condition_control_list[iter_40_1.choice_node_id] and self._condition_control_list[iter_40_1.choice_node_id].bg and not self._condition_control_list[iter_40_1.choice_node_id].bg:Equals(nil) then
									self._condition_control_list[iter_40_1.choice_node_id].bg.top_bg.image.sprite = self:loadSprite(var_0_4.combat_select_bg1)
									self._condition_control_list[iter_40_1.choice_node_id].bg.top_bg.node_point.image.sprite = self:loadSprite(var_0_4.campaign_is_ok.combat_select_dot1)
									self._condition_control_list[iter_40_1.choice_node_id].bg.ok_bg.image.sprite = self:loadSprite(var_0_4.campaign_is_ok.combat_frame2_light)
								end
							end
						}
						var_40_1 = var_40_1 + 1
						var_40_2 = true
					else
						self._condition_control_list[iter_40_1.choice_node_id].bg.top_bg.image.sprite = self:loadSprite(var_0_4.combat_select_bg2)
						self._condition_control_list[iter_40_1.choice_node_id].bg.top_bg.node_point.image.sprite = self:loadSprite(var_0_4.campaign_is_ok.combat_select_dot2)
					end
				end
			end

			if var_40_0 and #var_40_0 > 0 then
				var_40_0[#var_40_0 + 1] = {
					execute_time = var_40_1 * 0.8 + 2,
					execute_func = function()
						self._control.bg.info_bg.condition_bg.rectTransform:DOAnchorPos(var_0_26(-1280, 0), var_39_2):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(var_39_3):SetAutoKill(true).onComplete = function()
							arg_39_2(var_40_2)
						end
					end,
					skip_func = function()
						arg_39_2(var_40_2)
					end
				}
			else
				arg_39_2(var_40_2)
			end

			self._time_execute_task_list = var_40_0
		end
	end

	function arg_1_0.__get_condition_text(arg_46_0, arg_46_1)
		return (var_0_24(var_0_1:getNowLang(var_0_23("nodelock%d", arg_46_1.type)), "%b{}", function(arg_47_0)
			local var_47_0 = ""
			local var_47_1 = tonumber(var_0_25(arg_47_0, 2, 2))

			if var_47_1 == 0 then
				var_47_0 = tostring(arg_46_1.num)
			elseif var_47_1 == 1 then
				var_47_0 = var_0_1:getNowLang(var_0_4:get_ship_type_language_key(arg_46_1.shipType, 1))
			elseif var_47_1 == 2 then
				local var_47_2 = var_0_8.find_object_by_cid(var_47_1)

				if var_47_2 then
					var_47_0 = var_47_2.title
				end
			end

			return var_47_0
		end))
	end

	function arg_1_0:__get_condition_text_for_hide(arg_48_1)
		return (var_0_23(var_0_1:getNowLang(var_0_23("nodelock%d", arg_48_1.type)), self:__get_node_by_id(arg_48_1.condition_node).flag, arg_48_1.num))
	end

	function arg_1_0:__get_condition_text_for_hide_2(arg_49_1)
		return (var_0_23(var_0_1:getNowLang(var_0_23("nodelock%d", arg_49_1.type)), self:__get_node_by_id_2(arg_49_1.condition_node).title, arg_49_1.num))
	end

	function arg_1_0.__is_map_cid_in_garrison(arg_50_0, arg_50_1)
		if not arg_50_1 then
			return false
		end

		return (var_0_3:is_point_stationed(tonumber(arg_50_1)))
	end

	function arg_1_0:__get_condition_title_ok_num_for_panel(arg_51_1)
		if arg_51_1 and arg_51_1.condition_arr then
			if (arg_51_1.condition_need_ok_num or 0) <= 0 then
				return (arg_51_1 or nil) and (arg_51_1.condition_ok_num or 0)
			end
		end

		local var_51_1 = 0

		for iter_51_0, iter_51_1 in ipairs(arg_51_1.condition_arr) do
			if iter_51_1.type == var_0_4.map_next_node_condition_type.garrison_close then
				if self:__is_map_cid_in_garrison(iter_51_1.map_cid) then
					var_51_1 = var_51_1 + 1
				end
			elseif iter_51_1.condition_ok then
				var_51_1 = var_51_1 + 1
			end
		end

		return var_51_1
	end

	function arg_1_0:__get_garrison_condition_map_name(arg_52_1)
		local var_52_0

		if self._fight_type == var_0_4.fight_type.score_attack then
			local var_52_1 = self:__get_node_by_id(arg_52_1)

			if not var_52_1 then
				local var_52_2 = var_0_19.get_start_node_id_set_by_id(arg_52_1)

				if var_52_2 then
					for iter_52_0, iter_52_1 in pairs(var_52_2) do
						var_52_1 = var_0_19.find_object_by_id_start_node_id(arg_52_1, iter_52_0)

						if var_52_1 then
							break
						end
					end
				end
			end

			var_52_0 = var_52_1 and var_52_1.flag
		else
			local var_52_3 = var_0_6.find_object_by_id(arg_52_1)

			var_52_0 = var_52_3 and var_52_3.flag
		end

		return var_52_0
	end

	function arg_1_0:__get_condition_text_for_garrison_node_open(arg_53_1)
		return var_0_23(var_0_1:getNowLang("garrison_node_open"), (self:__get_garrison_condition_map_name(arg_53_1.map_cid)))
	end

	function arg_1_0:__get_condition_text_for_garrison_node_close(arg_54_1)
		return var_0_23(var_0_1:getNowLang("garrison_node_close"), (self:__get_garrison_condition_map_name(arg_54_1.map_cid)))
	end

	function arg_1_0:__play_random(arg_55_1, arg_55_2)
		self._random_control_list = {}

		for iter_55_0, iter_55_1 in ipairs(self._choices_data) do
			-- block empty
		end

		for iter_55_2, iter_55_3 in ipairs(self._choices_data) do
			local var_55_0, var_55_1 = self:loadUIPrefab("fight_info_random", self._control.bg.info_bg.random_bg.rectTransform)

			var_55_0:setVisible(true)

			var_55_1.bg.top_bg.node_title.text.text = self:__get_node_by_id(iter_55_3.choice_node_id).flag
			var_55_1.bg.title.text.text = var_0_1:getNowLang("percent")

			for iter_55_4 = 1, 5 do
				var_55_1.bg.star_group[var_0_23("star%d", iter_55_4)].gameObject:SetActive(false)
			end

			local var_55_2 = 0

			if iter_55_3.random_weight > 0 and iter_55_3.random_weight <= 25 then
				var_55_2 = 1
			elseif iter_55_3.random_weight > 25 and iter_55_3.random_weight <= 50 then
				var_55_2 = 2
			elseif iter_55_3.random_weight > 50 then
				var_55_2 = 3
			end

			for iter_55_5 = 1, var_55_2 do
				var_55_1.bg.star_group[var_0_23("star%d", iter_55_5)].gameObject:SetActive(true)
			end

			self._random_control_list[iter_55_3.choice_node_id] = var_55_1
		end

		local var_55_3 = 0.3
		local var_55_4 = 0
		local var_55_5 = 2

		self._control.bg.info_bg.random_bg.rectTransform.anchoredPosition = var_0_26(1280, 0)
		self._control.bg.info_bg.random_bg.canvasGroup.alpha = 1
		self._control.bg.info_bg.mask.canvasGroup.alpha = 1
		self._control.bg.info_bg.random_bg.rectTransform:DOAnchorPos(var_0_26(0, 0), 0.3):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(0):SetAutoKill(true).onComplete = function()
			local var_56_0 = {}
			local var_56_1 = 1

			for iter_56_0, iter_56_1 in ipairs(self._choices_data) do
				if iter_56_1.is_random_ok then
					var_56_0[#var_56_0 + 1] = {
						execute_time = var_56_1 * 0.8,
						execute_func = function()
							self._random_control_list[iter_56_1.choice_node_id].bg.top_bg.node_point.image.sprite = self:loadSprite(var_0_4.campaign_is_ok.combat_select_dot1)
							self._random_control_list[iter_56_1.choice_node_id].bg.ok_bg.image.sprite = self:loadSprite(var_0_4.campaign_is_ok.combat_frame2_light)
							self._random_control_list[iter_56_1.choice_node_id].bg.top_bg.image.sprite = self:loadSprite(var_0_4.combat_select_bg1)
						end
					}
					var_56_1 = var_56_1 + 1

					break
				end
			end

			var_56_0[#var_56_0 + 1] = {
				execute_time = var_56_1 * 0.8 + var_55_5,
				execute_func = function()
					self._control.bg.info_bg.random_bg.rectTransform:DOAnchorPos(var_0_26(-1280, 0), var_55_3):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(var_55_4):SetAutoKill(true).onComplete = function()
						self._control.bg.info_bg.random_bg.canvasGroup.alpha = 0
						self._control.bg.info_bg.mask.canvasGroup.alpha = 0
						self._control.bg.map_mask.image.enabled = false

						self:__play_ship_move(arg_55_1, arg_55_2)
					end
				end,
				skip_func = function()
					self._control.bg.info_bg.random_bg.canvasGroup.alpha = 0
					self._control.bg.info_bg.mask.canvasGroup.alpha = 0
					self._control.bg.map_mask.image.enabled = false

					self:__play_ship_move(arg_55_1, arg_55_2)
				end
			}
			self._time_execute_task_list = var_56_0
		end
	end

	function arg_1_0:__parse_team_detail_data()
		self._condition_need_data = {}
		self._condition_need_data.team_ship_num = 0
		self._condition_need_data.team_total_level = 0
		self._condition_need_data.team_total_radar = 0
		self._condition_need_data.team_total_luck = 0
		self._condition_need_data.ship_type_data = {}
		self._condition_need_data.first_ship_info = {}
		self._condition_need_data.min_speed_in_team = 0
		self._condition_need_data.max_speed_in_team = 0
		self._condition_need_data.team_average_speed = 0
		self._condition_need_data.team_ship_cid_arr = {}
		self._condition_need_data.evolution_ship_num = 0

		if self._fight_type == var_0_4.fight_type.event_story then
			return
		end

		for iter_61_0, iter_61_1 in ipairs(self._team_detail_data or {}) do
			local var_61_0 = var_0_34:get_ship_attr(iter_61_1.data, iter_61_1.config)

			if var_61_0 ~= nil then
				for iter_61_2, iter_61_3 in pairs(var_61_0) do
					if iter_61_1.data[iter_61_2] then
						iter_61_1.data[iter_61_2] = iter_61_3
					end
				end
			end

			self._team_detail_data[iter_61_0].data = iter_61_1.data
		end

		for iter_61_4, iter_61_5 in ipairs(self._team_detail_data or {}) do
			self:__set_buff_data_by_skill(iter_61_5.data, self._team_detail_data)
		end

		if self._fight_type == var_0_4.fight_type.seventh then
			local var_61_2 = var_0_43.find_object_by_id((var_0_3:get_cur_seventh_buff_max_level_id(1003)))

			for iter_61_6, iter_61_7 in ipairs(self._team_detail_data or {}) do
				for iter_61_8, iter_61_9 in ipairs(var_61_2.pre_effect) do
					for iter_61_10, iter_61_11 in ipairs(iter_61_9.shipTon) do
						if iter_61_7.config.ship_ton == iter_61_11 then
							iter_61_7.data[var_0_4.skil_attribute_type[iter_61_9.num4]] = iter_61_7.data[var_0_4.skil_attribute_type[iter_61_9.num4]] + iter_61_9.num
						end
					end
				end
			end
		end

		if self._fight_type == var_0_4.fight_type.eighth_attack then
			local var_61_3 = var_0_44.find_object_by_id((var_0_3:get_cur_eighth_buff_max_level_id(1003)))

			for iter_61_12, iter_61_13 in ipairs(self._team_detail_data or {}) do
				for iter_61_14, iter_61_15 in ipairs(var_61_3.pre_effect) do
					for iter_61_16, iter_61_17 in ipairs(iter_61_15.shipTon) do
						if iter_61_13.config.ship_ton == iter_61_17 then
							iter_61_13.data[var_0_4.skil_attribute_type[iter_61_15.num4]] = iter_61_13.data[var_0_4.skil_attribute_type[iter_61_15.num4]] + iter_61_15.num
						end
					end
				end
			end
		end

		for iter_61_18, iter_61_19 in ipairs(self._team_detail_data or {}) do
			local var_61_4 = iter_61_19.attr or iter_61_19.data

			self._condition_need_data.team_ship_num = self._condition_need_data.team_ship_num + 1
			self._condition_need_data.team_total_level = self._condition_need_data.team_total_level + iter_61_19.data.level
			self._condition_need_data.team_total_radar = self._condition_need_data.team_total_radar + var_61_4.radar
			self._condition_need_data.team_total_luck = self._condition_need_data.team_total_luck + var_61_4.luck

			if self._condition_need_data.ship_type_data[iter_61_19.data.type] == nil then
				self._condition_need_data.ship_type_data[iter_61_19.data.type] = 0
			end

			self._condition_need_data.ship_type_data[iter_61_19.data.type] = self._condition_need_data.ship_type_data[iter_61_19.data.type] + 1

			if iter_61_18 == 1 then
				self._condition_need_data.first_ship_info.level = iter_61_19.data.level
				self._condition_need_data.first_ship_info.type = iter_61_19.data.type
				self._condition_need_data.first_ship_info.speed = var_61_4.speed
				self._condition_need_data.min_speed_in_team = var_61_4.speed
				self._condition_need_data.max_speed_in_team = var_61_4.speed
			end

			if self._condition_need_data.min_speed_in_team > var_61_4.speed then
				self._condition_need_data.min_speed_in_team = var_61_4.speed
			end

			if self._condition_need_data.max_speed_in_team < var_61_4.speed then
				self._condition_need_data.max_speed_in_team = var_61_4.speed
			end

			if self._condition_need_data.team_ship_cid_arr[iter_61_19.data.cid] == nil then
				self._condition_need_data.team_ship_cid_arr[iter_61_19.data.cid] = 1
			end

			if iter_61_19.config.evo_class then
				self._condition_need_data.evolution_ship_num = self._condition_need_data.evolution_ship_num + 1
			end
		end

		local var_61_6 = var_0_3:get_gotofight_team_info()

		self._condition_need_data.team_average_speed = var_61_6 and (var_61_6 / #self._team_detail_data or 0) or 0
	end

	function arg_1_0:__set_buff_data_by_skill(arg_62_1, arg_62_2)
		local var_62_0 = var_0_10.find_object_by_skill_type_skill_level(arg_62_1.now_skill, arg_62_1.skill_level)

		if not var_62_0 then
			return
		end

		if not var_62_0.pre_effect[1] then
			return
		end

		for iter_62_0, iter_62_1 in pairs(var_62_0.pre_effect) do
			local var_62_1 = false

			if iter_62_1.condition then
				for iter_62_2, iter_62_3 in pairs(iter_62_1.condition) do
					if iter_62_3.type == 43 then
						local var_62_2 = true

						for iter_62_4, iter_62_5 in pairs(arg_62_2) do
							if iter_62_5.data.id ~= arg_62_1.id then
								for iter_62_6, iter_62_7 in pairs(iter_62_3.shipTypes) do
									if iter_62_5.data.type == iter_62_7 then
										var_62_2 = false
									end
								end
							end
						end

						var_62_1 = var_62_2
					elseif iter_62_3.type == 26 then
						for iter_62_8, iter_62_9 in pairs(arg_62_2) do
							if iter_62_9.data.id == arg_62_1.id and iter_62_8 == 1 then
								var_62_1 = true
							end
						end
					end
				end
			else
				var_62_1 = true
			end

			if var_62_1 == false then
				return
			end

			for iter_62_10, iter_62_11 in pairs(iter_62_1.target) do
				if iter_62_11.type == 2 then
					local var_62_3 = 0

					for iter_62_12, iter_62_13 in pairs(arg_62_2) do
						if iter_62_13.data.id == arg_62_1.id then
							var_62_3 = iter_62_12
						end
					end

					for iter_62_14, iter_62_15 in pairs(iter_62_11.shipTypes) do
						if arg_62_2[var_62_3 - 1] and arg_62_2[var_62_3 - 1].data.type == iter_62_15 then
							self:__set_buff_data_by_skill_by_effect(arg_62_2[var_62_3 - 1].data, iter_62_1.effect)
						end

						if arg_62_2[var_62_3 + 1] and arg_62_2[var_62_3 + 1].data.type == iter_62_15 then
							self:__set_buff_data_by_skill_by_effect(arg_62_2[var_62_3 + 1].data, iter_62_1.effect)
						end
					end
				elseif iter_62_11.type == 4 then
					local var_62_4 = 0

					for iter_62_16, iter_62_17 in pairs(arg_62_2) do
						if iter_62_17.data.id == arg_62_1.id then
							var_62_4 = iter_62_16
						end
					end

					for iter_62_18, iter_62_19 in pairs(arg_62_2) do
						if iter_62_18 < var_62_4 and iter_62_18 >= var_62_4 - iter_62_11.num then
							self:__set_buff_data_by_skill_by_effect(iter_62_19.data, iter_62_1.effect)
						end
					end
				elseif iter_62_11.type == 8 then
					for iter_62_20, iter_62_21 in pairs(arg_62_2) do
						self:__set_buff_data_by_skill_by_effect(iter_62_21.data, iter_62_1.effect)
					end
				elseif iter_62_11.type == 7 then
					self:__set_buff_data_by_skill_by_effect(arg_62_1, iter_62_1.effect)
				elseif iter_62_11.type == 10 then
					for iter_62_22, iter_62_23 in pairs(arg_62_2) do
						local var_62_5 = var_0_8.find_object_by_cid(iter_62_23.data.cid)

						if var_62_5 then
							for iter_62_24, iter_62_25 in pairs(iter_62_11.country) do
								if var_62_5.country == iter_62_25 then
									self:__set_buff_data_by_skill_by_effect(iter_62_23.data, iter_62_1.effect)
								end
							end
						end
					end
				elseif iter_62_11.type == 11 or iter_62_11.type == 12 then
					for iter_62_26, iter_62_27 in pairs(arg_62_2) do
						local var_62_6 = var_0_8.find_object_by_cid(iter_62_27.data.cid)

						if var_62_6 then
							local var_62_7 = false

							for iter_62_28, iter_62_29 in pairs(iter_62_11.shipTypes or {}) do
								if var_62_6.type == iter_62_29 then
									var_62_7 = true

									break
								end
							end

							if not var_62_7 then
								for iter_62_30, iter_62_31 in pairs(iter_62_11.shipTons or {}) do
									if var_62_6.ship_ton == iter_62_31 then
										var_62_7 = true

										break
									end
								end
							end

							if not var_62_7 then
								for iter_62_32, iter_62_33 in pairs(iter_62_11.guardTypes or {}) do
									if var_62_6.guard_type == iter_62_33 then
										var_62_7 = true

										break
									end
								end
							end

							local var_62_10 = true

							if iter_62_11.type == 12 then
								var_62_10 = false

								for iter_62_34, iter_62_35 in pairs(iter_62_11.country or {}) do
									if var_62_6.country == iter_62_35 then
										var_62_10 = true

										break
									end
								end
							end

							if var_62_7 and var_62_10 then
								self:__set_buff_data_by_skill_by_effect(iter_62_27.data, iter_62_1.effect)
							end
						end
					end
				end
			end
		end
	end

	function arg_1_0.__set_buff_data_by_skill_by_effect(arg_63_0, arg_63_1, arg_63_2)
		for iter_63_0, iter_63_1 in pairs(arg_63_2) do
			if iter_63_1.type == 3 then
				for iter_63_2, iter_63_3 in pairs(iter_63_1) do
					if iter_63_2 ~= "type" then
						arg_63_1[iter_63_2] = arg_63_1[iter_63_2] + iter_63_3
					end
				end
			end
		end
	end

	function arg_1_0:__get_node_limit(arg_64_1, arg_64_2, arg_64_3)
		local var_64_0 = self:__select_hide_node_list()
		local var_64_1 = arg_64_2

		for iter_64_0, iter_64_1 in pairs((self:__select_hide_node_list_2())) do
			local var_64_2 = tonumber(iter_64_1.hide_end_point)

			if arg_64_1 == tonumber(iter_64_1.hide_start_point) and arg_64_2 and arg_64_2 == var_64_2 then
				for iter_64_2, iter_64_3 in pairs(iter_64_1.hide_result) do
					local var_64_3 = self._fight_type == var_0_4.fight_type.seventh and var_0_22.find_object_by_id(tonumber(iter_64_2)) or var_0_6.find_object_by_id(tonumber(iter_64_2))

					if tonumber(iter_64_2) ~= 70405 and var_0_3:is_map_node_pass_b_and_b_up(var_64_3.pve_level_id, var_64_3.id) and iter_64_3 <= var_0_3:get_map_node_pass_count(self._map_id, tonumber(iter_64_2)) then
						if #arg_64_3 == 1 then
							return nil
						else
							for iter_64_4, iter_64_5 in pairs(arg_64_3) do
								if iter_64_5 ~= var_64_2 then
									var_64_1 = self:__get_node_limit(arg_64_1, iter_64_5, arg_64_3)
								end
							end
						end
					end
				end
			end
		end

		return var_64_1
	end

	function arg_1_0:__get_start_next_node(arg_65_1)
		local var_65_0 = self:__get_node_by_id(arg_65_1)

		if not var_65_0 then
			return nil, nil
		end

		local var_65_1 = var_65_0.next_node
		local var_65_2 = -1

		if #var_65_0.next_node == 0 then
			return var_65_0, nil
		else
			var_65_2 = #var_65_1 == 1 and var_65_1[1] or self:__get_next_node_id(var_65_0)
		end

		return var_65_0, (self:__get_node_by_id(var_65_2))
	end

	function arg_1_0:__get_next_node_id(arg_66_1)
		local var_66_0 = -1

		if next(arg_66_1.route_num) then
			self._has_random = true
		end

		if not self._has_random then
			log.errorlog(var_0_23("ship_pve_level_node table route_num config is unreasonable [id = %s]", arg_66_1.id))

			return nil
		end

		for iter_66_0, iter_66_1 in pairs(arg_66_1.route_num) do
			if iter_66_1.num > 0 then
				self._has_condition = true
			end

			self._choices_data[#self._choices_data + 1] = {
				choice_node_id = tonumber(iter_66_0),
				condition_need_ok_num = iter_66_1.num,
				random_weight = iter_66_1.weight
			}
		end

		for iter_66_2, iter_66_3 in pairs(arg_66_1.node_rounter) do
			for iter_66_4, iter_66_5 in ipairs(self._choices_data) do
				if iter_66_5.condition_need_ok_num > 0 and iter_66_5.choice_node_id == tonumber(iter_66_2) then
					iter_66_5.condition_arr = iter_66_3
				end
			end
		end

		local var_66_1 = {}
		local var_66_2 = {}

		if arg_66_1.node_hide and next(arg_66_1.node_hide) then
			self._has_hide = true

			local var_66_3 = false

			for iter_66_6, iter_66_7 in pairs(arg_66_1.node_hide) do
				for iter_66_8, iter_66_9 in pairs(iter_66_7) do
					if self._fight_type == var_0_4.fight_type.seventh then
						if not var_0_3:is_pass_seventh_map_node(self._map_id, iter_66_9) then
							var_0_32(var_66_1, tonumber(iter_66_6))

							var_66_3 = true
						end
					elseif self._fight_type == var_0_4.fight_type.eighth_attack then
						if not var_0_3:is_pass_eighth_map_node(self._map_id, iter_66_9) then
							var_0_32(var_66_1, tonumber(iter_66_6))

							var_66_3 = true
						end
					elseif self._fight_type == var_0_4.fight_type.score_attack then
						if not var_0_3:is_score_map_node_b_and_b_up_pass(arg_66_1.start_node_id, iter_66_9) then
							var_0_32(var_66_1, tonumber(iter_66_6))

							var_66_3 = true
						end
					elseif self._fight_type == var_0_4.fight_type.ninth_attack then
						if not var_0_3:is_ninth_map_node_pass(arg_66_1.start_node_id, iter_66_9) then
							var_0_32(var_66_1, tonumber(iter_66_6))

							var_66_3 = true
						end
					elseif not var_0_3:is_map_node_pass_b_and_b_up(self._map_id, iter_66_9) then
						var_0_32(var_66_1, tonumber(iter_66_6))

						var_66_3 = true
					end
				end
			end

			self._has_hide = var_66_3
		end

		if arg_66_1.node_hide_2 and next(arg_66_1.node_hide_2) then
			self._has_hide_2 = true

			local var_66_4 = false

			for iter_66_10, iter_66_11 in pairs(arg_66_1.node_hide_2) do
				for iter_66_12, iter_66_13 in pairs(iter_66_11) do
					if self._fight_type == var_0_4.fight_type.score_attack then
						table.insert(var_66_2, (var_0_3:score_map_is_pass(iter_66_13) or nil) and 1)

						if var_66_2 and next(var_66_2) and self:_have_data(var_66_2, 0) then
							var_66_4 = true

							table.insert(var_66_1, tonumber(iter_66_10))
						end
					elseif self._fight_type == var_0_4.fight_type.ninth_attack then
						table.insert(var_66_2, (var_0_3:ninth_map_is_pass(iter_66_13) or nil) and 1)

						if var_66_2 and next(var_66_2) and self:_have_data(var_66_2, 0) then
							var_66_4 = true

							table.insert(var_66_1, tonumber(iter_66_10))
						end
					end
				end
			end

			self._has_hide_2 = var_66_4
		end

		if arg_66_1.garrison_node_open and next(arg_66_1.garrison_node_open) then
			self._has_garrison_open = true

			for iter_66_14, iter_66_15 in pairs(arg_66_1.garrison_node_open) do
				local var_66_7 = true

				for iter_66_16, iter_66_17 in pairs(iter_66_15) do
					if not self:__is_map_cid_in_garrison(tonumber(iter_66_17)) then
						var_66_7 = false

						break
					end
				end

				if not var_66_7 then
					var_0_32(var_66_1, tonumber(iter_66_14))
				end
			end
		end

		if arg_66_1.garrison_node_close and next(arg_66_1.garrison_node_close) then
			self._has_garrison_close = true

			for iter_66_18, iter_66_19 in pairs(arg_66_1.garrison_node_close) do
				local var_66_8 = false

				for iter_66_20, iter_66_21 in pairs(iter_66_19) do
					if self:__is_map_cid_in_garrison(tonumber(iter_66_21)) then
						var_66_8 = true

						break
					end
				end

				if var_66_8 then
					var_0_32(var_66_1, tonumber(iter_66_18))
				end
			end
		end

		if arg_66_1.node_miss and next(arg_66_1.node_miss) then
			self._has_miss = true

			local var_66_9 = true

			for iter_66_22, iter_66_23 in pairs(arg_66_1.node_miss) do
				for iter_66_24, iter_66_25 in pairs(iter_66_23) do
					local var_66_10 = self._fight_type == var_0_4.fight_type.seventh and var_0_3:get_seven_map_node_pass_count(self._map_id, tonumber(iter_66_24)) or self._fight_type == var_0_4.fight_type.eighth_attack and var_0_3:get_eighth_map_node_pass_count(self._map_id, tonumber(iter_66_24)) or self._fight_type == var_0_4.fight_type.score_attack and var_0_3:get_score_map_node_pass_count(arg_66_1.start_node_id, tonumber(iter_66_24)) or self._fight_type == var_0_4.fight_type.ninth_attack and var_0_3:get_ninth_map_node_pass_count(arg_66_1.start_node_id, tonumber(iter_66_24)) or var_0_3:get_map_node_pass_count(self._map_id, tonumber(iter_66_24))

					if tonumber(iter_66_24) ~= 70405 then
						if var_66_10 and iter_66_25 <= var_66_10 then
							var_0_32(var_66_1, tonumber(iter_66_22))

							var_66_9 = false
						else
							var_66_9 = true

							break
						end
					elseif self._contain_miss then
						var_0_32(var_66_1, tonumber(iter_66_22))

						var_66_9 = false
					else
						var_66_9 = true

						break
					end
				end
			end

			self._has_miss = var_66_9
		end

		self._hide_node_data = {}
		self._miss_node_data = {}
		self._hide_node_data_2 = {}
		self._garrison_open_node_data = {}
		self._garrison_close_node_data = {}

		if self._has_hide then
			for iter_66_26, iter_66_27 in pairs(self._choices_data) do
				for iter_66_28, iter_66_29 in pairs(arg_66_1.node_hide) do
					if tonumber(iter_66_28) == iter_66_27.choice_node_id then
						local var_66_11 = lx.clone_table(iter_66_27)

						var_66_11.condition_arr = {}
						var_66_11.condition_need_ok_num = 0

						for iter_66_30, iter_66_31 in pairs(iter_66_29) do
							var_0_32(var_66_11.condition_arr, {
								fake_condition = true,
								go = 2,
								weight = 50,
								type = var_0_4.map_next_node_condition_type.hide_pass,
								condition_node = tonumber(iter_66_31)
							})
						end

						var_66_11.condition_need_ok_num = var_66_11.condition_need_ok_num + #iter_66_29

						var_0_32(self._hide_node_data, var_66_11)
					end
				end
			end
		end

		if self._has_hide_2 then
			for iter_66_32, iter_66_33 in pairs(self._choices_data) do
				for iter_66_34, iter_66_35 in pairs(arg_66_1.node_hide_2) do
					if tonumber(iter_66_34) == iter_66_33.choice_node_id then
						local var_66_12 = lx.clone_table(iter_66_33)

						var_66_12.condition_arr = {}
						var_66_12.condition_need_ok_num = 0

						for iter_66_36, iter_66_37 in pairs(iter_66_35) do
							var_0_32(var_66_12.condition_arr, {
								fake_condition = true,
								go = 2,
								weight = 50,
								type = var_0_4.map_next_node_condition_type.hide_pass_2,
								condition_node = tonumber(iter_66_37)
							})
						end

						var_66_12.condition_need_ok_num = var_66_12.condition_need_ok_num + #iter_66_35

						var_0_32(self._hide_node_data_2, var_66_12)
					end
				end
			end
		end

		if self._has_miss then
			for iter_66_38, iter_66_39 in pairs(self._choices_data) do
				for iter_66_40, iter_66_41 in pairs(arg_66_1.node_miss) do
					if iter_66_39.choice_node_id == tonumber(iter_66_40) then
						local var_66_13 = lx.clone_table(iter_66_39)

						var_66_13.condition_arr = {}
						var_66_13.condition_need_ok_num = 0

						for iter_66_42, iter_66_43 in pairs(iter_66_41) do
							var_66_13.condition_need_ok_num = var_66_13.condition_need_ok_num + 1

							var_0_32(var_66_13.condition_arr, {
								fake_condition = true,
								go = 2,
								weight = 50,
								type = var_0_4.map_next_node_condition_type.node_not_pass,
								num = tonumber(iter_66_43),
								condition_node = tonumber(iter_66_42)
							})
						end

						var_0_32(self._miss_node_data, var_66_13)
					end
				end
			end
		end

		if arg_66_1.garrison_node_open and next(arg_66_1.garrison_node_open) then
			for iter_66_44, iter_66_45 in pairs(self._choices_data) do
				for iter_66_46, iter_66_47 in pairs(arg_66_1.garrison_node_open) do
					if tonumber(iter_66_46) == iter_66_45.choice_node_id then
						local var_66_14 = lx.clone_table(iter_66_45)

						var_66_14.condition_arr = {}
						var_66_14.condition_need_ok_num = 0

						for iter_66_48, iter_66_49 in pairs(iter_66_47) do
							var_0_32(var_66_14.condition_arr, {
								fake_condition = true,
								go = 2,
								weight = 50,
								type = var_0_4.map_next_node_condition_type.garrison_open,
								map_cid = tonumber(iter_66_49)
							})
						end

						var_66_14.condition_need_ok_num = #var_66_14.condition_arr

						var_0_32(self._garrison_open_node_data, var_66_14)
					end
				end
			end
		end

		if arg_66_1.garrison_node_close and next(arg_66_1.garrison_node_close) then
			for iter_66_50, iter_66_51 in pairs(self._choices_data) do
				for iter_66_52, iter_66_53 in pairs(arg_66_1.garrison_node_close) do
					if tonumber(iter_66_52) == iter_66_51.choice_node_id then
						local var_66_15 = lx.clone_table(iter_66_51)

						var_66_15.condition_arr = {}
						var_66_15.condition_need_ok_num = 0

						for iter_66_54, iter_66_55 in pairs(iter_66_53) do
							var_0_32(var_66_15.condition_arr, {
								fake_condition = true,
								go = 2,
								weight = 50,
								type = var_0_4.map_next_node_condition_type.garrison_close,
								map_cid = tonumber(iter_66_55)
							})
						end

						var_66_15.condition_need_ok_num = #var_66_15.condition_arr

						var_0_32(self._garrison_close_node_data, var_66_15)
					end
				end
			end
		end

		for iter_66_56, iter_66_57 in pairs(var_66_1) do
			for iter_66_58 = #self._choices_data, 1, -1 do
				if iter_66_57 == self._choices_data[iter_66_58].choice_node_id then
					table.remove(self._choices_data, iter_66_58)

					break
				end
			end
		end

		for iter_66_59, iter_66_60 in pairs(var_0_3:get_fifth_hide_node()) do
			for iter_66_61 = #self._choices_data, 1, -1 do
				if iter_66_59 == self._choices_data[iter_66_61].choice_node_id then
					table.remove(self._choices_data, iter_66_61)

					break
				end
			end
		end

		table.sort(self._choices_data, function(arg_67_0, arg_67_1)
			return arg_67_0.choice_node_id < arg_67_1.choice_node_id
		end)

		if #self._choices_data == 1 then
			self._has_random = false

			if not self._choices_data.condition_arr or not next(self._choices_data.condition_arr) then
				self._has_condition = false
			end
		end

		if self._has_miss or self._has_hide or self._has_condition or self._has_hide_2 or self._has_garrison_open or self._has_garrison_close then
			self._need_condition = true
		end

		for iter_66_62, iter_66_63 in ipairs(self._choices_data) do
			self:__check_condition_by_choice(iter_66_63)
		end

		for iter_66_64, iter_66_65 in ipairs(self._hide_node_data) do
			self:__check_condition_by_choice(iter_66_65)
		end

		for iter_66_66, iter_66_67 in ipairs(self._hide_node_data_2) do
			self:__check_condition_by_choice(iter_66_67)
		end

		for iter_66_68, iter_66_69 in ipairs(self._miss_node_data) do
			self:__check_condition_by_choice(iter_66_69)
		end

		for iter_66_70, iter_66_71 in ipairs(self._garrison_open_node_data) do
			self:__check_condition_by_choice(iter_66_71)
		end

		for iter_66_72, iter_66_73 in ipairs(self._garrison_close_node_data) do
			self:__check_condition_by_choice(iter_66_73)
		end

		local var_66_16 = false

		for iter_66_74, iter_66_75 in ipairs(self._choices_data) do
			if iter_66_75.is_ok then
				var_66_16 = true
				var_66_0 = iter_66_75.choice_node_id

				break
			end
		end

		if not var_66_16 then
			local var_66_17 = {}

			for iter_66_76, iter_66_77 in ipairs(self._choices_data) do
				var_66_17[#var_66_17 + 1] = {
					node_id = iter_66_77.choice_node_id,
					weight = iter_66_77.random_weight
				}
			end

			var_66_0 = self:__random_by_weight(var_66_17)

			for iter_66_78, iter_66_79 in ipairs(self._choices_data) do
				iter_66_79.is_random_ok = iter_66_79.choice_node_id == var_66_0
			end
		end

		return var_66_0
	end

	function arg_1_0.__random_by_weight(arg_68_0, arg_68_1)
		local var_68_0 = arg_68_1[1].node_id

		math.randomseed(tostring(lx.ServerTime:getUtcTime()):reverse():sub(1, 6))

		local var_68_1 = math.random(1, 100000)
		local var_68_2 = 0

		for iter_68_0, iter_68_1 in ipairs(arg_68_1) do
			var_68_2 = var_68_2 + iter_68_1.weight
		end

		local var_68_3 = 0

		for iter_68_2, iter_68_3 in ipairs(arg_68_1) do
			var_68_3 = var_68_3 + 100000 * iter_68_3.weight / var_68_2

			if var_68_1 <= var_68_3 then
				var_68_0 = iter_68_3.node_id

				break
			end
		end

		return var_68_0
	end

	function arg_1_0:__check_condition_by_choice(arg_69_1)
		if arg_69_1.condition_need_ok_num <= 0 then
			return
		end

		local var_69_0 = {}

		for iter_69_0, iter_69_1 in ipairs(arg_69_1.condition_arr) do
			iter_69_1.condition_ok = false

			if iter_69_1.type == var_0_4.map_next_node_condition_type.team_total_level_greater_equal then
				if self._condition_need_data.team_total_level >= iter_69_1.num then
					iter_69_1.condition_ok = true
				end
			elseif iter_69_1.type == var_0_4.map_next_node_condition_type.team_total_level_less_equal then
				if self._condition_need_data.team_total_level <= iter_69_1.num then
					iter_69_1.condition_ok = true
				end
			elseif iter_69_1.type == var_0_4.map_next_node_condition_type.team_ship_num_greater_equal then
				if self._condition_need_data.team_ship_num >= iter_69_1.num then
					iter_69_1.condition_ok = true
				end
			elseif iter_69_1.type == var_0_4.map_next_node_condition_type.team_ship_num_less_equal then
				if self._condition_need_data.team_ship_num <= iter_69_1.num then
					iter_69_1.condition_ok = true
				end
			elseif iter_69_1.type == var_0_4.map_next_node_condition_type.specific_type_ship_greater_equal then
				if iter_69_1.shipType == 8 and self._condition_need_data.ship_type_data[28] then
					self._condition_need_data.ship_type_data[iter_69_1.shipType] = self._condition_need_data.ship_type_data[iter_69_1.shipType] and self._condition_need_data.ship_type_data[iter_69_1.shipType] + self._condition_need_data.ship_type_data[28] or self._condition_need_data.ship_type_data[28]
				end

				if self._condition_need_data.ship_type_data[iter_69_1.shipType] and self._condition_need_data.ship_type_data[iter_69_1.shipType] >= iter_69_1.num then
					iter_69_1.condition_ok = true
				end
			elseif iter_69_1.type == var_0_4.map_next_node_condition_type.specific_type_ship_less_equal then
				if iter_69_1.shipType == 8 and self._condition_need_data.ship_type_data[28] then
					self._condition_need_data.ship_type_data[iter_69_1.shipType] = self._condition_need_data.ship_type_data[iter_69_1.shipType] and self._condition_need_data.ship_type_data[iter_69_1.shipType] + self._condition_need_data.ship_type_data[28] or self._condition_need_data.ship_type_data[28]
				end

				if self._condition_need_data.ship_type_data[iter_69_1.shipType] and self._condition_need_data.ship_type_data[iter_69_1.shipType] <= iter_69_1.num then
					iter_69_1.condition_ok = true
				end

				if iter_69_1.shipType == 8 and not self._condition_need_data.ship_type_data[iter_69_1.shipType] and not self._condition_need_data.ship_type_data[28] then
					iter_69_1.condition_ok = true
				elseif not self._condition_need_data.ship_type_data[iter_69_1.shipType] then
					iter_69_1.condition_ok = true
				end
			elseif iter_69_1.type == var_0_4.map_next_node_condition_type.first_ship_level_greater_equal then
				if self._condition_need_data.first_ship_info.level >= iter_69_1.num then
					iter_69_1.condition_ok = true
				end
			elseif iter_69_1.type == var_0_4.map_next_node_condition_type.first_ship_level_less_equal then
				if self._condition_need_data.first_ship_info.level <= iter_69_1.num then
					iter_69_1.condition_ok = true
				end
			elseif iter_69_1.type == var_0_4.map_next_node_condition_type.specific_type_first_ship then
				if iter_69_1.shipType == 8 and (self._condition_need_data.first_ship_info.type == iter_69_1.shipType or self._condition_need_data.first_ship_info.type == 28) then
					iter_69_1.condition_ok = true
				elseif self._condition_need_data.first_ship_info.type == iter_69_1.shipType then
					iter_69_1.condition_ok = true
				end
			elseif iter_69_1.type == var_0_4.map_next_node_condition_type.team_total_radar_greater then
				if self._condition_need_data.team_total_radar >= iter_69_1.num then
					iter_69_1.condition_ok = true
				end
			elseif iter_69_1.type == var_0_4.map_next_node_condition_type.first_ship_speed_greater_equal then
				if self._condition_need_data.first_ship_info.speed >= iter_69_1.num then
					iter_69_1.condition_ok = true
				end
			elseif iter_69_1.type == var_0_4.map_next_node_condition_type.first_ship_speed_less_equal then
				if self._condition_need_data.first_ship_info.speed <= iter_69_1.num then
					iter_69_1.condition_ok = true
				end
			elseif iter_69_1.type == var_0_4.map_next_node_condition_type.min_speed_in_team_greater_equal then
				if self._condition_need_data.min_speed_in_team >= iter_69_1.num then
					iter_69_1.condition_ok = true
				end
			elseif iter_69_1.type == var_0_4.map_next_node_condition_type.min_speed_in_team_less_equal then
				if self._condition_need_data.min_speed_in_team <= iter_69_1.num then
					iter_69_1.condition_ok = true
				end
			elseif iter_69_1.type == var_0_4.map_next_node_condition_type.max_speed_in_team_greater_equal then
				if self._condition_need_data.max_speed_in_team >= iter_69_1.num then
					iter_69_1.condition_ok = true
				end
			elseif iter_69_1.type == var_0_4.map_next_node_condition_type.max_speed_in_team_less_equal then
				if self._condition_need_data.max_speed_in_team <= iter_69_1.num then
					iter_69_1.condition_ok = true
				end
			elseif iter_69_1.type == var_0_4.map_next_node_condition_type.team_average_speed_greater_equal then
				if self._condition_need_data.team_average_speed >= iter_69_1.num then
					iter_69_1.condition_ok = true
				end
			elseif iter_69_1.type == var_0_4.map_next_node_condition_type.team_average_speed_less_equal then
				if math.floor(self._condition_need_data.team_average_speed * 100) <= math.floor(iter_69_1.num * 100) then
					iter_69_1.condition_ok = true
				end
			elseif iter_69_1.type == var_0_4.map_next_node_condition_type.team_contain_specific_cid_ship then
				if self._condition_need_data.team_ship_cid_arr[iter_69_1.num] then
					iter_69_1.condition_ok = true
				end
			elseif iter_69_1.type == var_0_4.map_next_node_condition_type.team_not_contain_specific_cid_ship then
				if not self._condition_need_data.team_ship_cid_arr[iter_69_1.num] then
					iter_69_1.condition_ok = true
				end
			elseif iter_69_1.type == var_0_4.map_next_node_condition_type.evolution_ship_num_greater_equal then
				if self._condition_need_data.evolution_ship_num >= iter_69_1.num then
					iter_69_1.condition_ok = true
				end
			elseif iter_69_1.type == var_0_4.map_next_node_condition_type.evolution_ship_num_less_equal then
				if self._condition_need_data.evolution_ship_num <= iter_69_1.num then
					iter_69_1.condition_ok = true
				end
			elseif iter_69_1.type == var_0_4.map_next_node_condition_type.team_total_luck_greater then
				if self._condition_need_data.team_total_luck >= iter_69_1.num then
					iter_69_1.condition_ok = true
				end
			elseif iter_69_1.type == var_0_4.map_next_node_condition_type.team_total_luck_less then
				if self._condition_need_data.team_total_luck <= iter_69_1.num then
					iter_69_1.condition_ok = true
				end
			elseif iter_69_1.type == var_0_4.map_next_node_condition_type.node_not_pass then
				iter_69_1.condition_ok = true

				if iter_69_1.condition_node ~= 70405 then
					if var_0_3:get_map_node_pass_count(self._map_id, iter_69_1.condition_node) >= iter_69_1.num then
						iter_69_1.condition_ok = false
					end
				elseif self._contain_miss then
					iter_69_1.condition_ok = false
				end
			elseif iter_69_1.type == var_0_4.map_next_node_condition_type.hide_pass then
				iter_69_1.condition_ok = false

				local var_69_1 = self._fight_type == var_0_4.fight_type.seventh and var_0_3:get_map_list()[self._map_id] or self._fight_type == var_0_4.fight_type.eighth_attack and var_0_3:get_eighth_map_info()[self._map_id] or var_0_3:get_seventh_map_info()[self._map_id]

				if var_69_1 and next(var_69_1) then
					for iter_69_2, iter_69_3 in pairs(var_69_1.pass_point) do
						if iter_69_3.id == iter_69_1.condition_node then
							iter_69_1.condition_ok = true

							break
						end
					end
				end
			elseif iter_69_1.type == var_0_4.map_next_node_condition_type.hide_pass_2 then
				iter_69_1.condition_ok = false

				if var_0_3:ninth_map_is_pass(iter_69_1.condition_node) then
					iter_69_1.condition_ok = true
				end

				var_0_32(var_69_0, 0)
			elseif iter_69_1.type == var_0_4.map_next_node_condition_type.garrison_open then
				iter_69_1.condition_ok = self:__is_map_cid_in_garrison(iter_69_1.map_cid)
			elseif iter_69_1.type == var_0_4.map_next_node_condition_type.garrison_close then
				iter_69_1.condition_ok = not self:__is_map_cid_in_garrison(iter_69_1.map_cid)
			end
		end

		local var_69_3 = 0

		for iter_69_4, iter_69_5 in ipairs(arg_69_1.condition_arr) do
			if iter_69_5.condition_ok then
				var_69_3 = var_69_3 + 1
			end
		end

		arg_69_1.condition_ok_num = var_69_3
		arg_69_1.is_ok = var_69_3 >= arg_69_1.condition_need_ok_num
	end

	function arg_1_0:__play_ship_move(arg_70_1, arg_70_2, arg_70_3, arg_70_4)
		self:update_fearlessness_sea_panel_random_buff(arg_70_2)

		self.start_node_by_is_chose = arg_70_1
		self.next_node_by_is_chose = arg_70_2
		self.is_story = arg_70_3
		self._next_move_node_data = arg_70_2
		self._control.bg.map_mask.image.enabled = false

		local var_70_0 = self:__get_real_node_pos(self._control.bg.rectTransform.rect.width, self._control.bg.rectTransform.rect.height, arg_70_1.position.x, arg_70_1.position.y)
		local var_70_1 = self:__get_real_node_pos(self._control.bg.rectTransform.rect.width, self._control.bg.rectTransform.rect.height, arg_70_2.position.x, arg_70_2.position.y)

		if self._fight_type == var_0_4.fight_type.event_story then
			var_70_0 = self:__get_real_node_pos(self._control.bg.rectTransform.rect.width, self._control.bg.rectTransform.rect.height, arg_70_1.position.x, arg_70_1.position.y - 128)
			var_70_1 = self:__get_real_node_pos(self._control.bg.rectTransform.rect.width, self._control.bg.rectTransform.rect.height, arg_70_2.position.x, arg_70_2.position.y - 128)

			local var_70_2 = 0

			if var_70_1.x >= 849 then
				var_70_2 = var_70_0.x - 700
				var_70_0 = var_0_26(700, var_70_0.y)
				var_70_1 = var_0_26(var_70_1.x - (var_70_0.x - 700), var_70_1.y)
			end

			self._control.bg.map_path.rectTransform.localPosition = var_0_26(-var_70_2, 128)
			self.now_node_list[arg_70_1.id].node_image.image.sprite = self:loadSprite(var_0_4.sixth_map_node_icon.sixth_point_blue)

			if arg_70_1.node_type == 4 then
				self.now_node_list[arg_70_1.id].node_image.image.sprite = self:loadSprite(var_0_4.sixth_map_node_icon.sixth_start_blue)
			end

			if self.now_line_list[arg_70_1.id - 1] then
				self.now_line_list[arg_70_1.id - 1].line_image.image.sprite = self:loadSprite(self.lineImagePath)
				self.now_node_list[arg_70_1.id - 1].node_image.image.sprite = self:loadSprite(var_0_4.sixth_map_node_icon.sixth_point_blue)

				if self:__get_node_by_id(arg_70_1.id - 1).node_type == 4 then
					self.now_node_list[arg_70_1.id - 1].node_image.image.sprite = self:loadSprite(var_0_4.sixth_map_node_icon.sixth_start_blue)
				end
			end

			if self.now_line_list[arg_70_1.id - 2] then
				self.now_line_list[arg_70_1.id - 2].line_image.image.sprite = self:loadSprite(self.lineImagePath)
			end
		end

		self._control.bg.ship_layer.ship_icon.rectTransform.anchoredPosition = var_70_0

		local var_70_3 = {}

		for iter_70_0, iter_70_1 in pairs((var_0_3:get_player_story_unlock_data())) do
			var_0_32(var_70_3, iter_70_0, iter_70_1.id)
		end

		if arg_70_1.movie[1] and arg_70_1.movie[1][1] ~= 0 and not arg_70_3 then
			if var_0_34.have_data(var_70_3, arg_70_1.movie[1][1]) then
				if self._fight_type == var_0_4.fight_type.event_story then
					local var_70_4 = var_0_20.find_object_by_id(arg_70_1.movie[1][1])

					var_0_2:createInstance("cinema_dialog"):show(var_70_4.movie_group_id, var_70_4.movie_id[1], var_70_4.movie_id[2], 1, {
						start_node = arg_70_1,
						next_node = arg_70_2,
						is_chose = arg_70_4
					})

					return
				end

				if self._fight_type == var_0_4.fight_type.event_story and not arg_70_4 then
					self._control.bg.select_node_layer:SetActive(true)

					self._control.bg.select_node_layer.static_text.text.text = var_0_1:getNowLang("six_choosenode")

					self._control.bg.select_1:SetActive(true)

					self._control.bg.select_1.point.image.sprite = self:loadSprite(var_0_4.sixth_map_node_icon.sixth_point_white)

					if arg_70_2.node_type == 2 then
						self._control.bg.select_1.point.image.sprite = self:loadSprite(var_0_4.sixth_map_node_icon.sixth_boss_white)
					end

					self._control.bg.select_1.point_img.image.sprite = self:loadSprite(var_0_23(var_0_4.sixth_map_node_name, arg_70_2.flag))
					self._control.bg.select_1.point_text.text.text = arg_70_2.flag
					self._control.bg.select_1.info_text.text.text = var_0_1:convert_rich_text(arg_70_2.buff_desc, true)

					if arg_70_1.node_type == 4 then
						var_0_3:req_EnterSixthStoryReq(arg_70_1.id, 1)
					end

					return
				end
			end
		end

		local var_70_5 = self._fight_type == var_0_4.fight_type.abyss_model_first_phase
		local var_70_6 = 1
		local var_70_7 = 0

		self._control.bg.ship_layer.ship_icon.transform.localRotation = var_70_1.x - self._control.bg.ship_layer.ship_icon.rectTransform.anchoredPosition.x > 0 and var_0_26(0, 0) or var_0_26(0, 180)

		local var_70_8 = self:autoKillDOTween(var_0_33.Sequence())
		local var_70_9 = self._control.bg.ship_layer.ship_icon.rectTransform:DOAnchorPos(var_70_1, var_70_6):SetEase(DG.Tweening.Ease.Linear):SetDelay(var_70_7):SetAutoKill(true)

		if var_70_5 then
			if self.now_node_list[arg_70_1.id] and self.now_node_list[arg_70_2.id] then
				local var_70_10 = self.now_node_list[arg_70_1.id].node_image.rectTransform.anchoredPosition.x
				local var_70_11 = self.now_node_list[arg_70_2.id].node_image.rectTransform.anchoredPosition.x
				local var_70_12, var_70_13 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self._control.bg.map_path.transform, var_0_26(0, 0), nil, nil)
				local var_70_14 = 640 + var_70_13.x

				if var_70_10 <= 640 + var_70_13.x and var_70_14 <= var_70_11 or var_70_14 <= var_70_10 and var_70_11 <= var_70_14 then
					local var_70_15 = self._control.bg.map_path.rectTransform.anchoredPosition - var_0_26(var_70_11 - var_70_14, 0)

					if var_70_15.x > 320 then
						var_70_15 = var_0_26(320, 0)
					end

					if var_70_15.x < -320 then
						var_70_15 = var_0_26(-320, 0)
					end

					var_70_8:Insert(0, self._control.bg_r.rectTransform:DOAnchorPos(var_70_15, var_70_6):SetEase(DG.Tweening.Ease.Linear):SetDelay(var_70_7):SetAutoKill(true))
					var_70_8:Insert(0, self._control.bg.map_path.rectTransform:DOAnchorPos(var_70_15, var_70_6):SetEase(DG.Tweening.Ease.Linear):SetDelay(var_70_7):SetAutoKill(true))
					var_70_8:Insert(0, self._control.bg.ship_layer.rectTransform:DOAnchorPos(var_70_15, var_70_6):SetEase(DG.Tweening.Ease.Linear):SetDelay(var_70_7):SetAutoKill(true))
				end
			end
		end

		function var_70_9.onComplete()
			if self._liner_list[arg_70_1.id] then
				local var_71_1 = arg_70_1.flag

				if self._fight_type == var_0_4.fight_type.ocean_attack and (arg_70_1.flag == "α" or arg_70_1.flag == "β") then
					arg_70_1.flag = 0
				end

				local var_71_2 = var_0_23("%s-%s-%s", arg_70_1.pve_level_id, arg_70_1.flag == "" and 0 or arg_70_1.flag, arg_70_2.flag)

				for iter_71_0, iter_71_1 in pairs(self._liner_list[arg_70_1.id]) do
					if iter_71_1.lineImageName == var_71_2 and not iter_71_1.isCanNeedClose then
						iter_71_1.mapLineControl.line_image.image.color = self.is_abyss_team and var_0_28.New(0.6196078431372549, 0.2, 0.2) or var_0_28.New(0.2, 0.5686274509803921, 0.8666666666666667)

						if self._fight_type == var_0_4.fight_type.fearlessness_sea and var_0_3:get_fearlessness_is_hard() then
							iter_71_1.mapLineControl.line_image.image.color = var_0_28.New(0.6196078431372549, 0.2, 0.2)
						elseif self._fight_type == var_0_4.fight_type.seventh and var_0_3:get_is_cur_seventh_difficulty_mode() then
							iter_71_1.mapLineControl.line_image.image.color = var_0_28.New(0.6196078431372549, 0.2, 0.2)
						elseif self._fight_type == var_0_4.fight_type.score_attack and var_0_3:get_is_cur_score_difficulty_mode() then
							iter_71_1.mapLineControl.line_image.image.color = var_0_28.New(0.6196078431372549, 0.2, 0.2)
						elseif self._fight_type == var_0_4.fight_type.eighth_attack and var_0_3:get_is_cur_eighth_difficulty_mode() then
							iter_71_1.mapLineControl.line_image.image.color = var_0_28.New(0.6196078431372549, 0.2, 0.2)
						elseif self._fight_type == var_0_4.fight_type.ninth_attack and var_0_3:get_is_cur_ninth_difficulty_mode() then
							iter_71_1.mapLineControl.line_image.image.color = var_0_28.New(0.6196078431372549, 0.2, 0.2)
						end

						if self._fight_type == var_0_4.fight_type.abyss_model_first_phase then
							var_0_3:record_fight_info_pass(var_71_2, iter_71_1.mapLineControl.line_image.image)
							var_0_3:record_fight_info_pass(arg_70_2.id, self.now_node_list[arg_70_2.id])
						elseif self._fight_type == var_0_4.fight_type.seventh then
							var_0_3:record_seventh_fight_info_pass(var_71_2, iter_71_1.mapLineControl.line_image.image)
							var_0_3:record_seventh_fight_info_pass(arg_70_2.id, self.now_node_list[arg_70_2.id])
						elseif self._fight_type == var_0_4.fight_type.score_attack then
							var_0_3:record_score_push_info_pass(var_71_2, iter_71_1.mapLineControl.line_image.image)
							var_0_3:record_score_push_info_pass(arg_70_2.id, self.now_node_list[arg_70_2.id])
						elseif self._fight_type == var_0_4.fight_type.eighth_attack then
							var_0_3:record_eighth_fight_info_pass(var_71_2, iter_71_1.mapLineControl.line_image.image)
							var_0_3:record_eighth_fight_info_pass(arg_70_2.id, self.now_node_list[arg_70_2.id])
						elseif self._fight_type == var_0_4.fight_type.ninth_attack then
							var_0_3:record_ninth_info_pass(var_71_2, iter_71_1.mapLineControl.line_image.image)
							var_0_3:record_ninth_info_pass(arg_70_2.id, self.now_node_list[arg_70_2.id])
						end
					end
				end

				if self._fight_type == var_0_4.fight_type.abyss_model_first_phase then
					for iter_71_2, iter_71_3 in pairs(self._point_list) do
						if iter_71_2 == arg_70_2.id then
							iter_71_3.node_image.image.sprite = self:loadSprite((arg_70_2.node_type == var_0_4.abyss_map_node_type.prepare or nil) and var_0_4.abyss_const.abyss_repair_point_pass)
						end
					end
				end

				local var_71_6 = var_0_23(var_0_4.fearlessness_sea_node_letter, arg_70_2.flag .. (not self.is_abyss_team and 2 or 3))

				for iter_71_4, iter_71_5 in pairs(self._letter_list) do
					if iter_71_4 == arg_70_2.id then
						iter_71_5.node_letter_image.image.sprite = self:loadSprite(var_71_6)
					end
				end

				if self._fight_type == var_0_4.fight_type.ocean_attack or self._fight_type == var_0_4.fight_type.score_attack or self._fight_type == var_0_4.fight_type.ninth_attack then
					arg_70_1.flag = var_71_1
				end
			end

			if self._fight_type == var_0_4.fight_type.event_story then
				var_0_3:set_battle_type(var_0_4.battle_type.event_story)

				self._team_detail_data = {}
				self.player_list = arg_70_2.self_formation

				for iter_71_6, iter_71_7 in pairs(self.player_list) do
					local var_71_7 = var_0_8.find_object_by_cid(iter_71_7)

					var_0_32(self._team_detail_data, {
						data = var_0_34.little_clone(var_71_7),
						config = var_0_34.little_clone(var_71_7)
					})
				end

				local var_71_8 = {
					monster = arg_70_2.formation,
					point = arg_70_2.id,
					search = self:__get_search(self._team_detail_data, arg_70_2.formation)
				}

				if arg_70_2.movie[2] and arg_70_2.movie[2][1] ~= 0 then
					local var_71_9 = var_0_20.find_object_by_id(arg_70_2.movie[2][1])

					var_0_2:createInstance("cinema_dialog"):show(var_71_9.movie_group_id, var_71_9.movie_id[1], var_71_9.movie_id[2], 2, var_71_8)
				else
					self:__map_move_response(var_71_8)
				end

				self.now_monster = arg_70_2.formation
				self.now_node = arg_70_2.id
			elseif self._fight_type == var_0_4.fight_type.war_concerto then
				local var_71_10 = arg_70_2.id

				if self._input_map_node ~= 0 then
					var_71_10 = self._input_map_node
				end

				var_0_3:set_fifth_now_node(var_71_10)
				var_0_3:req_ConcertoMapMoveReq(var_71_10)
			elseif self._fight_type == var_0_4.fight_type.war_concerto_play then
				var_0_3:req_RecreationMoveMapReq((self._input_map_node ~= 0 or nil) and self._input_map_node)
			elseif self._fight_type == var_0_4.fight_type.ocean_attack then
				local var_71_12 = arg_70_2.id

				if self._input_map_node ~= 0 then
					var_71_12 = self._input_map_node
				end

				local var_71_13 = var_0_3:get_current_ocean_map_start_point()
				local var_71_14 = ocean_map_node_config.find_object_by_id_start_node_id(var_71_12, var_71_13)

				if not var_0_3:is_ocean_map_node_pass(var_71_13, var_71_12) and var_71_14.score ~= 0 then
					var_0_3:set_ocean_map_point_list(tonumber(string.sub(var_71_13, 1, 4)), var_71_14.score)
				end

				var_0_3:req_OceanMoveMapReq(var_71_12)
			elseif self._fight_type == var_0_4.fight_type.score_attack then
				local var_71_15 = arg_70_2.id

				if self._input_map_node ~= 0 then
					var_71_15 = self._input_map_node
				end

				local var_71_16 = var_0_3:get_current_score_map_start_point()
				local var_71_17 = var_0_19.find_object_by_id_start_node_id(var_71_15, var_71_16)

				if not var_0_3:is_score_map_node_pass(var_71_16, var_71_15) and var_71_17.score ~= 0 then
					var_0_3:set_score_map_point_list(tonumber(string.sub(var_71_16, 1, 4)), var_71_17.score)
				end

				var_0_3:req_AnswerMoveMapReq(var_71_15)
			elseif self._fight_type == var_0_4.fight_type.ninth_attack then
				local var_71_18 = arg_70_2.id

				if self._input_map_node ~= 0 then
					var_71_18 = self._input_map_node
				end

				local var_71_19 = var_0_3:get_ninth_map_start_point()
				local var_71_20 = var_0_3:is_ninth_map_node_pass(var_71_19, var_71_18)
				local var_71_21 = var_0_47.find_object_by_id_start_node_id(var_71_18, var_71_19)

				if arg_70_2.movie[2] and arg_70_2.movie[2][1] ~= 0 and not var_0_34.have_data(var_70_3, arg_70_2.movie[2][1]) then
					local var_71_22 = var_0_20.find_object_by_id(arg_70_2.movie[2][1])

					var_0_2:createInstance("cinema_dialog"):show(var_71_22.movie_group_id, var_71_22.movie_id[1], var_71_22.movie_id[2], 5, nil, function()
						var_0_3:req_NinthMapMoveReq(var_71_18)
					end)
				else
					var_0_3:req_NinthMapMoveReq(var_71_18)
				end

				if arg_70_2.node_type == 4 and self.now_node_list[arg_70_2.id] then
					self.now_node_list[arg_70_2.id].node_image.image.sprite = self:loadSprite(var_0_4.fight_point.pve_blue)
				end
			elseif self._fight_type == var_0_4.fight_type.abyss_model_first_phase then
				local var_71_23 = arg_70_2.id

				if self._input_map_node ~= 0 then
					var_71_23 = self._input_map_node
				end

				local var_71_24 = var_0_3:gm_abyss_get_jump_node()

				var_0_3:gm_abyss_record_jump_node(nil)

				local var_71_25 = {
					point = var_71_24 or var_71_23,
					team = var_0_3:get_abyss_preview_now_page() + 1
				}
				local var_71_26

				if self:__show_abyss_review_fight_point(arg_70_1, arg_70_2, var_71_25) then
					do return end

					var_71_26 = {}
				end

				for iter_71_8, iter_71_9 in pairs((var_0_3:get_player_story_unlock_data())) do
					var_0_32(var_71_26, iter_71_8, iter_71_9.id)
				end

				if arg_70_2.movie[2] and arg_70_2.movie[2][1] ~= 0 and not var_0_34.have_data(var_71_26, arg_70_2.movie[2][1]) then
					local var_71_27 = var_0_20.find_object_by_id(arg_70_2.movie[2][1])

					var_0_2:createInstance("cinema_dialog"):show(var_71_27.movie_group_id, var_71_27.movie_id[1], var_71_27.movie_id[2], 5, nil, function()
						var_0_3:req_AbyssMoveMapReq(var_71_25)
					end)
				else
					var_0_3:req_AbyssMoveMapReq(var_71_25)
				end
			elseif self._fight_type == var_0_4.fight_type.gotofight or self._fight_type == var_0_4.fight_type.fearlessness_sea then
				local var_71_28 = arg_70_2.id

				if self._input_map_node ~= 0 then
					var_71_28 = self._input_map_node
				end

				if arg_70_2.movie[2] and arg_70_2.movie[2][1] ~= 0 and not var_0_34.have_data(var_70_3, arg_70_2.movie[2][1]) then
					local var_71_29 = var_0_20.find_object_by_id(arg_70_2.movie[2][1])

					var_0_2:createInstance("cinema_dialog"):show(var_71_29.movie_group_id, var_71_29.movie_id[1], var_71_29.movie_id[2], 5, nil, function()
						if self._fight_type == var_0_4.fight_type.gotofight then
							var_0_3:tryPushEnterEndDo(function()
								var_0_3:req_MapMoveReq(var_71_28)
							end)
						else
							var_0_3:tryPushEnterEndDo(function()
								var_0_3:req_PushMapMoveReq(var_71_28)
							end)
						end
					end)
				elseif self._fight_type == var_0_4.fight_type.gotofight then
					var_0_3:tryPushEnterEndDo(function()
						var_0_3:req_MapMoveReq(var_71_28)
					end)
				else
					var_0_3:tryPushEnterEndDo(function()
						var_0_3:req_PushMapMoveReq(var_71_28)
					end)
				end

				if arg_70_2.node_type == 4 and self.now_node_list[arg_70_2.id] then
					self.now_node_list[arg_70_2.id].node_image.image.sprite = self:loadSprite(var_0_4.fight_point.pve_blue)
				end
			elseif self._fight_type == var_0_4.fight_type.seventh then
				local var_71_30 = arg_70_2.id

				if self._input_map_node ~= 0 then
					var_71_30 = self._input_map_node
				end

				if arg_70_2.movie[2] and arg_70_2.movie[2][1] ~= 0 and not var_0_34.have_data(var_70_3, arg_70_2.movie[2][1]) then
					local var_71_31 = var_0_20.find_object_by_id(arg_70_2.movie[2][1])

					var_0_2:createInstance("cinema_dialog"):show(var_71_31.movie_group_id, var_71_31.movie_id[1], var_71_31.movie_id[2], 5, nil, function()
						var_0_3:req_SeventhMapMoveReq(var_71_30)
					end)
				else
					var_0_3:req_SeventhMapMoveReq(var_71_30)
				end

				if arg_70_2.node_type == 4 and self.now_node_list[arg_70_2.id] then
					self.now_node_list[arg_70_2.id].node_image.image.sprite = self:loadSprite(var_0_4.fight_point.pve_blue)
				end
			elseif self._fight_type == var_0_4.fight_type.eighth_attack then
				local var_71_32 = arg_70_2.id

				if self._input_map_node ~= 0 then
					var_71_32 = self._input_map_node
				end

				if arg_70_2.movie[2] and arg_70_2.movie[2][1] ~= 0 and not var_0_34.have_data(var_70_3, arg_70_2.movie[2][1]) then
					local var_71_33 = var_0_20.find_object_by_id(arg_70_2.movie[2][1])

					var_0_2:createInstance("cinema_dialog"):show(var_71_33.movie_group_id, var_71_33.movie_id[1], var_71_33.movie_id[2], 5, nil, function()
						var_0_3:req_EighthMapMoveReq(var_71_32)
					end)
				else
					var_0_3:req_EighthMapMoveReq(var_71_32)
				end

				if arg_70_2.node_type == 4 and self.now_node_list[arg_70_2.id] then
					self.now_node_list[arg_70_2.id].node_image.image.sprite = self:loadSprite(var_0_4.fight_point.pve_blue)
				end
			end
		end

		var_70_8:Insert(0, var_70_9)

		if self._fight_type == var_0_4.fight_type.abyss_model_first_phase then
			var_70_8:AppendCallback(function()
				var_0_3:set_abyss_fight_cam(self._map_id, self._control.bg.map_path.rectTransform.anchoredPosition, self._control.bg.ship_layer.ship_icon.rectTransform.anchoredPosition)
			end)
		elseif self._fight_type == var_0_4.fight_type.ninth_attack then
			var_70_8:AppendCallback(function()
				var_0_3:set_ninth_fight_cam(self._map_id, self._control.bg.map_path.rectTransform.anchoredPosition, self._control.bg.ship_layer.ship_icon.rectTransform.anchoredPosition)
			end)
		end

		var_70_8:Play()
	end

	function arg_1_0.__get_search(arg_83_0, arg_83_1, arg_83_2)
		local var_83_0 = {}
		local var_83_1 = 0
		local var_83_2 = 0

		for iter_83_0, iter_83_1 in pairs(arg_83_1) do
			var_83_1 = var_83_1 + iter_83_1.data.radar
		end

		local var_83_3 = var_0_11.find_object_by_id(arg_83_2)

		if not var_83_3 then
			return true
		end

		for iter_83_2, iter_83_3 in pairs(var_83_3.formation) do
			var_0_32(var_83_0, (var_0_12.find_object_by_id(iter_83_3)))
		end

		for iter_83_4, iter_83_5 in pairs(var_83_0) do
			var_83_2 = var_83_2 + iter_83_5.radar
		end

		return 50 + (var_83_1 - var_83_2) * 5 >= lan_rand(1, 199)
	end

	function arg_1_0:__map_move_response(arg_84_1)
		self._response_data = arg_84_1

		if self._fight_type == var_0_4.fight_type.gotofight then
			local var_84_0 = {
				player = {},
				enemy = {}
			}

			for iter_84_0, iter_84_1 in pairs(self._team_detail_data) do
				iter_84_1.data.cid = iter_84_1.config.cid
				iter_84_1.data.skin_id = iter_84_1.data.skin

				var_0_32(var_84_0.player, iter_84_1.data)
			end

			for iter_84_2, iter_84_3 in pairs(self._response_data.monster_array) do
				var_0_32(var_84_0.enemy, {
					cid = iter_84_3,
					monster_type = var_0_38.enemy_type.monster
				})
			end

			self:__preload_battle_asset({
				bg_sea = var_0_6.find_object_by_id(self._response_data.point).bg_sea
			}, var_84_0)
		end

		local function var_84_1()
			if self._fight_type == var_0_4.fight_type.ocean_attack then
				var_0_3:set_ocean_team_detail_data(self._team_detail_data)
			end

			if self._fight_type == var_0_4.fight_type.score_attack then
				var_0_3:set_score_team_detail_data(self._team_detail_data)
			elseif self._fight_type == var_0_4.fight_type.ninth_attack then
				var_0_3:set_ninth_team_detail_data(self._team_detail_data)
			end

			if self._next_move_node_data.node_type == var_0_4.map_node_type.reward then
				self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.get_resource_1))
				self:__show_get_or_loss_res_msg_box(arg_84_1, "logget", true)
			elseif self._next_move_node_data.node_type == var_0_4.map_node_type.loss then
				self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.get_resource_2))
				self:__show_get_or_loss_res_msg_box(arg_84_1, "pvelostitemtitle", false)
			elseif self._next_move_node_data.node_type == var_0_4.map_node_type.null then
				self:__show_fight_info(self._next_move_node_data.id)
			elseif self._next_move_node_data.node_type == var_0_4.map_node_type.hide then
				-- block empty
			elseif self._next_move_node_data.node_type == var_0_4.map_node_type.push_buff_point then
				if self._fight_type == var_0_4.fight_type.fearlessness_sea then
					local var_85_0 = var_0_39.find_object_by_id(arg_84_1.point)

					if var_85_0.node_type == 13 then
						if self:__get_max_push_buff_num() > self:__get_now_push_buff_num() then
							self:_show_fearlessness_active_buff(var_85_0.id)

							return
						else
							if arg_84_1 then
								if arg_84_1.point then
									self:__show_fight_info(arg_84_1.point)
								end
							else
								local var_85_1 = var_0_2:getInstance("fearlessness_sea")

								if var_85_1 then
									var_85_1:show()
									var_0_3:show_panel_mix_panel(self._map_id)

									return
								else
									var_0_2:destroyInstance("fight_info")
									var_0_2:createInstance("fearlessness_sea"):show()
									var_0_3:show_panel_mix_panel(self._map_id)
								end
							end

							return
						end
					end
				end
			else
				self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.waring))

				local var_85_2 = self:__get_real_node_pos(self._control.bg.rectTransform.rect.width, self._control.bg.rectTransform.rect.height, self._next_move_node_data.position.x, self._next_move_node_data.position.y)

				self._control.bg.ship_layer.encounter_effect.rectTransform.anchoredPosition = self._control.bg.ship_layer.ship_icon.rectTransform.anchoredPosition

				self._control.bg.ship_layer.encounter_effect.encounter_spine.skeletonGraphic.AnimationState:ClearTracks()
				self._control.bg.ship_layer.encounter_effect.encounter_spine.skeletonGraphic.AnimationState:SetAnimation(0, "Cable_enemy", true)

				self._control.bg.ship_layer.encounter_effect.canvasGroup.alpha = 1
				self._control.bg.map_mask.image.enabled = true

				if self._next_move_node_data.buff == nil or self._next_move_node_data.buff == 0 then
					self:__toggle_encounter(true, arg_84_1)
				elseif next(self._next_move_node_data.buff) then
					self:__show_strong_buff(self._next_move_node_data.buff)
				else
					var_0_3:set_strong_buff_list()
					self:__toggle_encounter(true, arg_84_1)
				end
			end
		end

		if arg_84_1.monster == 10505002 then
			self._control.boss_new_root.gameObject:SetActive(true)

			local var_84_2 = self._control.boss_new_root.boss_new.skeletonGraphic

			self._control.boss_new_root.canvasGroup.alpha = 1
			self._control.boss_new_root.canvasGroup.blocksRaycasts = true

			self._control.boss_new_root.boss_new.skeletonGraphic.AnimationState:SetAnimation(var_0_4.boss_new.priority, var_0_4.boss_new.name, var_0_4.boss_new.loop)

			local var_84_3 = self._control.boss_new_root.boss_new.skeletonGraphic.AnimationState.Complete

			local function var_84_4()
				var_84_1()

				var_84_2.AnimationState.Complete = var_84_3
			end

			var_84_3 = self._control.boss_new_root.boss_new.skeletonGraphic.AnimationState.Complete + var_84_4
			self._control.boss_new_root.boss_new.skeletonGraphic.AnimationState.Complete = self._control.boss_new_root.boss_new.skeletonGraphic.AnimationState.Complete + var_84_4
			var_84_3 = var_84_3 - var_84_4
		else
			var_84_1()
		end
	end

	function arg_1_0.__preload_battle_asset(arg_87_0, arg_87_1, arg_87_2)
		gamecore.PreloadManager:preload_battle_asset(arg_87_1, arg_87_2)
		gamecore.PreloadManager:load_battle_music(arg_87_2)
		gamecore.PreloadManager:load_battle_prefab()
	end

	function arg_1_0:__show_get_or_loss_res_msg_box(arg_88_1, arg_88_2, arg_88_3)
		self:__change_reward_point_spirit()

		local var_88_0 = var_0_2:getInstance("msgbox") or var_0_2:createInstance("msgbox")

		var_88_0._control.main.close:SetActive(false)

		local var_88_2

		if arg_88_3 then
			var_88_2 = self._next_move_node_data.gain[1].id or self._next_move_node_data.loss[1].id
		end

		local var_88_3 = var_0_23(var_0_4.icon.item_icon, var_88_2)

		var_88_0:showOne({
			url = var_88_3,
			num = (arg_88_3 or nil) and (self._next_move_node_data.gain[1].value or 0 - self._next_move_node_data.loss[1].value),
			reward_name = var_0_1:getNowLang(var_0_23("resource%d", var_88_2))
		}, function()
			self:__show_fight_info(self._next_move_node_data.id)
			var_88_0._control.main.close:SetActive(true)
		end, var_0_1:getNowLang("ui_cbtn1"), var_0_1:getNowLang(arg_88_2), var_0_4.msg_type.reward)
	end

	function arg_1_0:__change_reward_point_spirit()
		if self._next_move_node_data.node_type == var_0_4.map_node_type.reward then
			self.now_node_list[self._next_move_node_data.id].node_image.image.sprite = self:loadSprite(var_0_4.fight_point.pve_green)
		elseif self._next_move_node_data.node_type == var_0_4.map_node_type.loss then
			self.now_node_list[self._next_move_node_data.id].node_image.image.sprite = self:loadSprite(var_0_4.fight_point.pve_purple)
		end
	end

	function arg_1_0:__show_strong_buff(arg_91_1)
		self._strong_buff_list = arg_91_1
		self._control.bg.info_bg.strongattack.canvasGroup.alpha = 1
		self._control.bg.info_bg.strongattack.canvasGroup.blocksRaycasts = true
		self._control.bg.info_bg.strongattack.titlebg.title.image.sprite = self:loadSprite(var_0_4.normal_title_bg)

		for iter_91_0 = 1, #arg_91_1 do
			local var_91_0 = var_0_35.find_object_by_id(arg_91_1[iter_91_0])

			if var_91_0 then
				local var_91_1 = self._control.bg.info_bg.strongattack[var_0_23("string_node%s", iter_91_0)]

				var_91_1.buff_name.text.text = var_91_0.title
				var_91_1.attr_info.text.text = var_0_34.convert_rich_text(var_91_0.desc)
				var_91_1.info_text.text.text = var_91_0.effect_desc
			end
		end
	end

	function arg_1_0:__toggle_encounter(arg_92_1, arg_92_2)
		if arg_92_1 then
			if self._fight_type == var_0_4.fight_type.event_story then
				self._control.bg.title_bg:SetActive(true)
				self._control.bg.campaign_bg:SetActive(true)

				if arg_92_2.search then
					self:__toggle_lock_enemy(true, arg_92_2)
				else
					self:__toggle_lost_enemy(true)
				end

				return
			end

			self._control.bg.info_bg.mask.canvasGroup.alpha = 1
			self._control.bg.info_bg.encounter_bg.canvasGroup.alpha = 1

			self._control.bg.info_bg.round_about_lock_enemy_txt:SetActive(true)

			if self._response_data and next(self._response_data) then
				if var_0_34.have_index(self._response_data, "search_rate") then
					local var_92_0 = self._response_data.search_rate

					if self._response_data.search_rate > 100 then
						var_92_0 = 100
					elseif var_92_0 < 0 then
						var_92_0 = 0
					end

					self._control.bg.info_bg.round_about_lock_enemy_txt.lock_enemy_info_bg.lock_enemy_info_txt.text.text = var_92_0 .. "%"
				else
					self._control.bg.info_bg.round_about_lock_enemy_txt.lock_enemy_info_bg.lock_enemy_info_txt.text.text = 50 .. "%"
				end
			end

			local var_92_1 = {}
			local var_92_2 = {
				can_not_skip = false
			}

			var_92_2.execute_time = 1.5

			function var_92_2.execute_func()
				self._control.bg.info_bg.encounter_bg.canvasGroup.alpha = 0

				self._control.bg.info_bg.encounter_bg.encounter_spine.skeletonGraphic.AnimationState:ClearTracks()

				if arg_92_2.search then
					self:__toggle_lock_enemy(true, arg_92_2)
					self._control.bg.info_bg.round_about_lock_enemy_txt:SetActive(true)
				else
					self:__toggle_lost_enemy(true)
					self._control.bg.info_bg.round_about_lock_enemy_txt:SetActive(true)
				end
			end

			var_92_1[#var_92_1 + 1] = var_92_2
			self._time_execute_task_list = var_92_1

			self._control.bg.info_bg.encounter_bg.encounter_spine.skeletonGraphic.AnimationState:SetAnimation(0, "encounter_new", false)
		else
			self._control.bg.info_bg.encounter_bg.canvasGroup.alpha = 0

			if self._control.bg.info_bg.encounter_bg.encounter_spine.skeletonGraphic.AnimationState then
				self._control.bg.info_bg.encounter_bg.encounter_spine.skeletonGraphic.AnimationState:ClearTracks()
			end
		end
	end

	function arg_1_0:__toggle_lock_enemy(arg_94_1, arg_94_2)
		if arg_94_1 then
			self._control.bg.info_bg.lock_enemy_bg.canvasGroup.alpha = 1

			self._control.bg.info_bg.lock_enemy_bg.radar_frame.radar_effect1.dOTweenAnimation:DORestart()
			self._control.bg.info_bg.lock_enemy_bg.radar_frame.radar_effect2.dOTweenAnimation:DORestart()
			self._control.bg.info_bg.lock_enemy_bg.lock_enemy_spine:SetActive(true)
			self._control.bg.info_bg.lock_enemy_bg.round_about_spine:SetActive(false)
			self._control.bg.info_bg.lock_enemy_bg.rate_bg:SetActive(false)
			self._control.bg.info_bg.round_about_lock_enemy_txt:SetActive(false)
			self._control.bg.info_bg.lock_enemy_bg.round_about:SetActive(false)

			local var_94_0 = self._control.bg.info_bg.lock_enemy_bg.lock_enemy_spine.skeletonGraphic.AnimationState

			local function var_94_2()
				self._control.bg.info_bg.lock_enemy_bg.canvasGroup.alpha = 0
				self._control.bg.info_bg.mask.canvasGroup.alpha = 0

				self._control.bg.info_bg.lock_enemy_bg.lock_enemy_spine.skeletonGraphic.AnimationState:ClearTracks()
				self:__toggle_enemy_info(true, arg_94_2)
			end

			local var_94_3 = {}

			if ((self._fight_type == var_0_4.fight_type.event_story or self._fight_type == var_0_4.fight_type.sixth_fight) and var_0_13.find_object_by_id(arg_94_2.point) or self._fight_type == var_0_4.fight_type.ocean_attack and ocean_map_node_config.find_object_by_id_start_node_id(arg_94_2.point, (var_0_3:get_current_ocean_map_start_point())) or self._fight_type == var_0_4.fight_type.score_attack and var_0_19.find_object_by_id_start_node_id(arg_94_2.point, (var_0_3:get_current_score_map_start_point())) or (self._fight_type == var_0_4.fight_type.war_concerto or self._fight_type == var_0_4.fight_type.war_concerto_play) and var_0_16.find_object_by_id(arg_94_2.point) or self._fight_type == var_0_4.fight_type.abyss_model_first_phase and abyss_map_node_config.find_object_by_id(arg_94_2.point) or self._fight_type == var_0_4.fight_type.fearlessness_sea and var_0_39.find_object_by_id(arg_94_2.point) or self._fight_type == var_0_4.fight_type.seventh and var_0_22.find_object_by_id(arg_94_2.point) or self._fight_type == var_0_4.fight_type.eighth_attack and gameconfig.pve_eighth_level_node_config.find_object_by_id(arg_94_2.point) or self._fight_type == var_0_4.fight_type.ninth_attack and var_0_47.find_object_by_id_start_node_id(arg_94_2.point, (var_0_3:get_ninth_map_start_point())) or var_0_6.find_object_by_id(arg_94_2.point)).roundabout ~= 1 then
				var_94_3[#var_94_3 + 1] = {
					execute_time = 1.5,
					execute_func = var_94_2
				}
			else
				local var_94_4 = {
					execute_time = (#var_94_3 + 1) * 1.5
				}

				function var_94_4.execute_func()
					self._control.bg.info_bg.round_about_lock_enemy_txt:SetActive(false)
					self._control.bg.info_bg.lock_enemy_bg.lock_enemy_spine:SetActive(false)
					self._control.bg.info_bg.lock_enemy_bg.round_about_spine:SetActive(true)
					self._control.bg.info_bg.lock_enemy_bg.rate_bg:SetActive(true)
					self._control.bg.info_bg.lock_enemy_bg.round_about:SetActive(true)
					self:__random_circuity(arg_94_2.monster_array)

					self._control.bg.info_bg.lock_enemy_bg.rate_bg.rate.text.text = string.format("%s%s", self._random_prob, "%")
					self._control.bg.info_bg.lock_enemy_bg.round_about.text.text = var_0_1:getNowLang("pveskipwarsuccessrate")

					self._control.bg.info_bg.lock_enemy_bg.round_about_spine.skeletonGraphic.AnimationState:SetAnimation(0, "circuitous_new", false)
					self:__toggle_enemy_info(false)
				end

				var_94_3[#var_94_3 + 1] = var_94_4
				var_94_3[#var_94_3 + 1] = {
					execute_time = (#var_94_3 + 1) * 1.5,
					execute_func = var_94_2
				}
			end

			self._time_execute_task_list = var_94_3

			var_94_0:SetAnimation(0, "lock_the_enemy", false)
			self:__show_monster_formation(arg_94_2.monster, self._control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation)
		else
			self._control.bg.info_bg.mask.canvasGroup.alpha = 0
			self._control.bg.info_bg.lock_enemy_bg.canvasGroup.alpha = 0

			self._control.bg.info_bg.lock_enemy_bg.lock_enemy_spine.skeletonGraphic.AnimationState:ClearTracks()
			self:__toggle_enemy_info(false)
		end
	end

	function arg_1_0.__show_monster_formation(arg_97_0, arg_97_1, arg_97_2, arg_97_3)
		local var_97_0 = var_0_11.find_object_by_id(arg_97_1)

		if arg_97_3 and #arg_97_3 ~= 0 then
			for iter_97_0 = #var_97_0.formation, 1, -1 do
				table.remove(var_97_0.formation, iter_97_0)
			end

			for iter_97_1, iter_97_2 in pairs(arg_97_3) do
				var_0_32(var_97_0.formation, iter_97_1, iter_97_2)
			end
		end

		if var_97_0 then
			arg_97_0._save_enemy_id = var_97_0.formation_id

			local var_97_1 = #var_97_0.formation

			for iter_97_3 = 1, 5 do
				arg_97_2[var_0_23("formation%d", iter_97_3)].canvasGroup.alpha = 0

				if iter_97_3 == var_97_0.formation_id then
					for iter_97_4 = 1, 6 do
						arg_97_2[var_0_23("formation%d", iter_97_3)][var_0_23("num%d", iter_97_4)].gameObject:SetActive(iter_97_4 == var_97_1)
					end

					arg_97_2[var_0_23("formation%d", iter_97_3)].canvasGroup.alpha = 1
				end
			end

			arg_97_0._save_enemy_name = var_97_0.title
		end

		return var_97_0
	end

	function arg_1_0:__toggle_enemy_info(arg_98_1, arg_98_2)
		if arg_98_2 and next(arg_98_2) then
			local var_98_0 = var_0_6.find_object_by_id(arg_98_2.point)

			if self._fight_type == var_0_4.fight_type.event_story then
				var_98_0 = var_0_13.find_object_by_id(arg_98_2.point)
			elseif self._fight_type == var_0_4.fight_type.ocean_attack then
				var_98_0 = ocean_map_node_config.find_object_by_id_start_node_id(arg_98_2.point, (var_0_3:get_current_ocean_map_start_point()))
			elseif self._fight_type == var_0_4.fight_type.score_attack then
				var_98_0 = var_0_19.find_object_by_id_start_node_id(arg_98_2.point, (var_0_3:get_current_score_map_start_point()))
			elseif self._fight_type == var_0_4.fight_type.war_concerto or self._fight_type == var_0_4.fight_type.war_concerto_play then
				var_98_0 = var_0_16.find_object_by_id(arg_98_2.point)
			elseif self._fight_type == var_0_4.fight_type.abyss_model_first_phase then
				var_98_0 = abyss_map_node_config.find_object_by_id(arg_98_2.point)
			elseif self._fight_type == var_0_4.fight_type.fearlessness_sea then
				var_98_0 = var_0_39.find_object_by_id(arg_98_2.point)
			elseif self._fight_type == var_0_4.fight_type.seventh then
				var_98_0 = var_0_22.find_object_by_id(arg_98_2.point)
			elseif self._fight_type == var_0_4.fight_type.eighth_attack then
				var_98_0 = gameconfig.pve_eighth_level_node_config.find_object_by_id(arg_98_2.point)
			elseif self._fight_type == var_0_4.fight_type.ninth_attack then
				var_98_0 = var_0_47.find_object_by_id_start_node_id(arg_98_2.point, (var_0_3:get_ninth_map_start_point()))
			end

			self._control.bg.info_bg.enemy_info_bg.canvasGroup.alpha = arg_98_1 and 1 or 0

			if self._control.bg.info_bg.enemy_info_bg.canvasGroup.alpha == 1 then
				self._control.bg.info_bg.enemy_info_bg.canvasGroup.interactable = true

				self._control.bg.info_bg.round_about_lock_enemy_txt:SetActive(false)
			end

			self._control.bg.info_bg.enemy_info_bg.canvasGroup.blocksRaycasts = arg_98_1

			self._control.bg.info_bg.enemy_info_bg.circuity_btn:SetActive(var_98_0.roundabout == 1)
			self._control.bg.info_bg.enemy_info_bg.circuity_img:SetActive(var_98_0.roundabout == 1)
			self._control.bg.info_bg.enemy_info_bg.circuity_random:SetActive(var_98_0.roundabout == 1)
			self._control.bg.info_bg.enemy_info_bg.s_circuity:SetActive(var_98_0.roundabout == 1)

			self._save_enemy_array = self:__show_monster_formation(arg_98_2.monster, self._control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation, arg_98_2.monster_array).formation
			self._save_node_roundabout = false

			if self._have_bvr_ship then
				if not self:__special_situation_ss() then
					self._control.bg.info_bg.enemy_info_bg.bvr_btn:SetActive(true)
				end

				if var_98_0.roundabout == 1 then
					self._save_node_roundabout = true
					self._control.bg.info_bg.enemy_info_bg.bvr_btn.transform.localPosition = var_0_27.New(self._now_btn_pos.x - 380, self._now_btn_pos.y, self._now_btn_pos.z)
				else
					self._control.bg.info_bg.enemy_info_bg.bvr_btn.transform.localPosition = var_0_27.New(self._now_btn_pos.x - 194, self._now_btn_pos.y, self._now_btn_pos.z)
				end
			end

			if arg_98_1 and var_98_0.roundabout == 1 then
				if not self._random then
					self:__random_circuity(arg_98_2.monster_array)
				end

				self._control.bg.info_bg.enemy_info_bg.circuity_random.text.text = string.format("%s%s", self._random_prob, "%")
				self._control.bg.info_bg.enemy_info_bg.circuity_random.text.color = self._random_prob == 100 and var_0_28.New(1, 0.8705882352941177, 0.2784313725490196, 1) or var_0_28.New(0.7137254901960784, 0.7176470588235294, 0.7254901960784313, 1)
			elseif arg_98_1 and not var_98_0.roundabout then
				-- block empty
			elseif not self._random then
				self:__random_circuity(arg_98_2.monster_array)
			end
		else
			self._control.bg.info_bg.enemy_info_bg.bvr_btn:SetActive(false)
			self._control.bg.info_bg.enemy_info_bg.circuity_btn:SetActive(false)
			self._control.bg.info_bg.enemy_info_bg.circuity_img:SetActive(false)
			self._control.bg.info_bg.enemy_info_bg.circuity_random:SetActive(false)
			self._control.bg.info_bg.enemy_info_bg.s_circuity:SetActive(false)

			self._control.bg.info_bg.enemy_info_bg.canvasGroup.interactable = false
		end

		if arg_98_1 and arg_98_2 and next(arg_98_2) then
			self._control.bg.info_bg.enemy_info_bg.radar_frame.radar_effect1.dOTweenAnimation:DORestart()
			self._control.bg.info_bg.enemy_info_bg.radar_frame.radar_effect2.dOTweenAnimation:DORestart()

			local var_98_1 = self:__show_monster_formation(arg_98_2.monster, self._control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation, arg_98_2.monster_array)

			if not var_98_1 then
				return
			end

			self._save_enemy_array = var_98_1.formation
			self._control.bg.info_bg.enemy_info_bg.enemy_info_txt.text.text = nil
			self._control.bg.info_bg.enemy_info_bg.s_enemy_info.text.text = var_0_1:getNowLang("warenemy") .. "-" .. var_0_1:getNowLang(var_0_23("warformation%s", var_98_1.formation_id))

			for iter_98_0, iter_98_1 in ipairs(var_98_1.formation) do
				local var_98_2 = var_0_12.find_object_by_id(iter_98_1)
				local var_98_3, var_98_4 = self:loadUIPrefab("fight_info_item", self._control.bg.info_bg.enemy_info_bg.enemy_list.rectTransform)

				var_98_3:setVisible(true)

				var_98_4.bg.ship_flag.image.enabled = iter_98_0 == 1
				var_98_4.bg.ship_type.text.text = var_0_1:getNowLang(var_0_4:get_ship_type_language_key(var_98_2.type, 1))

				local var_98_5 = self:loadSprite(var_0_4:get_ship_icon(var_0_4.ship_icon.model_normal_s, var_98_2.pic_id))

				if var_98_5 then
					var_98_4.bg.ship_icon.image.sprite = var_98_5
				end

				local var_98_6

				do
					var_98_4.bg.ship_icon.image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.ship_icon.model_normal_s, 1))
					var_98_6 = var_98_4.bg.image
				end

				var_98_6.sprite = self:loadSprite(var_0_4.ship_attrib_bg[var_98_2.star == 0 and 6 or var_98_2.star])
			end

			self:__get_new_guide_state_info(1)
		end
	end

	function arg_1_0:__toggle_lost_enemy(arg_99_1)
		if arg_99_1 then
			self._control.bg.info_bg.lost_enemy_bg.title.text.text = var_0_1:getNowLang("warscene1seachfail")
			self._control.bg.info_bg.lost_enemy_bg.canvasGroup.alpha = 1

			self._control.bg.info_bg.lost_enemy_bg.radar_frame.radar_effect1.dOTweenAnimation:DORestart()
			self._control.bg.info_bg.lost_enemy_bg.radar_frame.radar_effect2.dOTweenAnimation:DORestart()

			local var_99_0 = {}
			local var_99_1 = {}

			var_99_1.execute_time = 1

			function var_99_1.execute_func()
				self._control.bg.info_bg.lost_enemy_bg.canvasGroup.alpha = 0
				self._control.bg.info_bg.mask.canvasGroup.alpha = 0

				self._control.bg.info_bg.round_about_lock_enemy_txt:SetActive(false)

				if self:__ship_count_in_team_check() then
					self:__toggle_select_formation(true)
				else
					self:__select_formation(1)
				end
			end

			var_99_0[#var_99_0 + 1] = var_99_1
			self._time_execute_task_list = var_99_0
		else
			self._control.bg.info_bg.lost_enemy_bg.canvasGroup.alpha = 0
			self._control.bg.info_bg.mask.canvasGroup.alpha = 0
		end
	end

	function arg_1_0:__ship_count_in_team_check()
		if self._fight_type == var_0_4.fight_type.abyss_model_first_phase and self.is_abyss_team then
			return #(var_0_3:get_abyss_team_info() or {}) >= 4
		end

		if not self._team_detail_data then
			return false
		end

		return #self._team_detail_data >= 4
	end

	function arg_1_0:__toggle_select_formation(arg_102_1)
		if arg_102_1 then
			for iter_102_0 = 1, 5 do
				local var_102_0 = var_0_1:getNowLang(var_0_23("warformationdesc%d_2", iter_102_0))
				local var_102_1 = self._control.bg.info_bg.select_formation.right_widget[var_0_23("select%d", iter_102_0)]

				var_102_1.desc_mask.textScroller:SetText((var_0_1:getNowLang(var_0_23("warformationdesc%d", iter_102_0))))
				var_102_1.detail_mask.textScroller:SetText(var_102_0)

				for iter_102_1 = 4, 6 do
					if #self._team_detail_data == iter_102_1 then
						var_102_1[var_0_23("formation%s", iter_102_1)]:SetActive(true)
					else
						var_102_1[var_0_23("formation%s", iter_102_1)]:SetActive(false)
					end
				end
			end

			if next(self._team_detail_data) then
				local var_102_2 = self._team_detail_data[1].config
				local var_102_3 = self._team_detail_data[1].config.pic_id
				local var_102_4 = var_0_34.little_clone(self._team_detail_data[1].data)
				local var_102_5 = var_0_8.find_object_by_cid(var_102_4.cid)

				if self._fight_type ~= var_0_4.fight_type.event_story then
					var_102_4.hp = var_0_34:get_ship_attr(var_102_4, var_102_5).hp
				end

				local var_102_6
				local var_102_7 = var_0_9.find_object_by_cid(var_102_4.skin)
				local var_102_8 = var_102_4.now_hp / var_102_4.hp < var_0_4.health_sprite_rule.yellow.max_value
				local var_102_9 = false

				if var_102_5.battle_pic == 1 and not var_102_8 then
					if var_102_7 and var_102_7.battle_pic ~= 1 then
						var_102_6 = var_0_34:use_big_break_painting(var_102_4, var_0_4.ship_icon_type.model_l, true)
					else
						var_102_9 = true
						var_102_6 = var_0_34:use_big_break_painting(var_102_4, var_0_4.ship_icon_type.model_l, true, true)
					end
				elseif var_102_7 and var_102_7.battle_pic == 1 and not var_102_8 then
					var_102_9 = true
					var_102_6 = var_0_34:use_big_break_painting(var_102_4, var_0_4.ship_icon_type.model_l, true, true)
				else
					var_102_6 = var_0_34:use_big_break_painting(var_102_4, var_0_4.ship_icon_type.model_l, true)
				end

				local var_102_11, var_102_12 = self:loadSprite(var_102_7 and var_0_23(var_102_6, var_102_7.skin_id, var_102_7.skin_id) or var_0_23(var_102_6, var_102_3, var_102_3), var_102_9)

				self._control.bg.info_bg.select_formation.left_widget.first_ship_pic.image.sprite = var_102_11
				self._save_have_hd_sprite = var_102_12

				if var_102_12 then
					var_0_4:hd_sprite_half_scale(self._control.bg.info_bg.select_formation.left_widget.first_ship_pic.transform)
				end

				self._control.bg.info_bg.select_formation.left_widget.word_bg.first_ship_name.text.text = var_102_4.name or var_102_2.title
				self._control.bg.info_bg.select_formation.left_widget.word_bg.first_ship_word.text.text = (not var_102_2.formation_dialogue or var_102_2.formation_dialogue == tostring(0) or var_102_2.formation_dialogue == "") and var_0_1:getNowLang("pveselectformation") or var_102_7 and var_102_7.formation_dialogue and var_102_7.formation_dialogue ~= "" and var_102_7.formation_dialogue or var_102_2.formation_dialogue

				local var_102_14 = 0.3
				local var_102_15 = self._from_home and 0.2 or 0

				self._control.bg.info_bg.select_formation.left_widget.rectTransform.anchoredPosition = var_0_26(-800, 0)

				self._control.bg.info_bg.select_formation.left_widget.rectTransform:DOAnchorPos(var_0_26(0, 0), var_102_14):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(var_102_15):SetAutoKill(true)

				self._control.bg.info_bg.select_formation.right_widget.rectTransform.anchoredPosition = var_0_26(800, 0)

				self._control.bg.info_bg.select_formation.right_widget.rectTransform:DOAnchorPos(var_0_26(0, 0), var_102_14):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(var_102_15):SetAutoKill(true)

				local var_102_16
				local var_102_17

				if var_102_7 and var_102_7.cv_id then
					var_102_17 = var_102_7.cv_id
				end

				var_102_16 = var_102_17 and var_102_17 ~= 0 and var_102_17 ~= "0" and var_102_17 or var_102_3

				self:playCV(var_0_23("%s/%s_formation.mp3", var_102_16, var_102_16), false, "cv")
			end

			self._control.bg.info_bg.enemy_info_bg.canvasGroup.alpha = 0
			self._control.bg.info_bg.select_formation.mask.image.enabled = true
			self._control.bg.info_bg.select_formation.canvasGroup.alpha = 1
			self._control.bg.info_bg.select_formation.canvasGroup.blocksRaycasts = true
		else
			if self._fight_type == var_0_4.fight_type.event_story then
				return
			end

			self._control.bg.info_bg.select_formation.mask.image.enabled = false
			self._control.bg.info_bg.select_formation.canvasGroup.alpha = 0
			self._control.bg.info_bg.select_formation.canvasGroup.blocksRaycasts = false
		end
	end

	function arg_1_0:__select_formation(arg_103_1)
		if self._formation_selected then
			return
		end

		self._formation_selected = true
		self._formation_id = arg_103_1

		var_0_3:set_formation_id(self._formation_id)

		if self._fight_type == var_0_4.fight_type.event_story then
			var_0_2:createInstance("loading"):show(true)
			self:__start_battle_wihtout_server()
		else
			var_0_3:req_StartBattleReq(arg_103_1, var_0_3:get_strong_buff_list())
			var_0_3:set_battle_type(self._fight_type)
		end

		local var_103_0 = 0.3
		local var_103_1 = self._from_home and 0.2 or 0

		self._control.bg.info_bg.select_formation.left_widget.rectTransform.anchoredPosition = var_0_26(0, 0)

		self._control.bg.info_bg.select_formation.left_widget.rectTransform:DOAnchorPos(var_0_26(-800, 0), var_103_0):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(var_103_1):SetAutoKill(true)

		self._control.bg.info_bg.select_formation.right_widget.rectTransform.anchoredPosition = var_0_26(0, 0)
		self._control.bg.info_bg.select_formation.right_widget.rectTransform:DOAnchorPos(var_0_26(1000, 0), var_103_0):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(var_103_1):SetAutoKill(true).onComplete = function()
			self:__toggle_select_formation(false)

			self._formation_selected = false
		end
	end

	function arg_1_0:__start_battle_wihtout_server()
		local var_105_0 = {}
		local var_105_1 = {
			type = 5,
			monster = self.now_monster,
			battle_time = {
				speed = 1,
				frame_interval = 16.66667
			}
		}

		var_105_1.random = lan_random.create():serialize()
		var_105_1.point = self.now_node
		var_105_1.formation = self._formation_id
		var_105_0.battle_data = var_105_1
		self._battle_data = var_105_0

		var_0_3:set_battle_info_whithout_server({
			type = gameenum.battle_type.fight_type.plot_main,
			point = self.now_node,
			id = self._map_id,
			map_id = self._bg_id
		})
		var_0_3:set_battle_data_whithout_server(self._battle_data.battle_data)
		self:__start_battle_response(self._battle_data.battle_data)
	end

	function arg_1_0:__add_speed_by_buff_skill(arg_106_1, arg_106_2, arg_106_3, arg_106_4, arg_106_5)
		local var_106_0

		if arg_106_4 then
			var_106_0 = var_0_3:find_character_by_id(arg_106_4[arg_106_3])
		end

		if arg_106_5 then
			var_106_0 = arg_106_5[arg_106_3].data
		end

		local var_106_1 = var_0_10.find_object_by_skill_type_skill_level(var_106_0.now_skill, var_106_0.skill_level)

		if not var_106_1 then
			return
		end

		if not var_106_1.pre_effect[1] then
			return
		end

		for iter_106_0, iter_106_1 in pairs(var_106_1.pre_effect) do
			local var_106_2 = false

			if iter_106_1.condition then
				for iter_106_2, iter_106_3 in pairs(iter_106_1.condition) do
					if iter_106_3.type == 43 then
						local var_106_3 = true

						for iter_106_4, iter_106_5 in pairs(arg_106_5) do
							if iter_106_5.data.id ~= var_106_0.id then
								for iter_106_6, iter_106_7 in pairs(iter_106_3.shipTypes) do
									if iter_106_5.data.type == iter_106_7 then
										var_106_3 = false
									end
								end
							end
						end

						var_106_2 = var_106_3
					elseif iter_106_3.type == 26 and arg_106_3 == 1 then
						var_106_2 = true
					end
				end
			else
				var_106_2 = true
			end

			if var_106_2 == false then
				return
			end

			for iter_106_8, iter_106_9 in pairs(iter_106_1.target) do
				if iter_106_9.type == 2 then
					for iter_106_10, iter_106_11 in pairs(iter_106_9.shipTypes) do
						if arg_106_1[arg_106_3 - 1] and arg_106_1[arg_106_3 - 1].type == iter_106_11 then
							self:__add_speed_by_skill_by_effect(arg_106_2, iter_106_1.effect, arg_106_3 - 1)
						end

						if arg_106_1[arg_106_3 + 1] and arg_106_1[arg_106_3 + 1].type == iter_106_11 then
							self:__add_speed_by_skill_by_effect(arg_106_2, iter_106_1.effect, arg_106_3 + 1)
						end
					end
				elseif iter_106_9.type == 4 then
					for iter_106_12, iter_106_13 in pairs(arg_106_1) do
						if iter_106_12 < arg_106_3 and iter_106_12 >= arg_106_3 - iter_106_9.num then
							self:__add_speed_by_skill_by_effect(arg_106_2, iter_106_1.effect, iter_106_12)
						end
					end
				elseif iter_106_9.type == 7 then
					self:__add_speed_by_skill_by_effect(arg_106_2, iter_106_1.effect, arg_106_3)
				elseif iter_106_9.type == 8 then
					for iter_106_14, iter_106_15 in pairs(arg_106_1) do
						self:__add_speed_by_skill_by_effect(arg_106_2, iter_106_1.effect, iter_106_14)
					end
				elseif iter_106_9.type == 10 then
					for iter_106_16, iter_106_17 in pairs(arg_106_1) do
						local var_106_4 = var_0_8.find_object_by_cid(iter_106_17.cid)

						if var_106_4 then
							for iter_106_18, iter_106_19 in pairs(iter_106_9.country) do
								if var_106_4.country == iter_106_19 then
									self:__add_speed_by_skill_by_effect(arg_106_2, iter_106_1.effect, iter_106_16)
								end
							end
						end
					end
				elseif iter_106_9.type == 11 or iter_106_9.type == 12 then
					for iter_106_20, iter_106_21 in pairs(arg_106_1) do
						local var_106_5 = var_0_8.find_object_by_cid(iter_106_21.cid)

						if var_106_5 then
							local var_106_6 = false

							for iter_106_22, iter_106_23 in pairs(iter_106_9.shipTypes or {}) do
								if var_106_5.type == iter_106_23 then
									var_106_6 = true

									break
								end
							end

							if not var_106_6 then
								for iter_106_24, iter_106_25 in pairs(iter_106_9.shipTons or {}) do
									if var_106_5.ship_ton == iter_106_25 then
										var_106_6 = true

										break
									end
								end
							end

							if not var_106_6 then
								for iter_106_26, iter_106_27 in pairs(iter_106_9.guardTypes or {}) do
									if var_106_5.guard_type == iter_106_27 then
										var_106_6 = true

										break
									end
								end
							end

							local var_106_9 = true

							if iter_106_9.type == 12 then
								var_106_9 = false

								for iter_106_28, iter_106_29 in pairs(iter_106_9.country or {}) do
									if var_106_5.country == iter_106_29 then
										var_106_9 = true

										break
									end
								end
							end

							if var_106_6 and var_106_9 then
								self:__add_speed_by_skill_by_effect(arg_106_2, iter_106_1.effect, iter_106_20)
							end
						end
					end
				end
			end
		end
	end

	function arg_1_0:__add_attr_by_skill(arg_107_1, arg_107_2, arg_107_3)
		if arg_107_1 then
			local var_107_0 = var_0_10.find_object_by_skill_type_skill_level(arg_107_1.data.now_skill, arg_107_1.data.skill_level)

			if var_107_0 and var_107_0.effect then
				for iter_107_0, iter_107_1 in pairs(var_107_0.effect) do
					if var_107_0.effect[iter_107_0].type == 1 and var_107_0.effect[iter_107_0].stage[1] == 1 then
						for iter_107_2, iter_107_3 in pairs(iter_107_1.effect) do
							if iter_107_3.type == 131 then
								local var_107_1

								if arg_107_2[self._detail_attr_table[iter_107_3.attribute]] then
									var_107_1 = var_0_34.attr_impact_by_speed(arg_107_2.speed, arg_107_2[self._detail_attr_table[iter_107_3.attribute]], iter_107_3.num1, iter_107_3.num2) - arg_107_2[self._detail_attr_table[iter_107_3.attribute]]
								end

								if var_107_1 then
									arg_107_3[self._detail_attr_table[iter_107_3.attribute]] = arg_107_3[self._detail_attr_table[iter_107_3.attribute]] + var_107_1
								end
							end
						end
					end
				end
			end
		end

		return arg_107_2
	end

	function arg_1_0.__add_speed_by_skill_by_effect(arg_108_0, arg_108_1, arg_108_2, arg_108_3)
		for iter_108_0, iter_108_1 in pairs(arg_108_2) do
			if iter_108_1.type == 3 and iter_108_1.speed then
				arg_108_1[arg_108_3].speed_num = arg_108_1[arg_108_3].speed_num + iter_108_1.speed
				arg_108_1[arg_108_3].add_by_skill = true
			end
		end
	end

	function arg_1_0:__random_circuity(arg_109_1)
		local var_109_0 = self:__get_node_by_id(self._next_move_node_data.id)
		local var_109_1 = {}

		for iter_109_0, iter_109_1 in pairs(arg_109_1) do
			var_0_32(var_109_1, (var_0_12.find_object_by_id(iter_109_1)))
		end

		local var_109_3 = {}
		local var_109_4 = {}
		local var_109_5 = var_0_3:get_battle_info()

		if self._team_detail_data and self._team_detail_data.members then
			for iter_109_2, iter_109_3 in pairs(self._team_detail_data.members) do
				local var_109_6 = var_0_3:find_character_by_id(iter_109_3)
				local var_109_7 = var_0_8.find_object_by_cid(var_109_6.cid)

				var_0_32(var_109_3, var_109_7)

				var_109_4[iter_109_2] = {
					add_by_skill = false,
					speed_num = var_0_34:get_ship_attr(var_109_6, var_109_7).speed
				}
			end
		end

		if #var_109_3 == 0 and self._team_detail_data and not self._team_detail_data.members then
			for iter_109_4, iter_109_5 in pairs(self._team_detail_data) do
				var_0_32(var_109_3, iter_109_5.config)

				var_109_4[iter_109_4] = {
					add_by_skill = false,
					speed_num = var_0_34:get_ship_attr(iter_109_5.data, iter_109_5.config).speed
				}
			end
		end

		self._circuity_rate = 0

		for iter_109_6, iter_109_7 in pairs(var_109_3) do
			self:__add_speed_by_buff_skill(var_109_3, var_109_4, iter_109_6, self._team_detail_data.members, self._team_detail_data)
			self:__add_circuity_rate_by_buff_skill(iter_109_6, self._team_detail_data.members, self._team_detail_data)
		end

		local var_109_9 = self:__get_avg_speed(var_109_3, false, var_109_4)
		local var_109_10 = self:__get_avg_speed(var_109_1, true)

		var_109_9 = tostring(var_109_9) == "nan" and 0 or var_109_9
		var_109_10 = tostring(var_109_10) == "nan" and 0 or var_109_10

		local var_109_11 = math.pow(2, (var_109_9 - var_109_10) / 5) / 2 - 0.2

		var_109_11 = var_109_11 < 0.05 and 0.05 or var_109_11
		var_109_11 = var_109_11 > 0.95 and 0.95 or var_109_11

		if self._circuity_rate ~= 0 then
			var_109_11 = var_109_11 + self._circuity_rate

			if var_109_11 > 1 then
				var_109_11 = 1
			end
		end

		self._random_prob = var_0_31(var_109_11 * 100)
		self._random = lan_rand(1, 100)
	end

	function arg_1_0:__add_circuity_rate_by_buff_skill(arg_110_1, arg_110_2, arg_110_3)
		local var_110_0

		if arg_110_2 then
			var_110_0 = var_0_3:find_character_by_id(arg_110_2[arg_110_1])
		end

		if arg_110_3 then
			var_110_0 = arg_110_3[arg_110_1].data
		end

		local var_110_1 = var_0_10.find_object_by_skill_type_skill_level(var_110_0.now_skill, var_110_0.skill_level)

		if not var_110_1 then
			return
		end

		if var_110_1 and next(var_110_1) and var_110_1.circuity and var_110_1.circuity ~= 0 then
			self._circuity_rate = self._circuity_rate + var_110_1.circuity / 100
		end
	end

	function arg_1_0.getFleetSpeed(arg_111_0, arg_111_1, arg_111_2)
		local var_111_0 = 0
		local var_111_1 = 0
		local var_111_2 = 0
		local var_111_3 = 0
		local var_111_4 = 0
		local var_111_5 = 0
		local var_111_6 = true
		local var_111_7 = 0
		local var_111_8 = 0
		local var_111_9 = 0
		local var_111_10 = {}
		local var_111_11 = {}

		if arg_111_2 then
			for iter_111_0, iter_111_1 in pairs(arg_111_1) do
				for iter_111_2, iter_111_3 in pairs(var_0_4.maip_ship_type) do
					if iter_111_1.type == iter_111_3 then
						var_0_32(var_111_10, iter_111_1)
					end
				end

				for iter_111_4, iter_111_5 in pairs(var_0_4.protect_ship_type) do
					if iter_111_1.type == iter_111_5 then
						var_0_32(var_111_11, iter_111_1)
					end
				end
			end
		else
			for iter_111_6, iter_111_7 in pairs(arg_111_1) do
				if iter_111_7.guard_type == var_0_4.guard_type.main_ship then
					var_0_32(var_111_10, iter_111_7)
				elseif iter_111_7.guard_type == var_0_4.guard_type.protect_ship then
					var_0_32(var_111_11, iter_111_7)
				end
			end
		end

		if not next(var_111_10) and not next(var_111_11) then
			for iter_111_8, iter_111_9 in pairs(var_111_10) do
				if var_0_48[iter_111_9.type] then
					tw = var_0_48[iter_111_9.type]
					var_111_0 = var_111_0 + tw
					var_111_6 = false
					var_111_1 = tw
				elseif var_0_49[iter_111_9.type] then
					tw = var_0_49[iter_111_9.type]
					var_111_2 = var_111_2 + tw
					var_111_6 = false
					var_111_3 = tw
				elseif var_0_50[iter_111_9.type] then
					tw = var_0_50[iter_111_9.type]
					var_111_4 = var_111_4 + tw
					var_111_5 = tw
				end
			end

			if var_111_6 then
				var_111_8 = var_0_31(var_111_4 / var_111_5)
			else
				local var_111_12 = 0
				local var_111_13 = 0

				if var_111_0 > 0 then
					var_111_12 = var_111_0 / var_111_1
					var_111_8 = var_111_0 / var_111_1
				end

				if var_111_2 > 0 then
					var_111_13 = var_111_2 / var_111_3
					var_111_8 = var_111_2 / var_111_3
				end

				if var_111_0 > 0 and var_111_2 > 0 then
					var_111_8 = var_0_31(var_111_12 < var_111_13 and var_111_12 or var_111_13)
				end
			end

			var_111_0 = 0
			var_111_1 = 0
			var_111_2 = 0
			var_111_3 = 0
			var_111_4 = 0
			var_111_5 = 0
			var_111_6 = true

			for iter_111_10, iter_111_11 in pairs(var_111_11) do
				if var_0_48[iter_111_11.type] then
					tw = var_0_48[iter_111_11.type]
					var_111_0 = var_111_0 + tw
					var_111_6 = false
					var_111_1 = tw
				elseif var_0_49[iter_111_11.type] then
					tw = var_0_49[iter_111_11.type]
					var_111_2 = var_111_2 + tw
					var_111_6 = false
					var_111_3 = tw
				elseif var_0_50[iter_111_11.type] then
					tw = var_0_50[iter_111_11.type]
					var_111_4 = var_111_4 + tw
					var_111_5 = tw
				end
			end

			if var_111_6 then
				var_111_9 = var_0_31(var_111_4 / var_111_5)
			else
				local var_111_14 = 0
				local var_111_15 = 0

				if var_111_0 > 0 then
					var_111_14 = var_111_0 / var_111_1
					var_111_9 = var_111_0 / var_111_1
				end

				if var_111_2 > 0 then
					var_111_15 = var_111_2 / var_111_3
					var_111_9 = var_111_2 / var_111_3
				end

				if var_111_0 > 0 and var_111_2 > 0 then
					var_111_9 = var_0_31(var_111_14 < var_111_15 and var_111_14 or var_111_15)
				end
			end

			var_111_7 = var_111_9 < var_111_8 and var_111_9 or var_111_8
		else
			for iter_111_12, iter_111_13 in pairs(arg_111_1) do
				if var_0_48[iter_111_13.type] then
					tw = var_0_48[iter_111_13.type]
					var_111_0 = var_111_0 + tw
					var_111_6 = false
					var_111_1 = tw
				elseif var_0_49[iter_111_13.type] then
					tw = var_0_49[iter_111_13.type]
					var_111_2 = var_111_2 + tw
					var_111_6 = false
					var_111_3 = tw
				elseif var_0_50[iter_111_13.type] then
					tw = var_0_50[iter_111_13.type]
					var_111_4 = var_111_4 + tw
					var_111_5 = tw
				end
			end

			if var_111_6 then
				var_111_7 = var_0_31(var_111_4 / var_111_5)
			else
				local var_111_16 = 0
				local var_111_17 = 0

				if var_111_0 > 0 then
					var_111_16 = var_111_0 / var_111_1
					var_111_7 = var_111_0 / var_111_1
				end

				if var_111_2 > 0 then
					var_111_17 = var_111_2 / var_111_3
					var_111_7 = var_111_2 / var_111_3
				end

				if var_111_0 > 0 and var_111_2 > 0 then
					var_111_7 = var_0_31(var_111_16 < var_111_17 and var_111_16 or var_111_17)
				end
			end
		end

		return var_111_7
	end

	function arg_1_0.__get_avg_speed(arg_112_0, arg_112_1, arg_112_2, arg_112_3)
		local var_112_0 = 0
		local var_112_1 = 0
		local var_112_2 = 0
		local var_112_3 = 0
		local var_112_4 = 0
		local var_112_5 = 0
		local var_112_6 = 1
		local var_112_7 = 0
		local var_112_8 = 0
		local var_112_9 = 0

		for iter_112_0, iter_112_1 in pairs(arg_112_1) do
			local var_112_10, var_112_11 = var_0_4:get_avg_speed_class(iter_112_1.type)

			if arg_112_2 then
				-- block empty
			end

			if var_112_10 == "class1" then
				var_112_0 = arg_112_2 and var_112_0 + var_112_11 * iter_112_1.speed or var_112_0 + var_112_11 * arg_112_3[iter_112_0].speed_num
				var_112_1 = var_112_1 + var_112_11
				var_112_6 = 0
			elseif var_112_10 == "class2" then
				var_112_2 = arg_112_2 and var_112_2 + var_112_11 * iter_112_1.speed or var_112_2 + var_112_11 * arg_112_3[iter_112_0].speed_num
				var_112_3 = var_112_3 + var_112_11
				var_112_6 = 0
			elseif var_112_10 == "class3" then
				var_112_4 = arg_112_2 and var_112_4 + var_112_11 * iter_112_1.speed or var_112_4 + var_112_11 * arg_112_3[iter_112_0].speed_num
				var_112_5 = var_112_5 + var_112_11
			end
		end

		if var_112_6 == 1 then
			var_112_7 = math.floor(var_112_4 / var_112_5)
		else
			if var_112_0 ~= 0 then
				var_112_8 = var_112_0 / var_112_1
				var_112_7 = var_112_0 / var_112_1
			end

			if var_112_2 ~= 0 then
				var_112_9 = var_112_2 / var_112_3
				var_112_7 = var_112_2 / var_112_3
			end

			if var_112_8 ~= 0 and var_112_9 ~= 0 then
				var_112_7 = math.floor(math.min(var_112_8, var_112_9))
			end
		end

		return var_112_7
	end

	function arg_1_0:__start_battle_response(arg_113_1)
		self:set_guide_fight_state()

		local var_113_0 = {}
		local var_113_1 = {
			can_not_skip = true
		}

		var_113_1.execute_time = 0.5

		function var_113_1.execute_func()
			self._control.bg.info_bg.consume_bg.canvasGroup.alpha = 0

			var_0_30:loadScene(var_0_4:get_battle_scene_name(), function()
				self:__reset_panel()
				var_0_2:destroyStateUISet("game")
				var_0_2:createInstance(var_0_4:get_battle_name()):show(self._fight_type)
			end)
		end

		var_113_0[#var_113_0 + 1] = var_113_1
		self._time_execute_task_list = var_113_0

		self._control.bg.info_bg.enemy_info_bg.circuity_btn:SetActive(false)
		self._control.bg.info_bg.enemy_info_bg.back_btn:SetActive(false)
	end

	function arg_1_0:__select_hide_node_list()
		local var_116_0 = {}

		for iter_116_0, iter_116_1 in ipairs(self._map_node_data) do
			if iter_116_1.node_miss and next(iter_116_1.node_miss) then
				for iter_116_2, iter_116_3 in pairs(iter_116_1.node_miss) do
					var_0_32(var_116_0, {
						hide_start_point = iter_116_1.id,
						hide_end_point = iter_116_2,
						hide_result = iter_116_3
					})
				end
			end
		end

		return var_116_0
	end

	function arg_1_0:__select_hide_node_list_2()
		local var_117_0 = {}

		for iter_117_0, iter_117_1 in ipairs(self._map_node_data) do
			if iter_117_1.node_miss_2 and next(iter_117_1.node_miss_2) then
				for iter_117_2, iter_117_3 in pairs(iter_117_1.node_miss_2) do
					var_0_32(var_117_0, {
						hide_start_point = iter_117_1.id,
						hide_end_point = iter_117_2,
						hide_result = iter_117_3
					})
				end
			end
		end

		return var_117_0
	end

	function arg_1_0.__get_map_node_path_by_sixth_year(arg_118_0, arg_118_1)
		local var_118_0

		if arg_118_1.node_type == 1 then
			var_118_0 = var_0_4.sixth_map_node_icon.sixth_point_white
		elseif arg_118_1.node_type == 2 then
			var_118_0 = var_0_4.sixth_map_node_icon.sixth_boss_white
		elseif arg_118_1.node_type == 4 then
			var_118_0 = var_0_4.sixth_map_node_icon.sixth_start_white
		end

		return var_118_0
	end

	function arg_1_0.__get_map_node_path_by_seventh_year(arg_119_0, arg_119_1)
		local var_119_0
		local var_119_1 = var_0_3:is_pass_seventh_map_node(arg_119_1.pve_level_id, arg_119_1.id)
		local var_119_2 = var_0_3:is_cur_seventh_map_node_pass(arg_119_1.pve_level_id, arg_119_1.id)

		if arg_119_1.support_icon and arg_119_1.support_icon ~= 0 then
			var_119_0 = string.format((var_119_1 ~= false or nil) and (var_0_4.fight_point.support_icon_path_red or var_0_4.fight_point.support_icon_path_white), gameconfig.support_atk_config.find_object_by_id(arg_119_1.support_icon).type)
		elseif arg_119_1.node_attribute == var_0_4.map_node_finish_type.init then
			var_119_0 = var_0_4.fight_point.pve_start_l
		elseif arg_119_1.node_attribute == var_0_4.map_node_finish_type.boss_finish then
			var_119_0 = var_119_1 and var_0_4.fight_point.pve_boss_l or var_0_4.fight_point.pve_boss
		elseif arg_119_1.node_type == var_0_4.map_node_type.reward then
			var_119_0 = var_119_1 and var_0_4.fight_point.pve_green or var_0_4.fight_point.pve_white
		elseif arg_119_1.node_type == var_0_4.map_node_type.loss then
			var_119_0 = var_119_1 and var_0_4.fight_point.pve_purple or var_0_4.fight_point.pve_white
		elseif arg_119_1.node_type == var_0_4.map_node_type.null then
			var_119_0 = var_119_1 and var_0_4.fight_point.pve_blue or var_0_4.fight_point.pve_white
		elseif arg_119_1.node_type == var_0_4.map_node_type.little_boss then
			var_119_0 = var_119_1 and var_0_4.fight_point.pve_small_boss_l or var_0_4.fight_point.pve_small_boss
		else
			var_119_0 = var_119_2 and var_0_4.fight_point.pve_red or var_0_4.fight_point.pve_white
			var_119_0 = var_119_2 and var_0_4.fight_point.pve_red or var_0_4.fight_point.pve_white
		end

		return var_119_0
	end

	function arg_1_0.__get_map_node_path_by_eighth_year(arg_120_0, arg_120_1)
		local var_120_0
		local var_120_1 = var_0_3:is_pass_eighth_map_node(arg_120_1.pve_level_id, arg_120_1.id)
		local var_120_2 = var_0_3:is_cur_eighth_map_node_pass(arg_120_1.pve_level_id, arg_120_1.id)

		if arg_120_1.support_icon and arg_120_1.support_icon ~= 0 then
			var_120_0 = string.format((var_120_1 ~= false or nil) and (var_0_4.fight_point.support_icon_path_red or var_0_4.fight_point.support_icon_path_white), gameconfig.support_atk_config.find_object_by_id(arg_120_1.support_icon).type)
		elseif arg_120_1.node_attribute == var_0_4.map_node_finish_type.init then
			var_120_0 = var_0_4.fight_point.pve_start_l
		elseif arg_120_1.node_attribute == var_0_4.map_node_finish_type.boss_finish then
			var_120_0 = var_120_1 and var_0_4.fight_point.pve_boss_l or var_0_4.fight_point.pve_boss
		elseif arg_120_1.node_type == var_0_4.map_node_type.reward then
			var_120_0 = var_120_1 and var_0_4.fight_point.pve_green or var_0_4.fight_point.pve_white
		elseif arg_120_1.node_type == var_0_4.map_node_type.loss then
			var_120_0 = var_120_1 and var_0_4.fight_point.pve_purple or var_0_4.fight_point.pve_white
		elseif arg_120_1.node_type == var_0_4.map_node_type.null then
			var_120_0 = var_120_1 and var_0_4.fight_point.pve_blue or var_0_4.fight_point.pve_white
		elseif arg_120_1.node_type == var_0_4.map_node_type.little_boss then
			var_120_0 = var_120_1 and var_0_4.fight_point.pve_small_boss_l or var_0_4.fight_point.pve_small_boss
		else
			var_120_0 = var_120_2 and var_0_4.fight_point.pve_red or var_0_4.fight_point.pve_white
			var_120_0 = var_120_2 and var_0_4.fight_point.pve_red or var_0_4.fight_point.pve_white
		end

		return var_120_0
	end

	function arg_1_0.__get_map_node_path_by_ocean(arg_121_0, arg_121_1, arg_121_2, arg_121_3)
		local var_121_0

		if arg_121_1.node_attribute == var_0_4.map_node_finish_type.init then
			var_121_0 = var_0_4.fight_point.pve_start_l
		elseif arg_121_1.node_attribute == var_0_4.map_node_finish_type.boss_finish then
			var_121_0 = var_0_3:is_ocean_map_node_pass(arg_121_1.start_node_id, arg_121_1.id) and var_0_4.fight_point.pve_boss_l or var_0_4.fight_point.pve_boss
		elseif arg_121_1.node_type == var_0_4.map_node_type.reward then
			var_121_0 = var_0_3:is_ocean_map_node_pass(arg_121_1.start_node_id, arg_121_1.id) and var_0_4.fight_point.pve_green or var_0_4.fight_point.pve_white
		elseif arg_121_1.node_type == var_0_4.map_node_type.loss then
			var_121_0 = var_0_3:is_ocean_map_node_pass(arg_121_1.start_node_id, arg_121_1.id) and var_0_4.fight_point.pve_purple or var_0_4.fight_point.pve_white
		elseif arg_121_1.node_type == var_0_4.map_node_type.null then
			var_121_0 = var_0_3:is_ocean_map_node_pass(arg_121_1.start_node_id, arg_121_1.id) and var_0_4.fight_point.pve_blue or var_0_4.fight_point.pve_white
		else
			var_121_0 = var_0_3:is_ocean_map_node_pass(arg_121_1.start_node_id, arg_121_1.id) and var_0_4.fight_point.pve_red or var_0_4.fight_point.pve_white
			var_121_0 = var_0_3:is_ocean_map_node_pass(arg_121_1.start_node_id, arg_121_1.id) and var_0_4.fight_point.pve_red or var_0_4.fight_point.pve_white
		end

		return var_121_0
	end

	function arg_1_0.__get_map_node_path_by_score(arg_122_0, arg_122_1, arg_122_2, arg_122_3)
		local var_122_0
		local var_122_1 = var_0_3:is_score_map_node_pass(arg_122_1.start_node_id, arg_122_1.id)

		if arg_122_1.support_icon and arg_122_1.support_icon ~= 0 then
			var_122_0 = string.format((var_122_1 ~= false or nil) and (var_0_4.fight_point.support_icon_path_red or var_0_4.fight_point.support_icon_path_white), gameconfig.support_atk_config.find_object_by_id(arg_122_1.support_icon).type)
		elseif arg_122_1.node_attribute == var_0_4.map_node_finish_type.init then
			var_122_0 = var_0_4.fight_point.pve_start_l
		elseif arg_122_1.node_attribute == var_0_4.map_node_finish_type.boss_finish then
			var_122_0 = var_122_1 and var_0_4.fight_point.pve_boss_l or var_0_4.fight_point.pve_boss
		elseif arg_122_1.node_type == var_0_4.map_node_type.reward then
			var_122_0 = var_122_1 and var_0_4.fight_point.pve_green or var_0_4.fight_point.pve_white
		elseif arg_122_1.node_type == var_0_4.map_node_type.loss then
			var_122_0 = var_122_1 and var_0_4.fight_point.pve_purple or var_0_4.fight_point.pve_white
		elseif arg_122_1.node_type == var_0_4.map_node_type.null then
			var_122_0 = var_122_1 and var_0_4.fight_point.pve_blue or var_0_4.fight_point.pve_white
		elseif arg_122_1.node_type == var_0_4.map_node_type.little_boss then
			var_122_0 = var_122_1 and var_0_4.fight_point.pve_small_boss_l or var_0_4.fight_point.pve_small_boss
		else
			var_122_0 = var_122_1 and var_0_4.fight_point.pve_red or var_0_4.fight_point.pve_white
			var_122_0 = var_122_1 and var_0_4.fight_point.pve_red or var_0_4.fight_point.pve_white
		end

		return var_122_0
	end

	function arg_1_0.__get_map_node_path_by_ninth(arg_123_0, arg_123_1, arg_123_2, arg_123_3)
		local var_123_0
		local var_123_1 = var_0_3:is_ninth_map_node_pass(arg_123_1.start_node_id, arg_123_1.id)

		if arg_123_1.support_icon and arg_123_1.support_icon ~= 0 then
			var_123_0 = string.format((var_123_1 ~= false or nil) and (var_0_4.fight_point.support_icon_path_red or var_0_4.fight_point.support_icon_path_white), gameconfig.support_atk_config.find_object_by_id(arg_123_1.support_icon).type)
		elseif arg_123_1.node_attribute == var_0_4.map_node_finish_type.init then
			var_123_0 = var_0_4.fight_point.pve_start_l
		elseif arg_123_1.node_attribute == var_0_4.map_node_finish_type.boss_finish then
			var_123_0 = var_123_1 and var_0_4.fight_point.pve_boss_l or var_0_4.fight_point.pve_boss
		elseif arg_123_1.node_type == var_0_4.map_node_type.reward then
			var_123_0 = var_123_1 and var_0_4.fight_point.pve_green or var_0_4.fight_point.pve_white
		elseif arg_123_1.node_type == var_0_4.map_node_type.loss then
			var_123_0 = var_123_1 and var_0_4.fight_point.pve_purple or var_0_4.fight_point.pve_white
		elseif arg_123_1.node_type == var_0_4.map_node_type.null then
			var_123_0 = var_123_1 and var_0_4.fight_point.pve_blue or var_0_4.fight_point.pve_white
		elseif arg_123_1.node_type == var_0_4.map_node_type.little_boss then
			var_123_0 = var_123_1 and var_0_4.fight_point.pve_small_boss_l or var_0_4.fight_point.pve_small_boss
		else
			var_123_0 = var_123_1 and var_0_4.fight_point.pve_red or var_0_4.fight_point.pve_white
			var_123_0 = var_123_1 and var_0_4.fight_point.pve_red or var_0_4.fight_point.pve_white
		end

		return var_123_0
	end

	function arg_1_0.__get_map_node_path_by_war_concerto(arg_124_0, arg_124_1)
		local var_124_0

		if arg_124_1.node_attribute == var_0_4.map_node_finish_type.init then
			var_124_0 = var_0_4.fight_point.pve_start_l
		elseif arg_124_1.node_attribute == var_0_4.map_node_finish_type.boss_finish then
			var_124_0 = var_0_3:is_war_concerto_map_node_pass(arg_124_1.pve_level_id, arg_124_1.id) and var_0_4.fight_point.pve_boss_l or var_0_4.fight_point.pve_boss
		elseif arg_124_1.node_type == var_0_4.map_node_type.reward then
			var_124_0 = var_0_3:is_war_concerto_map_node_pass(arg_124_1.pve_level_id, arg_124_1.id) and var_0_4.fight_point.pve_green or var_0_4.fight_point.pve_white
		elseif arg_124_1.node_type == var_0_4.map_node_type.loss then
			var_124_0 = var_0_3:is_war_concerto_map_node_pass(arg_124_1.pve_level_id, arg_124_1.id) and var_0_4.fight_point.pve_purple or var_0_4.fight_point.pve_white
		elseif arg_124_1.node_type == var_0_4.map_node_type.null then
			var_124_0 = var_0_3:is_war_concerto_map_node_pass(arg_124_1.pve_level_id, arg_124_1.id) and var_0_4.fight_point.pve_blue or var_0_4.fight_point.pve_white
		else
			var_124_0 = var_0_3:is_war_concerto_map_node_pass(arg_124_1.pve_level_id, arg_124_1.id) and var_0_4.fight_point.pve_red or var_0_4.fight_point.pve_white
			var_124_0 = var_0_3:is_war_concerto_map_node_pass(arg_124_1.pve_level_id, arg_124_1.id) and var_0_4.fight_point.pve_red or var_0_4.fight_point.pve_white
		end

		return var_124_0
	end

	function arg_1_0:__set_map_node()
		self:destroyChildren("map_node_obj")
		self:destroyChildren("map_line_obj")
		self:destroyChildren("map_node_letter_obj")
		self:destroyChildren("fearlessness_sea_letter_obj")
		self:destroyChildren("ocean_boss_node_obj")

		local var_125_0 = self._control.bg.rectTransform.rect.width
		local var_125_1 = self._control.bg.rectTransform.rect.height
		local var_125_2 = self:__select_hide_node_list()
		local var_125_3 = self:__select_hide_node_list_2()
		local var_125_4 = var_0_3:get_fifth_hide_node()
		local var_125_5 = var_0_3:get_fifth_hide_route()

		self.now_node_list = {}
		self.now_line_list = {}

		if self._fight_type == var_0_4.fight_type.ocean_attack then
			local var_125_6 = var_0_3:get_ocean_map_tmp_icon_list()
			local var_125_7 = var_0_3:get_current_ocean_map_start_point()
			local var_125_8 = {}

			for iter_125_0, iter_125_1 in pairs(self._map_node_data) do
				if iter_125_1.start_node_id == var_125_7 then
					table.insert(var_125_8, iter_125_1)
				end
			end

			self._map_node_data = var_125_8
		end

		if self._fight_type == var_0_4.fight_type.score_attack then
			local var_125_9 = var_0_3:get_score_map_tmp_icon_list()
			local var_125_10 = var_0_3:get_current_score_map_start_point()
			local var_125_11 = {}

			for iter_125_2, iter_125_3 in pairs(self._map_node_data) do
				if iter_125_3.start_node_id == var_125_10 then
					table.insert(var_125_11, iter_125_3)
				end
			end

			self._map_node_data = var_125_11
		elseif self._fight_type == var_0_4.fight_type.ninth_attack then
			local var_125_12 = var_0_3:get_ninth_map_tmp_icon_list()
			local var_125_13 = var_0_3:get_ninth_map_start_point()
			local var_125_14 = {}

			for iter_125_4, iter_125_5 in pairs(self._map_node_data) do
				if iter_125_5.start_node_id == var_125_13 then
					table.insert(var_125_14, iter_125_5)
				end
			end

			self._map_node_data = var_125_14
		end

		for iter_125_6, iter_125_7 in ipairs(self._map_node_data) do
			if not var_125_4[iter_125_7.id] then
				local var_125_15, var_125_16 = self:loadUIPrefab("map_node_obj", self._control.bg.map_path.rectTransform)

				if iter_125_7.node_type == var_0_4.map_node_type.null then
					self._map_start_point = var_125_16
				elseif iter_125_7.node_type == var_0_4.map_node_finish_type.init then
					self._map_start_point = var_125_16
				end

				self.now_node_list[iter_125_7.id] = var_125_16

				var_125_15:setVisible(true)
				var_125_15._panel.transform:SetAsFirstSibling()

				if self._fight_type == var_0_4.fight_type.abyss_model_first_phase then
					local var_125_17 = var_0_3:get_abyss_ship_node_buff(iter_125_7.id)

					self._abyss_team_buff = var_0_3:get_abyss_ship_map_node_buff()

					local var_125_18 = {
						control = self.now_node_list[iter_125_7.id].node_image.adyss_buff_image,
						path = {}
					}
					local var_125_19 = false
					local var_125_20

					if iter_125_7.roundabout == 1 then
						var_125_20 = var_0_4.pve_g
						var_125_19 = true
					elseif iter_125_7.night_atk == 1 then
						var_125_20 = var_0_4.pve_night_atk_l
						var_125_19 = true
					elseif iter_125_7.node_type == 10 then
						var_125_20 = var_0_4.pve_air
						var_125_19 = true
					end

					if var_125_19 then
						self.now_node_list[iter_125_7.id].node_image.adyss_buff_image.image.sprite = self:loadSprite(var_125_20)

						var_0_32(var_125_18.path, var_125_20)
					end

					if var_125_17 then
						var_125_20 = var_0_3:check_if_get_abyss_buff(iter_125_7.id) and var_0_4.abyss_select_buff_bg_air_pass or var_0_4.abyss_select_buff_bg_air
						self.now_node_list[iter_125_7.id].node_image.adyss_buff_image.image.sprite = self:loadSprite(var_125_20)

						var_0_32(var_125_18.path, var_125_20)
					end

					if var_125_19 or var_125_17 then
						self.now_node_list[iter_125_7.id].node_image.adyss_buff_image:SetActive(true)
					else
						self.now_node_list[iter_125_7.id].node_image.adyss_buff_image:SetActive(false)
					end

					self._flash_obj_list[iter_125_7.id] = var_125_18

					local var_125_21 = self:autoKillDOTween(var_0_33.Sequence())

					if self._flash_obj_list[iter_125_7.id] then
						for iter_125_8, iter_125_9 in ipairs(self._flash_obj_list[iter_125_7.id].path) do
							var_125_21:Append(self.now_node_list[iter_125_7.id].node_image.adyss_buff_image.image:DOFade(0, 1))
							var_125_21:Append(self.now_node_list[iter_125_7.id].node_image.adyss_buff_image.image:DOFade(1, 1))
							var_125_21:Append(self.now_node_list[iter_125_7.id].node_image.adyss_buff_image.image:DOFade(1, 0))
							var_125_21:SetLoops(-1)
							var_125_21:Play()
						end
					end
				end

				var_125_16.node_image.rectTransform.parent.offsetMin = var_0_26(0, 0)
				var_125_16.node_image.rectTransform.parent.offsetMax = var_0_26(0, 0)
				var_125_16.node_image.rectTransform.anchoredPosition = self:__get_real_node_pos(var_125_0, var_125_1, iter_125_7.position.x, iter_125_7.position.y)
				var_125_16.node_image.rectTransform.localScale = var_0_27(1, 1, 1)

				local var_125_22

				if iter_125_7.support_icon and iter_125_7.support_icon ~= 0 then
					var_125_22 = string.format((var_0_3:get_map_node_pass_count(iter_125_7.pve_level_id, iter_125_7.id) ~= 0 or nil) and (var_0_4.fight_point.support_icon_path_red or var_0_4.fight_point.support_icon_path_white), gameconfig.support_atk_config.find_object_by_id(iter_125_7.support_icon).type)
				elseif iter_125_7.node_attribute == var_0_4.map_node_finish_type.init then
					var_125_22 = var_0_4.fight_point.pve_start_l
				elseif iter_125_7.node_attribute == var_0_4.map_node_finish_type.boss_finish then
					var_125_22 = var_0_3:is_map_node_pass(iter_125_7.pve_level_id, iter_125_7.id) and var_0_4.fight_point.pve_boss_l or var_0_4.fight_point.pve_boss
				elseif iter_125_7.node_type == var_0_4.map_node_type.reward then
					var_125_22 = var_0_3:is_map_node_pass(iter_125_7.pve_level_id, iter_125_7.id) and var_0_4.fight_point.pve_green or var_0_4.fight_point.pve_white
				elseif iter_125_7.node_type == var_0_4.map_node_type.loss then
					var_125_22 = var_0_3:is_map_node_pass(iter_125_7.pve_level_id, iter_125_7.id) and var_0_4.fight_point.pve_purple or var_0_4.fight_point.pve_white
				elseif iter_125_7.node_type == var_0_4.map_node_type.null then
					var_125_22 = var_0_3:is_map_node_pass(iter_125_7.pve_level_id, iter_125_7.id) and var_0_4.fight_point.pve_blue or var_0_4.fight_point.pve_white
				elseif iter_125_7.node_type == var_0_4.map_node_type.little_boss then
					var_125_22 = var_0_3:is_map_node_pass(iter_125_7.pve_level_id, iter_125_7.id) and var_0_4.fight_point.pve_small_boss_l or var_0_4.fight_point.pve_small_boss
				elseif iter_125_7.node_type == var_0_4.map_node_type.push_buff_point then
					local var_125_24 = var_0_3:is_map_node_pass(iter_125_7.pve_level_id, iter_125_7.id)

					if var_125_24 == false and iter_125_7.node_type ~= 13 then
						var_125_22 = var_0_4.fight_point.pve_white
					elseif var_125_24 and iter_125_7.node_type == 13 then
						var_125_22 = var_0_4.pve_buff_red
					elseif var_125_24 == false and iter_125_7.node_type == 13 then
						var_125_22 = var_0_4.pve_buff_white
					end
				else
					var_125_22 = var_0_3:is_map_node_pass(iter_125_7.pve_level_id, iter_125_7.id) and var_0_4.fight_point.pve_red or var_0_4.fight_point.pve_white
				end

				if self._fight_type == var_0_4.fight_type.event_story then
					var_125_22 = self:__get_map_node_path_by_sixth_year(iter_125_7)
				elseif self._fight_type == var_0_4.fight_type.ocean_attack then
					var_125_22 = self:__get_map_node_path_by_ocean(iter_125_7, iter_125_7.start_node_id, iter_125_7.id)
				elseif self._fight_type == var_0_4.fight_type.score_attack then
					var_125_22 = self:__get_map_node_path_by_score(iter_125_7, iter_125_7.start_node_id, iter_125_7.id)
				elseif self._fight_type == var_0_4.fight_type.ninth_attack then
					var_125_22 = self:__get_map_node_path_by_ninth(iter_125_7, iter_125_7.start_node_id, iter_125_7.id)
				elseif self._fight_type == var_0_4.fight_type.war_concerto then
					var_125_22 = self:__get_map_node_path_by_war_concerto(iter_125_7)
				elseif self._fight_type == var_0_4.fight_type.abyss_model_first_phase then
					if iter_125_7.node_type == var_0_4.abyss_map_node_type.prepare then
						var_125_22 = var_0_3:is_fight_info_pass(iter_125_7.id) and var_0_4.abyss_const.abyss_repair_point_pass or var_0_4.abyss_const.abyss_repair_point_normal
					elseif iter_125_7.node_type == var_0_4.abyss_map_node_type.fight then
						var_125_22 = var_0_3:is_fight_info_pass(iter_125_7.id) and var_0_4.fight_point.pve_red or var_0_4.fight_point.pve_white
					end
				elseif self._fight_type == var_0_4.fight_type.seventh then
					var_125_22 = self:__get_map_node_path_by_seventh_year(iter_125_7)
				elseif self._fight_type == var_0_4.fight_type.eighth_attack then
					var_125_22 = self:__get_map_node_path_by_eighth_year(iter_125_7)
				end

				var_125_16.node_image.image.sprite = self:loadSprite(var_125_22)

				local var_125_26

				if iter_125_7.roundabout == 1 and var_125_16 and var_125_16.night_atk_point_2 then
					var_125_26 = var_0_4.pve_g
					var_125_16.night_atk_point_2.image.sprite = self:loadSprite(var_0_4.pve_g)

					var_125_16.night_atk_point_2.image:SetNativeSize()
					var_125_16.night_atk_point_2:SetActive(true)

					var_125_16.night_atk_point_2.rectTransform.localScale = var_0_27(1, 1, 1)
					var_125_16.night_atk_point_2.rectTransform.parent.offsetMin = var_0_26(0, 0)
					var_125_16.night_atk_point_2.rectTransform.parent.offsetMax = var_0_26(0, 0)
					var_125_16.night_atk_point_2.rectTransform.anchoredPosition = self:__get_real_node_pos(var_125_0, var_125_1, iter_125_7.position.x, iter_125_7.position.y)
				end

				local var_125_27 = {}

				if iter_125_7.night_atk == 1 then
					var_125_26 = var_0_4.pve_night_atk_l

					table.insert(var_125_27, var_0_4.pve_night_atk_l)
				end

				if iter_125_7.node_type == 10 then
					var_125_26 = var_0_4.pve_air

					table.insert(var_125_27, var_0_4.pve_air)
				elseif iter_125_7.node_type == 11 then
					if (self._fight_type == var_0_4.fight_type.seventh and var_0_3:get_seventh_map_info()[var_0_3:get_now_seven_map_id()].finish_chase or nil) and false then
						var_125_26 = var_0_4.pve_special_boss_l

						table.insert(var_125_27, var_0_4.pve_special_boss_l)
					end
				elseif iter_125_7.node_type == 14 then
					if self._fight_type == var_0_4.fight_type.score_attack then
						if self:check_node_enemy(iter_125_7) then
							if (self._fight_type == var_0_4.fight_type.seventh and var_0_3:get_seventh_map_info()[var_0_3:get_now_seven_map_id()].finish_chase or nil) and false then
								var_125_26 = var_0_4.pve_special_boss_l

								table.insert(var_125_27, var_0_4.pve_special_boss_l)
							end
						end
					elseif (self._fight_type == var_0_4.fight_type.seventh and var_0_3:get_seventh_map_info()[var_0_3:get_now_seven_map_id()].finish_chase or nil) and false then
						var_125_26 = var_0_4.pve_special_boss_l

						table.insert(var_125_27, var_0_4.pve_special_boss_l)
					end
				end

				if var_125_26 and next(var_125_27) and self._fight_type ~= var_0_4.fight_type.abyss_model_first_phase then
					var_125_16.night_atk_point.image.sprite = self:loadSprite(var_125_26)

					var_125_16.night_atk_point.image:SetNativeSize()

					var_125_16.night_atk_point.rectTransform.localScale = var_0_27(1, 1, 1)

					var_125_16.night_atk_point:SetActive(true)

					var_125_16.night_atk_point.rectTransform.parent.offsetMin = var_0_26(0, 0)
					var_125_16.night_atk_point.rectTransform.parent.offsetMax = var_0_26(0, 0)
					var_125_16.night_atk_point.rectTransform.anchoredPosition = self:__get_real_node_pos(var_125_0, var_125_1, iter_125_7.position.x, iter_125_7.position.y)

					if iter_125_7.night_atk == 1 or iter_125_7.node_type == 10 or iter_125_7.node_type == 11 or iter_125_7.node_type == 14 then
						local var_125_34 = true

						if iter_125_7.node_type == 11 and var_0_3:is_map_node_s_pass(iter_125_7.pve_level_id, iter_125_7.id) then
							var_125_16.night_atk_point:SetActive(false)

							var_125_34 = false
						end

						if var_125_34 then
							local var_125_35 = self:autoKillDOTween(var_0_33.Sequence())

							table.insert(self._light_seq_list, var_125_35)
							var_125_35:Append(var_125_16.night_atk_point.image:DOFade(0, 0))

							for iter_125_10, iter_125_11 in pairs(var_125_27) do
								var_125_35:Append(var_125_16.night_atk_point.image:DOFade(0, 0.1):OnStepComplete(function()
									if var_125_16 and var_125_16.night_atk_point then
										var_125_16.night_atk_point.image.sprite = self:loadSprite(iter_125_11)
									end
								end))
								var_125_35:Append(var_125_16.night_atk_point.image:DOFade(1, 1))
								var_125_35:Append(var_125_16.night_atk_point.image:DOFade(0, 1))
							end

							var_125_35:SetLoops(-1)
							var_125_35:Play()
						end
					end
				else
					var_125_16.night_atk_point:SetActive(false)
				end

				if self._fight_type == var_0_4.fight_type.score_attack and iter_125_7.treasure_icon == 1 then
					var_125_26 = var_0_4.pve_box

					table.insert(var_125_27, var_0_4.pve_box)

					if not var_0_3:is_score_map_node_s_up_pass(iter_125_7.start_node_id, iter_125_7.id) then
						var_125_16.night_atk_point.image.sprite = self:loadSprite(var_125_26)

						var_125_16.night_atk_point.image:SetNativeSize()

						var_125_16.night_atk_point.rectTransform.localScale = var_0_27(1, 1, 1)

						var_125_16.night_atk_point:SetActive(true)

						var_125_16.night_atk_point.rectTransform.parent.offsetMin = var_0_26(0, 0)
						var_125_16.night_atk_point.rectTransform.parent.offsetMax = var_0_26(0, 0)
						var_125_16.night_atk_point.rectTransform.anchoredPosition = self:__get_real_node_pos(var_125_0, var_125_1, iter_125_7.position.x, iter_125_7.position.y)

						if true then
							local var_125_36 = self:autoKillDOTween(var_0_33.Sequence())

							table.insert(self._light_seq_list, var_125_36)
							var_125_36:Append(var_125_16.night_atk_point.image:DOFade(0, 0))

							for iter_125_12, iter_125_13 in pairs(var_125_27) do
								var_125_36:Append(var_125_16.night_atk_point.image:DOFade(0, 0.1):OnStepComplete(function()
									if var_125_16 and var_125_16.night_atk_point then
										var_125_16.night_atk_point.image.sprite = self:loadSprite(iter_125_13)
									end
								end))
								var_125_36:Append(var_125_16.night_atk_point.image:DOFade(1, 1))
								var_125_36:Append(var_125_16.night_atk_point.image:DOFade(0, 1))
							end

							var_125_36:SetLoops(-1)
							var_125_36:Play()
						end
					else
						var_125_16.night_atk_point:SetActive(false)
					end
				end

				if self._fight_type == var_0_4.fight_type.ocean_attack then
					local var_125_38 = var_0_3:get_ocean_map_tmp_icon_list()[iter_125_6]

					if var_125_26 or #var_125_38 > 0 then
						local var_125_39

						if var_125_26 then
							var_125_39 = var_125_26
						elseif #var_125_38 > 0 then
							var_125_39 = var_125_38[1]
						end

						var_125_16.night_atk_point.image.sprite = self:loadSprite(var_125_39)

						var_125_16.night_atk_point.image:SetNativeSize()
						var_125_16.night_atk_point:SetActive(true)

						var_125_16.night_atk_point.rectTransform.parent.offsetMin = var_0_26(0, 0)
						var_125_16.night_atk_point.rectTransform.parent.offsetMax = var_0_26(0, 0)
						var_125_16.night_atk_point.rectTransform.anchoredPosition = self:__get_real_node_pos(var_125_0, var_125_1, iter_125_7.position.x, iter_125_7.position.y)

						if iter_125_7.night_atk == 1 or iter_125_7.node_type == 10 or iter_125_7.node_type == 11 or #var_125_38 > 0 then
							local var_125_40 = true

							if iter_125_7.node_type == 11 then
								-- block empty
							end

							local var_125_41 = self:autoKillDOTween(var_0_33.Sequence())

							if var_125_40 then
								var_125_41:Append(var_125_16.night_atk_point.image:DOFade(0, 0))

								for iter_125_14, iter_125_15 in pairs(var_125_38) do
									var_125_41:Append(var_125_16.night_atk_point.image:DOFade(1, 1))
									var_125_41:Append(var_125_16.night_atk_point.image:DOFade(0, 1))
								end

								var_125_41:SetLoops(-1)
								var_125_41:Play()
							end
						end
					else
						var_125_16.night_atk_point:SetActive(false)
					end
				end

				self._point_list[iter_125_7.id] = var_125_16

				self:update_big_random_buff_node(iter_125_7.id, var_125_16)

				local var_125_42 = {}
				local var_125_43 = {}
				local var_125_44 = false

				for iter_125_16, iter_125_17 in pairs(var_125_2) do
					if iter_125_17.hide_start_point == iter_125_7.id then
						local var_125_45

						for iter_125_18, iter_125_19 in pairs(iter_125_17.hide_result) do
							var_125_45 = self._fight_type == var_0_4.fight_type.fearlessness_sea and var_0_39.find_object_by_id(tonumber(iter_125_18)) or self._fight_type == var_0_4.fight_type.seventh and var_0_22.find_object_by_id(tonumber(iter_125_18)) or self._fight_type == var_0_4.fight_type.eighth_attack and gameconfig.pve_eighth_level_node_config.find_object_by_id(tonumber(iter_125_18)) or self._fight_type == var_0_4.fight_type.score_attack and gameconfig.score_map_node_config.find_object_by_id_start_node_id(tonumber(iter_125_18), iter_125_7.start_node_id) or self._fight_type == var_0_4.fight_type.ninth_attack and var_0_47.find_object_by_id_start_node_id(tonumber(iter_125_18), iter_125_7.start_node_id) or var_0_6.find_object_by_id(tonumber(iter_125_18))

							local var_125_46 = var_0_3:get_map_node_pass_count(self._map_id, tonumber(iter_125_18))

							if tonumber(iter_125_18) ~= 70405 and self._fight_type == var_0_4.fight_type.seventh then
								if var_0_3:is_pass_seventh_map_node(var_125_45.pve_level_id, var_125_45.id) and var_0_3:get_seven_map_node_pass_count(self._map_id, tonumber(iter_125_18)) >= 1 then
									for iter_125_20, iter_125_21 in pairs(iter_125_7.next_node) do
										if iter_125_21 == tonumber(iter_125_17.hide_end_point) then
											var_0_32(var_125_42, iter_125_21)
										end
									end
								end
							elseif tonumber(iter_125_18) ~= 70405 and self._fight_type == var_0_4.fight_type.eighth_attack then
								if var_0_3:is_pass_eighth_map_node(var_125_45.pve_level_id, var_125_45.id) and var_0_3:get_eighth_map_node_pass_count(self._map_id, tonumber(iter_125_18)) >= 1 then
									for iter_125_22, iter_125_23 in pairs(iter_125_7.next_node) do
										if iter_125_23 == tonumber(iter_125_17.hide_end_point) then
											var_0_32(var_125_42, iter_125_23)
										end
									end
								end
							elseif tonumber(iter_125_18) ~= 70405 and self._fight_type == var_0_4.fight_type.score_attack then
								local var_125_47 = true

								for iter_125_24, iter_125_25 in pairs(iter_125_17.hide_result) do
									local var_125_48 = var_0_3:get_score_map_node_pass_count(iter_125_7.start_node_id, iter_125_24)

									if not var_125_48 or var_125_48 < 1 then
										var_125_47 = false
									end
								end

								if var_0_3:is_score_map_node_pass(var_125_45.start_node_id, var_125_45.id) and var_125_47 then
									for iter_125_26, iter_125_27 in pairs(iter_125_7.next_node) do
										if iter_125_27 == tonumber(iter_125_17.hide_end_point) then
											var_0_32(var_125_42, iter_125_27)
										end
									end
								end
							elseif tonumber(iter_125_18) ~= 70405 and self._fight_type == var_0_4.fight_type.ninth_attack then
								local var_125_49 = true

								for iter_125_28, iter_125_29 in pairs(iter_125_17.hide_result) do
									local var_125_50 = var_0_3:get_ninth_map_node_pass_count(iter_125_7.start_node_id, iter_125_28)

									if not var_125_50 or var_125_50 < 1 then
										var_125_49 = false
									end
								end

								if var_0_3:is_ninth_map_node_pass(var_125_45.start_node_id, var_125_45.id) and var_125_49 then
									for iter_125_30, iter_125_31 in pairs(iter_125_7.next_node) do
										if iter_125_31 == tonumber(iter_125_17.hide_end_point) then
											var_0_32(var_125_42, iter_125_31)
										end
									end
								end
							elseif tonumber(iter_125_18) ~= 70405 and self._fight_type ~= var_0_4.fight_type.seventh then
								if var_0_3:is_map_node_pass_b_and_b_up(var_125_45.pve_level_id, var_125_45.id) and iter_125_19 <= var_125_46 then
									for iter_125_32, iter_125_33 in pairs(iter_125_7.next_node) do
										if iter_125_33 == tonumber(iter_125_17.hide_end_point) then
											var_0_32(var_125_42, iter_125_33)
										end
									end
								end
							else
								if iter_125_19 <= var_125_46 - var_0_3:get_special_node_count() and not self._contain_miss then
									table.insert(var_125_43, {
										point_id = iter_125_17.hide_start_point,
										next_point_id = iter_125_17.hide_end_point
									})

									var_125_44 = true
								end

								if self._contain_miss then
									for iter_125_34, iter_125_35 in pairs(iter_125_7.next_node) do
										if iter_125_35 == tonumber(iter_125_17.hide_end_point) then
											var_0_32(var_125_42, iter_125_35)
										end
									end
								end
							end
						end
					end
				end

				for iter_125_36, iter_125_37 in pairs(var_125_3) do
					if iter_125_37.hide_start_point == iter_125_7.id then
						for iter_125_38, iter_125_39 in pairs(iter_125_37.hide_result) do
							if self._fight_type == var_0_4.fight_type.ninth_attack and var_0_3:ninth_map_is_pass(iter_125_39) then
								for iter_125_40, iter_125_41 in pairs(iter_125_7.next_node) do
									if iter_125_41 == tonumber(iter_125_37.hide_end_point) then
										var_0_32(var_125_42, iter_125_41)
									end
								end
							end
						end
					end
				end

				if var_125_44 and iter_125_7.id == 70405 then
					var_0_3:req_CompleteNodeMissReq(var_125_43)
				end

				local var_125_51 = {}
				local var_125_52 = {}
				local var_125_53 = {}
				local var_125_54 = true

				if iter_125_7.node_hide and next(iter_125_7.node_hide) then
					for iter_125_42, iter_125_43 in pairs(iter_125_7.node_hide) do
						for iter_125_44, iter_125_45 in pairs(iter_125_7.next_node) do
							if tonumber(iter_125_42) == iter_125_45 then
								for iter_125_46, iter_125_47 in pairs(iter_125_43) do
									if self._fight_type == var_0_4.fight_type.fearlessness_sea then
										local var_125_56 = var_0_39.find_object_by_id(tonumber(iter_125_47))
										local var_125_57 = var_0_3:is_map_node_pass_b_and_b_up(var_125_56.pve_level_id, var_125_56.id)
										local var_125_58

										if not var_125_57 then
											var_125_54 = false
											var_125_58 = {
												is_show_true = var_125_54
											}
										end

										var_125_58.node_flag = var_0_39.find_object_by_id(tonumber(iter_125_42)).flag
										var_125_58.is_pass = var_125_57

										var_0_32(var_125_51, var_125_58)
									elseif self._fight_type == var_0_4.fight_type.seventh then
										local var_125_59 = var_0_22.find_object_by_id(tonumber(iter_125_47))

										if not var_0_3:is_pass_seventh_map_node(var_125_59.pve_level_id, var_125_59.id) then
											var_125_54 = false
										end
									elseif self._fight_type == var_0_4.fight_type.eighth_attack then
										local var_125_60 = gameconfig.pve_eighth_level_node_config.find_object_by_id(tonumber(iter_125_47))

										if not var_0_3:is_pass_eighth_map_node(var_125_60.pve_level_id, var_125_60.id) then
											var_125_54 = false
										end
									elseif self._fight_type == var_0_4.fight_type.score_attack then
										local var_125_61 = var_0_19.find_object_by_id_start_node_id(iter_125_45, iter_125_7.start_node_id)
										local var_125_62

										if not var_0_3:is_score_map_node_pass(var_125_61.start_node_id, iter_125_47) or var_0_3:get_score_map_node_pass_count(var_125_61.start_node_id, iter_125_47) <= 0 then
											var_125_54 = false
											var_125_62 = {
												is_show_true = var_125_54,
												node_flag = var_125_61.flag
											}
										end

										var_125_62.is_pass = var_0_3:is_score_map_node_pass(var_125_61.start_node_id, iter_125_47)

										var_0_32(var_125_51, var_125_62)
									elseif self._fight_type == var_0_4.fight_type.ninth_attack then
										local var_125_63 = var_0_47.find_object_by_id_start_node_id(tonumber(iter_125_47), iter_125_7.start_node_id)

										if not var_0_3:is_ninth_map_node_pass(var_125_63.start_node_id, var_125_63.id) or var_0_3:get_ninth_map_node_pass_count(var_125_63.start_node_id, var_125_63.id) <= 0 then
											var_125_54 = false
										end
									else
										local var_125_64 = var_0_6.find_object_by_id(tonumber(iter_125_47))

										if not var_0_3:is_map_node_pass_b_and_b_up(var_125_64.pve_level_id, var_125_64.id) then
											var_125_54 = false
										end
									end
								end

								if self._fight_type == var_0_4.fight_type.fearlessness_sea then
									-- block empty
								elseif self._fight_type == var_0_4.fight_type.seventh then
									var_125_51 = {
										is_show_true = var_125_54,
										node_flag = var_0_22.find_object_by_id(tonumber(iter_125_42)).flag
									}
								elseif self._fight_type == var_0_4.fight_type.eighth_attack then
									var_125_51 = {
										is_show_true = var_125_54,
										node_flag = gameconfig.pve_eighth_level_node_config.find_object_by_id(tonumber(iter_125_42)).flag
									}
								elseif self._fight_type == var_0_4.fight_type.score_attack then
									-- block empty
								elseif self._fight_type == var_0_4.fight_type.ninth_attack then
									var_125_51 = {
										is_show_true = var_125_54,
										node_flag = var_0_47.find_object_by_id_start_node_id(iter_125_45, iter_125_7.start_node_id).flag
									}
								else
									local var_125_65 = {
										is_show_true = var_125_54
									}

									var_125_65.node_flag = var_0_6.find_object_by_id(tonumber(iter_125_42)).flag

									var_0_32(var_125_51, var_125_65)
								end
							end
						end
					end
				end

				if iter_125_7.node_hide_2 and next(iter_125_7.node_hide_2) then
					var_125_52 = self:get_hide_node_2_info(iter_125_7, var_125_53, var_125_54, var_125_52)
				end

				local var_125_66 = {}

				local function var_125_67(arg_128_0, arg_128_1)
					if arg_128_0 == nil then
						return
					end

					if var_125_66[arg_128_0] == nil then
						var_125_66[arg_128_0] = arg_128_1
					elseif var_125_66[arg_128_0] then
						var_125_66[arg_128_0] = arg_128_1
					end
				end

				if next(var_125_51) then
					if self._fight_type == var_0_4.fight_type.fearlessness_sea or self._fight_type == var_0_4.fight_type.score_attack then
						if #var_125_51 == 1 then
							for iter_125_48, iter_125_49 in pairs(var_125_51) do
								if var_125_51[iter_125_48] and var_125_51[iter_125_48].node_flag then
									var_125_67(var_125_51[iter_125_48].node_flag, var_125_51[iter_125_48].is_show_true)
								end
							end
						else
							for iter_125_50, iter_125_51 in pairs(var_125_51) do
								if var_125_51[iter_125_50] and var_125_51[iter_125_50].node_flag then
									var_125_67(var_125_51[iter_125_50].node_flag, (var_125_51[iter_125_50].is_pass == nil or nil) and var_125_51[iter_125_50].is_show_true)
								end
							end
						end
					elseif var_125_51.node_flag ~= nil then
						var_125_67(var_125_51.node_flag, var_125_51.is_show_true)
					else
						for iter_125_52, iter_125_53 in ipairs(var_125_51) do
							if iter_125_53 and iter_125_53.node_flag then
								var_125_67(iter_125_53.node_flag, iter_125_53.is_show_true)
							end
						end
					end
				end

				if var_125_52 and next(var_125_52) then
					for iter_125_54, iter_125_55 in pairs(var_125_52) do
						if var_125_52[iter_125_54] and var_125_52[iter_125_54].node_flag then
							var_125_67(var_125_52[iter_125_54].node_flag, var_125_52[iter_125_54].is_show_true)
						end
					end
				end

				if iter_125_7.garrison_node_open and next(iter_125_7.garrison_node_open) or iter_125_7.garrison_node_close and next(iter_125_7.garrison_node_close) then
					local var_125_69 = {}

					if iter_125_7.garrison_node_open then
						for iter_125_56, iter_125_57 in pairs(iter_125_7.garrison_node_open) do
							var_125_69[iter_125_56] = true
						end
					end

					if iter_125_7.garrison_node_close then
						for iter_125_58, iter_125_59 in pairs(iter_125_7.garrison_node_close) do
							var_125_69[iter_125_58] = true
						end
					end

					for iter_125_60, iter_125_61 in pairs(var_125_69) do
						local var_125_70
						local var_125_71 = tonumber(iter_125_60)

						var_125_70 = self._fight_type == var_0_4.fight_type.fearlessness_sea and var_0_39.find_object_by_id(var_125_71) or self._fight_type == var_0_4.fight_type.seventh and var_0_22.find_object_by_id(var_125_71) or self._fight_type == var_0_4.fight_type.eighth_attack and gameconfig.pve_eighth_level_node_config.find_object_by_id(var_125_71) or self._fight_type == var_0_4.fight_type.score_attack and var_0_19.find_object_by_id_start_node_id(var_125_71, iter_125_7.start_node_id) or self._fight_type == var_0_4.fight_type.ninth_attack and var_0_47.find_object_by_id_start_node_id(var_125_71, iter_125_7.start_node_id) or var_0_6.find_object_by_id(var_125_71)

						if var_125_70 then
							local var_125_72 = true
							local var_125_73

							if iter_125_7.garrison_node_open then
								var_125_73 = iter_125_7.garrison_node_open[iter_125_60] or iter_125_7.garrison_node_open[tonumber(iter_125_60)]
							end

							if var_125_73 then
								for iter_125_62, iter_125_63 in pairs(var_125_73) do
									if not var_0_3:is_point_stationed(tonumber(iter_125_63)) then
										var_125_72 = false

										break
									end
								end
							end

							local var_125_74 = true
							local var_125_75

							if iter_125_7.garrison_node_close then
								var_125_75 = iter_125_7.garrison_node_close[iter_125_60] or iter_125_7.garrison_node_close[tonumber(iter_125_60)]
							end

							if var_125_75 then
								for iter_125_64, iter_125_65 in pairs(var_125_75) do
									if var_0_3:is_point_stationed(tonumber(iter_125_65)) then
										var_125_74 = false

										break
									end
								end
							end

							var_125_67(var_125_70.flag, var_125_72 and var_125_74)
						end
					end
				end

				if iter_125_7.next_node_path ~= "{}" then
					self._liner_list[iter_125_7.id] = {}

					for iter_125_66, iter_125_67 in pairs(self._fight_type == var_0_4.fight_type.abyss_model_first_phase and iter_125_7.next_node_path or lx.json_decode(iter_125_7.next_node_path)) do
						if not var_125_5[iter_125_66] then
							local var_125_78, var_125_79 = self:loadUIPrefab("map_line_obj", self._control.bg.map_path.rectTransform)

							self.now_line_list[iter_125_7.id] = var_125_79

							var_125_78:setVisible(true)
							var_125_78._panel.transform:SetAsFirstSibling()

							var_125_79.line_image.rectTransform.parent.offsetMin = var_0_26(0, 0)
							var_125_79.line_image.rectTransform.parent.offsetMax = var_0_26(0, 0)
							var_125_79.line_image.rectTransform.anchoredPosition = self:__get_real_node_pos(var_125_0, var_125_1, iter_125_67.x, iter_125_67.y)
							var_125_79.line_image.rectTransform.localScale = var_0_27(1, 1, 1)

							local var_125_80 = var_0_23(var_0_4.mapline_path, self._map_id, iter_125_66)

							if self._fight_type == var_0_4.fight_type.event_story then
								var_125_80 = var_0_23(var_0_4.mapline_path, string.sub(iter_125_66, 1, #iter_125_66 - 4), iter_125_66)
								self.lineImagePath = var_0_23(var_0_4.mapline_path, string.sub(iter_125_66, 1, #iter_125_66 - 4), iter_125_66 .. "-02")
							elseif self._fight_type == var_0_4.fight_type.war_concerto or self._fight_type == var_0_4.fight_type.war_concerto_play or self._fight_type == var_0_4.fight_type.ocean_attack then
								var_125_80 = var_0_23(var_0_4.mapline_path, string.sub(iter_125_66, 1, #iter_125_66 - 4), iter_125_66)
								self.lineImagePath = var_0_23(var_0_4.mapline_path, string.sub(iter_125_66, 1, #iter_125_66 - 4), iter_125_66 .. "-02")
							elseif self._fight_type == var_0_4.fight_type.score_attack then
								self.lineImagePath = var_0_23(var_0_4.mapline_path, string.lower(self._map_id), iter_125_66)
								var_125_80 = string.format(var_0_4.mapline_path, string.lower(self._map_id), iter_125_66)
							end

							var_125_79.line_image.image.sprite = self:loadSprite(var_125_80)

							var_125_79.line_image.image:SetNativeSize()
							var_125_79.line_image:SetActive(true)

							local var_125_81 = false

							for iter_125_68, iter_125_69 in ipairs(var_125_2) do
								local var_125_82
								local var_125_83

								if self._fight_type == var_0_4.fight_type.fearlessness_sea then
									var_125_82 = var_0_39.find_object_by_id(tonumber(iter_125_69.hide_start_point))
									var_125_83 = var_0_39.find_object_by_id(tonumber(iter_125_69.hide_end_point))
								elseif self._fight_type == var_0_4.fight_type.seventh then
									var_125_82 = var_0_22.find_object_by_id(tonumber(iter_125_69.hide_start_point))
									var_125_83 = var_0_22.find_object_by_id(tonumber(iter_125_69.hide_end_point))
								elseif self._fight_type == var_0_4.fight_type.eighth_attack then
									var_125_82 = gameconfig.pve_eighth_level_node_config.find_object_by_id(tonumber(iter_125_69.hide_start_point))
									var_125_83 = gameconfig.pve_eighth_level_node_config.find_object_by_id(tonumber(iter_125_69.hide_end_point))
								elseif self._fight_type == var_0_4.fight_type.score_attack then
									var_125_82 = var_0_19.find_object_by_id_start_node_id(tonumber(iter_125_69.hide_start_point), iter_125_7.start_node_id)
									var_125_83 = var_0_19.find_object_by_id_start_node_id(tonumber(iter_125_69.hide_start_point), iter_125_7.start_node_id)
								elseif self._fight_type == var_0_4.fight_type.ninth_attack then
									var_125_82 = var_0_47.find_object_by_id_start_node_id(tonumber(iter_125_69.hide_start_point), iter_125_7.start_node_id)
									var_125_83 = var_0_47.find_object_by_id_start_node_id(tonumber(iter_125_69.hide_end_point), iter_125_7.start_node_id)
								else
									var_125_82 = var_0_6.find_object_by_id(tonumber(iter_125_69.hide_start_point))
									var_125_83 = var_0_6.find_object_by_id(tonumber(iter_125_69.hide_end_point))
								end

								if var_0_23("%s-%s-%s", iter_125_7.pve_level_id, var_125_82.flag, var_125_83.flag) == iter_125_66 then
									var_125_81 = true
								end
							end

							var_0_32(self._liner_list[iter_125_7.id], {
								lineImageName = iter_125_66,
								linePos = iter_125_67,
								mapLineControl = var_125_79,
								isCanNeedClose = var_125_81
							})

							local var_125_84 = lx.split(iter_125_66, "-")[3]

							if next(var_125_66) and var_125_66[var_125_84] ~= nil then
								var_125_79.line_image.image.color = var_125_66[var_125_84] and UnityEngine.Color(1, 1, 1, 1) or UnityEngine.Color(1, 1, 1, 0.2)
							end

							if var_125_42 and next(var_125_42) then
								for iter_125_70, iter_125_71 in pairs(var_125_42) do
									if var_0_23("%s-%s-%s", iter_125_7.pve_level_id, iter_125_7.flag, (self._fight_type == var_0_4.fight_type.fearlessness_sea and var_0_39.find_object_by_id(iter_125_71) or self._fight_type == var_0_4.fight_type.seventh and var_0_22.find_object_by_id(iter_125_71) or self._fight_type == var_0_4.fight_type.score_attack and var_0_19.find_object_by_id_start_node_id(iter_125_71, iter_125_7.start_node_id) or self._fight_type == var_0_4.fight_type.eighth_attack and gameconfig.pve_eighth_level_node_config.find_object_by_id(iter_125_71, iter_125_7.start_node_id) or self._fight_type == var_0_4.fight_type.ninth_attack and var_0_47.find_object_by_id_start_node_id(iter_125_71, iter_125_7.start_node_id) or var_0_6.find_object_by_id(iter_125_71)).flag) == iter_125_66 then
										var_125_79.line_image:SetActive(false)
									end
								end
							end

							if self._fight_type == var_0_4.fight_type.abyss_model_first_phase then
								if var_0_3:is_fight_info_pass(iter_125_66) then
									var_125_79.line_image.image.color = self.is_abyss_team and var_0_28.New(0.6196078431372549, 0.2, 0.2) or var_0_28.New(0.2, 0.5686274509803921, 0.8666666666666667)
								end
							elseif self._fight_type == var_0_4.fight_type.seventh and var_0_3:is_seventh_fight_info_pass(iter_125_66) then
								var_125_79.line_image.image.color = var_0_3:get_is_cur_seventh_difficulty_mode() and var_0_28.New(0.6196078431372549, 0.2, 0.2) or var_0_28.New(0.2, 0.5686274509803921, 0.8666666666666667)
							elseif self._fight_type == var_0_4.fight_type.score_attack and var_0_3:is_score_push_info_pass(iter_125_66) then
								var_125_79.line_image.image.color = var_0_3:get_is_cur_score_difficulty_mode() and var_0_28.New(0.6196078431372549, 0.2, 0.2) or var_0_28.New(0.2, 0.5686274509803921, 0.8666666666666667)
							elseif self._fight_type == var_0_4.fight_type.eighth_attack and var_0_3:is_eighth_fight_info_pass(iter_125_66) then
								var_125_79.line_image.image.color = var_0_3:get_is_cur_eighth_difficulty_mode() and var_0_28.New(0.6196078431372549, 0.2, 0.2) or var_0_28.New(0.2, 0.5686274509803921, 0.8666666666666667)
							elseif self._fight_type == var_0_4.fight_type.ninth_attack and var_0_3:is_ninth_push_info_pass(iter_125_66) then
								var_125_79.line_image.image.color = var_0_3:get_is_cur_ninth_difficulty_mode() and var_0_28.New(0.6196078431372549, 0.2, 0.2) or var_0_28.New(0.2, 0.5686274509803921, 0.8666666666666667)
							end
						end
					end
				end

				if #iter_125_7.flag > 0 then
					if self._fight_type == var_0_4.fight_type.abyss_model_first_phase then
						local var_125_91, var_125_92 = self:loadUIPrefab("fearlessness_sea_letter_obj", self._control.bg.map_path.rectTransform)

						var_125_91._panel.transform.localPosition = var_0_26(0, 0)
						var_125_91._panel.transform.sizeDelta = var_0_26(0, 0)
						var_125_92.node_letter_image.transform.anchoredPosition = var_125_16.node_image.rectTransform.anchoredPosition + var_0_26(0, 41)
						var_125_92.node_letter_image.image.sprite = nil

						if iter_125_7.flag and iter_125_7.flag ~= "" then
							var_125_92.node_letter_image:SetActive(true)

							var_125_92.node_letter_image.image.sprite = self:loadSprite((var_0_23(var_0_4.fearlessness_sea_node_letter, iter_125_7.flag .. ((var_0_3:is_fight_info_pass(iter_125_7.id) or nil) and (not self.is_abyss_team and 2 or 3)))))
						else
							var_125_92.node_letter_image:SetActive(false)
						end

						var_125_91:setVisible(true)

						self._letter_list[iter_125_7.id] = var_125_92
					else
						local var_125_94, var_125_95 = self:loadUIPrefab("map_node_letter_obj", self._control.bg.map_path.rectTransform)

						var_125_94:setVisible(true)
						var_125_94._panel.transform:SetAsFirstSibling()

						var_125_95.node_letter_text.rectTransform.parent.offsetMin = var_0_26(0, 0)
						var_125_95.node_letter_text.rectTransform.parent.offsetMax = var_0_26(0, 0)
						var_125_95.node_letter_text.rectTransform.anchoredPosition = var_125_16.node_image.rectTransform.anchoredPosition + var_0_26(0, 41)
						var_125_95.node_letter_text.rectTransform.localScale = var_0_27(1, 1, 1)
						var_125_95.node_letter_text.text.text = iter_125_7.flag
						var_125_95.node_letter_text.text.fontSize = 30

						if self._fight_type == var_0_4.fight_type.event_story then
							var_125_95.node_letter_text.text.text = ""

							var_125_95.node_letter_text.num:SetActive(true)

							var_125_95.node_letter_text.num.image.sprite = self:loadSprite(var_0_23(var_0_4.sixth_map_node_name, iter_125_7.flag))
						end
					end
				end
			end
		end

		if self._fight_type == var_0_4.fight_type.score_attack then
			local var_125_96 = var_0_18.find_object_by_id(self._map_id)

			for iter_125_72, iter_125_73 in ipairs(var_125_96.boss) do
				local var_125_97, var_125_98 = self:loadUIPrefab("ocean_boss_node_obj", self._control.bg.map_path.transform)

				var_125_97:setVisible(true)

				var_125_98.boss_icon.rectTransform.parent.offsetMin = var_0_26(0, 0)
				var_125_98.boss_icon.rectTransform.parent.offsetMax = var_0_26(0, 0)
				var_125_98.boss_icon.rectTransform.anchoredPosition = self:__get_real_node_pos(self._control.bg.map_path.rectTransform.rect.width, self._control.bg.map_path.rectTransform.rect.height, iter_125_73[4], iter_125_73[5])
				var_125_98.boss_icon.image.sprite = self:loadSprite(var_0_4.score_boss_unknow_icon)
				var_125_98.boss_icon.transform.localScale = var_0_27.New(1, 1, 1)
				self._opean_boss_img = {}

				local var_125_100 = var_0_18.find_object_by_id(var_125_96.map_id)
				local var_125_102 = iter_125_73[1]
				local var_125_103 = var_0_3:get_score_map_data()

				if iter_125_73[1] == var_125_100.boss[1][1] then
					for iter_125_74, iter_125_75 in pairs(var_125_103) do
						if iter_125_75.id == var_125_100.id then
							if iter_125_75.boss_hp[1].id == var_125_102 and iter_125_75.boss_hp[1].hp ~= 0 and iter_125_75.boss_hp[1].hp < var_125_100.boss[1][2] then
								var_125_98.boss_icon.image.sprite = self:loadSprite(var_0_23(var_0_4.score_boss_icon, iter_125_73[3]))

								if iter_125_75.boss_hp[1].hp / var_125_100.boss[1][2] <= 0.01 then
									var_125_98.boss_icon.boss_hp_bar.image.fillAmount = 0.01
								end

								var_125_98.boss_icon.boss_hp_bar:SetActive(true)
								var_125_98.boss_icon.boss_hp_bg:SetActive(true)
								var_125_98.boss_icon.boss_hp_die:SetActive(false)
							elseif iter_125_75.boss_hp[1].id == var_125_102 and iter_125_75.boss_hp[1].hp == 0 then
								var_125_98.boss_icon.image.sprite = self:loadSprite(var_0_23(var_0_4.score_boss_icon, iter_125_73[3]))

								var_125_98.boss_icon.boss_hp_bar:SetActive(false)
								var_125_98.boss_icon.boss_hp_die:SetActive(true)
							end

							if #iter_125_75.boss_hp > 1 then
								if iter_125_75.boss_hp[2].id == var_125_102 and iter_125_75.boss_hp[2].hp ~= 0 and iter_125_75.boss_hp[2].hp < var_125_100.boss[1][2] then
									var_125_98.boss_icon.image.sprite = self:loadSprite(var_0_23(var_0_4.score_boss_icon, iter_125_73[3]))

									if iter_125_75.boss_hp[2].hp / var_125_100.boss[1][2] <= 0.01 then
										var_125_98.boss_icon.boss_hp_bar.image.fillAmount = 0.01
									end

									var_125_98.boss_icon.boss_hp_bar:SetActive(true)
									var_125_98.boss_icon.boss_hp_bg:SetActive(true)
								elseif iter_125_75.boss_hp[2].id == var_125_102 and iter_125_75.boss_hp[2].hp == 0 then
									var_125_98.boss_icon.image.sprite = self:loadSprite(var_0_23(var_0_4.score_boss_icon, iter_125_73[3]))

									var_125_98.boss_icon.boss_hp_bar:SetActive(false)
									var_125_98.boss_icon.boss_hp_die:SetActive(true)
								end
							end
						end
					end
				end

				if #var_125_100.boss > 1 and var_125_102 == var_125_100.boss[2][1] then
					for iter_125_76, iter_125_77 in pairs(var_125_103) do
						if iter_125_77.id == var_125_100.id then
							if iter_125_77.boss_hp[1].id == var_125_102 and iter_125_77.boss_hp[1].hp ~= 0 and iter_125_77.boss_hp[1].hp < var_125_100.boss[2][2] then
								var_125_98.boss_icon.image.sprite = self:loadSprite(var_0_23(var_0_4.score_boss_icon, iter_125_73[3]))

								if iter_125_77.boss_hp[1].hp / var_125_100.boss[2][2] <= 0.01 then
									var_125_98.boss_icon.boss_hp_bar.image.fillAmount = 0.01
								end

								var_125_98.boss_icon.boss_hp_bar:SetActive(true)
								var_125_98.boss_icon.boss_hp_bg:SetActive(true)
							elseif iter_125_77.boss_hp[1].id == var_125_102 and iter_125_77.boss_hp[1].hp == 0 then
								var_125_98.boss_icon.image.sprite = self:loadSprite(var_0_23(var_0_4.score_boss_icon, iter_125_73[3]))

								var_125_98.boss_icon.boss_hp_bar:SetActive(false)
								var_125_98.boss_icon.boss_hp_die:SetActive(true)
							end

							if iter_125_77.boss_hp[2].id == var_125_102 and iter_125_77.boss_hp[2].hp ~= 0 and iter_125_77.boss_hp[2].hp < var_125_100.boss[2][2] then
								var_125_98.boss_icon.image.sprite = self:loadSprite(var_0_23(var_0_4.score_boss_icon, iter_125_73[3]))

								if iter_125_77.boss_hp[2].hp / var_125_100.boss[2][2] <= 0.01 then
									var_125_98.boss_icon.boss_hp_bar.image.fillAmount = 0.01
								end

								var_125_98.boss_icon.boss_hp_bar:SetActive(true)
								var_125_98.boss_icon.boss_hp_bg:SetActive(true)
							elseif iter_125_77.boss_hp[2].id == var_125_102 and iter_125_77.boss_hp[2].hp == 0 then
								var_125_98.boss_icon.image.sprite = self:loadSprite(var_0_23(var_0_4.score_boss_icon, iter_125_73[3]))

								var_125_98.boss_icon.boss_hp_bar:SetActive(false)
								var_125_98.boss_icon.boss_hp_die:SetActive(true)
							end
						end
					end
				end

				var_125_98.boss_icon.image:SetNativeSize()
			end
		end
	end

	function arg_1_0:get_hide_node_2_info(arg_129_1, arg_129_2, arg_129_3, arg_129_4)
		for iter_129_0, iter_129_1 in pairs(arg_129_1.node_hide_2) do
			for iter_129_2, iter_129_3 in pairs(arg_129_1.next_node) do
				if tonumber(iter_129_0) == iter_129_3 then
					for iter_129_4, iter_129_5 in pairs(iter_129_1) do
						table.insert(arg_129_2, (var_0_3:ninth_map_is_pass(iter_129_5) or nil) and 1)
					end

					local var_129_2 = var_0_47.find_object_by_id_start_node_id(iter_129_3, arg_129_1.start_node_id)

					if arg_129_2 and next(arg_129_2) then
						if self:_have_data(arg_129_2, 0) then
							arg_129_3 = false
						end

						var_0_32(arg_129_4, {
							is_show_true = arg_129_3,
							node_flag = var_129_2.flag
						})
					end
				end
			end
		end

		return arg_129_4
	end

	function arg_1_0._have_data(arg_130_0, arg_130_1, arg_130_2)
		local var_130_0 = false

		if next(arg_130_1) then
			for iter_130_0, iter_130_1 in pairs(arg_130_1) do
				if iter_130_1 == arg_130_2 then
					var_130_0 = true
				end
			end
		end

		return var_130_0
	end

	function arg_1_0:__get_node_by_id(arg_131_1)
		for iter_131_0, iter_131_1 in ipairs(self._map_node_data) do
			if iter_131_1.id == arg_131_1 then
				if iter_131_1.buff == nil then
					iter_131_1.buff = {}
				end

				return iter_131_1
			end
		end

		return nil
	end

	function arg_1_0:__get_node_by_id_2(arg_132_1)
		local var_132_0

		if self._fight_type == var_0_4.fight_type.ninth_attack then
			var_132_0 = var_0_46.find_object_by_id(arg_132_1)
		elseif self._fight_type == var_0_4.fight_type.ninth_attack then
			var_132_0 = var_0_18.find_object_by_id(arg_132_1)
		end

		var_132_0.flag = var_132_0.title .. var_132_0.sub_title

		return var_132_0
	end

	function arg_1_0:__get_real_node_pos(arg_133_1, arg_133_2, arg_133_3, arg_133_4)
		return var_0_26(arg_133_3 / 1280 * arg_133_1 + ((self._fight_type == var_0_4.fight_type.abyss_model_first_phase or nil) and -320), -1 * arg_133_4 + 120)
	end

	function arg_1_0:__get_node_data_by_map_id()
		local var_134_0 = {}
		local var_134_1, var_134_2 = var_0_6.get_sequence()

		if self._fight_type == var_0_4.fight_type.event_story then
			local var_134_3

			var_134_1, var_134_3 = var_0_13.get_sequence()
		elseif self._fight_type == var_0_4.fight_type.war_concerto or self._fight_type == var_0_4.fight_type.war_concerto_play then
			local var_134_4

			var_134_1, var_134_4 = var_0_16.get_sequence()
		elseif self._fight_type == var_0_4.fight_type.ocean_attack then
			local var_134_5

			var_134_1, var_134_5 = ocean_map_node_config.get_sequence()
		elseif self._fight_type == var_0_4.fight_type.score_attack then
			local var_134_6

			var_134_1, var_134_6 = var_0_19.get_sequence()
		elseif self._fight_type == var_0_4.fight_type.abyss_model_first_phase then
			local var_134_7

			var_134_1, var_134_7 = abyss_map_node_config.get_sequence()
		elseif self._fight_type == var_0_4.fight_type.fearlessness_sea then
			local var_134_8

			var_134_1, var_134_8 = var_0_39.get_sequence()
		elseif self._fight_type == var_0_4.fight_type.seventh then
			local var_134_9

			var_134_1, var_134_9 = var_0_22.get_sequence()
		elseif self._fight_type == var_0_4.fight_type.eighth_attack then
			local var_134_10

			var_134_1, var_134_10 = gameconfig.pve_eighth_level_node_config.get_sequence()
		elseif self._fight_type == var_0_4.fight_type.ninth_attack then
			local var_134_11

			var_134_1, var_134_11 = var_0_47.get_sequence()
		end

		for iter_134_0, iter_134_1 in pairs(var_134_1) do
			if tonumber(iter_134_1.pve_level_id) == self._map_id then
				var_134_0[#var_134_0 + 1] = iter_134_1
			end
		end

		return var_134_0
	end

	function arg_1_0.__get_new_guide_state_info(arg_135_0, arg_135_1)
		if var_0_3:get_guide_state() then
			local var_135_0 = var_0_2:getInstance("guide_panel")

			if not var_135_0 then
				return
			end

			local var_135_1 = var_135_0:get_next_step()

			if arg_135_1 == 1 then
				if var_135_1 == var_0_4.guide_const_id.ten_group.zero then
					var_135_0:reset_guide_panel()
				end
			elseif arg_135_1 == 2 and var_135_1 == var_0_4.guide_const_id.first_group.six then
				var_135_0:reset_guide_panel()
			end
		end
	end

	function arg_1_0:__init_strike_active()
		self._control.bg_r:SetActive(false)
		self._control.bg.map_path:SetActive(false)
		self._control.bg.ship_layer:SetActive(false)
		self._control.bg.title_bg:SetActive(false)
	end

	function arg_1_0:_play_audio(arg_137_1)
		self:playBackgroundMusic(arg_137_1)
	end

	function arg_1_0:_play_into_se(arg_138_1)
		self:playSE(arg_138_1, false)
	end

	function arg_1_0:__change_roundabout_state()
		if self._next_move_node_data.roundabout == 1 and self._next_move_node_data then
			self.now_node_list[self._next_move_node_data.id].node_image.image.sprite = self._next_move_node_data.node_type == var_0_4.map_node_type.little_boss and self:loadSprite(var_0_4.fight_point.pve_small_boss_l) or self._next_move_node_data.support_icon and self._next_move_node_data.support_icon ~= 0 and self:loadSprite(string.format(var_0_4.fight_point.support_icon_path_red, gameconfig.support_atk_config.find_object_by_id(self._next_move_node_data.support_icon).type)) or self:loadSprite(var_0_4.fight_point.pve_red)
		end
	end

	function arg_1_0.__get_config_min_num(arg_140_0, arg_140_1)
		local var_140_0

		if arg_140_1 then
			for iter_140_0, iter_140_1 in pairs(arg_140_1) do
				if var_140_0 == nil then
					var_140_0 = iter_140_1
				end

				if iter_140_1 < var_140_0 then
					var_140_0 = iter_140_1
				end
			end
		end

		return var_140_0
	end

	gamecore.extend_method(arg_1_0)

	function arg_1_0:__update_boss_hp(arg_141_1, arg_141_2)
		if arg_141_1.hp > 0 and (arg_141_2 == 0 or var_0_3:is_map_pass(arg_141_2)) then
			local var_141_0 = var_0_3:get_map_list()[arg_141_1.id]

			if var_141_0 then
				local var_141_1 = var_141_0.hp / arg_141_1.hp or 1

				if var_141_1 > 0 then
					self._control.bg.boss_slider.image.fillAmount = var_141_1
					self._control.bg.boss_hp.text.text = var_0_23("%0.2f%s", var_141_1 * 100, "%")

					self._control.bg.boss_hp:SetActive(true)
					self._control.bg.boss_slider:SetActive(true)
					self._control.bg.boss_slider_bg:SetActive(true)
					self._control.bg.boss_title:SetActive(true)

					goto label_141_0
				end
			end

			self._control.bg.boss_slider:SetActive(false)
			self._control.bg.boss_title:SetActive(false)
			self._control.bg.boss_slider_bg:SetActive(false)
			self._control.bg.boss_hp:SetActive(false)
		else
			self._control.bg.boss_slider:SetActive(false)
			self._control.bg.boss_title:SetActive(false)
			self._control.bg.boss_slider_bg:SetActive(false)
			self._control.bg.boss_hp:SetActive(false)
		end

		::label_141_0::
	end

	function arg_1_0:__click_select_abyss_buff(arg_142_1, arg_142_2)
		self._select_node_btn_index = arg_142_1

		if arg_142_2 then
			-- block empty
		end

		for iter_142_0 = 1, 3 do
			local var_142_0 = self._control.abyss_msgbox.main.select_node_layer[var_0_23("select_%s", iter_142_0)]

			if iter_142_0 == arg_142_1 then
				var_142_0.light:SetActive(true)
				var_142_0.mask_image:SetActive(false)

				for iter_142_1, iter_142_2 in pairs(self.buff_table_1) do
					if arg_142_1 == iter_142_1 then
						self._abyss_select_buff_id = iter_142_2
					end
				end
			else
				var_142_0.light:SetActive(false)
				var_142_0.mask_image:SetActive(true)
				var_142_0.select:SetActive(false)
			end
		end
	end

	function arg_1_0:__set_select_info()
		self:__set_abyss_ship_buff_image_init()

		self._control.abyss_msgbox.select_msg_btn.text.text.text = var_0_1:getNowLang("confirm")
		self._control.abyss_msgbox.main.text_image.text.text = var_0_1:getNowLang("ui_ny21_select_situation_tip")

		local var_143_0, var_143_1 = abyss_map_node_config.get_sequence()
		local var_143_2 = abyss_map_node_config.find_object_by_id(self._abyss_map_id)
		local var_143_3 = var_0_3:get_abyss_team_buff_info()
		local var_143_4
		local var_143_6

		if var_143_2.buffbox == 1 then
			var_143_6 = var_0_34.little_clone(self.abyss_map_buff_group_1)
		elseif var_143_2.buffbox == 2 then
			var_143_6 = var_0_34.little_clone(self.abyss_map_buff_group_2)
		elseif var_143_2.buffbox == 3 then
			var_143_6 = var_0_34.little_clone(self.abyss_map_buff_group_3)
		else
			self._control.abyss_msgbox.gameObject:SetActive(false)
			self:set_return_home_layer(true)
		end

		if var_143_3.map_id_1 then
			if not var_143_3.buff_1 then
				var_143_4 = var_143_6
			else
				for iter_143_0 = #var_143_6, 1, -1 do
					if var_143_3.buff_1 == var_143_6[iter_143_0] then
						table.remove(var_143_6, iter_143_0)
					end
				end

				var_143_4 = var_143_6
			end
		elseif var_143_3.map_id_2 then
			if not var_143_3.buff_2 then
				var_143_4 = var_143_6
			else
				for iter_143_1 = #var_143_6, 1, -1 do
					if var_143_3.buff_2 == var_143_6[iter_143_1] then
						table.remove(var_143_6, iter_143_1)
					end
				end

				var_143_4 = var_143_6
			end
		end

		if next(self._abyss_buff_select) == nil then
			self._abyss_buff_select = var_0_34.little_clone(var_143_4)
		else
			var_143_4 = var_0_34.little_clone(self._abyss_buff_select)
		end

		local var_143_8 = lan_rand(1, #var_143_4)
		local var_143_9

		for iter_143_2, iter_143_3 in pairs(var_143_4) do
			if iter_143_2 == var_143_8 then
				var_143_9 = iter_143_3
			end
		end

		self._control.abyss_msgbox.main.select_node_layer.select_1.text_one.text.text = var_143_9.title
		self._control.abyss_msgbox.main.select_node_layer.select_1.text_two.text.text = var_0_34.convert_rich_text(var_143_9.desc2)
		self._control.abyss_msgbox.main.select_node_layer.select_1.image.sprite = var_143_9.side == 2 and self:loadSprite(var_0_4.abyss_select_buff_bg_red) or self:loadSprite(var_0_4.abyss_select_buff_bg_blue)

		for iter_143_4 = #var_143_4, 1, -1 do
			if iter_143_4 == var_143_8 then
				table.remove(var_143_4, iter_143_4)
			end
		end

		local var_143_12 = lan_rand(1, #var_143_4)
		local var_143_13

		for iter_143_5, iter_143_6 in pairs(var_143_4) do
			if iter_143_5 == var_143_12 then
				var_143_13 = iter_143_6
			end
		end

		self._control.abyss_msgbox.main.select_node_layer.select_2.text_one.text.text = var_143_13.title
		self._control.abyss_msgbox.main.select_node_layer.select_2.text_two.text.text = var_0_34.convert_rich_text(var_143_13.desc2)
		self._control.abyss_msgbox.main.select_node_layer.select_2.image.sprite = var_143_13.side == 2 and self:loadSprite(var_0_4.abyss_select_buff_bg_red) or self:loadSprite(var_0_4.abyss_select_buff_bg_blue)

		for iter_143_7 = #var_143_4, 1, -1 do
			if iter_143_7 == var_143_12 then
				table.remove(var_143_4, iter_143_7)
			end
		end

		local var_143_16 = lan_rand(1, #var_143_4)
		local var_143_17

		for iter_143_8, iter_143_9 in pairs(var_143_4) do
			if iter_143_8 == var_143_16 then
				var_143_17 = iter_143_9
			end
		end

		local var_143_18

		if var_143_17 then
			var_143_18 = var_143_17.id
			self._control.abyss_msgbox.main.select_node_layer.select_3.text_one.text.text = var_143_17.title
			self._control.abyss_msgbox.main.select_node_layer.select_3.text_two.text.text = var_0_34.convert_rich_text(var_143_17.desc2)
			self._control.abyss_msgbox.main.select_node_layer.select_3.image.sprite = var_143_17.side == 2 and self:loadSprite(var_0_4.abyss_select_buff_bg_red) or self:loadSprite(var_0_4.abyss_select_buff_bg_blue)
		else
			self._control.abyss_msgbox.main.select_node_layer.select_3.text_one.text.text = ""
			self._control.abyss_msgbox.main.select_node_layer.select_3.text_two.text.text = ""
			self._control.abyss_msgbox.main.select_node_layer.select_3.image.sprite = self:loadSprite(var_0_4.abyss_select_buff_bg_blue)
		end

		for iter_143_10 = #var_143_4, 1, -1 do
			if iter_143_10 == var_143_16 then
				table.remove(var_143_4, iter_143_10)
			end
		end

		self.buff_table_1 = {}

		var_0_32(self.buff_table_1, var_143_10)
		var_0_32(self.buff_table_1, var_143_14)
		var_0_32(self.buff_table_1, var_143_18)

		self._abyss_select_buff_id = var_143_10

		local var_143_19 = var_0_3:get_battle_info()

		if var_143_19.type == var_0_38.fight_type.abyss then
			for iter_143_11 = 1, 3 do
				local var_143_20 = self._control.abyss_msgbox.main.select_node_layer[var_0_23("select_%s", iter_143_11)]

				if var_0_36.find_object_by_id(self.buff_table_1[iter_143_11]).side == 2 then
					var_143_20.buff_image:SetActive(true)
				else
					var_143_20.buff_image:SetActive(false)
				end
			end
		elseif var_143_19.type == var_0_38.fight_type.abyss_2 then
			for iter_143_12 = 1, 3 do
				local var_143_21 = self._control.abyss_msgbox.main.select_node_layer[var_0_23("select_%s", iter_143_12)]

				if var_0_36.find_object_by_id(self.buff_table_1[iter_143_12]).side == 1 then
					var_143_21.buff_image:SetActive(true)
				else
					var_143_21.buff_image:SetActive(false)
				end
			end
		end
	end

	function arg_1_0:__onReset()
		for iter_144_0, iter_144_1 in pairs(self._light_seq_list) do
			iter_144_1:Kill()
		end

		self:__reset_panel()

		self._control.bg.map_path.rectTransform.anchoredPosition = var_0_26(0, 0)
		self._control.bg_r.rectTransform.anchoredPosition = var_0_26(0, 0)
		self._control.bg.ship_layer.rectTransform.anchoredPosition = var_0_26(0, 0)

		self._control.mask.gameObject:SetActive(false)
		self._control.return_home.gameObject:SetActive(false)
		self._control.boss_new_root.gameObject:SetActive(false)
		self._control.abyss_msgbox.gameObject:SetActive(false)

		self._control.bg.info_bg.enemy_info_bg.canvasGroup.alpha = 0
		self._control.bg.info_bg.enemy_info_bg.canvasGroup.blocksRaycasts = false
		self._formation_selected = false
		self._random_prob = nil
		self._random = nil
		self._show_return_home = false
		self._point_list = {}
		self._letter_list = {}
		self._liner_list = {}
		self._have_bvr_ship = false
		self._save_enemy_array = {}
	end

	function arg_1_0.__show_abyss_review_fight_point(arg_145_0, arg_145_1, arg_145_2, arg_145_3)
		local var_145_0 = {}

		for iter_145_0, iter_145_1 in pairs((var_0_3:get_player_story_unlock_data())) do
			var_0_32(var_145_0, iter_145_0, iter_145_1.id)
		end

		local var_145_1 = abyss_map_node_config.find_object_by_id(arg_145_2.id)

		if not var_145_1 then
			return false
		end

		if var_145_1.node_type == var_0_4.abyss_map_node_type.prepare then
			var_0_3:record_abyss_enter_repair_point()

			local function var_145_2()
				local function var_146_0()
					var_0_3:set_abyss_fight_start_point(var_0_3:check_abyss_state() or 1, arg_145_2.id)

					local var_147_0, var_147_1 = math.modf(var_0_3:get_abyss_enter_repair_time() / 2)

					if var_147_1 == 0 then
						var_0_2:createInstance("fight_prepare"):show({
							abyss_prepare_point = true,
							fight_prepare_type = var_0_4.fight_type.abyss_model_first_phase,
							go_to_map_id = arg_145_1.id
						})

						return
					end

					local var_147_2 = var_0_2:createInstance("abyss_preview")

					arg_145_0:setVisible(false)
					var_147_2:show(var_0_3:get_abyss_now_chapter_cfg(), var_0_4.abyss_const.abyss_enter_preview_type.select_team)

					arg_145_0._abyss_team_buff = var_0_3:get_abyss_ship_map_node_buff()

					arg_145_0:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.abyss_activity_bgm))
				end

				if var_145_1.movie and var_145_1.movie[2] and var_145_1.movie[2][1] ~= 0 and not var_0_34.have_data(var_145_0, var_145_1.movie[2][1]) then
					local var_146_1 = var_0_20.find_object_by_id(var_145_1.movie[2][1])

					var_0_2:createInstance("cinema_dialog"):show(var_146_1.movie_group_id, var_146_1.movie_id[1], var_146_1.movie_id[2], 5, nil, function()
						var_146_0()
					end)
				else
					arg_145_0:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.abyss_activity_bgm))
					var_146_0()
				end
			end

			var_0_3:set_abyss_ship_move_callback(function()
				arg_145_0:__show_abyss_assist_icon(var_145_1, var_145_2)
			end)
			var_0_3:req_AbyssMoveMapReq(arg_145_3)

			return true
		end

		return false
	end

	function arg_1_0.__get_reward_data_after(arg_150_0)
		var_0_2:getInstance("msgbox"):setVisible(false)
	end

	function arg_1_0.__set_abyss_reward_data(arg_151_0, arg_151_1)
		local var_151_0 = {}

		for iter_151_0, iter_151_1 in pairs(arg_151_1.awardbox) do
			local var_151_1 = var_0_51.find_object_by_cid(iter_151_1)

			if var_151_1 then
				var_151_0[#var_151_0 + 1] = {
					count = 1,
					type = 2,
					id = var_151_1.cid
				}
			end
		end

		return var_151_0
	end

	function arg_1_0:__show_abyss_assist_icon(arg_152_1, arg_152_2)
		local var_152_0, var_152_1 = math.modf(var_0_3:get_abyss_enter_repair_time() / 2)

		if not next((self:__set_abyss_reward_data(arg_152_1))) then
			arg_152_2()

			return
		end

		var_0_3:req_AbyssAwardBoxReq(arg_152_1.id)

		local var_152_2 = self:autoKillDOTween(var_0_33.Sequence())

		self._control.abyss_combat_node:SetActive(true)

		self._control.abyss_combat_node.node_image.tip_text.text.text = var_0_1:getNowLang("ui_ny21_deep_power_up")

		local var_152_3 = self._control.abyss_combat_node.node_image.transform

		self._control.abyss_combat_node.node_image.transform.localScale = var_0_27(0, 0, 0)

		var_152_2:Append(self._control.abyss_combat_node.node_image.transform:DOScale(var_0_27(1.3, 1.3, 1.3), 0.1):SetAutoKill(true))
		var_152_2:Append(self._control.abyss_combat_node.node_image.transform:DOScale(var_0_27(0.8, 0.8, 0.8), 0.1):SetAutoKill(true))
		var_152_2:Append(self._control.abyss_combat_node.node_image.transform:DOScale(var_0_27(1, 1, 1), 0.1):SetAutoKill(true))
		var_152_2:AppendInterval(1)
		var_152_2:AppendCallback(function()
			var_152_2:Append(var_152_3:DOScale(var_0_27(0, 0, 0), 0.2):SetAutoKill(true))
			self._control.abyss_combat_node:SetActive(false)

			local var_153_0 = var_0_3:get_award_item_info()

			if next(var_153_0) then
				var_0_2:createInstance("msgbox"):showOnes(var_153_0, arg_152_2, nil, var_0_1:getNowLang("logget"), var_0_4.msg_type.abyss_node_rewards)
			else
				arg_152_2()
			end
		end)
		var_152_2:Play()
	end

	function arg_1_0:__set_select_buff_info()
		local var_154_0, var_154_1 = var_0_36.get_sequence()

		if next(self.abyss_map_buff_group_1) == nil then
			for iter_154_0, iter_154_1 in pairs(var_154_0) do
				if iter_154_1.group[1] == 1 then
					var_0_32(self.abyss_map_buff_group_1, iter_154_1)
				end

				if iter_154_1.group[1] == 2 or iter_154_1.group[2] == 2 then
					var_0_32(self.abyss_map_buff_group_2, iter_154_1)
				end

				if iter_154_1.group[1] == 3 or iter_154_1.group[2] == 3 or iter_154_1.group[3] == 3 then
					var_0_32(self.abyss_map_buff_group_3, iter_154_1)
				end
			end
		end

		self._ship_atk_type = var_0_3:get_battle_info().type
		self._buff_select_node = var_0_3:get_abyss_team_buff_info()
	end

	function arg_1_0:__set_abyss_ship_buff_image_init()
		for iter_155_0 = 1, 3 do
			local var_155_0 = self._control.abyss_msgbox.main.select_node_layer[var_0_23("select_%s", iter_155_0)]

			if iter_155_0 == 1 then
				var_155_0.light:SetActive(true)
				var_155_0.mask_image:SetActive(false)
			else
				var_155_0.light:SetActive(false)
				var_155_0.mask_image:SetActive(true)
			end
		end
	end

	function arg_1_0:__init_fearlessness_active_buff_Language()
		self._control.fearlessness_buff_msgbox.select_mask.tip.text.text = var_0_1:getNowLang("select_cover_support")
		self._control.fearlessness_buff_msgbox.main.text_image.text.text = var_0_1:getNowLang("buff_num_max") .. ":"
	end

	function arg_1_0:_show_fearlessness_active_buff(arg_157_1)
		self._retropulsion_map_id = arg_157_1

		self._control.fearlessness_buff_msgbox:SetActive(true)
		self:__init_fearlessness_active_buff_Language()

		for iter_157_0, iter_157_1 in pairs(var_0_39.find_object_by_id(arg_157_1).buff_choose) do
			if iter_157_1.weight ~= 0 then
				for iter_157_2 = 1, 3 do
					var_0_32(self._retropulsion_buff_list, iter_157_1.id)
				end
			end
		end

		local var_157_0 = var_0_3:get_push_info()
		local var_157_1 = var_0_3:get_push_buff_list()
		local var_157_2 = self._retropulsion_buff_list[lan_rand(1, #self._retropulsion_buff_list)]
		local var_157_3 = self._retropulsion_buff_list[lan_rand(1, #self._retropulsion_buff_list)]

		while var_157_3 == var_157_2 do
			var_157_3 = self._retropulsion_buff_list[lan_rand(1, #self._retropulsion_buff_list)]
		end

		local var_157_4 = self._retropulsion_buff_list[lan_rand(1, #self._retropulsion_buff_list)]

		while var_157_4 == var_157_2 or var_157_4 == var_157_3 do
			var_157_4 = self._retropulsion_buff_list[lan_rand(1, #self._retropulsion_buff_list)]
		end

		self._retropulsion_buff_1 = var_0_40.find_object_by_id(var_157_2)
		self._retropulsion_buff_2 = var_0_40.find_object_by_id(var_157_3)
		self._retropulsion_buff_3 = var_0_40.find_object_by_id(var_157_4)
		self._retropulsion_buff_4 = var_0_40.find_object_by_id(11000)

		if next(var_157_1) then
			self._control.fearlessness_buff_msgbox.main.select_node_layer.select_buff_1.Text.text.text = self._retropulsion_buff_1.effect_desc
			self._control.fearlessness_buff_msgbox.main.select_node_layer.select_buff_2.Text.text.text = self._retropulsion_buff_2.effect_desc
			self._control.fearlessness_buff_msgbox.main.select_node_layer.select_buff_3.Text.text.text = self._retropulsion_buff_3.effect_desc

			self:__show_push_buff_1_img(self._control.fearlessness_buff_msgbox.main.select_node_layer, 1)
			self:__show_push_buff_2_img(self._control.fearlessness_buff_msgbox.main.select_node_layer, 1)
			self:__show_push_buff_3_img(self._control.fearlessness_buff_msgbox.main.select_node_layer, 1)

			for iter_157_3, iter_157_4 in pairs(var_157_1) do
				if iter_157_3 == self._retropulsion_buff_1.id then
					self._control.fearlessness_buff_msgbox.main.select_node_layer.select_buff_1.buff.image.sprite = self:loadSprite((var_0_23(var_0_4.pve_active_buff_image, self._retropulsion_buff_1.buff_icon)))

					self:__show_push_buff_1_img(self._control.fearlessness_buff_msgbox.main.select_node_layer, 1)

					self._control.fearlessness_buff_msgbox.main.select_node_layer.select_buff_1.Text.text.text = self._retropulsion_buff_1.effect_desc

					if iter_157_4.count == 10 then
						self:__show_push_buff_4_img(self._control.fearlessness_buff_msgbox.main.select_node_layer.select_buff_1, 1)

						self._retropulsion_buff_1 = self._retropulsion_buff_4
						self._control.fearlessness_buff_msgbox.main.select_node_layer.select_buff_1.Text.text.text = self._retropulsion_buff_4.effect_desc
					elseif iter_157_4.count >= 4 then
						self:__show_push_buff_1_img(self._control.fearlessness_buff_msgbox.main.select_node_layer, 2)
					else
						self:__show_push_buff_1_img(self._control.fearlessness_buff_msgbox.main.select_node_layer, 1)
					end
				end

				if iter_157_3 == self._retropulsion_buff_2.id then
					self._control.fearlessness_buff_msgbox.main.select_node_layer.select_buff_2.buff.image.sprite = self:loadSprite((var_0_23(var_0_4.pve_active_buff_image, self._retropulsion_buff_2.buff_icon)))
					self._control.fearlessness_buff_msgbox.main.select_node_layer.select_buff_2.Text.text.text = self._retropulsion_buff_2.effect_desc

					if iter_157_4.count == 10 then
						self:__show_push_buff_4_img(self._control.fearlessness_buff_msgbox.main.select_node_layer.select_buff_2, 1)

						self._retropulsion_buff_2 = self._retropulsion_buff_4
						self._control.fearlessness_buff_msgbox.main.select_node_layer.select_buff_2.Text.text.text = self._retropulsion_buff_4.effect_desc
					elseif iter_157_4.count >= 4 then
						self:__show_push_buff_2_img(self._control.fearlessness_buff_msgbox.main.select_node_layer, 2)
					else
						self:__show_push_buff_2_img(self._control.fearlessness_buff_msgbox.main.select_node_layer, 1)
					end
				end

				if iter_157_3 == self._retropulsion_buff_3.id then
					self._control.fearlessness_buff_msgbox.main.select_node_layer.select_buff_3.buff.image.sprite = self:loadSprite((var_0_23(var_0_4.pve_active_buff_image, self._retropulsion_buff_3.buff_icon)))
					self._control.fearlessness_buff_msgbox.main.select_node_layer.select_buff_3.Text.text.text = self._retropulsion_buff_3.effect_desc

					if iter_157_4.count == 10 then
						self:__show_push_buff_4_img(self._control.fearlessness_buff_msgbox.main.select_node_layer.select_buff_3, 1)

						self._retropulsion_buff_3 = self._retropulsion_buff_4
						self._control.fearlessness_buff_msgbox.main.select_node_layer.select_buff_3.Text.text.text = self._retropulsion_buff_4.effect_desc
					elseif iter_157_4.count >= 4 then
						self:__show_push_buff_3_img(self._control.fearlessness_buff_msgbox.main.select_node_layer, 2)
					else
						self:__show_push_buff_3_img(self._control.fearlessness_buff_msgbox.main.select_node_layer, 1)
					end
				end
			end
		else
			self._control.fearlessness_buff_msgbox.main.select_node_layer.select_buff_1.Text.text.text = self:_get_txt(self._retropulsion_buff_1.effect_desc)
			self._control.fearlessness_buff_msgbox.main.select_node_layer.select_buff_2.Text.text.text = self:_get_txt(self._retropulsion_buff_2.effect_desc)
			self._control.fearlessness_buff_msgbox.main.select_node_layer.select_buff_3.Text.text.text = self:_get_txt(self._retropulsion_buff_3.effect_desc)

			self:__show_push_buff_1_img(self._control.fearlessness_buff_msgbox.main.select_node_layer, 1)
			self:__show_push_buff_2_img(self._control.fearlessness_buff_msgbox.main.select_node_layer, 1)
			self:__show_push_buff_3_img(self._control.fearlessness_buff_msgbox.main.select_node_layer, 1)
		end

		self:_push_active_buff_start_time()
	end

	function arg_1_0:__show_push_buff_1_img(arg_158_1, arg_158_2)
		arg_158_1.select_buff_1.image.sprite = self:loadSprite((var_0_23(var_0_4.pve_active_buff_bg_image, arg_158_2)))
		arg_158_1.select_buff_1.buff.image.sprite = self:loadSprite((var_0_23(var_0_4.pve_active_buff_image, self._retropulsion_buff_1.buff_icon)))
	end

	function arg_1_0:__show_push_buff_2_img(arg_159_1, arg_159_2)
		arg_159_1.select_buff_2.image.sprite = self:loadSprite((var_0_23(var_0_4.pve_active_buff_bg_image, arg_159_2)))
		arg_159_1.select_buff_2.buff.image.sprite = self:loadSprite((var_0_23(var_0_4.pve_active_buff_image, self._retropulsion_buff_2.buff_icon)))
	end

	function arg_1_0:__show_push_buff_3_img(arg_160_1, arg_160_2)
		arg_160_1.select_buff_3.image.sprite = self:loadSprite((var_0_23(var_0_4.pve_active_buff_bg_image, arg_160_2)))
		arg_160_1.select_buff_3.buff.image.sprite = self:loadSprite((var_0_23(var_0_4.pve_active_buff_image, self._retropulsion_buff_3.buff_icon)))
	end

	function arg_1_0:__show_push_buff_4_img(arg_161_1, arg_161_2)
		arg_161_1.image.sprite = self:loadSprite((var_0_23(var_0_4.pve_active_buff_bg_image, arg_161_2)))
		arg_161_1.buff.image.sprite = self:loadSprite((var_0_23(var_0_4.pve_active_buff_image, self._retropulsion_buff_4.buff_icon)))
	end

	function arg_1_0._get_txt(arg_162_0, arg_162_1)
		return (var_0_24(arg_162_1, "%^C[^%^]+", function(arg_163_0)
			return var_0_23("<color=#%s>%s</color>", var_0_25(arg_163_0, 3, 10), (var_0_25(arg_163_0, 19, #arg_163_0)))
		end))
	end

	function arg_1_0:_push_active_buff_start_time()
		self._control.fearlessness_buff_msgbox.main.text_image.Text.text.text = " " .. self:__get_now_push_buff_num() .. "/" .. self:__get_max_push_buff_num()
	end

	function arg_1_0:__get_max_push_buff_num()
		self.acticity = {}

		local var_165_0 = gameconfig.ship_rule_config.find_object_by_id(var_0_4.pve_init_active_id.fearlessness_event).content.activeId

		for iter_165_0, iter_165_1 in pairs((var_0_41.get_sequence())) do
			if self:get_acticity_time(iter_165_1) and iter_165_1.id == var_165_0 then
				self.acticity = var_0_34.little_clone(iter_165_1)
			end
		end

		local var_165_1 = math.floor((lx.ServerTime:getUtcTime() - (self.acticity.start_time - 54000)) / 86400)

		if var_165_1 >= 9 then
			var_165_1 = 9
		end

		return 90 + var_165_1 * 20
	end

	function arg_1_0:__get_now_push_buff_num()
		local var_166_1 = (var_0_34.have_data(var_0_41.find_object_by_id(gameconfig.ship_rule_config.find_object_by_id(var_0_4.pve_init_active_id.fearlessness_event).content.activeId).levels, self._map_id) or nil) and true and var_0_3:get_push_buff_list() or var_0_3:get_push_buff_list(true)
		local var_166_2 = 0

		if next(var_166_1) == nil then
			var_166_2 = 0
		else
			for iter_166_0, iter_166_1 in pairs(var_166_1) do
				var_166_2 = var_166_2 + iter_166_1.count
			end
		end

		return var_166_2
	end

	function arg_1_0.get_acticity_time(arg_167_0, arg_167_1)
		if not arg_167_1 then
			return false
		end

		arg_167_1.start_time = arg_167_1.start_time or 0
		arg_167_1.end_time = arg_167_1.end_time or 0

		if arg_167_1.start_time == 0 or arg_167_1.end_time == 0 then
			return false
		end

		arg_167_1.award_time = arg_167_1.award_time or 0

		if arg_167_1.award_time == 0 then
			if lx.ServerTime:getUtcTime() > arg_167_1.start_time and lx.ServerTime:getUtcTime() < arg_167_1.end_time then
				return true
			end
		elseif lx.ServerTime:getUtcTime() > arg_167_1.start_time and lx.ServerTime:getUtcTime() < arg_167_1.award_time then
			return true
		end

		return false
	end

	function arg_1_0:update_fearlessness_sea_panel_random_buff(arg_168_1)
		if self._fight_type ~= var_0_4.fight_type.fearlessness_sea then
			return
		end

		for iter_168_0, iter_168_1 in pairs((var_0_3:get_push_random_buff())) do
			if arg_168_1.id == iter_168_1.point_id then
				self._control.bg.info_bg.enemy_info_bg.line_bottom.random_tip_Text:SetActive(true)

				self._control.bg.info_bg.enemy_info_bg.line_bottom.random_tip_Text.Text.text.text = var_0_34.convert_rich_text(var_0_35.find_object_by_id(iter_168_1.buff_id).desc)

				var_0_3:set_strong_buff_list(iter_168_1.buff_id)
			end
		end
	end

	function arg_1_0.update_big_random_buff_node(arg_169_0, arg_169_1, arg_169_2)
		for iter_169_0, iter_169_1 in ipairs((var_0_3:get_push_random_buff())) do
			if arg_169_1 == iter_169_1.point_id then
				arg_169_2.node_image.random_buff_icon:SetActive(true)
			end
		end
	end

	function arg_1_0.check_node_enemy(arg_170_0, arg_170_1)
		for iter_170_0, iter_170_1 in pairs(var_0_3:get_score_map_buff_list().ids) do
			for iter_170_2, iter_170_3 in pairs(var_0_17.find_object_by_id(iter_170_1).effect) do
				if iter_170_3.type == 9 and iter_170_3.node_id[1] == arg_170_1.id then
					return false
				end
			end
		end

		return true
	end

	function arg_1_0.__play_animation(arg_171_0, arg_171_1, arg_171_2, arg_171_3)
		arg_171_1.skeletonGraphic.AnimationState:SetAnimation(0, arg_171_2, arg_171_3)
	end

	function arg_1_0:__special_situation_run(arg_172_1)
		if self._save_node_roundabout and arg_172_1 then
			gamecore.prompt:show(var_0_1:getNowLang("beyond_line_of_sight_skips"))
		end

		self._control.bg.info_bg.enemy_info_bg.circuity_btn.button.interactable = not arg_172_1
	end

	function arg_1_0:__special_situation_ss()
		local var_173_0 = false
		local var_173_1 = 0

		if self._save_enemy_array and next(self._save_enemy_array) then
			for iter_173_0, iter_173_1 in pairs(self._save_enemy_array) do
				local var_173_2 = var_0_12.find_object_by_id(iter_173_1)

				if var_173_2.type == 14 or var_173_2.type == 15 then
					var_173_1 = var_173_1 + 1
				end
			end

			if var_173_1 == #self._save_enemy_array then
				var_173_0 = true
			end
		end

		return var_173_0
	end

	function arg_1_0:__finish_special_task(arg_174_1)
		if not next(arg_174_1) then
			return
		end

		self._task_num = 0
		self._task_info = {}

		for iter_174_0, iter_174_1 in pairs(arg_174_1) do
			var_0_32(self._task_info, iter_174_1)

			self._task_num = self._task_num + 1
		end

		local var_174_0 = self:autoKillDOTween(var_0_33.Sequence())

		if self._task_num > 1 then
			self._control.msg_panel:SetActive(true)

			local var_174_1 = self._control.msg_panel.finish_special_mission

			self._control.msg_panel.finish_special_mission_btn:SetActive(true)

			if self._task_num == 2 then
				local var_174_2 = gameconfig.pve_eighth_task_config.find_object_by_id(self._task_info[1])

				self._control.msg_panel.finish_special_mission:SetActive(true)

				self._control.msg_panel.finish_special_mission.map_title.text.text = ""
				self._control.msg_panel.finish_special_mission.task_title.text.text = var_174_2.title
				self._control.msg_panel.finish_special_mission.coin_num.text.text = var_174_2.supportfleet_exp
				self._control.msg_panel.finish_special_mission.award_icon.image.sprite = self:loadSprite(var_0_4.eighth_task_image_type.exp_award)

				if var_174_2.award > 0 then
					var_174_0:AppendInterval(3)
					var_174_0:AppendCallback(function()
						var_174_1:SetActive(true)

						var_174_1.map_title.text.text = ""
						var_174_1.task_title.text.text = var_174_2.title
						self._control.msg_panel.finish_special_mission.award_icon.image.sprite = self:loadSprite(var_0_4.eighth_task_image_type.trophy_award)
						var_174_1.coin_num.text.text = var_174_2.award

						var_174_0:Append(var_174_1.transform:DOScaleY(0, 0)):SetEase(DG.Tweening.Ease.Linear)
						var_174_0:Append(var_174_1.transform:DOScaleY(1, 0.5)):SetEase(DG.Tweening.Ease.Linear)
					end)
				end

				var_174_0:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(0, 0)):SetEase(DG.Tweening.Ease.Linear)
				var_174_0:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(1, 0.5)):SetEase(DG.Tweening.Ease.Linear)
				var_174_0:AppendInterval(3)
				var_174_0:AppendCallback(function()
					local var_175_0 = gameconfig.pve_eighth_task_config.find_object_by_id(self._task_info[2])

					var_174_1:SetActive(true)

					var_174_1.map_title.text.text = ""
					var_174_1.task_title.text.text = var_175_0.title
					var_174_1.coin_num.text.text = var_175_0.supportfleet_exp
					self._control.msg_panel.finish_special_mission.award_icon.image.sprite = self:loadSprite(var_0_4.eighth_task_image_type.exp_award)

					var_174_0:Append(var_174_1.transform:DOScaleY(0, 0)):SetEase(DG.Tweening.Ease.Linear)
					var_174_0:Append(var_174_1.transform:DOScaleY(1, 0.5)):SetEase(DG.Tweening.Ease.Linear)
				end)
			elseif self._task_num == 3 then
				local var_174_3 = gameconfig.pve_eighth_task_config.find_object_by_id(self._task_info[1])

				self._control.msg_panel.finish_special_mission:SetActive(true)

				self._control.msg_panel.finish_special_mission.map_title.text.text = ""
				self._control.msg_panel.finish_special_mission.task_title.text.text = var_174_3.title
				self._control.msg_panel.finish_special_mission.coin_num.text.text = var_174_3.supportfleet_exp
				self._control.msg_panel.finish_special_mission.award_icon.image.sprite = self:loadSprite(var_0_4.eighth_task_image_type.exp_award)

				if var_174_3.award > 0 then
					var_174_0:AppendInterval(3)
					var_174_0:AppendCallback(function()
						var_174_1:SetActive(true)

						var_174_1.map_title.text.text = ""
						var_174_1.task_title.text.text = var_174_3.title
						self._control.msg_panel.finish_special_mission.award_icon.image.sprite = self:loadSprite(var_0_4.eighth_task_image_type.trophy_award)
						var_174_1.coin_num.text.text = var_174_3.award

						var_174_0:Append(var_174_1.transform:DOScaleY(0, 0)):SetEase(DG.Tweening.Ease.Linear)
						var_174_0:Append(var_174_1.transform:DOScaleY(1, 0.5)):SetEase(DG.Tweening.Ease.Linear)
					end)
				end

				var_174_0:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(0, 0)):SetEase(DG.Tweening.Ease.Linear)
				var_174_0:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(1, 0.5)):SetEase(DG.Tweening.Ease.Linear)
				var_174_0:AppendInterval(3)
				var_174_0:AppendCallback(function()
					local var_177_0 = gameconfig.pve_eighth_task_config.find_object_by_id(self._task_info[2])

					var_174_1:SetActive(true)

					var_174_1.map_title.text.text = ""
					var_174_1.task_title.text.text = var_177_0.title
					var_174_1.coin_num.text.text = var_177_0.supportfleet_exp
					self._control.msg_panel.finish_special_mission.award_icon.image.sprite = self:loadSprite(var_0_4.eighth_task_image_type.exp_award)

					var_174_0:Append(var_174_1.transform:DOScaleY(0, 0)):SetEase(DG.Tweening.Ease.Linear)
					var_174_0:Append(var_174_1.transform:DOScaleY(1, 0.5)):SetEase(DG.Tweening.Ease.Linear)
				end)
				var_174_0:AppendInterval(3)
				var_174_0:AppendCallback(function()
					local var_178_0 = gameconfig.pve_eighth_task_config.find_object_by_id(self._task_info[3])

					var_174_1:SetActive(true)

					var_174_1.map_title.text.text = ""
					var_174_1.task_title.text.text = var_178_0.title
					var_174_1.coin_num.text.text = var_178_0.supportfleet_exp
					self._control.msg_panel.finish_special_mission.award_icon.image.sprite = self:loadSprite(var_0_4.eighth_task_image_type.exp_award)

					var_174_0:Append(var_174_1.transform:DOScaleY(0, 0)):SetEase(DG.Tweening.Ease.Linear)
					var_174_0:Append(var_174_1.transform:DOScaleY(1, 0.5)):SetEase(DG.Tweening.Ease.Linear)
				end)
			end
		else
			self._control.msg_panel:SetActive(true)

			local var_174_4 = self._control.msg_panel.finish_special_mission
			local var_174_5 = gameconfig.pve_eighth_task_config.find_object_by_id(self._task_info[1])

			self._control.msg_panel.finish_special_mission:SetActive(true)

			self._control.msg_panel.finish_special_mission.map_title.text.text = ""
			self._control.msg_panel.finish_special_mission.task_title.text.text = var_174_5.title
			self._control.msg_panel.finish_special_mission.award_icon.image.sprite = self:loadSprite(var_0_4.eighth_task_image_type.exp_award)
			self._control.msg_panel.finish_special_mission.coin_num.text.text = var_174_5.supportfleet_exp

			var_174_0:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(0, 0)):SetEase(DG.Tweening.Ease.Linear)
			var_174_0:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(1, 0.5)):SetEase(DG.Tweening.Ease.Linear)
			self._control.msg_panel.finish_special_mission_btn:SetActive(true)

			if var_174_5.award > 0 then
				var_174_0:AppendInterval(3)
				var_174_0:AppendCallback(function()
					var_174_4:SetActive(true)

					var_174_4.map_title.text.text = ""
					var_174_4.task_title.text.text = var_174_5.title
					self._control.msg_panel.finish_special_mission.award_icon.image.sprite = self:loadSprite(var_0_4.eighth_task_image_type.trophy_award)
					var_174_4.coin_num.text.text = var_174_5.award

					var_174_0:Append(var_174_4.transform:DOScaleY(0, 0)):SetEase(DG.Tweening.Ease.Linear)
					var_174_0:Append(var_174_4.transform:DOScaleY(1, 0.5)):SetEase(DG.Tweening.Ease.Linear)
				end)
			end
		end

		var_0_3:clear_open_eighth_panel()
	end
end)

function var_0_0.create(arg_181_0)
	local var_181_0 = var_0_2:class("fight_info")

	var_181_0._map_id = -1
	var_181_0._map_node_data = nil
	var_181_0._has_condition = false
	var_181_0._need_condition = false
	var_181_0._has_random = false
	var_181_0._has_miss = false
	var_181_0._has_hide = false
	var_181_0._has_hide_2 = false
	var_181_0._has_garrison_open = false
	var_181_0._has_garrison_close = false
	var_181_0._choices_data = {}
	var_181_0._team_detail_data = nil
	var_181_0._condition_need_data = {}
	var_181_0._condition_control_list = {}
	var_181_0._random_control_list = {}
	var_181_0._time_execute_task_list = nil
	var_181_0._next_move_node_data = nil
	var_181_0._fight_type = -1
	var_181_0._start_node_id = -1
	var_181_0._show_return_home = false
	var_181_0._fighting_status = nil
	var_181_0._people_icon_id = nil
	var_181_0._formation_id = 1
	var_181_0._random_prob = nil
	var_181_0._circuity_rate = 0
	var_181_0._random = nil
	var_181_0._liner_list = {}
	var_181_0._point_list = {}
	var_181_0._letter_list = {}
	var_181_0._show_continue_tip = nil
	var_181_0._response_data = nil
	var_181_0._strong_buff_list = nil
	var_181_0.now_level_id = 0
	var_181_0._input_map_node = 0
	var_181_0._miss_node_data = {}
	var_181_0._hide_node_data = {}
	var_181_0._garrison_open_node_data = {}
	var_181_0._garrison_close_node_data = {}
	var_181_0._abyss_select_buff_id = nil
	var_181_0.buff_table_1 = {}
	var_181_0.ocean_buff_select = {}
	var_181_0._abyss_buff_select = {}
	var_181_0._fight_info_prefab = nil
	var_181_0.abyss_map_buff = {}
	var_181_0.abyss_map_buff_group_1 = {}
	var_181_0.abyss_map_buff_group_2 = {}
	var_181_0.abyss_map_buff_group_3 = {}
	var_181_0._abyss_map_id = nil
	var_181_0._abyss_team_buff = {}
	var_181_0._ship_atk_type = nil
	var_181_0._buff_select_node = nil
	var_181_0._flash_obj_list = {}
	var_181_0._map_title = nil
	var_181_0._retropulsion_buff_1 = nil
	var_181_0._retropulsion_buff_2 = nil
	var_181_0._retropulsion_buff_3 = nil
	var_181_0._retropulsion_buff_list = {}
	var_181_0._retropulsion_map_id = nil
	var_181_0._light_seq_list = {}
	var_181_0._have_bvr_ship = false
	var_181_0._now_into_param = {}
	var_181_0._save_node_roundabout = false
	var_181_0._already_init = false
	var_181_0._save_enemy_name = nil

	return var_181_0
end

return var_0_0
