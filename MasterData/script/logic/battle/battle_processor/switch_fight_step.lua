local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = lx.json_encode
local var_0_3 = gamecore.UILoader
local var_0_4 = gamecore.user
local var_0_5 = gamecore.BattleManager
local var_0_6 = gameenum.common_type
local var_0_7 = gameenum.battle_type
local var_0_8 = gameconfig.ship_config
local var_0_9 = gameconfig.monster_config
local var_0_10 = table.insert
local var_0_11 = gamecore.effect
local var_0_14 = DG.Tweening.DOTween
local var_0_15 = gameconfig.abyss_map_node_config
local var_0_16 = gameconfig.pve_active_map_node_config
local var_0_17 = gamecore.util_func
local var_0_18 = gameconfig.cinema_story_id_list_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:start(arg_2_1)
		if arg_2_1 == "buff" then
			arg_2_1 = "dialog"
		end

		if arg_2_1 == "night_war" then
			self:change_night_bg()
		end

		if arg_2_1 == "air_attack" then
			self.start_air_attack = true
			arg_2_1 = "buff"
		else
			self.start_air_attack = false
		end

		self:__show_main_fight_buff_info()
		self:delay(3000, function()
			self:next_step(arg_2_1)
		end)
	end

	function arg_1_0:next_step(arg_4_1)
		if not arg_4_1 then
			return
		end

		local var_4_0 = string.format("on_%s", arg_4_1)

		if not self[var_4_0] then
			return
		end

		self[var_4_0](self)
	end

	function arg_1_0:on_dialog()
		local var_5_0 = self._battle_scene:get_fight_type()
		local var_5_1 = self._battle_scene:get_battle_point()
		local var_5_2 = {}

		for iter_5_0, iter_5_1 in pairs((var_0_4:get_player_story_unlock_data())) do
			var_0_10(var_5_2, iter_5_0, iter_5_1.id)
		end

		local var_5_3

		if var_5_0 == var_0_7.fight_type.abyss or var_5_0 == var_0_7.fight_type.abyss_2 then
			var_5_3 = var_0_15.find_object_by_id(var_5_1)
		elseif var_5_0 == var_0_7.fight_type.push then
			var_5_3 = var_0_16.find_object_by_id(var_5_1)
		end

		if var_5_3 and var_5_3.movie[3] and var_5_3.movie[3][1] ~= 0 and not var_0_17.have_data(var_5_2, var_5_3.movie[3][1]) then
			local var_5_4 = var_0_18.find_object_by_id(var_5_3.movie[3][1])

			var_0_3:createInstance("cinema_dialog"):show(var_5_4.movie_group_id, var_5_4.movie_id[1], var_5_4.movie_id[2], 5, nil, function()
				self:next_step("buff")
			end)

			return
		end

		self:next_step("buff")
	end

	function arg_1_0:__get_buff_couple_cutins()
		local var_7_0 = {}
		local var_7_1 = 0

		for iter_7_0, iter_7_1 in ipairs({
			1,
			-1
		}) do
			for iter_7_2, iter_7_3 in pairs(self._visual_set) do
				if iter_7_3._logic and iter_7_3._logic:get_side() == iter_7_1 then
					local var_7_2 = iter_7_3:get_buff_couple_cutin_infos()

					if #var_7_2 > 0 then
						var_0_10(var_7_0, {
							visual = iter_7_3,
							infos = var_7_2
						})

						var_7_1 = var_7_1 + #var_7_2
					end

					break
				end
			end
		end

		return var_7_0, var_7_1
	end

	function arg_1_0:on_buff()
		local var_8_0, var_8_1 = self:__get_buff_couple_cutins()

		if not self._battlefield._battle_report.buff and var_8_1 <= 0 then
			self:next_step("support")

			return
		end

		if self._battlefield._battle_report.buff then
			self:eventOnBattleStep(var_0_6.fight_step_rule.buff.value)
		end

		local var_8_2 = self:__get_buff_step_list(self._battlefield._battle_report.buff)

		self._buff_step_next_done = false

		self:__show_buff_stage(var_8_2, var_8_0)

		local var_8_3 = var_0_14.Sequence()

		self:enqueue_visual(var_8_3)
		var_8_3:AppendInterval(var_0_6.buff_step_time.couple_cutin * var_8_1 + (var_0_6.buff_step_time.buff_cutin + var_0_6.buff_step_time.buff_name + var_0_6.buff_step_time.buff_extra) * #var_8_2 + var_0_6.buff_step_time.fixed_extra)
		var_8_3:AppendCallback(function()
			self:__enter_buff_next_step()
		end)
		var_8_3:Play()
	end

	function arg_1_0:__enter_buff_next_step()
		if self._buff_step_next_done then
			return
		end

		self._buff_step_next_done = true

		self:next_step("support")
	end

	function arg_1_0.__show_buff_stage(arg_11_0, arg_11_1, arg_11_2)
		local var_11_0 = 0

		local function var_11_2()
			var_11_0 = var_11_0 + 1

			if not arg_11_2[var_11_0] then
				arg_11_0:__excute_buff_step_delay(arg_11_1, 0)

				return
			end

			arg_11_2[var_11_0].visual:couple_skill_cutin_list(arg_11_2[var_11_0].infos, var_11_2, function(arg_13_0)
				arg_11_0:__show_couple_buff_info(arg_13_0, arg_11_1)
			end)
		end

		;(nil)()
	end

	function arg_1_0:__show_couple_buff_info(arg_14_1, arg_14_2)
		local var_14_0

		for iter_14_0, iter_14_1 in ipairs(arg_14_2) do
			if iter_14_1.visual:get_side() == arg_14_1.side and iter_14_1.buff_data.skill_type == arg_14_1.skill_type then
				iter_14_1.info_shown = true

				iter_14_1.visual:buff_anim_step(iter_14_1.buff_data, nil, iter_14_1.visual._now_hp)
				self:__show_target_buff_up(iter_14_1.buff_data)

				if not var_14_0 or iter_14_1.buff_data.source_id == arg_14_1.source_id then
					var_14_0 = iter_14_1
				end
			end
		end

		if var_14_0 then
			var_14_0.visual:buff_info_step(var_14_0.buff_data)
		end
	end

	function arg_1_0:__get_buff_step_list(arg_15_1)
		arg_15_1 = arg_15_1 or {}

		local var_15_0 = {}
		local var_15_1 = {}

		var_15_1[1] = arg_15_1.player_buff or {}
		var_15_1[2] = arg_15_1.enemy_buff or {}

		for iter_15_0, iter_15_1 in ipairs(var_15_1) do
			local var_15_2 = {}

			for iter_15_2, iter_15_3 in ipairs(iter_15_1) do
				local var_15_3 = self:find_visual(iter_15_3.source_id)

				if var_15_3 then
					local var_15_4 = {
						visual = var_15_3,
						buff_data = iter_15_3
					}

					if var_15_3:buff_has_cutin(iter_15_3) then
						var_0_10(var_15_0, var_15_4)
					else
						var_0_10(var_15_2, var_15_4)
					end
				end
			end

			for iter_15_4, iter_15_5 in ipairs(var_15_2) do
				var_0_10(var_15_0, iter_15_5)
			end
		end

		return var_15_0
	end

	function arg_1_0:on_support()
		if not self._battlefield._battle_report.support_attack then
			self:next_step("air_attack")

			return
		end

		self:eventOnBattleStep(var_0_6.fight_step_rule.support.value)
		self:show_cannon_attack_cutting(self._battlefield._battle_report.support_attack)
	end

	function arg_1_0:on_air_attack()
		local var_17_0 = var_0_1.clone_table(self._battlefield._battle_report.aircraft_attack)

		if not var_17_0 or not next(var_17_0) then
			self:next_step("air_attack_damage_cutin")

			return
		end

		self:delay(500, function()
			self:eventOnBattleStep(var_0_6.fight_step_rule.air_attack.value)
			self:process_aircraft_attack(var_17_0)
		end)
	end

	function arg_1_0:on_air_attack_damage_cutin()
		local var_19_0 = self._battlefield._battle_report.air_attack_damage_cutin

		if not self._battlefield._battle_report.air_attack_damage_cutin then
			self:next_step("air_attack_recovery")

			return
		end

		if self._battle_scene:get_fight_type() == var_0_7.fight_type.plot_main then
			self:next_step("air_attack_recovery")

			return
		end

		self:delay(500, function()
			self:process_damage_cutin(var_19_0, "air_attack_damage_cutin", 1)
		end)
	end

	function arg_1_0:on_air_attack_recovery()
		local var_21_0 = self._battlefield._battle_report.air_attack_recovery

		if not self._battlefield._battle_report.air_attack_recovery then
			self:next_step("open_missile_attack")

			return
		end

		if self._battle_scene:get_fight_type() == var_0_7.fight_type.plot_main then
			self:next_step("open_missile_attack")

			return
		end

		self:delay(2000, function()
			self:process_recovery(var_21_0, "air_attack_recovery", 1)
		end)
	end

	function arg_1_0:on_open_missile_attack()
		local var_23_0 = self._battlefield._battle_report.open_missile_attack
		local var_23_1 = self:lock_target_event()

		if not self._battlefield._battle_report.open_missile_attack then
			self:delay(var_23_1, function()
				self:next_step("open_missile_damage_cutin")
			end)

			return
		end

		self:delay(500 + var_23_1, function()
			self:eventOnBattleStep(var_0_6.fight_step_rule.first_missile.value)
			self:process_missile_attack(var_23_0, "open_missile_attack")
		end)
	end

	function arg_1_0:on_open_missile_damage_cutin()
		local var_26_0 = self._battlefield._battle_report.open_missile_attack_damage_cutin

		if not self._battlefield._battle_report.open_missile_attack_damage_cutin then
			self:next_step("open_missile_attack_recovery")

			return
		end

		if self._battle_scene:get_fight_type() == var_0_7.fight_type.plot_main then
			self:next_step("open_missile_attack_recovery")

			return
		end

		self:delay(500, function()
			self:process_damage_cutin(var_26_0, "open_missile_damage_cutin", 1)
		end)
	end

	function arg_1_0:on_open_missile_attack_recovery()
		local var_28_0 = self._battlefield._battle_report.open_missile_attack_recovery

		if not self._battlefield._battle_report.open_missile_attack_recovery then
			self:next_step("open_antisub_attack")

			return
		end

		if self._battle_scene:get_fight_type() == var_0_7.fight_type.plot_main then
			self:next_step("open_antisub_attack")

			return
		end

		self:delay(2000, function()
			self:process_recovery(var_28_0, "open_missile_recovery", 1)
		end)
	end

	function arg_1_0:on_open_antisub_attack()
		local var_30_0 = self._battlefield._battle_report.open_antisub_attack

		if not self._battlefield._battle_report.open_antisub_attack then
			self:next_step("open_antisub_attack_damage_cutin")

			return
		end

		self:delay(500, function()
			self:eventOnBattleStep(var_0_6.fight_step_rule.first_anti_sub.value)
			self:process_open_antisub_attack(var_30_0)
		end)
	end

	function arg_1_0:on_open_antisub_attack_damage_cutin()
		local var_32_0 = self._battlefield._battle_report.open_antisub_attack_damage_cutin

		if not self._battlefield._battle_report.open_antisub_attack_damage_cutin then
			self:next_step("open_antisub_attack_recovery")

			return
		end

		if self._battle_scene:get_fight_type() == var_0_7.fight_type.plot_main then
			self:next_step("open_antisub_attack_recovery")

			return
		end

		self:delay(500, function()
			self:process_damage_cutin(var_32_0, "open_antisub_attack_damage_cutin", 1)
		end)
	end

	function arg_1_0:on_open_antisub_attack_recovery()
		local var_34_0 = self._battlefield._battle_report.open_antisub_attack_recovery

		if not self._battlefield._battle_report.open_antisub_attack_recovery then
			self:next_step("open_torpedo_attack")

			return
		end

		if self._battle_scene:get_fight_type() == var_0_7.fight_type.plot_main then
			self:next_step("open_torpedo_attack")

			return
		end

		self:delay(2000, function()
			self:process_recovery(var_34_0, "open_antisub_recovery", 1)
		end)
	end

	function arg_1_0:on_open_torpedo_attack()
		local var_36_0 = self._battlefield._battle_report.open_torpedo_attack
		local var_36_1 = self._battlefield._battle_result.team_state

		if not self._battlefield._battle_report.open_torpedo_attack then
			self:next_step("open_torpedo_attack_damage_cutin")

			return
		end

		self:delay(500, function()
			self:eventOnBattleStep(var_0_6.fight_step_rule.first_torpedo.value)
			self:process_open_torpedo_attack(var_36_0, var_36_1)
		end)
	end

	function arg_1_0:on_open_torpedo_attack_damage_cutin()
		local var_38_0 = self._battlefield._battle_report.open_torpedo_attack_damage_cutin

		if not self._battlefield._battle_report.open_torpedo_attack_damage_cutin then
			self:next_step("open_torpedo_attack_recovery")

			return
		end

		if self._battle_scene:get_fight_type() == var_0_7.fight_type.plot_main then
			self:next_step("open_torpedo_attack_recovery")

			return
		end

		self:delay(500, function()
			self:process_damage_cutin(var_38_0, "open_torpedo_attack_damage_cutin", 1)
		end)
	end

	function arg_1_0:on_open_torpedo_attack_recovery()
		local var_40_0 = self._battlefield._battle_report.open_torpedo_attack_recovery

		if not self._battlefield._battle_report.open_torpedo_attack_recovery then
			self:next_step("normal_attack")

			return
		end

		if self._battle_scene:get_fight_type() == var_0_7.fight_type.plot_main then
			self:next_step("normal_attack")

			return
		end

		self:delay(2000, function()
			self:process_recovery(var_40_0, "open_torpedo_recovery", 1)
		end)
	end

	function arg_1_0:on_normal_attack()
		local var_42_0 = self._battlefield._battle_report.normal_attack

		if not self._battlefield._battle_report.normal_attack then
			self:next_step("normal_attack2")

			return
		end

		self:eventOnBattleStep(var_0_6.fight_step_rule.first_shelling.value)
		self:delay(500, function()
			self:process_normal_attack(var_42_0, 1, "normal_attack")
		end)
	end

	function arg_1_0:on_normal_attack2()
		local var_44_0 = self._battlefield._battle_report.normal_attack2

		if not self._battlefield._battle_report.normal_attack2 then
			self:next_step("close_torpedo_attack")

			return
		end

		self:eventOnBattleStep(var_0_6.fight_step_rule.second_shelling.value)
		self:delay(500, function()
			self:process_normal_attack(var_44_0, 1, "normal_attack2")
		end)
	end

	function arg_1_0:on_close_torpedo_attack()
		local var_46_0 = self._battlefield._battle_report.torpedo_attack

		if not self._battlefield._battle_report.torpedo_attack then
			self:next_step("close_torpedo_attack_damage_cutin")

			return
		end

		self:delay(500, function()
			self:eventOnBattleStep(var_0_6.fight_step_rule.torpedo_war.value)
			self:process_torpedo_attack(var_46_0)
		end)
	end

	function arg_1_0:on_close_torpedo_attack_damage_cutin()
		local var_48_0 = self._battlefield._battle_report.close_torpedo_attack_damage_cutin

		if not self._battlefield._battle_report.close_torpedo_attack_damage_cutin then
			self:next_step("close_torpedo_attack_recovery")

			return
		end

		if self._battle_scene:get_fight_type() == var_0_7.fight_type.plot_main then
			self:next_step("close_torpedo_attack_recovery")

			return
		end

		self:delay(500, function()
			self:process_damage_cutin(var_48_0, "close_torpedo_attack_damage_cutin", 1)
		end)
	end

	function arg_1_0:on_close_torpedo_attack_recovery()
		local var_50_0 = self._battlefield._battle_report.close_torpedo_attack_recovery

		if not self._battlefield._battle_report.close_torpedo_attack_recovery then
			self:next_step("close_missile_attack")

			return
		end

		if self._battle_scene:get_fight_type() == var_0_7.fight_type.plot_main then
			self:next_step("close_missile_attack")

			return
		end

		self:delay(2000, function()
			self:process_recovery(var_50_0, "close_torpedo_recovery", 1)
		end)
	end

	function arg_1_0:on_close_missile_attack()
		local var_52_0 = self._battlefield._battle_report.close_missile_attack

		if not self._battlefield._battle_report.close_missile_attack then
			self:next_step("close_missile_attack_damage_cutin")

			return
		end

		self:delay(500, function()
			self:eventOnBattleStep(var_0_6.fight_step_rule.closing_missile.value)
			self:process_missile_attack(var_52_0, "close_missile_attack")
		end)
	end

	function arg_1_0:on_close_missile_attack_damage_cutin()
		local var_54_0 = self._battlefield._battle_report.close_missile_attack_damage_cutin

		if not self._battlefield._battle_report.close_missile_attack_damage_cutin then
			self:next_step("close_missile_attack_recovery")

			return
		end

		if self._battle_scene:get_fight_type() == var_0_7.fight_type.plot_main then
			self:next_step("close_missile_attack_recovery")

			return
		end

		self:delay(500, function()
			self:process_damage_cutin(var_54_0, "close_missile_attack_damage_cutin", 1)
		end)
	end

	function arg_1_0:on_close_missile_attack_recovery()
		local var_56_0 = self._battlefield._battle_report.close_missile_attack_recovery

		if not self._battlefield._battle_report.close_missile_attack_recovery then
			self:next_step("day_war_end")

			return
		end

		if self._battle_scene:get_fight_type() == var_0_7.fight_type.plot_main then
			self:next_step("day_war_end")

			return
		end

		self:delay(2000, function()
			self:process_recovery(var_56_0, "close_missile_recovery", 1)
		end)
	end

	function arg_1_0:on_day_war_end()
		if self._battlefield._battle_end then
			self:delay(1500, function()
				self:on_night_war_end()
			end)

			return
		end

		local var_58_0 = self._battlefield._battle_report.day_war_end

		var_58_0.damage_control_num = self._battle_scene:get_damage_control_num()

		self:delay(800, function()
			local var_60_0 = var_0_3:getInstance(var_0_6:get_battle_name())

			if not var_60_0 then
				return
			end

			var_58_0.start_air_attack = self.start_air_attack and self.start_air_attack or nil

			var_60_0:show_night_war_tip(var_58_0)
			var_60_0:close_stage_step()
			var_0_5:set_battle_damage_report(self._battlefield:get_damage_result())
		end)
	end

	function arg_1_0:on_night_war()
		self:change_night_bg()
		self:eventOnBattleStep(var_0_6.fight_step_rule.night_fight.value)

		local var_61_0 = self._battlefield._battle_report.night_attack

		if not self._battlefield._battle_report.night_attack then
			self:next_step("night_war_end")

			return
		end

		self:delay(500, function()
			self:process_night_attack(var_61_0, 1)
		end)
	end

	function arg_1_0:on_night_war_end()
		local function var_63_0()
			local var_64_0

			if self._battlefield then
				var_64_0 = self._battlefield:get_damage_result()
			end

			var_0_5:exit(function(arg_65_0)
				if self._battle_scene:get_fight_type() == var_0_7.fight_type.plot_main then
					local var_65_0 = var_0_3:getInstance(var_0_6:get_battle_name())

					var_65_0._fight_type = var_0_6.fight_type.event_story

					var_65_0:enter_plot_event(arg_65_0, self._battlefield._battle_result)
				else
					var_0_4:tryPushEnterEndDo(function()
						self:kill_all_visual()
						var_0_4:req_BattleFinishReq()
						self:write_battle_damage_info(var_64_0)
					end)
				end
			end)
		end

		self:delay(500, function()
			local var_67_0 = var_0_3:getInstance(var_0_6:get_battle_name())

			if var_67_0 then
				var_67_0:close_stage_step(nil, var_63_0)
			end
		end)
	end

	function arg_1_0.write_battle_damage_info(arg_68_0, arg_68_1)
		if not app:isPC() then
			return
		end

		if not arg_68_1 then
			return
		end

		local var_68_0 = var_0_2(var_0_4:get_battle_data().record)
		local var_68_1 = app:getSystem()
		local var_68_2 = io.open(var_68_1:getWritePath() .. "battlereport", "wb")

		if var_68_1 then
			var_68_2:write(var_0_4:get_bvr_damage_info() .. "\n" .. var_0_1.json_format(arg_68_1) .. var_68_0)
		else
			var_68_2:write(var_0_1.json_format(arg_68_1) .. var_68_0)
		end

		var_68_2:close()
	end

	function arg_1_0:process_aircraft_attack(arg_69_1)
		local var_69_0 = 0
		local var_69_1 = 0
		local var_69_2 = false
		local var_69_3 = self:get_length(arg_69_1)
		local var_69_4 = var_0_14.Sequence()

		self:enqueue_visual(var_69_4)

		for iter_69_0, iter_69_1 in pairs(arg_69_1) do
			for iter_69_2, iter_69_3 in ipairs(iter_69_1) do
				if iter_69_3.side == 1 and var_69_2 == false then
					var_69_2 = true
				end

				if iter_69_3.side == -1 and false == false then
					if var_69_2 == true then
						var_69_0 = 2
					end
				end
			end
		end

		local var_69_6 = false
		local var_69_7 = false

		var_69_4:AppendCallback(function()
			for iter_70_0, iter_70_1 in pairs(arg_69_1) do
				for iter_70_2, iter_70_3 in ipairs(iter_70_1) do
					if iter_70_3.side == 1 and var_69_6 == false then
						iter_70_3.can_show_it = true

						local var_70_0 = self:find_visual(iter_70_3.attack_id)

						if var_70_0 then
							var_70_0._plane_img_type = iter_70_3.plane_type == 0 and 1 or iter_70_3.plane_type

							var_70_0:show_aircraft_cutin(iter_70_3.can_show_it, iter_70_3.side)

							var_69_6 = true
						end
					end
				end
			end
		end)
		var_69_4:AppendInterval(var_69_0)
		var_69_4:AppendCallback(function()
			for iter_71_0, iter_71_1 in pairs(arg_69_1) do
				for iter_71_2, iter_71_3 in ipairs(iter_71_1) do
					if iter_71_3.side == -1 and var_69_7 == false then
						iter_71_3.can_show_it = true

						local var_71_0 = self:find_visual(iter_71_3.attack_id)

						var_71_0._plane_img_type = iter_71_3.plane_type == 0 and 1 or iter_71_3.plane_type

						var_71_0:show_aircraft_cutin(iter_71_3.can_show_it, iter_71_3.side)

						var_69_7 = true
					end
				end
			end
		end)
		var_69_4:AppendInterval(2)
		var_69_4:AppendCallback(function()
			for iter_72_0, iter_72_1 in pairs(arg_69_1) do
				for iter_72_2, iter_72_3 in ipairs(iter_72_1) do
					self:find_visual(iter_72_3.attack_id):aircraft_attack(iter_72_3, function()
						var_69_1 = var_69_1 + 1

						if var_69_1 == var_69_3 then
							self:delay(1000, function()
								self:show_aircontrol(self._battle_scene:get_player_air_control_type(), self._battle_scene:get_player_air_control_value(), self._battle_scene:get_enemy_air_control_value())
								self:delay(1200, function()
									self:next_step("air_attack_damage_cutin")
								end)
							end)
						end
					end)
				end
			end
		end)
	end

	function arg_1_0:process_open_antisub_attack(arg_76_1)
		local var_76_0 = 0
		local var_76_1 = #arg_76_1

		for iter_76_0, iter_76_1 in pairs(arg_76_1) do
			self:find_visual(iter_76_1.attack_id):open_antisub_attack(iter_76_1, function()
				var_76_0 = var_76_0 + 1

				if var_76_0 == var_76_1 then
					self:delay(1500, function()
						self:next_step("open_antisub_attack_damage_cutin")
					end)
				end
			end)
		end
	end

	function arg_1_0:process_open_torpedo_attack(arg_79_1, arg_79_2)
		local var_79_0 = 0
		local var_79_1 = 0
		local var_79_2 = false
		local var_79_3 = false
		local var_79_4 = self:get_length(arg_79_1)
		local var_79_5 = var_0_14.Sequence()

		self:enqueue_visual(var_79_5)

		for iter_79_0, iter_79_1 in pairs(arg_79_1) do
			for iter_79_2, iter_79_3 in ipairs(iter_79_1) do
				if iter_79_3.side == 1 and var_79_2 == false then
					var_79_2 = true
				end

				if iter_79_3.side == -1 and false == false then
					if var_79_2 == true then
						var_79_0 = 2.5
					end
				end
			end
		end

		local var_79_7 = false
		local var_79_8 = false

		var_79_5:AppendCallback(function()
			for iter_80_0, iter_80_1 in pairs(arg_79_1) do
				for iter_80_2, iter_80_3 in ipairs(iter_80_1) do
					if iter_80_3.syncytium_skill_cid and iter_80_3.side == 1 and var_79_7 == false then
						local var_80_0 = self:find_visual(iter_80_3.attack_id)

						if var_80_0 then
							var_80_0:syncytium_skill_cutin(iter_80_3.syncytium_skill_cid, arg_79_2)

							var_79_7 = true
							var_79_3 = true
						end
					end
				end
			end
		end)
		var_79_5:AppendCallback(function()
			for iter_81_0, iter_81_1 in pairs(arg_79_1) do
				for iter_81_2, iter_81_3 in ipairs(iter_81_1) do
					if iter_81_3.syncytium_skill_cid and iter_81_3.side == -1 and var_79_8 == false then
						local var_81_0 = self:find_visual(iter_81_3.attack_id)

						if var_81_0 then
							var_81_0:syncytium_skill_cutin(iter_81_3.syncytium_skill_cid, arg_79_2)

							var_79_8 = true
						end
					end
				end
			end
		end)
		var_79_5:AppendInterval(1.3)
		var_79_5:AppendCallback(function()
			for iter_82_0, iter_82_1 in pairs(arg_79_1) do
				for iter_82_2, iter_82_3 in pairs(iter_82_1) do
					self:find_visual(iter_82_3.attack_id):open_torpedo_attack(iter_82_3, function()
						var_79_1 = var_79_1 + 1

						if var_79_1 == var_79_4 then
							self:delay(300, function()
								self:next_step("open_torpedo_attack_damage_cutin")
							end)
						end
					end)
				end
			end
		end)
	end

	function arg_1_0:process_normal_attack(arg_85_1, arg_85_2, arg_85_3)
		local var_85_0 = 0
		local var_85_1 = true

		if not arg_85_1[arg_85_2] then
			if arg_85_3 == "normal_attack2" then
				self:next_step("close_torpedo_attack")

				return
			else
				self:next_step("normal_attack2")

				return
			end
		end

		for iter_85_0, iter_85_1 in ipairs(arg_85_1[arg_85_2]) do
			local var_85_2 = self:find_visual(iter_85_1.attack_id)

			if not var_85_2 then
				log.errorlog("no visual---------")

				return
			end

			self:delay(arg_85_2 == 1 and 0 or 1000, function()
				var_85_2:normal_attack(iter_85_1, function()
					if var_85_1 == true then
						if iter_85_1.recovery and self._battle_scene:get_fight_type() ~= var_0_7.fight_type.plot_main then
							local var_87_0 = self:find_visual(iter_85_1.recovery.recovery_id)

							self:delay(1000, function()
								var_87_0:show_damage_recovery(function()
									var_87_0:recovery(iter_85_1.recovery)

									local var_89_0 = var_87_0._logic:get_attribute().hp:get_final_value()

									var_87_0:update_hp(var_89_0)
									var_87_0:update_submarine_hp(var_89_0)

									if iter_85_0 == #arg_85_1[arg_85_2] then
										self:process_normal_attack(arg_85_1, arg_85_2 + 1, arg_85_3)
									end
								end)
							end)
						elseif iter_85_0 == #arg_85_1[arg_85_2] then
							self:process_normal_attack(arg_85_1, arg_85_2 + 1, arg_85_3)
						end

						var_85_0 = var_85_0 + 1
						var_85_1 = false
					elseif iter_85_1.recovery and self._battle_scene:get_fight_type() ~= var_0_7.fight_type.plot_main then
						local var_87_1 = self:find_visual(iter_85_1.recovery.recovery_id)

						self:delay(1000 + var_85_0 * 2333, function()
							var_87_1:show_damage_recovery(function()
								var_87_1:recovery(iter_85_1.recovery)

								local var_91_0 = var_87_1._logic:get_attribute().hp:get_final_value()

								var_87_1:update_hp(var_91_0)
								var_87_1:update_submarine_hp(var_91_0)

								if iter_85_0 == #arg_85_1[arg_85_2] then
									self:process_normal_attack(arg_85_1, arg_85_2 + 1, arg_85_3)
								end
							end)
						end)
					elseif iter_85_0 == #arg_85_1[arg_85_2] then
						self:process_normal_attack(arg_85_1, arg_85_2 + 1, arg_85_3)
					end
				end)
			end)
		end
	end

	function arg_1_0:process_torpedo_attack(arg_92_1)
		local var_92_0 = 0
		local var_92_1 = self:get_length(arg_92_1)

		for iter_92_0, iter_92_1 in pairs(arg_92_1) do
			for iter_92_2, iter_92_3 in pairs(iter_92_1) do
				self:find_visual(iter_92_3.attack_id):torpedo_attack(iter_92_3, false, function()
					var_92_0 = var_92_0 + 1

					if var_92_0 == var_92_1 then
						self:delay(300, function()
							self:next_step("close_torpedo_attack_damage_cutin")
						end)
					end
				end)
			end
		end
	end

	function arg_1_0:process_missile_attack(arg_95_1, arg_95_2)
		local var_95_0 = 0
		local var_95_1 = self:get_length(arg_95_1)

		for iter_95_0, iter_95_1 in pairs(arg_95_1) do
			for iter_95_2, iter_95_3 in pairs(iter_95_1) do
				if (iter_95_0 == 1 or nil) and true and iter_95_2 == 1 then
					iter_95_3.can_show_it = true
				end

				self:find_visual(iter_95_3.attack_id):missile_attack(iter_95_3, false, function()
					var_95_0 = var_95_0 + 1

					if var_95_0 == var_95_1 then
						if arg_95_2 == "open_missile_attack" then
							self:delay(300, function()
								self:next_step("open_missile_damage_cutin")
							end)
						else
							self:delay(300, function()
								self:next_step("close_missile_attack_damage_cutin")
							end)
						end
					end
				end, iter_95_2 - 1)
			end
		end
	end

	function arg_1_0:process_night_attack(arg_99_1, arg_99_2)
		if arg_99_2 > #arg_99_1 or not arg_99_1[arg_99_2] then
			self:on_night_war_end()

			return
		end

		if arg_99_1[arg_99_2].type == "missile_attack" then
			arg_99_1[arg_99_2].type = nil

			local var_99_0 = 0
			local var_99_1 = #arg_99_1[arg_99_2]
			local var_99_2 = 0

			for iter_99_0, iter_99_1 in pairs(arg_99_1[arg_99_2]) do
				self:find_visual(iter_99_1.attack_id):missile_attack(iter_99_1, false, function()
					var_99_0 = var_99_0 + 1

					if iter_99_1.recovery then
						local var_100_0 = self:find_visual(iter_99_1.recovery.recovery_id)

						var_99_2 = var_99_2 + 1

						self:delay(1000, function()
							var_100_0:show_damage_recovery(function()
								local var_102_0 = var_100_0._logic:get_attribute().hp:get_final_value()

								var_100_0:update_hp(var_102_0)
								var_100_0:update_submarine_hp(var_102_0)
								var_100_0:recovery(arg_99_1[arg_99_2].recovery)

								if iter_99_0 == var_99_1 then
									self:process_night_attack(arg_99_1, arg_99_2 + 1)
								end
							end)
						end)
					elseif var_99_0 == var_99_1 then
						arg_99_2 = arg_99_2 + 1

						self:delay(1000 + var_99_2 * 4567, function()
							self:process_night_attack(arg_99_1, arg_99_2)
						end)
					end
				end)
			end
		end

		if arg_99_1[arg_99_2].type == "torpedo_attack" then
			arg_99_1[arg_99_2].type = nil

			local var_99_3 = 0
			local var_99_4 = #arg_99_1[arg_99_2]

			for iter_99_2, iter_99_3 in pairs(arg_99_1[arg_99_2]) do
				self:find_visual(iter_99_3.attack_id):torpedo_attack(iter_99_3, true, function()
					var_99_3 = var_99_3 + 1

					if iter_99_3.recovery then
						local var_104_0 = self:find_visual(iter_99_3.recovery.recovery_id)

						self:delay(1000, function()
							var_104_0:show_damage_recovery(function()
								local var_106_0 = var_104_0._logic:get_attribute().hp:get_final_value()

								var_104_0:update_hp(var_106_0)
								var_104_0:update_submarine_hp(var_106_0)
								var_104_0:recovery(arg_99_1[arg_99_2].recovery)

								if iter_99_2 == var_99_4 then
									self:process_night_attack(arg_99_1, arg_99_2 + 1)
								end
							end)
						end)
					elseif var_99_3 == var_99_4 then
						arg_99_2 = arg_99_2 + 1

						self:delay(1000, function()
							self:process_night_attack(arg_99_1, arg_99_2)
						end)
					end
				end)
			end
		end

		if arg_99_1[arg_99_2].type == "normal_attack" then
			arg_99_1[arg_99_2].type = nil

			local var_99_5 = 0
			local var_99_6 = #arg_99_1[arg_99_2]

			for iter_99_4, iter_99_5 in pairs(arg_99_1[arg_99_2]) do
				self:find_visual(iter_99_5.attack_id):normal_attack(iter_99_5, function()
					var_99_5 = var_99_5 + 1

					if iter_99_5.recovery then
						local var_108_0 = self:find_visual(iter_99_5.recovery.recovery_id)

						self:delay(1000, function()
							var_108_0:show_damage_recovery(function()
								local var_110_0 = var_108_0._logic:get_attribute().hp:get_final_value()

								var_108_0:update_hp(var_110_0)
								var_108_0:update_submarine_hp(var_110_0)
								var_108_0:recovery(arg_99_1[arg_99_2].recovery)

								if iter_99_4 == var_99_6 then
									self:process_night_attack(arg_99_1, arg_99_2 + 1)
								end
							end)
						end)
					elseif var_99_5 == var_99_6 then
						arg_99_2 = arg_99_2 + 1

						self:delay(1000, function()
							self:process_night_attack(arg_99_1, arg_99_2)
						end)
					end
				end)
			end
		end

		if arg_99_1[arg_99_2].type == "mix_attack" then
			self:find_visual(arg_99_1[arg_99_2].attack_id):night_mix_attack(arg_99_1[arg_99_2], function()
				if arg_99_1[arg_99_2].recovery then
					local var_112_0 = self:find_visual(arg_99_1[arg_99_2].recovery.recovery_id)

					self:delay(1000, function()
						var_112_0:show_damage_recovery(function()
							var_112_0:recovery(arg_99_1[arg_99_2].recovery)

							local var_114_0 = var_112_0._logic:get_attribute().hp:get_final_value()

							var_112_0:update_hp(var_114_0)
							var_112_0:update_submarine_hp(var_114_0)

							arg_99_2 = arg_99_2 + 1

							self:delay(1000, function()
								self:process_night_attack(arg_99_1, arg_99_2)
							end)
						end)
					end)
				else
					arg_99_2 = arg_99_2 + 1

					self:delay(1000, function()
						self:process_night_attack(arg_99_1, arg_99_2)
					end)
				end
			end)
		end

		if arg_99_1[arg_99_2].type == "antisub_attack" then
			self:find_visual(arg_99_1[arg_99_2].attack_id):antisub_attack(arg_99_1[arg_99_2], function()
				if arg_99_1[arg_99_2].recovery then
					local var_117_0 = self:find_visual(arg_99_1[arg_99_2].recovery.recovery_id)

					self:delay(1000, function()
						var_117_0:show_damage_recovery(function()
							var_117_0:recovery(arg_99_1[arg_99_2].recovery)

							local var_119_0 = var_117_0._logic:get_attribute().hp:get_final_value()

							var_117_0:update_hp(var_119_0)
							var_117_0:update_submarine_hp(var_119_0)

							arg_99_2 = arg_99_2 + 1

							self:delay(1000, function()
								self:process_night_attack(arg_99_1, arg_99_2)
							end)
						end)
					end)
				else
					arg_99_2 = arg_99_2 + 1

					self:delay(1000, function()
						self:process_night_attack(arg_99_1, arg_99_2)
					end)
				end
			end)
		end
	end

	function arg_1_0:process_recovery(arg_122_1, arg_122_2, arg_122_3)
		local var_122_0 = self:find_visual(arg_122_1[arg_122_3].recovery_id)

		var_122_0:show_damage_recovery(function()
			var_122_0:recovery(arg_122_1[arg_122_3])

			local var_123_0 = var_122_0._logic:get_attribute().hp:get_final_value()

			var_122_0:update_hp(var_123_0)
			var_122_0:update_submarine_hp(var_123_0)

			arg_122_3 = arg_122_3 + 1

			if arg_122_3 > #arg_122_1 then
				if arg_122_2 == "air_attack_recovery" then
					return self:next_step("open_missile_attack")
				end

				if arg_122_2 == "open_missile_recovery" then
					return self:next_step("open_antisub_attack")
				end

				if arg_122_2 == "open_antisub_recovery" then
					return self:next_step("open_torpedo_attack")
				end

				if arg_122_2 == "open_torpedo_recovery" then
					return self:next_step("normal_attack")
				end

				if arg_122_2 == "close_torpedo_recovery" then
					return self:next_step("close_missile_attack")
				end

				if arg_122_2 == "close_missile_recovery" then
					return self:next_step("day_war_end")
				end
			end

			self:process_recovery(arg_122_1, arg_122_2, arg_122_3)
		end)
	end

	function arg_1_0:process_damage_cutin(arg_124_1, arg_124_2, arg_124_3)
		self:find_visual(arg_124_1[arg_124_3].id):show_damage_cutin(arg_124_1[arg_124_3].now_hp, nil, function()
			arg_124_3 = arg_124_3 + 1

			if arg_124_3 > #arg_124_1 then
				if arg_124_2 == "air_attack_damage_cutin" then
					return self:next_step("air_attack_recovery")
				end

				if arg_124_2 == "open_missile_damage_cutin" then
					return self:next_step("open_missile_attack_recovery")
				end

				if arg_124_2 == "open_antisub_attack_damage_cutin" then
					return self:next_step("open_antisub_attack_recovery")
				end

				if arg_124_2 == "open_torpedo_attack_damage_cutin" then
					return self:next_step("open_torpedo_attack_recovery")
				end

				if arg_124_2 == "close_torpedo_attack_damage_cutin" then
					return self:next_step("close_torpedo_attack_recovery")
				end

				if arg_124_2 == "close_missile_attack_damage_cutin" then
					return self:next_step("close_missile_attack_recovery")
				end
			end

			self:process_damage_cutin(arg_124_1, arg_124_2, arg_124_3)
		end)
	end

	function arg_1_0:lock_target_event()
		local var_126_0 = {}
		local var_126_1 = {}
		local var_126_2 = 0

		for iter_126_0, iter_126_1 in ipairs(self._visual_set) do
			if iter_126_1._logic._side == 1 then
				var_0_10(var_126_0, iter_126_1)

				var_126_0[iter_126_1._logic:get_index()] = iter_126_1
			end

			if iter_126_1._logic._side == -1 then
				var_126_1[iter_126_1._logic:get_index()] = iter_126_1
			end
		end

		if self._battle_scene:get_player_formation() == 4 then
			local var_126_3
			local var_126_4

			for iter_126_2, iter_126_3 in pairs(var_126_0) do
				if self._battle_scene:get_fight_type() == var_0_7.fight_type.plot_main then
					var_126_3 = var_0_8.find_object_by_cid(iter_126_3._logic:get_cid()).type
				else
					var_126_4 = var_0_8.find_object_by_cid(iter_126_3._logic:get_cid()).guard_type
				end

				if (var_126_4 == 2 or ((var_126_3 == 2 or var_126_3 == 7 or var_126_3 == 8 or var_126_3 == 9 or var_126_3 == 10 or var_126_3 == 11 or var_126_3 == 12 or var_126_3 == 16 or var_126_3 == 23 or var_126_3 == 24 or var_126_3 == 28 or nil) and true) == true) and iter_126_3._now_hp > 0 then
					local var_126_6 = iter_126_3._logic:get_index()

					while var_126_6 == 0 or var_126_1[var_126_6] and not var_126_1[var_126_6]._logic:is_submarine() do
						if var_126_1[var_126_6] and not var_126_1[var_126_6].is_be_lock and var_126_1[var_126_6]._now_hp > 0 then
							var_126_1[var_126_6].is_be_lock = true

							self:__create_lock_target_effect("lock_target", var_126_1[var_126_6]._spine.transform.transform.position, iter_126_3._logic._side)

							var_126_2 = 1100

							break
						end

						var_126_6 = var_126_6 - 1
					end
				end
			end
		end

		if self._battle_scene:get_enemy_formation() == 4 then
			for iter_126_4, iter_126_5 in pairs(var_126_1) do
				local var_126_7 = (var_0_9.find_object_by_id(iter_126_5._logic:get_cid()) or var_0_8.find_object_by_cid(iter_126_5._logic:get_cid())).type

				if iter_126_5._now_hp > 0 and (var_126_7 == 2 or var_126_7 == 7 or var_126_7 == 8 or var_126_7 == 9 or var_126_7 == 10 or var_126_7 == 11 or var_126_7 == 12 or var_126_7 == 14 or var_126_7 == 16 or var_126_7 == 23 or var_126_7 == 24 or var_126_7 == 28) then
					local var_126_8 = iter_126_5._logic:get_index()

					while var_126_8 == 0 or var_126_0[var_126_8] and not var_126_0[var_126_8]._logic:is_submarine() and var_126_0[var_126_8]._now_hp > 0 do
						if var_126_0[var_126_8] and not var_126_0[var_126_8].is_be_lock then
							var_126_0[var_126_8].is_be_lock = true

							self:__create_lock_target_effect("lock_target", var_126_0[var_126_8]._spine.transform.transform.position, iter_126_5._logic._side)

							var_126_2 = 1100

							break
						end

						var_126_8 = var_126_8 - 1
					end
				end
			end
		end

		return var_126_2
	end

	function arg_1_0.get_length(arg_127_0, arg_127_1)
		local var_127_0 = 0

		for iter_127_0, iter_127_1 in pairs(arg_127_1) do
			for iter_127_2, iter_127_3 in pairs(iter_127_1) do
				var_127_0 = var_127_0 + 1
			end
		end

		return var_127_0
	end

	function arg_1_0.__create_lock_target_effect(arg_128_0, arg_128_1, arg_128_2, arg_128_3)
		local var_128_0 = var_0_11:create()

		var_128_0:create_effect(arg_128_1)
		var_128_0:set_side(arg_128_3)
		var_128_0:set_pos(arg_128_2 + Vector3(0, 1, -1))
	end

	function arg_1_0:__excute_buff_step_delay(arg_129_1, arg_129_2)
		arg_129_2 = arg_129_2 + 1

		if not arg_129_1[arg_129_2] then
			self:__enter_buff_next_step()

			return
		end

		self:__show_buff_step(arg_129_1[arg_129_2], function()
			self:__excute_buff_step_delay(arg_129_1, arg_129_2)
		end)
	end

	function arg_1_0:__show_buff_step(arg_131_1, arg_131_2)
		if arg_131_1.info_shown then
			if arg_131_2 then
				arg_131_2()
			end

			return
		end

		local var_131_0 = arg_131_1.visual
		local var_131_1 = 2

		local function var_131_2()
			var_131_1 = var_131_1 - 1

			if var_131_1 == 0 and arg_131_2 then
				arg_131_2()
			end
		end

		arg_131_1.visual:buff_anim_step(arg_131_1.buff_data, var_131_2, arg_131_1.visual._now_hp)
		var_131_0:buff_info_step(arg_131_1.buff_data, var_131_2)
		self:__show_target_buff_up(arg_131_1.buff_data)
	end

	function arg_1_0:__show_target_buff_up(arg_133_1)
		if not arg_133_1.target_list then
			return
		end

		local var_133_0 = arg_133_1.target_list
		local var_133_1 = var_0_14.Sequence()

		self:enqueue_visual(var_133_1)
		var_133_1:AppendCallback(function()
			for iter_134_0, iter_134_1 in pairs(var_133_0[1]) do
				local var_134_0 = self:find_visual(iter_134_1.target_id)

				if var_134_0 then
					var_134_0:buff_up_tips(iter_134_1)
				end
			end

			self:__excute_show_buff_logo_delay(var_133_0, 1)

			local var_134_1 = self:find_visual(arg_133_1.source_id)

			if var_134_1 then
				var_134_1:buff_icon(arg_133_1.skill_id, var_134_1:get_side())
			end
		end)
		var_133_1:Play()
	end

	function arg_1_0:__excute_show_buff_logo_delay(arg_135_1, arg_135_2)
		if arg_135_2 < #arg_135_1 then
			arg_135_2 = arg_135_2 + 1

			self:__show_buff_logo_info(arg_135_1, arg_135_2, function()
				self:__excute_show_buff_logo_delay(arg_135_1, arg_135_2)
			end)
		end
	end

	function arg_1_0:__show_buff_logo_info(arg_137_1, arg_137_2, arg_137_3)
		local var_137_0 = var_0_14.Sequence()

		self:enqueue_visual(var_137_0)
		var_137_0:AppendCallback(function()
			for iter_138_0, iter_138_1 in pairs(arg_137_1[arg_137_2]) do
				local var_138_0 = self:find_visual(iter_138_1.target_id)

				if var_138_0 then
					var_138_0:buff_up_tips(iter_138_1)
				end
			end
		end)
		var_137_0:AppendCallback(arg_137_3)
		var_137_0:Play()
	end

	function arg_1_0:__show_main_fight_buff_info()
		local var_139_0 = self._battle_scene:get_main_fight_buff_data()
		local var_139_1 = self._battle_scene:get_push_fight_buff_data()

		if var_139_0 then
			local var_139_2 = var_0_3:getInstance(var_0_6:get_battle_name())

			if var_139_2 then
				for iter_139_0, iter_139_1 in pairs(var_139_0) do
					var_139_2:attach_buff("main_fight", iter_139_1)
				end
			end
		end

		if var_139_1 and var_139_1 ~= 0 then
			local var_139_3 = var_0_3:getInstance(var_0_6:get_battle_name())

			if var_139_3 then
				var_139_3:attach_buff("push_fight", var_139_1)
			end
		end

		if self._battle_scene:get_fight_type() == var_0_7.fight_type.abyss_2 then
			local var_139_4 = self._battle_scene:get_abyss_power()

			if var_139_4 and var_139_4 > 0 then
				local var_139_5 = var_0_3:getInstance(var_0_6:get_battle_name())

				if var_139_5 then
					var_139_5:attach_buff("abyss", var_139_4)
				end
			end
		end
	end
end

function var_0_0.extend_obj(arg_140_0)
	return
end

return var_0_0
