local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.user
local var_0_5 = gameenum.common_type
local var_0_6 = string.format
local var_0_7 = table.insert
local var_0_9 = gameconfig.ship_config
local var_0_11 = gameconfig.skin_config
local var_0_12 = gameconfig.ship_level_config
local var_0_13 = gamecore.util_func
local var_0_14 = gameconfig.support_config
local var_0_15 = gameconfig.ship_rule_config
local var_0_17 = gameconfig.score_map_node_config
local var_0_19 = gameconfig.ship_pve_active_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.__onClick_character_btn(arg_2_0)
		return
	end

	function arg_1_0:__onClick_closeone()
		local var_3_0 = var_0_3:get_battle_result()
		local var_3_1 = var_0_3:get_use_info_data()
		local var_3_2 = var_0_3:get_battle_info()

		self._control.closeone.gameObject:SetActive(false)
		self._control.closetwo.gameObject:SetActive(true)
		self._control.fight_results.gameObject:SetActive(true)
		self._control.score.resultword.gameObject:SetActive(false)
		self._control.score.spineparent.gameObject:SetActive(false)
		self._control.every_exp.gameObject:SetActive(true)
		self._control.bonus_layer.gameObject:SetActive(false)
		self:__destroy_spine(self._control.score.spineparent)
		self._control.fight_results.addexp.fontJump:Anim(var_3_0.exp)

		if self._donot_show_player_exp then
			self._control.fight_results.gameObject:SetActive(false)
		end

		for iter_3_0 = 1, #var_3_0.state do
			local var_3_4
			local var_3_5 = var_0_3:get_battle_info()

			if self._enter_type == var_0_5.fight_type.abyss_model_first_phase and var_3_5.type == gameenum.battle_type.fight_type.abyss_2 then
				local var_3_6 = var_0_3:find_abyss_character_by_id(var_3_0.state[iter_3_0].id)

				var_3_4 = var_3_6 and var_0_13.little_clone(var_3_6) or {}
			elseif self._enter_type == var_0_5.fight_type.event_story and var_0_3:get_battle_info().type ~= var_0_5.battle_type.strike then
				local var_3_7 = var_0_9.find_object_by_cid(var_3_0.state[iter_3_0].id)

				var_3_4 = var_3_7 and var_0_13.little_clone(var_3_7) or {}
				var_3_4.level = 110
			elseif var_3_2.type == var_0_5.battle_type.war_concerto_play then
				local var_3_8 = var_0_3:get_fake_ship_data(var_0_3:get_fifth_team_data()[iter_3_0])

				var_3_4 = var_3_8 and var_0_13.little_clone(var_3_8) or {}
			else
				local var_3_9 = var_0_3:find_character_by_id(var_3_0.state[iter_3_0].id)

				var_3_4 = var_3_9 and var_0_13.little_clone(var_3_9) or {}
			end

			local var_3_10 = var_0_9.find_object_by_cid(var_3_4.cid)
			local var_3_11 = var_3_4.level
			local var_3_12 = var_3_4.exp

			if self._enter_type == var_0_5.fight_type.event_story and var_0_3:get_battle_info().type ~= var_0_5.battle_type.strike then
				var_3_12 = 0
			end

			local var_3_13 = var_0_12.find_object_by_level(var_3_11) and var_0_12.find_object_by_level(var_3_11).exp or 0
			local var_3_14 = var_3_4.skin
			local var_3_15

			if self._enter_type == var_0_5.fight_type.event_story and var_0_3:get_battle_info().type ~= var_0_5.battle_type.strike then
				var_3_14 = 0
			end

			local var_3_16 = var_3_0.state[iter_3_0].hp

			if self._enter_type == var_0_5.fight_type.event_story and var_0_3:get_battle_info().type ~= var_0_5.battle_type.strike then
				var_3_15 = var_0_9.find_object_by_cid(var_3_0.state[iter_3_0].id).hp
			elseif var_0_3:get_battle_info().type == var_0_5.battle_type.war_concerto_play then
				var_3_15 = var_0_9.find_object_by_cid(var_3_10.cid).hp
			elseif var_0_3:get_battle_info().type == var_0_5.battle_type.abyss_first_phase then
				var_3_15 = var_0_9.find_object_by_cid(var_3_10.cid).hp
			else
				local var_3_17 = var_0_3:find_character_by_id(var_3_0.state[iter_3_0].id)

				ship_base = var_0_9.find_object_by_cid(var_3_10.cid)
				var_3_15 = var_0_9.find_object_by_cid(var_3_10.cid).hp
				var_3_14 = var_0_3:find_character_by_id(var_3_0.state[iter_3_0].id).skin
				var_3_15 = var_0_13:get_ship_attr(var_3_17, ship_base).hp
			end

			if var_3_14 and var_3_14 ~= 0 then
				self.ship_skin_id = var_0_11.find_object_by_cid(var_3_14).skin_id
			end

			if var_3_16 == 0 then
				self._is_have_down = true
			end

			if var_3_16 == 0 and self._enter_type ~= var_0_5.fight_type.event_story and var_0_3:get_battle_info().type ~= var_0_5.battle_type.strike then
				for iter_3_1 = 1, #var_3_0.state do
					local var_3_19 = (self._enter_type == var_0_5.fight_type.abyss_model_first_phase and var_3_5.type == gameenum.battle_type.fight_type.abyss_2 and var_0_3:find_abyss_character_by_id(var_3_0.state[iter_3_1].id) or var_0_3:find_character_by_id(var_3_0.state[iter_3_1].id)).level

					if self._enter_type == var_0_5.fight_type.abyss_model_first_phase and var_3_5.type == gameenum.battle_type.fight_type.abyss_2 then
						if var_3_0.state[iter_3_1].hp == 0 and var_3_0.state[iter_3_1].init_hp ~= 0 then
							self:_love_down(iter_3_1, false, self._is_pvp)
						end
					elseif var_3_0.state[iter_3_1].hp ~= 0 and var_3_19 >= 11 and var_3_0.state[iter_3_1].init_hp ~= 0 then
						if var_3_0.state[iter_3_1].add_love then
							self:_love_down(iter_3_1, true, self._is_pvp, true)
						else
							self:_love_down(iter_3_1, true, self._is_pvp)
						end
					elseif var_3_0.state[iter_3_1].hp == 0 then
						self:_love_down(iter_3_1, false, self._is_pvp)
					end
				end
			end

			self._exp_info[iter_3_0].gameObject:SetActive(true)
			var_0_5:play_in_out_animation(self._control.tool.uITweenSequence, true)

			if var_3_0.state[iter_3_0].init_hp ~= 0 then
				self:_exp_move(iter_3_0)
			end

			self._user_fleet_unit[iter_3_0].main.goodwill.about_up.up.gameObject:SetActive(false)

			if var_0_13.have_index(var_3_0.state[iter_3_0], "love_change") then
				self._user_fleet_unit[iter_3_0].main.goodwill.about_up.up.increase.text.text = math.max(1, math.floor(var_3_0.state[iter_3_0].love_change / 100))
			end

			if var_3_0.state[iter_3_0].add_love then
				self._have_love = true
			end

			if var_3_0.state[iter_3_0].tactic_exp ~= 0 and var_3_0.state[iter_3_0].tactic_exp then
				self._have_college = true
			end

			if self._have_love and self._have_college then
				if var_3_0.state[iter_3_0].add_love and var_3_0.state[iter_3_0].tactic_exp then
					self:_love_get(iter_3_0, function()
						self:college_skill_up(iter_3_0, var_3_0.state[iter_3_0].tactic_exp, self._college_level_exps[iter_3_0], self._now_college_exps[iter_3_0], self._college_imgs[iter_3_0])
					end, 1)
				elseif (var_3_0.state[iter_3_0].add_love == nil or not var_3_0.state[iter_3_0].add_love) and var_3_0.state[iter_3_0].tactic_exp and var_3_0.state[iter_3_0].tactic_exp ~= 0 then
					self:_love_get(iter_3_0, function()
						self:college_skill_up(iter_3_0, var_3_0.state[iter_3_0].tactic_exp, self._college_level_exps[iter_3_0], self._now_college_exps[iter_3_0], self._college_imgs[iter_3_0])
					end, 3)
				end
			elseif self._have_college and self._have_love == false then
				if (var_3_0.state[iter_3_0].add_love == nil or not var_3_0.state[iter_3_0].add_love) and var_3_0.state[iter_3_0].tactic_exp and var_3_0.state[iter_3_0].tactic_exp ~= 0 then
					self:_love_get(iter_3_0, function()
						self:college_skill_up(iter_3_0, var_3_0.state[iter_3_0].tactic_exp, self._college_level_exps[iter_3_0], self._now_college_exps[iter_3_0], self._college_imgs[iter_3_0])
					end, 2)
				end
			elseif self._have_love and self._have_college == false and var_3_0.state[iter_3_0].add_love then
				self:_love_get(iter_3_0, function()
					return
				end, 4)
			end

			self._exp_info[iter_3_0].addexp.fontJump:Anim(var_3_0.state[iter_3_0].exp)

			self._exp_info[iter_3_0].remainexp.text.text = var_3_11 < 110 and var_3_13 - var_3_12 or 0

			local var_3_20 = self:__get_ship_exp()
			local var_3_21 = self:update_mysterious_textbook_buff_float()
			local var_3_22 = self:update_combatshop_mysterious_textbook_buff_float()

			self._exp_info[iter_3_0].extra.text.text = var_3_21 and var_3_22 and (var_3_0.state[iter_3_0].mvp and iter_3_0 == 1 and "+" .. math.ceil(var_3_20 * 2 * 1.5 * 2 * 2 * 100 - 100) .. "%" or var_3_0.state[iter_3_0].mvp and iter_3_0 ~= 1 and "+" .. math.ceil(var_3_20 * 2 * 2 * 2 * 100 - 100) .. "%" or not var_3_0.state[iter_3_0].mvp and iter_3_0 == 1 and "+" .. math.ceil(var_3_20 * 2 * 1.5 * 2 * 100 - 100) .. "%" or var_3_20 >= 1 and "+" .. math.ceil(var_3_20 * 2 * 2 * 100 - 100) .. "%" or "+" .. math.ceil(var_3_20 * 2 * 2 * 100) .. "%") or (var_3_21 or var_3_22) and (var_3_0.state[iter_3_0].mvp and iter_3_0 == 1 and "+" .. math.ceil(var_3_20 * 2 * 1.5 * 2 * 100 - 100) .. "%" or var_3_0.state[iter_3_0].mvp and iter_3_0 ~= 1 and "+" .. math.ceil(var_3_20 * 2 * 2 * 100 - 100) .. "%" or not var_3_0.state[iter_3_0].mvp and iter_3_0 == 1 and "+" .. math.ceil(var_3_20 * 2 * 1.5 * 100 - 100) .. "%" or var_3_20 >= 1 and "+" .. math.ceil(var_3_20 * 2 * 100 - 100) .. "%" or "+" .. math.ceil(var_3_20 * 2 * 100) .. "%") or var_3_0.state[iter_3_0].mvp and iter_3_0 == 1 and "+" .. math.ceil(var_3_20 * 1.5 * 2 * 100 - 100) .. "%" or var_3_0.state[iter_3_0].mvp and iter_3_0 ~= 1 and "+" .. math.ceil(var_3_20 * 2 * 100 - 100) .. "%" or not var_3_0.state[iter_3_0].mvp and iter_3_0 == 1 and "+" .. math.ceil(var_3_20 * 1.5 * 100 - 100) .. "%" or var_3_20 >= 1 and "+" .. math.ceil(var_3_20 * 100 - 100) .. "%" or "+" .. math.ceil(var_3_20 * 100 - 100) .. "%"

			local var_3_23 = lx.UserData:getKeyData(var_0_5.setting_key_list.setting_broken)
			local var_3_24 = true

			if var_3_23 ~= "" and var_3_23 ~= " " then
				var_3_24 = lx.json_decode(var_3_23).value
			end

			local var_3_25

			if var_3_0.state[iter_3_0].mvp and var_3_14 ~= 0 and var_3_16 >= var_3_15 / 2 then
				var_3_25 = var_0_6(var_0_5.ship_icon.model_normal_l, self.ship_skin_id, self.ship_skin_id)
			elseif var_3_0.state[iter_3_0].mvp and var_3_14 == 0 and var_3_16 >= var_3_15 / 2 then
				var_3_25 = var_0_6(var_0_5.ship_icon.model_normal_l, var_3_10.pic_id, var_3_10.pic_id)
			elseif var_3_0.state[iter_3_0].mvp and var_3_14 ~= 0 and var_3_16 < var_3_15 / 2 and var_3_24 then
				var_3_25 = var_0_6(var_0_5.ship_icon.model_broken_l, self.ship_skin_id, self.ship_skin_id)
			elseif var_3_0.state[iter_3_0].mvp and var_3_14 == 0 and var_3_16 < var_3_15 / 2 and var_3_24 then
				var_3_25 = var_0_6(var_0_5.ship_icon.model_broken_l, var_3_10.pic_id, var_3_10.pic_id)
			elseif var_3_0.state[iter_3_0].mvp and var_3_14 ~= 0 and var_3_16 < var_3_15 / 2 and not var_3_24 then
				var_3_25 = var_0_6(var_0_5.ship_icon.model_normal_l, self.ship_skin_id, self.ship_skin_id)
			elseif var_3_0.state[iter_3_0].mvp and var_3_14 == 0 and var_3_16 < var_3_15 / 2 and not var_3_24 then
				var_3_25 = var_0_6(var_0_5.ship_icon.model_normal_l, var_3_10.pic_id, var_3_10.pic_id)
			end

			self._control.character.characterone.gameObject:SetActive(true)

			local var_3_26, var_3_27 = self:loadSprite(var_3_25)

			if var_3_26 then
				self._control.character.characterone.image.sprite = var_3_26

				if var_3_27 then
					self._control.character.characterone.transform.localScale = Vector3(1, 1, 1)

					var_0_5:hd_sprite_half_scale(self._control.character.characterone.transform)
				end
			end
		end

		if next(var_3_0.reward) ~= 0 then
			self._control.bonus_layer.get_item.gameObject:SetActive(false)
			self._control.bonus_layer.coreget.gameObject:SetActive(false)
			self._control.get_booty.getword.gameObject:SetActive(false)
			self._control.get_booty.already_have_booty.gameObject:SetActive(false)

			for iter_3_2, iter_3_3 in pairs(var_3_0.reward) do
				if iter_3_3.type == 4 then
					self._get_ship = true
					self._get_ship_info = iter_3_3
				elseif iter_3_3.id == 14 then
					self._control.get_booty.gameObject:SetActive(true)

					self._control.get_booty.have_booty.num.text.text = var_3_1.spoils
					self._control.get_booty.get_num_booty.num.text.text = iter_3_3.count

					self._control.get_booty.getword.gameObject:SetActive(true)
					self._control.get_booty.already_have_booty.gameObject:SetActive(true)

					self._control.get_booty.get_num_booty.num.text.text = iter_3_3.count
				else
					self._control.bonus_layer.item_title.gameObject:SetActive(true)
					self._control.bonus_layer.get_item.gameObject:SetActive(true)
					self._control.bonus_layer.coreget.gameObject:SetActive(false)

					if iter_3_3.type == 2 then
						self._control.bonus_layer.gameObject:SetActive(true)

						if iter_3_3.id == 2 then
							self._control.bonus_layer.item_main_one.num.text.text = iter_3_3.count
						elseif iter_3_3.id == 3 then
							self._control.bonus_layer.item_main_two.num.text.text = iter_3_3.count
						elseif iter_3_3.id == 4 then
							self._control.bonus_layer.item_main_three.num.text.text = iter_3_3.count
						elseif iter_3_3.id == 9 then
							self._control.bonus_layer.item_main_four.num.text.text = iter_3_3.count
						elseif iter_3_3.id == 10141 or iter_3_3.id == 10241 or iter_3_3.id == 10341 or iter_3_3.id == 10441 or iter_3_3.id == 10541 then
							self._control.bonus_layer.coreget.gameObject:SetActive(true)

							self._control.bonus_layer.coreget.num.text.text = iter_3_3.count
							self._control.bonus_layer.coreget.item.image.sprite = self:loadSprite(var_0_6(var_0_5.remould_core, iter_3_3.id))
							self._control.bonus_layer.coreget.sample.text.text = var_0_2:getNowLang(var_0_6(var_0_5.remould_name, iter_3_3.id))
						end
					end
				end
			end
		end

		self:__show_fifth_joy_boss_res()
		self:__set_guide_panel_data()

		if var_0_3:get_new_battle_type() == gameenum.battle_type.fight_type.score then
			self._control.bonus_layer.gameObject:SetActive(false)

			local var_3_28 = var_0_3:get_battle_info()
			local var_3_30 = var_0_1:createInstance("msgbox")
			local var_3_31 = var_0_17.find_object_by_id_start_node_id(var_3_28.point, (var_0_3:get_current_score_map_start_point())).treasure_box

			for iter_3_4, iter_3_5 in pairs(var_3_31) do
				iter_3_5.count = iter_3_5.value
			end

			if #var_3_0.reward > 1 then
				var_3_30:showOne(var_3_31, function()
					var_3_30:setVisible(false)
				end, nil, var_0_2:getNowLang("logget"), var_0_5.msg_type.rewards)

				self._get_ship_info = {}

				for iter_3_6, iter_3_7 in pairs(var_3_0.reward) do
					if iter_3_7.type == 4 then
						var_0_7(self._get_ship_info, iter_3_7)
					end
				end
			end
		end
	end

	function arg_1_0:__onClick_closetwo()
		local var_9_0 = var_0_3:get_battle_type()
		local var_9_1 = var_0_3:get_battle_info()

		self:__destroy_spine(self._control.score.spineparent)
		self:__back_combat()
	end

	function arg_1_0:__get_push_coin_is_full()
		return (self:__init_buff_data())
	end

	function arg_1_0:__init_buff_data()
		local var_11_1, var_11_2 = self:_push_active_buff_start_time()

		return (var_11_2 <= var_11_1 or nil) and true
	end

	function arg_1_0:_push_active_buff_start_time()
		self.acticity = {}

		local var_12_0 = var_0_15.find_object_by_id(var_0_5.pve_init_active_id.fearlessness_event).content.activeId

		for iter_12_0, iter_12_1 in pairs((var_0_19.get_sequence())) do
			if self:get_acticity_time(iter_12_1) and iter_12_1.id == var_12_0 then
				self.acticity = var_0_13.little_clone(iter_12_1)
			end
		end

		local var_12_1 = math.floor((lx.ServerTime:getUtcTime() - (self.acticity.start_time - 54000)) / 86400)

		if var_12_1 >= 9 then
			var_12_1 = 9
		end

		local var_12_2 = 90 + var_12_1 * 20
		local var_12_3 = var_0_3:get_push_buff_list()
		local var_12_4 = 0

		if next(var_12_3) == nil then
			var_12_4 = 0
		else
			for iter_12_2, iter_12_3 in pairs(var_12_3) do
				var_12_4 = var_12_4 + iter_12_3.count
			end
		end

		return var_12_4, var_12_2
	end

	function arg_1_0.get_acticity_time(arg_13_0, arg_13_1)
		if not arg_13_1 then
			return false
		end

		arg_13_1.start_time = arg_13_1.start_time or 0
		arg_13_1.end_time = arg_13_1.end_time or 0

		if arg_13_1.start_time == 0 or arg_13_1.end_time == 0 then
			return false
		end

		arg_13_1.award_time = arg_13_1.award_time or 0

		if arg_13_1.award_time == 0 then
			if lx.ServerTime:getUtcTime() > arg_13_1.start_time and lx.ServerTime:getUtcTime() < arg_13_1.end_time then
				return true
			end
		elseif lx.ServerTime:getUtcTime() > arg_13_1.start_time and lx.ServerTime:getUtcTime() < arg_13_1.award_time then
			return true
		end

		return false
	end

	function arg_1_0.__get_award(arg_14_0, arg_14_1)
		return
	end

	function arg_1_0:__onClick_battlereport()
		self._control.report_bg:SetActive(true)

		self._control.report_bg.report_view.report.text.text = gamecore.BattleManager:get_battle_damage_report()
	end

	function arg_1_0:__onClick_report_bg_close()
		self._control.report_bg:SetActive(false)
	end

	function arg_1_0.__set_guide_panel_data(arg_17_0)
		if var_0_3:get_guide_state() then
			local var_17_0 = var_0_1:getInstance("guide_panel")

			if var_17_0 and var_17_0.get_next_step and var_17_0:get_next_step() == var_0_5.guide_const_id.first_group.five then
				var_17_0:reset_guide_panel()
			end
		end
	end

	function arg_1_0:__get_ship_exp()
		local var_18_0, var_18_1, var_18_2, var_18_3 = var_0_3:get_support_notify()
		local var_18_4 = 1

		if self._enter_type == var_0_5.fight_type.gotofight or self._enter_type == var_0_5.fight_type.ocean_attack or self._enter_type == var_0_5.fight_type.war_concerto or self._enter_type == var_0_5.fight_type.score_attack or self._enter_type == var_0_5.battle_type.push or self._enter_type == gameenum.battle_type.fight_type.eighth or self._enter_type == gameenum.battle_type.fight_type.ninth or self._enter_type == var_0_5.fight_type.fearlessness_sea then
			if var_18_0 and var_18_3 and var_18_1 <= 10 and var_0_3:get_support_info() then
				local var_18_5 = var_0_14.find_object_by_id(var_18_0)

				var_18_4 = var_18_5.effect.type == 1 and var_18_5.effect.num + 1 or 1
			else
				var_18_4 = 1
			end
		end

		local var_18_6 = 1
		local var_18_7 = var_0_3:get_new_battle_type()

		if var_18_7 == var_0_5.fight_type.gotofight or var_18_7 == gameenum.battle_type.fight_type.ocean_attack or var_18_7 == gameenum.battle_type.fight_type.score or var_18_7 == gameenum.battle_type.fight_type.campaign or var_18_7 == gameenum.battle_type.fight_type.sixth or self._enter_type == var_0_5.battle_type.push or var_18_7 == gameenum.battle_type.fight_type.eighth or var_18_7 == gameenum.battle_type.fight_type.ninth or var_18_7 == gameenum.battle_type.fight_type.push then
			local var_18_8 = lx.ServerTime:getUtcTime()
			local var_18_9 = var_0_15.find_object_by_id(11)

			if var_18_8 > var_18_9.content.startTime and var_18_8 < var_18_9.content.endTime then
				var_18_6 = var_18_9.content.expTimes
			end
		end

		return var_18_4 * var_18_6
	end

	function arg_1_0.update_mysterious_textbook_buff_float(arg_19_0)
		return lx.ServerTime:getUtcTime() < var_0_3:get_use_info_data().exp_card
	end

	function arg_1_0.update_combatshop_mysterious_textbook_buff_float(arg_20_0)
		return lx.ServerTime:getUtcTime() < var_0_3:get_use_info_data().combatshop_exp_card
	end

	function arg_1_0.update_combatshop_tactics_textbook_buff_float(arg_21_0)
		return lx.ServerTime:getUtcTime() < var_0_3:get_use_info_data().combatshop_tactics_card
	end
end

function var_0_0.extend_obj(arg_22_0)
	arg_22_0._ship_skin_id = nil
end

return var_0_0
