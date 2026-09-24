local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_5 = gameenum.common_type
local var_0_6 = gameenum.battle_type
local var_0_7 = string.format
local var_0_8 = table.insert
local var_0_10 = gameconfig.ship_config
local var_0_11 = DG.Tweening.DOTween
local var_0_12 = gameconfig.monster_config
local var_0_13 = gameconfig.monster_formation_config
local var_0_14 = gameconfig.map_config
local var_0_15 = gameconfig.pve_active_map_config
local var_0_16 = gameconfig.map_node_config
local var_0_17 = gameconfig.item_config
local var_0_18 = gameconfig.pve_active_map_node_config
local var_0_19 = gameconfig.skin_config
local var_0_21 = gameconfig.sixth_map_config
local var_0_22 = gameconfig.sixth_map_node_config
local var_0_23 = gameconfig.cinema_story_id_list_config
local var_0_24 = gameconfig.tactics_config
local var_0_25 = gameconfig.fifth_map_node_config
local var_0_26 = gameconfig.ocean_map_node_config
local var_0_27 = gamecore.util_func
local var_0_28 = gameconfig.pve_fifth_level_config
local var_0_29 = gameconfig.pve_mix_map_config
local var_0_31 = gameconfig.pve_mix_level_node_config
local var_0_32 = gameconfig.pve_eighth_map_config
local var_0_33 = gameconfig.pve_eighth_level_node_config
local var_0_35 = UnityEngine.Vector2
local var_0_36 = gameconfig.abyss_map_node_config
local var_0_37 = gameconfig.ship_pve_active_config
local var_0_38 = gameconfig.abyss_chapter_config
local var_0_39 = gamecore.prompt
local var_0_40 = lx.UserData
local var_0_41 = gamecore.UserDataManager
local var_0_42 = gameconfig.strike_map_config
local var_0_44 = gameconfig.chat_head_config
local var_0_45 = gameconfig.score_map_node_config
local var_0_46 = gameconfig.pve_ninth_level_config
local var_0_47 = gameconfig.pve_ninth_level_node_config
local var_0_48 = {
	"rank_SS",
	"rank_S",
	"rank_A",
	"rank_B",
	"rank_C",
	"rank_D",
	"rank_E"
}

