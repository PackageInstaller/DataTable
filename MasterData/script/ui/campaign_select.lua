local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_3 = gameenum.common_type
local var_0_5 = gameconfig.monster_formation_config
local var_0_6 = gameconfig.monster_config
local var_0_7 = string.format
local var_0_8 = gamecore.Language
local var_0_9 = gamecore.user
local var_0_10 = gameconfig.robot_config
local var_0_11 = gameconfig.ship_config
local var_0_12 = gameconfig.sixth_map_config
local var_0_13 = gamecore.util_func
local var_0_14 = gameconfig.skin_config
local var_0_15 = gamecore.SceneManager
local var_0_16 = gameconfig.equip_config

gamecore.UILoader:define("campaign_select", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3)
		self:setVisible(true)

		self._enter_type = arg_2_2

		if var_0_3.open_broken then
			self._team_detail_data_for_open = arg_2_3
			self._team_detail_data = arg_2_3
		end

		self._team_use_bvr_info = arg_2_3
		self._use_bvr_enemy_info = arg_2_1

		self:__init_panel(arg_2_1)
	end

	function arg_1_0:__onUpdate()
		if not self._time_execute_task_list then
			return
		end

		for iter_3_0, iter_3_1 in ipairs(self._time_execute_task_list) do
			if iter_3_1.execute_time > 0 then
				iter_3_1.execute_time = iter_3_1.execute_time - Time.deltaTime

				if iter_3_1.execute_time <= 0 and iter_3_1.execute_func then
					if iter_3_0 == #self._time_execute_task_list then
						self._time_execute_task_list = nil
					end

					iter_3_1.execute_func()
				end
			end
		end
	end

	function arg_1_0:__init_panel(arg_4_1)
		self:__reset_close_bvr()
		self:__init_effects()

		if self._enter_type == var_0_3.select_prepare_type.campaign or self._enter_type == var_0_3.select_prepare_type.sixth_select then
			self._control.campaign_bg:SetActive(true)
			self._control.exercise_bg:SetActive(false)
		elseif self._enter_type == var_0_3.select_prepare_type.strike or self._enter_type == var_0_3.select_prepare_type.tower_fight then
			local var_4_0 = var_0_1:getInstance("strike_map")

			if var_4_0 then
				self._panel.transform:GetComponent("Canvas").sortingOrder = var_4_0._panel.transform:GetComponent("Canvas").sortingOrder + 1
				var_4_0._control.main.top.return_btn.button.enabled = true
			end

			self._control.campaign_bg:SetActive(false)
			self._control.exercise_bg:SetActive(false)
		else
			self._control.campaign_bg:SetActive(false)
			self._control.exercise_bg:SetActive(true)
		end

		if self._enter_type == var_0_3.select_prepare_type.sixth_select then
			self._control.mask:SetActive(false)
			self._control.title_bg:SetActive(true)

			self._control.title_bg.title_txt.text.text = var_0_12.find_object_by_id(tonumber((string.sub(arg_4_1.point, 1, 4)))).sub_title
		elseif self._enter_type == var_0_3.select_prepare_type.campaign then
			self._control.mask:SetActive(false)
			self._control.title_bg:SetActive(false)
		else
			self._control.title_bg:SetActive(false)
		end

		self:_set_bvr_btn(arg_4_1)

		self._control.enemy_info_bg.back_btn.text.text.text = var_0_8:getNowLang("ui_combat_return")
		self._control.enemy_info_bg.fight_btn.text.text.text = var_0_8:getNowLang("pvestartwar")
		self._control.encounter_bg.round_about_lock_enemy_txt.text.text = var_0_8:getNowLang("combat_radar_probability")

		if arg_4_1 and next(arg_4_1) then
			if var_0_13.have_index(arg_4_1, "search_rate") then
				local var_4_1 = arg_4_1.search_rate

				if arg_4_1.search_rate > 100 then
					var_4_1 = 100
				elseif var_4_1 < 0 then
					var_4_1 = 0
				end

				self._control.encounter_bg.round_about_lock_enemy_txt.lock_enemy_info_bg.lock_enemy_info_txt.text.text = var_4_1 .. "%"
			else
				self._control.encounter_bg.round_about_lock_enemy_txt.lock_enemy_info_bg.lock_enemy_info_txt.text.text = 50 .. "%"
			end
		end

		self._control.encounter_bg.canvasGroup.alpha = 1

		local var_4_2 = {}
		local var_4_3 = {
			can_not_skip = false
		}

		var_4_3.execute_time = 1.5

		function var_4_3.execute_func()
			self._control.encounter_bg.canvasGroup.alpha = 0

			self._control.encounter_bg.encounter_spine.skeletonGraphic.AnimationState:ClearTracks()

			if arg_4_1.search then
				self:__toggle_lock_enemy(true, arg_4_1)
			else
				self:__toggle_lost_enemy(true)
			end
		end

		var_4_2[#var_4_2 + 1] = var_4_3
		self._time_execute_task_list = var_4_2

		self._control.encounter_bg.encounter_spine.skeletonGraphic.AnimationState:SetAnimation(0, "encounter_new", false)
		self:change_bgm()
	end

	function arg_1_0:__reset_close_bvr()
		self._set_bvr_btn_isOn = false

		self._control.enemy_info_bg.bvr_btn.spine_effect:SetActive(false)
		self._control.enemy_info_bg.bvr_btn:SetActive(false)
		var_0_9:req_BVRAttackChangeReq(false)
	end

	function arg_1_0:_set_bvr_btn(arg_7_1)
		if self._enter_type == var_0_3.select_prepare_type.exercise or self._enter_type == var_0_3.select_prepare_type.friend_exercise or self._enter_type == var_0_3.select_prepare_type.sixth_select or self._enter_type == var_0_3.select_prepare_type.campaign then
			self._control.enemy_info_bg.bvr_btn:SetActive(false)

			return
		end

		self._now_btn_pos = self._control.enemy_info_bg.back_btn.transform.localPosition

		local var_7_0 = false
		local var_7_1 = 0
		local var_7_3 = 0
		local var_7_4 = 0
		local var_7_5 = 0

		for iter_7_0, iter_7_1 in pairs(self._team_use_bvr_info) do
			local var_7_6 = false
			local var_7_7 = false

			if iter_7_1.type == 30 or iter_7_1.type == 13 then
				var_7_5 = var_7_5 + 1

				if iter_7_1.now_hp / iter_7_1.hp < 0.25 then
					var_7_3 = var_7_3 + 1
				end
			end

			for iter_7_2, iter_7_3 in pairs(iter_7_1.equips) do
				if var_0_16.find_object_by_cid(iter_7_3.id) and var_0_16.find_object_by_cid(iter_7_3.id).type == 32 then
					var_7_7 = true

					break
				end
			end

			for iter_7_4, iter_7_5 in pairs(iter_7_1.equips) do
				if iter_7_5.carry_type == 3 and iter_7_5.num >= 2 and var_0_16.find_object_by_cid(iter_7_5.id) then
					if var_0_16.find_object_by_cid(iter_7_5.id).bore_type == 41 then
						var_7_6 = true
					elseif iter_7_1.type == 13 then
						var_7_6 = true
					end
				end

				if var_7_7 and var_7_6 then
					var_7_4 = var_7_4 + 1

					break
				end
			end
		end

		if var_7_4 > 0 then
			var_7_0 = var_7_3 ~= var_7_5

			self._control.enemy_info_bg.bvr_btn:SetActive(true)

			self._control.enemy_info_bg.bvr_btn.transform.localPosition = Vector3.New(self._now_btn_pos.x - 194, self._now_btn_pos.y, self._now_btn_pos.z)
		end

		if arg_7_1.monster_array and next(arg_7_1.monster_array) then
			for iter_7_6, iter_7_7 in pairs(arg_7_1.monster_array) do
				local var_7_8 = var_0_6.find_object_by_id(iter_7_7)

				if var_7_8.type == 14 or var_7_8.type == 15 then
					var_7_1 = var_7_1 + 1
				end
			end

			if var_7_1 == #arg_7_1.monster_array then
				var_7_0 = false
			end
		end

		if self._enter_type == var_0_3.select_prepare_type.strike then
			self._control.enemy_info_bg.bvr_btn:SetActive(var_7_0)
		end
	end

	function arg_1_0:__init_effects()
		local function var_8_0(arg_9_0, arg_9_1)
			arg_9_0.skeletonDataAsset = self:loadSkeletonDataAsset(self:convertToJP(var_0_7(var_0_3.effect_path, arg_9_1, arg_9_1), "effect"))
			arg_9_0.material = self:loadMaterial(self:convertToJP(var_0_7(var_0_3.effect_material, arg_9_1, arg_9_1), "effect"))
			arg_9_0.initialSkinName = "default"

			arg_9_0:Initialize(true)
		end

		var_8_0(self._control.encounter_bg.encounter_spine.skeletonGraphic, "encounter_new")
		var_8_0(self._control.lock_enemy_bg.lock_enemy_spine.skeletonGraphic, "lock_the_enemy")
	end

	function arg_1_0:__play_into_bgm(arg_10_1)
		self:playBackgroundMusic(arg_10_1)
	end

	function arg_1_0:change_bgm()
		if self._enter_type == var_0_3.select_prepare_type.friend_exercise then
			self:__play_into_bgm(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.fignt_one))
		end
	end

	function arg_1_0:__toggle_lock_enemy(arg_12_1, arg_12_2)
		if arg_12_1 then
			self._control.lock_enemy_bg.canvasGroup.alpha = 1

			self._control.lock_enemy_bg.radar_frame.radar_effect1.dOTweenAnimation:DORestart()
			self._control.lock_enemy_bg.radar_frame.radar_effect2.dOTweenAnimation:DORestart()

			local function var_12_0()
				self._control.lock_enemy_bg.canvasGroup.alpha = 0

				self._control.lock_enemy_bg.lock_enemy_spine.skeletonGraphic.AnimationState:ClearTracks()
				self:__toggle_enemy_info(true, arg_12_2)
			end

			local var_12_1 = {}
			local var_12_2 = {}

			var_12_2.execute_time = 1.5
			var_12_2.execute_func = var_12_0
			var_12_2.skip_func = var_12_0
			var_12_1[#var_12_1 + 1] = var_12_2
			self._time_execute_task_list = var_12_1

			self._control.lock_enemy_bg.lock_enemy_spine.skeletonGraphic.AnimationState:SetAnimation(0, "lock_the_enemy", false)

			if self._enter_type == var_0_3.select_prepare_type.friend_exercise then
				local var_12_3 = var_0_9:get_friend_info(var_0_9:get_friend_id())
				local var_12_4 = var_12_3 and var_0_13.little_clone(var_12_3).mansion or {}
				local var_12_5

				if var_12_4 then
					var_12_5 = var_12_4.garrison
				end

				if var_12_5 then
					self:__show_monster_formation_2(self._control.lock_enemy_bg.radar_frame.monster_formation, arg_12_2.formation, var_12_5)
				end
			elseif self._enter_type == var_0_3.select_prepare_type.exercise then
				local var_12_6 = var_0_9:get_battle_info()
				local var_12_7 = var_0_9:get_maneuver_target_info().garrison

				if var_12_7 and next(var_12_7) then
					self:__show_monster_formation_2(self._control.lock_enemy_bg.radar_frame.monster_formation, arg_12_2.formation, var_12_7)
				else
					local var_12_8

					if var_0_10.find_object_by_id(var_12_6.id) then
						var_12_8 = var_0_10.find_object_by_id(var_12_6.id).npc_formation
					end

					if var_12_8 then
						self:__show_monster_formation(var_12_8, self._control.lock_enemy_bg.radar_frame.monster_formation)
					end
				end
			else
				self:__show_monster_formation(arg_12_2.monster, self._control.lock_enemy_bg.radar_frame.monster_formation)
			end
		else
			self._control.lock_enemy_bg.canvasGroup.alpha = 0

			self._control.lock_enemy_bg.lock_enemy_spine.skeletonGraphic.AnimationState:ClearTracks()
		end
	end

	function arg_1_0:__toggle_lost_enemy(arg_14_1)
		if arg_14_1 then
			self._control.lost_enemy_bg.canvasGroup.alpha = 1
			self._control.lost_enemy_bg.title.text.text = var_0_8:getNowLang("warscene1seachfail")

			self._control.lost_enemy_bg.radar_frame.radar_effect1.dOTweenAnimation:DORestart()
			self._control.lost_enemy_bg.radar_frame.radar_effect2.dOTweenAnimation:DORestart()

			local var_14_0 = {}
			local var_14_1 = {}

			var_14_1.execute_time = 1

			function var_14_1.execute_func()
				self._control.lost_enemy_bg.canvasGroup.alpha = 0

				if self:__ship_count_in_team_check() then
					self:__toggle_select_formation(true)
				else
					self:__select_formation(1)
				end
			end

			var_14_0[#var_14_0 + 1] = var_14_1
			self._time_execute_task_list = var_14_0
		else
			self._control.lost_enemy_bg.canvasGroup.alpha = 0
		end
	end

	function arg_1_0:__ship_count_in_team_check()
		local var_16_0 = var_0_9:get_battle_info()

		if self._enter_type == var_0_3.select_prepare_type.exercise or self._enter_type == var_0_3.select_prepare_type.friend_exercise or self._enter_type == var_0_3.select_prepare_type.seventh or self._enter_type == var_0_3.select_prepare_type.tower_fight or self._enter_type == var_0_3.select_prepare_type.eighth then
			for iter_16_0 = 1, 4 do
				if var_16_0.team == iter_16_0 then
					local var_16_1 = var_0_9:get_team_data(1, iter_16_0)
					local var_16_2 = var_16_1 and var_0_13.little_clone(var_16_1) or {}

					if var_16_2 and var_16_2.members then
						if self._enter_type == var_0_3.select_prepare_type.exercise or self._enter_type == var_0_3.select_prepare_type.friend_exercise or self._enter_type == var_0_3.select_prepare_type.seventh or self._enter_type == var_0_3.select_prepare_type.eighth or self._enter_type == var_0_3.select_prepare_type.tower_fight then
							self._team_detail_data = var_16_2.members
						end

						return #var_16_2.members >= 4
					end
				end
			end
		elseif self._enter_type == var_0_3.select_prepare_type.campaign then
			local var_16_3 = var_0_9:get_campaign_members(var_16_0.id)

			self._team_detail_data = var_16_3 and var_0_13.little_clone(var_16_3) or {}

			return var_0_13.get_value_greater_than_zero(self._team_detail_data) >= 4
		elseif self._enter_type == var_0_3.select_prepare_type.sixth_select then
			local var_16_4 = var_0_9:get_sixth_combat_info()
			local var_16_5 = (var_16_4 and var_0_13.little_clone(var_16_4) or {}).members

			if not (var_16_4 and var_0_13.little_clone(var_16_4) or {}).members then
				self._team_detail_data = {}
			end

			return var_0_13.get_value_greater_than_zero(self._team_detail_data) >= 4
		elseif self._enter_type == var_0_3.select_prepare_type.strike then
			local var_16_6 = var_0_9:get_strike_team_data()

			self._team_detail_data = var_16_6 and var_0_13.little_clone(var_16_6) or {} or {}

			return var_0_13.get_value_greater_than_zero(self._team_detail_data) >= 4
		elseif self._enter_type == var_0_3.select_prepare_type.ocean then
			local var_16_7 = var_0_9:get_ocean_team_data()

			self._team_detail_data = var_16_7 and var_0_13.little_clone(var_16_7) or {} or {}

			return var_0_13.get_value_greater_than_zero(self._team_detail_data) >= 4
		end

		return false
	end

	function arg_1_0:__toggle_select_formation(arg_17_1)
		if arg_17_1 then
			if self._enter_type == var_0_3.select_prepare_type.campaign then
				self._control.mask:SetActive(false)
			end

			if self._enter_type == var_0_3.select_prepare_type.sixth_select then
				self._control.campaign_bg:SetActive(false)
				self._control.exercise_bg:SetActive(true)
			end

			for iter_17_0 = 1, 5 do
				local var_17_0 = var_0_8:getNowLang(var_0_7("warformationdesc%d_2", iter_17_0))
				local var_17_1 = self._control.select_formation.right_widget[var_0_7("select%d", iter_17_0)]

				var_17_1.desc_mask.textScroller:SetText((var_0_8:getNowLang(var_0_7("warformationdesc%d", iter_17_0))))
				var_17_1.detail_mask.textScroller:SetText(var_17_0)

				for iter_17_1 = 1, 5 do
					self._control.select_formation.right_widget["select" .. iter_17_1].name_txt.text.text = var_0_8:getNowLang("warformation" .. iter_17_1)
				end

				local var_17_2 = 0

				for iter_17_2, iter_17_3 in pairs(self._team_detail_data) do
					if iter_17_3 ~= 0 then
						var_17_2 = var_17_2 + 1
					end
				end

				for iter_17_4 = 4, 6 do
					if var_17_2 == iter_17_4 then
						var_17_1[var_0_7("formation%s", iter_17_4)]:SetActive(true)
					else
						var_17_1[var_0_7("formation%s", iter_17_4)]:SetActive(false)
					end
				end
			end

			if self._team_detail_data and next(self._team_detail_data) or self._team_detail_data_for_open and next(self._team_detail_data_for_open) then
				for iter_17_5, iter_17_6 in ipairs((not self._team_detail_data_for_open or nil) and {}) do
					local var_17_5 = var_0_9:find_character_by_id(iter_17_6.id)
					local var_17_6 = var_0_13:get_ship_attr(var_17_5, (var_0_11.find_object_by_cid(iter_17_6.cid)))

					if var_17_6 ~= nil then
						for iter_17_7, iter_17_8 in pairs(var_17_6) do
							if iter_17_7 == "hp" and var_17_5[iter_17_7] then
								var_17_5[iter_17_7] = iter_17_8
							end
						end
					end
				end

				local var_17_8 = ""
				local var_17_9 = ""
				local var_17_11 = ""
				local var_17_12 = ""
				local var_17_13 = ""

				if var_0_3.open_broken and self._team_detail_data_for_open and self._team_detail_data_for_open[1] then
					var_17_8 = var_0_11.find_object_by_cid(self._team_detail_data_for_open[1].cid)
					var_17_9 = var_17_8.pic_id

					local var_17_14 = self._team_detail_data_for_open[1].now_hp / self._team_detail_data_for_open[1].hp < var_0_3.health_sprite_rule.yellow.max_value

					var_17_13 = var_0_14.find_object_by_cid(var_0_9:find_character_by_id(self._team_detail_data_for_open[1].id).skin)
					var_17_11 = var_17_8.battle_pic == 1 and not var_17_14 and (var_17_13 and var_17_13.battle_pic ~= 1 and var_0_13:use_big_break_painting(self._team_detail_data_for_open[1], var_0_3.ship_icon_type.model_l, true) or var_0_13:use_big_break_painting(self._team_detail_data_for_open[1], var_0_3.ship_icon_type.model_l, true, true)) or var_17_13 and var_17_13.battle_pic == 1 and not var_17_14 and var_0_13:use_big_break_painting(self._team_detail_data_for_open[1], var_0_3.ship_icon_type.model_l, true, true) or var_0_13:use_big_break_painting(self._team_detail_data_for_open[1], var_0_3.ship_icon_type.model_l, true)
					var_17_12 = var_17_13 and var_0_7(var_17_11, var_17_13.skin_id, var_17_13.skin_id) or var_0_7(var_17_11, var_17_9, var_17_9)
				else
					var_17_8 = var_0_11.find_object_by_cid(var_0_9:find_character_by_id(self._team_detail_data[1]).cid)
					var_17_9 = var_17_8.pic_id

					local var_17_15 = var_0_9:find_character_by_id(self._team_detail_data[1])
					local var_17_16 = var_17_15.now_hp / var_17_15.hp < var_0_3.health_sprite_rule.yellow.max_value

					var_17_13 = var_0_14.find_object_by_cid(var_17_15.skin)
					var_17_11 = var_17_8.battle_pic == 1 and not var_17_16 and (var_17_13 and var_17_13.battle_pic ~= 1 and var_0_13:use_big_break_painting(self._team_detail_data[1], var_0_3.ship_icon_type.model_l, true) or var_0_13:use_big_break_painting(self._team_detail_data[1], var_0_3.ship_icon_type.model_l, true, true)) or var_17_13 and var_17_13.battle_pic == 1 and not var_17_16 and var_0_13:use_big_break_painting(self._team_detail_data[1], var_0_3.ship_icon_type.model_l, true, true) or var_0_13:use_big_break_painting(self._team_detail_data[1], var_0_3.ship_icon_type.model_l, true)
					var_17_12 = var_17_13 and var_0_7(var_17_11, var_17_13.skin_id, var_17_13.skin_id) or var_0_7(var_17_11, var_17_9, var_17_9)
				end

				local var_17_17 = 0.3
				local var_17_18 = 0
				local var_17_19, var_17_20 = self:loadSprite(var_17_12)

				self._control.select_formation.left_widget.first_ship_pic.image.sprite = var_17_19

				if var_17_20 then
					var_0_3:hd_sprite_half_scale(self._control.select_formation.left_widget.first_ship_pic.transform)
				end

				self._control.select_formation.left_widget.word_bg.first_ship_name.text.text = var_17_8.title
				self._control.select_formation.left_widget.word_bg.first_ship_word.text.text = var_17_13 and var_17_13.formation_dialogue and var_17_13.formation_dialogue ~= "" and var_17_13.formation_dialogue or (not var_17_8.formation_dialogue or var_17_8.formation_dialogue == tostring(0) or var_17_8.formation_dialogue == "") and var_0_8:getNowLang("pveselectformation") or var_17_8.formation_dialogue
				self._control.select_formation.right_widget.title_txt.text.text = var_0_8:getNowLang("pveselectformation")
				self._control.select_formation.left_widget.rectTransform.anchoredPosition = Vector2(-800, 0)

				self._control.select_formation.left_widget.rectTransform:DOAnchorPos(Vector2(0, 0), var_17_17):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(var_17_18):SetAutoKill(true)

				self._control.select_formation.right_widget.rectTransform.anchoredPosition = Vector2(800, 0)

				self._control.select_formation.right_widget.rectTransform:DOAnchorPos(Vector2(0, 0), var_17_17):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(var_17_18):SetAutoKill(true)

				local var_17_21
				local var_17_22

				if var_17_13 and var_17_13.cv_id then
					var_17_22 = var_17_13.cv_id
				end

				var_17_21 = var_17_22 and var_17_22 ~= 0 and var_17_22 ~= "0" and var_17_22 or var_17_9

				self:playCV(var_0_7("%s/%s_formation.mp3", var_17_21, var_17_21), false, "cv")
			end

			self._control.select_formation.canvasGroup.alpha = 1
			self._control.select_formation.canvasGroup.blocksRaycasts = true
		else
			self._control.select_formation.canvasGroup.alpha = 0
			self._control.select_formation.canvasGroup.blocksRaycasts = false
		end
	end

	function arg_1_0:__select_formation(arg_18_1)
		self:__toggle_select_formation(false)

		self._formation_id = arg_18_1

		var_0_9:req_StartBattleReq(arg_18_1)
	end

	function arg_1_0.__show_monster_formation(arg_19_0, arg_19_1, arg_19_2)
		local var_19_0 = var_0_5.find_object_by_id(arg_19_1)

		if var_19_0 then
			local var_19_1 = #var_19_0.formation

			for iter_19_0 = 1, 5 do
				arg_19_2[var_0_7("formation%d", iter_19_0)].canvasGroup.alpha = 0

				if iter_19_0 == var_19_0.formation_id then
					for iter_19_1 = 1, 6 do
						arg_19_2[var_0_7("formation%d", iter_19_0)][var_0_7("num%d", iter_19_1)].gameObject:SetActive(iter_19_1 == var_19_1)
					end

					arg_19_2[var_0_7("formation%d", iter_19_0)].canvasGroup.alpha = 1
				end
			end
		end

		return var_19_0
	end

	function arg_1_0.__show_monster_formation_2(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
		for iter_20_0 = 1, 5 do
			arg_20_1[var_0_7("formation%d", iter_20_0)].canvasGroup.alpha = 0

			if iter_20_0 == arg_20_2 then
				for iter_20_1 = 1, 6 do
					arg_20_1[var_0_7("formation%d", iter_20_0)][var_0_7("num%d", iter_20_1)].gameObject:SetActive(iter_20_1 == #arg_20_3)
				end

				arg_20_1[var_0_7("formation%d", iter_20_0)].canvasGroup.alpha = 1
			end
		end
	end

	function arg_1_0:__toggle_enemy_info(arg_21_1, arg_21_2)
		self._control.enemy_info_bg.canvasGroup.alpha = arg_21_1 and 1 or 0

		self._control.enemy_info_bg.fight_btn:SetActive(true)
		self._control.enemy_info_bg.back_btn:SetActive(true)

		self._control.enemy_info_bg.canvasGroup.blocksRaycasts = arg_21_1

		self._control.mask:SetActive(true)

		if arg_21_1 and self._enter_type == var_0_3.select_prepare_type.sixth_select then
			self._control.campaign_bg:SetActive(false)

			self._control.exercise_bg.image.sprite = self:loadSprite("data/ui/common_bg/common_bg_2.png")

			self._control.exercise_bg:SetActive(true)
		elseif arg_21_1 and self._enter_type == var_0_3.select_prepare_type.campaign then
			self._control.mask:SetActive(false)
		end

		if arg_21_1 and arg_21_2 and next(arg_21_2) then
			self._control.enemy_info_bg.radar_frame.radar_effect1.dOTweenAnimation:DORestart()
			self._control.enemy_info_bg.radar_frame.radar_effect2.dOTweenAnimation:DORestart()

			if self._enter_type == var_0_3.select_prepare_type.campaign or self._enter_type == var_0_3.select_prepare_type.sixth_select or self._enter_type == var_0_3.select_prepare_type.tower_fight or self._enter_type == var_0_3.select_prepare_type.seventh or self._enter_type == var_0_3.select_prepare_type.strike or self._enter_type == var_0_3.select_prepare_type.eighth then
				local var_21_1 = self:__show_monster_formation(arg_21_2.monster, self._control.enemy_info_bg.radar_frame.monster_formation)

				if not var_21_1 then
					return
				end

				self._control.enemy_info_bg.enemy_info_txt.text.text = var_0_8:getNowLang("warenemy") .. "-" .. var_0_8:getNowLang(var_0_7("warformation%s", var_21_1.formation_id))

				for iter_21_0, iter_21_1 in pairs(var_21_1.formation) do
					local var_21_2 = var_0_6.find_object_by_id(iter_21_1)
					local var_21_3, var_21_4 = self:loadUIPrefab("fight_info_item", self._control.enemy_info_bg.enemy_list.rectTransform)

					var_21_3:setVisible(true)

					var_21_4.bg.ship_flag.image.enabled = iter_21_0 == 1
					var_21_4.bg.ship_type.text.text = var_0_8:getNowLang(var_0_3:get_ship_type_language_key(var_21_2.type, 1))
					var_21_4.bg.ship_icon.image.sprite = self:loadSprite(var_0_3:get_ship_icon(var_0_3.ship_icon.model_normal_s, var_21_2.pic_id))
					var_21_4.bg.image.sprite = self:loadSprite(var_0_3.ship_attrib_bg[var_21_2.star])
				end
			elseif self._enter_type == var_0_3.select_prepare_type.exercise then
				local var_21_5 = var_0_9:get_battle_info()

				if var_21_5 then
					self._exercise_id = var_21_5.id

					local var_21_6 = var_0_9:get_maneuver_data_byid(self._exercise_id)
					local var_21_7 = var_21_6 and var_0_13.little_clone(var_21_6.garrison) or {}

					if var_21_7 and next(var_21_7) then
						self:__show_monster_formation_2(self._control.enemy_info_bg.radar_frame.monster_formation, arg_21_2.formation, var_21_7)
					else
						if not var_0_10.find_object_by_id(self._exercise_id) then
							var_0_9:set_bug_id(self._exercise_id)
						end

						if self._exercise_id then
							local var_21_9 = var_0_10.find_object_by_id(self._exercise_id)

							if var_21_9 then
								var_21_7 = var_0_5.find_object_by_id(var_21_9.npc_formation).formation

								local var_21_10 = self:__show_monster_formation(var_21_9.npc_formation, self._control.enemy_info_bg.radar_frame.monster_formation).formation_id
							end
						end
					end

					self._control.enemy_info_bg.enemy_info_txt.text.text = var_0_8:getNowLang("warenemy") .. "-" .. var_0_8:getNowLang(var_0_7("warformation%s", var_0_9:get_maneuver_resp_info().formation))

					for iter_21_2, iter_21_3 in pairs(var_21_7) do
						local var_21_11 = var_0_6.find_object_by_id(iter_21_3) or var_0_11.find_object_by_cid(iter_21_3.cid)
						local var_21_12

						if iter_21_3 and type(iter_21_3) ~= "number" and iter_21_3.skin ~= 0 then
							local var_21_13 = var_0_14.find_object_by_cid(iter_21_3.skin).icon

							var_21_12 = var_0_3:get_ship_icon(var_0_3.ship_icon.model_normal_s, tostring(var_21_13), tostring(var_21_13))
						else
							var_21_12 = var_0_3:get_ship_icon(var_0_3.ship_icon.model_normal_s, tostring(var_21_11.pic_id), tostring(var_21_11.pic_id))
						end

						local var_21_14, var_21_15 = self:loadUIPrefab("fight_info_item", self._control.enemy_info_bg.enemy_list.rectTransform)

						var_21_14:setVisible(true)

						var_21_15.bg.ship_flag.image.enabled = iter_21_2 == 1
						var_21_15.bg.ship_type.text.text = var_0_8:getNowLang(var_0_3:get_ship_type_language_key(var_21_11.type, 1))
						var_21_15.bg.ship_icon.image.sprite = self:loadSprite(var_21_12)
						var_21_15.bg.image.sprite = self:loadSprite(var_0_3.ship_attrib_bg[var_21_11.star])
					end
				end
			elseif self._enter_type == var_0_3.select_prepare_type.friend_exercise and var_0_9:get_battle_info() then
				local var_21_16 = var_0_9:get_friend_info(var_0_9:get_friend_id())
				local var_21_17 = (var_21_16 and var_0_13.little_clone(var_21_16).mansion or {}).garrison

				self:__show_monster_formation_2(self._control.enemy_info_bg.radar_frame.monster_formation, arg_21_2.formation, (var_21_16 and var_0_13.little_clone(var_21_16).mansion or {}).garrison)

				self._control.enemy_info_bg.enemy_info_txt.text.text = var_0_8:getNowLang("warenemy") .. "-" .. var_0_8:getNowLang(var_0_7("warformation%s", arg_21_2.formation))

				for iter_21_4, iter_21_5 in pairs(var_21_17) do
					local var_21_18 = var_0_11.find_object_by_cid(iter_21_5.cid)
					local var_21_19 = var_21_18.pic_id

					if iter_21_5.skin ~= 0 then
						var_21_19 = var_0_14.find_object_by_cid(iter_21_5.skin).icon
					end

					local var_21_20, var_21_21 = self:loadUIPrefab("fight_info_item", self._control.enemy_info_bg.enemy_list.rectTransform)

					var_21_20:setVisible(true)

					var_21_21.bg.image.sprite = self:loadSprite(var_0_3.ship_attrib_bg[var_21_18.star])
					var_21_21.bg.ship_flag.image.enabled = iter_21_4 == 1
					var_21_21.bg.ship_type.text.text = var_0_8:getNowLang(var_0_3:get_ship_type_language_key(var_21_18.type, 1))
					var_21_21.bg.ship_icon.image.sprite = self:loadSprite(var_0_3:get_ship_icon(var_0_3.ship_icon.model_normal_s, var_21_19))
				end
			end
		end
	end

	function arg_1_0:__reset_panel()
		self:__toggle_lock_enemy(false)
		self:__toggle_enemy_info(false)
		self:__toggle_lost_enemy(false)
		self:__toggle_select_formation(false)
		self:destroyChildren("fight_info_item")
	end

	function arg_1_0.__play_animation(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
		arg_23_1.skeletonGraphic.AnimationState:SetAnimation(0, arg_23_2, arg_23_3)
	end

	function arg_1_0:_play_into_se(arg_24_1)
		self:playSE(arg_24_1, false)
	end

	function arg_1_0:__start_battle_response(arg_25_1)
		local var_25_0 = {}
		local var_25_1 = {
			can_not_skip = true
		}

		var_25_1.execute_time = 0.5

		function var_25_1.execute_func()
			var_0_15:loadScene(var_0_3:get_battle_scene_name(), function()
				self:__reset_panel()
				var_0_1:destroyInstance("campaign_select")
				var_0_1:destroyStateUISet("game")
				var_0_1:createInstance(var_0_3:get_battle_name()):show()
			end)
		end

		var_25_0[#var_25_0 + 1] = var_25_1
		self._time_execute_task_list = var_25_0

		self._control.enemy_info_bg.fight_btn:SetActive(false)
		self._control.enemy_info_bg.back_btn:SetActive(false)
	end

	function arg_1_0:__onReset()
		self:__reset_panel()
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0:create()
	local var_29_0 = var_0_1:class("campaign_select")

	var_29_0._time_execute_task_list = nil
	var_29_0._enter_type = self._enter_type
	var_29_0._exercise_id = nil
	var_29_0._formation_id = nil
	var_29_0._team_detail_data = {}
	var_29_0._team_detail_data_for_open = {}

	return var_29_0
end

return var_0_0
