local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.BattleManager
local var_0_4 = gameenum.common_type
local var_0_5 = DG.Tweening.DOTween
local var_0_6 = gamecore.user
local var_0_7 = gameconfig.ship_skill_buff_config
local var_0_8 = gameconfig.joy_buff_config
local var_0_9 = gameconfig.ocean_map_node_config
local var_0_10 = gameconfig.pve_active_map_node_config
local var_0_11 = gameconfig.pve_mix_level_node_config
local var_0_12 = gamecore.AudioManager
local var_0_13 = gameconfig.shop_config
local var_0_14 = gameconfig.map_config
local var_0_15 = gameconfig.map_node_config
local var_0_16 = gameconfig.ship_pve_buff_config
local var_0_18 = gamecore.util_func
local var_0_19 = UnityEngine.Screen
local var_0_22 = gameconfig.sixth_map_config
local var_0_23 = gameconfig.strike_map_config
local var_0_24 = gameconfig.pve_mix_map_config
local var_0_25 = gameconfig.score_map_node_config
local var_0_26 = gameconfig.pve_score_level_config
local var_0_27 = gameconfig.pve_ninth_level_node_config
local var_0_28 = gameconfig.pve_ninth_level_config
local var_0_29 = gameconfig.pve_eighth_level_node_config
local var_0_30 = gameconfig.pve_eighth_map_config
local var_0_31 = gameconfig.pve_active_map_config