gamecore.UILoader:define("combat_result", function(arg_1_0)
	function arg_1_0.updata_data(arg_2_0)
		return
	end

	function arg_1_0:show(arg_3_1, arg_3_2)
		self._tower_battle_data = arg_3_1
		self._data = var_0_27.little_clone(arg_3_1)

		self:__set_story_data(arg_3_2)
		self:setVisible(true)
		self:__init_panel(self._data, arg_3_2)

		self._enter_type = arg_3_2

		local var_3_0 = var_0_3:get_battle_info()

		self._battle_info_type = var_0_3:get_battle_info().type
		self._battle_info_team = var_0_3:get_battle_info().team
		self._battle_info_id = var_0_3:get_battle_info().id
		self._battle_info_point = var_0_3:get_battle_info().point

		if var_3_0.type == var_0_5.enter_get_battle_type.main_settlement then
			self._control.bg.image.sprite = self:loadSprite(string.format(var_0_5.map_path, var_3_0.id, var_3_0.id))
		end
	end

	function arg_1_0.__onVisible(arg_4_0, arg_4_1)
		if not arg_4_1 then
			return
		end

		arg_4_0._already_init = true
	end

	function arg_1_0:__set_story_data(arg_5_1)
		if arg_5_1 == var_0_5.fight_type.event_story and var_0_3:get_battle_info().type ~= var_0_5.battle_type.strike and (not var_0_3:get_new_battle_type() or var_0_3:get_new_battle_type() ~= gameenum.battle_type.fight_type.strike) then
			local var_5_0 = var_0_3:get_battle_info()

			if var_5_0 then
				local var_5_1 = var_0_22.find_object_by_id(var_5_0.point)

				if var_5_1 then
					if var_5_1.self_formation and next(var_5_1.self_formation) then
						local var_5_2 = {}

						for iter_5_0, iter_5_1 in ipairs(var_5_1.self_formation) do
							for iter_5_2, iter_5_3 in ipairs(self._data.state) do
								if iter_5_3.id == iter_5_1 then
									var_5_2[iter_5_0] = iter_5_3

									break
								end
							end
						end

						self._data.state = var_5_2

						return
					end
				end
			end
		end
	end

	function arg_1_0:__init_panel(arg_6_1, arg_6_2)
		if var_0_3:get_bvr_damage_info() then
			local var_6_0 = var_0_2:getInstance("loading")

			if var_6_0 then
				var_6_0:show(false, nil, false, "")
			end
		end

		self._control.bonus_layer.item_title.text.text = var_0_1:getNowLang("pveexploreresultres")
		self._control.bonus_layer.get_item.text.text = var_0_1:getNowLang("pveexploreresultequip")
		self._control.get_booty.getword.text.text = var_0_1:getNowLang("pvegetitemtitle")
		self._control.get_booty.already_have_booty.text.text = var_0_1:getNowLang("pvehascentitem")

		self._control.mask.gameObject:SetActive(true)

		self._support_id, self._support_count, self._support_point, self._support_active = var_0_3:get_support_notify()
		self._combat_res_grade = arg_6_1.grade

		local var_6_1 = {}

		for iter_6_0, iter_6_1 in pairs((var_0_3:get_player_story_unlock_data())) do
			var_0_8(var_6_1, iter_6_0, iter_6_1.id)
		end

		self.__max_normal_map_id = 101

		for iter_6_2, iter_6_3 in pairs((var_0_14.get_sequence())) do
			if iter_6_3.id >= self.__max_normal_map_id then
				self.__max_normal_map_id = iter_6_3.id
			end
		end

		self.__max_normal_map_id = self.__max_normal_map_id + 4

		local var_6_2
		local var_6_3 = var_0_3:get_battle_info()

		if var_6_3.type == var_0_6.fight_type.plot_main then
			var_6_2 = var_0_22.find_object_by_id(var_6_3.point)
		elseif var_6_3.type == var_0_6.fight_type.abyss or var_6_3.type == var_0_6.fight_type.abyss_2 then
			var_6_2 = var_0_36.find_object_by_id(var_6_3.point)
		elseif var_6_3.type == var_0_6.fight_type.push then
			var_6_2 = var_0_18.find_object_by_id(var_6_3.point)

			var_0_3:clear_bug_buff_index()
		else
			var_6_2 = var_6_3.type == var_0_6.fight_type.eighth and var_0_33.find_object_by_id(var_6_3.point) or var_6_3.type == var_0_6.fight_type.ninth and var_0_47.find_object_by_id_start_node_id(var_6_3.point, (var_0_3:get_ninth_map_start_point())) or var_0_16.find_object_by_id(var_6_3.point)
		end

		local var_6_4 = arg_6_2 == var_0_5.fight_type.event_story and (not var_0_3:get_new_battle_type() or var_0_3:get_new_battle_type() ~= gameenum.battle_type.fight_type.strike)

		if var_6_2 then
			if var_6_2.movie[4] and var_6_2.movie[4][1] ~= 0 and (not var_0_27.have_data(var_6_1, var_6_2.movie[4][1]) or var_6_4) then
				local var_6_5 = var_0_23.find_object_by_id(var_6_2.movie[4][1])

				var_0_2:createInstance("cinema_dialog"):show(var_6_5.movie_group_id, var_6_5.movie_id[1], var_6_5.movie_id[2])
			end

			if var_6_2.movie[5] and var_6_2.movie[5][1] ~= 0 and (not var_0_27.have_data(var_6_1, var_6_2.movie[5][1]) or var_6_4) and arg_6_1.grade <= 4 then
				local var_6_6 = var_0_23.find_object_by_id(var_6_2.movie[5][1])

				var_0_2:createInstance("cinema_dialog"):show(var_6_6.movie_group_id, var_6_6.movie_id[1], var_6_6.movie_id[2])
			end

			if var_6_2.movie[6] and var_6_2.movie[6][1] ~= 0 and (not var_0_27.have_data(var_6_1, var_6_2.movie[6][1]) or var_6_4) and arg_6_1.grade <= 2 then
				local var_6_7 = var_0_23.find_object_by_id(var_6_2.movie[6][1])

				var_0_2:createInstance("cinema_dialog"):show(var_6_7.movie_group_id, var_6_7.movie_id[1], var_6_7.movie_id[2])
			end
		end

		local var_6_8 = var_0_3:get_battle_data()
		local var_6_9 = var_0_3:get_battle_info()
		local var_6_10 = "临时战队"
		local var_6_11 = var_0_3:get_new_battle_type()

		if var_0_3:get_battle_type() == 4 then
			self._control.mask.gameObject:SetActive(true)
		elseif var_6_11 == var_0_6.fight_type.campaign or var_6_11 == var_0_6.fight_type.maneuver or var_6_11 == var_0_6.fight_type.plot_main then
			self._control.mask.gameObject:SetActive(false)
		end

		self._is_pvp = var_6_11 == var_0_6.fight_type.maneuver

		if arg_6_2 == var_0_5.fight_type.event_story and var_0_3:get_battle_info().type ~= var_0_5.battle_type.strike and (not var_0_3:get_new_battle_type() or var_0_3:get_new_battle_type() ~= gameenum.battle_type.fight_type.strike) then
			var_6_10 = ""

			local var_6_12 = var_0_3:get_battle_info()

			var_6_10 = var_0_13.find_object_by_id(931905001).title
		elseif var_6_11 == var_0_6.fight_type.maneuver then
			local var_6_13 = var_0_3:get_maneuver_target_info()

			var_6_10 = var_6_13.name
			self._control.enemy_info.lv.text.text = "Lv." .. var_6_13.level
		elseif arg_6_1 and arg_6_1.monster and arg_6_1.monster > 930000000 then
			local var_6_14 = var_0_13.find_object_by_id(arg_6_1.monster)

			if var_6_14 then
				var_6_10 = var_6_14.title
			end
		elseif var_6_11 == var_0_6.fight_type.war_concerto then
			local var_6_15 = var_0_13.find_object_by_id(arg_6_1.monster)

			if var_6_15 then
				var_6_10 = var_6_15.title
			end
		else
			local var_6_16 = var_0_13.find_object_by_id(arg_6_1.monster)

			if var_6_16 then
				var_6_10 = var_6_16.title
			end
		end

		if var_6_11 == var_0_6.fight_type.war_concerto_play or var_6_11 == var_0_6.fight_type.abyss_2 then
			self._donot_show_every_exp = true
			self._donot_show_player_exp = true
		else
			self._donot_show_every_exp = false
			self._donot_show_player_exp = false
		end

		local var_6_17 = var_0_3:get_name()
		local var_6_18 = var_0_3:get_use_info_data()
		local var_6_19
		local var_6_20

		if var_6_11 == var_0_6.fight_type.campaign or arg_6_2 == var_0_5.fight_type.event_story or var_6_11 == var_0_6.fight_type.sixth and var_0_3:get_battle_info().type ~= var_0_5.battle_type.strike then
			var_6_19 = var_0_1:getNowLang("selffleet")
		elseif var_0_3:get_battle_info().team ~= 0 then
			var_6_20 = var_0_3:get_battle_info().team
			var_6_19 = var_0_3:get_team_group(var_0_5.team_type.normal) and var_0_3:get_team_group(var_0_5.team_type.normal)[var_6_20] and var_0_3:get_team_group(var_0_5.team_type.normal)[var_6_20].name or var_0_1:getNowLang("firstfleet")
		end

		if var_6_20 == 1 and var_6_19 == "" then
			var_6_19 = var_0_1:getNowLang("firstfleet")
		elseif var_6_20 == 2 and var_6_19 == "" then
			var_6_19 = var_0_1:getNowLang("fleetid2")
		elseif var_6_20 == 3 and var_6_19 == "" then
			var_6_19 = var_0_1:getNowLang("fleetid3")
		elseif var_6_20 == 4 and var_6_19 == "" then
			var_6_19 = var_0_1:getNowLang("fleetid4")
		end

		self._control.get_booty.gameObject:SetActive(false)
		self._control.bonus_layer.gameObject:SetActive(false)
		self._control.fight_results.gameObject:SetActive(false)

		if arg_6_1.grade == 1 or arg_6_1.grade == 2 then
			self:_play_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.victory_s))
		elseif arg_6_1.grade == 3 then
			self:_play_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.victory_a))
		elseif arg_6_1.grade == 4 then
			self:_play_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.victory_b))
		else
			self:_play_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.lose))
		end

		self._control.dmg_set:SetActive(true)
		self._control.dmg_set.user_dmg.uIFillAmountChangeEffect:SetNum(0, arg_6_1.score * 100, 100)
		self._control.dmg_set.enemy_dmg.uIFillAmountChangeEffect:SetNum(0, arg_6_1.enemy_score * 100, 100)

		self._control.up_layer.fight_result.text.text = var_0_1:getNowLang("warfinishtitle")
		self._control.countinue.text.text = var_0_1:getNowLang("ui_combatresultcontinuetip")

		self._control.closeone.gameObject:SetActive(true)
		self._control.closetwo.gameObject:SetActive(false)

		self._user_fleet_unit = {
			self._control.user_fleet_info.fight_result_ship_one,
			self._control.user_fleet_info.fight_result_ship_two,
			self._control.user_fleet_info.fight_result_ship_three,
			self._control.user_fleet_info.fight_result_ship_four,
			self._control.user_fleet_info.fight_result_ship_five,
			self._control.user_fleet_info.fight_result_ship_six
		}
		self._enemy_fleet_unit = {
			self._control.enemy_fleet_info.fight_result_ship_one,
			self._control.enemy_fleet_info.fight_result_ship_two,
			self._control.enemy_fleet_info.fight_result_ship_three,
			self._control.enemy_fleet_info.fight_result_ship_four,
			self._control.enemy_fleet_info.fight_result_ship_five,
			self._control.enemy_fleet_info.fight_result_ship_six
		}
		self._exp_info = {
			self._control.every_exp.main_one,
			self._control.every_exp.main_two,
			self._control.every_exp.main_three,
			self._control.every_exp.main_four,
			self._control.every_exp.main_five,
			self._control.every_exp.main_six
		}

		for iter_6_4 = 1, 6 do
			self._user_fleet_unit[iter_6_4].gameObject:SetActive(false)
			self._enemy_fleet_unit[iter_6_4].gameObject:SetActive(false)

			self._exp_info[iter_6_4].remainword.text.text = var_0_1:getNowLang("upgradeneedexp")

			self._exp_info[iter_6_4].gameObject:SetActive(false)
		end

		self._control.user_exp.user_name.name_dd_1.text.text = var_6_17

		self._control.user_exp.user_name:GetComponent("TextHorizonScroller"):SetText(var_6_17)

		self._control.user_exp.lv.text.text = "Lv." .. var_6_18.level
		self._control.user_fleet_info.fleet_name.fleet_name_1.text.text = var_6_19

		self._control.user_fleet_info.fleet_name:GetComponent("TextHorizonScroller"):SetText(var_6_19)
		self._control.enemy_fleet_info:SetActive(true)
		self._control.enemy_info:SetActive(true)

		self._control.enemy_info.eneny_name.name_dd_1.text.text = var_6_10

		self._control.enemy_info.eneny_name:GetComponent("TextHorizonScroller"):SetText(var_6_10)

		self._control.enemy_fleet_info.fleet_name.fleet_name_1.text.text = var_6_10

		self._control.enemy_fleet_info.fleet_name:GetComponent("TextHorizonScroller"):SetText(var_6_10)
		self:rankstart(false, 2, 1.5, function()
			if not self._control.maskto:Equals(nil) then
				self._control.maskto.gameObject:SetActive(false)
			end
		end, arg_6_1.grade)

		self._control.score.resultword.image.sprite = self:loadSprite(var_0_7(var_0_5.battle_settlement_word, arg_6_1.grade))
		self._college_imgs = self._college_imgs or {}
		self._now_college_exps = self._now_college_exps or {}
		self._college_level_exps = self._college_level_exps or {}

		for iter_6_5 = 1, #arg_6_1.state do
			local var_6_21
			local var_6_23 = arg_6_2 == var_0_5.fight_type.abyss_model_first_phase and var_6_3.type == gameenum.battle_type.fight_type.abyss_2 and var_0_3:find_abyss_character_by_id(arg_6_1.state[iter_6_5].id) or var_0_3:find_character_by_id(arg_6_1.state[iter_6_5].id)

			if arg_6_2 == var_0_5.fight_type.event_story and var_0_3:get_battle_info().type ~= var_0_5.battle_type.strike and (not var_0_3:get_new_battle_type() or var_0_3:get_new_battle_type() ~= gameenum.battle_type.fight_type.strike) then
				local var_6_24 = var_0_10.find_object_by_cid(arg_6_1.state[iter_6_5].id)

				var_6_23 = var_6_24 and var_0_27.little_clone(var_6_24) or {}
				var_6_23.level = 110
			elseif var_0_3:get_battle_info().type == var_0_5.battle_type.war_concerto_play then
				local var_6_25 = var_0_3:get_fake_ship_data(var_0_3:get_fifth_team_data()[iter_6_5])

				var_6_23 = var_6_25 and var_0_27.little_clone(var_6_25) or {}
				var_6_23.hp = arg_6_1.state[iter_6_5].hp
			end

			self._college_skill_info = nil
			self._college_level = nil
			self._ship_all_tactics = var_6_23.all_tactics

			local var_6_26 = ""
			local var_6_27 = 0
			local var_6_29 = self:__get_learning_tactics(var_6_23.all_tactics)

			if var_6_29 then
				var_6_27 = var_6_29.exp
				self._college_skill_info = var_0_24.find_object_by_cid(var_6_29.id)
				var_6_26 = var_0_7(var_0_5.college_tactics_s, self._college_skill_info.icon)
				self._college_level = self._college_skill_info.level
			elseif not var_6_29 and arg_6_1.state[iter_6_5].tactic_id then
				self._college_skill_info = var_0_24.find_object_by_cid(arg_6_1.state[iter_6_5].tactic_id)

				if self._college_skill_info then
					var_6_26 = var_0_7(var_0_5.college_tactics_s, self._college_skill_info.icon)
					var_6_27 = self._college_skill_info.level_exp[3]
					self._college_level = 3
				end
			end

			self._college_imgs[iter_6_5] = var_6_26
			self._now_college_exps[iter_6_5] = var_6_27

			if self._college_skill_info and self._college_level then
				self._college_level_exps[iter_6_5] = self._college_level ~= 3 and self._college_skill_info.level_exp[self._college_level + 1] or self._college_skill_info.level_exp[3]
			end

			local var_6_30
			local var_6_31 = arg_6_1.state[iter_6_5].hp

			if arg_6_2 == var_0_5.fight_type.event_story and var_0_3:get_battle_info().type ~= var_0_5.battle_type.strike and (not var_0_3:get_new_battle_type() or var_0_3:get_new_battle_type() ~= gameenum.battle_type.fight_type.strike) then
				var_6_21 = var_0_10.find_object_by_cid(arg_6_1.state[iter_6_5].id).hp
			elseif var_0_3:get_battle_info().type == var_0_5.battle_type.war_concerto_play then
				var_6_21 = var_0_10.find_object_by_cid(var_6_23.cid).hp
			elseif var_0_3:get_battle_info().type == var_0_5.battle_type.abyss_first_phase then
				var_6_21 = var_0_10.find_object_by_cid(var_6_23.cid).hp
			else
				local var_6_32 = var_0_10.find_object_by_cid(var_6_23.cid)

				var_6_21 = var_0_10.find_object_by_cid(var_6_23.cid).hp
				var_6_30 = var_0_3:find_character_by_id(arg_6_1.state[iter_6_5].id).skin
				var_6_21 = var_0_27:get_ship_attr(var_0_3:find_character_by_id(arg_6_1.state[iter_6_5].id), var_6_32).hp
			end

			if arg_6_1.state[iter_6_5].max_hp then
				var_6_21 = arg_6_1.state[iter_6_5].max_hp
			end

			if var_6_30 and var_6_30 ~= 0 then
				self.ship_skin_id = var_0_19.find_object_by_cid(var_6_30).skin_id
			end

			self._user_fleet_unit[iter_6_5].main.mvp_one.gameObject:SetActive(false)
			self._user_fleet_unit[iter_6_5].main.mvp_two.gameObject:SetActive(false)
			self._user_fleet_unit[iter_6_5].gameObject:SetActive(true)

			if arg_6_1.state[iter_6_5].up then
				self:level_up(false, 0, 1, iter_6_5)
			end

			if arg_6_2 == var_0_5.fight_type.event_story and var_0_3:get_battle_info().type ~= var_0_5.battle_type.strike and (not var_0_3:get_new_battle_type() or var_0_3:get_new_battle_type() ~= gameenum.battle_type.fight_type.strike) then
				local var_6_33 = var_0_10.find_object_by_cid(var_6_23.cid).title

				self._user_fleet_unit[iter_6_5].main.ship_name.ship_name_1.text.text = var_6_33

				self._user_fleet_unit[iter_6_5].main.ship_name:GetComponent("TextHorizonScroller"):SetText(var_6_33)
			else
				self._user_fleet_unit[iter_6_5].main.ship_name.ship_name_1.text.text = var_6_23.name

				self._user_fleet_unit[iter_6_5].main.ship_name:GetComponent("TextHorizonScroller"):SetText(var_6_23.name)
			end

			self._user_fleet_unit[iter_6_5].main.about_lv.lv.text.text = "Lv." .. var_6_23.level
			self._user_fleet_unit[iter_6_5].main.about_type.type.text.text = var_0_1:getNowLang(var_0_5:get_ship_type_language_key(var_6_23.type, 1))

			if arg_6_2 == var_0_5.fight_type.event_story and var_0_3:get_battle_info().type ~= var_0_5.battle_type.strike and (not var_0_3:get_new_battle_type() or var_0_3:get_new_battle_type() ~= gameenum.battle_type.fight_type.strike) then
				local var_6_34 = var_0_10.find_object_by_cid(var_6_23.cid).pic_id

				self._user_fleet_unit[iter_6_5].main.ship.ship_icon.image.sprite = self:loadSprite(var_0_5:get_ship_icon(var_0_5.ship_icon.model_normal_s, var_6_34))

				local var_6_35 = lx.UserData:getKeyData(var_0_5.setting_key_list.setting_broken)
				local var_6_36 = true

				if var_6_35 ~= "" and var_6_35 ~= " " then
					var_6_36 = lx.json_decode(var_6_35).value
				end

				if var_6_31 > var_6_21 / 2 then
					if var_6_30 ~= nil and var_6_30 ~= 0 then
						self._user_fleet_unit[iter_6_5].main.ship.ship_icon.image.sprite = self:loadSprite(var_0_5:get_ship_icon(var_0_5.ship_icon.model_normal_s, self.ship_skin_id))
					elseif var_6_30 == nil or var_6_30 == 0 then
						self._user_fleet_unit[iter_6_5].main.ship.ship_icon.image.sprite = self:loadSprite(var_0_5:get_ship_icon(var_0_5.ship_icon.model_normal_s, var_6_34))
					end
				elseif var_6_31 <= var_6_21 / 2 and var_6_36 then
					if var_6_30 ~= nil and var_6_30 ~= 0 then
						self._user_fleet_unit[iter_6_5].main.ship.ship_icon.image.sprite = self:loadSprite(var_0_5:get_ship_icon(var_0_5.ship_icon.model_broken_s, self.ship_skin_id))
					elseif var_6_30 == nil or var_6_30 == 0 then
						self._user_fleet_unit[iter_6_5].main.ship.ship_icon.image.sprite = self:loadSprite(var_0_5:get_ship_icon(var_0_5.ship_icon.model_broken_s, var_6_34))
					end
				elseif var_6_31 <= var_6_21 / 2 and not var_6_36 then
					if var_6_30 ~= nil and var_6_30 ~= 0 then
						self._user_fleet_unit[iter_6_5].main.ship.ship_icon.image.sprite = self:loadSprite(var_0_5:get_ship_icon(var_0_5.ship_icon.model_normal_s, self.ship_skin_id))
					elseif var_6_30 == nil or var_6_30 == 0 then
						self._user_fleet_unit[iter_6_5].main.ship.ship_icon.image.sprite = self:loadSprite(var_0_5:get_ship_icon(var_0_5.ship_icon.model_normal_s, var_6_34))
					end
				end

				local var_6_37 = var_0_10.find_object_by_cid(var_6_23.cid).star

				self._user_fleet_unit[iter_6_5].main.ship.ship_bg.image.sprite = self:loadSprite(var_0_7(var_0_5.battle_settlement_bg, var_6_37 == 0 and 1 or var_6_37))
			else
				local var_6_38 = lx.UserData:getKeyData(var_0_5.setting_key_list.setting_broken)

				if var_6_31 >= var_6_21 / 2 or not ((var_6_38 ~= "" and var_6_38 ~= " " or nil) and lx.json_decode(var_6_38).value) then
					if var_6_30 ~= nil and var_6_30 ~= 0 then
						self._user_fleet_unit[iter_6_5].main.ship.ship_icon.image.sprite = self:loadSprite(var_0_5:get_ship_icon(var_0_5.ship_icon.model_normal_s, self.ship_skin_id))
					elseif var_6_30 ~= nil then
						if var_6_30 == 0 then
							self._user_fleet_unit[iter_6_5].main.ship.ship_icon.image.sprite = self:loadSprite(var_0_5:get_ship_icon(var_0_5.ship_icon.model_normal_s, var_0_10.find_object_by_cid(var_6_23.cid).pic_id))
						elseif var_6_31 <= var_6_21 / 2 then
							if var_6_30 ~= nil and var_6_30 ~= 0 then
								self._user_fleet_unit[iter_6_5].main.ship.ship_icon.image.sprite = self:loadSprite(var_0_5:get_ship_icon(var_0_5.ship_icon.model_broken_s, self.ship_skin_id))
							elseif var_6_30 ~= nil then
								if var_6_30 == 0 then
									self._user_fleet_unit[iter_6_5].main.ship.ship_icon.image.sprite = self:loadSprite(var_0_5:get_ship_icon(var_0_5.ship_icon.model_broken_s, var_0_10.find_object_by_cid(var_6_23.cid).pic_id))
								end
							end
						end
					end
				end

				local var_6_40 = var_0_10.find_object_by_cid(var_6_23.cid).star

				self._user_fleet_unit[iter_6_5].main.ship.ship_bg.image.sprite = self:loadSprite(var_0_7(var_0_5.battle_settlement_bg, var_6_40 == 0 and 1 or var_6_40))

				if arg_6_2 == var_0_5.fight_type.abyss_model_first_phase and var_6_3.type == gameenum.battle_type.fight_type.abyss_2 then
					self._user_fleet_unit[iter_6_5].main.ship.ship_bg.image.sprite = self:loadSprite(var_0_7(var_0_5.abyss_battle_settlement_bg, var_0_10.find_object_by_cid(var_6_23.cid).boss == 0 and 1 or 2))
				end

				if self._user_fleet_unit[iter_6_5].main.ship.ship_icon.image.sprite == nil then
					self._user_fleet_unit[iter_6_5].main.ship.ship_icon.image.sprite = arg_6_2 == var_0_5.fight_type.abyss_model_first_phase and var_6_3.type == gameenum.battle_type.fight_type.abyss_2 and self:loadSprite(var_0_5:get_ship_icon(var_0_5.ship_icon.model_normal_s, var_0_10.find_object_by_cid(var_6_23.cid).pic_id)) or self:loadSprite(var_0_5:get_ship_icon(var_0_5.ship_icon.model_normal_s, 1))
				end
			end

			if var_6_31 / var_6_21 >= 0.5 then
				self._user_fleet_unit[iter_6_5].main.about_hp.hp.image.sprite = self:loadSprite(var_0_5.battle_settlement_hp_normal)

				if not arg_6_1.state[iter_6_5].mvp then
					-- block empty
				elseif arg_6_1.state[iter_6_5].mvp then
					self._user_fleet_unit[iter_6_5].main.mvp_one.gameObject:SetActive(true)

					self._user_fleet_unit[iter_6_5].main.mvp_one.bg.image.sprite = self:loadSprite(var_0_5.battle_ship_mvp)
					self._user_fleet_unit[iter_6_5].main.mvp_one.mvp.text.text = "MVP"
					self._user_fleet_unit[iter_6_5].main.mvp_one.mvp.text.color = Color.New(0.23529411764705882, 0.23529411764705882, 0.23529411764705882)
				end
			elseif var_6_31 / var_6_21 < 0.5 and var_6_31 / var_6_21 >= 0.25 then
				self._user_fleet_unit[iter_6_5].main.about_hp.hp.image.sprite = self:loadSprite(var_0_5.battle_settlement_hp_mid)

				self:smoke(false, 0, -1, iter_6_5)

				if not arg_6_1.state[iter_6_5].mvp then
					self._user_fleet_unit[iter_6_5].main.mvp_one.gameObject:SetActive(true)

					self._user_fleet_unit[iter_6_5].main.mvp_one.bg.image.sprite = self:loadSprite(var_0_5.battle_ship_borken_mid)
					self._user_fleet_unit[iter_6_5].main.mvp_one.mvp.text.text = var_0_1:getNowLang("showasbroken")
					self._user_fleet_unit[iter_6_5].main.mvp_one.mvp.text.color = Color.New(1, 1, 1)
				elseif arg_6_1.state[iter_6_5].mvp then
					self._user_fleet_unit[iter_6_5].main.mvp_one.gameObject:SetActive(true)

					self._user_fleet_unit[iter_6_5].main.mvp_one.bg.image.sprite = self:loadSprite(var_0_5.battle_ship_mvp)
					self._user_fleet_unit[iter_6_5].main.mvp_one.mvp.text.text = "MVP"
					self._user_fleet_unit[iter_6_5].main.mvp_one.mvp.text.color = Color.New(0.23529411764705882, 0.23529411764705882, 0.23529411764705882)

					self._user_fleet_unit[iter_6_5].main.mvp_two.gameObject:SetActive(true)

					self._user_fleet_unit[iter_6_5].main.mvp_two.bg.image.sprite = self:loadSprite(var_0_5.battle_ship_borken_mid)
					self._user_fleet_unit[iter_6_5].main.mvp_two.mvp.text.text = var_0_1:getNowLang("showasbroken")
					self._user_fleet_unit[iter_6_5].main.mvp_two.mvp.text.color = Color.New(1, 1, 1)
				end
			elseif var_6_31 / var_6_21 < 0.25 and var_6_31 / var_6_21 > 0 then
				self._user_fleet_unit[iter_6_5].main.about_hp.hp.image.sprite = self:loadSprite(var_0_5.battle_settlement_hp_low)

				self:smoke(false, 0, -1, iter_6_5)

				if not arg_6_1.state[iter_6_5].mvp then
					self._user_fleet_unit[iter_6_5].main.mvp_one.gameObject:SetActive(true)

					self._user_fleet_unit[iter_6_5].main.mvp_one.bg.image.sprite = self:loadSprite(var_0_5.battle_ship_borken_low)
					self._user_fleet_unit[iter_6_5].main.mvp_one.mvp.text.text = var_0_1:getNowLang("ui_combatpreparetip2")
					self._user_fleet_unit[iter_6_5].main.mvp_one.mvp.text.color = Color.New(1, 1, 1)
				elseif arg_6_1.state[iter_6_5].mvp then
					self._user_fleet_unit[iter_6_5].main.mvp_one.gameObject:SetActive(true)

					self._user_fleet_unit[iter_6_5].main.mvp_one.bg.image.sprite = self:loadSprite(var_0_5.battle_ship_mvp)
					self._user_fleet_unit[iter_6_5].main.mvp_one.mvp.text.text = "MVP"
					self._user_fleet_unit[iter_6_5].main.mvp_one.mvp.text.color = Color.New(0.23529411764705882, 0.23529411764705882, 0.23529411764705882)

					self._user_fleet_unit[iter_6_5].main.mvp_two.gameObject:SetActive(true)

					self._user_fleet_unit[iter_6_5].main.mvp_two.bg.image.sprite = self:loadSprite(var_0_5.battle_ship_borken_low)
					self._user_fleet_unit[iter_6_5].main.mvp_two.mvp.text.text = var_0_1:getNowLang("ui_combatpreparetip2")
					self._user_fleet_unit[iter_6_5].main.mvp_two.mvp.text.color = Color.New(1, 1, 1)
				end
			elseif var_6_31 == 0 then
				self:smoke(false, 0, -1, iter_6_5)

				if not arg_6_1.state[iter_6_5].mvp then
					self._user_fleet_unit[iter_6_5].main.mvp_one.gameObject:SetActive(true)

					self._user_fleet_unit[iter_6_5].main.mvp_one.bg.image.sprite = self:loadSprite(var_0_5.battle_ship_borken_empty)
					self._user_fleet_unit[iter_6_5].main.mvp_one.mvp.text.text = var_0_1:getNowLang("ui_combat_return")
					self._user_fleet_unit[iter_6_5].main.mvp_one.mvp.text.color = Color.New(0, 0.37254901960784315, 0.6862745098039216)
				elseif arg_6_1.state[iter_6_5].mvp then
					self._user_fleet_unit[iter_6_5].main.mvp_one.gameObject:SetActive(true)

					self._user_fleet_unit[iter_6_5].main.mvp_one.bg.image.sprite = self:loadSprite(var_0_5.battle_ship_mvp)
					self._user_fleet_unit[iter_6_5].main.mvp_one.mvp.text.text = "MVP"
					self._user_fleet_unit[iter_6_5].main.mvp_one.mvp.text.color = Color.New(0.23529411764705882, 0.23529411764705882, 0.23529411764705882)

					self._user_fleet_unit[iter_6_5].main.mvp_two.gameObject:SetActive(true)

					self._user_fleet_unit[iter_6_5].main.mvp_two.bg.image.sprite = self:loadSprite(var_0_5.battle_ship_borken_empty)
					self._user_fleet_unit[iter_6_5].main.mvp_two.mvp.text.text = var_0_1:getNowLang("ui_combat_return")
					self._user_fleet_unit[iter_6_5].main.mvp_two.mvp.text.color = Color.New(0, 0.37254901960784315, 0.6862745098039216)
				end
			end

			if arg_6_1.state[iter_6_5].mvp then
				local var_6_43 = var_0_19.find_object_by_cid(var_6_23.skin)
				local var_6_44 = (var_6_43 and var_6_43.cv_id and var_6_43.cv_id ~= "0" or nil) and var_6_43.cv_id or var_0_10.find_object_by_cid(var_6_23.cid).pic_id

				self:playCV(var_0_7("%s/%s_mvp.mp3", var_6_44, var_6_44), false, "cv")
			end

			self._user_fleet_unit[iter_6_5].main.about_hp.hp.image.fillAmount = var_6_31 / var_6_21
		end

		for iter_6_6 = 1, #arg_6_1.enemy_state do
			self._enemy_fleet_unit[iter_6_6].gameObject:SetActive(true)

			local var_6_45 = var_0_12.find_object_by_id(arg_6_1.enemy_state[iter_6_6].id)
			local var_6_46 = var_0_3:get_battle_type()

			if arg_6_1.enemy_state[iter_6_6].max_hp then
				enemy_base_hp = arg_6_1.enemy_state[iter_6_6].max_hp
			end

			if var_0_3:get_new_battle_type() == 3 and var_6_46 ~= 4 and var_0_3:get_back_type() then
				if var_6_46 == var_0_5.battle_type.exercise then
					if not var_0_3:get_maneuver_target_info().robot then
						local var_6_47 = var_0_3:get_ship_data_by_id_in_maneuver_target_info(arg_6_1.enemy_state[iter_6_6].id)

						var_6_45 = var_0_10.find_object_by_cid(arg_6_1.enemy_state[iter_6_6].id)
						var_6_45.level = var_6_47.level
						self._enemy_fleet_unit[iter_6_6].main.ship.ship_icon.image.sprite = var_6_47.skin ~= 0 and self:loadSprite((var_0_5:get_ship_icon(var_0_5.ship_icon.model_normal_s, tostring(var_0_19.find_object_by_cid(var_6_47.skin).icon)))) or self:loadSprite(var_0_5:get_ship_icon(var_0_5.battle_settlement_normal, var_6_45.pic_id))
					else
						self._enemy_fleet_unit[iter_6_6].main.ship.ship_icon.image.sprite = self:loadSprite(var_0_5:get_ship_icon(var_0_5.battle_settlement_normal, var_6_45.pic_id))
					end
				elseif var_6_46 == var_0_5.battle_type.friend_exercise then
					local var_6_48 = var_0_3:get_friend_ship_data_by_id_in_maneuver_target_info(arg_6_1.enemy_state[iter_6_6].id)

					var_6_45 = var_0_10.find_object_by_cid(arg_6_1.enemy_state[iter_6_6].id)
					var_6_45.level = arg_6_1.enemy_state[iter_6_6].level

					self._control.mask.gameObject:SetActive(true)

					self._enemy_fleet_unit[iter_6_6].main.ship.ship_icon.image.sprite = var_6_48.skin ~= 0 and self:loadSprite((var_0_5:get_ship_icon(var_0_5.ship_icon.model_normal_s, tostring(var_0_19.find_object_by_cid(var_6_48.skin).icon)))) or self:loadSprite(var_0_5:get_ship_icon(var_0_5.battle_settlement_normal, var_6_45.pic_id))
				end
			else
				self._enemy_fleet_unit[iter_6_6].main.ship.ship_icon.image.sprite = (not var_6_45 or not next(var_6_45)) and self:loadSprite(var_0_5:get_ship_icon(var_0_5.battle_settlement_normal, 1)) or self:loadSprite(var_0_5:get_ship_icon(var_0_5.battle_settlement_normal, var_6_45.pic_id))
			end

			local var_6_49 = var_6_45.hp
			local var_6_50 = arg_6_1.enemy_state[iter_6_6].hp

			self._enemy_fleet_unit[iter_6_6].main.mvp_one.gameObject:SetActive(false)

			self._enemy_fleet_unit[iter_6_6].main.ship_name.ship_name_1.text.text = var_6_45.title

			self._enemy_fleet_unit[iter_6_6].main.ship_name:GetComponent("TextHorizonScroller"):SetText(var_6_45.title)

			self._enemy_fleet_unit[iter_6_6].main.about_lv.lv.text.text = "Lv." .. var_6_45.level
			self._enemy_fleet_unit[iter_6_6].main.about_type.type.text.text = var_0_1:getNowLang(var_0_5:get_ship_type_language_key(var_6_45.type, 1))
			self._enemy_fleet_unit[iter_6_6].main.ship.ship_bg.image.sprite = self:loadSprite(var_0_7(var_0_5.battle_settlement_bg, var_6_45.star == 0 and 1 or var_6_45.star))

			self._enemy_fleet_unit[iter_6_6].main.mvp_two.gameObject:SetActive(false)

			if var_6_50 / var_6_49 >= 0.5 then
				self._enemy_fleet_unit[iter_6_6].main.about_hp.hp.image.sprite = self:loadSprite(var_0_5.battle_settlement_hp_normal)
			elseif var_6_50 / var_6_49 < 0.5 and var_6_50 / var_6_49 >= 0.25 then
				self._enemy_fleet_unit[iter_6_6].main.about_hp.hp.image.sprite = self:loadSprite(var_0_5.battle_settlement_hp_mid)

				self:smoke_e(false, 0, -1, iter_6_6)
				self._enemy_fleet_unit[iter_6_6].main.mvp_one.gameObject:SetActive(true)

				self._enemy_fleet_unit[iter_6_6].main.mvp_one.bg.image.sprite = self:loadSprite(var_0_5.battle_ship_borken_mid)
				self._enemy_fleet_unit[iter_6_6].main.mvp_one.mvp.text.text = var_0_1:getNowLang("showasbroken")
				self._enemy_fleet_unit[iter_6_6].main.mvp_one.mvp.text.color = Color.New(1, 1, 1)
			elseif var_6_50 / var_6_49 < 0.25 and var_6_50 / var_6_49 > 0 then
				self._enemy_fleet_unit[iter_6_6].main.about_hp.hp.image.sprite = self:loadSprite(var_0_5.battle_settlement_hp_low)

				self:smoke_e(false, 0, -1, iter_6_6)
				self._enemy_fleet_unit[iter_6_6].main.mvp_one.gameObject:SetActive(true)

				self._enemy_fleet_unit[iter_6_6].main.mvp_one.bg.image.sprite = self:loadSprite(var_0_5.battle_ship_borken_low)
				self._enemy_fleet_unit[iter_6_6].main.mvp_one.mvp.text.text = var_0_1:getNowLang("ui_combatpreparetip2")
				self._enemy_fleet_unit[iter_6_6].main.mvp_one.mvp.text.color = Color.New(1, 1, 1)
			elseif var_6_50 == 0 then
				self:smoke_e(false, 0, -1, iter_6_6)
				self._enemy_fleet_unit[iter_6_6].main.mvp_one.gameObject:SetActive(true)

				self._enemy_fleet_unit[iter_6_6].main.mvp_one.bg.image.sprite = self:loadSprite(var_0_5.battle_ship_borken_empty)
				self._enemy_fleet_unit[iter_6_6].main.mvp_one.mvp.text.text = var_0_1:getNowLang("ui_combatresultbreak3")
				self._enemy_fleet_unit[iter_6_6].main.mvp_one.mvp.text.color = Color.New(0, 0.37254901960784315, 0.6862745098039216)
			end

			self._enemy_fleet_unit[iter_6_6].main.about_hp.hp.image.fillAmount = var_6_50 / var_6_49
		end

		if var_6_11 == var_0_6.fight_type.eighth then
			local var_6_51 = var_0_3:get_eighth_elite_move()

			if var_6_51 and next(var_6_51) then
				var_0_3:req_EighthEliteMoveReq(var_6_51.map_id, var_6_51.monster_info)
				var_0_3:set_eighth_elite_move(nil)
			end
		end
	end

	function arg_1_0._skill_exp(arg_8_0, arg_8_1)
		arg_8_0._now_college_exp = arg_8_1
	end

	function arg_1_0:rankstart(arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
		local var_9_0 = self:autoKillDOTween(var_0_11.Sequence())
		local var_9_1

		var_9_0:AppendInterval(arg_9_2)
		var_9_0:AppendCallback(function()
			self._control.countinue.gameObject:SetActive(true)
			self._control.score.resultword.gameObject:SetActive(true)
			self._control.enemy_fleet_info.gameObject:SetActive(false)
			self._control.enemy_info.gameObject:SetActive(false)
			self._control.dmg_set:SetActive(false)

			var_9_1 = self:createGameObject("data/effect/prefab/rankspine.prefab")

			var_9_1.transform:SetParent(self._control.score.spineparent.rectTransform, false)

			local var_10_0 = var_9_1.transform:GetChild(0).transform:GetComponent(typeof(Spine.Unity.SkeletonGraphic))

			self._spine_residual = var_10_0
			var_10_0.material.shader = var_0_5.shader_tint

			var_10_0.AnimationState:SetAnimation(0, var_0_48[arg_9_5], false)

			local var_10_1 = var_9_1.transform:GetComponent("CanvasGroup")

			var_10_1.alpha = 0

			var_10_1:DOFade(1, 5)
			var_10_1:DOFade(0, arg_9_3):OnComplete(function()
				arg_9_4()
				var_9_0:Kill()

				var_9_0 = nil
			end)

			local var_10_2 = var_0_3:get_battle_info()

			if var_10_2.type == var_0_6.fight_type.plot_main then
				var_0_3:req_EnterSixthStoryReq(var_10_2.point, arg_9_5)
			end
		end)
		var_9_0:AppendInterval(1)
		var_9_0:Play()
	end

	function arg_1_0:smoke(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
		local var_12_0 = self:autoKillDOTween(var_0_11.Sequence())
		local var_12_1

		var_12_0:AppendInterval(arg_12_2)
		var_12_0:AppendCallback(function()
			var_12_1 = self:createGameObject("data/effect/prefab/smoke.prefab")

			var_12_1.transform:SetParent(self._user_fleet_unit[arg_12_4].main.smoke.rectTransform, false)
			var_12_1.transform:GetChild(0).transform:GetComponent(typeof(Spine.Unity.SkeletonGraphic)).AnimationState:SetAnimation(0, "Smoke_L", true)
		end)
		var_12_0:Play()
	end

	function arg_1_0:smoke_e(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
		local var_14_0 = self:autoKillDOTween(var_0_11.Sequence())
		local var_14_1

		var_14_0:AppendInterval(arg_14_2)
		var_14_0:AppendCallback(function()
			var_14_1 = self:createGameObject("data/effect/prefab/smoke.prefab")

			var_14_1.transform:SetParent(self._enemy_fleet_unit[arg_14_4].main.smoke.rectTransform, false)
			var_14_1.transform:GetChild(0).transform:GetComponent(typeof(Spine.Unity.SkeletonGraphic)).AnimationState:SetAnimation(0, "Smoke_L", true)
		end)
		var_14_0:Play()
	end

	function arg_1_0:level_up(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
		local var_16_0 = self:autoKillDOTween(var_0_11.Sequence())
		local var_16_1

		var_16_0:AppendInterval(arg_16_2)
		var_16_0:AppendCallback(function()
			var_16_1 = self:createGameObject("data/effect/prefab/level_up.prefab")

			var_16_1.transform:SetParent(self._user_fleet_unit[arg_16_4].rectTransform, false)

			local var_17_0 = var_16_1.transform:Find("up"):GetComponent(typeof(Spine.Unity.SkeletonGraphic))

			var_17_0.material.shader = var_0_5.shader_tint

			var_17_0.AnimationState:SetAnimation(0, "Level_up", false)
		end)
		var_16_0:Play()
	end

	function arg_1_0:__is_already_init()
		return self._already_init
	end

	function arg_1_0:_exp_move(arg_19_1)
		if self._donot_show_every_exp then
			self._exp_info[arg_19_1]:SetActive(false)

			return
		end

		self._exp_info[arg_19_1]:SetActive(true)

		self._exp_info[arg_19_1].transform.localPosition = var_0_35(-480, self._exp_info[arg_19_1].transform.localPosition.y)
		self._exp_position_list[arg_19_1] = self._exp_info[arg_19_1].transform.localPosition
		self.exp_seq = self:autoKillDOTween(var_0_11.Sequence())

		self.exp_seq:Append(self._exp_info[arg_19_1].transform:DOBlendableLocalMoveBy(Vector3.New(235, 0), 0.3 + arg_19_1 / 10):SetEase(DG.Tweening.Ease.Linear))
		self.exp_seq:AppendCallback(func)
		self.exp_seq:SetLoops(1)
		self.exp_seq:Play()
	end

	function arg_1_0:_love_get(arg_20_1, arg_20_2, arg_20_3, arg_20_4)
		self._user_fleet_unit[arg_20_1].main.goodwill:SetActive(true)
		self._user_fleet_unit[arg_20_1].main.goodwill.about_down.love_down:SetActive(false)

		local var_20_0 = self:autoKillDOTween(var_0_11.Sequence())
		local var_20_1 = self._user_fleet_unit[arg_20_1].main.goodwill.about_up.shadow.image
		local var_20_2 = self._user_fleet_unit[arg_20_1].main.goodwill.about_up.up
		local var_20_3 = self._user_fleet_unit[arg_20_1].main.goodwill.about_up.up.transform.localPosition

		if arg_20_3 == 1 then
			if arg_20_4 then
				if not self._user_fleet_unit[arg_20_1].main.goodwill.about_up.up:Equals(nil) then
					self._user_fleet_unit[arg_20_1].main.goodwill.about_up.up.gameObject:SetActive(true)

					if self._is_have_down then
						self._user_fleet_unit[arg_20_1].main.goodwill.about_up.up.gameObject:SetActive(false)
					end
				end

				var_20_0:AppendCallback(function()
					var_20_1:DOFade(1, 1.1):OnComplete(function()
						var_20_1:DOFade(0, 0.9)
					end)
				end)
				var_20_0:AppendCallback(function()
					if not var_20_2:Equals(nil) then
						var_20_0:Append(var_20_2.transform:DOBlendableLocalMoveBy(Vector3.New(-85, 0), 0.5):SetEase(DG.Tweening.Ease.Linear))
					end
				end)
				var_20_0:AppendInterval(1)
				var_20_0:AppendCallback(function()
					if not var_20_2:Equals(nil) then
						var_20_0:Append(var_20_2.transform:DOBlendableLocalMoveBy(Vector3.New(-80, 0), 0.5):SetEase(DG.Tweening.Ease.Linear))
					end
				end)
				var_20_0:AppendInterval(0.6)
			else
				var_20_0:AppendInterval(1.6)
			end

			var_20_0:AppendCallback(function()
				if not var_20_2:Equals(nil) then
					var_20_2.gameObject:SetActive(false)

					var_20_2.transform.localPosition = var_0_35(var_20_3.x, var_20_3.y)
				end

				local var_25_0 = self:autoKillDOTween(var_0_11.Sequence())

				var_25_0:AppendInterval(0.5)
				var_25_0:AppendCallback(function()
					if var_20_0 then
						var_20_0:Kill()

						var_20_0 = nil
					end

					if arg_20_2 then
						arg_20_2()

						arg_20_2 = nil
					end

					var_25_0:Kill()

					var_25_0 = nil
				end)
				var_25_0:SetLoops(1)
				var_25_0:Play()
			end)
		elseif arg_20_3 == 3 then
			var_20_0:AppendInterval(2.1)
			var_20_0:AppendCallback(function()
				if not var_20_2:Equals(nil) then
					var_20_2.gameObject:SetActive(false)

					var_20_2.transform.localPosition = var_0_35(var_20_3.x, var_20_3.y)
				end

				local var_27_0 = self:autoKillDOTween(var_0_11.Sequence())

				var_27_0:AppendCallback(function()
					if var_20_0 then
						var_20_0:Kill()

						var_20_0 = nil
					end

					if arg_20_2 then
						arg_20_2()

						arg_20_2 = nil
					end

					var_27_0:Kill()

					var_27_0 = nil
				end)
				var_27_0:SetLoops(1)
				var_27_0:Play()
			end)
		elseif arg_20_3 == 2 then
			var_20_0:AppendCallback(function()
				if not var_20_2:Equals(nil) then
					var_20_2.gameObject:SetActive(false)

					var_20_2.transform.localPosition = var_0_35(var_20_3.x, var_20_3.y)
				end

				local var_29_0 = self:autoKillDOTween(var_0_11.Sequence())

				var_29_0:AppendCallback(function()
					if var_20_0 then
						var_20_0:Kill()

						var_20_0 = nil
					end

					if arg_20_2 then
						arg_20_2()

						arg_20_2 = nil
					end

					var_29_0:Kill()

					var_29_0 = nil
				end)
				var_29_0:SetLoops(1)
				var_29_0:Play()
			end)
		else
			if not self._user_fleet_unit[arg_20_1].main.goodwill.about_up.up:Equals(nil) then
				self._user_fleet_unit[arg_20_1].main.goodwill.about_up.up.gameObject:SetActive(true)

				if self._is_have_down then
					self._user_fleet_unit[arg_20_1].main.goodwill.about_up.up.gameObject:SetActive(false)
				end
			end

			var_20_0:AppendCallback(function()
				var_20_1:DOFade(1, 1.1):OnComplete(function()
					var_20_1:DOFade(0, 0.9)
				end)
			end)
			var_20_0:AppendCallback(function()
				if not var_20_2:Equals(nil) then
					var_20_0:Append(var_20_2.transform:DOBlendableLocalMoveBy(Vector3.New(-85, 0), 0.5):SetEase(DG.Tweening.Ease.Linear))
				end
			end)
			var_20_0:AppendInterval(1)
			var_20_0:AppendCallback(function()
				if not var_20_2:Equals(nil) then
					var_20_0:Append(var_20_2.transform:DOBlendableLocalMoveBy(Vector3.New(-80, 0), 0.5):SetEase(DG.Tweening.Ease.Linear))
				end
			end)
			var_20_0:AppendInterval(0.6)
			var_20_0:AppendCallback(function()
				if not var_20_2:Equals(nil) then
					var_20_2.gameObject:SetActive(false)

					var_20_2.transform.localPosition = var_0_35(var_20_3.x, var_20_3.y)
				end
			end)
		end

		var_20_0:AppendInterval(0.6)
		var_20_0:SetLoops(1)
		var_20_0:Play()
	end

	function arg_1_0:__show_fifth_joy_boss_res()
		if self._enter_type ~= var_0_5.fight_type.war_concerto_play then
			return
		end

		if var_0_3:get_new_battle_type() == gameenum.battle_type.fight_type.score then
			return
		end

		if var_0_25.find_object_by_id(var_0_3:get_battle_info().point).node_attribute == var_0_5.map_node_finish_type.boss_finish then
			local var_36_2, var_36_3 = var_0_3:check_joy_love_increase()

			self:college_skill_up(1, var_36_2, 100, var_36_3, var_0_5.fifth_event_const.joy.love_icon)
		end
	end

	function arg_1_0:_love_down(arg_37_1, arg_37_2, arg_37_3, arg_37_4)
		if arg_37_3 then
			return
		end

		local var_37_0 = self:autoKillDOTween(var_0_11.Sequence())
		local var_37_1 = self._user_fleet_unit[arg_37_1].main.goodwill.about_down.shadow.image
		local var_37_2 = self._user_fleet_unit[arg_37_1].main.goodwill.about_down.love_down
		local var_37_3 = self._user_fleet_unit[arg_37_1].main.goodwill.about_down.love_down.transform.localPosition

		self._user_fleet_unit[arg_37_1].main.goodwill.about_down.love_down.gameObject:SetActive(true)
		var_37_0:AppendCallback(function()
			var_37_1:DOFade(1, 1.1):OnComplete(function()
				var_37_1:DOFade(0, 0.9)
			end)
		end)

		if arg_37_2 then
			self._user_fleet_unit[arg_37_1].main.goodwill.about_down.love_down.love_down.subtract.text.text = 5

			if arg_37_4 then
				self._user_fleet_unit[arg_37_1].main.goodwill.about_down.love_down.love_down.subtract.text.text = 4
			end
		else
			self._user_fleet_unit[arg_37_1].main.goodwill.about_down.love_down.love_down.subtract.text.text = 50
		end

		if self._enter_type == var_0_5.fight_type.abyss_model_first_phase and var_0_3:get_battle_info().type == gameenum.battle_type.fight_type.abyss_2 then
			self._user_fleet_unit[arg_37_1].main.goodwill.about_down.love_down.love_down.image.sprite = self:loadSprite(var_0_5.abyss_const.abyss_power_down_icon)
			self._user_fleet_unit[arg_37_1].main.goodwill.about_down.love_down.subtract.text.text = string.format("<color=#%s>%s</color>", "E00605", "-5") .. "\n" .. string.format("<color=#%s>%s</color>", "06EB05", string.format("%s/100", (var_0_3:get_abyss_power())))
		end

		var_37_0:AppendCallback(function()
			if not var_37_0:Equals(nil) then
				var_37_0:Append(self._user_fleet_unit[arg_37_1].main.goodwill.about_down.love_down.transform:DOBlendableLocalMoveBy(Vector3.New(30, 0), 0.6):SetEase(DG.Tweening.Ease.Linear))
			end
		end)
		var_37_0:AppendInterval(1)
		var_37_0:AppendCallback(function()
			if not var_37_0:Equals(nil) and not self._user_fleet_unit[arg_37_1].main.goodwill.about_down.love_down:Equals(nil) then
				var_37_0:Append(self._user_fleet_unit[arg_37_1].main.goodwill.about_down.love_down.transform:DOBlendableLocalMoveBy(Vector3.New(30, 0), 0.6):SetEase(DG.Tweening.Ease.Linear))
			end
		end)
		var_37_0:AppendInterval(0.7)
		var_37_0:AppendCallback(function()
			if not var_37_2:Equals(nil) then
				var_37_2.gameObject:SetActive(false)

				var_37_2.transform.localPosition = var_0_35(var_37_3.x, var_37_3.y)
			end
		end)
		var_37_0:SetLoops(1)
		var_37_0:Play()
	end

	function arg_1_0:college_skill_up(arg_43_1, arg_43_2, arg_43_3, arg_43_4, arg_43_5)
		if arg_43_2 == 0 then
			return
		end

		local var_43_0 = self:autoKillDOTween(var_0_11.Sequence())
		local var_43_1 = self._user_fleet_unit[arg_43_1].main.college_skill.skill.shadow.image
		local var_43_2 = self._user_fleet_unit[arg_43_1].main.college_skill.skill
		local var_43_3 = self._user_fleet_unit[arg_43_1].main.college_skill.skill.college_info.transform.localPosition
		local var_43_4 = self._user_fleet_unit[arg_43_1].main.college_skill.skill.college_info

		self._user_data = var_0_3:get_use_info_data()

		if self._user_data.combatshop_tactics_card and lx.ServerTime:getUtcTime() < self._user_data.combatshop_tactics_card then
			arg_43_2 = arg_43_2 * 2
		end

		if not self._user_fleet_unit[arg_43_1].main.college_skill.skill.college_info:Equals(nil) then
			self._user_fleet_unit[arg_43_1].main.college_skill.skill.college_info.contrast.text.text = arg_43_4 .. "/" .. arg_43_3
			self._user_fleet_unit[arg_43_1].main.college_skill.skill.college_info.add.text.text = "+" .. arg_43_2
		end

		if arg_43_5 ~= "" then
			self._user_fleet_unit[arg_43_1].main.college_skill.skill.college_info.icon.image.sprite = self:loadSprite(arg_43_5)
		end

		self._user_fleet_unit[arg_43_1].main.college_skill.skill.gameObject:SetActive(true)
		var_43_0:AppendCallback(function()
			var_43_1:DOFade(1, 1.1):OnComplete(function()
				var_43_1:DOFade(0, 0.9)
			end)
		end)
		var_43_0:AppendCallback(function()
			if not var_43_4:Equals(nil) then
				var_43_0:Append(var_43_4.transform:DOBlendableLocalMoveBy(Vector3.New(-80, 0), 0.5):SetEase(DG.Tweening.Ease.Linear))
			end
		end)
		var_43_0:AppendInterval(1)
		var_43_0:AppendCallback(function()
			if not var_43_4:Equals(nil) then
				var_43_0:Append(var_43_4.transform:DOBlendableLocalMoveBy(Vector3.New(-80, 0), 0.5):SetEase(DG.Tweening.Ease.Linear))
			end
		end)
		var_43_0:AppendInterval(0.6)
		var_43_0:AppendCallback(function()
			if not var_43_2:Equals(nil) then
				var_43_2.gameObject:SetActive(false)

				var_43_2.college_info.transform.localPosition = var_0_35(var_43_3.x, var_43_3.y)
			end

			var_43_0:Kill()

			var_43_0 = nil
		end)
		var_43_0:SetLoops(1)
		var_43_0:Play()
	end

	function arg_1_0:_play_se(arg_49_1)
		self:playSE(arg_49_1, false)
	end

	function arg_1_0:_play_audio(arg_50_1)
		self:playBackgroundMusic(arg_50_1, true)
	end

	function arg_1_0.__get_learning_tactics(arg_51_0, arg_51_1)
		if not arg_51_1 then
			return
		end

		for iter_51_0, iter_51_1 in pairs(arg_51_1) do
			if iter_51_1.state == 2 then
				return iter_51_1
			end
		end
	end

	function arg_1_0:__other_call()
		var_0_3:set_bvr_damage_info()

		local var_52_0 = var_0_3:get_battle_type()
		local var_52_1 = var_0_3:get_back_type()
		local var_52_2 = var_0_3:get_new_battle_type()

		if (var_52_2 == gameenum.battle_type.fight_type.main or var_52_2 == gameenum.battle_type.fight_type.push) and (var_52_0 == var_0_5.battle_type.exercise or var_52_0 == var_0_5.fight_type.fearlessness_sea) then
			local var_52_3 = var_0_3:get_battle_info()
			local var_52_4 = self._battle_info_id
			local var_52_5
			local var_52_6
			local var_52_9
			local var_52_10 = self._battle_info_team

			var_52_5 = var_52_2 == gameenum.battle_type.fight_type.main and var_0_14.find_object_by_id(var_52_4) or var_0_15.find_object_by_id(var_52_4)

			local var_52_13 = var_0_40:getKeyData("map_is_lock")
			local var_52_14 = false

			if var_52_5.replace_conditions and next(var_52_5.replace_conditions) and var_0_27.have_index(var_52_5, "temporary_pve_debuff") then
				if var_52_5.temporary_pve_debuff == 1 then
					var_52_14 = true
				elseif var_52_5.temporary_pve_debuff == 0 then
					local var_52_15 = lx.ServerTime:getUtcTime()
					local var_52_16 = var_0_37.find_object_by_id(23)

					if var_52_16.start_time < var_52_15 and var_52_15 < var_52_16.end_time then
						var_52_14 = true
					end
				end
			end

			var_52_6 = var_52_13 == "2" and var_52_5.pve_condition_weak or var_52_5.pve_condition

			local var_52_17 = var_52_5.pve_id
			local var_52_18 = var_52_3.point

			var_52_9 = var_52_2 == gameenum.battle_type.fight_type.main and var_0_16.find_object_by_id(var_52_18) or var_0_18.find_object_by_id(var_52_18)

			if var_52_9.award and next(var_52_9.award) and var_0_3:get_use_info_data().ship_drop > 500 then
				var_0_39:show(var_0_1:getNowLang("nomoreshiptip"))
			end

			local var_52_19 = var_0_3:get_team_members(1, var_52_10)
			local var_52_20 = var_52_19 and var_0_27.little_clone(var_52_19) or {}
			local var_52_21 = tonumber(var_52_4) % 100

			if var_52_0 == var_0_5.fight_type.fearlessness_sea and self._combat_res_grade <= 3 and var_52_9.support_icon and var_52_9.support_icon ~= 0 then
				local var_52_22 = var_0_3:get_account_id()
				local var_52_23 = tonumber(var_0_41:getDataByID(var_0_7("is_first_station_%d", var_52_9.pve_level_id), var_52_22))

				if not var_52_23 or var_52_23 == 0 then
					var_0_41:setDataByID(var_0_7("is_first_station_%d", var_52_9.pve_level_id), var_52_22, tostring(var_52_9.pve_level_id))
				end
			end

			local var_52_24

			if var_52_0 == var_0_5.fight_type.fearlessness_sea then
				if var_52_9.node_hide and next(var_52_9.node_hide) and #var_52_9.next_node == 1 then
					for iter_52_0, iter_52_1 in pairs(var_52_9.node_hide) do
						var_52_24 = var_0_3:is_map_node_pass_b_and_b_up(var_52_9.pve_level_id, iter_52_1[1])
					end
				elseif var_52_9.node_hide and next(var_52_9.node_hide) then
					for iter_52_2, iter_52_3 in pairs(var_52_9.node_hide) do
						for iter_52_4, iter_52_5 in pairs(var_52_9.next_node) do
							if tonumber(iter_52_2) == iter_52_5 and var_52_9.node_miss ~= iter_52_5 then
								for iter_52_6, iter_52_7 in pairs(iter_52_3) do
									var_52_24 = var_0_3:is_map_node_pass_b_and_b_up(var_52_9.pve_level_id, var_0_18.find_object_by_id(tonumber(iter_52_7)).id)

									if not var_52_24 and next(var_52_9.node_miss) then
										for iter_52_8, iter_52_9 in pairs(var_52_9.node_miss) do
											for iter_52_10, iter_52_11 in pairs(iter_52_9) do
												var_52_24 = var_0_3:is_map_node_pass_b_and_b_up(var_52_9.pve_level_id, tonumber(iter_52_10))
												var_52_24 = not var_52_24
											end
										end
									else
										var_52_24 = true
									end
								end
							end
						end
					end
				end
			end

			if var_52_9.node_attribute == var_0_5.map_node_finish_type.normal_finish or var_52_9.node_attribute == var_0_5.map_node_finish_type.boss_finish or var_52_9.node_attribute == var_0_5.map_node_finish_type.normal and self._enter_type == var_0_5.fight_type.fearlessness_sea and var_52_24 == false then
				if var_52_0 == var_0_5.fight_type.fearlessness_sea then
					local function var_52_27()
						self:__set_bvr_close()
						var_0_2:destroyInstance("combat_result")
						var_0_2:destroyInstance("new_ship_or_equip")

						local var_53_0 = var_0_2:createInstance("fearlessness_sea")
						local var_53_1 = var_0_3:get_fearlessness_id()
						local var_53_2 = gameconfig.ship_rule_config.find_object_by_id(var_0_5.pve_init_active_id.fearlessness_event).content

						if var_53_2 and next(var_53_2) then
							var_53_1 = var_53_2.activeId
						end

						local var_53_3 = var_0_37.find_object_by_id(var_53_1)
						local var_53_4, var_53_5 = var_0_3:is_quickly_map_pass(var_52_4)

						if var_53_4 and var_52_5.next_pve_level_id[1] == var_53_3.hardLevels[1] then
							var_0_3:set_is_first_open_fearlessness_hard(true)

							var_53_0.cur_open_hard = true
						else
							var_53_0.cur_open_hard = false
						end

						var_53_0.cur_last_boss = not not (var_53_4 and var_52_4 == var_53_3.hardLevels[#var_53_3.hardLevels])

						local var_53_6 = var_0_3:get_clear_map_reward()

						if not var_0_3:get_fearlessness_is_hard() then
							var_53_0:show(var_53_1)

							if not var_53_6 then
								var_0_3:show_panel_mix_panel(var_52_4, false)
							end
						else
							var_53_0:show(var_53_1, true)

							local var_53_7, var_53_8 = var_0_3:get_open_fearless_sea_panel()

							if var_53_7 and var_53_8 then
								var_53_0:__finish_special_task(var_53_8)
							end

							var_0_3:show_panel_mix_panel(var_52_4)

							if not var_53_6 then
								var_0_3:show_panel_mix_panel(var_52_4)
							end
						end

						if var_53_0._active_config then
							if var_53_0._active_config.bgm then
								var_53_0:_play_audio(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_53_0._active_config.bgm))
							else
								var_53_0:_play_audio(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.sixth_activity_bgm))
							end
						else
							var_53_0:_play_audio(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.sixth_activity_bgm))
						end

						if var_52_9.node_attribute == var_0_5.map_node_finish_type.boss_finish then
							if var_53_4 then
								var_53_0:__pass_big_node(var_52_4)
							end

							var_53_0:show_panel_special_task_btn()
						end
					end

					if var_52_9.node_type == var_0_5.map_node_type.little_boss and self._combat_res_grade <= 2 and not var_0_3:is_point_stationed(var_52_18) then
						(var_0_2:getInstance("msgbox") or var_0_2:createInstance("msgbox")):show(var_0_1:getNowLang("doyouwantsetguardfleet"), function()
							var_0_3:req_StationPointReq(var_52_18, var_52_10, var_52_2)

							local var_54_0 = var_0_2:createInstance("loading")

							if var_54_0 then
								var_54_0:show()
							end
						end, function()
							var_52_27()
						end, var_0_1:getNowLang("setguardfleettitle"), var_0_5.msg_type.tip)
					else
						var_52_27()
					end

					return
				end

				local function var_52_28()
					local var_56_0 = var_0_2:createInstance("gotofight")

					var_0_2:destroyInstance("combat_result")
					var_0_2:destroyInstance("new_ship_or_equip")
					self:__set_bvr_close()
					var_56_0:show({
						is_open_init = true,
						toggle_index = var_0_5.fight_type.gotofight,
						init_chapter_index = var_52_17,
						init_map_index = var_52_21
					}, false)

					if var_52_4 >= 101 and var_52_4 <= 404 then
						var_56_0:_play_audio(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.fignt_one))
					elseif var_52_4 >= 501 and var_52_4 <= 605 then
						var_56_0:_play_audio(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.fignt_two))
					elseif var_52_4 >= 701 and var_52_4 <= 805 then
						var_56_0:_play_audio(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.fignt_three))
					elseif var_52_4 <= self.__max_normal_map_id then
						var_56_0:_play_audio(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.fignt_three))
					else
						var_56_0:_play_audio(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.fignt_three))
					end
				end

				if var_52_0 == var_0_5.fight_type.gotofight then
					log.print_r(var_52_9.node_type, "node_config.node_type")

					if var_52_9.node_type == var_0_5.map_node_type.little_boss and self._combat_res_grade <= 2 and not var_0_3:is_point_stationed(var_52_18) then
						(var_0_2:getInstance("msgbox") or var_0_2:createInstance("msgbox")):show(var_0_1:getNowLang("doyouwantsetguardfleet"), function()
							var_0_3:req_StationPointReq(var_52_18, var_52_10, var_52_2)
						end, function()
							var_52_28()
						end, var_0_1:getNowLang("setguardfleettitle"), var_0_5.msg_type.tip)
					else
						var_52_28()
					end
				else
					var_52_28()
				end
			elseif var_52_14 and var_52_6 ~= 0 and var_52_6 < self._data.grade then
				var_0_2:destroyInstance("combat_result")
				var_0_2:destroyInstance("new_ship_or_equip")
				var_0_2:createInstance("gotofight"):show({
					is_open_init = true,
					toggle_index = var_0_5.fight_type.gotofight,
					init_chapter_index = var_52_17,
					init_map_index = var_52_21
				}, true)
			else
				var_0_2:destroyInstance("combat_result")
				var_0_2:destroyInstance("new_ship_or_equip")

				local var_52_29 = var_0_2:createInstance("fight_info")
				local var_52_30 = {
					show_continue_tip = true,
					fight_type = var_0_5.fight_type.gotofight,
					map_id = var_52_4,
					members = var_52_20,
					start_node_id = var_52_18
				}

				if var_52_0 == var_0_5.fight_type.fearlessness_sea then
					var_52_30.fight_type = var_0_5.fight_type.fearlessness_sea
				end

				var_52_29:show(var_52_30)

				if var_52_0 ~= var_0_5.fight_type.fearlessness_sea then
					var_52_29:_play_audio(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.fignt_one))
				end

				var_52_29._control.bg.info_bg.round_about_lock_enemy_txt:SetActive(false)

				if var_52_4 >= 101 and var_52_4 <= 404 then
					var_52_29:_play_audio(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.fignt_one))
				elseif var_52_4 >= 501 and var_52_4 <= 605 then
					var_52_29:_play_audio(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.fignt_two))
				elseif var_52_4 >= 701 and var_52_4 <= 805 then
					var_52_29:_play_audio(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.fignt_three))
				elseif var_52_4 <= self.__max_normal_map_id then
					var_52_29:_play_audio(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.fignt_three))
				elseif var_52_4 >= var_0_5.active_big_id.east_car_start and var_52_4 <= var_0_5.active_big_id.east_end_start then
					var_52_29:_play_audio(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.battle_east))
				elseif var_0_3:get_fearlessness_id() then
					-- block empty
				end
			end
		elseif var_52_0 == var_0_5.battle_type.friend_exercise and var_52_2 == gameenum.battle_type.fight_type.maneuver then
			if var_52_1 == var_0_5.select_back_type.captainroom then
				var_0_2:destroyInstance("combat_result")
				var_0_2:createInstance("captainroom"):show(var_0_5.enter_captainroom_type.friend, (var_0_3:get_friend_info(var_0_3:get_friend_id())))
			elseif var_52_1 == var_0_5.select_back_type.show_room then
				var_0_2:destroyInstance("combat_result")
				var_0_2:createInstance("show_room"):show(var_0_3:get_friend_id(), var_0_5.show_room_enter_type.friend, true)
			elseif var_52_1 == var_0_5.select_back_type.tower_rank_list then
				var_0_2:createInstance("climb_tower")
				var_0_2:destroyInstance("combat_result")
				var_0_2:createInstance("show_room"):show({
					_is_friend = true,
					account_id = var_0_3:get_friend_id()
				}, var_0_5.show_room_enter_type.tower, true)
			elseif var_52_1 == var_0_5.select_back_type.tower_rank_friend_captainroom then
				local var_52_31 = var_0_3:get_friend_info(var_0_3:get_friend_id())

				var_52_31._is_friend = true

				var_0_2:destroyInstance("combat_result")
				var_0_2:createInstance("captainroom"):show(var_0_5.enter_captainroom_type.tower, var_52_31)
			end
		elseif var_52_0 == var_0_5.battle_type.exercise and var_52_2 == gameenum.battle_type.fight_type.maneuver then
			var_0_2:destroyInstance("combat_result")
			var_0_2:createInstance("gotofight"):show({
				toggle_index = var_0_5.fight_type.exercise
			}, false)
		elseif var_52_2 == gameenum.battle_type.fight_type.campaign and var_52_0 == var_0_5.battle_type.campaign then
			var_0_2:destroyInstance("combat_result")
			var_0_2:createInstance("gotofight"):show({
				toggle_index = var_0_5.fight_type.campaign,
				difficulty = var_0_3:get_campaign_difficulty()
			}, false)
		elseif var_52_0 == var_0_5.battle_type.event_story and not var_0_3:set_back_type() then
			local var_52_32 = var_0_3:get_battle_info()
			local var_52_33 = var_52_32.id
			local var_52_34 = var_52_32.map_id
			local var_52_35 = var_0_21.find_object_by_id(var_52_32.id).level_id
			local var_52_36 = var_52_32.point
			local var_52_37 = var_0_22.find_object_by_id(var_52_32.point)

			if var_52_37.node_type == 2 then
				local var_52_38 = var_0_2:createInstance("six_year_main_interface")

				var_0_2:destroyInstance("combat_result")
				var_52_38:show()
				var_52_38:__set_now_map_data(var_0_3:get_now_map_level())
				var_0_3:set_battle_type(nil)
			else
				local var_52_39 = var_0_2:createInstance("fight_info")
				local var_52_40 = {}

				if #var_52_37.self_formation ~= 0 then
					var_52_40 = var_52_37.self_formation
				end

				self.teams = {}

				for iter_52_12, iter_52_13 in pairs(var_52_40) do
					local var_52_41 = var_0_10.find_object_by_cid(iter_52_13)

					var_0_8(self.teams, {
						data = var_52_41,
						config = var_52_41
					})
				end

				local var_52_42 = self.teams and var_0_27.little_clone(self.teams) or {}
				local var_52_43 = {
					show_continue_tip = true,
					fight_type = var_0_5.fight_type.event_story,
					map_id = var_52_34,
					team_detail_data = var_52_42,
					start_node_id = var_52_36,
					id = var_52_33
				}

				var_0_2:destroyInstance("combat_result")
				var_52_39:show(var_52_43)
				var_52_39._control.bg.info_bg.round_about_lock_enemy_txt:SetActive(false)
			end
		elseif var_52_2 == gameenum.battle_type.fight_type.ocean_attack then
			local var_52_44 = var_0_3:get_battle_info()
			local var_52_45 = var_52_44.id
			local var_52_46 = var_52_44.point
			local var_52_47 = var_0_26.find_object_by_id_start_node_id(var_52_44.point, (var_0_3:get_current_ocean_map_start_point()))

			var_0_2:destroyInstance("combat_result")

			if var_52_47.node_attribute == var_0_5.map_node_finish_type.boss_finish or var_52_47.node_attribute == var_0_5.map_node_finish_type.normal_finish then
				local var_52_48 = var_0_3:get_clear_map_reward()
				local var_52_49 = var_0_2:createInstance("ocean_main_map")

				var_52_49:show()
				var_52_49:__show_next_map()

				if var_52_48 then
					local var_52_50 = var_52_48[1].type

					self._point_seq = self:autoKillDOTween(var_0_11.Sequence())

					self._point_seq:AppendInterval(0)
					self._point_seq:AppendCallback(function()
						local var_59_0 = var_0_2:createInstance("reward_tip")

						if var_52_50 == var_0_5.reward_type.item then
							var_59_0:show_map_pass(var_0_1:getNowLang("logget"), var_0_17.find_object_by_cid(var_52_48[1].id).title .. "*" .. var_52_48[1].count)
						elseif var_52_50 == var_0_5.reward_type.head_icon then
							var_59_0:show_by_enter_type(var_0_44.find_object_by_cid(var_52_48[1].id).icon, var_0_5.enter_get_ship_type.mail_new_head_award, function()
								return
							end)
						elseif var_52_50 == var_0_5.reward_type.equipment or var_52_50 == var_0_5.reward_type.ship then
							local var_59_1 = var_0_2:createInstance("new_ship_or_equip")
							local var_59_2 = var_0_3:get_clear_map_reward()

							if var_59_2 then
								var_59_1:show(true, var_59_2[1], var_0_5.enter_get_ship_type.up_award, function()
									var_0_3:set_clear_map_reward(nil)
								end)
							end
						end
					end)
				end
			else
				local var_52_51 = var_0_2:createInstance("fight_info")
				local var_52_52 = var_0_3:get_ocean_team_detail_data()
				local var_52_53 = var_52_52 and var_0_27.little_clone(var_52_52) or {}

				var_52_51:show({
					show_continue_tip = true,
					fight_type = var_0_5.fight_type.ocean_attack,
					map_id = var_52_45,
					team_detail_data = var_52_53,
					start_node_id = var_52_46
				})
				var_52_51:__set_map_node()
				var_52_51._control.bg.info_bg.round_about_lock_enemy_txt:SetActive(false)
			end
		elseif var_52_2 == gameenum.battle_type.fight_type.score then
			local var_52_54 = var_0_3:get_battle_info()
			local var_52_55 = var_52_54.id
			local var_52_56 = var_52_54.point
			local var_52_57 = var_52_54.team
			local var_52_58 = var_0_45.find_object_by_id_start_node_id(var_52_54.point, (var_0_3:get_current_score_map_start_point()))

			local function var_52_59()
				var_0_2:destroyInstance("combat_result")
				var_0_2:destroyInstance("new_ship_or_equip")

				local var_62_0 = var_0_2:getInstance("score_push_map")

				if var_62_0 then
					var_62_0:show()
					var_62_0:show_score_panel_mix_panel(var_52_55, var_0_3:get_is_cur_score_difficulty_mode())
				else
					local var_62_1 = var_0_2:createInstance("score_push_map")

					var_62_1:show()
					var_62_1:show_score_panel_mix_panel(var_52_55, var_0_3:get_is_cur_score_difficulty_mode())
				end
			end

			if var_52_58.node_attribute == var_0_5.map_node_finish_type.boss_finish or var_52_58.node_attribute == var_0_5.map_node_finish_type.normal_finish and var_52_58.node_type ~= var_0_5.map_node_type.little_boss then
				local var_52_60 = var_0_3:get_clear_map_reward()
				local var_52_61 = var_0_2:createInstance("score_push_map")

				var_52_61:show()
				var_52_61:__show_next_map()
				var_52_61:show_score_panel_mix_panel(var_52_55, var_0_3:get_is_cur_score_difficulty_mode())

				if var_52_61 then
					local var_52_62 = var_0_3:get_boss_hp_info()

					if var_52_62 then
						for iter_52_14, iter_52_15 in pairs((var_0_3:get_score_map_data())) do
							if var_52_55 == iter_52_14 and iter_52_15.boss_hp then
								for iter_52_16, iter_52_17 in pairs(iter_52_15.boss_hp) do
									if iter_52_17.id == var_52_56 and iter_52_17.hp <= self._data.enemy_state[1].max_hp and iter_52_17.hp == 0 and self._data.enemy_state[1].hp == 0 and (var_52_62.boss_now_hp ~= 0 or var_52_62.bvr_kill) then
										var_52_61:show_panel_pass()
									end
								end
							end
						end
					end
				end
			elseif var_52_58.node_type == var_0_5.map_node_type.little_boss then
				if self._combat_res_grade <= 2 and not var_0_3:is_point_stationed(var_52_56) then
					var_0_2:createInstance("msgbox"):show(var_0_1:getNowLang("doyouwantsetguardfleet"), function()
						var_0_3:req_StationPointReq(var_52_56, var_52_57, var_52_2)
						var_0_2:destroyInstance("combat_result")
						var_0_2:destroyInstance("new_ship_or_equip")

						local var_63_0 = var_0_3:get_account_id()
						local var_63_1 = tonumber(var_0_41:getDataByID(var_0_7("is_first_station_%d", var_52_58.pve_level_id), var_63_0))

						if not var_63_1 or var_63_1 == 0 then
							var_0_41:setDataByID(var_0_7("is_first_station_%d", var_52_58.pve_level_id), var_63_0, tostring(var_52_58.pve_level_id))
						end

						local var_63_2 = var_0_2:createInstance("loading")

						if var_63_2 then
							var_63_2:show()
						end
					end, function()
						var_52_59()
					end, var_0_1:getNowLang("setguardfleettitle"), var_0_5.msg_type.tip)
				else
					var_52_59()
				end
			else
				local var_52_64 = var_0_2:createInstance("fight_info")
				local var_52_65 = var_0_3:get_now_team_data()
				local var_52_66 = var_52_65 and var_0_27.little_clone(var_52_65) or {}

				var_52_64:show({
					show_continue_tip = true,
					fight_type = var_0_5.fight_type.score_attack,
					map_id = var_52_55,
					team_detail_data = var_52_66,
					start_node_id = var_52_56
				})
				var_52_64._control.bg.info_bg.round_about_lock_enemy_txt:SetActive(false)
				var_52_64:__set_map_node()
			end
		elseif var_52_2 == gameenum.battle_type.fight_type.climb_tower and var_52_0 == var_0_5.battle_type.climb_tower then
			local var_52_67 = var_0_2:createInstance("climb_tower")

			var_0_2:destroyInstance("combat_result")
		elseif var_52_2 == gameenum.battle_type.fight_type.strike and var_52_0 == var_0_5.battle_type.strike then
			local var_52_68 = var_0_3:get_strike_point_info()

			var_0_2:destroyInstance("combat_result")

			if var_52_68.next_point_id == 0 then
				local var_52_69 = var_0_2:createInstance("strike_map")
				local var_52_70 = var_0_3:get_strike_pass_buff()
				local var_52_71 = 0

				if var_52_70 then
					for iter_52_18, iter_52_19 in pairs(var_52_70.buffs) do
						var_52_71 = var_52_71 + iter_52_19.score
					end
				end

				var_52_69:show(var_0_3:get_current_ocean_map_start_point(), nil, true)
				var_52_69:show_new_result(var_52_71, (var_0_3:get_strike_now_state()))
			else
				local var_52_72 = var_0_2:createInstance("strike_map")

				var_52_72:set_last_battle_grade(self._data.grade)
				var_52_72:set_show_lock(true)
				var_52_72:show(var_52_68.id)

				if var_0_3:get_strike_config() then
					self:_play_audio(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_42.find_object_by_id(var_52_68.id or 0).music1), true)
				else
					self:_play_audio(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.sixth_activity_bgm), true)
				end

				var_0_3:record_strike_enter_battle_nunber()
			end
		elseif var_52_2 == gameenum.battle_type.fight_type.war_concerto and var_52_0 == var_0_5.fight_type.war_concerto then
			local var_52_73 = var_0_3:get_battle_info()

			local function var_52_74()
				var_0_2:destroyInstance("combat_result")

				local var_65_0 = var_0_2:createInstance("fifth_event")

				if var_65_0 then
					var_65_0:show()
				end
			end

			local var_52_75 = var_0_25.find_object_by_id(var_0_3:get_fifth_now_node())

			if var_0_3:get_fifth_level_cfg().type == var_0_5.fifth_node_type.son and var_52_75 and var_52_75.node_type == var_0_5.map_node_type.little_boss and not var_0_3:get_fifth_next_node() then
				self:setVisible(true)

				if self._combat_res_grade <= 2 then
					(var_0_2:getInstance("msgbox") or var_0_2:createInstance("msgbox")):show(var_0_1:getNowLang("doyouwantsetguardfleet"), function()
						var_0_3:req_ConcertoStationReq(var_52_73.id, var_0_3:get_current_team())

						local var_66_0 = var_0_2:createInstance("loading")

						if var_66_0 then
							var_66_0:show()
						end
					end, function()
						var_52_74()
					end, var_0_1:getNowLang("setguardfleettitle"), var_0_5.msg_type.tip)
				else
					var_52_74()
				end
			else
				var_0_2:destroyInstance("combat_result")

				local var_52_76 = var_0_2:createInstance("fight_info")
				local var_52_77 = var_0_3:get_now_team_data()
				local var_52_78 = var_52_77 and var_0_27.little_clone(var_52_77) or {}

				var_52_76:show({
					fight_type = var_0_5.fight_type.war_concerto,
					map_id = var_52_73.id,
					team_detail_data = var_52_78,
					start_node_id = var_52_73.point,
					input_map_node_id = var_0_3:get_now_node()
				})
				var_52_76._control.bg.info_bg.round_about_lock_enemy_txt:SetActive(false)
			end
		elseif var_52_2 == gameenum.battle_type.fight_type.war_concerto_play and var_0_3:get_battle_info().type == var_0_5.battle_type.war_concerto_play then
			local var_52_79 = var_0_3:get_battle_info()
			local var_52_80 = var_52_79.id
			local var_52_81 = var_0_28.find_object_by_id(var_52_79.id)
			local var_52_82 = var_0_25.find_object_by_id(var_52_79.point)
			local var_52_83 = var_0_2:getInstance("combat_result")

			if var_52_82.node_attribute == var_0_5.map_node_finish_type.normal_finish or var_52_82.node_attribute == var_0_5.map_node_finish_type.boss_finish then
				local function var_52_84()
					var_0_2:destroyInstance("combat_result")

					local var_68_0 = var_0_2:createInstance("fifth_event")

					if var_68_0 then
						var_68_0:show()
						var_68_0:__change_btn_event(false)
					end
				end

				local var_52_85 = var_0_3:check_recreation_point_increase()

				if var_52_85 then
					var_52_83:setVisible(true)
					;(var_0_2:getInstance("msgbox") or var_0_2:createInstance("msgbox")):showOne({
						url = var_0_5.fifth_event_const.joy.reward_icon,
						num = var_52_85,
						reward_name = var_0_17.find_object_by_cid(var_0_5.fifth_recreation_award_cid).title
					}, var_52_84, nil, var_0_1:getNowLang("logget"), var_0_5.msg_type.reward)
				else
					var_52_84()
				end
			else
				local function var_52_86()
					local var_69_0 = {}

					for iter_69_0, iter_69_1 in pairs((var_0_3:get_fifth_team_data())) do
						local var_69_1, var_69_2, var_69_3 = var_0_3:get_fake_ship_data(iter_69_1)

						var_69_0[iter_69_0] = {
							data = var_69_1 and var_0_27.little_clone(var_69_1),
							config = var_69_2 and var_0_27.little_clone(var_69_2),
							attrs = var_69_3 and var_0_27.little_clone(var_69_3)
						}
					end

					local var_69_5 = var_0_2:createInstance("fight_info")

					var_0_2:destroyInstance("combat_result")
					var_69_5:show({
						show_continue_tip = true,
						fight_type = var_0_5.fight_type.war_concerto_play,
						map_id = var_52_80,
						team_detail_data = var_69_0,
						start_node_id = var_52_79.point
					})
					var_69_5._control.bg.info_bg.round_about_lock_enemy_txt:SetActive(false)
				end

				local var_52_87 = var_0_3:check_recreation_point_increase()

				if var_52_87 then
					var_52_83:setVisible(true)
					;(var_0_2:getInstance("msgbox") or var_0_2:createInstance("msgbox")):showOne({
						url = var_0_5.fifth_event_const.joy.reward_icon,
						num = var_52_87,
						reward_name = var_0_17.find_object_by_cid(var_0_5.fifth_recreation_award_cid).title
					}, var_52_86, nil, var_0_1:getNowLang("logget"), var_0_5.msg_type.reward)
				else
					var_52_86()
				end
			end
		elseif var_52_2 == gameenum.battle_type.fight_type.ninth then
			local var_52_88 = var_0_3:get_battle_info()
			local var_52_89 = var_52_88.id
			local var_52_90 = var_52_88.point
			local var_52_91 = var_52_88.team
			local var_52_92 = var_0_47.find_object_by_id_start_node_id(var_52_88.point, (var_0_3:get_ninth_map_start_point()))

			local function var_52_93()
				var_0_2:destroyInstance("combat_result")
				var_0_2:destroyInstance("new_ship_or_equip")

				local var_70_0 = var_0_2:getInstance("ninth_main_map")

				if var_70_0 then
					var_70_0:show()

					if var_52_89 == var_70_0._active_config.levels[5] or var_52_89 == var_70_0._active_config.hardLevels[5] then
						local var_70_1 = var_0_46.find_object_by_id(var_52_89)

						for iter_70_0 = 1, 4 do
							var_70_0:_show_map_panel(var_52_89, iter_70_0, var_70_1.init_nodes)
						end
					else
						var_70_0:_show_map_panel(var_52_89, 1, var_0_46.find_object_by_id(var_52_89).init_node_id)
					end
				else
					local var_70_2 = var_0_2:createInstance("ninth_main_map")

					var_70_2:show()

					if var_52_89 == var_70_2._active_config.levels[5] or var_52_89 == var_70_2._active_config.hardLevels[5] then
						local var_70_3 = var_0_46.find_object_by_id(var_52_89)

						for iter_70_1 = 1, 4 do
							var_70_2:_show_map_panel(var_52_89, iter_70_1, var_70_3.init_nodes)
						end
					else
						var_70_2:_show_map_panel(var_52_89, 1, var_0_46.find_object_by_id(var_52_89).init_node_id)
					end
				end
			end

			local function var_52_94()
				local var_71_0 = var_0_2:createInstance("fight_info")
				local var_71_1 = var_0_3:get_now_team_data()
				local var_71_2 = var_71_1 and var_0_27.little_clone(var_71_1) or {}

				var_71_0:show({
					show_continue_tip = true,
					fight_type = var_0_5.fight_type.ninth_attack,
					map_id = var_52_89,
					team_detail_data = var_71_2,
					start_node_id = var_52_90
				})
				var_71_0._control.bg.info_bg.round_about_lock_enemy_txt:SetActive(false)
				var_71_0:__set_map_node()
			end

			if var_52_92.node_attribute == var_0_5.map_node_finish_type.boss_finish or var_52_92.node_attribute == var_0_5.map_node_finish_type.normal_finish and var_52_92.node_type ~= var_0_5.map_node_type.little_boss then
				self:__set_bvr_close()
				var_0_2:destroyInstance("combat_result")
				var_0_2:destroyInstance("new_ship_or_equip")

				local var_52_95 = var_0_3:get_clear_map_reward()
				local var_52_96 = var_0_2:createInstance("ninth_main_map")

				var_52_96:show()

				local var_52_97 = false

				if var_52_96 then
					local var_52_98 = var_0_3:get_ninth_boss_hp_info()

					if var_52_98 and type(var_52_98) == "number" then
						for iter_52_20, iter_52_21 in pairs((var_0_3:get_ninth_map_data())) do
							if var_52_88.id == iter_52_20 and iter_52_21.hp and iter_52_21.hp == 0 and var_52_98 ~= 0 then
								var_52_97 = true

								var_52_96:show_panel_pass()
							end
						end
					end
				end

				if not var_52_97 then
					if var_52_88.id == var_52_96._active_config.levels[5] or var_52_88.id == var_52_96._active_config.hardLevels[5] and var_0_3:get_is_ninth_boss() then
						local var_52_100 = var_0_46.find_object_by_id(var_52_88.id)

						for iter_52_22 = 1, 4 do
							var_52_96:_show_map_panel(var_52_88.id, iter_52_22, var_52_100.init_nodes)
						end
					else
						var_52_96:_show_map_panel(var_52_88.id, 1, var_0_46.find_object_by_id(var_52_88.id).init_node_id)
					end
				end
			elseif var_52_92.node_type == var_0_5.map_node_type.little_boss then
				if self._combat_res_grade <= 2 and not var_0_3:is_point_stationed(var_52_88.point) then
					var_0_2:createInstance("msgbox"):show(var_0_1:getNowLang("doyouwantsetguardfleet"), function()
						var_0_3:req_StationPointReq(var_52_90, var_52_91, var_52_2)
						var_0_2:destroyInstance("combat_result")
						var_0_2:destroyInstance("new_ship_or_equip")

						local var_72_0 = var_0_3:get_account_id()
						local var_72_1 = tonumber(var_0_41:getDataByID(var_0_7("is_first_station_%d", var_52_92.pve_level_id), var_72_0))

						if not var_72_1 or var_72_1 == 0 then
							var_0_41:setDataByID(var_0_7("is_first_station_%d", var_52_92.pve_level_id), var_72_0, tostring(var_52_92.pve_level_id))
						end

						local var_72_2 = var_0_2:createInstance("loading")

						if var_72_2 then
							var_72_2:show()
						end
					end, function()
						if var_52_92 and next(var_52_92) then
							if var_52_92.next_node and next(var_52_92.next_node) then
								var_52_94()
							else
								var_52_93()
							end
						else
							var_52_93()
						end
					end, var_0_1:getNowLang("setguardfleettitle"), var_0_5.msg_type.tip)
				elseif var_52_92 and next(var_52_92) then
					if var_52_92.next_node and next(var_52_92.next_node) then
						var_52_94()
					else
						var_52_93()
					end
				else
					var_52_93()
				end
			else
				var_52_94()
			end
		elseif var_52_0 == var_0_5.fight_type.abyss_model_first_phase and (var_52_2 == gameenum.battle_type.fight_type.abyss or var_52_2 == gameenum.battle_type.fight_type.abyss_2) then
			local var_52_101 = var_0_38.find_object_by_chapter_id(4)
			local var_52_102 = var_0_2:createInstance("fight_info")

			var_52_102:_play_audio(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.abyss_activity_bgm))

			local var_52_103 = var_0_3:get_battle_info()
			local var_52_104 = var_0_3:get_battle_result()
			local var_52_105 = var_0_3:get_abyss_now_chapter_cfg()
			local var_52_106 = var_0_36.find_object_by_id(var_52_103.point)

			local function var_52_107(arg_74_0)
				local var_74_0 = var_0_2:createInstance("new_ship_or_equip")

				var_74_0._combat_res_grade = self._combat_res_grade

				var_74_0:show(true, self._get_ship_info, var_0_5.enter_get_ship_type.salvage_award, arg_74_0)
			end

			local function var_52_108()
				if var_52_102 then
					local var_75_0 = var_0_3:get_abyss_fight_info_param()
					local var_75_1
					local var_75_2 = var_52_103.type == gameenum.battle_type.fight_type.abyss_2

					if var_52_103.type == gameenum.battle_type.fight_type.abyss_2 then
						local var_75_3 = var_0_3:get_abyss_team_info()

						var_75_1 = var_75_3 and var_0_27.little_clone(var_75_3) or {}
					else
						local var_75_4 = var_0_3:get_normal_team_info()

						var_75_1 = var_75_4 and var_0_27.little_clone(var_75_4) or {}
					end

					local var_75_5 = {
						show_continue_tip = true,
						fight_type = var_0_5.fight_type.abyss_model_first_phase,
						map_id = var_75_0.map_id,
						members = var_75_1,
						start_node_id = var_52_103.point,
						is_abyss_team = var_75_2
					}

					if not var_75_5 or not next(var_75_5) then
						return
					end

					var_0_2:destroyInstance("combat_result")
					var_52_102:show(var_75_5)
					var_52_102._control.bg.info_bg.round_about_lock_enemy_txt:SetActive(false)
				end
			end

			if var_52_106 and (var_52_106.node_type == var_0_5.map_node_type.little_boss or var_52_106.node_type == var_0_5.map_node_type.boss) then
				local var_52_109 = var_0_3:check_abyss_state() or 1
				local var_52_110 = var_0_3:get_abyss_now_chapter_cfg()

				var_0_3:set_abyss_fight_start_point(var_52_109, nil)
				var_0_3:set_abyss_now_team((var_52_109 == 1 or nil) and (var_0_5.team_type.abyss_owner_team or var_0_5.team_type.abyss_team))
				var_0_3:record_abyss_enter_repair_point()

				local var_52_111, var_52_112 = math.modf(var_0_3:get_abyss_enter_repair_time() / 2)
				local var_52_113 = var_52_111 == 0 and not var_52_109 or var_52_112 == 0
				local var_52_114 = true

				for iter_52_23, iter_52_24 in pairs(var_52_104.enemy_state) do
					if iter_52_24.hp > 0 then
						var_52_114 = false
					end
				end

				if var_52_113 or var_52_105.type == var_52_101.type and var_52_114 then
					local var_52_115 = var_0_2:createInstance("abyss_event")
					local var_52_116 = var_52_115:create_chapter_cfg()

					local function var_52_117()
						local var_76_0 = var_0_3:get_award_item_info()

						if var_76_0 then
							var_52_102:setVisible(true)

							local var_76_1 = var_0_2:getInstance("abyss_preview")

							if var_76_1 then
								var_76_1:setVisible(false)
							end

							var_0_2:createInstance("msgbox"):showOnes(var_76_0, function()
								var_0_2:destroyInstance("msgbox")
								var_52_102:setVisible(false)
								var_0_2:destroyInstance("combat_result")
								var_52_115:show()
							end, var_0_1:getNowLang("space_confirm"), var_0_1:getNowLang("logget"), var_0_5.msg_type.abyss_node_rewards, nil, true, true)
						elseif self._get_ship then
							var_52_107(function()
								var_0_2:destroyInstance("combat_result")
								var_52_115:show()
							end)
						else
							var_0_2:destroyInstance("combat_result")
							var_52_115:show()
						end
					end

					if var_52_116 and next(var_52_116) then
						local var_52_118 = var_0_3:get_clear_map_reward()

						if var_52_118 then
							local function var_52_119()
								var_0_2:destroyInstance("msgbox")
								var_0_3:set_clear_map_reward(nil)

								if next((self:__set_abyss_reward_data(var_52_106))) then
									var_0_3:setAbyssAwardBoxRespCallback(var_52_117)
									var_0_3:req_AbyssAwardBoxReq(var_52_106.id)
								else
									if self._get_ship then
										var_52_107(function()
											var_0_2:destroyInstance("combat_result")
											var_52_115:show()
										end)
									else
										var_0_2:destroyInstance("combat_result")
										var_52_115:show()
									end

									return
								end
							end

							;(function()
								var_0_2:createInstance("msgbox"):showOnes(var_52_118, var_52_119, var_0_1:getNowLang("space_confirm"), var_0_1:getNowLang("logget"), var_0_5.msg_type.rewards, nil, true, true)
							end)()
						elseif var_52_105.type == var_52_101.type then
							local var_52_120
							local var_52_121 = 0
							local var_52_123 = var_0_3:get_abyss_world_boss_info(4)

							if var_52_123 then
								local var_52_124 = var_0_27.little_clone(var_52_123)

								var_52_120 = (not var_52_124 or next(var_52_124)) and 3 or var_52_124.step
								var_52_121 = var_52_121 + var_52_101[string.format("pass_score%d", var_52_120)]
							end

							if var_52_104.enemy_state[1].hp == 0 then
								var_52_121 = var_52_121 + var_52_101[string.format("boss_score%d", var_52_120)]
							end

							local var_52_125 = {}

							table.insert(var_52_125, {
								id = 19,
								count = var_52_121
							})

							local function var_52_126()
								var_0_2:destroyInstance("msgbox")

								if next((self:__set_abyss_reward_data(var_52_106))) then
									var_0_3:setAbyssAwardBoxRespCallback(var_52_117)
									var_0_3:req_AbyssAwardBoxReq(var_52_106.id)
								else
									if self._get_ship then
										var_52_107(function()
											var_0_2:destroyInstance("combat_result")
											var_52_115:show()
										end)
									else
										var_0_2:destroyInstance("combat_result")
										var_52_115:show()
									end

									return
								end
							end

							;(function()
								var_0_2:createInstance("msgbox"):showOnes(var_52_125, var_52_126, var_0_1:getNowLang("space_confirm"), var_0_1:getNowLang("logget"), var_0_5.msg_type.rewards, nil, true, true)
							end)()
						else
							var_0_2:destroyInstance("abyss_preview")
							;(function()
								if next((self:__set_abyss_reward_data(var_52_106))) then
									var_0_3:setAbyssAwardBoxRespCallback(var_52_117)
									var_0_3:req_AbyssAwardBoxReq(var_52_106.id)
								elseif self._get_ship then
									var_52_107(function()
										var_0_2:destroyInstance("combat_result")
										var_52_115:show()
									end)
								else
									var_0_2:destroyInstance("combat_result")
									var_52_115:show()
								end
							end)()
						end
					end

					return
				end

				local function var_52_127()
					if next((self:__set_abyss_reward_data(var_52_106))) then
						local var_87_0 = var_0_3:get_award_item_info()

						if var_87_0 then
							var_52_102:setVisible(true)
							var_0_2:createInstance("msgbox"):showOnes(var_87_0, function()
								var_52_102:setVisible(false)
								var_0_2:destroyInstance("msgbox")
								var_0_2:destroyInstance("new_ship_or_equip")
								var_0_2:destroyInstance("combat_result")
								var_0_2:createInstance("abyss_preview"):show(var_52_110, var_0_5.abyss_const.abyss_enter_preview_type.select_team)
							end, var_0_1:getNowLang("space_confirm"), var_0_1:getNowLang("logget"), var_0_5.msg_type.abyss_node_rewards, nil, true, true)
						end
					else
						local var_87_1 = var_0_2:createInstance("abyss_preview")

						var_0_2:destroyInstance("new_ship_or_equip")
						var_0_2:destroyInstance("combat_result")
						self:_play_audio(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.abyss_activity_bgm))
						var_87_1:show(var_52_110, var_0_5.abyss_const.abyss_enter_preview_type.select_team)
					end
				end

				if self._get_ship then
					var_52_107(function()
						var_52_127()
					end)
				else
					var_52_127()
				end

				return
			end

			if self._get_ship then
				var_52_107(function()
					var_52_108()
				end)
			else
				var_52_108()
			end
		elseif var_52_2 == gameenum.battle_type.fight_type.seventh then
			local function var_52_128(arg_91_0)
				var_0_2:destroyInstance("combat_result")
				var_0_2:destroyInstance("new_ship_or_equip")

				local var_91_0 = var_0_3:get_now_seven_map_id()
				local var_91_1 = var_0_2:getInstance("seven_sea_map")
				local var_91_2 = true
				local var_91_3 = var_0_3:get_clear_map_reward()

				var_91_2 = var_91_3 and next(var_91_3) or false

				if var_91_1 then
					var_91_1:show(var_91_0)

					if arg_91_0 and not var_91_2 then
						var_91_1:set_boss_func(true)
					end
				else
					var_91_1 = var_0_2:createInstance("seven_sea_map")

					var_91_1:show(var_91_0)

					if arg_91_0 and not var_91_2 then
						var_91_1:set_boss_func(true)
					end
				end

				var_91_1:show_cover_func(false)

				local var_91_4 = var_0_3:get_seven_special_task_data()

				if next(var_91_4) then
					var_0_2:getInstance("seven_sea_map"):__finish_special_task(var_91_4)
				end
			end

			local var_52_129 = var_0_3:get_now_seven_map_fight_type()

			if var_52_129 == var_0_5.select_seventh_fight_type.encounter or var_52_129 == var_0_5.select_seventh_fight_type.exploration then
				var_52_128()
			elseif var_52_129 == var_0_5.select_seventh_fight_type.boss then
				local var_52_130 = var_0_3:get_battle_info()
				local var_52_131 = var_52_130.id
				local var_52_132 = var_52_130.point
				local var_52_133 = var_52_130.team
				local var_52_134 = var_0_31.find_object_by_id(var_52_130.point)
				local var_52_135 = false

				for iter_52_25, iter_52_26 in pairs(var_52_134.node_hide) do
					if #var_52_134.next_node == 1 and var_0_3:get_seven_map_node_pass_count(var_52_134.pve_level_id, iter_52_26[1]) then
						var_52_135 = true
					end
				end

				if var_52_134.node_attribute == var_0_5.map_node_finish_type.boss_finish or var_52_134.node_attribute == var_0_5.map_node_finish_type.normal_finish and var_52_134.node_type ~= var_0_5.map_node_type.little_boss or var_52_135 then
					local var_52_136 = var_0_3:get_clear_map_reward()

					if not var_52_136 or not next(var_52_136) then
						var_52_128(true)

						return
					else
						(function()
							var_0_2:destroyInstance("combat_result")
							var_0_2:destroyInstance("new_ship_or_equip")

							local var_92_0 = var_0_3:get_seventh_event_activity_id()
							local var_92_1 = var_0_2:getInstance("mix_main_map")

							if var_92_1 then
								var_92_1:show(var_92_0)
							else
								var_0_2:createInstance("mix_main_map"):show(var_92_0)
							end
						end)()
					end

					local var_52_138 = var_0_2:getInstance("mix_main_map")
					local var_52_139 = var_0_3:get_seven_special_task_data()

					if next(var_52_139) then
						var_52_138:__finish_special_task(var_52_139)
					end

					if var_52_138 then
						var_52_138:show_panel_pass()
					end
				elseif var_52_134.node_type == var_0_5.map_node_type.little_boss then
					if self._combat_res_grade <= 2 and not var_0_3:is_point_stationed(var_52_130.point) then
						(var_0_2:getInstance("msgbox") or var_0_2:createInstance("msgbox")):show(var_0_1:getNowLang("doyouwantsetguardfleet"), function()
							var_0_2:destroyInstance("combat_result")
							var_0_2:destroyInstance("new_ship_or_equip")
							var_0_3:req_StationPointReq(var_52_132, var_52_133, var_52_2)

							local var_94_0 = var_0_3:get_account_id()
							local var_94_1 = tonumber(var_0_41:getDataByID(var_0_7("is_first_station_%d", var_52_134.pve_level_id), var_94_0))

							if not var_94_1 or var_94_1 == 0 then
								var_0_41:setDataByID(var_0_7("is_first_station_%d", var_52_134.pve_level_id), var_94_0, tostring(var_52_134.pve_level_id))
							end

							local var_94_2 = var_0_2:createInstance("loading")

							if var_94_2 then
								var_94_2:show()
							end
						end, function()
							var_52_128(true)
						end, var_0_1:getNowLang("setguardfleettitle"), var_0_5.msg_type.tip)
					else
						var_52_128(true)
					end
				else
					(function()
						var_0_2:destroyInstance("combat_result")
						var_0_2:destroyInstance("new_ship_or_equip")

						local var_93_0 = var_0_3:get_now_team_data()
						local var_93_1 = var_93_0 and var_0_27.little_clone(var_93_0) or {}
						local var_93_2 = var_0_2:createInstance("fight_info")

						var_93_2:show({
							show_continue_tip = true,
							fight_type = var_0_5.fight_type.seventh,
							map_id = var_52_131,
							team_detail_data = var_93_1,
							start_node_id = var_52_132
						})
						var_93_2._control.bg.info_bg.round_about_lock_enemy_txt:SetActive(false)
						var_93_2:_play_audio(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_29.find_object_by_id(var_52_130.id).music_battle))
						var_93_2:__set_map_node()
					end)()
				end
			end
		elseif var_52_2 == gameenum.battle_type.fight_type.eighth then
			local function var_52_140(arg_96_0)
				var_0_2:destroyInstance("combat_result")
				var_0_2:destroyInstance("new_ship_or_equip")

				local var_96_0 = var_0_3:get_now_eighth_map_id()
				local var_96_1 = var_0_2:getInstance("eighth_sea_map")
				local var_96_2 = true
				local var_96_3 = var_0_3:get_clear_map_reward()

				var_96_2 = var_96_3 and next(var_96_3) or false

				if var_96_1 then
					var_96_1:show(var_96_0)

					if arg_96_0 and not var_96_2 then
						var_96_1:set_boss_func(true)
					end
				else
					var_96_1 = var_0_2:createInstance("eighth_sea_map")

					var_96_1:show(var_96_0)

					if arg_96_0 and not var_96_2 then
						var_96_1:set_boss_func(true)
					end
				end

				var_96_1:show_cover_func(false)

				local var_96_4 = var_0_2:getInstance("eighth_sea_map")
				local var_96_5 = var_0_3:get_eighth_special_task_data()

				if next(var_96_5) then
					var_96_4:__finish_special_task(var_96_5)
				end

				local var_96_6 = var_0_3:get_eighth_special_task_data()

				if var_96_6 and next(var_96_6) then
					var_96_4:__finish_special_task(var_96_6)
				end
			end

			local var_52_141 = var_0_3:get_now_eighth_map_fight_type()

			if var_52_141 == var_0_5.select_eighth_fight_type.encounter or var_52_141 == var_0_5.select_eighth_fight_type.exploration then
				var_52_140()
			elseif var_52_141 == var_0_5.select_eighth_fight_type.boss then
				local var_52_142 = var_0_3:get_battle_info()
				local var_52_143 = var_52_142.id
				local var_52_144 = var_52_142.point
				local var_52_145 = var_52_142.team
				local var_52_146 = var_0_33.find_object_by_id(var_52_142.point)
				local var_52_147 = false

				for iter_52_27, iter_52_28 in pairs(var_52_146.node_hide) do
					if #var_52_146.next_node == 1 and var_0_3:get_eighth_map_node_pass_count(var_52_146.pve_level_id, iter_52_28[1]) then
						var_52_147 = true
					end
				end

				if var_52_146.node_attribute == var_0_5.map_node_finish_type.boss_finish or var_52_146.node_attribute == var_0_5.map_node_finish_type.normal_finish and var_52_146.node_type ~= var_0_5.map_node_type.little_boss or var_52_147 then
					local var_52_148 = var_0_3:get_clear_map_reward()

					if not var_52_148 or not next(var_52_148) then
						var_52_140(true)

						return
					else
						(function()
							var_0_2:destroyInstance("combat_result")
							var_0_2:destroyInstance("new_ship_or_equip")

							local var_97_0 = var_0_3:get_eighth_event_activity_id()

							var_0_41:setDataByID("eighth_select_map_info" .. var_97_0 .. var_0_3:get_server_name(), var_0_3:get_account_id(), "")

							local var_97_1 = var_0_2:getInstance("eighth_main_map")

							if var_97_1 then
								var_97_1:show(var_97_0)

								local var_97_2 = var_0_3:get_eighth_special_task_data()

								if var_97_2 and next(var_97_2) then
									var_97_1:__finish_special_task(var_97_2)
								end
							else
								local var_97_3 = var_0_2:createInstance("eighth_main_map")

								var_97_3:show((var_0_3:get_eighth_event_activity_id()))

								local var_97_4 = var_0_3:get_eighth_special_task_data()

								if var_97_4 and next(var_97_4) then
									var_97_3:__finish_special_task(var_97_4)
								end
							end
						end)()
					end

					local var_52_150 = var_0_2:getInstance("eighth_main_map")

					if var_52_150 then
						var_52_150:show_panel_pass()
					end
				elseif var_52_146.node_type == var_0_5.map_node_type.little_boss then
					if self._combat_res_grade <= 2 and not var_0_3:is_point_stationed(var_52_142.point) then
						(var_0_2:getInstance("msgbox") or var_0_2:createInstance("msgbox")):show(var_0_1:getNowLang("doyouwantsetguardfleet"), function()
							var_0_2:destroyInstance("combat_result")
							var_0_2:destroyInstance("new_ship_or_equip")
							var_0_3:req_StationPointReq(var_52_144, var_52_145, var_52_2)

							local var_99_0 = var_0_3:get_account_id()
							local var_99_1 = tonumber(var_0_41:getDataByID(var_0_7("is_first_station_%d", var_52_146.pve_level_id), var_99_0))

							if not var_99_1 or var_99_1 == 0 then
								var_0_41:setDataByID(var_0_7("is_first_station_%d", var_52_146.pve_level_id), var_99_0, tostring(var_52_146.pve_level_id))
							end

							local var_99_2 = var_0_2:createInstance("loading")

							if var_99_2 then
								var_99_2:show()
							end
						end, function()
							var_52_140(true)
						end, var_0_1:getNowLang("setguardfleettitle"), var_0_5.msg_type.tip)
					else
						var_52_140(true)
					end
				else
					(function()
						var_0_2:destroyInstance("combat_result")
						var_0_2:destroyInstance("new_ship_or_equip")

						local var_98_0 = var_0_3:get_now_team_data()
						local var_98_1 = var_98_0 and var_0_27.little_clone(var_98_0) or {}
						local var_98_2 = var_0_2:createInstance("fight_info")

						var_98_2:show({
							show_continue_tip = true,
							fight_type = var_0_5.fight_type.eighth_attack,
							map_id = var_52_143,
							team_detail_data = var_98_1,
							start_node_id = var_52_144
						})

						local var_98_3 = var_0_3:get_eighth_special_task_data()

						if var_98_3 and next(var_98_3) then
							var_98_2:__finish_special_task(var_98_3)
						end

						var_98_2._control.bg.info_bg.round_about_lock_enemy_txt:SetActive(false)
						var_98_2:_play_audio(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_32.find_object_by_id(var_52_142.id).music_battle))
						var_98_2:__set_map_node()
					end)()
				end
			end
		elseif var_0_3:get_to_six_year() or var_0_3:get_to_six_fight_map() then
			if var_0_3:get_now_six_bgm() then
				self:_play_audio(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_3:get_now_six_bgm()))
			else
				self:_play_audio(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.sixth_activity_bgm))
			end

			local var_52_151 = var_0_2:createInstance("sixth_map_node")
			local var_52_152 = var_0_3:get_sixth_combat_info()
			local var_52_153 = var_0_3:get_cur_sixth_map()
			local var_52_154 = var_0_22.find_object_by_id(var_52_152.point)

			var_52_151._control.left_bg.cur_count.text.text = var_52_152.coin

			var_0_2:destroyInstance("combat_result")
			var_52_151:show({
				id = var_52_152.id
			})
		end
	end

	function arg_1_0.__set_abyss_reward_data(arg_101_0, arg_101_1)
		local var_101_0 = {}

		for iter_101_0, iter_101_1 in pairs(arg_101_1.awardbox) do
			local var_101_1 = var_0_17.find_object_by_cid(iter_101_1)

			if var_101_1 then
				var_101_0[#var_101_0 + 1] = {
					count = 1,
					type = 2,
					id = var_101_1.cid
				}
			end
		end

		return var_101_0
	end

	function arg_1_0:__back_combat()
		local var_102_0 = var_0_3:get_battle_result()

		if self.exp_seq then
			self.exp_seq:Kill()

			self.exp_seq = nil
		end

		if self.love_seq then
			self.love_seq:Kill()

			self.love_seq = nil
		end

		if self._spine_residual and not self._spine_residual:Equals(nil) then
			self._spine_residual.Skeleton:SetToSetupPose()
			self._spine_residual.AnimationState:ClearTracks()
		end

		local var_102_1 = var_0_3:get_battle_type()

		if self._get_ship then
			if var_102_1 ~= var_0_5.fight_type.abyss_model_first_phase then
				local var_102_2 = var_0_3:get_use_info_data()
				local var_102_3 = var_0_2:createInstance("new_ship_or_equip")

				var_102_3._combat_res_grade = self._combat_res_grade

				local var_102_4 = var_0_2:getInstance("combat_result")

				if var_102_4 then
					var_102_4:setVisible(false)
				end

				if var_102_1 == var_0_5.fight_type.score_attack and #self._get_ship_info >= 1 then
					local var_102_5 = var_0_2:createInstance("score_push_map")

					var_102_5:show()
					var_102_5:show_score_panel_mix_panel(var_0_3:get_battle_info().id, var_0_3:get_is_cur_score_difficulty_mode())

					if #self._get_ship_info == 1 then
						var_102_3:show(true, self._get_ship_info[1], var_0_5.enter_get_ship_type.salvage_award)
					else
						var_102_3:show(true, self._get_ship_info, var_0_5.enter_get_ship_type.salvage_award)
					end
				else
					var_102_3:show(true, self._get_ship_info, var_0_5.enter_get_ship_type.salvage_award)
				end
			elseif var_102_1 == var_0_5.battle_type.climb_tower then
				local var_102_6 = var_0_2:createInstance("climb_tower")

				if var_102_6 then
					var_102_6:show(nil, self._tower_battle_data)
				end

				self:__other_call()
			else
				self:__other_call()
			end
		else
			local var_102_7 = var_0_3:get_battle_type()
			local var_102_8 = var_0_3:get_new_battle_type()

			if var_102_7 == var_0_5.battle_type.friend_exercise or var_102_8 == gameenum.battle_type.fight_type.maneuver or var_102_7 == var_0_5.battle_type.campaign or var_102_8 == gameenum.battle_type.fight_type.campaign or var_102_8 == gameenum.battle_type.fight_type.sixth or var_102_7 == var_0_5.battle_type.strike or var_102_8 == gameenum.battle_type.fight_type.strike then
				self:__other_call()

				return
			end

			if var_0_3:get_use_info_data().ship_drop > 500 then
				var_0_39:show(var_0_1:getNowLang("nomoreshiptip"))
				self:__other_call()

				return
			end

			self:__other_call()
		end
	end

	function arg_1_0.__set_bvr_close(arg_103_0)
		if var_0_2:getInstance("fight_info") then
			var_0_2:destroyInstance("fight_info")
		end
	end

	function arg_1_0:__onReset()
		self._control.bg.uITweenSequence:ResetParts()
		self._control.tool.uITweenSequence:ResetParts()

		self._control.dmg_set.user_dmg.image.fillAmount = 0
		self._control.dmg_set.enemy_dmg.image.fillAmount = 0
		self._control.character.characterone.image.sprite = nil

		self._control.score.spineparent.gameObject:SetActive(true)
		self:__destroy_spine(self._control.score.spineparent)

		for iter_104_0, iter_104_1 in ipairs(self._user_fleet_unit) do
			self:__destroy_spine(iter_104_1.main.smoke)
		end

		for iter_104_2, iter_104_3 in ipairs(self._enemy_fleet_unit) do
			self:__destroy_spine(iter_104_3.main.smoke)
		end

		self._exp_info = {}
		self._exp_position_list = {}

		self._control.maskto.gameObject:SetActive(true)

		self._control.bg.image.sprite = self:loadSprite("data/ui/common_bg/common_bg.png")
		self._already_init = false
		self._get_ship = false
		self._love_add_position_list = {}
		self._is_have_down = false
	end

	function arg_1_0:__destroy_spine(arg_105_1)
		if arg_105_1.transform:GetComponentsInChildren(typeof(UnityEngine.Transform)).Length > 1 then
			self:destroyGameObject(arg_105_1.transform:GetChild(0).gameObject)
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_106_0)
	local var_106_0 = var_0_2:class("combat_result")

	var_106_0._already_init = false
	var_106_0._battle_data = nil
	var_106_0._user_fleet_unit = {}
	var_106_0._enemy_fleet_unit = {}
	var_106_0._exp_info = {}
	var_106_0.exp_seq = nil
	var_106_0.love_seq = nil
	var_106_0.love_down_seq = nil
	var_106_0._get_ship = false
	var_106_0._get_ship_info = {}
	var_106_0._is_pvp = false
	var_106_0._college_imgs = nil
	var_106_0.college_seq = nil
	var_106_0._college_level_exp = nil
	var_106_0._college_level = nil
	var_106_0._college_skill_info = nil
	var_106_0._now_college_exp = nil
	var_106_0._have_love = false
	var_106_0._have_college = false
	var_106_0._ship_all_tactics = nil
	var_106_0._support_id = nil
	var_106_0._support_count = nil
	var_106_0._support_point = nil
	var_106_0._support_active = nil
	var_106_0._enter_type = 1
	var_106_0._exp_position_list = {}
	var_106_0._spine_residual = nil
	var_106_0._is_have_down = false
	var_106_0._tower_battle_data = {}

	return var_106_0
end

return var_0_0
