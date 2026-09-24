local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = gameenum.common_type
local var_0_5 = gamecore.util_func
local var_0_6 = gameconfig.ship_config
local var_0_7 = gameconfig.map_config
local var_0_8 = gameconfig.pve_active_map_config
local var_0_9 = gameconfig.shop_config
local var_0_10 = gameconfig.item_config
local var_0_11 = gameconfig.skill_config
local var_0_12 = string.format
local var_0_13 = table.remove
local var_0_14 = table.insert
local var_0_15 = UnityEngine.Vector2
local var_0_16 = UnityEngine.Color
local var_0_17 = 6
local var_0_18 = lx.clone_table
local var_0_19 = table.sort
local var_0_20 = gameconfig.support_atk_config
local var_0_22 = gameconfig.cook_book_config
local var_0_23 = gameconfig.furniture_config
local var_0_24 = gameconfig.tower_buff_stone_config
local var_0_25 = gameconfig.tower_buff_config
local var_0_26 = gameconfig.monster_formation_config
local var_0_27 = gameconfig.monster_config
local var_0_28 = gameconfig.support_config
local var_0_29 = gameconfig.strike_map_config
local var_0_30 = gameconfig.strike_buff_config
local var_0_31 = gameconfig.strike_weather_config
local var_0_32 = math.floor
local var_0_33 = math.ceil
local var_0_34 = math.modf
local var_0_35 = gamecore.prompt
local var_0_36 = gameenum.error_type
local var_0_37 = gameconfig.map_campaign_config
local var_0_38 = gameconfig.pve_ocean_level_config
local var_0_39 = gameconfig.pve_ocean_cia_config
local var_0_40 = gameconfig.equip_config
local var_0_41 = gameconfig.abyss_buff_config
local var_0_42 = UnityEngine.UI.LayoutRebuilder
local var_0_43 = DG.Tweening.DOTween
local var_0_44 = UnityEngine.UI.ContentSizeFitter
local var_0_45 = UnityEngine.RectTransform
local var_0_47 = gamecore.PreloadManager
local var_0_48 = gameconfig.bathhouse_config