gamecore.UILoader:define("battle", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		var_0_12:destroyCV()
		self:setVisible(true)

		self._fight_type = arg_2_1

		self:__init_language()
		self:__init_battle()
	end

	function arg_1_0:get_left_formation_tip()
		return self._control.left.formation.info.text.text
	end

	function arg_1_0:get_right_formation_tip()
		return self._control.right.formation.info.text.text
	end

	function arg_1_0:get_left_course_tip()
		return self._control.left.course.info.text.text
	end

	function arg_1_0:get_right_course_tip()
		return self._control.right.course.info.text.text
	end

	function arg_1_0:set_formation(arg_7_1, arg_7_2)
		self._control.left.formation.info.text.text = var_0_2:getNowLang((var_0_4:get_formation_language(arg_7_1)))
		self._control.right.formation.info.text.text = var_0_2:getNowLang((var_0_4:get_formation_language(arg_7_2)))
	end

	function arg_1_0:__set_buff_info()
		self._control.strong_buff_root.info_bg:SetActive(not self._control.strong_buff_root.info_bg.activeSelf)

		local var_8_0 = var_0_6:get_strong_buff_list()

		if var_8_0 and not self._control.strong_buff_root.info_bg.activeSelf then
			local var_8_1 = var_0_16.find_object_by_id(var_8_0)

			self._control.strong_buff_root.info_bg.buff_name.text.text = var_8_1.title
			self._control.strong_buff_root.info_bg.info_text.text.text = var_0_18.convert_rich_text(var_8_1.desc2)
		end
	end

	function arg_1_0:__set_lock_info()
		local var_9_0 = var_0_14.find_object_by_id(var_0_6:get_battle_info().id)
		local var_9_1 = false
		local var_9_2 = false

		for iter_9_0, iter_9_1 in pairs(var_9_0.replace_conditions) do
			local var_9_3 = var_0_6:get_map_list()[iter_9_1[1]]

			if not var_0_6:is_map_pass(iter_9_1[1]) then
				var_9_2 = true
			end
		end

		for iter_9_2, iter_9_3 in pairs(var_0_6:get_map_list()[var_9_0.id].pass_point) do
			if var_9_0.id == iter_9_3.id then
				for iter_9_4, iter_9_5 in ipairs(iter_9_3.info) do
					if ((var_9_2 or nil) and (var_9_0.pve_condition or var_9_0.pve_condition_weak)) >= iter_9_5.grade then
						var_9_1 = true

						break
					end
				end
			end
		end

		local var_9_4

		if var_9_1 then
			var_9_4 = var_9_0.pve_debuff_weak or var_9_0.pve_debuff
		end

		self._control.strong_buff_root.lock_info:SetActive(not self._control.strong_buff_root.lock_info.activeSelf)

		local var_9_5 = var_0_16.find_object_by_id(var_9_4)

		self._control.strong_buff_root.lock_info.buff_name.text.text = var_9_5.title
		self._control.strong_buff_root.lock_info.info_text.text.text = var_0_18.convert_rich_text(var_9_5.desc2)
	end

	function arg_1_0:set_direction(arg_10_1, arg_10_2)
		local var_10_0, var_10_1 = var_0_4:get_course_language(arg_10_1)
		local var_10_2, var_10_3 = var_0_4:get_course_language(arg_10_2)

		self._control.left.course.info.text.text = var_0_2:getNowLang(var_10_0)
		self._control.right.course.info.text.text = var_0_2:getNowLang(var_10_2)
		self._control.left.course.image.sprite = self:loadSprite(var_10_1)
		self._control.right.course.image.sprite = self:loadSprite(var_10_3)
	end

	function arg_1_0:show_night_war_tip(arg_11_1)
		self._control.popup.combat_continue.frame.tip.canvasGroup.alpha = 0

		self:show_bullet_and_oil_percent(arg_11_1)
		self._control.popup.combat_continue:SetActive(true)

		self._control.popup.combat_continue.canvas.sortingOrder = 1000

		self:set_damagecontrol_num(arg_11_1)

		if var_0_6:get_guide_state() then
			local var_11_0 = var_0_1:getInstance("guide_panel")

			if var_11_0 and var_11_0:get_next_step() == var_0_4.guide_const_id.first_group.seven then
				var_11_0:reset_guide_panel()
			end
		end

		if var_0_6:get_battle_info().type == var_0_4.battle_type.war_concerto_play then
			self._control.popup.combat_continue.frame.oil:SetActive(false)
			self._control.popup.combat_continue.frame.bullet:SetActive(false)
			self._control.popup.combat_continue.frame.damagecontrol:SetActive(false)
			self._control.popup.combat_continue.frame.ui_combatcontinuetip:SetActive(false)

			self._control.popup.combat_continue.frame.ui_tip_mid.text.text = var_0_2:getNowLang("ui_continue_to_night")

			self._control.popup.combat_continue.frame.ui_tip_mid:SetActive(true)
		end

		if var_0_6:get_battle_info().type == var_0_4.battle_type.abyss_first_phase then
			local var_11_1 = var_0_6:get_abyss_preview_now_page()

			if var_11_1 and var_11_1 == 1 then
				self._control.popup.combat_continue.frame.oil:SetActive(false)
				self._control.popup.combat_continue.frame.bullet:SetActive(false)
				self._control.popup.combat_continue.frame.damagecontrol:SetActive(false)

				self._control.popup.combat_continue.frame.ui_combatcontinuetip.text.text = var_0_2:getNowLang("ui_ny21_fleet_deep_energy")

				local var_11_2 = var_0_6:get_abyss_power()

				var_11_2 = var_11_2 > 100 and 100 or var_11_2

				local var_11_3 = var_11_2 / 100
				local var_11_4 = ""

				if var_11_2 > 0 and var_11_2 < 30 then
					var_11_4 = var_0_4.abyss_converter.abyss_converter_red
				elseif var_11_2 >= 30 and var_11_2 < 60 then
					var_11_4 = var_0_4.abyss_converter.abyss_converter_yellow
				elseif var_11_2 >= 60 and var_11_2 <= 100 then
					var_11_4 = var_0_4.abyss_converter.abyss_converter_green
				end

				self._control.popup.combat_continue.frame.abyss_power.fill.image.sprite = self:loadSprite(var_11_4)
				self._control.popup.combat_continue.frame.abyss_power.fill.image.fillAmount = var_11_2 / 100
				self._control.popup.combat_continue.frame.abyss_power.tip.num.text.text = var_11_3 * 100 .. "/" .. 100

				self._control.popup.combat_continue.frame.abyss_power:SetActive(true)
			end
		end

		self._control.popup:SetActive(true)
	end

	function arg_1_0:__show_hp_bar()
		self._hp_bar_status = not self._hp_bar_status

		for iter_12_0 = 1, self._control.hp_bar_root.transform.childCount do
			local var_12_0 = self._control.hp_bar_root.transform:GetChild(iter_12_0 - 1).transform:Find("progress"):Find("foreground")

			if var_12_0 then
				if var_12_0.transform:GetComponent("Image").fillAmount > 0 then
					self._control.hp_bar_root.transform:GetChild(iter_12_0 - 1).gameObject:SetActive(self._hp_bar_status)
				else
					self._control.hp_bar_root.transform:GetChild(iter_12_0 - 1).gameObject:SetActive(false)
				end
			end
		end
	end

	function arg_1_0:get_hp_bar_status()
		return self._hp_bar_status
	end

	function arg_1_0:hide_night_war_tip()
		self._control.popup.combat_continue:SetActive(false)
	end

	function arg_1_0:get_hp_bar_root()
		return self._control.hp_bar_root.transform
	end

	function arg_1_0:get_step_text()
		return self._control.middle.stage_bg.stage.text
	end

	function arg_1_0:show_stage_step(arg_17_1)
		if not arg_17_1 or not self._control then
			return
		end

		self._control.middle.stage_bg:SetActive(true)

		if self._change_fight_step then
			self:close_stage_step(arg_17_1)

			return
		end

		local var_17_0 = 80

		if arg_17_1 == var_0_4.fight_step_rule.night_fight.value then
			var_17_0 = 55
		end

		self._control.middle.stage_bg.clip.stage.text.text = var_0_2:getNowLang((var_0_4:get_fight_step_language_key(arg_17_1)))

		self._control.middle.stage_bg.stage1.transform:DOLocalMoveX(var_17_0 * -1, 0.5)
		self._control.middle.stage_bg.stage2.transform:DOLocalMoveX(var_17_0, 0.5)
		self._control.middle.stage_bg.clip.rectTransform:DOSizeDelta(Vector2(128, 60), 0.5)

		self._change_fight_step = true
	end

	function arg_1_0:close_stage_step(arg_18_1, arg_18_2)
		if not self._change_fight_step then
			return
		end

		local var_18_0 = self:autoKillDOTween(var_0_5.Sequence())

		self._control.middle.stage_bg.stage2.transform:DOLocalMoveX(23.5, 0.5)
		self._control.middle.stage_bg.clip.rectTransform:DOSizeDelta(Vector2(0, 60), 0.5)
		self._control.middle.stage_bg.stage1.transform:DOLocalMoveX(-23.5, 0.8):OnComplete(function()
			if arg_18_1 then
				self:show_stage_step(arg_18_1)
			end

			if arg_18_2 then
				arg_18_2()
			end

			var_18_0:Kill()

			var_18_0 = nil
		end)
		var_18_0:Play()

		self._change_fight_step = false
	end

	function arg_1_0:get_cutin_root()
		return self._control.cutin_root
	end

	function arg_1_0:get_actor_mask()
		return self._control.cutin_root.aircraft_mask
	end

	function arg_1_0:get_damage_text_root()
		return self._control.damage_text_root.transform
	end

	function arg_1_0:get_border_root()
		return self._control.border_root
	end

	function arg_1_0:attach_buff(arg_24_1, arg_24_2, arg_24_3)
		local var_24_1
		local var_24_2

		if arg_24_1 == "main_fight" then
			var_24_1 = string.format(var_0_4.buff_icon, var_0_16.find_object_by_id(arg_24_2).buff_icon)
		elseif arg_24_1 == "abyss" then
			var_24_2 = gameenum.battle_type:get_abyss_power_level(arg_24_2)
			var_24_1 = string.format(var_0_4.buff_icon, var_0_8.find_object_by_level(var_24_2).buff_icon)
		else
			var_24_1 = arg_24_1 == "push_fight" and string.format(var_0_4.buff_icon, var_0_16.find_object_by_id(arg_24_2).buff_icon) or string.format(var_0_4.buff_icon, var_0_7.find_object_by_cid(arg_24_2).icon)
		end

		local var_24_3
		local var_24_4

		if arg_24_1 == "player" then
			var_24_3, var_24_4 = self:loadUIPrefab("buff_bg", self._control.buff_root.transform)
		end

		if arg_24_1 == "enemy" then
			var_24_3, var_24_4 = self:loadUIPrefab("buff_bg", self._control.enemy_buff_root.transform)
		end

		if arg_24_1 == "main_fight" then
			var_24_3, var_24_4 = self:loadUIPrefab("buff_bg", self._control.fight_buff_root.transform)
		end

		if arg_24_1 == "push_fight" then
			var_24_3, var_24_4 = self:loadUIPrefab("buff_bg", self._control.fight_buff_root.transform)
		end

		if arg_24_1 == "abyss" then
			var_24_3, var_24_4 = self:loadUIPrefab("buff_bg", self._control.fight_buff_root.transform)
		end

		if arg_24_2 == 911 then
			var_24_4.icon:GetComponent(typeof(UnityEngine.RectTransform)).sizeDelta = Vector2.New(36, 31)
		end

		if arg_24_2 == 913 then
			var_24_4.icon:GetComponent(typeof(UnityEngine.RectTransform)).sizeDelta = Vector2.New(36, 33)
		end

		var_24_3._control.icon.button.onClick:AddListener(function()
			self:show_buff_desc(arg_24_1, arg_24_2, var_24_3._panel, var_24_2, arg_24_3)
		end)

		var_24_3._control.icon.image.sprite = self:loadSprite(var_24_1)
		var_24_3._panel.transform.localScale = Vector3.New(0.4, 0.4, 0.4)

		var_24_3:setVisible(true)

		local var_24_5 = self:autoKillDOTween(var_0_5.Sequence())
		local var_24_6 = var_24_3._panel.transform
		local var_24_7 = var_24_3._control.icon.image

		var_24_5:AppendCallback(function()
			var_24_6:DOScale(Vector3.New(1, 1, 1), 1)
			var_24_7:DOFade(1, 0.4)
		end)
		var_24_5:Play()
	end

	function arg_1_0:attach_aircontrol_tip(arg_27_1, arg_27_2, arg_27_3, arg_27_4)
		local var_27_0, var_27_1 = self:loadUIPrefab("aircontrol_content", self._control.aircontrol_root.transform)

		var_27_0:setVisible(true)

		if not arg_27_2 then
			var_27_0._control.aircontrol_bg.aircontrol_img.image.sprite = self:loadSprite((string.format(var_0_4.aircontrol_img, arg_27_1)))
			var_27_0._control.aircontrol_bg.aircontrol_img.canvasGroup.alpha = 1
			var_27_0._control.aircontrol_bg.buff_name.canvasGroup.alpha = 0
		else
			var_27_0._control.aircontrol_bg.aircontrol_img.canvasGroup.alpha = 0
			var_27_0._control.aircontrol_bg.buff_name.canvasGroup.alpha = 1
			var_27_0._control.aircontrol_bg.buff_name.text.text = arg_27_2
		end

		local var_27_2 = 0.5
		local var_27_3 = 100
		local var_27_5 = 2

		if arg_27_3 then
			var_27_2 = arg_27_3.time
			var_27_3 = arg_27_3.move_y
			var_27_5 = arg_27_3.wait_time
			var_27_0._control.aircontrol_bg.transform.anchoredPosition = Vector2.New(var_27_0._control.aircontrol_bg.transform.anchoredPosition.x + 0, var_27_0._control.aircontrol_bg.transform.anchoredPosition.y + arg_27_3.delta_y)
		end

		local var_27_6 = self:autoKillDOTween(var_0_5.Sequence())
		local var_27_7 = var_27_0._control.aircontrol_bg.canvasGroup
		local var_27_8 = var_27_0._control.aircontrol_bg.transform

		var_27_0._control.aircontrol_bg.canvasGroup:DOFade(1, 0.5)
		var_27_6:AppendInterval(var_27_5)
		var_27_6:AppendCallback(function()
			var_27_8:DOLocalMoveY(var_27_3, var_27_2)
			var_27_7:DOFade(0, 0.5)
		end)
		var_27_6:AppendInterval(0.5)

		if arg_27_4 then
			var_27_6:AppendCallback(arg_27_4)
		end

		var_27_6:Play()
	end

	function arg_1_0:get_dialogue_root()
		return self._control.dialogue_root
	end

	function arg_1_0:show_tip()
		self._control.popup.combat_continue.frame.tip:SetActive(true)
	end

	function arg_1_0:show_bullet_and_oil_percent(arg_31_1)
		local var_31_0 = arg_31_1.max_oil
		local var_31_1 = arg_31_1.now_bullet - arg_31_1.max_bullet / 5
		local var_31_2 = arg_31_1.now_oil - arg_31_1.max_oil / 5

		if arg_31_1.start_air_attack then
			var_31_1 = arg_31_1.now_bullet - arg_31_1.max_bullet / 10
			var_31_2 = arg_31_1.now_oil - arg_31_1.max_oil / 10
		end

		if self.fight_type == gameenum.battle_type.fight_type.maneuver then
			var_31_1 = arg_31_1.now_bullet
			var_31_2 = arg_31_1.now_oil
		end

		if self.fight_type == gameenum.battle_type.fight_type.plot_main then
			var_31_1 = arg_31_1.max_bullet
			var_31_2 = arg_31_1.max_oil
		end

		var_31_1 = var_31_1 <= 0 and 0 or var_31_1
		var_31_2 = var_31_2 <= 0 and 0 or var_31_2

		local var_31_3 = var_31_1 * 10 / arg_31_1.max_bullet > 10 and 10 or var_31_1 * 10 / arg_31_1.max_bullet
		local var_31_4 = var_31_2 * 10 / var_31_0 > 10 and 10 or var_31_2 * 10 / var_31_0
		local var_31_5 = var_0_4:get_supply_img((var_31_1 * 10 / arg_31_1.max_bullet > 10 and 10 or var_31_1 * 10 / arg_31_1.max_bullet) / 10, "bullet")
		local var_31_6 = var_0_4:get_supply_img((var_31_2 * 10 / var_31_0 > 10 and 10 or var_31_2 * 10 / var_31_0) / 10, "oil")

		for iter_31_0 = 1, math.floor(var_31_1 * 10 / arg_31_1.max_bullet > 10 and 10 or var_31_1 * 10 / arg_31_1.max_bullet) do
			self._control.popup.combat_continue.frame.bullet["bullet_" .. iter_31_0].image.sprite = self:loadSprite(var_31_5)
		end

		for iter_31_1 = math.floor(var_31_3) + 1, 10 do
			self._control.popup.combat_continue.frame.bullet["bullet_" .. iter_31_1].image.sprite = self:loadSprite(var_0_4.supply_rule.bullet_path)
		end

		for iter_31_2 = 1, math.floor(var_31_4) do
			self._control.popup.combat_continue.frame.oil["oil_" .. iter_31_2].image.sprite = self:loadSprite(var_31_6)
		end

		for iter_31_3 = math.floor(var_31_4) + 1, 10 do
			self._control.popup.combat_continue.frame.oil["oil_" .. iter_31_3].image.sprite = self:loadSprite(var_0_4.supply_rule.path)
		end

		self._control.popup.combat_continue.frame.bullet.percent.text.text = string.format("%.1f%%", math.floor(var_31_1 * 100 / arg_31_1.max_bullet))
		self._control.popup.combat_continue.frame.oil.percent.text.text = string.format("%.1f%%", math.floor(var_31_2 * 100 / var_31_0))
	end

	function arg_1_0:show_boss_hp(arg_32_1, arg_32_2, arg_32_3, arg_32_4)
		if arg_32_3 and not self._node_point then
			self._node_point = arg_32_3
		end

		local var_32_0 = var_0_15.find_object_by_id(self._node_point)

		if self.fight_type == gameenum.battle_type.fight_type.ocean_attack then
			var_32_0 = var_0_9.find_object_by_id_start_node_id(self._node_point, (var_0_6:get_current_ocean_map_start_point()))
		elseif self.fight_type == gameenum.battle_type.fight_type.push then
			var_32_0 = var_0_10.find_object_by_id(self._node_point)
		elseif self.fight_type == gameenum.battle_type.fight_type.seventh then
			var_32_0 = var_0_11.find_object_by_id(self._node_point)
		elseif self.fight_type == gameenum.battle_type.fight_type.eighth then
			var_32_0 = var_0_29.find_object_by_id(self._node_point)
		elseif self.fight_type == gameenum.battle_type.fight_type.score then
			var_32_0 = var_0_25.find_object_by_id_start_node_id(self._node_point, (var_0_6:get_current_score_map_start_point()))
		elseif self.fight_type == gameenum.battle_type.fight_type.ninth then
			var_32_0 = var_0_27.find_object_by_id_start_node_id(self._node_point, (var_0_6:get_ninth_map_start_point()))
		end

		if var_32_0 then
			if var_32_0.node_type == var_0_4.map_node_type.boss then
				self._control.boss_hp_root.hp_text.text.text = string.format("%.2f%%", arg_32_1 / arg_32_2 * 100)
				self._control.boss_hp_root.bg.progress.image.fillAmount = arg_32_1 / arg_32_2
				self._control.boss_hp_root.canvasGroup.alpha = arg_32_1 / arg_32_2 == 0 and 1 or 1

				if arg_32_4 or arg_32_1 == 1 then
					self._control.boss_hp_root.hp_text.text.text = "0.01%"
					self._control.boss_hp_root.bg.progress.image.fillAmount = 0.01
					self._control.boss_hp_root.canvasGroup.alpha = 1
				end
			else
				self._control.boss_hp_root.canvasGroup.alpha = 0
			end
		else
			self._control.boss_hp_root.canvasGroup.alpha = 0
		end
	end

	function arg_1_0:close_boss_hp()
		self._control.boss_hp_root.canvasGroup.alpha = 0
	end

	function arg_1_0:update_boss_hp(arg_34_1)
		self._control.boss_hp_root.bg.progress.image.fillAmount = arg_34_1
		self._control.boss_hp_root.bg.progress.image.fillAmount = string.format("%.2f%%", arg_34_1 * 100)
	end

	function arg_1_0:show_periscope(arg_35_1, arg_35_2)
		local var_35_0 = UnityEngine.GameObject.Find("PeriscopeCamera"):GetComponent(typeof(UnityEngine.Camera))

		var_35_0.transform.localPosition = Vector3.New(var_0_4.p_camera_pos[arg_35_2].x * arg_35_1 * -1, var_0_4.p_camera_pos[arg_35_2].y, var_0_4.p_camera_pos[arg_35_2].z)
		var_35_0.targetTexture = self:loadTexture("data/battle/texture/periscope.renderTexture")
		self._control.periscope_root.periscope.mask.texture.rawImage.texture = self:loadTexture("data/battle/texture/periscope.renderTexture")
		self._control.periscope_root.periscope.transform.localPosition = Vector3.New(160, -229, 0)
		self._control.periscope_root.periscope.bg.transform.localScale = Vector3.New(-1, 1, 1)

		if arg_35_1 == var_0_4.character_type.enemy then
			self._control.periscope_root.periscope.transform.localPosition = Vector3.New(-80, -229, 0)
			self._control.periscope_root.periscope.bg.transform.localScale = Vector3.New(1, 1, 1)
		end

		self._control.periscope_root.periscope.canvasGroup.alpha = 1
	end

	function arg_1_0:close_periscope()
		self._control.periscope_root.periscope.canvasGroup.alpha = 0
	end

	function arg_1_0:get_periscope_damage_parent()
		return self._control.periscope_root.periscope.mask.transform
	end

	function arg_1_0:show_support_attack(arg_38_1, arg_38_2, arg_38_3)
		self._support_type = arg_38_1

		local var_38_0, var_38_1 = var_0_4:get_support_attack_rule(arg_38_1)

		self._support_obj = self:createGameObject((var_0_4:get_final_battle_prefab_path(var_38_0)))

		self._support_obj.transform:SetParent(self._control.support_root.bg.mask.transform, false)

		self._support_func = arg_38_2

		local var_38_2 = self._support_obj:GetComponent(typeof(Spine.Unity.SkeletonGraphic))

		var_38_2.AnimationState:SetAnimation(var_38_1.priority, var_38_1.name, var_38_1.loop)

		local var_38_3 = var_38_2.AnimationState.Complete

		if arg_38_1 == gameenum.battle_type.support_attack_type.water_attack then
			self._control.support_root.bg.mask.support_water_attack = UnityEngine.Shader.Find("Spine/SkeletonGraphic (Premultiply Alpha)")
		end

		if arg_38_1 == gameenum.battle_type.support_attack_type.bombs_attack then
			var_38_2.material = self:loadMaterial(var_0_4.support_mat.bombing)
			self._control.support_root.bg.mask.support_bombers_attack = UnityEngine.Shader.Find("Spine/SkeletonGraphic (Premultiply Alpha)")
		end

		local function var_38_4()
			if self._support_func then
				self._support_func()

				self._support_func = nil
			end

			if arg_38_1 == gameenum.battle_type.support_attack_type.bombs_attack or arg_38_1 == gameenum.battle_type.support_attack_type.water_attack then
				self._control.support_root:SetActive(false)
			end

			self:close_support_attack()

			var_38_2.AnimationState.Complete = var_38_3

			self:destroyGameObject(self._support_obj)
		end

		var_38_3 = var_38_3 + var_38_4
		var_38_2.AnimationState.Complete = var_38_3
		var_38_3 = var_38_3 - var_38_4

		self._control.support_root:SetActive(true)

		self._control.support_root.bg.canvasGroup.alpha = 1
	end

	function arg_1_0:show_cannon_damage(arg_40_1)
		local var_40_0 = {
			name = var_0_4.cannon_damage_spine.name,
			loop = var_0_4.cannon_damage_spine.loop,
			priority = var_0_4.cannon_damage_spine.priority
		}

		self._cannon_damage_obj = self:createGameObject((var_0_4:get_final_battle_prefab_path(var_0_4.cannon_damage_spine.path)))

		self._cannon_damage_obj.transform:SetParent(self._control.support_root.transform, false)

		local var_40_1 = self._cannon_damage_obj:GetComponent(typeof(Spine.Unity.SkeletonGraphic))

		var_40_1.AnimationState:SetAnimation(var_40_0.priority, var_40_0.name, var_40_0.loop)

		local var_40_2 = var_40_1.AnimationState.Complete

		local function var_40_3()
			var_40_1.AnimationState.Complete = var_40_2

			self:close_support_attack()
			self._control.support_root:SetActive(false)
			self:destroyGameObject(self._cannon_damage_obj)
		end

		var_40_2 = var_40_1.AnimationState.Complete + var_40_3
		var_40_1.AnimationState.Complete = var_40_1.AnimationState.Complete + var_40_3
		var_40_2 = var_40_2 - var_40_3
		var_40_1.AnimationState.Event = var_40_1.AnimationState.Event + function(arg_42_0, arg_42_1)
			if arg_42_1.Data.Name == "damage_point" and arg_40_1 then
				arg_40_1()
			end
		end
	end

	function arg_1_0:close_support_attack()
		self._control.support_root.bg.canvasGroup.alpha = 0
	end

	function arg_1_0:close_click_support_attack()
		if self._support_type == gameenum.battle_type.support_attack_type.cannon_attack then
			self._control.support_root.bg.canvasGroup.alpha = 0
		else
			self._control.support_root:SetActive(false)
			self:destroyGameObject(self._support_obj)
		end
	end

	function arg_1_0:set_damagecontrol_num(arg_45_1)
		local var_45_0

		if arg_45_1 then
			var_45_0 = arg_45_1.damage_control_num or var_0_6:get_item_count(var_0_13.find_object_by_id(var_0_4.shop_damage_control_cid).content[1].id)
		end

		self._control.popup.combat_continue.frame.damagecontrol.gross.text.text = string.format("x%d", var_45_0)

		if var_45_0 >= 5 then
			self._control.popup.combat_continue.frame.damagecontrol.buy:SetActive(false)
		else
			self._control.popup.combat_continue.frame.damagecontrol.buy:SetActive(true)
		end
	end

	function arg_1_0.set_unitcamera_fov(arg_46_0)
		local var_46_0 = UnityEngine.GameObject.Find("UnitCamera"):GetComponent(typeof(UnityEngine.Camera))

		if var_46_0 then
			var_46_0.fieldOfView = 20.5 * (var_0_4.screen_ratio / (var_0_19.width / var_0_19.height > 1.7777777777777777 and 1.7777777777777777 or var_0_19.width / var_0_19.height))
			var_46_0.transform.position.y = 2.2
		end
	end

	function arg_1_0:__init_language()
		self._control.popup.combat_continue.frame.nightwarleft_btn.nightwarcontinue.text.text = var_0_2:getNowLang("nightwarcontinue")
		self._control.popup.combat_continue.frame.nightwarright_btn.nightwarcancel.text.text = var_0_2:getNowLang("nightwarcancel")
		self._control.popup.combat_continue.frame.tip.text.text.text = var_0_2:getNowLang("ui_combatpreparetip1")
		self._control.popup.combat_continue.frame.oil.oil.text.text = var_0_2:getNowLang("fuel")
		self._control.popup.combat_continue.frame.bullet.bullet.text.text = var_0_2:getNowLang("ammo")
		self._control.popup.combat_continue.frame.ui_combatcontinuetip.text.text = var_0_2:getNowLang("ui_combatcontinuetip")
	end

	function arg_1_0:__init_battle()
		self:set_unitcamera_fov()

		if app:isPC() then
			self._control.skip:SetActive(true)

			self._control.skip.transform:GetComponent("Canvas").sortingOrder = 504
		end

		local var_48_0 = var_0_6:get_battle_info()

		self.fight_type = var_48_0.type

		if var_48_0.type == gameenum.battle_type.fight_type.plot_main then
			var_0_3:start()
		end

		local var_48_2

		do
			var_0_3:loadRecord()

			local var_48_1 = false

			var_48_2 = self:autoKillDOTween(var_0_5.Sequence())
		end

		for iter_48_0 = 1, 0 do
			var_48_2:AppendInterval(0.06)
			var_48_2:AppendCallback(function()
				var_0_3:loadRecord(iter_48_0, var_48_1)
			end)
		end

		self.__max_normal_map_id = 101

		for iter_48_1, iter_48_2 in pairs((var_0_14.get_sequence())) do
			if iter_48_2.id >= self.__max_normal_map_id then
				self.__max_normal_map_id = iter_48_2.id
			end
		end

		self.__max_normal_map_id = self.__max_normal_map_id + 4

		self:play_day_bgm()

		self._control.hp_bar_root.transform:GetComponent("Canvas").sortingOrder = 102
		self._control.damage_text_root.transform:GetComponent("Canvas").sortingOrder = 102
		self._control.cutin_root.transform:GetComponent("Canvas").sortingOrder = 104
		self._control.dialogue_root.transform:GetComponent("Canvas").sortingOrder = 103
		self._control.support_root.transform:GetComponent("Canvas").sortingOrder = 102
	end

	function arg_1_0:play_day_bgm()
		local var_50_0 = var_0_6:get_battle_info()

		self:play_bgm_by_battle_type(var_0_6:get_new_battle_type(), var_50_0)

		if var_50_0.id == 0 then
			return
		end
	end

	function arg_1_0:__onReset()
		self._continue_frame_nightwarleft = nil
		self._change_fight_step = false
		self._support_func = nil
		self._node_point = nil
		self._hp_bar_status = true
		self._is_show_damage_cutin = false
		self._damage_cutin_num = 0
		self._clicked_skip = false

		self:destroyChildren("buff_bg")
		self:destroyChildren("aircontrol_content")
		self:destroyChildren("buff_detail")

		self._control.boss_hp_root.canvasGroup.alpha = 0

		self._control.support_root:SetActive(false)
		self._control.popup.combat_continue.frame.oil:SetActive(true)
		self._control.popup.combat_continue.frame.bullet:SetActive(true)
		self._control.popup.combat_continue.frame.damagecontrol:SetActive(true)
		self._control.popup.combat_continue.frame.abyss_power:SetActive(false)
		self._control.popup:SetActive(false)
		self._control.skip:SetActive(false)

		self._control.periscope_root.periscope.canvasGroup.alpha = 0

		self._control.middle.stage_bg:SetActive(false)

		if self._support_obj then
			self:destroyGameObject(self._support_obj)
		end

		if self._cannon_damage_obj then
			self:destroyGameObject(self._cannon_damage_obj)
		end
	end

	function arg_1_0:play_bgm_by_battle_type(arg_52_1, arg_52_2)
		if arg_52_1 == gameenum.battle_type.fight_type.maneuver or arg_52_1 == gameenum.battle_type.fight_type.campaign then
			self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.battle_day_two))
		elseif arg_52_1 == gameenum.battle_type.fight_type.climb_tower or arg_52_1 == gameenum.battle_type.fight_type.sixth then
			local var_52_0 = var_0_6:get_sixth_combat_info()
			local var_52_3

			if var_52_0 then
				local var_52_4 = var_0_22.find_object_by_id(var_52_0.id or 0)

				if var_52_4 then
					var_52_3 = var_52_4.music
				end
			end

			if var_52_3 then
				self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_52_3))
			else
				self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.battle_event_twenty_two))
			end
		elseif arg_52_1 == gameenum.battle_type.fight_type.abyss or arg_52_1 == gameenum.battle_type.fight_type.abyss_2 then
			self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.battle_day_two))
		elseif arg_52_1 == gameenum.battle_type.fight_type.main then
			self:_mian_fight()
		elseif arg_52_1 == gameenum.battle_type.fight_type.strike then
			local var_52_6 = var_0_23.find_object_by_id(arg_52_2.id or 0)

			if var_52_6 then
				self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_52_6.music1))
			else
				self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_52_6.battle_event_twenty_two))
			end
		elseif arg_52_1 == gameenum.battle_type.fight_type.push then
			self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_31.find_object_by_id(arg_52_2.id).music))
		elseif arg_52_1 == gameenum.battle_type.fight_type.seventh then
			self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_24.find_object_by_id(arg_52_2.id).music_battle))
		elseif arg_52_1 == gameenum.battle_type.fight_type.eighth then
			self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_30.find_object_by_id(arg_52_2.id).music_battle))
		elseif arg_52_1 == gameenum.battle_type.fight_type.score then
			local var_52_7 = var_0_6:get_current_score_map_start_point()

			self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_26.find_object_by_id(arg_52_2.id).music))
		elseif arg_52_1 == gameenum.battle_type.fight_type.ninth then
			self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_28.find_object_by_id(arg_52_2.id).music))
		end
	end

	function arg_1_0:_push_fight(arg_53_1)
		local var_53_0 = var_0_10.find_object_by_id(arg_53_1.point)

		if var_53_0.night_atk == 1 then
			self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.night_fight_one))
		else
			self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.battle_day_one))
		end

		if (var_53_0.node_type == var_0_4.map_node_type.boss or nil) and true then
			self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.battle_boss_one))
		end
	end

	function arg_1_0:_mian_fight()
		local var_54_0 = var_0_6:get_battle_info()
		local var_54_1 = var_0_14.find_object_by_id(var_54_0.id)

		if var_54_0.id < 100 then
			self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.battle_day_two))
		elseif var_54_0.id >= 101 and var_54_0.id <= 404 then
			if var_54_0.point == var_54_1.boss_node_id[1] then
				self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.battle_boss_one))
			else
				self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.battle_day_one))
			end
		elseif var_54_0.id >= 501 and var_54_0.id <= 604 then
			if var_54_0.point == var_54_1.boss_node_id[1] and var_54_0.point < 60000 then
				self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.battle_boss_one))
			elseif var_54_0.point == var_54_1.boss_node_id[1] and var_54_0.point > 60000 then
				self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.battle_boss_two))
			else
				self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.battle_day_two))
			end
		elseif var_54_0.id >= 701 and var_54_0.id <= 805 then
			if var_54_0.point == var_54_1.boss_node_id[1] then
				self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.battle_boss_two))
			else
				self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.battle_day_three))
			end
		elseif var_54_0.id <= self.__max_normal_map_id then
			if var_54_0.point == var_54_1.boss_node_id[1] then
				self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.battle_boss_two))
			else
				self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.battle_day_three))
			end
		end
	end

	function arg_1_0:play_night_bgm()
		local var_55_0 = var_0_6:get_battle_info()

		if var_55_0.id then
			if var_55_0.id >= 101 and var_55_0.id <= 404 then
				self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.night_fight_one))
			elseif var_55_0.id >= 501 and var_55_0.id <= 604 then
				self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.night_fight_two))
			elseif var_55_0.id >= 701 and var_55_0.id <= 805 then
				self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.night_fight_three))
			elseif var_55_0.id <= self.__max_normal_map_id then
				self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.night_fight_three))
			else
				self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.night_fight_two))
			end
		else
			self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.night_fight_one))
		end
	end

	function arg_1_0:_play_audio(arg_56_1)
		self:playBackgroundMusic(arg_56_1, true)
	end

	function arg_1_0:_play_into_se(arg_57_1)
		self:playSE(arg_57_1, false)
	end

	function arg_1_0.stop_all(arg_58_0)
		var_0_12:init()
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_59_0)
	local var_59_0 = var_0_1:class("battle")

	var_59_0._change_fight_step = false
	var_59_0._support_func = nil
	var_59_0._node_point = nil
	var_59_0._hp_bar_status = true
	var_59_0._is_show_damage_cutin = false
	var_59_0._damage_cutin_num = 0
	var_59_0._click_down_num = 0

	return var_59_0
end

return var_0_0