gamecore.UILoader:define("fight_prepare", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2)
		self.isGray = arg_2_2

		self:setVisible(true)
		self:__init_panel(arg_2_1)
		self:__preload_battle_asset()
	end

	function arg_1_0:__preload_battle_asset()
		var_0_47:load_battle_sea()
		var_0_47:load_battle_submarine_sea()
		var_0_47:load_battle_prefab()

		if self._fight_prepare_type == var_0_4.fight_type.exercise then
			local var_3_0 = {
				player = {},
				enemy = {}
			}

			for iter_3_0, iter_3_1 in pairs(self._team_detail_data) do
				iter_3_1.data.cid = iter_3_1.config.cid
				iter_3_1.data.skin_id = iter_3_1.data.skin

				var_0_14(var_3_0.player, iter_3_1.data)
			end

			for iter_3_2, iter_3_3 in pairs((var_0_3:get_exercise_enemy_config_list())) do
				var_0_14(var_3_0.enemy, iter_3_3)
			end

			var_0_47:preload_battle_asset({
				bg_sea = "BG_sea_Normal"
			}, var_3_0)
			var_0_47:load_battle_music(var_3_0)
		end

		if self._fight_prepare_type == var_0_4.fight_type.strike then
			local var_3_1 = var_0_2:getInstance("strike_map")

			if var_3_1 then
				self._panel.transform:GetComponent("Canvas").sortingOrder = var_3_1._panel.transform:GetComponent("Canvas").sortingOrder + 1
			end
		else
			self._panel.transform:GetComponent("Canvas").sortingOrder = 500
		end
	end

	function arg_1_0:get_input_map_node()
		return tonumber(self._control.input_map_node.inputField.text)
	end

	function arg_1_0:show_test_input_map_node()
		local var_5_0 = var_0_3:get_account_id()

		if app:isPC() then
			self._control.input_map_node.text.text = "0"

			self._control.input_map_node:SetActive(true)
		end

		if var_5_0 == 16329 or var_5_0 == 16541 or var_5_0 == 17990 or var_5_0 == 16308 then
			self._control.input_map_node.text.text = "0"

			self._control.input_map_node:SetActive(true)
		end
	end

	function arg_1_0:get_curr_content_type()
		return self._current_content_type
	end

	function arg_1_0:__close_prepare()
		self:setVisible(false)
	end

	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end

		if self._tower_reusable_cell then
			self._tower_reusable_cell:update()
		end

		if self._strike_reusable_cell then
			self._strike_reusable_cell:update()
		end

		if self._ocean_reusable_cell then
			self._ocean_reusable_cell:update()
		end

		if self._click_times >= 0 then
			self._click_times = self._click_times - 0.1
		end

		if self._single_click_time >= 0 then
			self._single_click_time = self._single_click_time - 0.1
		end

		if self._start_fight_time >= 0 then
			self._start_fight_time = self._start_fight_time - 0.1
		end

		if self._support_time >= 0 then
			self._support_time = self._support_time - 0.1
		end
	end

	function arg_1_0:update_damage_control_count()
		self._control.right_widget.damage_group_bg.count.text.text = var_0_3:get_item_count(var_0_9.find_object_by_id(var_0_4.shop_damage_control_cid).content[1].id)
	end

	function arg_1_0:refresh_info_list(arg_10_1)
		self._panel.transform:GetComponent("Canvas").sortingOrder = 500

		if var_0_2:getInstance("strike_map") then
			self._panel.transform:GetComponent("Canvas").sortingOrder = 501
		end

		if not arg_10_1 and self._copy_team_data then
			self._team_data = var_0_18(self._copy_team_data)
			self._copy_team_data = nil
		end

		self:__update_prepare_item_list(self._current_content_type, self._current_team_index)
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup:ReSetBoundaryPosXList()

		if self._current_content_type == var_0_4.fight_prepare_right_panel_type.props or self._current_content_type == var_0_4.fight_prepare_right_panel_type.supply or self._current_content_type == var_0_4.fight_prepare_right_panel_type.repair or self._current_content_type == var_0_4.fight_prepare_right_panel_type.equip_preview or self._current_content_type == var_0_4.fight_prepare_right_panel_type.ninth_preview or self._current_content_type == var_0_4.fight_prepare_right_panel_type.ninth_equip_preview then
			if self._fight_prepare_type == var_0_4.fight_type.farfight then
				self:__set_condition_panel_data()
			end

			self:__set_total_props_panel_data()
		elseif self._current_content_type == var_0_4.fight_prepare_right_panel_type.condition or self._current_content_type == var_0_4.fight_prepare_right_panel_type.farfight_equip_preview then
			self:__set_condition_panel_data()
		end

		self:__set_total_supply_panel_data()
		self:__set_total_repair_panel_data()

		if self._fight_prepare_type == var_0_4.fight_type.tower_fight then
			self:__update_tower_cost()
		end
	end

	function arg_1_0:refresh_campaign_info_list()
		if self._fight_prepare_type ~= var_0_4.fight_type.campaign then
			return
		end

		self:__update_campaign_prepare()
		self:__set_total_supply_panel_data()
		self:__set_total_repair_panel_data()
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup:ReSetBoundaryPosXList()

		if self._campaign then
			self._control.right_widget.bg_back.speed_skeleton_mask:SetActive(false)
		end
	end

	function arg_1_0:refresh_sixth_info_list()
		self:__update_sixth_item_list(self._current_content_type)
		self:__set_total_supply_panel_data()
		self:__set_total_repair_panel_data()
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup:ReSetBoundaryPosXList()
	end

	function arg_1_0:refresh_mist_info_list()
		self:__update_mist_item_list(self._current_content_type)
		self:__set_mist_ship_info()
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup:ReSetBoundaryPosXList()
	end

	function arg_1_0:refresh_strike_info_list()
		self:__update_strike_item_list(self._current_content_type)
		self:__set_total_supply_panel_data()
		self:__set_total_repair_panel_data()
		self:__update_strike_buffs()
		self:destroyChildren("single_strike_buff_item")

		self._strike_reusable_cell = gamecore.reusable_cell:create(self, self._control.right_widget.bg_back.strike_info.buffs.Viewport.edge_mask.content.endlessScrollView, self._control.right_widget.bg_back.strike_info.buffs.Viewport.edge_mask.content, "single_strike_buff_item", "fight_prepare", true)

		self._strike_reusable_cell:init()
		self:change_strike_buff_color()
		self:__update_strike_reusable_cell()
		self:__set_total_props_panel_data()
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup:ReSetBoundaryPosXList()
	end

	function arg_1_0:refresh_ocean_info_list()
		self:__update_ocean_item_list(self._current_content_type)
		self:__set_total_supply_panel_data()
		self:__set_total_repair_panel_data()
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup:ReSetBoundaryPosXList()
	end

	function arg_1_0:refresh_concerto_info_list()
		self:__update_concerto_item_list(self._current_content_type)
		self:__set_total_props_panel_data()
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup:ReSetBoundaryPosXList()
	end

	function arg_1_0:toggle_team(arg_17_1)
		self._team_group_data = var_0_3:get_team_group(self._team_type)

		local var_17_0 = self._current_team_index % 4 == 0 and 4 or self._current_team_index % 4

		self._control.left_widget.team_toggle[var_0_12("toggle%d", self._current_team_index % 4 == 0 and 4 or self._current_team_index % 4)].bg.title.text.color = var_0_16.New(1, 1, 1, 0.5019607843137255)
		self._control.left_widget.team_toggle[var_0_12("toggle%d", var_17_0)].bg.title.text.fontSize = 28
		self._current_team_index = arg_17_1

		if self._fight_prepare_type == var_0_4.fight_type.campaign then
			self._team_type = var_0_4.team_type.campaign
		elseif self._fight_prepare_type == var_0_4.fight_type.farfight then
			self._team_type = var_0_4.team_type.expedition
		else
			self._team_type = var_0_4.team_type.normal

			var_0_3:set_cur_click_team_index(self._current_team_index)

			if self._fight_prepare_type == var_0_4.fight_type.gotofight or self._fight_prepare_type == var_0_4.fight_type.exercise or self._fight_prepare_type == var_0_4.fight_type.show_room_friend or self._fight_prepare_type == var_0_4.fight_type.captainroom_friend or self._fight_prepare_type == var_0_4.fight_type.tower_rank_friend_captainroom or self._fight_prepare_type == var_0_4.fight_type.fearlessness_sea or self._fight_prepare_type == var_0_4.fight_type.seventh or self._fight_prepare_type == var_0_4.fight_type.tower_fight or self._fight_prepare_type == var_0_4.fight_type.score_attack or self._fight_prepare_type == var_0_4.fight_type.ninth_attack or self._fight_prepare_type == var_0_4.fight_type.eighth_attack then
				self._gotofight_memory_team_index = self._current_team_index
			end
		end

		local var_17_1 = self._current_team_index % 4 == 0 and 4 or self._current_team_index % 4

		self._control.left_widget.team_toggle[var_0_12("toggle%d", self._current_team_index % 4 == 0 and 4 or self._current_team_index % 4)].bg.title.text.color = var_0_16.New(1, 1, 1, 1)
		self._control.left_widget.team_toggle[var_0_12("toggle%d", var_17_1)].bg.title.text.fontSize = 30

		self:refresh_info_list(true)
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.task_goto))

		if self._fight_prepare_type == var_0_4.fight_type.eighth_attack then
			var_0_3:set_eighth_team(self._current_team_index)
		end
	end

	function arg_1_0:get_current_team_index()
		return self._current_team_index
	end

	function arg_1_0:__show_collection(arg_19_1)
		local var_19_0 = false
		local var_19_1 = {}

		for iter_19_0, iter_19_1 in pairs(arg_19_1) do
			if iter_19_1.id ~= 0 then
				var_0_14(var_19_1, iter_19_1)
			end
		end

		var_0_19(var_19_1, function(arg_20_0, arg_20_1)
			return arg_20_0.index < arg_20_1.index
		end)

		for iter_19_2 = 1, 3 do
			local var_19_2

			if var_19_1[iter_19_2] then
				var_19_2 = var_0_10.find_object_by_cid(var_19_1[iter_19_2].id)

				if var_19_1[iter_19_2].id ~= 0 and var_19_2 then
					var_19_0 = true
				end
			end

			self:__update_collection_info(iter_19_2, var_19_2)
		end

		self._control.collect_layer:SetActive(var_19_0)

		if not var_19_0 then
			var_0_35:show(var_0_1:getNowLang("nocollections"))
		end
	end

	function arg_1_0:__update_collection_info(arg_21_1, arg_21_2)
		if arg_21_2 then
			self._control.collect_layer["collect_cell" .. arg_21_1]:SetActive(true)

			self._control.collect_layer["collect_cell" .. arg_21_1].icon.image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.collection_use_icon[1], arg_21_2.cid))

			self._control.collect_layer["collect_cell" .. arg_21_1].name_scroller:GetComponent("TextHorizonScroller"):SetText(arg_21_2.title)

			self._control.collect_layer["collect_cell" .. arg_21_1].ship_type.text.text = arg_21_2.effect_desc
		else
			self._control.collect_layer["collect_cell" .. arg_21_1]:SetActive(false)
		end
	end

	function arg_1_0:get_team_type()
		return self._team_type
	end

	function arg_1_0.__found_in_team(arg_23_0, arg_23_1)
		for iter_23_0 = 1, 2 do
			for iter_23_1, iter_23_2 in pairs((var_0_3:get_team_group(iter_23_0))) do
				for iter_23_3, iter_23_4 in pairs(iter_23_2.members) do
					if iter_23_4 == arg_23_1 then
						return iter_23_1, iter_23_3
					end
				end
			end
		end
	end

	function arg_1_0:save_team_single_info(arg_24_1, arg_24_2)
		local var_24_0 = var_0_5.check_single_team_member_change_saveable(arg_24_1, arg_24_2, var_0_18(self._team_data), self._current_team_index)

		if var_24_0 then
			var_0_3:req_TeamSave(var_24_0)
		end
	end

	function arg_1_0:ship_repair(arg_25_1)
		self._repair_item_index = arg_25_1

		var_0_3:req_QuickRepairReq({
			self._ship_item_list[arg_25_1]:get_data().id
		})
	end

	function arg_1_0:ship_repair_refresh()
		for iter_26_0, iter_26_1 in pairs(self._ship_item_list) do
			iter_26_1:refresh_hp()
			iter_26_1:update_ship_state()
		end

		if self._fight_prepare_type == var_0_4.fight_type.campaign then
			self._team_detail_data = var_0_3:get_campaign_team_info()

			self:__init_campaign_prepare()
		end

		if self._team_detail_data and next(self._team_detail_data) then
			for iter_26_2, iter_26_3 in pairs(self._team_detail_data) do
				iter_26_3.data = var_0_5.little_clone((var_0_3:find_character_by_id(iter_26_3.data.id)))
			end

			self:set_strike_panel_mask()
		end

		self:__set_total_repair_panel_data()
	end

	function arg_1_0.set_click_time(arg_27_0, arg_27_1)
		arg_27_0._single_click_time = arg_27_1
	end

	function arg_1_0:get_click_time()
		return self._single_click_time
	end

	function arg_1_0:has_repair_or_expedition_or_station()
		if self._team_type == var_0_4.team_type.ocean_attack_team then
			self._team_group_data = var_0_3:get_ocean_team_data()

			for iter_29_0 = 1, var_0_17 do
				if self._team_group_data[iter_29_0] then
					local var_29_0 = var_0_3:find_character_by_id(self._team_group_data[iter_29_0])

					if var_29_0.state == var_0_4.ship_state.repair or var_29_0.state == var_0_4.ship_state.expedition then
						var_0_35:show(var_0_1:getNowLang("hasshipinrepair1"))

						return true
					elseif var_29_0.state == var_0_4.ship_state.station then
						var_0_35:show(var_0_1:getNowLang("noticeshipisinguard"))

						return true
					end
				end
			end
		elseif self._team_type == var_0_4.team_type.sixth_team then
			local var_29_1 = var_0_3:get_sixth_combat_info().members

			for iter_29_1 = 1, var_0_17 do
				if var_29_1 then
					local var_29_2 = var_29_1[iter_29_1] or nil

					if var_29_2 then
						local var_29_3 = var_0_3:find_character_by_id(var_29_2)

						if self._fight_prepare_type == var_0_4.fight_type.sixth_fight then
							if var_29_3.state == var_0_4.ship_state.repair then
								var_0_35:show(var_0_1:getNowLang("shipinrepair"))

								return true
							elseif var_29_3.state == var_0_4.ship_state.station then
								var_0_35:show(var_0_1:getNowLang("noticeshipisinguard"))

								return true
							end
						end
					end
				end
			end
		elseif self._team_type == var_0_4.team_type.strike_map_team then
			for iter_29_2 = 1, var_0_17 do
				if self._strike_team_data then
					local var_29_4 = self._strike_team_data[iter_29_2] or nil

					if var_29_4 then
						local var_29_5 = var_0_3:find_character_by_id(var_29_4)

						if self._fight_prepare_type == var_0_4.fight_type.strike then
							if var_29_5.state == var_0_4.ship_state.repair or var_29_5.state == var_0_4.ship_state.expedition then
								var_0_35:show(var_0_1:getNowLang("shipinrepair"))

								return true
							elseif var_29_5.state == var_0_4.ship_state.station then
								var_0_35:show(var_0_1:getNowLang("noticeshipisinguard"))

								return true
							end
						end
					end
				end
			end
		elseif self._team_type == var_0_4.team_type.abyss_team or self._team_type == var_0_4.team_type.abyss_owner_team then
			local var_29_6 = var_0_3:get_normal_team_info()

			for iter_29_3 = 1, var_0_17 do
				if var_29_6 then
					local var_29_7 = var_29_6[iter_29_3] or nil

					if var_29_7 then
						local var_29_8 = var_0_3:find_character_by_id(var_29_7)

						if var_29_8.state == var_0_4.ship_state.repair then
							var_0_35:show(var_0_1:getNowLang("hasshipinrepair1"))

							return true
						elseif var_29_8.state == var_0_4.ship_state.expedition then
							var_0_35:show(var_0_1:getNowLang("hasshipinexplore1"))

							return true
						elseif var_29_8.state == var_0_4.ship_state.station then
							var_0_35:show(var_0_1:getNowLang("noticeshipisinguard"))

							return true
						end
					end
				end
			end
		elseif self._team_type == var_0_4.team_type.war_concerto_play_team then
			for iter_29_4 = 1, var_0_17 do
				if self._war_concerto_team_data then
					local var_29_9 = self._war_concerto_team_data[iter_29_4] or nil

					if var_29_9 then
						local var_29_10 = var_0_3:find_character_by_id(var_29_9)

						if self._fight_prepare_type == var_0_4.fight_type.war_concerto_play then
							if var_29_10.state == var_0_4.ship_state.repair or var_29_10.state == var_0_4.ship_state.expedition then
								var_0_35:show(var_0_1:getNowLang("shipinrepair"))

								return true
							elseif var_29_10.state == var_0_4.ship_state.station then
								var_0_35:show(var_0_1:getNowLang("noticeshipisinguard"))

								return true
							end
						end
					end
				end
			end
		else
			for iter_29_5, iter_29_6 in pairs(var_0_3:get_team_group(self._team_type)) do
				self._team_group_data[iter_29_5] = iter_29_6
			end

			for iter_29_7 = 1, var_0_17 do
				if self._team_group_data[self._current_team_index] then
					local var_29_11 = self._team_group_data[self._current_team_index].members[iter_29_7] or nil

					if var_29_11 then
						local var_29_12 = var_0_3:find_character_by_id(var_29_11)

						if self._fight_prepare_type == var_0_4.fight_type.gotofight or self._fight_prepare_type == var_0_4.fight_type.score_attack then
							if var_29_12.state == var_0_4.ship_state.repair then
								var_0_35:show(var_0_1:getNowLang("shipinrepair"))

								return true
							elseif var_29_12.state == var_0_4.ship_state.station then
								var_0_35:show(var_0_1:getNowLang("noticeshipisinguard"))

								return true
							end
						end
					end
				end
			end
		end

		return false
	end

	function arg_1_0:team_repair()
		if #self._team_detail_data == 0 then
			var_0_35:show(var_0_1:getNowLang("norepair"))

			return
		end

		if self._total_repair_item_need == 0 then
			var_0_35:show(var_0_1:getNowLang("no_need_repair"))

			return
		end

		local var_30_0 = var_0_3:get_use_info_data()

		if self._total_oil_need > var_30_0.oil then
			var_0_35:show(var_0_1:getNowLang("oilnotenough"))

			return
		end

		if self._total_steel_need > var_30_0.fe then
			var_0_35:show(var_0_1:getNowLang("steelnotenough"))

			return
		end

		if self._total_repair_item_need > self:__get_quick_repair_item_count() then
			var_0_35:show(var_0_1:getNowLang("quick_item_not_enough"))

			return
		end

		if self._team_type ~= var_0_4.team_type.ocean_attack_team then
			self._team_group_data = var_0_3:get_team_group(self._team_type)

			for iter_30_0 = 1, var_0_17 do
				if self._team_group_data[self._current_team_index] then
					local var_30_1 = self._team_group_data[self._current_team_index].members[iter_30_0] or nil

					if var_30_1 then
						local var_30_2 = var_0_3:find_character_by_id(var_30_1)
						local var_30_3 = var_0_6.find_object_by_cid(var_30_2.cid)

						if var_30_2.state == var_0_4.ship_state.expedition then
							return
						end
					end
				end
			end
		else
			self._team_group_data = var_0_3:get_ocean_team_data()

			for iter_30_1 = 1, var_0_17 do
				if self._team_group_data[iter_30_1] then
					local var_30_4 = var_0_3:find_character_by_id(self._team_group_data[iter_30_1])
					local var_30_5 = var_0_6.find_object_by_cid(var_30_4.cid)

					if var_30_4.state == var_0_4.ship_state.expedition then
						return
					end
				end
			end
		end

		if self._current_team_index then
			var_0_3:req_TeamQuickRepair({
				id = self._current_team_index
			})
		end
	end

	function arg_1_0:campaign_team_repair()
		if self._team_detail_data and next(self._team_detail_data) and #self._team_detail_data == 0 then
			var_0_35:show(var_0_1:getNowLang("norepair"))

			return
		end

		if self._total_repair_item_need == 0 then
			var_0_35:show(var_0_1:getNowLang("no_need_repair"))

			return
		end

		local var_31_0 = var_0_3:get_use_info_data()

		if self._total_oil_need > var_31_0.oil then
			var_0_35:show(var_0_1:getNowLang("oilnotenough"))

			return
		end

		if self._total_steel_need > var_31_0.fe then
			var_0_35:show(var_0_1:getNowLang("steelnotenough"))

			return
		end

		if self._total_repair_item_need > self:__get_quick_repair_item_count() then
			var_0_35:show(var_0_1:getNowLang("quick_item_not_enough"))

			return
		end

		local var_31_1 = {}

		for iter_31_0, iter_31_1 in pairs(self._ship_item_list) do
			local var_31_2 = iter_31_1:get_data()

			if var_31_2 and var_31_2.now_hp < var_31_2.hp then
				var_0_14(var_31_1, var_31_2.id)
			end
		end

		var_0_3:req_QuickRepairReq(var_31_1)
	end

	function arg_1_0:set_supply_btn_state(arg_32_1)
		self._control.right_widget.bg_back.supply_panel.supply_all_btn.button.interactable = arg_32_1
	end

	function arg_1_0:set_repair_btn_state(arg_33_1)
		self._control.right_widget.bg_back.repair_panel.repair_all_btn.button.interactable = arg_33_1
	end

	function arg_1_0:team_repair_refresh()
		for iter_34_0, iter_34_1 in pairs(self._ship_item_list) do
			iter_34_1:refresh_hp()
			iter_34_1:update_ship_state()
		end

		for iter_34_2, iter_34_3 in pairs(self._team_detail_data) do
			iter_34_3.data = var_0_5.little_clone((var_0_3:find_character_by_id(iter_34_3.data.id)))
		end

		self:__set_total_repair_panel_data()
	end

	function arg_1_0:ship_supply(arg_35_1)
		local var_35_0 = var_0_3:get_use_info_data()

		if not arg_35_1 then
			if self._total_oil_need > var_35_0.oil then
				var_0_35:show(var_0_1:getNowLang("oilnotenough"))

				return false
			end

			if self._total_bullet_need > var_35_0.bullet then
				var_0_35:show(var_0_1:getNowLang("ammonotenough"))

				return false
			end

			if self._total_aluminium_need > var_35_0.al then
				var_0_35:show(var_0_1:getNowLang("aluminumnotenough"))

				return false
			end

			self._supply_item_list = {}

			for iter_35_0, iter_35_1 in pairs(self._ship_item_list) do
				local var_35_1 = iter_35_1:get_data()

				if var_35_1 then
					var_0_14(self._supply_item_list, var_35_1.id)
				end
			end

			if next(self._supply_item_list) then
				var_0_3:req_ShipSupply({
					id_array = self._supply_item_list
				})
			end
		else
			local var_35_2 = self._ship_item_list[arg_35_1]
			local var_35_3 = self._ship_item_list[arg_35_1]:get_supply_need()

			if var_35_3.oil_need > var_35_0.oil then
				var_0_35:show(var_0_1:getNowLang("oilnotenough"))

				return false
			end

			if var_35_3.bullet_need > var_35_0.bullet then
				var_0_35:show(var_0_1:getNowLang("ammonotenough"))

				return false
			end

			if var_35_3.aluminium_need > var_35_0.al then
				var_0_35:show(var_0_1:getNowLang("aluminumnotenough"))

				return false
			end

			self._supply_item_index = arg_35_1

			local var_35_4 = var_35_2:get_data()

			if var_35_4 then
				var_0_3:req_ShipSupply({
					id_array = {
						var_35_4.id
					}
				})
			end
		end

		return true
	end

	function arg_1_0:__check_resource_enough()
		local var_36_0 = var_0_3:get_use_info_data()

		if self._total_oil_need > var_36_0.oil then
			var_0_35:show(var_0_1:getNowLang("oilnotenough"))

			return false
		end

		if self._total_bullet_need > var_36_0.bullet then
			var_0_35:show(var_0_1:getNowLang("ammonotenough"))

			return false
		end

		if self._total_aluminium_need > var_36_0.al then
			var_0_35:show(var_0_1:getNowLang("aluminumnotenough"))

			return false
		end

		return true
	end

	function arg_1_0:ship_supply_refresh(arg_37_1)
		if self._this_toggle_not_need_refresh then
			self:delay_enter_map()

			return
		end

		if self._supply_item_list then
			for iter_37_0, iter_37_1 in pairs(self._supply_item_list) do
				local var_37_0 = iter_37_0

				if self._campagion_team_data then
					for iter_37_2, iter_37_3 in pairs(self._campagion_team_data) do
						if iter_37_3 == iter_37_1 then
							var_37_0 = iter_37_2
						end
					end
				end

				local var_37_1 = self._ship_item_list[var_37_0]

				self._ship_item_list[var_37_0]:refresh_supply()

				if next(arg_37_1.tactics) then
					for iter_37_4, iter_37_5 in pairs(arg_37_1.tactics) do
						if iter_37_5.id == iter_37_1 then
							var_37_1:show_tactic(arg_37_1.tactics[iter_37_4])
						end
					end
				end
			end

			self:__set_total_supply_panel_data()
			self:delay_enter_map()

			return
		end

		local var_37_2 = self._ship_item_list[self._supply_item_index]

		self._ship_item_list[self._supply_item_index]:refresh_supply()

		if next(arg_37_1.tactics) then
			var_37_2:show_tactic(arg_37_1.tactics[1])
		end

		self:__set_total_supply_panel_data()
		self:delay_enter_map()
	end

	function arg_1_0:delay_enter_map()
		if self._fight_prepare_type == var_0_4.fight_type.sixth_fight and self._is_sixth_enter_point then
			self._is_sixth_enter_point = nil

			var_0_3:req_SixthEnterPointReq()
		elseif self._fight_prepare_type == var_0_4.fight_type.campaign and self._is_campaign_enter then
			self._is_campaign_enter = nil

			var_0_3:req_EnterCampaignReq({
				id = self._go_to_map_id
			})
		elseif self._fight_prepare_type == var_0_4.fight_type.war_concerto and self._is_war_concerto_enter then
			self._is_war_concerto_enter = nil

			var_0_3:set_current_team(self:get_current_team_index())
			var_0_3:req_ConcertoEnterMapReq(var_0_3:get_fifth_level_cfg().id, self._team_group_data[self:get_current_team_index()].id)
		elseif self._fight_prepare_type == var_0_4.fight_type.tower_fight then
			self._climb_tower_team_id = nil
		elseif self._fight_prepare_type == var_0_4.fight_type.strike and self._is_strike_enter_point then
			self._is_strike_enter_point = nil

			self:__enter_strike_map()
		elseif self._fight_prepare_type == var_0_4.fight_type.ocean_attack and self._is_ocean_attack_enter_point then
			local var_38_0 = var_0_3:get_current_ocean_map_start_point()

			var_0_3:req_OceanEnterMapReq(tonumber(string.sub(var_38_0, 1, 4)), var_38_0)

			self._is_ocean_attack_enter_point = nil
		elseif self._fight_prepare_type == var_0_4.fight_type.abyss_model_first_phase and self._is_abyss_enter_point then
			self._is_abyss_enter_point = nil

			local var_38_1 = var_0_2:createInstance("abyss_preview")

			if var_38_1 then
				self._abyss_now_page = var_38_1:get_now_page()

				local var_38_3 = var_0_3:get_abyss_now_chapter_cfg()

				self._abyss_prepare_to_fight_type = false

				local var_38_4 = var_0_3:get_abyss_now_chapter_cfg()

				var_0_3:set_abyss_fight_team_detail(self._team_detail_data)
			end
		elseif self._fight_prepare_type == var_0_4.fight_type.seventh and self._is_seventh_point then
			var_0_3:set_now_seven_map_id(self._seven_map_data.id)

			if not self.seventh_is_boss then
				if self._is_encounter then
					var_0_3:set_now_seven_map_fight_type(var_0_4.select_seventh_fight_type.encounter)
					var_0_3:req_SeventhEnterEliteReq(self._seven_map_data.id, self._seven_pos_num, self._current_team_index)
				else
					var_0_3:set_now_seven_map_fight_type(var_0_4.select_seventh_fight_type.exploration)
					var_0_3:req_SeventhEnterChaseReq(self._seven_map_data.id, self._seven_pos_num, self._current_team_index)
				end
			else
				var_0_3:set_now_seven_map_fight_type(var_0_4.select_seventh_fight_type.boss)
				var_0_3:req_SeventhEnterMapReq(self._seven_map_data.id, self._current_team_index)
			end
		elseif self._fight_prepare_type == var_0_4.fight_type.eighth_attack and self._is_eighth_point then
			var_0_3:set_now_eighth_map_id(self._eighth_map_data.id)

			if self._eighth_is_boss then
				var_0_3:set_now_eighth_map_fight_type(var_0_4.select_eighth_fight_type.boss)
				var_0_3:req_EighthEnterMapReq(self._eighth_map_data.id, self._current_team_index)
			else
				var_0_3:set_now_eighth_map_fight_type(var_0_4.select_eighth_fight_type.encounter)
				var_0_3:req_EighthEnterEliteReq(self._eighth_map_data.id, self._eighth_pos_num, self._current_team_index)

				return
			end
		end
	end

	function arg_1_0:team_supply(arg_39_1)
		self:__set_total_supply_panel_data()

		if #self._team_detail_data == 0 then
			var_0_35:show(var_0_1:getNowLang("nosupply"))

			return false
		end

		local var_39_0 = self._team_group_data[self._current_team_index]

		if not self._team_group_data[self._current_team_index] or not var_39_0.id then
			return
		end

		self._is_auto_supply = arg_39_1 or false

		if self._total_oil_need == 0 and self._total_bullet_need == 0 and self._total_aluminium_need == 0 then
			if not self._auto_supply then
				var_0_35:show(var_0_1:getNowLang("supplyfullnotice"))
			end

			if self._is_auto_supply then
				if self._go_to_map_id and self._go_to_map_id < var_0_4.normal_map_max_id and self._fight_prepare_type == var_0_4.fight_type.gotofight then
					var_0_3:req_EnterMapReq({
						id = self._go_to_map_id,
						team_id = var_39_0.id,
						start_point = self._init_node_id
					})
				elseif self._fight_prepare_type == var_0_4.fight_type.fearlessness_sea then
					var_0_3:req_PushEnterMapReq({
						id = self._go_to_map_id,
						team_id = var_39_0.id
					})
				elseif self._fight_prepare_type == var_0_4.fight_type.farfight then
					-- block empty
				elseif self._fight_prepare_type == var_0_4.fight_type.score_attack then
					var_0_3:req_AnswerEnterMapReq({
						id = self._go_to_map_id,
						team_id = var_39_0.id,
						start_point = self._init_node_id
					})
				elseif self._fight_prepare_type == var_0_4.fight_type.seventh then
					var_0_3:set_now_seven_map_id(self._seven_map_data.id)

					if not self.seventh_is_boss then
						if self._is_encounter then
							var_0_3:set_now_seven_map_fight_type(var_0_4.select_seventh_fight_type.encounter)
							var_0_3:req_SeventhEnterEliteReq(self._seven_map_data.id, self._seven_pos_num, self._current_team_index)
						else
							var_0_3:set_now_seven_map_fight_type(var_0_4.select_seventh_fight_type.exploration)
							var_0_3:req_SeventhEnterChaseReq(self._seven_map_data.id, self._seven_pos_num, self._current_team_index)
						end
					else
						var_0_3:set_now_seven_map_fight_type(var_0_4.select_seventh_fight_type.boss)
						var_0_3:req_SeventhEnterMapReq(self._seven_map_data.id, self._current_team_index)
					end
				elseif self._fight_prepare_type == var_0_4.fight_type.eighth_attack then
					var_0_3:set_now_eighth_map_id(self._eighth_map_data.id)

					if self._eighth_is_boss then
						var_0_3:set_now_eighth_map_fight_type(var_0_4.select_eighth_fight_type.boss)
						var_0_3:req_EighthEnterMapReq(self._eighth_map_data.id, self._current_team_index)
					else
						var_0_3:set_now_eighth_map_fight_type(var_0_4.select_eighth_fight_type.encounter)
						var_0_3:req_EighthEnterEliteReq(self._eighth_map_data.id, self._eighth_pos_num, self._current_team_index)

						return
					end
				elseif self._fight_prepare_type == var_0_4.fight_type.ninth_attack then
					var_0_3:req_NinthEnterMapReq({
						id = self._go_to_map_id,
						team_id = var_39_0.id,
						start_point = self._init_node_id
					})
				end

				self._is_auto_supply = false
			end

			return false
		end

		local var_39_2 = var_0_3:get_use_info_data()

		if self._total_oil_need > var_39_2.oil then
			var_0_35:show(var_0_1:getNowLang("oilnotenough"))

			return false
		end

		if self._total_bullet_need > var_39_2.bullet then
			var_0_35:show(var_0_1:getNowLang("ammonotenough"))

			return false
		end

		if self._total_aluminium_need > var_39_2.al then
			var_0_35:show(var_0_1:getNowLang("aluminumnotenough"))

			return false
		end

		if self._current_team_index then
			var_0_3:req_TeamSupply({
				id = self._current_team_index
			})
		end

		if self._config_data then
			local var_39_3 = var_0_3:get_supportInfo_data(self._go_to_map_id)

			if not not (var_39_3 and next(var_39_3)) then
				var_0_3:req_SupportSupplyReq(self._go_to_map_id)
			end
		end

		return true
	end

	function arg_1_0:__just_supply()
		local var_40_0 = self._total_oil_need > 0 or self._total_bullet_need > 0 or self._total_aluminium_need > 0

		if var_40_0 and self._current_team_index then
			var_0_3:req_TeamSupply({
				id = self._current_team_index
			})
		end

		return var_40_0
	end

	function arg_1_0:__need_supply()
		self._total_oil_need = 0
		self._total_bullet_need = 0
		self._total_aluminium_need = 0

		for iter_41_0, iter_41_1 in pairs(self._ship_item_list) do
			local var_41_1 = iter_41_1:get_supply_need()

			self._total_oil_need = self._total_oil_need + var_41_1.oil_need < 0 and 0 or self._total_oil_need + var_41_1.oil_need
			self._total_bullet_need = self._total_bullet_need + var_41_1.bullet_need < 0 and 0 or self._total_bullet_need + var_41_1.bullet_need
			self._total_aluminium_need = self._total_aluminium_need + var_41_1.aluminium_need < 0 and 0 or self._total_aluminium_need + var_41_1.aluminium_need
		end

		return (self._total_oil_need > 0 or self._total_bullet_need > 0 or self._total_aluminium_need > 0 or nil) and true
	end

	function arg_1_0:team_supply_refresh(arg_42_1)
		for iter_42_0, iter_42_1 in pairs(self._ship_item_list) do
			iter_42_1:refresh_supply()

			if arg_42_1 and next(arg_42_1.tactics) then
				for iter_42_2, iter_42_3 in pairs(arg_42_1.tactics) do
					local var_42_0 = iter_42_1:get_data()

					if var_42_0 and iter_42_3.id == var_42_0.id then
						iter_42_1:show_tactic(arg_42_1.tactics[iter_42_2])
					end
				end
			end
		end

		if self._fight_prepare_type == var_0_4.fight_type.exercise or self._fight_prepare_type == var_0_4.fight_type.captainroom_friend or self._fight_prepare_type == var_0_4.fight_type.show_room_friend then
			if not self._is_supply_all_btn then
				if self._fight_prepare_type == var_0_4.fight_type.exercise then
					var_0_3:req_EnterManeuverReq(self._exercise_id, self._team_group_data[self._current_team_index].id, false)
				elseif self._fight_prepare_type == var_0_4.fight_type.captainroom_friend then
					var_0_3:req_EnterManeuverReq(self._firend_account_id, self._team_group_data[self._current_team_index].id, true)
				elseif self._fight_prepare_type == var_0_4.fight_type.show_room_friend then
					var_0_3:req_EnterManeuverReq(self._firend_account_id, self._team_group_data[self._current_team_index].id, true)
				end
			end

			self._is_supply_all_btn = nil

			self:__set_total_supply_panel_data()

			return
		elseif self._fight_prepare_type == var_0_4.fight_type.farfight and self._is_farfight_auto_supply then
			self._is_farfight_auto_supply = nil

			if not self._farfight_condition.is_ok then
				var_0_35:show(self._farfight_condition.not_ok_info)

				return
			end

			local var_42_1 = {
				team_id = self._team_group_data[self._current_team_index].id,
				id = self._farfight_data.id
			}
			local var_42_2 = app:getSystem():getChannel()

			print("发送333")

			local var_42_3 = var_0_4:get_now_appversion_num()

			var_0_3:req_ExpeditionStartReq(var_42_1)
			log.print_r(var_42_2, "channel渠道名字")
			log.print_r(var_42_3, "version_num版本号数")

			if var_42_2 == "hm_android" and var_42_3 > var_0_4.version_init_num then
				NotifyManager.InitReceivedHandler()

				function NotifyManager.receivedCallback(arg_43_0)
					print("通知触发回调")
				end

				NotifyManager.CreateChannel(var_42_2, "cbt", 4, "推送", true, true)
				log.print_r(self._farfight_data.need_time, "需要时间3333")
				print("发送3333333")
				NotifyManager.CreateAndroidNotification("提督大人", string.format(var_0_1:getNowLang("expeditioncompleted"), self._team_group_data[self._current_team_index].id, self._farfight_data.title), self._farfight_data.need_time, true, "", "icon_1", "", self._team_group_data[self._current_team_index].id, var_42_2)
			end

			return
		end

		for iter_42_4, iter_42_5 in pairs(self._team_detail_data) do
			iter_42_5.data = var_0_5.little_clone((var_0_3:find_character_by_id(iter_42_5.data.id)))
		end

		self:__set_total_supply_panel_data()

		if self._is_auto_supply then
			if self._supply_type and not self._support_supply_full then
				return
			end

			if self._go_to_map_id and self._go_to_map_id < var_0_4.normal_map_max_id and self._fight_prepare_type == var_0_4.fight_type.gotofight then
				var_0_3:req_EnterMapReq({
					id = self._go_to_map_id,
					team_id = self._team_group_data[self._current_team_index].id,
					start_point = self._init_node_id
				})
			elseif self._fight_prepare_type == var_0_4.fight_type.fearlessness_sea then
				var_0_3:req_PushEnterMapReq({
					id = self._go_to_map_id,
					team_id = self._team_group_data[self._current_team_index].id
				})
			elseif self._fight_prepare_type == var_0_4.fight_type.farfight then
				local var_42_4 = app:getSystem():getChannel()
				local var_42_5 = var_0_4:get_now_appversion_num()

				var_0_3:req_ExpeditionStartReq({
					team_id = self._team_group_data[self._current_team_index].id,
					id = self._farfight_data.id
				})
				log.print_r(var_42_4, "channel渠道名字")
				log.print_r(var_42_5, "version_num版本号数")

				if var_42_4 == "hm_android" and var_42_5 > var_0_4.version_init_num then
					NotifyManager.InitReceivedHandler()

					function NotifyManager.receivedCallback(arg_44_0)
						print("通知触发回调")
					end

					NotifyManager.CreateChannel(var_42_4, "cbt", 4, "推送", true, true)
					log.print_r(self._farfight_data, "self._farfight_data")
					print("发送444444444")
					log.print_r(self._farfight_data.need_time, "需要时间444")
					NotifyManager.CreateAndroidNotification("提督大人", string.format(var_0_1:getNowLang("expeditioncompleted"), self._team_group_data[self._current_team_index].id, self._farfight_data.title), self._farfight_data.need_time, true, "", "icon_1", "", self._team_group_data[self._current_team_index].id, var_42_4)
				end
			elseif self._fight_prepare_type == var_0_4.fight_type.score_attack then
				var_0_3:req_AnswerEnterMapReq({
					id = self._go_to_map_id,
					team_id = self._team_group_data[self._current_team_index].id,
					start_point = self._init_node_id
				})
			elseif self._fight_prepare_type == var_0_4.fight_type.seventh then
				var_0_3:set_now_seven_map_id(self._seven_map_data.id)

				if not self.seventh_is_boss then
					if self._is_encounter then
						var_0_3:set_now_seven_map_fight_type(var_0_4.select_seventh_fight_type.encounter)
						var_0_3:req_SeventhEnterEliteReq(self._seven_map_data.id, self._seven_pos_num, self._current_team_index)
					else
						var_0_3:set_now_seven_map_fight_type(var_0_4.select_seventh_fight_type.exploration)
						var_0_3:req_SeventhEnterChaseReq(self._seven_map_data.id, self._seven_pos_num, self._current_team_index)
					end
				else
					var_0_3:set_now_seven_map_fight_type(var_0_4.select_seventh_fight_type.boss)
					var_0_3:req_SeventhEnterMapReq(self._seven_map_data.id, self._current_team_index)
				end
			elseif self._fight_prepare_type == var_0_4.fight_type.eighth_attack then
				var_0_3:set_now_eighth_map_id(self._eighth_map_data.id)

				if self._eighth_is_boss then
					var_0_3:set_now_eighth_map_fight_type(var_0_4.select_eighth_fight_type.boss)
					var_0_3:req_EighthEnterMapReq(self._eighth_map_data.id, self._current_team_index)
				else
					var_0_3:set_now_eighth_map_fight_type(var_0_4.select_eighth_fight_type.encounter)
					var_0_3:req_EighthEnterEliteReq(self._eighth_map_data.id, self._eighth_pos_num, self._current_team_index)

					return
				end
			elseif self._fight_prepare_type == var_0_4.fight_type.ninth_attack then
				var_0_3:req_NinthEnterMapReq({
					id = self._go_to_map_id,
					team_id = self._team_group_data[self._current_team_index].id,
					start_point = self._init_node_id
				})
			end

			self._is_auto_supply = false
		end
	end

	function arg_1_0:expedition_start_resp(arg_45_1)
		self:__play_out_animation(arg_45_1)
	end

	function arg_1_0.team_save_error(arg_46_0, arg_46_1)
		if arg_46_1 == 16 then
			var_0_35:show(var_0_1:getNowLang("errorcode_139"))
		elseif arg_46_1 == 146 then
			var_0_35:show(var_0_1:getNowLang("inguard"))
		else
			var_0_35:show(var_0_36:get_err_msg(arg_46_1))
		end
	end

	function arg_1_0:enter_map_resp()
		if self._fight_prepare_type == var_0_4.fight_type.ocean_attack then
			self._go_to_map_id = string.sub(var_0_3:get_current_ocean_map_start_point(), 1, 4)
		end

		local var_47_0 = var_0_5.little_clone(self._team_detail_data)

		var_0_3:set_now_node(self:get_input_map_node())
		var_0_3:set_now_team_data(var_47_0)
		var_0_2:destroyInstance("fight_prepare")
		var_0_2:createInstance("fight_info"):show({
			fight_type = self._fight_prepare_type,
			map_id = self._go_to_map_id,
			team_detail_data = var_47_0,
			start_node_id = var_0_3:get_battle_info().point,
			input_map_node_id = self:get_input_map_node()
		})
	end

	function arg_1_0:get_guide_btn_pos_info(arg_48_1)
		if arg_48_1 == var_0_4.guide_const_id.first_group.four or arg_48_1 == var_0_4.guide_const_id.nine_group.two then
			return self._control.bottom_widget.start_fight_btn.transform
		end
	end

	function arg_1_0:__init_panel(arg_49_1)
		self._detail_attr_table = {
			"hp",
			"atk",
			"def",
			"torpedo",
			"miss",
			"air_def",
			"capacity",
			nil,
			"antisub",
			"speed",
			"radar",
			"range",
			"luck",
			nil,
			nil,
			"crit",
			"hit",
			nil,
			"ext"
		}
		self.is_already_init = true
		self.__strike_is_deal = arg_49_1.strike_is_deal
		self._fight_prepare_type = arg_49_1.fight_prepare_type
		self._campaign = arg_49_1.campaign
		self._hard_open = arg_49_1.hard_open

		local var_49_0 = ""
		local var_49_1 = ""
		local var_49_2 = ""
		local var_49_3 = ""
		local var_49_4 = ""

		self._is_nf = var_0_3:get_select_into_nf()

		var_0_3:set_come_in_panel_style(1)

		local var_49_5 = false

		self._gotofight_memory_team_index = var_0_3:get_gotofight_memory_team_index()

		self._control.bottom_widget.bottom_line:SetActive(true)

		self._control.left_widget.func_toggle.toggle4.rectTransform.anchoredPosition = var_0_15(586.6, 5.1)

		if self._fight_prepare_type == var_0_4.fight_type.gotofight then
			self:show_test_input_map_node()

			self._go_to_map_id = arg_49_1.go_to_map_id
			self._init_node_id = var_0_7.find_object_by_id(arg_49_1.go_to_map_id).init_node_id
			self._support_id = arg_49_1.support_id
			self._team_type = var_0_4.team_type.normal
			self._init_chapter_index = arg_49_1.init_chapter_index
			self._init_map_index = arg_49_1.init_map_index
			var_49_0 = var_0_1:getNowLang("pvebattleprepare")
			var_49_1 = var_0_1:getNowLang("pvepreparetotalprops")
			var_49_2 = var_0_1:getNowLang("startpve")
			self._current_content_type = var_0_4.fight_prepare_right_panel_type.props

			if not var_0_3:get_eighth_team() then
				self._current_team_index = var_0_3:get_cur_click_team_index()
			else
				self._team_group_data = {}

				self:__onToggle_left_widget_team_toggle_toggle1()

				self._current_team_index = 1

				var_0_3:set_cur_click_team_index(self._current_team_index)
				var_0_3:set_eighth_team()
			end

			self._control.parent.pre_formation_bg.image.sprite = self:loadSprite(var_0_4.pre_formation_bg)

			self._control.parent.pre_formation_bg:SetActive(true)
			var_0_3:clear_cur_butter_list()
		elseif self._fight_prepare_type == var_0_4.fight_type.farfight then
			self._farfight_data = arg_49_1.farfight_data
			self._team_type = var_0_4.team_type.expedition
			var_49_0 = var_0_1:getNowLang("pveexplorepreparetitle")
			var_49_1 = var_0_1:getNowLang("pveexplorerequitetitle")
			var_49_2 = var_0_1:getNowLang("startexplore")
			self._current_content_type = var_0_4.fight_prepare_right_panel_type.condition
			self._control.parent.pre_formation_bg.image.sprite = self:loadSprite(var_0_4.pre_formation_bg)

			self._control.parent.pre_formation_bg:SetActive(true)

			self._current_team_index = 5
		elseif self._fight_prepare_type == var_0_4.fight_type.campaign then
			self._go_to_map_id = arg_49_1.go_to_map_id
			self._team_type = var_0_4.team_type.campaign
			var_49_0 = var_0_1:getNowLang("pvebattleprepare")
			var_49_1 = var_0_1:getNowLang("pvepreparetotalprops")
			var_49_2 = var_0_1:getNowLang("startpve")
			self._campagion_data = arg_49_1.config_data
			self._difficulty = arg_49_1.difficulty
			self._current_content_type = var_0_4.fight_prepare_right_panel_type.props
		elseif self._fight_prepare_type == var_0_4.fight_type.captainroom_friend or self._fight_prepare_type == var_0_4.fight_type.show_room_friend or self._fight_prepare_type == var_0_4.fight_type.tower_rank_list or self._fight_prepare_type == var_0_4.fight_type.tower_rank_friend_captainroom then
			var_49_0 = var_0_1:getNowLang("pvebattleprepare")
			var_49_1 = var_0_1:getNowLang("pvepreparetotalprops")
			var_49_2 = var_0_1:getNowLang("startpve")
			self._team_type = var_0_4.team_type.normal
			self._current_content_type = var_0_4.fight_prepare_right_panel_type.props
			self._firend_account_id = arg_49_1.firend_account_id
			self._control.parent.pre_formation_bg.image.sprite = self:loadSprite(var_0_4.pre_formation_bg)

			self._control.parent.pre_formation_bg:SetActive(true)

			var_49_5 = true
		elseif self._fight_prepare_type == var_0_4.fight_type.exercise then
			self._team_type = var_0_4.team_type.normal
			var_49_0 = var_0_1:getNowLang("pvebattleprepare")
			var_49_1 = var_0_1:getNowLang("pvepreparetotalprops")
			var_49_2 = var_0_1:getNowLang("startpve")
			self._current_content_type = var_0_4.fight_prepare_right_panel_type.props
			self._control.parent.pre_formation_bg.image.sprite = self:loadSprite(var_0_4.pre_formation_bg)
			self._exercise_id = arg_49_1.exercise_id
			self._current_team_index = var_0_3:get_cur_click_team_index()
		elseif self._fight_prepare_type == var_0_4.fight_type.sixth_fight then
			self._team_type = var_0_4.team_type.sixth_team
			self._sixth_map = arg_49_1.sixth_map
			self._is_return_sixth_map_node = true
			self._six_map_node_bg = arg_49_1.bg_pos
			self._current_content_type = var_0_4.fight_prepare_right_panel_type.sixth
			var_49_0 = var_0_1:getNowLang("pvebattleprepare")
			var_49_1 = var_0_1:getNowLang("pvepreparetotalprops")
			var_49_2 = var_0_1:getNowLang("startpve")
			var_49_3 = var_0_1:getNowLang("sixth_fight_title")
			var_49_4 = var_0_1:getNowLang("ui_4th_prepare_buff")

			if not self._reusable_cell then
				self._reusable_cell = gamecore.reusable_cell:create(self, self._control.right_widget.bg_back.sixth_panel.all_ship.Viewport.edge_mask.Content.endlessScrollView, self._control.right_widget.bg_back.sixth_panel.all_ship.Viewport.edge_mask.Content, "sixth_buff_cell", "fight_prepare", true)

				self._reusable_cell:init()
			end

			self._no_clicking = true

			self:__update_reusable_cell()
		elseif self._fight_prepare_type == var_0_4.fight_type.mist_attack then
			self._team_type = var_0_4.team_type.mist_team
			self._mist_map = arg_49_1.mist_map
			self._is_return_mist_map_node = true
			self._mist_map_node_bg = arg_49_1.bg_pos
			self._current_content_type = var_0_4.fight_prepare_right_panel_type.sixth
			var_49_0 = var_0_1:getNowLang("pvebattleprepare")
			var_49_1 = var_0_1:getNowLang("pvepreparetotalprops")
			var_49_2 = var_0_1:getNowLang("startpve")
			var_49_3 = var_0_1:getNowLang("sixth_fight_title")
			var_49_4 = var_0_1:getNowLang("ui_4th_prepare_buff")
			self._control.left_widget.func_toggle.toggle2.toggle.interactable = false
			self._control.left_widget.func_toggle.toggle3.toggle.interactable = false
			self._control.left_widget.func_toggle.toggle4.toggle.interactable = false

			if self._is_nf then
				self._control.auto_supply_btn:SetActive(false)
			end

			if not self._reusable_cell then
				self._reusable_cell = gamecore.reusable_cell:create(self, self._control.right_widget.bg_back.sixth_panel.all_ship.Viewport.edge_mask.Content.endlessScrollView, self._control.right_widget.bg_back.sixth_panel.all_ship.Viewport.edge_mask.Content, "sixth_buff_cell", "fight_prepare", true)

				self._reusable_cell:init()
			end

			self:__update_mist_reusable_cell()
		elseif self._fight_prepare_type == var_0_4.fight_type.fearlessness_sea then
			self:show_test_input_map_node()

			self._go_to_map_id = arg_49_1.go_to_map_id
			self._init_node_id = var_0_8.find_object_by_id(arg_49_1.go_to_map_id).init_node_id
			self._support_id = arg_49_1.support_id
			self._team_type = var_0_4.team_type.normal
			self._init_chapter_index = arg_49_1.init_chapter_index
			self._init_map_index = arg_49_1.init_map_index
			self._control.parent.pre_formation_bg.image.sprite = self:loadSprite(var_0_4.pre_formation_bg)

			self._control.parent.pre_formation_bg:SetActive(true)

			var_49_0 = var_0_1:getNowLang("pvebattleprepare")
			var_49_1 = var_0_1:getNowLang("pvepreparetotalprops")
			var_49_2 = var_0_1:getNowLang("startpve")
			self._current_content_type = var_0_4.fight_prepare_right_panel_type.props
			self._current_team_index = var_0_3:get_cur_click_team_index()

			var_0_3:clear_cur_butter_list()
		elseif self._fight_prepare_type == var_0_4.fight_type.tower_fight then
			self._tower_monster = arg_49_1.tower_monster
			self._now_layer = arg_49_1.now_layer
			self._team_type = var_0_4.team_type.normal
			self._now_layer_map_cfg = arg_49_1.now_layer_map_cfg
			self._card_index = arg_49_1.card_index
			self._control.parent.pre_formation_bg.image.sprite = self:loadSprite(var_0_4.pre_formation_bg)

			self._control.parent.pre_formation_bg:SetActive(true)

			self._current_team_index = var_0_3:get_cur_click_team_index()
			var_49_0 = var_0_1:getNowLang("pvebattleprepare")
			var_49_1 = var_0_1:getNowLang("pvepreparetotalprops")
			var_49_2 = var_0_1:getNowLang("startpve")
			self._current_content_type = var_0_4.fight_prepare_right_panel_type.tower

			self:__update_tower_reusable_cell()
			self:__set_enemy_info_des()

			var_49_4 = var_0_1:getNowLang("ui_4th_prepare_buff")

			self:__change_right_bg(2)
		elseif self._fight_prepare_type == var_0_4.fight_type.ocean_attack then
			self:show_test_input_map_node()

			self._go_to_map_id = arg_49_1.go_to_map_id

			local var_49_6 = var_0_38.find_object_by_id(arg_49_1.go_to_map_id)

			self._team_type = var_0_4.team_type.ocean_attack_team
			var_49_3 = var_0_1:getNowLang("ui_4th_prepare_title")
			var_49_0 = var_0_1:getNowLang("pvebattleprepare")
			var_49_1 = var_0_1:getNowLang("ui_4th_prepare_buff")
			var_49_2 = var_0_1:getNowLang("startpve")
			self._control.parent.pre_formation_bg.image.sprite = self:loadSprite(var_0_4.pre_formation_bg)

			self._control.parent.pre_formation_bg:SetActive(true)

			self._current_content_type = var_0_4.fight_prepare_right_panel_type.ocean_attack
			self._ocean_reusable_cell = gamecore.reusable_cell:create(self, self._control.right_widget.bg_back.ocean_panel.all_buff.Viewport.edge_mask.Content.endlessScrollView, self._control.right_widget.bg_back.ocean_panel.all_buff.Viewport.edge_mask.Content, "ocean_buff_cell", "fight_prepare", true)

			self._ocean_reusable_cell:init()
			self:__update_ocean_map_reusable_cell(arg_49_1.go_to_map_id)
		elseif self._fight_prepare_type == var_0_4.fight_type.strike then
			self._team_type = var_0_4.team_type.strike_map_team
			self._go_to_map_id = arg_49_1.go_to_map_id
			self._current_content_type = var_0_4.fight_prepare_right_panel_type.strike
			var_49_3 = var_0_1:getNowLang("strongattackfleet")
			var_49_0 = var_0_1:getNowLang("pvebattleprepare")
			var_49_1 = var_0_1:getNowLang("pvepreparetotalprops")
			var_49_2 = var_0_1:getNowLang("startpve")
			var_49_4 = var_0_1:getNowLang("currentsituation")
			self._control.parent.pre_formation_bg.image.sprite = self:loadSprite(var_0_4.pre_formation_bg)

			self._control.parent.pre_formation_bg:SetActive(true)
			self:__update_strike_buffs()

			local var_49_7 = var_0_3:get_strike_point_info()

			if var_49_7 and next(var_49_7) then
				if var_49_7.point_id and var_49_7.point_id ~= 0 then
					self._control.left_widget.func_toggle.line3.gameObject:SetActive(false)
					self._control.left_widget.func_toggle.toggle3.gameObject:SetActive(false)

					self._control.left_widget.func_toggle.toggle4.rectTransform.anchoredPosition = var_0_15(self._control.left_widget.func_toggle.toggle3.rectTransform.anchoredPosition.x, self._control.left_widget.func_toggle.toggle3.rectTransform.anchoredPosition.y)
				end
			end

			local var_49_8 = 0

			if self._current_strike_buffs and next(self._current_strike_buffs) then
				for iter_49_0, iter_49_1 in pairs(self._current_strike_buffs) do
					var_49_8 = var_49_8 + iter_49_1.score
				end
			end

			self._control.right_widget.bg_back.strike_info.point.point_num.text.text = var_49_8

			if not self._strike_reusable_cell then
				self._strike_reusable_cell = gamecore.reusable_cell:create(self, self._control.right_widget.bg_back.strike_info.buffs.Viewport.edge_mask.content.endlessScrollView, self._control.right_widget.bg_back.strike_info.buffs.Viewport.edge_mask.content, "single_strike_buff_item", "fight_prepare", true)

				self._strike_reusable_cell:init()
			end

			self:__update_strike_reusable_cell()
			self:refresh_strike_info_list()
			var_0_3:set_come_in_panel_style(12)
		elseif self._fight_prepare_type == var_0_4.fight_type.war_concerto then
			self._team_type = var_0_4.team_type.normal
			var_49_0 = var_0_1:getNowLang("pvebattleprepare")
			var_49_1 = var_0_1:getNowLang("pvepreparetotalprops")
			var_49_2 = var_0_1:getNowLang("startpve")
			self._control.parent.pre_formation_bg.image.sprite = self:loadSprite(var_0_4.pre_formation_bg)

			self._control.parent.pre_formation_bg:SetActive(true)

			self._go_to_map_id = arg_49_1.go_to_map_id
			self._current_content_type = var_0_4.fight_prepare_right_panel_type.props
			self._current_team_index = var_0_3:get_cur_click_team_index()
		elseif self._fight_prepare_type == var_0_4.fight_type.war_concerto_play then
			self._team_type = var_0_4.team_type.war_concerto_play_team
			self._go_to_map_id = arg_49_1.go_to_map_id
			var_49_0 = var_0_1:getNowLang("pvebattleprepare")
			var_49_1 = var_0_1:getNowLang("pvepreparetotalprops")
			var_49_2 = var_0_1:getNowLang("ui_5th_prepare_start")
			var_49_3 = var_0_1:getNowLang("ui_5th_prepare_title")
			self._current_content_type = var_0_4.fight_prepare_right_panel_type.war_concerto_play
		elseif self._fight_prepare_type == var_0_4.fight_type.abyss_model_first_phase then
			self._go_to_map_id = arg_49_1.go_to_map_id
			self._abyss_prepare_point = arg_49_1.abyss_prepare_point
			var_49_0 = var_0_1:getNowLang("pvebattleprepare")
			var_49_2 = var_0_1:getNowLang("startpve")
			var_49_1 = var_0_1:getNowLang("pvepreparetotalprops")
			self._control.parent.pre_formation_bg.image.sprite = self:loadSprite(var_0_4.pre_formation_bg)

			self._control.right_widget.bg_back.abyss_panel.power_tog:SetActive(true)
			self._control.right_widget.bg_back.abyss_panel.power_tog.bg:SetActive(false)
			self._control.right_widget.bg_back.abyss_panel.buff_tog:SetActive(false)
			self._control.bottom_widget.bottom_line:SetActive(false)

			self._control.left_widget.abyss_btn.owner_team_tog.title.text.text = var_0_1:getNowLang("ui_ny21_fleet_title_1")
			self._control.left_widget.abyss_btn.deep_sea_team_tog.title.text.text = var_0_1:getNowLang("ui_ny21_fleet_title_2")
			self._control.right_widget.bg_back.abyss_panel.power_tog.title.text.text = var_0_1:getNowLang("pvepreparetotalprops")
			self._current_content_type = var_0_4.fight_prepare_right_panel_type.abyss_model
			self._team_type = var_0_4.team_type.abyss_owner_team
		elseif self._fight_prepare_type == var_0_4.fight_type.seventh then
			self:show_test_input_map_node()

			self._go_to_map_id = arg_49_1.go_to_map_id
			self.seventh_is_boss = arg_49_1.is_boss
			self._is_encounter = arg_49_1.is_encounter
			self._team_type = var_0_4.team_type.normal
			self._seven_map_data = arg_49_1.map_data
			self._seven_pos_num = arg_49_1.pos_num
			var_49_0 = var_0_1:getNowLang("pvebattleprepare")
			var_49_1 = var_0_1:getNowLang("pvepreparetotalprops")
			var_49_2 = var_0_1:getNowLang("startpve")
			self._current_content_type = var_0_4.fight_prepare_right_panel_type.props
			self._current_team_index = var_0_3:get_cur_click_team_index()
			self._control.parent.pre_formation_bg.image.sprite = self:loadSprite(var_0_4.pre_formation_bg)

			self._control.parent.pre_formation_bg:SetActive(true)
		elseif self._fight_prepare_type == var_0_4.fight_type.score_attack then
			self:show_test_input_map_node()

			self._init_node_id, self._go_to_map_id = var_0_3:get_current_score_map_start_point(), arg_49_1.go_to_map_id
			self._support_id = arg_49_1.support_id
			self._team_type = var_0_4.team_type.normal
			self._init_chapter_index = arg_49_1.init_chapter_index
			self._init_map_index = arg_49_1.init_map_index
			var_49_0 = var_0_1:getNowLang("pvebattleprepare")
			var_49_1 = var_0_1:getNowLang("pvepreparetotalprops")
			var_49_2 = var_0_1:getNowLang("startpve")
			self._current_content_type = var_0_4.fight_prepare_right_panel_type.props
			self._current_team_index = var_0_3:get_cur_click_team_index()
			self._control.parent.pre_formation_bg.image.sprite = self:loadSprite(var_0_4.pre_formation_bg)

			self._control.parent.pre_formation_bg:SetActive(true)
			var_0_3:clear_cur_butter_list()
		elseif self._fight_prepare_type == var_0_4.fight_type.eighth_attack then
			self._team_group_data = lx.clone_table(var_0_3:get_team_all_data())[1]

			if not var_0_3:get_eighth_team() then
				self:__onToggle_left_widget_team_toggle_toggle1()

				self._current_team_index = 1

				var_0_3:set_cur_click_team_index(self._current_team_index)
			else
				self._current_team_index = var_0_3:get_cur_click_team_index()

				var_0_3:set_eighth_team(self._current_team_index)
			end

			self:show_test_input_map_node()

			self._go_to_map_id = arg_49_1.go_to_map_id
			self._eighth_map_data = arg_49_1.map_data
			self._eighth_pos_num = arg_49_1.elite_id
			self._is_encounter = arg_49_1.is_encounter
			self._eighth_is_boss = arg_49_1.is_boss
			self._team_type = var_0_4.team_type.normal
			var_49_0 = var_0_1:getNowLang("pvebattleprepare")
			var_49_1 = var_0_1:getNowLang("pvepreparetotalprops")
			var_49_2 = var_0_1:getNowLang("startpve")
			self._current_content_type = var_0_4.fight_prepare_right_panel_type.props
			self._control.parent.pre_formation_bg.image.sprite = self:loadSprite(var_0_4.pre_formation_bg)

			self._control.parent.pre_formation_bg:SetActive(true)
		elseif self._fight_prepare_type == var_0_4.fight_type.ninth_attack then
			self:show_test_input_map_node()

			self._init_node_id, self._go_to_map_id = var_0_3:get_ninth_map_start_point(), arg_49_1.go_to_map_id
			self._support_id = arg_49_1.support_id
			self._team_type = var_0_4.team_type.normal
			self._init_chapter_index = arg_49_1.init_chapter_index
			self._init_map_index = arg_49_1.init_map_index
			var_49_0 = var_0_1:getNowLang("pvebattleprepare")
			var_49_1 = var_0_1:getNowLang("pvepreparetotalprops")
			var_49_2 = var_0_1:getNowLang("startpve")
			self._current_content_type = var_0_4.fight_prepare_right_panel_type.props
			self._current_team_index = var_0_3:get_cur_click_team_index()
			self._control.parent.pre_formation_bg.image.sprite = self:loadSprite(var_0_4.pre_formation_bg)

			self._control.parent.pre_formation_bg:SetActive(true)

			if not self._reusable_cell then
				self._reusable_cell = gamecore.reusable_cell:create(self, self._control.right_widget.bg_back.ninth_info.ninth_buffs.ninth_Viewport.ninth_edge_mask.ninth_content.endlessScrollView, self._control.right_widget.bg_back.ninth_info.ninth_buffs.ninth_Viewport.ninth_edge_mask.ninth_content, "ninth_buff_cell", "fight_prepare", true)

				self._reusable_cell:init()
			end

			self:__update_ninth_active_reusable_cell()
			var_0_3:clear_cur_butter_list()
		end

		self._control.right_widget.bg_back.sixth_panel.buff_text.text.text = var_49_4
		self._control.left_widget.sixth_title.team_name.text.text = var_49_3

		if self._is_nf then
			self._control.left_widget.sixth_title.team_name.text.text = var_0_1:getNowLang("mist_team")
		end

		self._control.top_widget.top_title_text.text.text = var_49_0
		self._control.left_widget.func_toggle.toggle1.bg.title.text.text = var_49_1
		self._control.left_widget.func_toggle.toggle2.bg.title.text.text = var_0_1:getNowLang("pvepreparesupply")
		self._control.left_widget.func_toggle.toggle3.bg.title.text.text = var_0_1:getNowLang("pvepreparerepair")
		self._control.left_widget.func_toggle.toggle4.bg.title.text.text = var_0_1:getNowLang("equipment_preview")

		local var_49_9

		if var_49_5 then
			var_49_9 = self._current_team_index or 1

			if self._fight_prepare_type == var_0_4.fight_type.gotofight or self._fight_prepare_type == var_0_4.fight_type.exercise or self._fight_prepare_type == var_0_4.fight_type.captainroom_friend or self._fight_prepare_type == var_0_4.fight_type.show_room_friend or self._fight_prepare_type == var_0_4.fight_type.fearlessness_sea or self._fight_prepare_type == var_0_4.fight_type.seventh or self._fight_prepare_type == var_0_4.fight_type.tower_fight or self._fight_prepare_type == var_0_4.fight_type.score_attack or self._fight_prepare_type == var_0_4.fight_type.ninth_attack then
				var_49_9 = self._gotofight_memory_team_index
			elseif self._fight_prepare_type == var_0_4.fight_type.farfight then
				var_49_9 = 1
			elseif self._fight_prepare_type == var_0_4.fight_type.fearlessness_sea then
				var_49_9 = self._current_team_index or 1
			elseif self._fight_prepare_type == var_0_4.fight_type.ninth_attack then
				var_49_9 = self._current_team_index or 1
			elseif self._fight_prepare_type == var_0_4.fight_type.eighth_attack then
				if self._current_team_index > 4 then
					self._current_team_index = 1
				end

				var_49_9 = self._current_team_index or 1
			end
		end

		for iter_49_2 = 1, 4 do
			if iter_49_2 == var_49_9 then
				self._control.left_widget.team_toggle[var_0_12("toggle%s", var_49_9)].bg.title.text.color = var_0_16.New(1, 1, 1, 1)
				self._control.left_widget.team_toggle[var_0_12("toggle%s", var_49_9)].bg.title.text.fontSize = 30
				self._control.left_widget.team_toggle[var_0_12("toggle%s", iter_49_2)].toggle.isOn = true
			else
				self._control.left_widget.team_toggle[var_0_12("toggle%s", iter_49_2)].bg.title.text.color = var_0_16.New(1, 1, 1, 0.5019607843137255)
				self._control.left_widget.team_toggle[var_0_12("toggle%s", iter_49_2)].bg.title.text.fontSize = 28
				self._control.left_widget.team_toggle[var_0_12("toggle%s", iter_49_2)].toggle.isOn = false
			end
		end

		self._control.auto_supply_btn.toggle_text.text.text = var_0_1:getNowLang("auto_supply")
		self._control.bottom_widget.start_fight_btn.text.text.text = var_49_2
		self._control.right_widget.damage_group_bg.title.text.text = var_0_1:getNowLang("damagecontrol")
		self._team_detail_data = {}

		self:update_damage_control_count()
		self:update_supply_control_info()

		self._auto_supply = var_0_3:get_use_auto_supply()

		self:__onupdate_auto_toggle(self._auto_supply)
		self:__init_language()
		self:__set_panel_info()
		self:__update_support_active_info()
		self:__init_content()
	end

	function arg_1_0:update_auto_supply_toggle()
		self._auto_supply = var_0_3:get_use_auto_supply()

		self:__onupdate_auto_toggle(self._auto_supply)
	end

	function arg_1_0:__init_language()
		self._control.right_widget.bg_back.repair_panel.title.text.text = var_0_1:getNowLang("ui_shiptip1")
		self._control.right_widget.bg_back.repair_panel.repair1.title.text.text = var_0_1:getNowLang("item2")
		self._control.right_widget.bg_back.repair_panel.repair2.title.text.text = var_0_1:getNowLang("item4")
		self._control.right_widget.bg_back.repair_panel.repair_all_btn.text.text.text = var_0_1:getNowLang("pvefastrepairall")
		self._control.repair_btn.repair_txt.text.text = var_0_1:getNowLang("repairship")
	end

	function arg_1_0:__init_content()
		self._control.right_widget.bg_back.sixth_panel:SetActive(false)
		self._control.right_widget.bg_back.speed_skeleton_mask:SetActive(true)
		self._control.left_widget.sixth_title:SetActive(false)
		self._control.buff_btn:SetActive(false)
		self._control.left_widget.tower_cost:SetActive(false)
		self._control.left_widget.nf_info:SetActive(false)
		self._control.left_widget.func_toggle:SetActive(true)
		self._control.right_widget.damage_group_bg:SetActive(true)

		self._team_data = {}

		if not self._campaign and self._fight_prepare_type ~= var_0_4.fight_type.sixth_fight and self._current_content_type ~= var_0_4.fight_prepare_right_panel_type.strike and self._current_content_type ~= var_0_4.fight_prepare_right_panel_type.ocean_attack and self._current_content_type ~= var_0_4.fight_prepare_right_panel_type.score_attack and self._current_content_type ~= var_0_4.fight_prepare_right_panel_type.abyss_model and self._current_content_type ~= var_0_4.fight_prepare_right_panel_type.war_concerto_play and self._fight_prepare_type ~= var_0_4.fight_type.mist_attack then
			self:__init_prepare_item_list(self._current_content_type)

			if self._fight_prepare_type == var_0_4.fight_type.captainroom_friend or self._fight_prepare_type == var_0_4.fight_type.tower_rank_list then
				self._control.repair_btn:SetActive(false)
			else
				self._control.repair_btn:SetActive(true)
			end

			self._control.left_widget.team_toggle:SetActive(true)
			self._control.parent.collect_icon_bg:SetActive(true)
			self._control.parent.pre_formation_bg:SetActive(true)
		end

		if self._current_content_type == var_0_4.fight_prepare_right_panel_type.props and not self._campaign then
			if self._fight_prepare_type == var_0_4.fight_type.ninth_attack then
				self:__init_total_props_panel()
				self:__set_total_props_panel_data()
				self:__show_props_panel()
				self:__show_ninth_panel()
			else
				self:__init_total_props_panel()
				self:__set_total_props_panel_data()
				self:__show_props_panel()
			end
		elseif self._current_content_type == var_0_4.fight_prepare_right_panel_type.condition then
			self:__set_condition_panel_data()
			self:__show_condition_panel()
		elseif self._current_content_type == var_0_4.fight_prepare_right_panel_type.props and self._campaign then
			self._control.right_widget.bg_back.speed_skeleton_mask:SetActive(false)
			self:__set_campaign_panel_data()
			self:__show_campaign_panel()
			self:__init_campaign_prepare(self._current_content_type)
			self._control.left_widget.team_toggle:SetActive(false)
			self._control.parent.collect_icon_bg:SetActive(false)
			self._control.parent.pre_formation_bg:SetActive(false)
			self._control.repair_btn:SetActive(true)
		elseif self._current_content_type == var_0_4.fight_prepare_right_panel_type.sixth then
			self:__show_sixth_panel()
			self._control.parent.collect_icon_bg:SetActive(true)

			if self._fight_prepare_type == var_0_4.fight_type.mist_attack then
				self._control.left_widget.nf_info:SetActive(true)
				self:__init_mist_prepare(self._current_content_type)
				self._control.parent.collect_icon_bg:SetActive(false)
				self._control.right_widget.damage_group_bg:SetActive(false)
				self._control.left_widget.func_toggle:SetActive(false)
				self._control.repair_btn:SetActive(false)
				self:__set_mist_ship_info()
			else
				self:__init_sixth_prepare(self._current_content_type)
				self._control.repair_btn:SetActive(true)
			end

			self._control.left_widget.team_toggle:SetActive(false)
			self._control.parent.pre_formation_bg:SetActive(false)
			self._control.right_widget.bg_back.sixth_panel:SetActive(true)
			self._control.left_widget.sixth_title:SetActive(true)
		elseif self._current_content_type == var_0_4.fight_prepare_right_panel_type.tower then
			self._control.repair_btn:SetActive(false)
			self._control.buff_btn:SetActive(true)

			self._control.buff_btn.repair_txt.text.text = var_0_1:getNowLang("ui_tower_prepare_buff_shop")

			self._control.left_widget.tower_cost:SetActive(true)
			self:__update_tower_cost()
			self:__show_tower_fight_panel()
		elseif self._current_content_type == var_0_4.fight_prepare_right_panel_type.ocean_attack then
			self:__init_ocean_attack_prepare(self._current_content_type)
			self._control.left_widget.team_toggle:SetActive(false)
			self._control.parent.collect_icon_bg:SetActive(true)
			self._control.parent.pre_formation_bg:SetActive(true)
			self._control.repair_btn:SetActive(false)
			self._control.right_widget.bg_back.ocean_panel:SetActive(true)
			self._control.left_widget.sixth_title:SetActive(true)
			self:__show_ocean_panel()
		elseif self._current_content_type == var_0_4.fight_prepare_right_panel_type.score_attack then
			self:__init_ocean_attack_prepare(self._current_content_type)
			self._control.left_widget.team_toggle:SetActive(false)
			self._control.parent.collect_icon_bg:SetActive(true)
			self._control.parent.pre_formation_bg:SetActive(true)
			self._control.repair_btn:SetActive(false)
			self._control.right_widget.bg_back.ocean_panel:SetActive(true)
			self._control.left_widget.sixth_title:SetActive(true)
			self:__show_score_panel()
		elseif self._current_content_type == var_0_4.fight_prepare_right_panel_type.strike then
			self:__init_strike_prepare(self._current_content_type)
			self._control.left_widget.team_toggle:SetActive(false)
			self._control.parent.collect_icon_bg:SetActive(true)
			self._control.parent.pre_formation_bg:SetActive(true)
			self._control.repair_btn:SetActive(var_0_3:get_strike_first_get_in())
			self._control.left_widget.sixth_title:SetActive(true)
			self:__init_total_props_panel()
			self:__show_strike_panel()
		elseif self._current_content_type == var_0_4.fight_prepare_right_panel_type.war_concerto_play then
			self:__init_war_concerto_play_prepare(self._current_content_type)
			self._control.left_widget.team_toggle:SetActive(false)
			self._control.parent.collect_icon_bg:SetActive(false)
			self._control.parent.pre_formation_bg:SetActive(false)
			self._control.left_widget.func_toggle:SetActive(false)
			self._control.right_widget.damage_group_bg:SetActive(false)
			self._control.left_widget.sixth_title:SetActive(true)
			self._control.repair_btn:SetActive(false)
			self:__init_total_props_panel()
			self:__set_total_props_panel_data()
			self:__show_props_panel()
		elseif self._current_content_type == var_0_4.fight_prepare_right_panel_type.abyss_model then
			self._abyss_prepare_point = self._abyss_prepare_point or false

			self:__set_bottom_info_state(var_0_4.team_type.abyss_owner_team)
			self:__set_buff_display_state(self._abyss_prepare_point)
			self:__show_abyss_team_buff_ilist()
			self:__init_abyss_model_team_list(self._current_content_type, var_0_4.team_type.abyss_owner_team)
			self._control.left_widget.team_toggle:SetActive(false)
			self._control.left_widget.abyss_btn:SetActive(true)
			self:__show_props_panel()
			self:__set_total_props_panel_data()
		end

		if not self._fight_prepare_type == var_0_4.fight_type.mist_attack then
			self:__set_total_supply_panel_data()
			self:__set_total_repair_panel_data()
		end

		self:__play_in_animation()
	end

	function arg_1_0:__the_rest_of_the_cost()
		return self:__add_slot_cost() + self._now_layer_map_cfg.cost - var_0_3:get_tower_data_by_level(self._now_layer_map_cfg.level).cost
	end

	function arg_1_0:__set_mist_ship_info()
		local var_54_0 = var_0_3:get_mist_combat_info().members
		local var_54_1 = 0
		local var_54_2 = 0
		local var_54_3 = 0
		local var_54_4 = 0
		local var_54_5 = 0
		local var_54_6 = 0
		local var_54_7 = 0
		local var_54_8 = {}

		if #var_54_0 > 0 then
			for iter_54_0, iter_54_1 in pairs(var_54_0) do
				local var_54_9 = gameconfig.pve_mist_ship_config.find_object_by_id(iter_54_1)

				var_0_14(var_54_8, var_54_9)

				if var_54_9.shiptype == 6 then
					var_54_3 = var_54_3 + var_54_9.gunpower
					var_54_4 = var_54_4 + var_54_9.torpedopower
					var_54_7 = var_54_7 + var_54_9.antiair
				end

				var_54_1 = var_54_1 + var_54_9.gunpower
				var_54_2 = var_54_2 + var_54_9.torpedopower
				var_54_5 = var_54_5 + var_54_9.antiair
				var_54_6 = var_54_6 + var_54_9.scouting
			end
		end

		self._control.left_widget.nf_info.fire_info.fire_num.text.text = var_54_1 - var_54_3
		self._control.left_widget.nf_info.torpedo_info.fire_num.text.text = var_54_2 - var_54_4
		self._control.left_widget.nf_info.crit_info.fire_num.text.text = var_54_3
		self._control.left_widget.nf_info.atk_info.fire_num.text.text = var_54_4
		self._control.left_widget.nf_info.air_info.fire_num.text.text = var_54_5
		self._control.left_widget.nf_info.spotting_info.fire_num.text.text = var_54_6
		self._control.left_widget.nf_info.counterair_info.fire_num.text.text = var_54_7
		self._control.left_widget.nf_info.fire_info.fire.text.text = var_0_1:get("炮击")
		self._control.left_widget.nf_info.torpedo_info.torp.text.text = var_0_1:get("雷击")
		self._control.left_widget.nf_info.crit_info.crit.text.text = var_0_1:get("舰爆")
		self._control.left_widget.nf_info.atk_info.atk.text.text = var_0_1:get("舰攻")
		self._control.left_widget.nf_info.air_info.air.text.text = var_0_1:get("对空")
		self._control.left_widget.nf_info.spotting_info.spotting.text.text = var_0_1:get("索敌")
		self._control.left_widget.nf_info.counterair_info.counterair.text.text = var_0_1:get("制空")
	end

	function arg_1_0.__add_slot_cost(arg_55_0)
		local var_55_0 = 0

		for iter_55_0, iter_55_1 in pairs(var_0_3:get_tower_chip_info().slot) do
			for iter_55_2, iter_55_3 in pairs(var_0_4.add_cost_chip) do
				if iter_55_1 == iter_55_2 then
					var_55_0 = var_55_0 + iter_55_3
				end
			end
		end

		return var_55_0
	end

	function arg_1_0:save_team_info_all(arg_56_1)
		local var_56_0 = {}
		local var_56_1 = {}

		for iter_56_0, iter_56_1 in pairs(arg_56_1 or self._team_data) do
			var_0_14(var_56_0, {
				keys = iter_56_0,
				id = iter_56_1
			})
		end

		table.sort(var_56_0, function(arg_57_0, arg_57_1)
			return arg_57_0.keys < arg_57_1.keys
		end)

		for iter_56_2, iter_56_3 in pairs(var_56_0) do
			var_56_1[iter_56_2] = iter_56_3.id
		end

		if self._current_team_index and self._current_team_index == 1 and (not var_56_0 or not next(var_56_0)) then
			var_0_35:show(var_0_1:getNowLang("needflagshipinfleet"))

			return false
		end

		var_0_3:req_TeamSave({
			quick = true,
			id = self._current_team_index,
			members = var_56_1
		})

		return true
	end

	function arg_1_0:get_all_charactor_info_affected_from_tower_by_charactors_config(arg_58_1)
		if not self._tower_cost_affected_buff_list or #self._tower_cost_affected_buff_list == 0 then
			return arg_58_1
		end

		local var_58_0 = var_0_18(arg_58_1)

		for iter_58_0, iter_58_1 in pairs(self._tower_cost_affected_buff_list) do
			var_58_0 = self:select_ship_by_pvebuff(var_58_0, iter_58_1, self._fight_prepare_type)
		end

		return var_58_0
	end

	function arg_1_0:__get_characters_info_affected_by_tower_buff_later(arg_59_1)
		if not arg_59_1 then
			return
		end

		local var_59_0 = {}

		for iter_59_0, iter_59_1 in pairs(arg_59_1) do
			local var_59_1 = var_0_3:find_character_by_id(iter_59_1)

			if not var_59_1 then
				print("??????")

				return
			end

			var_0_14(var_59_0, (var_0_6.find_object_by_cid(var_59_1.cid)))
		end

		if not self._tower_cost_affected_buff_list or #self._tower_cost_affected_buff_list == 0 then
			return var_59_0
		else
			return {}
		end
	end

	function arg_1_0:__update_tower_cost()
		if not self._team_data or #self._team_data == 0 then
			return
		end

		self._limit_tower = self:__the_rest_of_the_cost()
		self._tower_cost = 0

		for iter_60_0, iter_60_1 in pairs(self._team_data) do
			self._tower_cost = self._tower_cost + self:__check_for_each_cost((var_0_6.find_object_by_cid(var_0_3:find_character_by_id(iter_60_1).cid)))
		end

		self._control.left_widget.tower_cost.cost_text.text.text = var_0_12("<color=%s>%s</color>/%s", (self._tower_cost > self._limit_tower or nil) and "#f8040c", self._tower_cost, self._limit_tower)
	end

	function arg_1_0:__check_for_each_cost(arg_61_1)
		local var_61_0 = arg_61_1.cost

		if self._now_layer_map_cfg.tower_buff and next(self._now_layer_map_cfg.tower_buff) then
			for iter_61_0, iter_61_1 in pairs(self._now_layer_map_cfg.tower_buff) do
				for iter_61_2, iter_61_3 in pairs(var_0_25.find_object_by_id(iter_61_1).effect) do
					if iter_61_3.num4 == 18 then
						if iter_61_3.shipTon then
							var_61_0 = var_61_0 + self:__check_buff_info(arg_61_1.ship_ton, iter_61_3.shipTon, iter_61_3.type, iter_61_3.num)
						elseif iter_61_3.shipType then
							var_61_0 = var_61_0 + self:__check_buff_info(arg_61_1.type, iter_61_3.shipType, iter_61_3.type, iter_61_3.num)
						elseif iter_61_3.country then
							var_61_0 = var_61_0 + self:__check_buff_info(arg_61_1.country, iter_61_3.country, iter_61_3.type, iter_61_3.num)
						elseif iter_61_3.guardType then
							var_61_0 = var_61_0 + self:__check_buff_info(arg_61_1.guard_type, iter_61_3.guardType, iter_61_3.type, iter_61_3.num)
						end
					end
				end
			end
		end

		return var_61_0
	end

	function arg_1_0.__check_buff_info(arg_62_0, arg_62_1, arg_62_2, arg_62_3, arg_62_4)
		local var_62_0 = 0

		for iter_62_0, iter_62_1 in pairs(arg_62_2) do
			if arg_62_1 == iter_62_1 then
				if arg_62_3 == 9 then
					var_62_0 = var_62_0 + arg_62_4
				elseif arg_62_3 == 10 then
					var_62_0 = var_62_0 - arg_62_4
				end
			end
		end

		return var_62_0
	end

	function arg_1_0:send_tower_buff_info()
		if self._fight_prepare_type == var_0_4.fight_type.tower_fight then
			return self._now_layer_map_cfg.tower_buff
		else
			return {}
		end
	end

	function arg_1_0:__update_reusable_cell()
		local var_64_0 = var_0_3:get_sixth_combat_info()

		self._reusable_cell:set_data(var_64_0.buff)

		function self._reusable_cell:_set_func(arg_65_1)
			self:show(arg_65_1 + 1, var_64_0.buff[arg_65_1 + 1])
		end
	end

	function arg_1_0:__update_mist_reusable_cell()
		local var_66_0 = var_0_3:get_mist_combat_info()

		self._reusable_cell:set_data(var_66_0.buff)

		function self._reusable_cell:_set_func(arg_67_1)
			self:show(arg_67_1 + 1, var_66_0.buff[arg_67_1 + 1])
		end
	end

	function arg_1_0:__update_ninth_active_reusable_cell()
		local var_68_0 = var_0_3:get_ninth_cia_buff_info()

		if var_68_0 and next(var_68_0) then
			var_68_0 = var_68_0.ids
		end

		self._reusable_cell:set_data(var_68_0)

		function self._reusable_cell:_set_func(arg_69_1)
			self:show(arg_69_1 + 1, var_68_0[arg_69_1 + 1])
		end
	end

	function arg_1_0:__update_ocean_map_reusable_cell(arg_70_1)
		if arg_70_1 and arg_70_1 ~= 0 then
			self._map_id = arg_70_1
		end

		local var_70_0 = {}
		local var_70_1 = {}

		self._effective_debuff_config = {}

		local var_70_2 = var_0_3:get_ocean_map_buff_data()

		if var_70_2 ~= nil and var_70_2 ~= {} then
			for iter_70_0, iter_70_1 in pairs(var_70_2) do
				if iter_70_1.id ~= 0 then
					local var_70_3 = var_0_39.find_object_by_id(iter_70_1.id)

					if var_70_3.effect.type then
						var_70_1[var_70_3.effect.type] = var_70_3.effect.type
					end

					var_0_14(var_70_0, {
						is_debuff = false,
						is_unlocked_debuff = false,
						id = iter_70_1.id,
						config = var_70_3
					})
				end
			end
		end

		local var_70_4 = var_0_38.find_object_by_id(self._map_id).debuff

		for iter_70_2 = 1, #var_70_4 do
			local var_70_5 = var_0_39.find_object_by_id(var_70_4[iter_70_2])
			local var_70_6 = true

			for iter_70_3, iter_70_4 in pairs(var_70_5.need_buff) do
				if iter_70_4 then
					var_70_6 = false
				end
			end

			if var_70_5 then
				local var_70_7 = var_70_1 and var_70_1[var_70_5.unlock_type]
				local var_70_8 = {
					is_debuff = true,
					id = var_70_4[iter_70_2],
					is_unlocked_debuff = var_70_1 and var_70_1[var_70_5.unlock_type],
					config = var_70_5
				}

				if var_70_6 then
					var_0_14(var_70_0, var_70_8)
				end

				if not var_70_7 then
					self._effective_debuff_config[var_70_8.id] = var_70_5
				end
			end
		end

		if self._ocean_reusable_cell and var_70_0 then
			self._ocean_reusable_cell:set_data(var_70_0)

			function self._ocean_reusable_cell:_set_func(arg_71_1)
				self:show(arg_71_1 + 1, var_70_0[arg_71_1 + 1])
			end
		end

		local var_70_9 = var_0_2:getInstance("ocean_cia") or var_0_2:createInstance("ocean_cia")
		local var_70_10 = {}
		local var_70_11 = {}

		for iter_70_5, iter_70_6 in pairs(self._effective_debuff_config) do
			if iter_70_6.effect.type == var_0_4.ocean_debuff_effect_type.type_105 or iter_70_6.effect.type == var_0_4.ocean_debuff_effect_type.type_106 then
				table.insert(var_70_10, iter_70_6)
			end
		end

		for iter_70_7, iter_70_8 in pairs(var_70_2) do
			var_70_11[iter_70_8.id] = iter_70_8
		end

		var_0_3:set_ocean_all_buff_for_fight_list(true, var_70_11)
		var_0_3:set_ocean_all_buff_for_fight_list(false, var_70_10)
		self:update_ocean_fight(var_70_9, var_70_10, var_70_11)
	end

	function arg_1_0:update_ocean_fight(arg_72_1, arg_72_2, arg_72_3)
		for iter_72_0, iter_72_1 in pairs(self._team_detail_data) do
			if arg_72_1:check_ocean_buff_limit(iter_72_1, arg_72_2, arg_72_3) then
				table.insert(self._ocean_can_fight_list, iter_72_1.data.id)
			end
		end

		for iter_72_2, iter_72_3 in pairs(self._ship_item_list) do
			local var_72_0 = false

			for iter_72_4, iter_72_5 in pairs(self._ocean_can_fight_list) do
				if iter_72_3._data and iter_72_3._data.id == iter_72_5 then
					var_72_0 = true

					break
				end
			end

			local var_72_2 = not var_72_0 and 1 or 0
			local var_72_3 = iter_72_3._control.ship_item.item_icon_mask.mark_bg

			if iter_72_3._control.ship_item.item_icon_mask.mark_bg.canvasGroup.alpha == 0 then
				var_72_3.canvasGroup.alpha = var_72_2
			end

			if var_72_3.tower_limit.canvasGroup.alpha == 0 then
				var_72_3.tower_limit.canvasGroup.alpha = var_72_2
			end
		end
	end

	function arg_1_0.__set_map_band_ship(arg_73_0)
		return
	end

	function arg_1_0:__clear_tower_info_cells()
		if not self._tower_info_cells_list then
			return
		end

		for iter_74_0, iter_74_1 in pairs(self._tower_info_cells_list) do
			if iter_74_1 then
				iter_74_1.cell:SetActive(false)
			end
		end
	end

	function arg_1_0:__create_tower_info_cells_to_num(arg_75_1)
		if not arg_75_1 or arg_75_1 <= 0 then
			return
		end

		self._tower_info_cells_list = self._tower_info_cells_list or {}

		local var_75_0 = arg_75_1 - #self._tower_info_cells_list

		if arg_75_1 - #self._tower_info_cells_list <= 0 then
			return
		end

		local var_75_1 = self._control.right_widget.bg_back.tower_info.layer_list.Viewport.edge_mask.Content.transform

		for iter_75_0 = 1, var_75_0 do
			local var_75_2 = self:loadUIPrefab("tower_layer_info")._panel

			var_75_2.transform:SetParent(var_75_1)

			local var_75_3 = var_75_2.transform:GetComponent(typeof(var_0_44))
			local var_75_4 = var_75_2.transform:GetComponent(typeof(var_0_45))
			local var_75_5 = var_75_2.transform:GetComponent("Text")

			var_75_4.sizeDelta = var_0_15.New(205, 0)

			var_0_14(self._tower_info_cells_list, {
				cell = var_75_2,
				content_fitter = var_75_3,
				rectTransform = var_75_4,
				text = var_75_5
			})
		end
	end

	function arg_1_0:__tower_cost_affected_buff_record(arg_76_1)
		if not arg_76_1 or not arg_76_1.effect then
			return
		end

		for iter_76_0, iter_76_1 in pairs(arg_76_1.effect) do
			if iter_76_1 then
				if (iter_76_1.num4 or -1) == 18 then
					var_0_14(self._tower_cost_affected_buff_list, iter_76_1)
				end
			end
		end
	end

	function arg_1_0:__update_tower_reusable_cell()
		if not self._control.right_widget.bg_back.tower_info.activeSelf then
			self._control.right_widget.bg_back.tower_info:SetActive(true)
		end

		local var_77_0 = self._control.right_widget.bg_back.tower_info.layer_list

		if not self._control.right_widget.bg_back.tower_info.layer_list.activeSelf then
			var_77_0:SetActive(true)
		end

		if not self._tower_layer_list_canvas_group then
			self._tower_layer_list_canvas_group = var_0_5.get_or_add_canvas_group_component_to_it(var_77_0)
			self._tower_layer_list_canvas_group.alpha = 0
		end

		self:__clear_tower_info_cells()
		self:__create_tower_info_cells_to_num(#self._now_layer_map_cfg.tower_buff)

		self._tower_cost_affected_buff_list = {}

		for iter_77_0 = 1, #self._now_layer_map_cfg.tower_buff do
			local var_77_1 = var_0_25.find_object_by_id(self._now_layer_map_cfg.tower_buff[iter_77_0])

			self._tower_info_cells_list[iter_77_0].rectTransform.anchoredPosition = var_0_15.New(0, -0)

			self._tower_info_cells_list[iter_77_0].cell:SetActive(true)

			self._tower_info_cells_list[iter_77_0].text.text = var_0_5.convert_rich_text(var_77_1.desc)

			self._tower_info_cells_list[iter_77_0].content_fitter:SetLayoutVertical()
			self:__tower_cost_affected_buff_record(var_77_1)
		end
	end

	function arg_1_0:__set_enemy_info_des()
		self._control.right_widget.bg_back.tower_info.enemy_listscrollview.content.enemy_info_des.text.text = self._now_layer_map_cfg.enemys_buff and self._now_layer_map_cfg.enemys_buff[self._card_index] and self._now_layer_map_cfg.enemys_buff[self._card_index][1] > 0 and var_0_5.convert_rich_text(var_0_25.find_object_by_id(self._now_layer_map_cfg.enemys_buff[self._card_index][1]).desc) or "无"
	end

	function arg_1_0:show_ocean_buff_cell_detailed_info(arg_79_1)
		if not arg_79_1 then
			return
		end

		local var_79_0 = arg_79_1.config

		self._control.ocean_cia_buff_info_bg:SetActive(true)

		self._control.ocean_cia_buff_info_bg.single_ocean_cia.transform.position = arg_79_1.pos
		self._control.ocean_cia_buff_info_bg.single_ocean_cia.transform.localPosition = var_0_15.New(self._control.ocean_cia_buff_info_bg.single_ocean_cia.transform.localPosition.x - 100, self._control.ocean_cia_buff_info_bg.single_ocean_cia.transform.localPosition.y)
		self._control.ocean_cia_buff_info_bg.single_ocean_cia.desc_text.text.text = var_0_1:convert_rich_text(var_79_0.effect_desc)
		self._control.ocean_cia_buff_info_bg.single_ocean_cia.desc_text.text.color = var_0_16.New(0.5882352941176471, 0.5882352941176471, 0.5882352941176471)
		self._control.ocean_cia_buff_info_bg.single_ocean_cia.limit_text.text.text = var_0_1:convert_rich_text(var_79_0.desc)
		self._control.ocean_cia_buff_info_bg.single_ocean_cia.limit_text.text.color = var_0_16.New(0.3411764705882353, 0.792156862745098, 1)

		self._control.ocean_cia_buff_info_bg.single_ocean_cia.title:GetComponent("TextHorizonScroller"):SetText(var_79_0.title)

		self._control.ocean_cia_buff_info_bg.single_ocean_cia.icon_bg.icon.image.sprite = self:loadSprite(var_0_12(var_0_4.ocean_cia_icon, var_79_0.buff_type))
	end

	function arg_1_0:__update_strike_reusable_cell()
		local var_80_0 = var_0_29.find_object_by_id(self._go_to_map_id)
		local var_80_1
		local var_80_2 = var_0_3:get_strike_data_by_level(self._go_to_map_id)

		if (var_80_2 and var_80_2.score or 0) >= var_80_0.hard_score and var_80_0.weather2 ~= 0 then
			local var_80_4 = {}

			var_80_4.score = 0
			var_80_4.id = var_0_31.find_object_by_id(var_80_0.weather2).id

			var_0_14(self._current_strike_buffs, 1, var_80_4)
		end

		if self._current_strike_buffs and next(self._current_strike_buffs) then
			var_80_1 = var_0_18(self._current_strike_buffs)
		elseif self.__strike_is_deal == true then
			local var_80_5 = var_0_3:get_strike_data_by_level(self._go_to_map_id)

			if nil then
				var_80_1 = {
					(var_0_30.find_object_by_id((var_80_5.score >= var_80_0.hard_score and var_80_0.emergent_buff2 or var_80_0.emergent_buff)[1]))
				}
			end
		end

		local var_80_6 = {}

		if not var_80_1 then
			for iter_80_0 = 1, 7 do
				var_80_6[iter_80_0] = {}
			end

			self._strike_reusable_cell:set_data(var_80_6)

			function self._strike_reusable_cell:_set_func(arg_81_1)
				self:show(arg_81_1 + 1, var_80_6[arg_81_1 + 1])
			end
		else
			for iter_80_1 = 1, #var_80_1 >= 7 and #var_80_1 or 7 do
				var_80_6[iter_80_1] = var_80_1[iter_80_1] or {}
			end

			self._strike_reusable_cell:set_data(var_80_6)

			function self._strike_reusable_cell:_set_func(arg_82_1)
				self:show(arg_82_1 + 1, var_80_1[arg_82_1 + 1])
			end
		end
	end

	function arg_1_0:__select_strike_toggle(arg_83_1)
		if arg_83_1 == "toggle_buff" then
			self._control.right_widget.bg_back.speed_skeleton_mask:SetActive(false)
			self._control.right_widget.bg_back.strike_info.radar_chart_bg:SetActive(false)
			self._control.right_widget.bg_back.strike_info.speed_info_panel:SetActive(false)
			self._control.right_widget.bg_back.speed_skeleton_mask.speed_skeleton:SetActive(false)
			self._control.right_widget.bg_back.strike_info.buffs:SetActive(true)
			self._control.right_widget.bg_back.strike_info.point:SetActive(true)
			self:__refresh_strike_buff_item_display()

			local var_83_0 = var_0_3:get_strike_point_info()
			local var_83_1 = var_0_3:get_save_buff()

			if var_83_0 and next(var_83_0) and var_83_0.buffs and next(var_83_0.buffs) or var_83_1 and next(var_83_1) then
				self._control.right_widget.bg_back.strike_info.canvasGroup.alpha = 1
				self._control.right_widget.bg_back.strike_info.canvasGroup.blocksRaycasts = true
			elseif self.__strike_is_deal == true then
				self._control.right_widget.bg_back.strike_info.canvasGroup.alpha = 1
				self._control.right_widget.bg_back.strike_info.canvasGroup.blocksRaycasts = true
			else
				self:__init_total_props_panel()
				self:__set_total_props_panel_data()

				self._control.right_widget.bg_back.strike_info.canvasGroup.alpha = 1
				self._control.right_widget.bg_back.strike_info.canvasGroup.blocksRaycasts = true
			end
		elseif arg_83_1 == "toggle_info" then
			self._control.right_widget.bg_back.strike_info.buffs:SetActive(false)
			self._control.right_widget.bg_back.strike_info.point:SetActive(false)
			self._control.right_widget.bg_back.speed_skeleton_mask:SetActive(true)
			self._control.right_widget.bg_back.strike_info.radar_chart_bg:SetActive(true)
			self._control.right_widget.bg_back.strike_info.speed_info_panel:SetActive(true)
			self._control.right_widget.bg_back.speed_skeleton_mask.speed_skeleton:SetActive(true)
			self:__update_strike_buffs()
			self:__set_total_props_panel_data()
		end
	end

	function arg_1_0:__select_tower_toggle(arg_84_1)
		local var_84_1 = var_0_16.New(0.5490196078431373, 0.5803921568627451, 0.6196078431372549, 1)
		local var_84_2 = var_0_16.white
		local var_84_3 = 24
		local var_84_4 = 27

		local function var_84_5(arg_85_0, arg_85_1)
			if arg_85_1 then
				arg_85_0.color = var_84_2
				arg_85_0.fontSize = var_84_4
			else
				arg_85_0.color = var_84_1
				arg_85_0.fontSize = var_84_3
			end
		end

		if arg_84_1 == var_0_4.tower_toggle.enemy_info then
			self:__update_tower_enemy()

			if not self._tower_enemy_list_canvas_group then
				self._control.right_widget.bg_back.tower_info.enemy_listscrollview.content.enemy_list:SetActive(true)
				self._control.right_widget.bg_back.tower_info.enemy_listscrollview.content.enemy_info_des:SetActive(true)

				self._tower_enemy_list_canvas_group = var_0_5.get_or_add_canvas_group_component_to_it(self._control.right_widget.bg_back.tower_info.enemy_listscrollview.content.enemy_list)
				self._tower_enemy_info_des_canvas_group = var_0_5.get_or_add_canvas_group_component_to_it(self._control.right_widget.bg_back.tower_info.enemy_listscrollview.content.enemy_info_des)
			end

			self._tower_enemy_list_canvas_group.alpha = 1
			self._tower_enemy_info_des_canvas_group.alpha = 1

			if self._tower_layer_list_canvas_group then
				self._tower_layer_list_canvas_group.alpha = 0
			end

			var_84_5(self._control.right_widget.bg_back.tower_info.toggle_info.bg.title.text, true)
			var_84_5(self._control.right_widget.bg_back.tower_info.toggle_layer.bg.title.text, false)
		elseif arg_84_1 == var_0_4.tower_toggle.layer_info then
			self._tower_enemy_list_canvas_group.alpha = 0
			self._tower_enemy_info_des_canvas_group.alpha = 0
			self._tower_layer_list_canvas_group.alpha = 1

			var_84_5(self._control.right_widget.bg_back.tower_info.toggle_info.bg.title.text, false)
			var_84_5(self._control.right_widget.bg_back.tower_info.toggle_layer.bg.title.text, true)
		end
	end

	function arg_1_0:__set_panel_info()
		local var_86_0 = (self._team_type == var_0_4.team_type.normal or self._team_type == var_0_4.team_type.ocean_attack_team) and self._fight_prepare_type ~= var_0_4.fight_type.exercise and self._fight_prepare_type ~= var_0_4.fight_type.tower_fight and self._fight_prepare_type ~= var_0_4.fight_type.show_room_friend and self._fight_prepare_type ~= var_0_4.fight_type.captainroom_friend and self._fight_prepare_type ~= var_0_4.fight_type.strike and self._fight_prepare_type ~= var_0_4.fight_type.tower_rank_list and self._fight_prepare_type ~= var_0_4.fight_type.seventh and self._fight_prepare_type ~= var_0_4.fight_type.abyss_model_first_phase

		if self._fight_prepare_type == var_0_4.fight_type.seventh or self._fight_prepare_type == var_0_4.fight_type.eighth_attack then
			var_86_0 = not not (self.seventh_is_boss or self._eighth_is_boss)
		end

		if self._fight_prepare_type == var_0_4.fight_type.score_attack then
			var_86_0 = true
		end

		if var_86_0 then
			local var_86_1, var_86_2, var_86_3, var_86_4 = var_0_3:get_support_notify()

			self._control.parent.support_icon_bg.image.sprite = self:loadSprite(var_86_2 < 10 and (var_86_4 and (var_86_2 < 10 and var_0_4.pve_support_card_1 or var_0_4.pve_support_card_2) or var_0_4.pve_support_card) or var_0_4.pve_support_card_2)

			var_0_3:set_support_info(true)
		else
			var_0_3:set_support_info(false)
		end

		self._control.parent.support_icon_bg:SetActive(var_86_0)

		if self._fight_prepare_type == var_0_4.fight_type.tower_fight then
			self._control.parent.tower_icon_bg:SetActive(true)
		else
			self._control.parent.tower_icon_bg:SetActive(false)
		end

		if self._fight_prepare_type == var_0_4.fight_type.sixth_fight or self._fight_prepare_type == var_0_4.fight_type.exercise or self._fight_prepare_type == var_0_4.fight_type.campaign or self._fight_prepare_type == var_0_4.fight_type.show_room_friend or self._fight_prepare_type == var_0_4.fight_type.tower_rank_list or self._current_content_type == var_0_4.fight_prepare_right_panel_type.condition then
			-- block empty
		elseif self._team_type == var_0_4.team_type.ocean_attack_team or self._fight_prepare_type == var_0_4.fight_type.strike then
			-- block empty
		end

		self._no_clicking = false
	end

	function arg_1_0:update_supply_control_info()
		if self._support_id and tonumber(self._support_id) ~= 0 then
			self._config_data = var_0_20.find_object_by_id(tonumber(self._support_id))

			local var_87_0 = var_0_3:get_supportInfo_data(self._go_to_map_id)
			local var_87_1 = not not (var_87_0 and next(var_87_0))
			local var_87_2 = var_0_3:GetMapData()

			if var_87_2[self._go_to_map_id] then
				self._supply_type = var_87_2[self._go_to_map_id].support or false
			end

			self:__onupdate_type_toggle(self._supply_type)

			self._control.supply_type_btn.toggle_text.text.text = self._config_data.title

			self._control.supply_type_btn:SetActive(var_87_1)
			self._control.right_widget.bg_back.supply_panel.map_support:SetActive(var_87_1)

			local var_87_3 = ""

			if var_87_1 then
				self:__set_support_data(var_87_0)

				self._has_map_support = true
				var_87_3 = var_0_4.pve_support_bg["pve_support_lv_" .. var_87_0.level]
			else
				var_87_3 = var_0_4.pve_support_bg.pve_support_lv_0
			end

			self._control.right_widget.bg_back.supply_panel.map_support.icon_bg.image.sprite = self:loadSprite(var_87_3)
			self._control.right_widget.bg_back.supply_panel.map_support.support_button.image.sprite = self:loadSprite(var_0_4.support_pve_icon["pve_support_" .. self._config_data.type])
		else
			self._supply_type = false

			self._control.supply_type_btn:SetActive(false)
			self._control.right_widget.bg_back.supply_panel.map_support:SetActive(false)
		end
	end

	function arg_1_0:__set_support_data(arg_88_1)
		local var_88_0 = arg_88_1 or var_0_3:get_supportInfo_data(self._go_to_map_id)

		self._support_atk_list = {}

		for iter_88_0, iter_88_1 in pairs(self._config_data) do
			if iter_88_0 == "ammo" then
				self._support_atk_list[3] = {
					supply_name = "bullet",
					maxnum = iter_88_1
				}
			elseif iter_88_0 == "aluminium" then
				self._support_atk_list[1] = {
					supply_name = "al",
					maxnum = iter_88_1
				}
			elseif iter_88_0 == "oil" then
				self._support_atk_list[2] = {
					supply_name = "oil",
					maxnum = iter_88_1
				}
			end
		end

		local var_88_1 = false

		for iter_88_2, iter_88_3 in pairs(self._support_atk_list) do
			local var_88_2 = self._control.right_widget.bg_back.supply_panel.map_support.count_parent[var_0_12("icon_%s", iter_88_2)]

			var_88_2.image.sprite = self:loadSprite(var_0_4.support_supply_icon[iter_88_3.supply_name])

			local var_88_3 = var_88_0[iter_88_3.supply_name] / iter_88_3.maxnum / 2
			local var_88_4, var_88_5 = var_0_34(var_88_0[iter_88_3.supply_name] / iter_88_3.maxnum / 2)

			if var_88_5 > 0 and var_88_5 < 0.5 then
				var_88_3 = math.floor(var_88_3)
			elseif var_88_5 ~= 0 then
				var_88_3 = math.ceil(var_88_3)
			end

			if iter_88_3.maxnum == 0 then
				var_88_2:SetActive(false)
			else
				var_88_2:SetActive(true)

				for iter_88_4 = 1, 5 do
					if iter_88_4 <= var_88_3 then
						var_88_2.full_image[var_0_12("full%s", iter_88_4)].image.sprite = self:loadSprite(var_0_4.ship_support_blue)
					else
						var_88_1 = true
						var_88_2.full_image[var_0_12("full%s", iter_88_4)].image.sprite = self:loadSprite(var_0_4.ship_support_bg)
					end
				end
			end
		end

		self._support_supply_full = not var_88_1

		if self._is_auto_supply and not arg_88_1 then
			if self._supply_type and not self._support_supply_full then
				var_0_35:show(var_0_1:getNowLang("support_not_full"))

				return
			end

			if self._go_to_map_id < var_0_4.normal_map_max_id and self._fight_prepare_type == var_0_4.fight_type.gotofight then
				var_0_3:req_EnterMapReq({
					id = self._go_to_map_id,
					team_id = self._team_group_data[self._current_team_index].id,
					start_point = self._init_node_id
				})
			elseif self._fight_prepare_type == var_0_4.fight_type.fearlessness_sea then
				var_0_3:req_PushEnterMapReq({
					id = self._go_to_map_id,
					team_id = self._team_group_data[self._current_team_index].id
				})
			elseif self._fight_prepare_type == var_0_4.fight_type.farfight then
				local var_88_6 = app:getSystem():getChannel()

				print("发送555")

				local var_88_7 = var_0_4:get_now_appversion_num()

				var_0_3:req_ExpeditionStartReq({
					team_id = self._team_group_data[self._current_team_index].id,
					id = self._farfight_data.id
				})
				log.print_r(var_88_6, "channel渠道名字")
				log.print_r(var_88_7, "version_num版本号数")

				if var_88_6 == "hm_android" and var_88_7 > var_0_4.version_init_num then
					NotifyManager.InitReceivedHandler()

					function NotifyManager.receivedCallback(arg_89_0)
						print("通知触发回调")
					end

					NotifyManager.CreateChannel(var_88_6, "cbt", 4, "推送", true, true)
					print("发送555555")
					log.print_r(self._farfight_data.need_time, "需要时间5555")
					NotifyManager.CreateAndroidNotification("提督大人", string.format(var_0_1:getNowLang("expeditioncompleted"), self._team_group_data[self._current_team_index].id, self._farfight_data.title), self._farfight_data.need_time, true, "", "icon_1", "", self._team_group_data[self._current_team_index].id, var_88_6)
				end
			elseif self._fight_prepare_type == var_0_4.fight_type.score_attack then
				var_0_3:req_AnswerEnterMapReq({
					id = self._go_to_map_id,
					team_id = self._team_group_data[self._current_team_index].id,
					start_point = self._init_node_id
				})
			elseif self._fight_prepare_type == var_0_4.fight_type.ninth_attack then
				var_0_3:req_NinthEnterMapReq({
					id = self._go_to_map_id,
					team_id = self._team_group_data[self._current_team_index].id,
					start_point = self._init_node_id
				})
			end

			self._is_auto_supply = false
		end
	end

	function arg_1_0:__onupdate_auto_toggle(arg_90_1)
		self._control.auto_supply_btn.toggle_img:SetActive(arg_90_1)
	end

	function arg_1_0:__onupdate_type_toggle(arg_91_1)
		self._control.supply_type_btn.toggle_img:SetActive(arg_91_1)
	end

	function arg_1_0.__play_animation(arg_92_0, arg_92_1, arg_92_2, arg_92_3)
		arg_92_1.skeletonGraphic.AnimationState:SetAnimation(0, arg_92_2, arg_92_3)
	end

	function arg_1_0:__init_prepare_item_list(arg_93_1)
		self._team_detail_data = {}
		self._team_group_data = var_0_3:get_team_group(self._team_type)

		local var_93_0 = 1

		if self._fight_prepare_type == var_0_4.fight_type.gotofight or self._fight_prepare_type == var_0_4.fight_type.exercise or self._fight_prepare_type == var_0_4.fight_type.show_room_friend or self._fight_prepare_type == var_0_4.fight_type.captainroom_friend or self._fight_prepare_type == var_0_4.fight_type.tower_rank_friend_captainroom or self._fight_prepare_type == var_0_4.fight_type.fearlessness_sea or self._fight_prepare_type == var_0_4.fight_type.seventh or self._fight_prepare_type == var_0_4.fight_type.tower_fight or self._fight_prepare_type == var_0_4.fight_type.score_attack or self._fight_prepare_type == var_0_4.fight_type.ninth_attack or self._fight_prepare_type == var_0_4.fight_type.eighth_attack then
			var_93_0 = self._gotofight_memory_team_index

			if self._fight_prepare_type == var_0_4.fight_type.eighth_attack and self._gotofight_memory_team_index > 4 then
				var_93_0 = 1
				self._gotofight_memory_team_index = 1
			end
		end

		if self._fight_prepare_type == var_0_4.fight_type.tower_fight then
			var_93_0 = self._current_team_index
		end

		self._team_group_data = self._team_group_data or lx.clone_table(var_0_3:get_team_all_data())[1]

		local var_93_1 = self._team_group_data[var_93_0 + (self._team_type - 1) * 4]
		local var_93_2 = self._team_type == var_0_4.team_type.normal and 0 or 4

		for iter_93_0, iter_93_1 in pairs(self._team_group_data) do
			local var_93_3 = iter_93_0 % 4 == 0 and 4 or iter_93_0 % 4

			self._control.left_widget.team_toggle[var_0_12("toggle%d", iter_93_0 % 4 == 0 and 4 or iter_93_0 % 4)].gameObject:SetActive(true)
			self._control.left_widget.team_toggle.locks[var_0_12("lock_%d", var_93_3)].gameObject:SetActive(false)

			self._control.left_widget.team_toggle[var_0_12("toggle%d", var_93_3)].bg.title.text.text = var_0_12("%d%s", var_93_3 + var_93_2, var_0_1:getNowLang("team_single_word"))
		end

		for iter_93_2 = 1, 4 do
			if iter_93_2 > #self._team_group_data then
				self._control.left_widget.team_toggle[var_0_12("toggle%d", iter_93_2)].gameObject:SetActive(false)
				self._control.left_widget.team_toggle.locks[var_0_12("lock_%d", iter_93_2)].gameObject:SetActive(true)
			end
		end

		for iter_93_3 = 1, var_0_17 do
			local var_93_4 = self._ship_item_list[iter_93_3]

			if not self._ship_item_list[iter_93_3] then
				var_93_4 = self:loadUI("fight_prepare_ship_item")

				var_93_4._panel.transform:SetParent(self._control.left_widget.rankable_layout_group.rectTransform, false)
			end

			if var_93_1 then
				local var_93_5 = var_93_1.members[iter_93_3] or nil

				if var_93_5 then
					local var_93_6 = var_0_3:find_character_by_id(var_93_5)
					local var_93_7 = var_0_6.find_object_by_cid(var_93_6.cid)

					var_93_4:show(iter_93_3, arg_93_1, var_93_6, var_93_7, self._team_type)

					self._team_data[#self._team_data + 1] = var_93_6.id
					self._team_detail_data[#self._team_detail_data + 1] = {
						data = var_0_5.little_clone(var_93_6),
						config = var_0_5.little_clone(var_93_7)
					}

					goto label_93_0
				end
			end

			var_93_4:show(iter_93_3, arg_93_1, nil, nil, self._team_type)

			::label_93_0::

			self._ship_item_list[iter_93_3] = var_93_4
		end

		self._control.left_widget.rankable_layout_group.rankableLayoutGroup.onItemExchange:RemoveAllListeners()
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup.onItemExchange:AddListener(function(arg_94_0, arg_94_1)
			self._team_data[arg_94_0] = self._team_data[arg_94_1]
			self._team_data[arg_94_1] = self._team_data[arg_94_0]
			self._ship_item_list[arg_94_0] = self._ship_item_list[arg_94_1]
			self._ship_item_list[arg_94_1] = self._ship_item_list[arg_94_0]
		end)
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup.onEndDrag:RemoveAllListeners()
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup.onEndDrag:AddListener(function()
			if #self._team_data < 2 then
				return
			end

			self:__save_team_all_info(self._team_data)
		end)
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup:Init()
	end

	function arg_1_0:__init_campaign_prepare(arg_96_1)
		arg_96_1 = arg_96_1 or self._current_content_type

		local var_96_0 = var_0_3:get_campaign_data(self._go_to_map_id)

		self._team_detail_data = {}

		if var_96_0 and var_96_0.info and var_96_0.info.members then
			self._campagion_team_data = {}

			for iter_96_0 = 1, 6 do
				self._campagion_team_data[iter_96_0] = var_96_0.info.members[iter_96_0] and var_96_0.info.members[iter_96_0] or 0
			end
		else
			self._campagion_team_data = {
				0,
				0,
				0,
				0,
				0,
				0
			}
		end

		local var_96_1 = 0
		local var_96_2 = var_0_37.find_object_by_id(self._go_to_map_id)

		for iter_96_1, iter_96_2 in pairs(var_96_2.fleet_rule) do
			if iter_96_2 > 0 then
				var_96_1 = var_96_1 + 1
			end
		end

		if next(self._campagion_data.fleet_rule) then
			for iter_96_3, iter_96_4 in pairs(self._campagion_data.fleet_rule) do
				local var_96_3 = self._ship_item_list[iter_96_3] or self:loadUI("fight_prepare_ship_item")

				var_96_3._panel.transform:SetParent(self._control.left_widget.rankable_layout_group.rectTransform, false)

				local var_96_4 = 0

				if var_96_0 and var_96_0.info and var_96_0.info.members then
					var_96_4 = var_96_0.info.members and var_96_0.info.members[iter_96_3] or 0
				end

				if var_96_4 and var_96_4 ~= 0 and var_0_3:find_character_by_id(var_96_4) then
					local var_96_5 = var_0_3:find_character_by_id(var_96_4)

					if var_96_5.type == iter_96_4 then
						local var_96_6 = var_0_6.find_object_by_cid(var_96_5.cid)

						var_96_3:SetCampagion(true)
						var_96_3:show(iter_96_3, arg_96_1, var_96_5, var_96_6, self._team_type, self._go_to_map_id, self._campagion_data)

						self._team_detail_data[iter_96_3] = {
							data = var_0_5.little_clone(var_96_5),
							config = var_0_5.little_clone(var_96_6)
						}
					else
						var_96_4 = 0

						var_96_3:SetCampagion(true)
						var_96_3:show(iter_96_3, arg_96_1, nil, nil, self._team_type, self._go_to_map_id, self._campagion_data)
					end
				else
					var_96_3:SetCampagion(true)
					var_96_3:show(iter_96_3, arg_96_1, nil, nil, self._team_type, self._go_to_map_id, self._campagion_data)
				end

				self._campagion_team_data[iter_96_3] = var_96_4
				self._ship_item_list[iter_96_3] = var_96_3

				var_96_3:set_active_rankable_layout_item(false)

				if var_96_2.difficulty == 2 and var_96_1 < iter_96_3 then
					var_96_3._campaign_member_limit = true
					var_96_3._control.ship_empty.bg.image.sprite = self:loadSprite(var_0_4.fight_prepare_ship_item.ship_empty_ban_bg)
					var_96_3._control.campaign_layer.static_text.text.text = ""
					var_96_3._control.campaign_layer.limit_type.text.text = ""
					var_96_3._control.ship_empty.add_ship_btn.image.raycastTarget = false
				end
			end
		else
			for iter_96_5 = 1, var_0_17 do
				local var_96_7 = self._ship_item_list[iter_96_5] or self:loadUI("fight_prepare_ship_item")

				var_96_7._panel.transform:SetParent(self._control.left_widget.rankable_layout_group.rectTransform, false)

				local var_96_8 = 0

				if var_96_0 and var_96_0.info and var_96_0.info.members then
					var_96_8 = var_96_0.info.members and var_96_0.info.members[iter_96_5] or 0
				end

				if var_96_8 and var_96_8 ~= 0 and var_0_3:find_character_by_id(var_96_8) then
					local var_96_9 = var_0_3:find_character_by_id(var_96_8)
					local var_96_10 = var_0_6.find_object_by_cid(var_96_9.cid)

					var_96_7:SetCampagion(true)
					var_96_7:show(iter_96_5, arg_96_1, var_96_9, var_96_10, self._team_type, self._go_to_map_id, self._campagion_data)

					self._team_detail_data[iter_96_5] = {
						data = var_0_5.little_clone(var_96_9),
						config = var_0_5.little_clone(var_96_10)
					}
				else
					var_96_7:SetCampagion(true)
					var_96_7:show(iter_96_5, arg_96_1, nil, nil, self._team_type, self._go_to_map_id, self._campagion_data)
				end

				self._campagion_team_data[iter_96_5] = var_96_8
				self._ship_item_list[iter_96_5] = var_96_7

				var_96_7:set_active_rankable_layout_item(false)

				if var_96_2.difficulty == 2 and var_96_1 < iter_96_5 then
					var_96_7._campaign_member_limit = true
					var_96_7._control.ship_empty.bg.image.sprite = self:loadSprite(var_0_4.fight_prepare_ship_item.ship_empty_ban_bg)
					var_96_7._control.campaign_layer.static_text.text.text = ""
					var_96_7._control.campaign_layer.limit_type.text.text = ""
					var_96_7._control.ship_empty.add_ship_btn.image.raycastTarget = false
				end
			end
		end

		self._control.left_widget.rankable_layout_group.rankableLayoutGroup.onItemExchange:RemoveAllListeners()
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup.onItemExchange:AddListener(function(arg_97_0, arg_97_1)
			self._campagion_team_data[arg_97_0] = self._campagion_team_data[arg_97_1]
			self._campagion_team_data[arg_97_1] = self._campagion_team_data[arg_97_0]
			self._ship_item_list[arg_97_0] = self._ship_item_list[arg_97_1]
			self._ship_item_list[arg_97_1] = self._ship_item_list[arg_97_0]
		end)
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup.onEndDrag:RemoveAllListeners()
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup.onEndDrag:AddListener(function()
			if #self._campagion_team_data < 2 then
				return
			end

			self:__save_campaign_all_info(self._campagion_team_data)
		end)
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup:Init()
	end

	function arg_1_0:__init_sixth_prepare(arg_99_1)
		local var_99_0 = var_0_3:get_sixth_combat_info().members or {}

		self._sixth_team_data = {}
		self._team_detail_data = {}

		for iter_99_0 = 1, var_0_17 do
			local var_99_1 = self._ship_item_list[iter_99_0] or self:loadUI("fight_prepare_ship_item")

			var_99_1._panel.transform:SetParent(self._control.left_widget.rankable_layout_group.rectTransform, false)

			local var_99_2 = var_0_3:find_character_by_id(var_99_0[iter_99_0])

			self._team_type = var_0_4.team_type.sixth_team

			if var_99_0[iter_99_0] and var_99_2 then
				local var_99_3 = var_0_6.find_object_by_cid(var_99_2.cid)

				var_99_1:show(iter_99_0, arg_99_1, var_99_2, var_99_3, self._team_type)

				self._sixth_team_data[#self._sixth_team_data + 1] = var_99_2.id
				self._team_detail_data[#self._team_detail_data + 1] = {
					data = var_0_5.little_clone(var_99_2),
					config = var_0_5.little_clone(var_99_3)
				}
			else
				var_99_1:show(iter_99_0, arg_99_1, nil, nil, self._team_type)
			end

			var_0_3:set_sixth_prepare_team_detail_data(self._team_detail_data)

			self._ship_item_list[iter_99_0] = var_99_1
		end

		self._control.left_widget.rankable_layout_group.rankableLayoutGroup.onItemExchange:RemoveAllListeners()
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup.onItemExchange:AddListener(function(arg_100_0, arg_100_1)
			self._sixth_team_data = var_0_3:get_sixth_combat_info().members
			self._sixth_team_data[arg_100_0] = self._sixth_team_data[arg_100_1]
			self._sixth_team_data[arg_100_1] = self._sixth_team_data[arg_100_0]
			self._ship_item_list[arg_100_0] = self._ship_item_list[arg_100_1]
			self._ship_item_list[arg_100_1] = self._ship_item_list[arg_100_0]
		end)
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup.onEndDrag:RemoveAllListeners()
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup.onEndDrag:AddListener(function()
			if #self._sixth_team_data < 2 then
				return
			end

			var_0_3:req_SixthTeamSaveReq(self._sixth_team_data)
		end)
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup:Init()
	end

	function arg_1_0:__init_mist_prepare(arg_102_1)
		local var_102_0 = var_0_3:get_mist_combat_info().members or {}

		self._mist_team_data = {}
		self._team_detail_data = {}

		for iter_102_0 = 1, var_0_17 do
			local var_102_1 = self._ship_item_list[iter_102_0] or self:loadUI("fight_prepare_ship_item")

			var_102_1._panel.transform:SetParent(self._control.left_widget.rankable_layout_group.rectTransform, false)

			self._team_type = var_0_4.team_type.mist_team

			if var_102_0[iter_102_0] then
				local var_102_2 = gameconfig.pve_mist_ship_config.find_object_by_id(var_102_0[iter_102_0])

				var_102_1:show(iter_102_0, arg_102_1, var_102_2, var_102_2, self._team_type)

				self._mist_team_data[#self._mist_team_data + 1] = var_102_2.id
				self._team_detail_data[#self._team_detail_data + 1] = {
					data = var_0_5.little_clone(var_102_2),
					config = var_0_5.little_clone(var_102_2)
				}
			else
				var_102_1:show(iter_102_0, arg_102_1, nil, nil, self._team_type)
			end

			var_0_3:set_mist_prepare_team_detail_data(self._team_detail_data)

			self._ship_item_list[iter_102_0] = var_102_1

			if iter_102_0 == var_0_17 then
				var_102_1._campaign_member_limit = true
				var_102_1._control.ship_empty.bg.image.sprite = self:loadSprite(var_0_4.fight_prepare_ship_item.ship_empty_ban_bg)
				var_102_1._control.campaign_layer.static_text.text.text = ""
				var_102_1._control.campaign_layer.limit_type.text.text = ""
				var_102_1._control.ship_empty.add_ship_btn.image.raycastTarget = false
			end
		end

		self._control.left_widget.rankable_layout_group.rankableLayoutGroup.onItemExchange:RemoveAllListeners()
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup.onItemExchange:AddListener(function(arg_103_0, arg_103_1)
			self._mist_team_data = var_0_3:get_mist_combat_info().members
			self._mist_team_data[arg_103_0] = self._mist_team_data[arg_103_1]
			self._mist_team_data[arg_103_1] = self._mist_team_data[arg_103_0]
			self._ship_item_list[arg_103_0] = self._ship_item_list[arg_103_1]
			self._ship_item_list[arg_103_1] = self._ship_item_list[arg_103_0]
		end)
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup.onEndDrag:RemoveAllListeners()
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup.onEndDrag:AddListener(function()
			if #self._mist_team_data < 2 then
				return
			end

			var_0_3:req_MistTeamSaveReq(self._mist_team_data)
		end)
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup:Init()
	end

	function arg_1_0:__init_ocean_attack_prepare(arg_105_1)
		local var_105_0 = var_0_3:get_ocean_team_data() or {}

		self._ocean_team_data = {}
		self._team_detail_data = {}

		for iter_105_0 = 1, var_0_17 do
			local var_105_1 = self._ship_item_list[iter_105_0] or self:loadUI("fight_prepare_ship_item")

			var_105_1._panel.transform:SetParent(self._control.left_widget.rankable_layout_group.rectTransform, false)

			if var_105_0[iter_105_0] and var_0_3:find_character_by_id(var_105_0[iter_105_0]) then
				local var_105_2 = var_0_3:find_character_by_id(var_105_0[iter_105_0])
				local var_105_3 = var_0_6.find_object_by_cid(var_105_2.cid)

				var_105_1:show(iter_105_0, arg_105_1, var_105_2, var_105_3, self._team_type)

				self._ocean_team_data[#self._ocean_team_data + 1] = var_105_2.id
				self._team_detail_data[#self._team_detail_data + 1] = {
					data = var_0_5.little_clone(var_105_2),
					config = var_0_5.little_clone(var_105_3)
				}
			else
				var_105_1:show(iter_105_0, arg_105_1, nil, nil, self._team_type)
			end

			self._ship_item_list[iter_105_0] = var_105_1
		end

		self._control.left_widget.rankable_layout_group.rankableLayoutGroup.onItemExchange:RemoveAllListeners()
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup.onItemExchange:AddListener(function(arg_106_0, arg_106_1)
			self._ocean_team_data[arg_106_0] = self._ocean_team_data[arg_106_1]
			self._ocean_team_data[arg_106_1] = self._ocean_team_data[arg_106_0]
			self._ship_item_list[arg_106_0] = self._ship_item_list[arg_106_1]
			self._ship_item_list[arg_106_1] = self._ship_item_list[arg_106_0]
		end)
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup.onEndDrag:RemoveAllListeners()
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup.onEndDrag:AddListener(function()
			if #self._ocean_team_data < 2 then
				return
			end

			var_0_3:req_OceanSaveTeamReq(self._ocean_team_data)
		end)
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup:Init()
	end

	function arg_1_0:__init_strike_prepare(arg_108_1)
		self._strike_team_data = var_0_3:get_strike_team_data()

		local var_108_0 = self._strike_team_data or {}

		self._solid_team_data = {}
		self._team_detail_data = {}

		for iter_108_0 = 1, var_0_17 do
			local var_108_1 = self._ship_item_list[iter_108_0] or self:loadUI("fight_prepare_ship_item")

			var_108_1._panel.transform:SetParent(self._control.left_widget.rankable_layout_group.rectTransform, false)

			if var_108_0[iter_108_0] and var_0_3:find_character_by_id(var_108_0[iter_108_0]) then
				local var_108_2 = var_0_3:find_character_by_id(var_108_0[iter_108_0])
				local var_108_3 = var_0_6.find_object_by_cid(var_108_2.cid)

				var_108_1:show(iter_108_0, arg_108_1, var_108_2, var_108_3, self._team_type)
				var_108_1:show_strike_forbidden(false)

				self._solid_team_data[#self._solid_team_data + 1] = var_108_2.id
				self._team_detail_data[#self._team_detail_data + 1] = {
					data = var_0_5.little_clone(var_108_2),
					config = var_0_5.little_clone(var_108_3)
				}
			else
				var_108_1:show(iter_108_0, arg_108_1, nil, nil, self._team_type)
			end

			self._ship_item_list[iter_108_0] = var_108_1
		end

		for iter_108_1, iter_108_2 in pairs(self._current_strike_buffs) do
			if not iter_108_2.replace then
				local var_108_5

				if iter_108_2.id < 1000 then
					var_108_5 = var_0_31.find_object_by_id(iter_108_2.id)

					if iter_108_2.state then
						var_108_5 = var_0_31.find_object_by_id(iter_108_2.change_id)
					end
				else
					var_108_5 = var_0_30.find_object_by_id(iter_108_2.id)

					if iter_108_2.state then
						var_108_5 = var_0_30.find_object_by_id(iter_108_2.change_id)
					end
				end

				self:refresh_strike_info_list()

				for iter_108_3, iter_108_4 in pairs(var_108_5.effect) do
					if iter_108_4.type == 38 then
						local var_108_6 = var_0_3:get_strike_point_info().use_ship or {}

						if next(var_108_6) then
							for iter_108_5, iter_108_6 in pairs(self._strike_team_data) do
								for iter_108_7, iter_108_8 in pairs(var_108_6) do
									if iter_108_6 == iter_108_8 then
										self._ship_item_list[iter_108_5]:show_strike_forbidden(true)

										break
									end
								end
							end
						end

						break
					end

					self._attr_buff_list = {}

					local var_108_7 = lx.clone_table(self._current_strike_buffs)

					for iter_108_9, iter_108_10 in pairs(var_108_7) do
						if iter_108_10.replace then
							table.remove(var_108_7, iter_108_9)
						end
					end

					for iter_108_11, iter_108_12 in pairs(var_108_7) do
						local var_108_8

						if iter_108_12.id < 1000 then
							var_108_8 = var_0_31.find_object_by_id(iter_108_12.id)

							if iter_108_12.state then
								var_108_8 = var_0_31.find_object_by_id(iter_108_12.change_id)
							end
						else
							var_108_8 = var_0_30.find_object_by_id(iter_108_12.id)

							if iter_108_12.state then
								var_108_8 = var_0_30.find_object_by_id(iter_108_12.change_id)
							end
						end

						for iter_108_13, iter_108_14 in pairs(var_108_8.effect) do
							self:select_ship_attrs_by_pvebuff(self._strike_team_data, iter_108_14, self._fight_prepare_type, true)
						end
					end

					local var_108_9, var_108_10 = self:select_ship_by_pvebuff(self._strike_team_data, iter_108_4, self._fight_prepare_type)

					if not var_108_9 then
						if (iter_108_4.type == 1 or iter_108_4.type == 3 or iter_108_4.type == 5) and var_108_10 then
							for iter_108_15, iter_108_16 in pairs(self._strike_team_data) do
								for iter_108_17, iter_108_18 in pairs(var_108_10) do
									if iter_108_16 == iter_108_18 then
										self._ship_item_list[iter_108_15]:show_strike_forbidden(true)

										break
									end
								end
							end
						elseif iter_108_4.type == 26 and var_108_10 then
							for iter_108_19, iter_108_20 in pairs(self._strike_team_data) do
								local var_108_11 = false

								for iter_108_21, iter_108_22 in pairs(var_108_10) do
									if iter_108_20 == iter_108_22 then
										var_108_11 = true

										break
									end
								end

								if not var_108_11 then
									self._ship_item_list[iter_108_19]:show_strike_forbidden(true)
								end
							end
						end

						if iter_108_4.type == 3 and iter_108_4.num == 0 then
							for iter_108_23, iter_108_24 in pairs(self._strike_team_data) do
								if var_0_6.find_object_by_cid(var_0_3:find_character_by_id(iter_108_24).cid).country == iter_108_4.country then
									self._ship_item_list[iter_108_23]:show_strike_forbidden(true)
								end
							end
						end
					end
				end
			end
		end

		self._control.left_widget.rankable_layout_group.rankableLayoutGroup.onItemExchange:RemoveAllListeners()
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup.onItemExchange:AddListener(function(arg_109_0, arg_109_1)
			self._solid_team_data[arg_109_0] = self._solid_team_data[arg_109_1]
			self._solid_team_data[arg_109_1] = self._solid_team_data[arg_109_0]
			self._ship_item_list[arg_109_0] = self._ship_item_list[arg_109_1]
			self._ship_item_list[arg_109_1] = self._ship_item_list[arg_109_0]
		end)
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup.onEndDrag:RemoveAllListeners()
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup.onEndDrag:AddListener(function()
			if #self._solid_team_data < 2 then
				return
			end

			var_0_3:req_SolidSaveTeamReq(self._solid_team_data)
		end)

		if self.is_already_init then
			self._control.left_widget.rankable_layout_group.rankableLayoutGroup:Init()

			self.is_already_init = false
		end
	end

	function arg_1_0:__get_strike_team_data_for_buff()
		if self._team_detail_data and next(self._team_detail_data) then
			local var_111_0 = {}

			for iter_111_0, iter_111_1 in pairs(self._team_detail_data) do
				var_111_0[iter_111_0] = iter_111_1.data.id
			end

			return var_111_0
		end

		return self._strike_team_data or {}
	end

	function arg_1_0:__build_strike_speed_radar_lists()
		local var_112_0 = {}
		local var_112_1 = {}

		if not self._team_detail_data then
			return var_112_0, var_112_1
		end

		for iter_112_0, iter_112_1 in pairs(self._team_detail_data) do
			local var_112_2 = var_0_5:get_ship_attr(iter_112_1.data, iter_112_1.config)

			if var_112_2 then
				var_112_0[iter_112_0] = {
					add_by_skill = false,
					add_by_strike_buff = false,
					speed_num = var_112_2.speed
				}
				var_112_1[iter_112_0] = {
					add_by_strike_buff = false,
					radar_num = var_112_2.radar
				}
			end
		end

		for iter_112_2, iter_112_3 in pairs(self._team_detail_data) do
			self:__add_speed_by_buff_skill(self._team_detail_data, var_112_0, var_112_1, iter_112_2)
		end

		return var_112_0, var_112_1
	end

	function arg_1_0:__get_strike_buffs_for_check()
		local var_113_1 = lx.clone_table(self._current_strike_buffs or {})

		for iter_113_0, iter_113_1 in pairs(var_113_1) do
			if iter_113_1.replace then
				table.remove(var_113_1, iter_113_0)
			end
		end

		return var_113_1
	end

	function arg_1_0:__get_strike_buffs_for_panel_and_check()
		local var_114_0 = self:__get_strike_buffs_for_check()

		self:__append_strike_weather_buff_to_list(var_114_0)

		return var_114_0
	end

	function arg_1_0:__calc_strike_team_radar_total(arg_115_1)
		local var_115_0, var_115_1 = self:__build_strike_speed_radar_lists()

		if arg_115_1 == nil then
			arg_115_1 = self:__get_strike_buffs_for_panel_and_check()
		end

		if arg_115_1 and next(arg_115_1) then
			self:__apply_strike_buff_speed_radar_to_lists(var_115_0, var_115_1, arg_115_1)
		end

		local var_115_2 = 0

		for iter_115_0, iter_115_1 in pairs(var_115_1) do
			var_115_2 = var_115_2 + iter_115_1.radar_num
		end

		return var_115_2
	end

	function arg_1_0:__calc_strike_team_speed_total(arg_116_1)
		local var_116_0, var_116_1 = self:__build_strike_speed_radar_lists()

		if arg_116_1 == nil then
			arg_116_1 = self:__get_strike_buffs_for_panel_and_check()
		end

		if arg_116_1 and next(arg_116_1) then
			self:__apply_strike_buff_speed_radar_to_lists(var_116_0, var_116_1, arg_116_1)
		end

		local var_116_2 = 0

		for iter_116_0, iter_116_1 in pairs(var_116_0) do
			var_116_2 = var_116_2 + iter_116_1.speed_num
		end

		return var_116_2
	end

	function arg_1_0:__calc_strike_team_average_speed(arg_117_1)
		local var_117_0, var_117_1 = self:__build_strike_speed_radar_lists()

		if arg_117_1 == nil then
			arg_117_1 = self:__get_strike_buffs_for_panel_and_check()
		end

		if arg_117_1 and next(arg_117_1) then
			self:__apply_strike_buff_speed_radar_to_lists(var_117_0, var_117_1, arg_117_1)
		end

		if not var_117_0 or #var_117_0 == 0 then
			return 0, var_117_0
		end

		local var_117_2 = 0

		for iter_117_0, iter_117_1 in pairs(var_117_0) do
			var_117_2 = var_117_2 + iter_117_1.speed_num
		end

		return var_117_2 / #var_117_0, var_117_0
	end

	function arg_1_0:__rebuild_strike_attr_buff_list()
		local var_118_1 = lx.clone_table(self._current_strike_buffs or {})

		for iter_118_0, iter_118_1 in pairs(var_118_1) do
			if iter_118_1.replace then
				table.remove(var_118_1, iter_118_0)
			end
		end

		local var_118_2 = self:__get_strike_team_data_for_buff()

		self._attr_buff_list = {}
		self._attr_by_pre_effect_list = {}

		self:select_ship_attr_by_pre_effect(var_118_2)

		for iter_118_2, iter_118_3 in pairs(var_118_1) do
			if iter_118_3.id >= 1000 then
				local var_118_3 = var_0_30.find_object_by_id(iter_118_3.id)

				if iter_118_3.state then
					var_118_3 = var_0_30.find_object_by_id(iter_118_3.change_id)
				end

				if var_118_3 and var_118_3.effect then
					for iter_118_4, iter_118_5 in pairs(var_118_3.effect) do
						self:select_ship_attrs_by_pvebuff(var_118_2, iter_118_5, self._fight_prepare_type, true)
					end
				end
			end
		end

		return var_118_1
	end

	function arg_1_0:__get_strike_weather_buff_entry()
		if not self._go_to_map_id then
			return nil
		end

		local var_119_0 = var_0_29.find_object_by_id(self._go_to_map_id)

		if not var_119_0 or var_119_0.weather2 == 0 then
			return nil
		end

		local var_119_1 = var_0_3:get_strike_data_by_level(self._go_to_map_id)

		if var_119_1 then
			if (var_119_1.score or 0) < var_119_0.hard_score then
				return nil
			end
		end

		return {
			score = 0,
			id = var_119_0.weather2
		}
	end

	function arg_1_0:__append_strike_weather_buff_to_list(arg_120_1)
		local var_120_0 = self:__get_strike_weather_buff_entry()

		if not var_120_0 or not arg_120_1 then
			return
		end

		for iter_120_0, iter_120_1 in pairs(arg_120_1) do
			if iter_120_1.id == var_120_0.id then
				return
			end
		end

		var_0_14(arg_120_1, 1, var_120_0)
	end

	function arg_1_0:change_strike_buff_color()
		local var_121_0 = {}
		local var_121_1 = self:__rebuild_strike_attr_buff_list()

		self:__append_strike_weather_buff_to_list(var_121_1)

		local var_121_2 = self:__get_strike_team_data_for_buff()

		for iter_121_0, iter_121_1 in pairs(var_121_1) do
			if not iter_121_1.replace then
				local var_121_3 = self:__get_strike_buff_data_by_buff_entry(iter_121_1)

				if var_121_3 then
					var_0_14(var_121_0, var_121_3.id, {
						self:__is_strike_buff_team_satisfy(var_121_3, var_121_2) and 1 or 0
					})
				end
			end
		end

		var_0_3:set_buff_item_color(var_121_0)
	end

	function arg_1_0:__refresh_strike_buff_item_display()
		self:change_strike_buff_color()

		if self._strike_reusable_cell then
			self._strike_reusable_cell._already_do = false

			self._strike_reusable_cell:update()
		end
	end

	function arg_1_0:__init_war_concerto_play_prepare(arg_123_1)
		local var_123_0 = var_0_3:get_fifth_team_data() or {}

		self._war_concerto_team_data = {}

		for iter_123_0 = 1, var_0_17 do
			local var_123_1 = self._ship_item_list[iter_123_0] or self:loadUI("fight_prepare_ship_item")

			var_123_1._panel.transform:SetParent(self._control.left_widget.rankable_layout_group.rectTransform, false)

			if var_123_0[iter_123_0] then
				local var_123_2, var_123_3, var_123_4 = var_0_3:get_fake_ship_data(var_123_0[iter_123_0])

				var_123_1:show(iter_123_0, arg_123_1, var_123_2, var_123_3, self._team_type)

				self._war_concerto_team_data[#self._war_concerto_team_data + 1] = var_123_0[iter_123_0]
				self._team_detail_data[#self._team_detail_data + 1] = {
					data = var_0_5.little_clone(var_123_2),
					config = var_0_5.little_clone(var_123_3),
					attrs = var_123_4
				}
			else
				var_123_1:show(iter_123_0, arg_123_1, nil, nil, self._team_type)
			end

			self._ship_item_list[iter_123_0] = var_123_1
		end

		self._control.left_widget.rankable_layout_group.rankableLayoutGroup.onItemExchange:RemoveAllListeners()
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup.onItemExchange:AddListener(function(arg_124_0, arg_124_1)
			self._war_concerto_team_data[arg_124_0] = self._war_concerto_team_data[arg_124_1]
			self._war_concerto_team_data[arg_124_1] = self._war_concerto_team_data[arg_124_0]
			self._ship_item_list[arg_124_0] = self._ship_item_list[arg_124_1]
			self._ship_item_list[arg_124_1] = self._ship_item_list[arg_124_0]
		end)
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup.onEndDrag:RemoveAllListeners()
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup.onEndDrag:AddListener(function()
			if #self._war_concerto_team_data < 2 then
				return
			end

			var_0_3:req_RecreationTeamSaveReq(self._war_concerto_team_data)
		end)
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup:Init()
	end

	function arg_1_0:__init_abyss_model_team_list(arg_126_1, arg_126_2)
		local var_126_0
		local var_126_1 = false

		if arg_126_2 == var_0_4.team_type.abyss_owner_team then
			var_126_0 = var_0_3:get_normal_team_info()
			var_126_1 = true
		else
			var_126_0 = var_0_3:get_abyss_team_info()
		end

		local var_126_2 = var_126_0

		self._team_data = {}
		self._team_detail_data = {}

		for iter_126_0 = 1, var_0_17 do
			local var_126_3 = self._ship_item_list[iter_126_0] or self:loadUI("fight_prepare_ship_item")

			var_126_3._panel.transform:SetParent(self._control.left_widget.rankable_layout_group.rectTransform, false)

			if var_126_1 then
				if var_126_2[iter_126_0] and var_0_3:find_character_by_id(var_126_2[iter_126_0]) and var_126_1 then
					local var_126_4 = var_0_3:find_character_by_id(var_126_2[iter_126_0])
					local var_126_5 = var_0_6.find_object_by_cid(var_126_4.cid)

					var_126_3:show(iter_126_0, arg_126_1, var_126_4, var_126_5, self._team_type)

					self._team_data[#self._team_data + 1] = var_126_4.id
					self._team_detail_data[#self._team_detail_data + 1] = {
						data = var_0_5.little_clone(var_126_4),
						config = var_0_5.little_clone(var_126_5)
					}
				else
					var_126_3:show(iter_126_0, arg_126_1, nil, nil, self._team_type)
				end
			elseif var_126_2[iter_126_0] and var_0_3:find_abyss_character_by_id(var_126_2[iter_126_0]) then
				local var_126_6 = var_0_3:find_abyss_character_by_id(var_126_2[iter_126_0])
				local var_126_7 = var_0_6.find_object_by_cid(var_126_6.cid)

				var_126_3:show(iter_126_0, arg_126_1, var_126_6, var_126_7, self._team_type)

				self._team_data[#self._team_data + 1] = var_126_6.id
				self._team_detail_data[#self._team_detail_data + 1] = {
					data = var_0_5.little_clone(var_126_6),
					config = var_0_5.little_clone(var_126_7)
				}
			else
				var_126_3:show(iter_126_0, arg_126_1, nil, nil, self._team_type)
			end

			self._ship_item_list[iter_126_0] = var_126_3
		end

		self._control.left_widget.rankable_layout_group.rankableLayoutGroup.onItemExchange:RemoveAllListeners()
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup.onItemExchange:AddListener(function(arg_127_0, arg_127_1)
			self._team_data[arg_127_0], self._team_data[arg_127_1] = self._team_data[arg_127_1], self._team_data[arg_127_0]
			self._ship_item_list[arg_127_0], self._ship_item_list[arg_127_1] = self._ship_item_list[arg_127_1], self._ship_item_list[arg_127_0]
		end)
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup.onEndDrag:RemoveAllListeners()
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup.onEndDrag:AddListener(function()
			if #self._team_data < 2 then
				return
			end

			if self._team_type == var_0_4.team_type.abyss_owner_team then
				var_0_3:req_AbyssSaveTeamReq(self._team_data)
			else
				var_0_3:req_AbyssAbyssSaveTeamReq(self._team_data)
			end
		end)
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup:Init()
	end

	function arg_1_0:update_abyss_model_team_list(arg_129_1, arg_129_2)
		local var_129_0
		local var_129_1 = false

		if arg_129_2 == var_0_4.team_type.abyss_owner_team then
			var_129_0 = var_0_3:get_normal_team_info()
			var_129_1 = true
		else
			var_129_0 = var_0_3:get_abyss_team_info()
		end

		self._team_data = {}
		self._team_detail_data = {}

		for iter_129_0 = 1, var_0_17 do
			local var_129_3 = self._ship_item_list[iter_129_0]

			if not self._ship_item_list[iter_129_0] then
				var_129_3 = self:loadUI("fight_prepare_ship_item")

				var_129_3._panel.transform:SetParent(self._control.left_widget.rankable_layout_group.rectTransform, false)
			end

			local var_129_4 = var_129_0[iter_129_0]

			if var_129_1 then
				if var_129_0 and var_129_4 then
					local var_129_5 = var_0_3:find_character_by_id(var_129_4)
					local var_129_6 = var_0_6.find_object_by_cid(var_129_5.cid)

					var_129_3:show(iter_129_0, arg_129_1, var_129_5, var_129_6, self._team_type)
					var_0_14(self._team_data, var_129_5.id)
					var_0_14(self._team_detail_data, {
						data = var_0_5.little_clone(var_129_5),
						config = var_0_5.little_clone(var_129_6)
					})
				else
					var_129_3:show(iter_129_0, arg_129_1, nil, nil, self._team_type)
				end
			elseif var_129_0 and var_129_4 then
				local var_129_7 = var_0_3:find_abyss_character_by_id(var_129_4)
				local var_129_8 = var_0_6.find_object_by_cid(var_129_7.cid)

				var_129_3:show(iter_129_0, arg_129_1, var_129_7, var_129_8, self._team_type)
				var_0_14(self._team_data, var_129_7.id)
				var_0_14(self._team_detail_data, {
					data = var_0_5.little_clone(var_129_7),
					config = var_0_5.little_clone(var_129_8)
				})
			else
				var_129_3:show(iter_129_0, arg_129_1, nil, nil, self._team_type)
			end

			self._ship_item_list[iter_129_0] = var_129_3
		end

		self._control.left_widget.rankable_layout_group.rankableLayoutGroup:ReSetBoundaryPosXList()

		if arg_129_2 == var_0_4.team_type.abyss_owner_team then
			self:__set_total_props_panel_data()
			self:__set_total_supply_panel_data()
			self:__set_total_repair_panel_data()
		end
	end

	function arg_1_0:__update_prepare_item_list(arg_130_1, arg_130_2)
		self._team_data = {}
		self._team_detail_data = {}
		self._current_team_index = arg_130_2

		if not self._current_team_index then
			arg_130_1 = self.content_type
			arg_130_2 = self._current_team_index or 1
		end

		self._team_group_data = var_0_3:get_team_group(self._team_type)

		if self._team_type == var_0_4.team_type.strike_map_team then
			self._team_group_data = var_0_3:get_team_group(1)
		end

		if self._team_group_data and self._team_group_data[self._current_team_index] then
			-- block empty
		else
			return
		end

		for iter_130_0 = 1, var_0_17 do
			local var_130_1 = self._ship_item_list[iter_130_0]

			if not self._ship_item_list[iter_130_0] then
				var_130_1 = self:loadUI("fight_prepare_ship_item")

				var_130_1._panel.transform:SetParent(self._control.left_widget.rankable_layout_group.rectTransform, false)
			end

			if not self._team_group_data[self._current_team_index] and not self._team_group_data[self._current_team_index].members then
				return
			end

			local var_130_2 = self._team_group_data[self._current_team_index].members[iter_130_0]

			if self._team_group_data[self._current_team_index] and var_130_2 then
				local var_130_3 = var_0_3:find_character_by_id(var_130_2)
				local var_130_4 = var_0_6.find_object_by_cid(var_130_3.cid)

				if self._fight_prepare_type == var_0_4.fight_type.tower_fight then
					local var_130_5 = self:get_all_charactor_info_affected_from_tower_by_charactors_config({
						var_130_4
					})
				end

				if self._fight_prepare_type == var_0_4.fight_type.war_concerto then
					local var_130_7 = var_0_3:get_concerto_info()
					local var_130_8 = {}

					if var_130_7 then
						var_130_8 = var_130_7.station or {}
					end

					var_130_1._is_state_station = false

					for iter_130_1, iter_130_2 in pairs(var_130_8) do
						if iter_130_2.team == arg_130_2 then
							var_130_1._is_state_station = true

							break
						else
							var_130_1._is_state_station = nil
						end
					end
				end

				var_130_1:show(iter_130_0, arg_130_1, var_130_3, var_130_4, self._team_type)

				self._team_data[#self._team_data + 1] = var_130_3.id
				self._team_detail_data[#self._team_detail_data + 1] = {
					data = var_0_5.little_clone(var_130_3),
					config = var_0_5.little_clone(var_130_4)
				}
			else
				var_130_1:show(iter_130_0, arg_130_1, nil, nil, self._team_type)
			end

			self._ship_item_list[iter_130_0] = var_130_1
		end
	end

	function arg_1_0:__update_sixth_item_list(arg_131_1)
		self._team_data = {}
		self._team_detail_data = {}

		local var_131_0 = var_0_3:get_sixth_combat_info().members or {}

		for iter_131_0 = 1, var_0_17 do
			local var_131_1 = self._ship_item_list[iter_131_0]

			if not self._ship_item_list[iter_131_0] then
				var_131_1 = self:loadUI("fight_prepare_ship_item")

				var_131_1._panel.transform:SetParent(self._control.left_widget.rankable_layout_group.rectTransform, false)
			end

			local var_131_2 = var_131_0[iter_131_0]

			if var_131_0 and var_131_2 then
				local var_131_3 = var_0_3:find_character_by_id(var_131_2)
				local var_131_4 = var_0_6.find_object_by_cid(var_131_3.cid)

				var_131_1:show(iter_131_0, arg_131_1, var_131_3, var_131_4, self._team_type)

				self._team_data[#self._team_data + 1] = var_131_3.id
				self._team_detail_data[#self._team_detail_data + 1] = {
					data = var_0_5.little_clone(var_131_3),
					config = var_0_5.little_clone(var_131_4)
				}

				var_0_3:set_sixth_prepare_team_detail_data(self._team_detail_data)
			else
				var_131_1:show(iter_131_0, arg_131_1, nil, nil, self._team_type)
			end

			self._ship_item_list[iter_131_0] = var_131_1
		end
	end

	function arg_1_0:__update_mist_item_list(arg_132_1)
		self._team_data = {}
		self._team_detail_data = {}

		local var_132_0 = var_0_3:get_mist_combat_info().members or {}

		for iter_132_0 = 1, var_0_17 do
			local var_132_1 = self._ship_item_list[iter_132_0]

			if not self._ship_item_list[iter_132_0] then
				var_132_1 = self:loadUI("fight_prepare_ship_item")

				var_132_1._panel.transform:SetParent(self._control.left_widget.rankable_layout_group.rectTransform, false)
			end

			local var_132_2 = var_132_0[iter_132_0]

			if var_132_0 and var_132_2 then
				local var_132_3 = gameconfig.pve_mist_ship_config.find_object_by_id(var_132_2)

				var_132_1:show(iter_132_0, arg_132_1, var_132_3, var_132_3, self._team_type)

				self._team_data[#self._team_data + 1] = var_132_2
				self._team_detail_data[#self._team_detail_data + 1] = {
					data = var_0_5.little_clone(ship_data),
					config = var_0_5.little_clone(var_132_3)
				}

				var_0_3:set_mist_prepare_team_detail_data(self._team_detail_data)
			else
				var_132_1:show(iter_132_0, arg_132_1, nil, nil, self._team_type)
			end

			self._ship_item_list[iter_132_0] = var_132_1
		end
	end

	function arg_1_0:__update_strike_item_list(arg_133_1)
		self._solid_team_data = {}
		self._team_detail_data = {}
		self._strike_team_data = var_0_3:get_strike_team_data()

		local var_133_0 = self._strike_team_data or {}

		for iter_133_0 = 1, var_0_17 do
			local var_133_1 = self._ship_item_list[iter_133_0]

			if not self._ship_item_list[iter_133_0] then
				var_133_1 = self:loadUI("fight_prepare_ship_item")

				var_133_1._panel.transform:SetParent(self._control.left_widget.rankable_layout_group.rectTransform, false)
			end

			local var_133_2 = var_133_0[iter_133_0]

			if var_133_0 and var_133_2 then
				local var_133_3 = var_0_3:find_character_by_id(var_133_2)
				local var_133_4 = var_0_6.find_object_by_cid(var_133_3.cid)

				var_133_1:show(iter_133_0, arg_133_1, var_133_3, var_133_4, self._team_type)
				var_133_1:show_strike_forbidden(false)

				self._solid_team_data[#self._solid_team_data + 1] = var_133_3.id
				self._team_detail_data[#self._team_detail_data + 1] = {
					data = var_0_5.little_clone(var_133_3),
					config = var_0_5.little_clone(var_133_4)
				}
			else
				var_133_1:show(iter_133_0, arg_133_1, nil, nil, self._team_type)
			end

			self._ship_item_list[iter_133_0] = var_133_1
		end

		self:set_strike_panel_mask()
	end

	function arg_1_0:set_strike_panel_mask()
		local var_134_1 = lx.clone_table(self._current_strike_buffs or {})

		self:__append_strike_weather_buff_to_list(var_134_1)

		for iter_134_0, iter_134_1 in pairs(var_134_1) do
			if not iter_134_1.replace then
				local var_134_2 = self:__get_strike_buff_data_by_buff_entry(iter_134_1)

				if var_134_2 and var_134_2.effect then
					for iter_134_2, iter_134_3 in pairs(var_134_2.effect) do
						if iter_134_3.type == 38 then
							local var_134_3 = var_0_3:get_strike_point_info().use_ship or {}

							if next(var_134_3) then
								for iter_134_4, iter_134_5 in pairs(self._strike_team_data) do
									for iter_134_6, iter_134_7 in pairs(var_134_3) do
										if iter_134_5 == iter_134_7 then
											self._ship_item_list[iter_134_4]:show_strike_forbidden(true)

											break
										end
									end
								end
							end

							break
						end

						if self:__is_strike_buff_fight_check_effect(iter_134_3) then
							local var_134_4
							local var_134_5

							if iter_134_3.type == 12 and iter_134_3.num4 == 11 then
								var_134_4 = self:__calc_strike_team_radar_total() > iter_134_3.num
							elseif iter_134_3.type == 12 and iter_134_3.num4 == 10 then
								var_134_4 = self:__calc_strike_team_speed_total() > iter_134_3.num
							elseif iter_134_3.type == 13 and iter_134_3.num4 == 10 then
								var_134_4 = self:__calc_strike_team_average_speed() <= iter_134_3.num
							elseif iter_134_3.type == 14 and iter_134_3.num4 == 10 then
								var_134_4 = self:__calc_strike_team_average_speed() > iter_134_3.num
							else
								var_134_4, var_134_5 = self:select_ship_by_pvebuff(self._strike_team_data, iter_134_3, self._fight_prepare_type, true)
							end

							if not var_134_4 then
								if (iter_134_3.type == 1 or iter_134_3.type == 3 or iter_134_3.type == 5) and var_134_5 then
									for iter_134_8, iter_134_9 in pairs(self._strike_team_data) do
										for iter_134_10, iter_134_11 in pairs(var_134_5) do
											if iter_134_9 == iter_134_11 then
												self._ship_item_list[iter_134_8]:show_strike_forbidden(true)

												break
											end
										end
									end
								elseif iter_134_3.type == 26 and var_134_5 then
									for iter_134_12, iter_134_13 in pairs(self._strike_team_data) do
										local var_134_6 = false

										for iter_134_14, iter_134_15 in pairs(var_134_5) do
											if iter_134_13 == iter_134_15 then
												var_134_6 = true

												break
											end
										end

										if not var_134_6 then
											self._ship_item_list[iter_134_12]:show_strike_forbidden(true)
										end
									end

									if iter_134_3.type == 3 and iter_134_3.num == 0 then
										for iter_134_16, iter_134_17 in pairs(self._strike_team_data) do
											if var_0_6.find_object_by_cid(var_0_3:find_character_by_id(iter_134_17).cid).country == iter_134_3.country then
												self._ship_item_list[iter_134_16]:show_strike_forbidden(true)
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	function arg_1_0:__update_ocean_item_list(arg_135_1)
		self._team_data = {}
		self._team_detail_data = {}
		self._ocean_team_data = var_0_3:get_ocean_team_data()

		local var_135_0 = self._ocean_team_data or {}
		local var_135_1 = var_0_2:getInstance("ocean_cia") or var_0_2:createInstance("ocean_cia")

		for iter_135_0 = 1, var_0_17 do
			local var_135_2 = self._ship_item_list[iter_135_0]

			if not self._ship_item_list[iter_135_0] then
				var_135_2 = self:loadUI("fight_prepare_ship_item")

				var_135_2._panel.transform:SetParent(self._control.left_widget.rankable_layout_group.rectTransform, false)
			end

			local var_135_3 = var_135_0[iter_135_0]

			if var_135_0 and var_135_3 then
				local var_135_4 = var_0_3:find_character_by_id(var_135_3)
				local var_135_5 = var_0_6.find_object_by_cid(var_135_4.cid)

				var_135_2:show(iter_135_0, arg_135_1, var_135_4, var_135_5, self._team_type)

				self._team_data[#self._team_data + 1] = var_135_4.id
				self._team_detail_data[#self._team_detail_data + 1] = {
					data = var_0_5.little_clone(var_135_4),
					config = var_0_5.little_clone(var_135_5)
				}
			else
				var_135_2:show(iter_135_0, arg_135_1, nil, nil, self._team_type)
			end

			self._ship_item_list[iter_135_0] = var_135_2

			self:update_ocean_fight(var_135_1, var_0_3:get_ocean_all_buff_for_fight_list(false), (var_0_3:get_ocean_all_buff_for_fight_list(true)))
		end
	end

	function arg_1_0:__update_concerto_item_list(arg_136_1)
		self._war_concerto_team_data = {}
		self._team_detail_data = {}

		local var_136_0 = var_0_3:get_fifth_team_data() or {}

		for iter_136_0 = 1, var_0_17 do
			local var_136_1 = self._ship_item_list[iter_136_0]

			if not self._ship_item_list[iter_136_0] then
				var_136_1 = self:loadUI("fight_prepare_ship_item")

				var_136_1._panel.transform:SetParent(self._control.left_widget.rankable_layout_group.rectTransform, false)
			end

			local var_136_2 = var_136_0[iter_136_0]

			if var_136_0 and var_136_2 then
				local var_136_3, var_136_4, var_136_5 = var_0_3:get_fake_ship_data(var_136_2)

				var_136_1:show(iter_136_0, arg_136_1, var_136_3, var_136_4, self._team_type)

				self._war_concerto_team_data[#self._war_concerto_team_data + 1] = var_136_2
				self._team_detail_data[#self._team_detail_data + 1] = {
					data = var_0_5.little_clone(var_136_3),
					config = var_0_5.little_clone(var_136_4),
					attrs = var_136_5
				}
			else
				var_136_1:show(iter_136_0, arg_136_1, nil, nil, self._team_type)
			end

			self._ship_item_list[iter_136_0] = var_136_1
		end
	end

	function arg_1_0:__update_campaign_prepare()
		self._team_detail_data = {}

		local var_137_0 = var_0_3:get_campaign_data(self._go_to_map_id)

		for iter_137_0 = 1, var_0_17 do
			local var_137_1 = self._ship_item_list[iter_137_0]

			if not self._ship_item_list[iter_137_0] then
				var_137_1 = self:loadUI("fight_prepare_ship_item")

				var_137_1._panel.transform:SetParent(self._control.left_widget.rankable_layout_group.rectTransform, false)
			end

			local var_137_2

			if var_137_0.info and var_137_0.info.members then
				var_137_2 = var_137_0.info.members and var_137_0.info.members[iter_137_0] or nil
			end

			if var_137_2 and var_137_2 ~= 0 then
				local var_137_3 = var_0_3:find_character_by_id(var_137_2)
				local var_137_4 = var_0_6.find_object_by_cid(var_137_3.cid)

				var_137_1:show(iter_137_0, self._current_content_type, var_137_3, var_137_4, self._team_type, self._go_to_map_id, self._campagion_data)

				self._team_data[#self._team_data + 1] = var_137_3.id
				self._team_detail_data[#self._team_detail_data + 1] = {
					data = var_0_5.little_clone(var_137_3),
					config = var_0_5.little_clone(var_137_4)
				}
			else
				var_137_1:show(iter_137_0, self._current_content_type, nil, nil, self._team_type, self._go_to_map_id, self._campagion_data)
			end

			var_137_1:set_active_rankable_layout_item(false)

			self._ship_item_list[iter_137_0] = var_137_1
		end
	end

	function arg_1_0:__save_campaign_all_info(arg_138_1)
		var_0_3:req_CampaignTeamSaveReq({
			id = self._go_to_map_id,
			members = arg_138_1
		})
	end

	function arg_1_0:__save_team_all_info(arg_139_1)
		if not self._team_group_data or not next(self._team_group_data) then
			return
		end

		local var_139_0

		if not self._current_team_index or not self._team_group_data[self._current_team_index] then
			do return end

			var_139_0 = {
				quick = true
			}
		end

		var_139_0.id = self._team_group_data[self._current_team_index].id
		var_139_0.members = arg_139_1

		var_0_3:req_TeamSave(var_139_0)
	end

	function arg_1_0:sava_campaign_error(arg_140_1)
		if arg_140_1 == 6 then
			var_0_35:show(var_0_1:getNowLang("nosameshipinteam2"))
		else
			var_0_35:show(var_0_36:get_err_msg(arg_140_1))
		end

		local var_140_0 = var_0_3:get_campaign_data(self._go_to_map_id)

		if var_140_0 and var_140_0.info and var_140_0.info.members then
			self._campagion_team_data = {}

			for iter_140_0 = 1, 6 do
				self._campagion_team_data[iter_140_0] = var_140_0.info.members[iter_140_0] and var_140_0.info.members[iter_140_0] or 0
			end
		else
			self._campagion_team_data = {
				0,
				0,
				0,
				0,
				0
			}
		end
	end

	function arg_1_0:save_campaign_teamdata(arg_141_1, arg_141_2)
		if not arg_141_2 or arg_141_2.is_exist then
			self._campagion_team_data[arg_141_1] = 0
		elseif self._campagion_team_data[arg_141_1] then
			local var_141_0 = false

			for iter_141_0, iter_141_1 in pairs(self._campagion_team_data) do
				if var_0_3:find_character_by_id(iter_141_1) == nil then
					local var_141_1

					for iter_141_2, iter_141_3 in pairs(self._campagion_team_data) do
						if iter_141_3 == arg_141_2.id then
							var_141_1 = false

							break
						end

						var_141_1 = true
					end

					if var_141_1 then
						self._campagion_team_data[arg_141_1] = arg_141_2.id
					end
				end

				if iter_141_1 ~= 0 then
					local var_141_2 = var_0_3:find_character_by_id(arg_141_2.id)
					local var_141_3 = var_0_3:find_character_by_id(iter_141_1)

					if var_141_2 and var_141_3 then
						local var_141_4 = var_0_6.find_object_by_cid(var_141_2.cid)
						local var_141_5 = var_0_6.find_object_by_cid(var_141_3.cid)

						if var_141_5 and (var_141_5.cid == var_141_4.cid or var_141_5.evo_cid == var_141_4.evo_cid) and arg_141_1 ~= iter_141_0 and not var_141_6 then
							self._campagion_team_data[arg_141_1] = 0

							var_0_35:show(var_0_1:getNowLang("nosameshipinteam"))

							return
						end

						if var_141_6 then
							self._campagion_team_data[arg_141_1] = arg_141_2.id
							self._campagion_team_data[iter_141_0] = self._campagion_team_data[arg_141_1]
							var_141_0 = true
						end
					elseif not var_141_2 then
						return
					elseif not var_141_3 then
						self._campagion_team_data[iter_141_0] = 0
					end
				end
			end

			if not var_141_0 then
				self._campagion_team_data[arg_141_1] = arg_141_2.id
			end
		else
			local var_141_8

			for iter_141_4, iter_141_5 in pairs(self._campagion_team_data) do
				local var_141_9 = var_0_6.find_object_by_cid(var_0_3:find_character_by_id(iter_141_5).cid)
				local var_141_12 = var_0_6.find_object_by_cid(var_0_3:find_character_by_id(arg_141_2.id).cid)
				local var_141_13 = (var_141_9.cid == var_141_12.cid or var_141_9.evo_cid == var_141_12.evo_cid) and not var_141_10

				if iter_141_5 ~= arg_141_2.id and var_141_13 then
					var_0_35:show(var_0_1:getNowLang("nosameshipinteam"))

					return
				elseif iter_141_5 == arg_141_2.id and var_141_13 then
					var_141_8 = iter_141_4
				end
			end

			if var_141_8 then
				self._campagion_team_data[var_141_8] = 0
			else
				self._campagion_team_data[arg_141_1] = 0
			end
		end

		var_0_3:req_CampaignTeamSaveReq({
			id = self._go_to_map_id,
			members = self._campagion_team_data
		})
	end

	function arg_1_0:save_sixth_single_info(arg_142_1, arg_142_2)
		self._sixth_team_data = var_0_3:get_sixth_combat_info().members

		if not arg_142_2 or arg_142_2.is_exist then
			var_0_13(self._sixth_team_data, arg_142_1)
		elseif self._sixth_team_data[arg_142_1] then
			local var_142_0 = false

			for iter_142_0, iter_142_1 in pairs(self._sixth_team_data) do
				if iter_142_1 == arg_142_2.id then
					self._sixth_team_data[arg_142_1] = arg_142_2.id
					self._sixth_team_data[iter_142_0] = self._sixth_team_data[arg_142_1]
					var_142_0 = true

					break
				end
			end

			if not var_142_0 then
				self._sixth_team_data[arg_142_1] = arg_142_2.id
			end
		else
			local var_142_1 = var_0_6.find_object_by_cid(var_0_3:find_character_by_id(arg_142_2.id).cid)
			local var_142_2

			for iter_142_2, iter_142_3 in pairs(self._sixth_team_data) do
				local var_142_3 = var_0_6.find_object_by_cid(var_0_3:find_character_by_id(iter_142_3).cid)
				local var_142_4 = var_142_3.cid == var_142_1.cid or var_142_3.evo_cid == var_142_1.evo_cid

				if iter_142_3 ~= arg_142_2.id and var_142_4 then
					var_0_35:show(var_0_1:getNowLang("nosameshipinteam"))

					return
				elseif iter_142_3 == arg_142_2.id and var_142_4 then
					var_142_2 = iter_142_2
				end
			end

			if var_142_2 then
				var_0_13(self._sixth_team_data, var_142_2)
			end

			var_0_14(self._sixth_team_data, arg_142_2.id)
		end

		var_0_3:req_SixthTeamSaveReq(self._sixth_team_data)
	end

	function arg_1_0:save_mist_single_info(arg_143_1, arg_143_2)
		self._mist_team_data = var_0_3:get_mist_combat_info().members

		if not arg_143_2 or arg_143_2.is_exist then
			var_0_13(self._mist_team_data, arg_143_1)
		elseif self._mist_team_data[arg_143_1] then
			local var_143_0 = false

			for iter_143_0, iter_143_1 in pairs(self._mist_team_data) do
				if iter_143_1 == arg_143_2.id then
					self._mist_team_data[arg_143_1] = arg_143_2.id
					self._mist_team_data[iter_143_0] = self._mist_team_data[arg_143_1]
					var_143_0 = true

					break
				end
			end

			if not var_143_0 then
				self._mist_team_data[arg_143_1] = arg_143_2.id
			end
		else
			local var_143_1 = gameconfig.pve_mist_ship_config.find_object_by_id(arg_143_2.id)
			local var_143_2

			for iter_143_2, iter_143_3 in pairs(self._mist_team_data) do
				local var_143_3 = gameconfig.pve_mist_ship_config.find_object_by_id(iter_143_3).id == var_143_1.id

				if iter_143_3 ~= arg_143_2.id and var_143_3 then
					var_0_35:show(var_0_1:getNowLang("nosameshipinteam"))

					return
				elseif iter_143_3 == arg_143_2.id and var_143_3 then
					var_143_2 = iter_143_2
				end
			end

			if var_143_2 then
				var_0_13(self._mist_team_data, var_143_2)
			end

			var_0_14(self._mist_team_data, arg_143_2.id)
		end

		var_0_3:req_MistTeamSaveReq(self._mist_team_data)
	end

	function arg_1_0:save_abyss_model_single_info(arg_144_1, arg_144_2)
		if self._team_type == var_0_4.team_type.abyss_owner_team then
			for iter_144_0, iter_144_1 in pairs(var_0_3:get_normal_team_info()) do
				self._team_data[iter_144_0] = iter_144_1
			end
		elseif self._team_type == var_0_4.team_type.abyss_team then
			for iter_144_2, iter_144_3 in pairs(var_0_3:get_abyss_team_info()) do
				self._team_data[iter_144_2] = iter_144_3
			end
		end

		if not arg_144_2 or arg_144_2.is_exist then
			self._team_data[arg_144_1] = nil
		else
			local var_144_0 = 0

			var_144_0 = self._team_type == var_0_4.team_type.abyss_owner_team and var_0_3:find_character_by_id(arg_144_2.id).cid or var_0_3:find_abyss_character_by_id(arg_144_2.id).cid

			local var_144_1 = var_0_6.find_object_by_cid(var_144_0)

			if self._team_data[arg_144_1] then
				local var_144_2 = false

				for iter_144_4, iter_144_5 in pairs(self._team_data) do
					local var_144_3 = 0

					var_144_3 = self._team_type == var_0_4.team_type.abyss_owner_team and var_0_3:find_character_by_id(iter_144_5).cid or var_0_3:find_abyss_character_by_id(iter_144_5).cid

					local var_144_4 = var_0_6.find_object_by_cid(var_144_3)

					if iter_144_4 == arg_144_1 and var_144_3 == var_144_0 and iter_144_5 ~= arg_144_2.id and (var_144_4.cid == var_144_1.cid or var_144_4.evo_cid == var_144_1.evo_cid) then
						var_0_35:show(var_0_1:getNowLang("nosameshipinteam"))

						return
					elseif iter_144_4 == arg_144_1 and var_144_3 == var_144_0 then
						self._team_data[arg_144_1] = arg_144_2.id
						var_144_2 = true

						break
					end
				end

				if not var_144_2 then
					self._team_data[arg_144_1] = arg_144_2.id
				end
			else
				local var_144_6

				for iter_144_6, iter_144_7 in pairs(self._team_data) do
					local var_144_8 = var_0_6.find_object_by_cid(self._team_type == var_0_4.team_type.abyss_owner_team and var_0_3:find_character_by_id(iter_144_7).cid or var_0_3:find_abyss_character_by_id(iter_144_7).cid)
					local var_144_9 = var_144_8.cid == var_144_1.cid or var_144_8.evo_cid == var_144_1.evo_cid

					if iter_144_7 ~= arg_144_2.id and var_144_9 then
						var_0_35:show(var_0_1:getNowLang("nosameshipinteam"))

						return
					elseif iter_144_7 == arg_144_2.id and var_144_9 then
						var_144_6 = iter_144_6
					end
				end

				if var_144_6 then
					self._team_data[var_144_6] = nil
				end

				self._team_data[#self._team_data + 1] = arg_144_2.id
			end
		end

		if self._team_type == var_0_4.team_type.abyss_owner_team then
			var_0_3:req_AbyssSaveTeamReq(self._team_data)
		else
			var_0_3:req_AbyssAbyssSaveTeamReq(self._team_data)
		end
	end

	function arg_1_0:save_strike_team_info(arg_145_1, arg_145_2)
		if not arg_145_2 or arg_145_2.is_exist then
			var_0_13(self._solid_team_data, arg_145_1)
		elseif self._solid_team_data[arg_145_1] then
			local var_145_0 = false

			for iter_145_0, iter_145_1 in pairs(self._solid_team_data) do
				if iter_145_1 == arg_145_2.id then
					self._solid_team_data[arg_145_1] = arg_145_2.id
					self._solid_team_data[iter_145_0] = self._solid_team_data[arg_145_1]
					var_145_0 = true

					break
				end
			end

			if not var_145_0 then
				self._solid_team_data[arg_145_1] = arg_145_2.id
			end
		else
			local var_145_1 = var_0_6.find_object_by_cid(var_0_3:find_character_by_id(arg_145_2.id).cid)
			local var_145_2

			for iter_145_2, iter_145_3 in pairs(self._solid_team_data) do
				local var_145_3 = var_0_6.find_object_by_cid(var_0_3:find_character_by_id(iter_145_3).cid)
				local var_145_4 = var_145_3.cid == var_145_1.cid or var_145_3.evo_cid == var_145_1.evo_cid

				if iter_145_3 ~= arg_145_2.id and var_145_4 then
					var_0_35:show(var_0_1:getNowLang("nosameshipinteam"))

					return
				elseif iter_145_3 == arg_145_2.id and var_145_4 then
					var_145_2 = iter_145_2
				end
			end

			if var_145_2 then
				var_0_13(self._solid_team_data, var_145_2)
			end

			var_0_14(self._solid_team_data, arg_145_2.id)
		end

		var_0_3:req_SolidSaveTeamReq(self._solid_team_data)
	end

	function arg_1_0:save_ocean_team_info(arg_146_1, arg_146_2)
		if not arg_146_2 or arg_146_2.is_exist then
			var_0_13(self._ocean_team_data, arg_146_1)
		elseif self._ocean_team_data[arg_146_1] then
			local var_146_0 = false

			for iter_146_0, iter_146_1 in pairs(self._ocean_team_data) do
				if iter_146_1 == arg_146_2.id then
					self._ocean_team_data[arg_146_1] = arg_146_2.id
					self._ocean_team_data[iter_146_0] = self._ocean_team_data[arg_146_1]
					var_146_0 = true

					break
				end
			end

			if not var_146_0 then
				self._ocean_team_data[arg_146_1] = arg_146_2.id
			end
		else
			local var_146_1 = var_0_6.find_object_by_cid(var_0_3:find_character_by_id(arg_146_2.id).cid)
			local var_146_2

			for iter_146_2, iter_146_3 in pairs(self._ocean_team_data) do
				local var_146_3 = var_0_6.find_object_by_cid(var_0_3:find_character_by_id(iter_146_3).cid)
				local var_146_4 = var_146_3.cid == var_146_1.cid or var_146_3.evo_cid == var_146_1.evo_cid

				if iter_146_3 ~= arg_146_2.id and var_146_4 then
					var_0_35:show(var_0_1:getNowLang("nosameshipinteam"))

					return
				elseif iter_146_3 == arg_146_2.id and var_146_4 then
					var_146_2 = iter_146_2
				end
			end

			if var_146_2 then
				var_0_13(self._ocean_team_data, var_146_2)
			end

			var_0_14(self._ocean_team_data, arg_146_2.id)
		end

		var_0_3:req_OceanSaveTeamReq(self._ocean_team_data)
	end

	function arg_1_0:save_war_concerto_team_info(arg_147_1, arg_147_2)
		if not arg_147_2 or arg_147_2.is_exist then
			var_0_13(self._war_concerto_team_data, arg_147_1)
		elseif self._war_concerto_team_data[arg_147_1] then
			local var_147_0 = false

			for iter_147_0, iter_147_1 in pairs(self._war_concerto_team_data) do
				if iter_147_1 == arg_147_2.cid then
					self._war_concerto_team_data[arg_147_1] = arg_147_2.cid
					self._war_concerto_team_data[iter_147_0] = self._war_concerto_team_data[arg_147_1]
					var_147_0 = true

					break
				end
			end

			if not var_147_0 then
				self._war_concerto_team_data[arg_147_1] = arg_147_2.cid
			end
		else
			local var_147_1 = var_0_6.find_object_by_cid(arg_147_2.cid)
			local var_147_2

			for iter_147_2, iter_147_3 in pairs(self._war_concerto_team_data) do
				local var_147_3 = var_0_6.find_object_by_cid(iter_147_3).cid == var_147_1.cid

				if iter_147_3 ~= arg_147_2.cid and var_147_3 then
					var_0_35:show(var_0_1:getNowLang("nosameshipinteam"))

					return
				elseif iter_147_3 == arg_147_2.cid and var_147_3 then
					var_147_2 = iter_147_2
				end
			end

			if var_147_2 then
				var_0_13(self._war_concerto_team_data, var_147_2)
			end

			var_0_14(self._war_concerto_team_data, arg_147_2.cid)
		end

		var_0_3:req_RecreationTeamSaveReq(self._war_concerto_team_data)
	end

	function arg_1_0:__init_total_props_panel()
		self._control.right_widget.bg_back.props_panel.title.text.text = var_0_1:getNowLang("pvepreparetotalprops")
		self._control.right_widget.bg_back.props_panel.radar_chart_bg.prop1.title.text.text = var_0_1:getNowLang("cardattribute5")
		self._control.right_widget.bg_back.props_panel.radar_chart_bg.prop2.title.text.text = var_0_1:getNowLang("radar")
		self._control.right_widget.bg_back.props_panel.radar_chart_bg.prop3.title.text.text = var_0_1:getNowLang("airdef")
		self._control.right_widget.bg_back.props_panel.radar_chart_bg.prop4.title.text.text = var_0_1:getNowLang("def")
		self._control.right_widget.bg_back.props_panel.radar_chart_bg.prop5.title.text.text = var_0_1:getNowLang("torpedo")
		self._control.right_widget.bg_back.props_panel.radar_chart_bg.prop6.title.text.text = var_0_1:getNowLang("atk")
		self._control.right_widget.bg_back.strike_info.radar_chart_bg.prop1.title.text.text = var_0_1:getNowLang("cardattribute5")
		self._control.right_widget.bg_back.strike_info.radar_chart_bg.prop2.title.text.text = var_0_1:getNowLang("radar")
		self._control.right_widget.bg_back.strike_info.radar_chart_bg.prop3.title.text.text = var_0_1:getNowLang("airdef")
		self._control.right_widget.bg_back.strike_info.radar_chart_bg.prop4.title.text.text = var_0_1:getNowLang("def")
		self._control.right_widget.bg_back.strike_info.radar_chart_bg.prop5.title.text.text = var_0_1:getNowLang("torpedo")
		self._control.right_widget.bg_back.strike_info.radar_chart_bg.prop6.title.text.text = var_0_1:getNowLang("atk")
		self._control.right_widget.bg_back.strike_info.point.now_score_text.text.text = var_0_1:getNowLang("ui_5th_point")
		self._control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_prop1.ninth_title.text.text = var_0_1:getNowLang("cardattribute5")
		self._control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_prop2.ninth_title.text.text = var_0_1:getNowLang("radar")
		self._control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_prop3.ninth_title.text.text = var_0_1:getNowLang("airdef")
		self._control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_prop4.ninth_title.text.text = var_0_1:getNowLang("def")
		self._control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_prop5.ninth_title.text.text = var_0_1:getNowLang("torpedo")
		self._control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_prop6.ninth_title.text.text = var_0_1:getNowLang("atk")
	end

	function arg_1_0:__set_wcp_total_props_panel_data()
		if not self._team_detail_data then
			return
		end

		local var_149_0 = {
			"luck",
			"radar",
			"air_def",
			"def",
			"torpedo",
			"atk"
		}
		local var_149_1 = {}
		local var_149_2 = {}
		local var_149_3 = 0

		for iter_149_0, iter_149_1 in pairs(var_149_0) do
			var_149_1[iter_149_1] = 0
		end

		for iter_149_2, iter_149_3 in pairs(self._team_detail_data) do
			if not iter_149_3.attrs or not iter_149_3.data.equips then
				break
			end

			for iter_149_4, iter_149_5 in pairs(var_149_0) do
				if iter_149_3.attrs[iter_149_5] then
					var_149_1[iter_149_5] = var_149_1[iter_149_5] + iter_149_3.attrs[iter_149_5]
				end
			end

			for iter_149_6, iter_149_7 in pairs(iter_149_3.data.equips) do
				local var_149_4 = var_0_40.find_object_by_cid(iter_149_7.id)

				for iter_149_8, iter_149_9 in pairs(var_149_0) do
					if var_149_4[iter_149_9] then
						var_149_1[iter_149_9] = var_149_1[iter_149_9] + var_149_4[iter_149_9]
					end
				end
			end

			if iter_149_3.attrs.speed then
				var_0_14(var_149_2, iter_149_3.attrs.speed)

				var_149_3 = var_149_3 + iter_149_3.attrs.speed
			end
		end

		local var_149_5 = 0
		local var_149_6 = 0

		if #var_149_2 > 0 then
			var_149_3 = var_0_32(var_149_3 / #var_149_2)

			var_0_19(var_149_2, function(arg_150_0, arg_150_1)
				return arg_150_0 < arg_150_1
			end)

			var_149_5 = var_149_2[1]
			var_149_6 = var_149_2[#var_149_2]
		end

		self._control.right_widget.bg_back.props_panel.speed_info_panel.min_speed.text.text = string.format("<color=#%s>%s</color>", "E7E7E7", var_0_12("%0.1f%s", var_149_5, var_0_1:getNowLang("speedtext")))
		self._control.right_widget.bg_back.props_panel.speed_info_panel.max_speed.text.text = string.format("<color=#%s>%s</color>", "E7E7E7", var_0_12("%0.1f%s", var_149_6, var_0_1:getNowLang("speedtext")))
		self._control.right_widget.bg_back.props_panel.speed_info_panel.mean_speed.text.text = string.format("<color=#%s>%s</color>", "E7E7E7", var_0_12("%0.2f%s", var_149_3, var_0_1:getNowLang("speedtext")))

		local var_149_7 = 1

		for iter_149_10, iter_149_11 in pairs(var_149_1) do
			if iter_149_11 / 500 > 1 then
				var_149_7 = iter_149_11 / 500
			end
		end

		self._control.right_widget.bg_back.props_panel.radar_chart_bg.draw_web:SetActive(false)

		self._control.right_widget.bg_back.props_panel.radar_chart_bg.draw_web.uIPolygon.VerticesDistances[0] = var_149_1[var_149_0[1]] / 500 / var_149_7
		self._control.right_widget.bg_back.props_panel.radar_chart_bg.draw_web.uIPolygon.VerticesDistances[1] = var_149_1[var_149_0[2]] / 500 / var_149_7
		self._control.right_widget.bg_back.props_panel.radar_chart_bg.draw_web.uIPolygon.VerticesDistances[2] = var_149_1[var_149_0[3]] / 500 / var_149_7
		self._control.right_widget.bg_back.props_panel.radar_chart_bg.draw_web.uIPolygon.VerticesDistances[3] = var_149_1[var_149_0[4]] / 500 / var_149_7
		self._control.right_widget.bg_back.props_panel.radar_chart_bg.draw_web.uIPolygon.VerticesDistances[4] = var_149_1[var_149_0[5]] / 500 / var_149_7
		self._control.right_widget.bg_back.props_panel.radar_chart_bg.draw_web.uIPolygon.VerticesDistances[5] = var_149_1[var_149_0[6]] / 500 / var_149_7

		self._control.right_widget.bg_back.props_panel.radar_chart_bg.draw_web.uIPolygon:DrawPolygon(6, self._control.right_widget.bg_back.props_panel.radar_chart_bg.draw_web.uIPolygon.VerticesDistances, 270)
		self._control.right_widget.bg_back.props_panel.radar_chart_bg.draw_web:SetActive(true)

		self._control.right_widget.bg_back.props_panel.radar_chart_bg.prop1.num.text.text = tostring(var_149_1[var_149_0[1]])
		self._control.right_widget.bg_back.props_panel.radar_chart_bg.prop2.num.text.text = tostring(var_149_1[var_149_0[2]])
		self._control.right_widget.bg_back.props_panel.radar_chart_bg.prop3.num.text.text = tostring(var_149_1[var_149_0[3]])
		self._control.right_widget.bg_back.props_panel.radar_chart_bg.prop4.num.text.text = tostring(var_149_1[var_149_0[4]])
		self._control.right_widget.bg_back.props_panel.radar_chart_bg.prop5.num.text.text = tostring(var_149_1[var_149_0[5]])
		self._control.right_widget.bg_back.props_panel.radar_chart_bg.prop6.num.text.text = tostring(var_149_1[var_149_0[6]])

		self:__play_animation(self._control.right_widget.bg_back.speed_skeleton_mask.speed_skeleton, "meter_deep_sea_version", false)
	end

	function arg_1_0:__set_strike_props_panel_data()
		if not self._team_detail_data then
			return
		end

		self:__update_strike_buffs()

		local var_151_0 = 0

		if self._team_detail_data and next(self._team_detail_data) then
			var_151_0 = #self._team_detail_data
		end

		local var_151_1 = self:__rebuild_strike_attr_buff_list()

		self:__append_strike_weather_buff_to_list(var_151_1)

		local var_151_2 = 0
		local var_151_3 = 0
		local var_151_5 = 0
		local var_151_6 = 0
		local var_151_8 = 0
		local var_151_9 = 0
		local var_151_11 = 0
		local var_151_12 = 0
		local var_151_14 = 0
		local var_151_15 = 0
		local var_151_17 = 0
		local var_151_18 = 0
		local var_151_20 = 0
		local var_151_22, var_151_23 = self:__build_strike_speed_radar_lists()

		for iter_151_0, iter_151_1 in pairs(self._team_detail_data) do
			local var_151_24 = var_0_5:get_ship_attr(iter_151_1.data, iter_151_1.config)

			if var_151_24 then
				for iter_151_2, iter_151_3 in pairs(var_151_24) do
					if iter_151_2 == "luck" then
						var_151_2 = math.floor(var_151_2 + iter_151_3)
					elseif iter_151_2 == "air_def" then
						var_151_8 = math.floor(var_151_8 + iter_151_3)
					elseif iter_151_2 == "def" then
						var_151_11 = math.floor(var_151_11 + iter_151_3)
					elseif iter_151_2 == "torpedo" then
						var_151_14 = math.floor(var_151_14 + iter_151_3)
					elseif iter_151_2 == "atk" then
						var_151_17 = math.floor(var_151_17 + iter_151_3)
					end
				end
			end
		end

		self:__apply_strike_buff_speed_radar_to_lists(var_151_22, var_151_23, var_151_1)

		for iter_151_4, iter_151_5 in pairs(var_151_23) do
			if iter_151_5.add_by_strike_buff then
				break
			end
		end

		for iter_151_6, iter_151_7 in pairs(var_151_22) do
			var_151_20 = var_151_20 + iter_151_7.speed_num
		end

		for iter_151_8, iter_151_9 in pairs(var_151_23) do
			var_151_5 = var_151_5 + iter_151_9.radar_num
		end

		for iter_151_10, iter_151_11 in pairs(var_151_1) do
			local var_151_27

			if iter_151_11.id < 1000 then
				var_151_27 = var_0_31.find_object_by_id(iter_151_11.id)

				if iter_151_11.state then
					var_151_27 = var_0_31.find_object_by_id(iter_151_11.change_id)
				end
			else
				var_151_27 = var_0_30.find_object_by_id(iter_151_11.id)

				if iter_151_11.state then
					var_151_27 = var_0_30.find_object_by_id(iter_151_11.change_id)
				end
			end

			if var_151_27 and var_151_27.effect then
				for iter_151_12, iter_151_13 in pairs(var_151_27.effect) do
					if not self:__is_strike_buff_effect_type(iter_151_13.type) then
						-- block empty
					elseif iter_151_13.num4 == 2 then
						var_151_17 = math.floor(var_151_17 + self:__calc_strike_buff_team_attr_delta(iter_151_13, var_151_0))
					elseif iter_151_13.num4 == 3 then
						var_151_11 = math.floor(var_151_11 + self:__calc_strike_buff_team_attr_delta(iter_151_13, var_151_0))
					elseif iter_151_13.num4 == 4 then
						var_151_14 = math.floor(var_151_14 + self:__calc_strike_buff_team_attr_delta(iter_151_13, var_151_0))
					elseif iter_151_13.num4 == 6 then
						var_151_8 = math.floor(var_151_8 + self:__calc_strike_buff_team_attr_delta(iter_151_13, var_151_0))
					elseif iter_151_13.num4 == 13 then
						var_151_2 = math.floor(var_151_2 + self:__calc_strike_buff_team_attr_delta(iter_151_13, var_151_0))
					end
				end
			end
		end

		var_0_3:set_gotofight_team_info(var_151_20)
		var_0_19(var_151_22, function(arg_152_0, arg_152_1)
			return arg_152_0.speed_num < arg_152_1.speed_num
		end)

		local var_151_28 = "E7E7E7"

		if next(var_151_22) then
			if var_151_22[1].add_by_skill == true or var_151_22[1].add_by_strike_buff == true then
				var_151_28 = "2DA6F6"
			end

			if var_151_22[#var_151_22].add_by_skill == true or var_151_22[#var_151_22].add_by_strike_buff == true then
				-- block empty
			end

			for iter_151_14, iter_151_15 in pairs(var_151_22) do
				if iter_151_15.add_by_skill == true or iter_151_15.add_by_strike_buff == true then
					-- block empty
				end
			end

			self._control.right_widget.bg_back.strike_info.speed_info_panel.min_speed.text.text = string.format("<color=#%s>%s</color>", var_151_28, var_0_12("%0.1f%s", var_151_22[1].speed_num, var_0_1:getNowLang("speedtext")))
			self._control.right_widget.bg_back.strike_info.speed_info_panel.max_speed.text.text = string.format("<color=#%s>%s</color>", "E7E7E7", var_0_12("%0.1f%s", var_151_22[#var_151_22].speed_num, var_0_1:getNowLang("speedtext")))
			self._control.right_widget.bg_back.strike_info.speed_info_panel.mean_speed.text.text = string.format("<color=#%s>%s</color>", "E7E7E7", var_0_12("%0.2f%s", var_151_20 / #var_151_22, var_0_1:getNowLang("speedtext")))
		else
			self._control.right_widget.bg_back.strike_info.speed_info_panel.min_speed.text.text = string.format("<color=#%s>%s</color>", var_151_28, var_0_12("%0d%s", 0, var_0_1:getNowLang("speedtext")))
			self._control.right_widget.bg_back.strike_info.speed_info_panel.max_speed.text.text = string.format("<color=#%s>%s</color>", var_151_28, var_0_12("%0d%s", 0, var_0_1:getNowLang("speedtext")))
			self._control.right_widget.bg_back.strike_info.speed_info_panel.mean_speed.text.text = string.format("<color=#%s>%s</color>", var_151_28, var_0_12("%0d%s", 0, var_0_1:getNowLang("speedtext")))
		end

		local var_151_31 = 500

		for iter_151_16, iter_151_17 in pairs({
			var_151_3,
			var_151_6,
			var_151_9,
			var_151_12,
			var_151_15,
			var_151_18
		}) do
			if var_151_31 < iter_151_17 then
				var_151_31 = iter_151_17
			end
		end

		local var_151_32 = {}

		var_0_14(var_151_32, var_151_2 / var_151_31)
		var_0_14(var_151_32, var_151_5 / var_151_31)
		var_0_14(var_151_32, var_151_8 / var_151_31)
		var_0_14(var_151_32, var_151_11 / var_151_31)
		var_0_14(var_151_32, var_151_14 / var_151_31)
		var_0_14(var_151_32, var_151_17 / var_151_31)
		var_0_19(var_151_32, function(arg_153_0, arg_153_1)
			return arg_153_0 < arg_153_1
		end)

		local var_151_33 = 1

		if var_151_32[#var_151_32] > 1 then
			var_151_33 = var_151_32[#var_151_32]
		end

		self._control.right_widget.bg_back.strike_info.radar_chart_bg.draw_web:SetActive(false)

		self._control.right_widget.bg_back.strike_info.radar_chart_bg.draw_web.uIPolygon.VerticesDistances[0] = var_151_2 / var_151_31 / var_151_33
		self._control.right_widget.bg_back.strike_info.radar_chart_bg.draw_web.uIPolygon.VerticesDistances[1] = var_151_5 / var_151_31 / var_151_33
		self._control.right_widget.bg_back.strike_info.radar_chart_bg.draw_web.uIPolygon.VerticesDistances[2] = var_151_8 / var_151_31 / var_151_33
		self._control.right_widget.bg_back.strike_info.radar_chart_bg.draw_web.uIPolygon.VerticesDistances[3] = var_151_11 / var_151_31 / var_151_33
		self._control.right_widget.bg_back.strike_info.radar_chart_bg.draw_web.uIPolygon.VerticesDistances[4] = var_151_14 / var_151_31 / var_151_33
		self._control.right_widget.bg_back.strike_info.radar_chart_bg.draw_web.uIPolygon.VerticesDistances[5] = var_151_17 / var_151_31 / var_151_33

		self._control.right_widget.bg_back.strike_info.radar_chart_bg.draw_web.uIPolygon:DrawPolygon(6, self._control.right_widget.bg_back.strike_info.radar_chart_bg.draw_web.uIPolygon.VerticesDistances, 270)
		self._control.right_widget.bg_back.strike_info.radar_chart_bg.draw_web:SetActive(true)

		self._control.right_widget.bg_back.strike_info.radar_chart_bg.prop2.num.text.text = tostring(var_151_5)
		self._control.right_widget.bg_back.strike_info.radar_chart_bg.prop1.num.text.text = tostring(var_151_2)
		self._control.right_widget.bg_back.strike_info.radar_chart_bg.prop3.num.text.text = tostring(var_151_8)
		self._control.right_widget.bg_back.strike_info.radar_chart_bg.prop4.num.text.text = tostring(var_151_11)
		self._control.right_widget.bg_back.strike_info.radar_chart_bg.prop5.num.text.text = tostring(var_151_14)
		self._control.right_widget.bg_back.strike_info.radar_chart_bg.prop6.num.text.text = tostring(var_151_17)

		self:__play_animation(self._control.right_widget.bg_back.speed_skeleton_mask.speed_skeleton, "meter_deep_sea_version", false)
	end

	function arg_1_0.__get_strike_buff_data_by_buff_entry(arg_154_0, arg_154_1)
		local var_154_0

		if arg_154_1.id < 1000 then
			var_154_0 = var_0_31.find_object_by_id(arg_154_1.id)

			if arg_154_1.state then
				var_154_0 = var_0_31.find_object_by_id(arg_154_1.change_id)
			end
		else
			var_154_0 = var_0_30.find_object_by_id(arg_154_1.id)

			if arg_154_1.state then
				var_154_0 = var_0_30.find_object_by_id(arg_154_1.change_id)
			end
		end

		return var_154_0
	end

	function arg_1_0.__is_strike_buff_effect_type(arg_155_0, arg_155_1)
		return arg_155_1 == 7 or arg_155_1 == 8 or arg_155_1 == 9 or arg_155_1 == 10 or arg_155_1 == 19 or arg_155_1 == 20 or arg_155_1 == 31
	end

	function arg_1_0:__is_strike_buff_fight_check_effect(arg_156_1)
		return self:__is_strike_buff_card_color_check_effect(arg_156_1)
	end

	function arg_1_0:__is_strike_buff_card_color_check_effect(arg_157_1)
		if not arg_157_1 or not arg_157_1.type then
			return false
		end

		if self:__is_strike_buff_effect_type(arg_157_1.type) then
			return false
		end

		return true
	end

	function arg_1_0.__check_strike_buff_type38_team_pass(arg_158_0, arg_158_1)
		local var_158_0 = var_0_3:get_strike_point_info().use_ship or {}

		if not next(var_158_0) then
			return true
		end

		if not arg_158_1 or not next(arg_158_1) then
			return true
		end

		for iter_158_0, iter_158_1 in pairs(arg_158_1) do
			for iter_158_2, iter_158_3 in pairs(var_158_0) do
				if iter_158_1 == iter_158_3 then
					return false
				end
			end
		end

		return true
	end

	function arg_1_0:__pass_strike_buff_card_color_effect(arg_159_1, arg_159_2)
		if arg_159_2.type == 38 then
			return self:__check_strike_buff_type38_team_pass(arg_159_1)
		elseif arg_159_2.type == 12 and arg_159_2.num4 == 11 then
			return self:__calc_strike_team_radar_total() > arg_159_2.num
		elseif arg_159_2.type == 12 and arg_159_2.num4 == 10 then
			return self:__calc_strike_team_speed_total() > arg_159_2.num
		elseif arg_159_2.type == 13 and arg_159_2.num4 == 10 then
			return self:__calc_strike_team_average_speed() <= arg_159_2.num
		elseif arg_159_2.type == 14 and arg_159_2.num4 == 10 then
			return self:__calc_strike_team_average_speed() > arg_159_2.num
		elseif arg_159_2.type == 13 and arg_159_2.num4 == 11 then
			local var_159_0

			if self._team_detail_data then
				var_159_0 = #self._team_detail_data or 0

				if var_159_0 == 0 then
					return false
				end
			end

			return self:__calc_strike_team_radar_total() / var_159_0 <= arg_159_2.num
		elseif arg_159_2.type == 14 and arg_159_2.num4 == 11 then
			local var_159_1

			if self._team_detail_data then
				var_159_1 = #self._team_detail_data or 0

				if var_159_1 == 0 then
					return false
				end
			end

			return self:__calc_strike_team_radar_total() / var_159_1 > arg_159_2.num
		end

		local var_159_2 = self:select_ship_by_pvebuff(arg_159_1, arg_159_2, self._fight_prepare_type, true)

		return var_159_2 and var_159_2 ~= nil
	end

	function arg_1_0:__is_strike_buff_team_satisfy(arg_160_1, arg_160_2)
		if not arg_160_1 or not arg_160_1.effect then
			return true
		end

		if not arg_160_2 or not next(arg_160_2) then
			return false
		end

		for iter_160_0, iter_160_1 in pairs(arg_160_1.effect) do
			if self:__is_strike_buff_card_color_check_effect(iter_160_1) and not self:__pass_strike_buff_card_color_effect(arg_160_2, iter_160_1) then
				return false
			end

			if iter_160_1.type == 38 and not self:__check_strike_buff_type38_team_pass(arg_160_2) then
				return false
			end
		end

		return true
	end

	function arg_1_0:__is_strike_buff_condition_pass(arg_161_1)
		if not arg_161_1 or not arg_161_1.effect then
			return true
		end

		local var_161_0 = self:__get_strike_team_data_for_buff()

		if not next(var_161_0) then
			return false
		end

		for iter_161_0, iter_161_1 in pairs(arg_161_1.effect) do
			if not self:__is_strike_buff_effect_type(iter_161_1.type) then
				if iter_161_1.type == 12 and iter_161_1.num4 == 11 then
					if self:__calc_strike_team_radar_total() <= iter_161_1.num then
						return false
					end
				elseif iter_161_1.type == 12 and iter_161_1.num4 == 10 then
					if self:__calc_strike_team_speed_total() <= iter_161_1.num then
						return false
					end
				elseif iter_161_1.type == 13 and iter_161_1.num4 == 10 then
					if self:__calc_strike_team_average_speed() > iter_161_1.num then
						return false
					end
				elseif iter_161_1.type == 14 and iter_161_1.num4 == 10 then
					if self:__calc_strike_team_average_speed() <= iter_161_1.num then
						return false
					end
				elseif not self:select_ship_by_pvebuff(var_161_0, iter_161_1, self._fight_prepare_type) then
					return false
				end
			end
		end

		return true
	end

	function arg_1_0.__check_buff_value_change(arg_162_0, arg_162_1)
		if arg_162_1.type == 7 or arg_162_1.type == 9 or arg_162_1.type == 19 then
			return arg_162_1.num
		elseif arg_162_1.type == 8 or arg_162_1.type == 10 or arg_162_1.type == 20 then
			return arg_162_1.num * -1
		else
			return 0
		end
	end

	function arg_1_0:__strike_buff_applies_to_ship(arg_163_1, arg_163_2)
		if arg_163_1.type == 7 or arg_163_1.type == 8 then
			return true
		end

		if arg_163_1.type == 9 or arg_163_1.type == 10 or arg_163_1.type == 19 or arg_163_1.type == 20 then
			local var_163_0 = self:__get_ship_counter_by_buff_data({
				arg_163_2
			}, arg_163_1)

			return var_163_0 and next(var_163_0) ~= nil
		end

		return false
	end

	function arg_1_0:__count_strike_buff_effect_ships(arg_164_1)
		if not self._team_detail_data or not next(self._team_detail_data) then
			return 0
		end

		if arg_164_1.type == 7 or arg_164_1.type == 8 then
			return #self._team_detail_data
		end

		if arg_164_1.type == 9 or arg_164_1.type == 10 or arg_164_1.type == 19 or arg_164_1.type == 20 then
			local var_164_0 = {}

			for iter_164_0, iter_164_1 in pairs(self._team_detail_data) do
				var_164_0[iter_164_0] = iter_164_1.data.id
			end

			local var_164_1 = self:__get_ship_counter_by_buff_data(var_164_0, arg_164_1)

			if not var_164_1 then
				return 0
			end

			local var_164_2 = 0

			for iter_164_2 in pairs(var_164_1) do
				var_164_2 = var_164_2 + 1
			end

			return var_164_2
		end

		return 0
	end

	function arg_1_0:__calc_strike_buff_team_attr_delta(arg_165_1, arg_165_2)
		if not self:__is_strike_buff_effect_type(arg_165_1.type) then
			return 0
		end

		local var_165_0 = self:__count_strike_buff_effect_ships(arg_165_1)

		if var_165_0 == 0 then
			return 0
		end

		return self:__check_buff_value_change(arg_165_1) * var_165_0
	end

	function arg_1_0:__apply_strike_buff_speed_radar_to_lists(arg_166_1, arg_166_2, arg_166_3)
		local var_166_0 = false
		local var_166_1 = false

		if not arg_166_3 or not self._team_detail_data then
			return var_166_0, var_166_1
		end

		for iter_166_0, iter_166_1 in pairs(arg_166_3) do
			local var_166_2 = self:__get_strike_buff_data_by_buff_entry(iter_166_1)

			if var_166_2 and var_166_2.effect then
				for iter_166_2, iter_166_3 in pairs(var_166_2.effect) do
					if self:__is_strike_buff_effect_type(iter_166_3.type) and (iter_166_3.num4 == 10 or iter_166_3.num4 == 11) then
						local var_166_3 = self:__check_buff_value_change(iter_166_3)

						if var_166_3 ~= 0 then
							for iter_166_4, iter_166_5 in pairs(self._team_detail_data) do
								if self:__strike_buff_applies_to_ship(iter_166_3, iter_166_5.data.id) then
									if iter_166_3.num4 == 10 and arg_166_1[iter_166_4] then
										arg_166_1[iter_166_4].speed_num = arg_166_1[iter_166_4].speed_num + var_166_3
										arg_166_1[iter_166_4].add_by_strike_buff = true
										var_166_0 = true
									elseif iter_166_3.num4 == 11 and arg_166_2[iter_166_4] then
										arg_166_2[iter_166_4].radar_num = arg_166_2[iter_166_4].radar_num + var_166_3
										arg_166_2[iter_166_4].add_by_strike_buff = true
										var_166_1 = true
									end
								end
							end
						end
					end
				end
			end
		end

		return var_166_0, var_166_1
	end

	function arg_1_0:__calc_strike_buff_speed_change(arg_167_1)
		local var_167_0 = 0

		if not arg_167_1 then
			return var_167_0
		end

		for iter_167_0, iter_167_1 in pairs(arg_167_1) do
			local var_167_1

			if iter_167_1.id < 1000 then
				var_167_1 = var_0_31.find_object_by_id(iter_167_1.id)

				if iter_167_1.state then
					var_167_1 = var_0_31.find_object_by_id(iter_167_1.change_id)
				end
			else
				var_167_1 = var_0_30.find_object_by_id(iter_167_1.id)

				if iter_167_1.state then
					var_167_1 = var_0_30.find_object_by_id(iter_167_1.change_id)
				end
			end

			if var_167_1 and var_167_1.effect then
				for iter_167_2, iter_167_3 in pairs(var_167_1.effect) do
					if iter_167_3.num4 == 10 and (iter_167_3.type == 7 or iter_167_3.type == 8) then
						var_167_0 = var_167_0 + self:__check_buff_value_change(iter_167_3)
					end
				end
			end
		end

		return var_167_0
	end

	function arg_1_0:__calc_strike_buff_radar_change(arg_168_1)
		local var_168_0 = 0

		if not arg_168_1 then
			return var_168_0
		end

		for iter_168_0, iter_168_1 in pairs(arg_168_1) do
			local var_168_1

			if iter_168_1.id < 1000 then
				var_168_1 = var_0_31.find_object_by_id(iter_168_1.id)

				if iter_168_1.state then
					var_168_1 = var_0_31.find_object_by_id(iter_168_1.change_id)
				end
			else
				var_168_1 = var_0_30.find_object_by_id(iter_168_1.id)

				if iter_168_1.state then
					var_168_1 = var_0_30.find_object_by_id(iter_168_1.change_id)
				end
			end

			if var_168_1 and var_168_1.effect then
				for iter_168_2, iter_168_3 in pairs(var_168_1.effect) do
					if iter_168_3.num4 == 11 and (iter_168_3.type == 7 or iter_168_3.type == 8) then
						var_168_0 = var_168_0 + self:__check_buff_value_change(iter_168_3)
					end
				end
			end
		end

		return var_168_0
	end

	function arg_1_0:__get_avg_speed(arg_169_1)
		local var_169_0 = 0
		local var_169_1 = 0
		local var_169_2 = 0
		local var_169_3 = 0
		local var_169_4 = 0
		local var_169_5 = 0
		local var_169_6 = 1
		local var_169_7 = 0
		local var_169_8 = 0
		local var_169_9 = 0

		for iter_169_0, iter_169_1 in pairs(self._team_detail_data) do
			attrs = arg_169_1[iter_169_0]

			local var_169_10, var_169_11 = var_0_4:get_avg_speed_class(iter_169_1.data.type)

			if var_169_10 == "class1" then
				var_169_0 = var_169_0 + var_169_11 * attrs.speed_num
				var_169_1 = var_169_1 + var_169_11
				var_169_6 = 0
			elseif var_169_10 == "class2" then
				var_169_2 = var_169_2 + var_169_11 * attrs.speed_num
				var_169_3 = var_169_3 + var_169_11
				var_169_6 = 0
			elseif var_169_10 == "class3" then
				var_169_4 = var_169_4 + var_169_11 * attrs.speed_num
				var_169_5 = var_169_5 + var_169_11
			end
		end

		if var_169_6 == 1 then
			var_169_7 = math.floor(var_169_4 / var_169_5)
		else
			if var_169_0 ~= 0 then
				var_169_8 = var_169_0 / var_169_1
				var_169_7 = var_169_0 / var_169_1
			end

			if var_169_2 ~= 0 then
				var_169_9 = var_169_2 / var_169_3
				var_169_7 = var_169_2 / var_169_3
			end

			if var_169_8 ~= 0 and var_169_9 ~= 0 then
				var_169_7 = math.floor(math.min(var_169_8, var_169_9))
			end
		end

		return var_169_7
	end

	function arg_1_0:__set_total_props_panel_data()
		if self._current_content_type == var_0_4.fight_prepare_right_panel_type.war_concerto_play then
			self:__set_wcp_total_props_panel_data()

			return
		end

		if self._current_content_type == var_0_4.fight_prepare_right_panel_type.strike or self._current_content_type == var_0_4.fight_prepare_right_panel_type.strike_equip_preview then
			self:__set_strike_props_panel_data()

			return
		end

		local var_170_0 = 0
		local var_170_1 = 0
		local var_170_3 = 0
		local var_170_4 = 0
		local var_170_6 = 0
		local var_170_7 = 0
		local var_170_9 = 0
		local var_170_10 = 0
		local var_170_12 = 0
		local var_170_13 = 0
		local var_170_15 = 0
		local var_170_16 = 0
		local var_170_18 = {}
		local var_170_19 = {}
		local var_170_20 = 0

		for iter_170_0, iter_170_1 in pairs(self._team_detail_data) do
			local var_170_22 = var_0_5:get_ship_attr(iter_170_1.data, iter_170_1.config)

			if var_170_22 then
				var_170_18[iter_170_0] = {
					add_by_skill = false,
					speed_num = var_170_22.speed
				}
				var_170_19[iter_170_0] = {
					radar_num = var_170_22.radar
				}

				for iter_170_2, iter_170_3 in pairs(var_170_22) do
					if iter_170_2 == "luck" then
						var_170_0 = math.floor(var_170_0 + iter_170_3)
					elseif iter_170_2 == "air_def" then
						var_170_6 = math.floor(var_170_6 + iter_170_3)
					elseif iter_170_2 == "def" then
						var_170_9 = math.floor(var_170_9 + iter_170_3)
					elseif iter_170_2 == "torpedo" then
						var_170_12 = math.floor(var_170_12 + iter_170_3)
					elseif iter_170_2 == "atk" then
						var_170_15 = math.floor(var_170_15 + iter_170_3)
					end
				end
			end
		end

		for iter_170_4, iter_170_5 in pairs(self._team_detail_data) do
			self:__add_speed_by_buff_skill(self._team_detail_data, var_170_18, var_170_19, iter_170_4)
		end

		for iter_170_6, iter_170_7 in pairs(var_170_19) do
			var_170_3 = var_170_3 + iter_170_7.radar_num
		end

		for iter_170_8, iter_170_9 in pairs(var_170_18) do
			var_170_20 = var_170_20 + iter_170_9.speed_num
		end

		var_0_3:set_gotofight_team_info(var_170_20)
		var_0_19(var_170_18, function(arg_171_0, arg_171_1)
			return arg_171_0.speed_num < arg_171_1.speed_num
		end)

		local var_170_23 = "E7E7E7"
		local var_170_24 = "E7E7E7"
		local var_170_25 = "E7E7E7"

		if next(var_170_18) then
			if var_170_18[1].add_by_skill == true then
				var_170_23 = "2DA6F6"
			end

			if var_170_18[#var_170_18].add_by_skill == true then
				var_170_24 = "2DA6F6"
			end

			for iter_170_10, iter_170_11 in pairs(var_170_18) do
				if iter_170_11.add_by_skill == true then
					var_170_25 = "2DA6F6"
				end
			end

			if self._fight_prepare_type == var_0_4.fight_type.ninth_attack then
				self._control.right_widget.bg_back.ninth_info.ninth_speed_info_panel.ninth_min_speed.text.text = string.format("<color=#%s>%s</color>", var_170_23, var_0_12("%0.1f%s", var_170_18[1].speed_num, var_0_1:getNowLang("speedtext")))
				self._control.right_widget.bg_back.ninth_info.ninth_speed_info_panel.ninth_max_speed.text.text = string.format("<color=#%s>%s</color>", var_170_24, var_0_12("%0.1f%s", var_170_18[#var_170_18].speed_num, var_0_1:getNowLang("speedtext")))
				self._control.right_widget.bg_back.ninth_info.ninth_speed_info_panel.ninth_mean_speed.text.text = string.format("<color=#%s>%s</color>", var_170_25, var_0_12("%0.2f%s", var_170_20 / #var_170_18, var_0_1:getNowLang("speedtext")))
			else
				self._control.right_widget.bg_back.props_panel.speed_info_panel.min_speed.text.text = string.format("<color=#%s>%s</color>", var_170_23, var_0_12("%0.1f%s", var_170_18[1].speed_num, var_0_1:getNowLang("speedtext")))
				self._control.right_widget.bg_back.props_panel.speed_info_panel.max_speed.text.text = string.format("<color=#%s>%s</color>", var_170_24, var_0_12("%0.1f%s", var_170_18[#var_170_18].speed_num, var_0_1:getNowLang("speedtext")))
				self._control.right_widget.bg_back.props_panel.speed_info_panel.mean_speed.text.text = string.format("<color=#%s>%s</color>", var_170_25, var_0_12("%0.2f%s", var_170_20 / #var_170_18, var_0_1:getNowLang("speedtext")))
			end
		elseif self._fight_prepare_type == var_0_4.fight_type.ninth_attack then
			self._control.right_widget.bg_back.ninth_info.ninth_speed_info_panel.ninth_min_speed.text.text = string.format("<color=#%s>%s</color>", var_170_23, var_0_12("%0d%s", 0, var_0_1:getNowLang("speedtext")))
			self._control.right_widget.bg_back.ninth_info.ninth_speed_info_panel.ninth_max_speed.text.text = string.format("<color=#%s>%s</color>", var_170_23, var_0_12("%0d%s", 0, var_0_1:getNowLang("speedtext")))
			self._control.right_widget.bg_back.ninth_info.ninth_speed_info_panel.ninth_mean_speed.text.text = string.format("<color=#%s>%s</color>", var_170_23, var_0_12("%0d%s", 0, var_0_1:getNowLang("speedtext")))
		else
			self._control.right_widget.bg_back.props_panel.speed_info_panel.min_speed.text.text = string.format("<color=#%s>%s</color>", var_170_23, var_0_12("%0d%s", 0, var_0_1:getNowLang("speedtext")))
			self._control.right_widget.bg_back.props_panel.speed_info_panel.max_speed.text.text = string.format("<color=#%s>%s</color>", var_170_23, var_0_12("%0d%s", 0, var_0_1:getNowLang("speedtext")))
			self._control.right_widget.bg_back.props_panel.speed_info_panel.mean_speed.text.text = string.format("<color=#%s>%s</color>", var_170_23, var_0_12("%0d%s", 0, var_0_1:getNowLang("speedtext")))
		end

		local var_170_26 = 500

		for iter_170_12, iter_170_13 in pairs({
			var_170_1,
			var_170_4,
			var_170_7,
			var_170_10,
			var_170_13,
			var_170_16
		}) do
			if var_170_26 < iter_170_13 then
				var_170_26 = iter_170_13
			end
		end

		local var_170_27 = {}

		var_0_14(var_170_27, var_170_0 / var_170_26)
		var_0_14(var_170_27, var_170_3 / var_170_26)
		var_0_14(var_170_27, var_170_6 / var_170_26)
		var_0_14(var_170_27, var_170_9 / var_170_26)
		var_0_14(var_170_27, var_170_12 / var_170_26)
		var_0_14(var_170_27, var_170_15 / var_170_26)
		var_0_19(var_170_27, function(arg_172_0, arg_172_1)
			return arg_172_0 < arg_172_1
		end)

		local var_170_28 = 1

		if var_170_27[#var_170_27] > 1 then
			var_170_28 = var_170_27[#var_170_27]
		end

		if self._fight_prepare_type == var_0_4.fight_type.ninth_attack then
			self._control.right_widget.bg_back.props_panel.radar_chart_bg.draw_web:SetActive(false)

			self._control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_draw_web.uIPolygon.VerticesDistances[0] = var_170_0 / var_170_26 / var_170_28
			self._control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_draw_web.uIPolygon.VerticesDistances[1] = var_170_3 / var_170_26 / var_170_28
			self._control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_draw_web.uIPolygon.VerticesDistances[2] = var_170_6 / var_170_26 / var_170_28
			self._control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_draw_web.uIPolygon.VerticesDistances[3] = var_170_9 / var_170_26 / var_170_28
			self._control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_draw_web.uIPolygon.VerticesDistances[4] = var_170_12 / var_170_26 / var_170_28
			self._control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_draw_web.uIPolygon.VerticesDistances[5] = var_170_15 / var_170_26 / var_170_28

			self._control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_draw_web.uIPolygon:DrawPolygon(6, self._control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_draw_web.uIPolygon.VerticesDistances, 270)
			self._control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_draw_web:SetActive(true)

			self._control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_prop1.ninth_num.text.text = tostring(var_170_0)
			self._control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_prop2.ninth_num.text.text = tostring(var_170_3)
			self._control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_prop3.ninth_num.text.text = tostring(var_170_6)
			self._control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_prop4.ninth_num.text.text = tostring(var_170_9)
			self._control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_prop5.ninth_num.text.text = tostring(var_170_12)
			self._control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_prop6.ninth_num.text.text = tostring(var_170_15)

			if self._control.left_widget.func_toggle.toggle1.toggle.isOn == true and self._control.right_widget.bg_back.ninth_info.ninth_toggle_info.toggle.isOn == true or self._control.left_widget.func_toggle.toggle4.toggle.isOn == true and self._control.right_widget.bg_back.ninth_info.ninth_toggle_info.toggle.isOn == true then
				self._control.right_widget.bg_back.speed_skeleton_mask:SetActive(true)
				self._control.right_widget.bg_back.speed_skeleton_mask.speed_skeleton:SetActive(true)
				self:__play_animation(self._control.right_widget.bg_back.speed_skeleton_mask.speed_skeleton, "meter_deep_sea_version", false)
			end
		else
			self._control.right_widget.bg_back.props_panel.radar_chart_bg.draw_web:SetActive(false)

			self._control.right_widget.bg_back.props_panel.radar_chart_bg.draw_web.uIPolygon.VerticesDistances[0] = var_170_0 / var_170_26 / var_170_28
			self._control.right_widget.bg_back.props_panel.radar_chart_bg.draw_web.uIPolygon.VerticesDistances[1] = var_170_3 / var_170_26 / var_170_28
			self._control.right_widget.bg_back.props_panel.radar_chart_bg.draw_web.uIPolygon.VerticesDistances[2] = var_170_6 / var_170_26 / var_170_28
			self._control.right_widget.bg_back.props_panel.radar_chart_bg.draw_web.uIPolygon.VerticesDistances[3] = var_170_9 / var_170_26 / var_170_28
			self._control.right_widget.bg_back.props_panel.radar_chart_bg.draw_web.uIPolygon.VerticesDistances[4] = var_170_12 / var_170_26 / var_170_28
			self._control.right_widget.bg_back.props_panel.radar_chart_bg.draw_web.uIPolygon.VerticesDistances[5] = var_170_15 / var_170_26 / var_170_28

			self._control.right_widget.bg_back.props_panel.radar_chart_bg.draw_web.uIPolygon:DrawPolygon(6, self._control.right_widget.bg_back.props_panel.radar_chart_bg.draw_web.uIPolygon.VerticesDistances, 270)
			self._control.right_widget.bg_back.props_panel.radar_chart_bg.draw_web:SetActive(true)

			self._control.right_widget.bg_back.props_panel.radar_chart_bg.prop1.num.text.text = tostring(var_170_0)
			self._control.right_widget.bg_back.props_panel.radar_chart_bg.prop2.num.text.text = tostring(var_170_3)
			self._control.right_widget.bg_back.props_panel.radar_chart_bg.prop3.num.text.text = tostring(var_170_6)
			self._control.right_widget.bg_back.props_panel.radar_chart_bg.prop4.num.text.text = tostring(var_170_9)
			self._control.right_widget.bg_back.props_panel.radar_chart_bg.prop5.num.text.text = tostring(var_170_12)
			self._control.right_widget.bg_back.props_panel.radar_chart_bg.prop6.num.text.text = tostring(var_170_15)

			if self._control.left_widget.func_toggle.toggle1.toggle.isOn == true then
				self._control.right_widget.bg_back.speed_skeleton_mask:SetActive(true)
				self._control.right_widget.bg_back.speed_skeleton_mask.speed_skeleton:SetActive(true)
			end

			self:__play_animation(self._control.right_widget.bg_back.speed_skeleton_mask.speed_skeleton, "meter_deep_sea_version", false)
		end
	end

	function arg_1_0:__add_attr_by_skill(arg_173_1, arg_173_2, arg_173_3)
		if arg_173_1 then
			local var_173_0 = var_0_11.find_object_by_skill_type_skill_level(arg_173_1.data.now_skill, arg_173_1.data.skill_level)

			if var_173_0 and var_173_0.effect then
				for iter_173_0, iter_173_1 in pairs(var_173_0.effect) do
					if var_173_0.effect[iter_173_0].type == 1 and var_173_0.effect[iter_173_0].stage[1] == 1 then
						for iter_173_2, iter_173_3 in pairs(iter_173_1.effect) do
							if iter_173_3.type == 131 then
								local var_173_1

								if arg_173_2[self._detail_attr_table[iter_173_3.attribute]] then
									var_173_1 = var_0_5.attr_impact_by_speed(arg_173_2.speed, arg_173_2[self._detail_attr_table[iter_173_3.attribute]], iter_173_3.num1, iter_173_3.num2) - arg_173_2[self._detail_attr_table[iter_173_3.attribute]]
								end

								if var_173_1 then
									arg_173_3[self._detail_attr_table[iter_173_3.attribute]] = arg_173_3[self._detail_attr_table[iter_173_3.attribute]] + var_173_1
								end
							end
						end
					end
				end
			end
		end

		return arg_173_2
	end

	function arg_1_0:__add_speed_by_buff_skill(arg_174_1, arg_174_2, arg_174_3, arg_174_4)
		local var_174_0 = arg_174_1[arg_174_4].data
		local var_174_1 = var_0_11.find_object_by_skill_type_skill_level(arg_174_1[arg_174_4].data.now_skill, arg_174_1[arg_174_4].data.skill_level)

		if not var_174_1 then
			return
		end

		if not var_174_1.pre_effect[1] then
			return
		end

		for iter_174_0, iter_174_1 in pairs(var_174_1.pre_effect) do
			local var_174_2 = false

			if iter_174_1.condition then
				for iter_174_2, iter_174_3 in pairs(iter_174_1.condition) do
					if iter_174_3.type == 43 then
						local var_174_3 = true

						for iter_174_4, iter_174_5 in pairs(arg_174_1) do
							if iter_174_5.data.id ~= var_174_0.id then
								for iter_174_6, iter_174_7 in pairs(iter_174_3.shipTypes) do
									if iter_174_5.data.type == iter_174_7 then
										var_174_3 = false
									end
								end
							end
						end

						var_174_2 = var_174_3
					elseif iter_174_3.type == 26 and arg_174_4 == 1 then
						var_174_2 = true
					end
				end
			else
				var_174_2 = true
			end

			if var_174_2 == false then
				return
			end

			for iter_174_8, iter_174_9 in pairs(iter_174_1.target) do
				if iter_174_9.type == 2 then
					for iter_174_10, iter_174_11 in pairs(iter_174_9.shipTypes) do
						if arg_174_1[arg_174_4 - 1] and arg_174_1[arg_174_4 - 1].data.type == iter_174_11 then
							self:__add_speed_by_skill_by_effect(arg_174_2, arg_174_3, iter_174_1.effect, arg_174_4 - 1)
						end

						if arg_174_1[arg_174_4 + 1] and arg_174_1[arg_174_4 + 1].data.type == iter_174_11 then
							self:__add_speed_by_skill_by_effect(arg_174_2, arg_174_3, iter_174_1.effect, arg_174_4 + 1)
						end
					end
				elseif iter_174_9.type == 4 then
					local var_174_4 = 0

					for iter_174_12, iter_174_13 in pairs(arg_174_1) do
						if iter_174_13.data.id == var_174_0.id then
							var_174_4 = iter_174_12
						end
					end

					for iter_174_14, iter_174_15 in pairs(arg_174_1) do
						if iter_174_14 < var_174_4 and iter_174_14 >= var_174_4 - iter_174_9.num then
							self:__add_speed_by_skill_by_effect(arg_174_2, arg_174_3, iter_174_1.effect, iter_174_14)
						end
					end
				elseif iter_174_9.type == 7 then
					self:__add_speed_by_skill_by_effect(arg_174_2, arg_174_3, iter_174_1.effect, arg_174_4)
				elseif iter_174_9.type == 8 then
					for iter_174_16, iter_174_17 in pairs(arg_174_1) do
						self:__add_speed_by_skill_by_effect(arg_174_2, arg_174_3, iter_174_1.effect, iter_174_16)
					end
				elseif iter_174_9.type == 10 then
					for iter_174_18, iter_174_19 in pairs(arg_174_1) do
						local var_174_5 = var_0_6.find_object_by_cid(iter_174_19.data.cid)

						if var_174_5 then
							for iter_174_20, iter_174_21 in pairs(iter_174_9.country) do
								if var_174_5.country == iter_174_21 then
									self:__add_speed_by_skill_by_effect(arg_174_2, arg_174_3, iter_174_1.effect, iter_174_18)
								end
							end
						end
					end
				elseif iter_174_9.type == 11 or iter_174_9.type == 12 then
					for iter_174_22, iter_174_23 in pairs(arg_174_1) do
						local var_174_6 = var_0_6.find_object_by_cid(iter_174_23.data.cid)

						if var_174_6 then
							local var_174_7 = false

							for iter_174_24, iter_174_25 in pairs(iter_174_9.shipTypes or {}) do
								if var_174_6.type == iter_174_25 then
									var_174_7 = true

									break
								end
							end

							if not var_174_7 then
								for iter_174_26, iter_174_27 in pairs(iter_174_9.shipTons or {}) do
									if var_174_6.ship_ton == iter_174_27 then
										var_174_7 = true

										break
									end
								end
							end

							if not var_174_7 then
								for iter_174_28, iter_174_29 in pairs(iter_174_9.guardTypes or {}) do
									if var_174_6.guard_type == iter_174_29 then
										var_174_7 = true

										break
									end
								end
							end

							local var_174_10 = true

							if iter_174_9.type == 12 then
								var_174_10 = false

								for iter_174_30, iter_174_31 in pairs(iter_174_9.country or {}) do
									if var_174_6.country == iter_174_31 then
										var_174_10 = true

										break
									end
								end
							end

							if var_174_7 and var_174_10 then
								self:__add_speed_by_skill_by_effect(arg_174_2, arg_174_3, iter_174_1.effect, iter_174_22)
							end
						end
					end
				end
			end
		end
	end

	function arg_1_0.__add_radar_by_skill_by_effect(arg_175_0, arg_175_1, arg_175_2, arg_175_3)
		for iter_175_0, iter_175_1 in pairs(arg_175_1) do
			if iter_175_1.type == 3 and iter_175_1.radar then
				arg_175_3 = arg_175_3 + iter_175_1.radar * arg_175_2
			end
		end

		arg_175_0._now_radar = arg_175_3
	end

	function arg_1_0.__add_speed_by_skill_by_effect(arg_176_0, arg_176_1, arg_176_2, arg_176_3, arg_176_4)
		for iter_176_0, iter_176_1 in pairs(arg_176_3) do
			if iter_176_1.type == 3 and iter_176_1.speed then
				arg_176_1[arg_176_4].speed_num = arg_176_1[arg_176_4].speed_num + iter_176_1.speed
				arg_176_1[arg_176_4].add_by_skill = true
			elseif iter_176_1.type == 3 and iter_176_1.radar then
				arg_176_2[arg_176_4].radar_num = arg_176_2[arg_176_4].radar_num + iter_176_1.radar
			end
		end
	end

	function arg_1_0.__add_restaurant_attr(arg_177_0, arg_177_1, arg_177_2)
		local var_177_0 = 0
		local var_177_1 = var_0_3:get_restaurant_cookbook_buff()

		if not var_177_1 then
			return var_177_0
		end

		local var_177_2

		if lx.ServerTime:getUtcTime() < var_177_1.end_time then
			var_177_2 = var_0_22.find_object_by_cid(var_177_1.id)
		end

		if not var_177_2 then
			return var_177_0
		end

		local var_177_3 = var_0_6.find_object_by_cid(var_0_3:find_character_by_id(arg_177_2).cid)

		if not var_177_3 then
			return var_177_0
		end

		local var_177_4 = var_177_2.effect.attr
		local var_177_5 = var_177_2.effect.value
		local var_177_6 = var_177_1.end_time >= lx.ServerTime:getUtcTime()

		if var_177_4 == arg_177_1 and (var_177_2.effect.type == 5 or var_177_2.effect.type == 6) then
			local var_177_7 = var_177_2.effect.country or 0
			local var_177_8 = var_177_2.effect.ship_type or 0
			local var_177_9 = var_177_2.effect.ship_ton or 0

			if (var_177_8 == 0 or var_177_8 == var_177_3.type) and (var_177_7 == 0 or var_177_7 == var_177_3.country) and (var_177_9 == 0 or var_177_9 == var_177_3.ship_ton) then
				var_177_0 = var_177_5
			end
		end

		return var_177_0
	end

	function arg_1_0.__add_racing_attr(arg_178_0, arg_178_1, arg_178_2)
		local var_178_0 = 0
		local var_178_1 = var_0_3:get_dormitory_race_buff()

		if not var_178_1 then
			return var_178_0
		end

		local var_178_2

		if (lx.ServerTime:getUtcTime() or 0) < var_178_1.end_time then
			var_178_2 = var_0_23.find_object_by_cid(var_178_1.id)
		end

		if not var_178_2 then
			return var_178_0
		end

		local var_178_3 = var_0_6.find_object_by_cid(var_0_3:find_character_by_id(arg_178_2).cid)

		if not var_178_3 then
			return var_178_0
		end

		local var_178_4 = var_178_2.buff
		local var_178_5 = var_178_2.buff.ship_type or 0
		local var_178_6 = var_178_4.shipTon or 0

		if var_0_4:get_attr_name(var_178_4.num4) == arg_178_1 and var_178_4.type == 1 and (var_178_5 == 0 or var_178_5 == var_178_3.type) and (var_178_1.country == 0 or var_178_1.country == var_178_3.country) and (var_178_6 == 0 or var_178_6 == var_178_3.ship_ton) then
			var_178_0 = var_178_2.buff.num
		end

		return var_178_0
	end

	function arg_1_0:__update_support_info(arg_179_1, arg_179_2, arg_179_3, arg_179_4)
		self._control.support_layer:SetActive(not self._control.support_layer.activeSelf)

		if self._control.support_layer.activeSelf then
			self:__show_support_info(arg_179_1, arg_179_2, arg_179_3, arg_179_4)
		end
	end

	function arg_1_0:__show_support_info(arg_180_1, arg_180_2, arg_180_3, arg_180_4)
		local var_180_0 = self._control.support_layer.support_bg

		self._control.support_layer.support_bg.card_bg.icon_btn.image.sprite = self:loadSprite(var_0_12(var_0_4.support_icon_list.support_s_icon, arg_180_3.id))
		var_180_0.info_title_text.text.text = arg_180_3.title
		var_180_0.info_text.text.text = var_0_5.convert_rich_text(arg_180_3.effect_desc)

		if arg_180_4 and arg_180_2 < 10 then
			var_180_0.get_btn.get_text.text.text = var_0_1:getNowLang("ui_support_card_open") or var_0_1:getNowLang("ui_support_card_close")
		end

		if arg_180_2 > 10 then
			arg_180_2 = 10
		end

		var_180_0.limit_count.text.text = var_0_12(var_0_1:getNowLang("ui_today_support_card_num"), 10 - arg_180_2)
		var_180_0.card_bg.image.sprite = self:loadSprite(var_0_12(var_0_4.s_card_bg, arg_180_3.quality))
		self._control.parent.support_icon_bg.image.sprite = self:loadSprite(arg_180_4 and (arg_180_2 < 10 and var_0_4.pve_support_card_1 or var_0_4.pve_support_card_2) or arg_180_4 == false and arg_180_2 == 10 and var_0_4.pve_support_card_2 or arg_180_4 == true and arg_180_2 == 10 and var_0_4.pve_support_card_2 or var_0_4.pve_support_card)
	end

	function arg_1_0:__update_support_active_info()
		local var_181_0, var_181_1, var_181_2, var_181_3 = var_0_3:get_support_notify()
		local var_181_4

		if var_181_1 < 10 then
			if var_181_3 then
				var_181_4 = var_181_1 < 10 and var_0_4.pve_support_card_1 or var_0_4.pve_support_card_2

				if var_181_1 < 10 then
					self._control.support_layer.support_bg.get_btn.get_text.text.text = var_0_1:getNowLang("ui_support_card_open") or var_0_1:getNowLang("ui_support_card_close")
				end
			else
				var_181_4 = var_0_4.pve_support_card
				self._control.support_layer.support_bg.get_btn.get_text.text.text = var_0_1:getNowLang("ui_support_card_close")
			end
		else
			var_181_4 = var_0_4.pve_support_card_2
		end

		self._control.parent.support_icon_bg.image.sprite = self:loadSprite(var_181_4)
	end

	function arg_1_0:update_support_change()
		local var_182_0, var_182_1, var_182_2, var_182_3 = var_0_3:get_support_notify()

		self:__show_support_info(var_182_0, var_182_1, var_182_0 and var_0_28.find_object_by_id(var_182_0) or var_0_28.find_object_by_sequence_index(1), var_182_3)
	end

	function arg_1_0:__set_total_supply_panel_data()
		self._total_oil_need = 0
		self._total_bullet_need = 0
		self._total_aluminium_need = 0

		if self._fight_prepare_type == var_0_4.fight_type.war_concerto_play or self._fight_prepare_type == var_0_4.fight_type.mist_attack then
			return
		end

		if self:get_team_type() == var_0_4.team_type.abyss_team then
			return
		end

		local var_183_0 = var_0_3:get_supportInfo_data(self._go_to_map_id)
		local var_183_1 = 0
		local var_183_2 = 0
		local var_183_3 = 0

		if var_183_0 and next(var_183_0) and self._support_atk_list then
			var_183_1 = self._support_atk_list[2].maxnum * 10 - var_183_0.oil
			var_183_2 = self._support_atk_list[3].maxnum * 10 - var_183_0.bullet
			var_183_3 = self._support_atk_list[1].maxnum * 10 - var_183_0.al
		end

		for iter_183_0, iter_183_1 in pairs(self._ship_item_list) do
			local var_183_4 = iter_183_1:get_supply_need()

			self._total_oil_need = self._total_oil_need + var_183_4.oil_need < 0 and 0 or self._total_oil_need + var_183_4.oil_need
			self._total_bullet_need = self._total_bullet_need + var_183_4.bullet_need < 0 and 0 or self._total_bullet_need + var_183_4.bullet_need
			self._total_aluminium_need = self._total_aluminium_need + var_183_4.aluminium_need < 0 and 0 or self._total_aluminium_need + var_183_4.aluminium_need
		end

		if not self._support_supply_full then
			self._total_oil_need = self._total_oil_need + var_183_1
			self._total_bullet_need = self._total_bullet_need + var_183_2
			self._total_aluminium_need = self._total_aluminium_need + var_183_3
		end

		local var_183_5 = var_0_3:get_use_info_data()

		self._control.right_widget.bg_back.supply_panel.supply1.count.text.text = var_0_5.get_simplify_num(var_0_32(self._total_oil_need))
		self._control.right_widget.bg_back.supply_panel.supply1.total.text.text = var_0_5.get_simplify_num(var_183_5.oil)
		self._control.right_widget.bg_back.supply_panel.supply2.count.text.text = var_0_5.get_simplify_num(var_0_32(self._total_bullet_need))
		self._control.right_widget.bg_back.supply_panel.supply2.total.text.text = var_0_5.get_simplify_num(var_183_5.bullet)
		self._control.right_widget.bg_back.supply_panel.supply3.count.text.text = var_0_5.get_simplify_num(var_0_32(self._total_aluminium_need))
		self._control.right_widget.bg_back.supply_panel.supply3.total.text.text = var_0_5.get_simplify_num(var_183_5.al)
	end

	function arg_1_0:__set_total_repair_panel_data()
		if self._is_nf then
			return
		end

		self._total_oil_need = 0
		self._total_steel_need = 0
		self._total_repair_item_need = 0

		for iter_184_0, iter_184_1 in pairs(self._ship_item_list) do
			local var_184_0 = iter_184_1:get_quick_repair_need()

			self._total_oil_need = self._total_oil_need + var_184_0.oil_need
			self._total_steel_need = self._total_steel_need + var_184_0.steel_need
			self._total_repair_item_need = self._total_repair_item_need + var_184_0.repair_item_need
		end

		local var_184_1 = 1

		for iter_184_2, iter_184_3 in pairs((var_0_3:get_bathroom_style())) do
			var_184_1 = var_184_1 * var_0_48.find_object_by_id(iter_184_3).effect.res
		end

		local var_184_2 = var_0_3:get_use_info_data()

		self._control.right_widget.bg_back.repair_panel.repair1.count.text.text = var_0_5.get_simplify_num(var_0_33(self._total_oil_need * var_184_1))
		self._control.right_widget.bg_back.repair_panel.repair1.total.text.text = var_0_5.get_simplify_num(var_184_2.oil)
		self._control.right_widget.bg_back.repair_panel.repair2.count.text.text = var_0_5.get_simplify_num(var_0_33(self._total_steel_need * var_184_1))
		self._control.right_widget.bg_back.repair_panel.repair2.total.text.text = var_0_5.get_simplify_num(var_184_2.fe)
		self._control.right_widget.bg_back.repair_panel.repair_info.count.text.text = var_0_5.get_simplify_num(var_0_32(self._total_repair_item_need))
		self._control.right_widget.bg_back.repair_panel.repair_info.total.text.text = var_0_5.get_simplify_num(self:__get_quick_repair_item_count())
	end

	function arg_1_0:__set_condition_panel_data()
		local var_185_0 = false
		local var_185_1 = false
		local var_185_2 = {}

		for iter_185_0 = 1, 2 do
			var_185_2[#var_185_2 + 1] = {
				has_type_condition = false,
				type_condition_ok = false
			}
		end

		local var_185_3 = var_0_16(0.05, 0.55, 0.9)
		local var_185_4 = var_0_16(0.42, 0.49, 0.56)
		local var_185_5 = false

		for iter_185_1, iter_185_2 in pairs(self._team_detail_data) do
			if iter_185_2.data.state == var_0_4.ship_state.expedition then
				var_185_5 = true
			end
		end

		self._control.right_widget.bg_back.condition_panel.first_ship_condition.condition_txt.text.text = var_0_12(var_0_1:getNowLang("pveexploreneedflaglevel"), self._farfight_data.need_flag_ship_level)

		local var_185_6 = var_185_4
		local var_185_7 = "data/ui/combat/combat_selec2.png"

		if self._team_detail_data[1] and self._farfight_data.need_flag_ship_level <= self._team_detail_data[1].data.level then
			var_185_0 = true
			var_185_6 = var_185_3
			var_185_7 = "data/ui/combat/combat_selec.png"
		end

		self._control.right_widget.bg_back.condition_panel.first_ship_condition.condition_txt.text.color = var_185_6
		self._control.right_widget.bg_back.condition_panel.first_ship_condition.ok_icon.image.sprite = self:loadSprite(var_185_7)
		self._control.right_widget.bg_back.condition_panel.first_ship_condition.canvasGroup.alpha = 1
		self._control.right_widget.bg_back.condition_panel.ship_num_condition.condition_txt.text.text = var_0_12("%d+", self._farfight_data.need_ship_num)

		local var_185_8 = var_185_4
		local var_185_9 = "data/ui/combat/combat_selec2.png"

		if self._farfight_data.need_ship_num <= #self._team_detail_data then
			var_185_1 = true
			var_185_8 = var_185_3
			var_185_9 = "data/ui/combat/combat_selec.png"
		end

		self._control.right_widget.bg_back.condition_panel.ship_num_condition.condition_txt.text.color = var_185_8
		self._control.right_widget.bg_back.condition_panel.ship_num_condition.ok_icon.image.sprite = self:loadSprite(var_185_9)
		self._control.right_widget.bg_back.condition_panel.ship_num_condition.canvasGroup.alpha = 1

		for iter_185_3 = 1, 2 do
			if self._farfight_data.need_ship_type[iter_185_3] then
				var_185_2[iter_185_3].has_type_condition = true
				self._control.right_widget.bg_back.condition_panel[var_0_12("ship_type_condition%d", iter_185_3)].title.text.text = var_0_1:getNowLang(var_0_4:get_ship_type_language_key(self._farfight_data.need_ship_type[iter_185_3].type, 1))
				self._control.right_widget.bg_back.condition_panel[var_0_12("ship_type_condition%d", iter_185_3)].condition_txt.text.text = var_0_12("x%d", self._farfight_data.need_ship_type[iter_185_3].count)

				local var_185_10 = var_185_4
				local var_185_11 = "data/ui/combat/combat_selec2.png"

				if self._farfight_data.need_ship_type[iter_185_3].count <= self:__get_ship_type_num(self._farfight_data.need_ship_type[iter_185_3].type) then
					var_185_2[iter_185_3].type_condition_ok = true
					var_185_10 = var_185_3
					var_185_11 = "data/ui/combat/combat_selec.png"
				end

				self._control.right_widget.bg_back.condition_panel[var_0_12("ship_type_condition%d", iter_185_3)].condition_txt.text.color = var_185_10
				self._control.right_widget.bg_back.condition_panel[var_0_12("ship_type_condition%d", iter_185_3)].ok_icon.image.sprite = self:loadSprite(var_185_11)
				self._control.right_widget.bg_back.condition_panel[var_0_12("ship_type_condition%d", iter_185_3)].canvasGroup.alpha = 1
			else
				self._control.right_widget.bg_back.condition_panel[var_0_12("ship_type_condition%d", iter_185_3)].canvasGroup.alpha = 0
			end
		end

		self._farfight_condition.is_ok = true

		if var_185_5 then
			self._farfight_condition.is_ok = false
			self._farfight_condition.not_ok_info = var_0_1:getNowLang("noticefleetisinexplore")
		elseif #self._team_detail_data == 0 then
			self._farfight_condition.is_ok = false
			self._farfight_condition.not_ok_info = var_0_1:getNowLang("team_not_ship")
		elseif not var_185_0 then
			self._farfight_condition.is_ok = false
			self._farfight_condition.not_ok_info = var_0_1:getNowLang("flagshiplevelnotenough")
		elseif not var_185_1 then
			self._farfight_condition.is_ok = false
			self._farfight_condition.not_ok_info = var_0_1:getNowLang("errorcode_167")
		else
			for iter_185_4 = 1, 2 do
				if var_185_2[iter_185_4].has_type_condition and not var_185_2[iter_185_4].type_condition_ok then
					self._farfight_condition.is_ok = false
					self._farfight_condition.not_ok_info = var_0_1:getNowLang("errorcode_168")
				end
			end
		end
	end

	function arg_1_0:__update_strike_buffs()
		local var_186_0 = var_0_3:get_strike_point_info()
		local var_186_1 = var_0_18(var_186_0)
		local var_186_2 = var_0_18(var_186_0)
		local var_186_3 = var_0_3:get_save_buff()

		self._current_strike_buffs = {}

		if var_186_1.buffs and next(var_186_1.buffs) or var_186_3 and next(var_186_3) then
			var_186_2.buffs = var_186_2.buffs or {}

			if var_186_3 then
				if var_186_1.buffs and #var_186_1.buffs > 0 then
					for iter_186_0 = 1, #var_186_1.buffs do
						for iter_186_1, iter_186_2 in pairs(var_186_1.buffs) do
							if iter_186_2.point_id == var_186_1.next_point_id then
								var_0_13(var_186_1.buffs, iter_186_1)
							end
						end
					end

					var_186_2 = var_0_18(var_186_1)
				end

				for iter_186_3, iter_186_4 in pairs(var_186_3) do
					local var_186_4 = false

					if var_186_2.buffs then
						for iter_186_5, iter_186_6 in pairs(var_186_2.buffs) do
							if iter_186_6.id == iter_186_4.id then
								var_186_4 = true
							end
						end
					end

					if not var_186_4 then
						var_0_14(var_186_2.buffs, iter_186_4)
					end
				end
			end

			var_0_19(var_186_2.buffs, function(arg_187_0, arg_187_1)
				return arg_187_0.id < arg_187_1.id
			end)

			if var_186_2.buffs and next(var_186_2.buffs) and var_186_2.buffs[#var_186_2.buffs].id == 10000 then
				var_0_14(var_186_2.buffs, 1, var_186_2.buffs[#var_186_2.buffs])
				var_0_13(var_186_2.buffs)
			end

			self._current_strike_buffs = var_0_18(var_186_2.buffs)
		elseif self.__strike_is_deal == true then
			local var_186_5 = var_0_29.find_object_by_id(self._go_to_map_id)
			local var_186_6 = var_0_3:get_strike_data_by_level(self._go_to_map_id)

			if var_186_6 then
				local var_186_7

				if var_186_6.score >= var_186_5.hard_score then
					var_186_7 = var_186_5.emergent_buff2 or var_186_5.emergent_buff

					local var_186_8

					if var_186_6.score >= var_186_5.hard_score then
						var_186_8 = var_186_5.emergent_score2 or var_186_5.emergent_score
					end
				end

				local var_186_9 = {}

				for iter_186_7, iter_186_8 in pairs(var_186_7) do
					var_0_14(var_186_9, {
						id = iter_186_8,
						score = var_186_8
					})
				end

				self._current_strike_buffs = var_0_18(var_186_9)
			else
				local var_186_10 = {}

				for iter_186_9, iter_186_10 in pairs(var_186_5.emergent_buff) do
					var_0_14(var_186_10, {
						id = iter_186_10,
						score = var_186_5.emergent_score
					})
				end

				self._current_strike_buffs = var_0_18(var_186_10)
			end
		elseif self.__strike_is_deal == false then
			self._current_strike_buffs = {}
		end
	end

	function arg_1_0:__set_campaign_panel_data()
		self._control.right_widget.bg_back.campaign.campaign_name.text.text = self._campagion_data.title

		if self._difficulty == var_0_4.map_campaign_difficulty.normal then
			self._control.right_widget.bg_back.campaign.difficulty.text.text = var_0_1:getNowLang("pvecampaigneasy") or var_0_1:getNowLang("pvecampaignhard")
		end

		self._control.right_widget.bg_back.campaign.campaign_info_panel.Viewport.content.campaign_info.text.text = self._campagion_data.desc
	end

	function arg_1_0:__get_ship_type_num(arg_189_1)
		local var_189_0 = 0

		for iter_189_0, iter_189_1 in pairs(self._team_detail_data) do
			if iter_189_1.data.type == arg_189_1 then
				var_189_0 = var_189_0 + 1
			end
		end

		return var_189_0
	end

	function arg_1_0.__get_quick_repair_item_count(arg_190_0)
		local var_190_1 = var_0_3:get_item(var_0_4.quick_repair_item_cid)

		return (var_190_1 or nil) and (var_190_1.count or 0)
	end

	function arg_1_0:__toggle_right_panel(arg_191_1)
		if arg_191_1 == self._current_content_type then
			return
		end

		self._current_content_type = arg_191_1

		for iter_191_0, iter_191_1 in pairs(self._ship_item_list) do
			iter_191_1:toggle_item_type(arg_191_1)
		end

		if arg_191_1 == var_0_4.fight_prepare_right_panel_type.tower then
			self:__change_right_bg(2)
		elseif self._fight_prepare_type == var_0_4.fight_type.tower_fight then
			self:__change_right_bg(1)
		end

		self:__play_right_panel_toggle_animation(arg_191_1)
	end

	function arg_1_0:__change_right_bg(arg_192_1)
		if not arg_192_1 then
			return
		end

		local var_192_0 = self._control.right_widget.bg_back.image

		if arg_192_1 == 1 then
			var_192_0.sprite = self:loadSprite(var_0_4.pve_prepare_info_bg)
		elseif arg_192_1 == 2 then
			var_192_0.sprite = self:loadSprite(var_0_12(var_0_4.tower_prepare, "info_bg"))

			if self._control.right_widget.bg_back.tower_info.toggle_layer.toggle.isOn then
				self._control.right_widget.bg_back.tower_info.toggle_layer.toggle.isOn = false
				self._control.right_widget.bg_back.tower_info.toggle_info.toggle.isOn = true
			end
		end
	end

	function arg_1_0:__hide_all_right_panel()
		self._control.right_widget.bg_back.speed_skeleton_mask.speed_skeleton:SetActive(false)
		self._control.right_widget.bg_back.tower_info:SetActive(false)

		self._control.right_widget.bg_back.props_panel.canvasGroup.alpha = 0
		self._control.right_widget.bg_back.props_panel.canvasGroup.blocksRaycasts = false
		self._control.right_widget.bg_back.supply_panel.canvasGroup.alpha = 0
		self._control.right_widget.bg_back.supply_panel.canvasGroup.blocksRaycasts = false
		self._control.right_widget.bg_back.repair_panel.canvasGroup.alpha = 0
		self._control.right_widget.bg_back.repair_panel.canvasGroup.blocksRaycasts = false
		self._control.right_widget.bg_back.condition_panel.canvasGroup.alpha = 0
		self._control.right_widget.bg_back.condition_panel.canvasGroup.blocksRaycasts = false
		self._control.right_widget.bg_back.campaign.canvasGroup.alpha = 0
		self._control.right_widget.bg_back.campaign.canvasGroup.blocksRaycasts = false
		self._control.right_widget.bg_back.sixth_panel.canvasGroup.alpha = 0
		self._control.right_widget.bg_back.sixth_panel.canvasGroup.blocksRaycasts = false
		self._control.right_widget.bg_back.strike_info.canvasGroup.alpha = 0
		self._control.right_widget.bg_back.strike_info.canvasGroup.blocksRaycasts = false
		self._control.right_widget.bg_back.ocean_panel.canvasGroup.alpha = 0
		self._control.right_widget.bg_back.ocean_panel.canvasGroup.blocksRaycasts = false
		self._control.right_widget.bg_back.ninth_info.canvasGroup.alpha = 0
		self._control.right_widget.bg_back.ninth_info.canvasGroup.blocksRaycasts = false
		self._control.right_widget.bg_back.abyss_panel.canvasGroup.alpha = 0
		self._control.right_widget.bg_back.abyss_panel.canvasGroup.blocksRaycasts = false
	end

	function arg_1_0:__show_props_panel()
		self:__hide_all_right_panel()

		self._control.right_widget.bg_back.abyss_panel.canvasGroup.alpha = 1
		self._control.right_widget.bg_back.abyss_panel.canvasGroup.blocksRaycasts = true

		self._control.right_widget.bg_back.speed_skeleton_mask.speed_skeleton:SetActive(true)

		self._control.right_widget.bg_back.props_panel.canvasGroup.alpha = 1
		self._control.right_widget.bg_back.props_panel.canvasGroup.blocksRaycasts = true
	end

	function arg_1_0:__show_supply_panel()
		self:__hide_all_right_panel()

		self._control.right_widget.bg_back.supply_panel.title.text.text = var_0_1:getNowLang("pvesupplycost")
		self._control.right_widget.bg_back.supply_panel.supply1.title.text.text = var_0_1:getNowLang("item2")
		self._control.right_widget.bg_back.supply_panel.supply2.title.text.text = var_0_1:getNowLang("item3")
		self._control.right_widget.bg_back.supply_panel.supply3.title.text.text = var_0_1:getNowLang("item9")
		self._control.right_widget.bg_back.supply_panel.supply_all_btn.text.text.text = var_0_1:getNowLang("pvesupplyall")
		self._control.right_widget.bg_back.supply_panel.canvasGroup.alpha = 1
		self._control.right_widget.bg_back.supply_panel.canvasGroup.blocksRaycasts = true
	end

	function arg_1_0:__show_repair_panel()
		self:__hide_all_right_panel()

		self._control.right_widget.bg_back.repair_panel.canvasGroup.alpha = 1
		self._control.right_widget.bg_back.repair_panel.canvasGroup.blocksRaycasts = true
	end

	function arg_1_0:__show_condition_panel()
		self:__hide_all_right_panel()

		self._control.right_widget.bg_back.condition_panel.title.text.text = var_0_1:getNowLang("ui_pvepreparetip4")
		self._control.right_widget.bg_back.condition_panel.first_ship_condition.title.text.text = var_0_1:getNowLang("ui_pvepreparetip2")
		self._control.right_widget.bg_back.condition_panel.ship_num_condition.title.text.text = var_0_1:getNowLang("ui_pvepreparetip3")
		self._control.right_widget.bg_back.condition_panel.canvasGroup.alpha = 1
		self._control.right_widget.bg_back.condition_panel.canvasGroup.blocksRaycasts = true
	end

	function arg_1_0:__show_campaign_panel()
		self:__hide_all_right_panel()

		self._control.right_widget.bg_back.campaign.canvasGroup.alpha = 1
		self._control.right_widget.bg_back.campaign.canvasGroup.blocksRaycasts = true
	end

	function arg_1_0:__show_sixth_panel()
		self:__hide_all_right_panel()

		self._control.right_widget.bg_back.sixth_panel.canvasGroup.alpha = 1
		self._control.right_widget.bg_back.sixth_panel.canvasGroup.blocksRaycasts = true
	end

	function arg_1_0:__show_ocean_panel()
		self:__hide_all_right_panel()

		self._control.right_widget.bg_back.ocean_panel.canvasGroup.alpha = 1
		self._control.right_widget.bg_back.ocean_panel.canvasGroup.blocksRaycasts = true

		self:__update_ocean_map_reusable_cell(self._map_id)
	end

	function arg_1_0.__show_score_panel(arg_201_0)
		return
	end

	function arg_1_0:__show_strike_panel()
		self:__hide_all_right_panel()
		self._control.right_widget.bg_back.strike_info:SetActive(true)

		self._control.right_widget.bg_back.strike_info.toggle_info.bg.title.text.text = var_0_1:getNowLang("pvepreparetotalprops")
		self._control.right_widget.bg_back.strike_info.toggle_buff.bg.title.text.text = var_0_1:getNowLang("currentsituation")

		self._control.right_widget.bg_back.strike_info.radar_chart_bg:SetActive(false)
		self._control.right_widget.bg_back.strike_info.speed_info_panel:SetActive(false)
		self:__select_strike_toggle("toggle_buff")
	end

	function arg_1_0:__show_ninth_panel()
		self:__hide_all_right_panel()
		self._control.right_widget.bg_back.ninth_info:SetActive(true)

		self._control.right_widget.bg_back.ninth_info.ninth_toggle_info.ninth_bg.ninth_title.text.text = var_0_1:getNowLang("pvepreparetotalprops")
		self._control.right_widget.bg_back.ninth_info.ninth_toggle_buff.ninth_bg.ninth_title.text.text = var_0_1:getNowLang("currentsituation")
		self._control.right_widget.bg_back.ninth_info.canvasGroup.alpha = 1
		self._control.right_widget.bg_back.ninth_info.canvasGroup.blocksRaycasts = true

		if self._control.right_widget.bg_back.ninth_info.ninth_toggle_info.toggle.isOn == true then
			self._control.right_widget.bg_back.speed_skeleton_mask.speed_skeleton:SetActive(true)
			self._control.right_widget.bg_back.ninth_info.ninth_speed_info_panel:SetActive(true)
			self._control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg:SetActive(true)
		else
			self._control.right_widget.bg_back.speed_skeleton_mask.speed_skeleton:SetActive(false)
			self._control.right_widget.bg_back.ninth_info.ninth_speed_info_panel:SetActive(false)
			self._control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg:SetActive(false)
		end
	end

	function arg_1_0:__show_tower_fight_panel()
		self:__hide_all_right_panel()
		self._control.right_widget.bg_back.tower_info:SetActive(true)

		self._control.right_widget.bg_back.tower_info.toggle_info.bg.title.text.text = var_0_1:getNowLang("ui_tower_prepare_buff_tab_1")
		self._control.right_widget.bg_back.tower_info.toggle_layer.bg.title.text.text = var_0_1:getNowLang("ui_tower_prepare_buff_tab_2")

		self:__select_tower_toggle(var_0_4.tower_toggle.enemy_info)
	end

	function arg_1_0:__update_tower_enemy()
		local var_205_0 = var_0_26.find_object_by_id(self._tower_monster)

		if var_205_0 then
			local var_205_1 = 0

			for iter_205_0, iter_205_1 in pairs(var_205_0.formation) do
				local var_205_2 = var_0_27.find_object_by_id(iter_205_1)
				local var_205_3
				local var_205_4

				if self._fight_tower_list[iter_205_0] then
					var_205_3 = self._fight_tower_list[iter_205_0].fight_info_item_obj
					var_205_4 = self._fight_tower_list[iter_205_0].fight_info_item_control
				else
					var_205_3, var_205_4 = self:loadUIPrefab("tower_enemy_cell", self._control.right_widget.bg_back.tower_info.enemy_listscrollview.content.enemy_list.rectTransform)
				end

				var_205_3:setVisible(true)

				var_205_4.ship_type.text.text = var_0_1:getNowLang(var_0_4:get_ship_type_language_key(var_205_2.type, 1))
				var_205_4.ship_icon.image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.ship_icon.model_normal_s, var_205_2.pic_id))
				self._fight_tower_list[iter_205_0] = {
					fight_info_item_obj = var_205_3,
					fight_info_item_control = var_205_4
				}
				var_205_1 = var_205_1 + 1
			end

			for iter_205_2 = var_205_1 + 1, #self._fight_tower_list do
				self._fight_tower_list[iter_205_2].fight_info_item_obj:setVisible(false)
			end

			self._control.right_widget.bg_back.tower_info.enemy_listscrollview.content.enemy_info_des.rectTransform.anchoredPosition = var_0_15(self._control.right_widget.bg_back.tower_info.enemy_listscrollview.content.enemy_info_des.rectTransform.anchoredPosition.x, self._control.right_widget.bg_back.tower_info.enemy_listscrollview.content.enemy_list.rectTransform.anchoredPosition.y - (math.floor((var_205_1 + 1) / 2) * 69 + 16.675 - 9))
		end
	end

	function arg_1_0:__update_tower_buff()
		if not self._tower_buff_canvas_group then
			self._tower_buff_canvas_group = var_0_5.get_or_add_canvas_group_component_to_it(self._control.tower_buff)
			self._tower_buff_canvas_group.alpha = 0

			self._control.tower_buff:SetActive(true)
		end

		local var_206_0 = var_0_3:get_tower_chip_info()
		local var_206_1 = false

		for iter_206_0 = 1, self._control.tower_buff.buff_parent.transform.childCount do
			local var_206_2 = self._control.tower_buff.buff_parent[var_0_12("single_buff_cell%s", iter_206_0)]

			if var_206_0.slot[iter_206_0] and var_206_0.slot[iter_206_0] ~= 0 then
				var_206_2.gameObject:SetActive(true)

				local var_206_3 = var_0_24.find_object_by_id(var_206_0.slot[iter_206_0])

				var_206_2.buff_icon.image.sprite = self:loadSprite(var_0_12(var_0_4.tactical_buff_icon, var_206_3.icon))
				var_206_2.single_bg.image.sprite = self:loadSprite(var_0_12(var_0_4.buff_small_bg, (var_206_3.quality == 4 or nil) and "2"))
				var_206_2.buff_name.text.text = var_206_3.title
				var_206_2.buff_info.text.text = var_0_5.convert_rich_text(var_206_3.desc1)
				var_206_1 = true
			else
				var_206_2.gameObject:SetActive(false)
			end
		end

		if var_206_1 then
			self._tower_buff_canvas_group.alpha = self._tower_buff_canvas_group.alpha == 1 and 0 or 1
			self._tower_buff_canvas_group.blocksRaycasts = self._tower_buff_canvas_group.alpha == 1
		else
			var_0_35:show(var_0_1:getNowLang("not_tower_buff"))
		end
	end

	function arg_1_0:__play_right_panel_toggle_animation(arg_207_1)
		if self._right_panel_tweener ~= nil then
			self._right_panel_tweener:Kill()
		end

		local var_207_0 = 0.2
		local var_207_1 = 0

		if self and self._control then
			self._right_panel_tweener = self._control.right_widget.bg_back.rectTransform:DOAnchorPos(var_0_15(300, 41), var_207_0):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(0):SetAutoKill(true)
		end

		if self._right_panel_tweener then
			function self._right_panel_tweener.onComplete()
				if arg_207_1 == var_0_4.fight_prepare_right_panel_type.props and not self._campaign then
					self:__show_props_panel()
				elseif arg_207_1 == var_0_4.fight_prepare_right_panel_type.supply then
					self:__show_supply_panel()
				elseif arg_207_1 == var_0_4.fight_prepare_right_panel_type.repair then
					self:__show_repair_panel()
				elseif arg_207_1 == var_0_4.fight_prepare_right_panel_type.supply then
					self:__show_props_panel()
				elseif arg_207_1 == var_0_4.fight_prepare_right_panel_type.condition then
					self:__show_condition_panel()
				elseif arg_207_1 == var_0_4.fight_prepare_right_panel_type.props and self._campaign then
					self:__show_campaign_panel()
				elseif arg_207_1 == var_0_4.fight_prepare_right_panel_type.sixth then
					self:__show_sixth_panel()
				elseif arg_207_1 == var_0_4.fight_prepare_right_panel_type.tower then
					self:__show_tower_fight_panel()
				elseif arg_207_1 == var_0_4.fight_prepare_right_panel_type.strike or arg_207_1 == var_0_4.fight_prepare_right_panel_type.strike_equip_preview then
					self:__show_strike_panel()
				elseif arg_207_1 == var_0_4.fight_prepare_right_panel_type.ocean_attack then
					self:__show_ocean_panel()
				elseif arg_207_1 == var_0_4.fight_prepare_right_panel_type.score_attack then
					self:__show_score_panel()
				elseif arg_207_1 == var_0_4.fight_prepare_right_panel_type.abyss_model then
					self:__show_props_panel()
				elseif arg_207_1 == var_0_4.fight_prepare_right_panel_type.equip_preview and not self._campaign then
					self:__show_props_panel()
				elseif arg_207_1 == var_0_4.fight_prepare_right_panel_type.equip_preview and self._campaign then
					self:__show_campaign_panel()
				elseif arg_207_1 == var_0_4.fight_prepare_right_panel_type.farfight_equip_preview then
					self:__show_condition_panel()
				elseif arg_207_1 == var_0_4.fight_prepare_right_panel_type.six_equip_preview then
					self:__show_sixth_panel()
				elseif arg_207_1 == var_0_4.fight_prepare_right_panel_type.ninth_preview or arg_207_1 == var_0_4.fight_prepare_right_panel_type.ninth_equip_preview then
					self:__show_ninth_panel()
				end

				self._right_panel_tweener = self._control.right_widget.bg_back.rectTransform:DOAnchorPos(var_0_15(-22, 41), var_207_0):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(var_207_1):SetAutoKill(true)
			end
		end
	end

	function arg_1_0:__play_in_animation()
		self._control.top_widget.top_widget_mask.image.raycastTarget = true

		local var_209_0 = 0.4

		self._control.top_widget.rectTransform.anchoredPosition = var_0_15(0, 70)
		self._control.bottom_widget.rectTransform.anchoredPosition = var_0_15(0, -100)
		self._control.left_widget.rectTransform.anchoredPosition = var_0_15(-950, 15)
		self._control.right_widget.rectTransform.anchoredPosition = var_0_15(320, 15)

		local var_209_2 = self:autoKillDOTween(var_0_43.Sequence())

		var_209_2:AppendInterval(0.2)
		var_209_2:AppendCallback(function()
			if self._control then
				self._control.top_widget.rectTransform:DOAnchorPos(var_0_15(0, 0), var_209_0 + 0.1):SetEase(DG.Tweening.Ease.OutCirc):SetAutoKill(true).onComplete = function()
					if self and self._control then
						self._control.top_widget.top_widget_mask.image.raycastTarget = false
					end
				end
			end
		end)
		var_209_2:SetLoops(1)
		var_209_2:Play()

		local var_209_4 = self:autoKillDOTween(var_0_43.Sequence())

		var_209_4:AppendInterval(0.2)
		var_209_4:AppendCallback(function()
			if self._control then
				self._control.bottom_widget.rectTransform:DOAnchorPos(var_0_15(0, 0), var_209_0):SetEase(DG.Tweening.Ease.OutCirc):SetAutoKill(true)
			end
		end)
		var_209_4:SetLoops(1)
		var_209_4:Play()

		local var_209_6 = self:autoKillDOTween(var_0_43.Sequence())

		var_209_6:AppendInterval(0.2)
		var_209_6:AppendCallback(function()
			if self._control then
				self._control.left_widget.rectTransform:DOAnchorPos(var_0_15(0, 15), var_209_0):SetEase(DG.Tweening.Ease.OutCirc):SetAutoKill(true)
			end
		end)
		var_209_6:SetLoops(1)
		var_209_6:Play()

		local var_209_8 = self:autoKillDOTween(var_0_43.Sequence())

		var_209_8:AppendInterval(0.2)
		var_209_8:AppendCallback(function()
			if self._control then
				self._control.right_widget.rectTransform:DOAnchorPos(var_0_15(0, 15), var_209_0):SetEase(DG.Tweening.Ease.OutCirc):SetAutoKill(true)
			end
		end)
		var_209_8:SetLoops(1)
		var_209_8:Play()
	end

	function arg_1_0:__play_out_animation(arg_215_1)
		self._control.top_widget.top_widget_mask.image.raycastTarget = true

		local var_215_0 = 0.2

		self._control.top_widget.rectTransform.anchoredPosition = var_0_15(0, 0)
		self._control.bottom_widget.rectTransform.anchoredPosition = var_0_15(0, 0)
		self._control.left_widget.rectTransform.anchoredPosition = var_0_15(0, 15)
		self._control.right_widget.rectTransform.anchoredPosition = var_0_15(0, 15)

		local var_215_2 = self:autoKillDOTween(var_0_43.Sequence())

		var_215_2:AppendInterval(0)
		var_215_2:AppendCallback(function()
			if self._control then
				self._control.top_widget.rectTransform:DOAnchorPos(var_0_15(0, 70), var_215_0 + 0.01):SetEase(DG.Tweening.Ease.OutCirc):SetAutoKill(true).onComplete = function()
					if self and self._control then
						self._control.top_widget.top_widget_mask.image.raycastTarget = false
					end
				end
			end
		end)
		var_215_2:SetLoops(1)
		var_215_2:Play()

		local var_215_4 = self:autoKillDOTween(var_0_43.Sequence())

		var_215_4:AppendInterval(0)
		var_215_4:AppendCallback(function()
			if self._control then
				self._control.bottom_widget.rectTransform:DOAnchorPos(var_0_15(0, -100), var_215_0):SetEase(DG.Tweening.Ease.OutCirc):SetAutoKill(true)
			end
		end)
		var_215_4:SetLoops(1)
		var_215_4:Play()

		local var_215_6 = self:autoKillDOTween(var_0_43.Sequence())

		var_215_6:AppendInterval(0)
		var_215_6:AppendCallback(function()
			if self._control then
				self._control.left_widget.rectTransform:DOAnchorPos(var_0_15(-950, 15), var_215_0):SetEase(DG.Tweening.Ease.OutCirc):SetAutoKill(true)
			end
		end)
		var_215_6:SetLoops(1)
		var_215_6:Play()

		local var_215_8 = self:autoKillDOTween(var_0_43.Sequence())

		var_215_8:AppendInterval(0)
		var_215_8:AppendCallback(function()
			if self._control then
				self._control.right_widget.rectTransform:DOAnchorPos(var_0_15(320, 15), var_215_0):SetEase(DG.Tweening.Ease.OutCirc):SetAutoKill(true).onComplete = function(arg_221_0)
					self:__destroy_panel(arg_221_0)
				end
			end
		end)
		var_215_8:SetLoops(1)
		var_215_8:Play()
	end

	function arg_1_0:__destroy_panel(arg_222_1)
		var_0_2:destroyInstance("fight_prepare")
		var_0_2:destroyInstance("select_member")
		var_0_2:destroyInstance("equip_list")
		var_0_2:destroyInstance("abyss_select_member")

		if self._fight_prepare_type == var_0_4.fight_type.captainroom_friend or self._fight_prepare_type == var_0_4.fight_type.tower_rank_friend_captainroom then
			local var_222_0 = var_0_2:getInstance("captainroom_friend_fleet")

			if var_222_0 then
				var_222_0:show_layer_of_captainroom(true)
			end

			return
		elseif self._fight_prepare_type == var_0_4.fight_type.show_room_friend or self._fight_prepare_type == var_0_4.fight_type.tower_rank_list then
			local var_222_1 = var_0_2:getInstance("captainroom_friend_fleet")

			if var_222_1 then
				var_222_1:show_layer_of_show_room(true)
			end

			return
		elseif self._fight_prepare_type == var_0_4.fight_type.sixth_fight then
			var_0_2:createInstance("sixth_map_node"):show({
				id = self._sixth_map,
				is_return_sixth_map_node = self._is_return_sixth_map_node,
				_six_map_node_bg = self._six_map_node_bg
			})

			return
		elseif self._fight_prepare_type == var_0_4.fight_type.mist_attack then
			var_0_2:createInstance("nf_map_node"):show({
				id = self._mist_map,
				is_return_mist_map_node = self._is_return_mist_map_node,
				_mist_map_node_bg = self._mist_map_node_bg
			})

			return
		elseif self._fight_prepare_type == var_0_4.fight_type.fearlessness_sea then
			local var_222_2 = var_0_2:getInstance("fearlessness_sea")

			if var_222_2 then
				var_222_2:show()

				if var_222_2._is_hard then
					var_222_2:__change_hard_map(true)
				end

				var_0_3:show_panel_mix_panel(self._go_to_map_id, false)
			else
				var_0_2:createInstance("fearlessness_sea"):show()
				var_0_3:show_panel_mix_panel(self._go_to_map_id, true)
			end

			return
		elseif self._fight_prepare_type == var_0_4.fight_type.tower_fight then
			var_0_2:createInstance("climb_tower"):show()

			return
		elseif self._fight_prepare_type == var_0_4.fight_type.ocean_attack then
			local var_222_3 = var_0_2:getInstance("ocean_main_map")

			if var_222_3 then
				var_222_3:setVisible(true)
			end

			return
		elseif self._fight_prepare_type == var_0_4.fight_type.strike then
			local var_222_4 = var_0_2:getInstance("strike_main")

			if var_222_4 then
				var_222_4:setVisible(true)
			end

			return
		elseif self._fight_prepare_type == var_0_4.fight_type.war_concerto_play or self._fight_prepare_type == var_0_4.fight_type.war_concerto then
			local var_222_5 = var_0_2:getActiveInstance("fifth_preview_map")

			if var_222_5 then
				var_222_5:show()
			end

			return
		elseif self._fight_prepare_type == var_0_4.fight_type.abyss_model_first_phase then
			local var_222_6 = var_0_2:getInstance("abyss_event")

			if var_0_2:getInstance("fight_info") then
				var_0_2:destroyInstance("fight_info")
			end

			if var_222_6 then
				var_222_6:show()
			else
				var_0_2:createInstance("abyss_event"):show()
			end

			return
		elseif self._fight_prepare_type == var_0_4.fight_type.seventh then
			local var_222_7 = var_0_2:getInstance("seven_sea_map")

			if var_0_2:getInstance("fight_info") then
				var_0_2:destroyInstance("fight_info")
			end

			if var_222_7 then
				var_222_7:show(self._seven_map_data.id)
			else
				var_0_2:createInstance("seven_sea_map"):show(self._seven_map_data.id)
			end

			var_222_7:show_cover_func(false)

			if var_0_3:get_into_seven_fight() == 1 then
				var_222_7._now_face = 2
			end

			return
		elseif self._fight_prepare_type == var_0_4.fight_type.eighth_attack then
			local var_222_8 = var_0_2:getInstance("eighth_sea_map")

			if var_0_2:getInstance("fight_info") then
				var_0_2:destroyInstance("fight_info")
			end

			var_0_3:set_eight_monster_hurt_id()

			if var_222_8 then
				var_222_8:show(self._eighth_map_data.id)
			else
				local var_222_9 = var_0_3:get_now_eighth_map_id()

				if var_222_9 then
					local var_222_10 = var_0_2:createInstance("eighth_sea_map")

					var_222_10:show(var_222_9)
					var_222_10:show_cover_func(false)
				else
					var_0_2:createInstance("home"):show()
				end
			end

			return
		end

		var_0_2:createInstance("gotofight"):show(not arg_222_1 and (self._fight_prepare_type == var_0_4.fight_type.campaign and {
			is_open_init = true,
			toggle_index = self._fight_prepare_type,
			init_chapter_index = self._init_chapter_index,
			init_map_index = self._init_map_index,
			difficulty = self._difficulty
		} or {
			is_open_init = true,
			toggle_index = self._fight_prepare_type,
			init_chapter_index = self._init_chapter_index,
			init_map_index = self._init_map_index
		}) or {
			toggle_index = var_0_4.fight_type.farfight
		}, false)
	end

	function arg_1_0:_play_into_se(arg_223_1)
		self:playSE(arg_223_1, false)
	end

	function arg_1_0:__set_bottom_info_state(arg_224_1)
		local var_224_0 = arg_224_1 == var_0_4.team_type.abyss_owner_team

		self._control.left_widget.func_toggle:SetActive(arg_224_1 == var_0_4.team_type.abyss_owner_team)

		if var_224_0 then
			self._team_type = var_0_4.team_type.abyss_owner_team or var_0_4.team_type.abyss_team
		end

		self._control.left_widget.abyss_btn.owner_team_tog.toggle.isOn = var_224_0
		self._control.left_widget.abyss_btn.deep_sea_team_tog.toggle.isOn = not var_224_0

		self._control.left_widget.abyss_floor:SetActive(not var_224_0)
		self._control.auto_supply_btn:SetActive(var_224_0)

		if self._is_nf then
			self._control.auto_supply_btn:SetActive(false)
		end

		self._control.right_widget.damage_group_bg:SetActive(var_224_0)
		self._control.right_widget.bg_back.props_panel.speed_info_panel:SetActive(var_224_0)
		self._control.right_widget.damage_group_bg:SetActive(var_224_0)
		self._control.repair_btn:SetActive(var_224_0)

		if var_0_3:get_abyss_enter_repair_time() ~= 0 then
			self._control.repair_btn:SetActive(false)
		end

		self._control.right_widget.bg_back.abyss_panel:SetActive(true)
		self._control.right_widget.bg_back.props_panel:SetActive(true)
		self._control.right_widget.bg_back.props_panel.title:SetActive(false)
		self._control.right_widget.bg_back.abyss_hp_info:SetActive(not var_224_0)
		self._control.right_widget.bg_back.abyss_panel.scrollview:SetActive(var_224_0)
		self._control.parent.collect_icon_bg:SetActive(var_224_0)
		self._control.parent.pre_formation_bg:SetActive(var_224_0)

		if var_0_3:get_abyss_enter_repair_time() ~= 0 then
			self._control.parent.pre_formation_bg:SetActive(false)
		end

		self._abyss_prepare_toggle_index = var_0_4.abyss_right_layer_type.power_layer

		self:__change_abyss_panel_state()
	end

	function arg_1_0:__set_buff_display_state(arg_225_1)
		if arg_225_1 then
			self._control.right_widget.bg_back.abyss_panel.power_tog:SetActive(true)

			self._control.right_widget.bg_back.abyss_panel.power_tog.toggle.isOn = arg_225_1

			self._control.right_widget.bg_back.abyss_panel.power_tog.bg:SetActive(arg_225_1)

			self._control.right_widget.bg_back.abyss_panel.buff_tog.toggle.isOn = not arg_225_1

			self._control.repair_btn:SetActive(not arg_225_1)
			self._control.parent.pre_formation_bg:SetActive(not arg_225_1)
		end
	end

	function arg_1_0:__change_abyss_panel_state()
		local var_226_0 = self._abyss_prepare_toggle_index == var_0_4.abyss_right_layer_type.power_layer
		local var_226_1 = self._control.right_widget.bg

		self._control.right_widget.bg.props_panel:SetActive(self._abyss_prepare_toggle_index == var_0_4.abyss_right_layer_type.power_layer)

		if self._team_type == var_0_4.team_type.abyss_team then
			var_226_1.abyss_hp_info:SetActive(var_226_0)
			var_226_1.speed_skeleton_mask:SetActive(false)
		else
			var_226_1.abyss_hp_info:SetActive(false)
			var_226_1.speed_skeleton_mask:SetActive(var_226_0)
		end

		var_226_1.abyss_panel.scrollview:SetActive(not var_226_0)
	end

	function arg_1_0:__show_abyss_team_power_meter()
		local var_227_0 = self._control.right_widget.bg_back.abyss_hp_info
		local var_227_1 = var_0_3:get_abyss_power() / 100

		var_227_1 = var_227_1 > 100 and 100 or var_227_1

		local var_227_2

		if var_227_1 <= 0.29 then
			var_227_2 = var_0_4.ship_hp_slider.ship_hp_l_red
		elseif var_227_1 >= 0.3 and var_227_1 <= 0.59 then
			var_227_2 = var_0_4.ship_hp_slider.ship_hp_l_yellow
		elseif var_227_1 >= 0.6 and var_227_1 <= 1 then
			var_227_2 = var_0_4.ship_hp_slider.ship_hp_l_green
		end

		var_227_0.hp_layer.image.sprite = self:loadSprite(var_227_2)
		var_227_0.hp_layer.image.fillAmount = var_227_1
		var_227_0.residue_des.text.text = var_0_1:getNowLang("ui_ny21_fleet_deep_energy")
		var_227_0.residue_des.hp_num.text.text = var_227_1 * 100 .. "/" .. 100
	end

	function arg_1_0:__show_abyss_team_buff_ilist()
		local var_228_0 = var_0_3:get_abyss_team_buff_info()

		if not var_228_0 then
			self._control.right_widget.bg_back.abyss_panel.buff_tog:SetActive(false)

			return
		end

		local var_228_1 = {}

		if self._team_type == var_0_4.team_type.abyss_owner_team then
			var_228_1 = var_228_0.buff_1

			if next(var_228_0.buff_1) == nil then
				self._control.right_widget.bg_back.abyss_panel.buff_tog:SetActive(false)
				self._control.right_widget.bg_back.abyss_panel.power_tog.bg:SetActive(false)
			else
				self._control.right_widget.bg_back.abyss_panel.buff_tog:SetActive(true)
				self._control.right_widget.bg_back.abyss_panel.power_tog.bg:SetActive(true)
			end
		else
			var_228_1 = var_228_0.buff_2

			if next(var_228_0.buff_2) == nil then
				self._control.right_widget.bg_back.abyss_panel.buff_tog:SetActive(false)
				self._control.right_widget.bg_back.abyss_panel.power_tog.bg:SetActive(false)
			else
				self._control.right_widget.bg_back.abyss_panel.buff_tog:SetActive(true)
				self._control.right_widget.bg_back.abyss_panel.power_tog.bg:SetActive(true)
			end
		end

		local var_228_2 = self._control.right_widget.bg_back.abyss_panel.scrollview.viewport.content

		for iter_228_0 = 1, self._control.right_widget.bg_back.abyss_panel.scrollview.viewport.content.transform.childCount do
			self:destroyGameObject(var_228_2.transform:GetChild(iter_228_0 - 1).gameObject)
		end

		for iter_228_1, iter_228_2 in pairs(var_228_1) do
			local var_228_3, var_228_4 = self:loadUIPrefab("buff_tips_des", var_228_2.transform)

			var_228_3:setVisible(true)

			var_228_3._panel.transform:GetComponent("Text").text = var_0_1:convert_rich_text(var_0_41.find_object_by_id(iter_228_2).desc)
		end

		var_0_42.ForceRebuildLayoutImmediate(var_228_2.rectTransform)
	end

	function arg_1_0:__enter_strike_map()
		local var_229_0 = var_0_3:get_strike_point_info()

		if var_229_0.point_id and var_229_0.point_id ~= 0 then
			var_0_2:destroyInstance("fight_prepare")

			local var_229_1 = var_0_2:createInstance("strike_map")

			var_229_1:set_show_lock(false)
			var_229_1:destroyChildren("strike_buff_obj")
			var_229_1:show(self._go_to_map_id)

			local var_229_2 = var_0_3:get_now_ship_point()
			local var_229_3 = var_0_3:get_next_ship_point()

			var_229_1:__init_buff_pos()

			if var_0_3:get_have_buff_point() then
				local var_229_4 = {}

				for iter_229_0, iter_229_1 in pairs((var_0_3:get_save_buff())) do
					table.insert(var_229_4, iter_229_1.id)
				end

				var_229_1:__play_move_ship(var_229_2, var_229_3, true, var_229_4)
			else
				var_229_1:__play_move_ship(var_229_2, var_229_3, true)
			end
		else
			var_0_3:req_SolidEnterMapReq(self._go_to_map_id, self.__strike_is_deal)
		end
	end

	function arg_1_0:__onReset()
		self._this_toggle_not_need_refresh = false

		self._control.cover:SetActive(false)
		var_0_3:set_gotofight_memory_team_index(self._gotofight_memory_team_index)

		if self._control.left_widget.func_toggle.toggle1.toggle then
			self._control.left_widget.func_toggle.toggle1.toggle.isOn = true
			self._control.left_widget.func_toggle.toggle2.toggle.isOn = false
			self._control.left_widget.func_toggle.toggle3.toggle.isOn = false
			self._control.left_widget.func_toggle.toggle4.toggle.isOn = false
		end

		self._control.left_widget.func_toggle.line3.gameObject:SetActive(true)
		self._control.left_widget.func_toggle.toggle3.gameObject:SetActive(true)
		self._control.left_widget.rankable_layout_group.rankableLayoutGroup:OnDestroy()

		for iter_230_0, iter_230_1 in pairs(self._ship_item_list) do
			iter_230_1:destroy()
		end

		self._ship_item_list = {}
		self._solid_team_data = {}
		self._team_data = {}
		self._team_group_data = {}
		self._team_detail_data = {}
		self._init_chapter_index = nil
		self._init_map_index = nil

		if self._tower_enemy_list_canvas_group then
			self._tower_enemy_list_canvas_group.alpha = 0
		end

		if self._tower_enemy_info_des_canvas_group then
			self._tower_enemy_info_des_canvas_group.alpha = 0
		end

		if self._tower_layer_list_canvas_group then
			self._tower_layer_list_canvas_group.alpha = 0
			self._tower_layer_list_canvas_group = nil
		end

		if self._tower_buff_canvas_group then
			self._tower_buff_canvas_group.alpha = 0
			self._tower_buff_canvas_group.blocksRaycasts = false
		end

		if self._control.right_widget.bg_back.tower_info.toggle_layer.toggle.isOn then
			self._control.right_widget.bg_back.tower_info.toggle_layer.toggle.isOn = false
			self._control.right_widget.bg_back.tower_info.toggle_info.toggle.isOn = true
		end

		self:__change_right_bg(1)

		if self._control.right_widget.bg_back.strike_info.toggle_info.toggle.isOn then
			self._control.right_widget.bg_back.strike_info.toggle_info.toggle.isOn = false
			self._control.right_widget.bg_back.strike_info.toggle_buff.toggle.isOn = true
		end

		if self._reusable_cell then
			for iter_230_2, iter_230_3 in pairs((self._reusable_cell:get_all_item())) do
				iter_230_3.control:destroy()
			end

			self._reusable_cell = nil
		end

		if self._ocean_reusable_cell then
			for iter_230_4, iter_230_5 in pairs((self._ocean_reusable_cell:get_all_item())) do
				iter_230_5.control:destroy()
			end

			self._ocean_reusable_cell = nil
		end

		if self._fight_prepare_type == var_0_4.fight_type.abyss_model_first_phase then
			self._control.left_widget.abyss_btn.owner_team_tog.toggle.isOn = true

			self._control.right_widget.bg_back.props_panel.title:SetActive(true)
			self._control.right_widget.bg_back.abyss_panel:SetActive(false)
		end

		if self._fight_prepare_type == var_0_4.fight_type.abyss_model_first_phase and not self._control.left_widget.abyss_btn:Equals(nil) then
			self._control.left_widget.abyss_btn:SetActive(false)
		end

		if self._current_content_type == var_0_4.fight_prepare_right_panel_type.war_concerto_play then
			self._team_detail_data = {}
		end

		for iter_230_6, iter_230_7 in pairs(self._ship_item_list) do
			iter_230_7:destroy()
		end

		self._abyss_prepare_point = nil
		self._support_id = nil
		self._ship_item_list = {}
		self._team_data = {}
		self._team_group_data = {}
		self._team_detail_data = {}

		if self._right_panel_tweener then
			self._right_panel_tweener:Kill()

			self._right_panel_tweener = nil
		end
	end

	function arg_1_0:__prevent_frequently_click()
		local var_231_0 = self:autoKillDOTween(var_0_43.Sequence())

		var_231_0:AppendInterval(0.4)
		var_231_0:Play()
	end

	function arg_1_0:is_abyss_team()
		return self._control.left_widget.abyss_btn.deep_sea_team_tog.toggle.isOn
	end

	function arg_1_0.get_config_list_by_id_list(arg_233_0, arg_233_1)
		local var_233_0 = {}

		for iter_233_0, iter_233_1 in pairs(arg_233_1) do
			var_0_14(var_233_0, (var_0_3:find_character_by_id(iter_233_1)))
		end

		return var_233_0
	end

	function arg_1_0:show_strike_buff(arg_234_1)
		self._control.strike_buff:SetActive(true)

		local var_234_0 = var_0_30.find_object_by_id(arg_234_1)
		local var_234_1 = var_0_3:get_strike_point_info().buffs
		local var_234_2 = 0

		if var_234_1 and next(var_234_1) then
			for iter_234_0, iter_234_1 in pairs(var_234_1) do
				if iter_234_1.id == arg_234_1 then
					var_234_2 = var_234_1[iter_234_0] and (next(var_234_1[iter_234_0].progresses[1]) and var_234_1[iter_234_0].progresses[1].counter / var_234_1[iter_234_0].progresses[1].target_value * 100 or 0) or 0
				end
			end
		end

		self._control.strike_buff.weather_info.weather_name.text.text = var_234_0.title
		self._control.strike_buff.weather_info.weather_content.text.text = var_0_5.convert_rich_text(var_234_0.change_desc)
		self._control.strike_buff.weather_info.time_txt.text.text = var_0_1:getNowLang("questprogress")
		self._control.strike_buff.weather_info.time_txt_2.text.text = var_234_2 .. "%"
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_235_0)
	local var_235_0 = var_0_2:class("fight_prepare")

	var_235_0._current_content_type = nil
	var_235_0._current_team_index = 1
	var_235_0._ship_item_list = {}
	var_235_0._team_data = {}
	var_235_0._team_detail_data = {}
	var_235_0._supply_item_index = -1
	var_235_0._repair_item_index = -1
	var_235_0._total_oil_need = 0
	var_235_0._total_bullet_need = 0
	var_235_0._total_aluminium_need = 0
	var_235_0._total_steel_need = 0
	var_235_0._total_repair_item_need = 0
	var_235_0._go_to_map_id = -1
	var_235_0._init_node_id = -1
	var_235_0._fight_prepare_type = var_0_4.fight_type.gotofight
	var_235_0._team_type = var_0_4.team_type.normal
	var_235_0._team_group_data = {}
	var_235_0._farfight_data = {}
	var_235_0._farfight_condition = {}
	var_235_0._auto_supply = false
	var_235_0._supply_type = false
	var_235_0._campagion_data = {}
	var_235_0._difficulty = nil
	var_235_0._campagion_team_data = {}
	var_235_0._campaign = false
	var_235_0._exercise_id = nil
	var_235_0._support_id = nil
	var_235_0._firend_account_id = nil
	var_235_0._init_chapter_index = nil
	var_235_0._init_map_index = nil
	var_235_0._sixth_team_data = {}
	var_235_0._sixth_map = nil
	var_235_0._reusable_cell = nil
	var_235_0._click_times = 0
	var_235_0._single_click_time = 0
	var_235_0._tower_monster = nil
	var_235_0._tower_reusable_cell = nil
	var_235_0._now_layer_map_cfg = nil
	var_235_0._fight_tower_list = {}
	var_235_0._tower_cost = 0
	var_235_0._limit_tower = 0
	var_235_0._now_layer = 0
	var_235_0._support_supply_full = true
	var_235_0._copy_team_data = nil
	var_235_0._solid_team_data = nil
	var_235_0._ocean_team_data = nil
	var_235_0._start_fight_time = 0
	var_235_0._support_time = 1
	var_235_0.__is_into_map = false
	var_235_0._current_strike_buffs = {}
	var_235_0._is_return_sixth_map_node = false
	var_235_0._is_onclick_quick_supply = false
	var_235_0._is_onclick_quick_repair = false
	var_235_0._ocean_can_fight_list = {}
	var_235_0._six_map_node_bg = nil
	var_235_0._abyss_prepare_point = nil
	var_235_0._gotofight_memory_team_index = var_0_3:get_gotofight_memory_team_index()
	var_235_0._abyss_prepare_toggle_index = nil
	var_235_0._abyss_prepare_to_fight_type = false
	var_235_0._right_panel_tweener = nil
	var_235_0._attr_buff_list = {}
	var_235_0.is_already_init = true

	return var_235_0
end

return var_0_0
