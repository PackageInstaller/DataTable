local var_0_0 = {}
local var_0_1 = gameenum.battle_type
local var_0_2 = gamecore.battle_util
local var_0_6 = gameconfig.ship_config
local var_0_7 = gameconfig.monster_config
local var_0_8 = tostring
local var_0_9 = string.sub
local var_0_10 = gameconfig.pve_mix_map_config
local var_0_11 = gameconfig.pve_eighth_map_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__on_torpedo_damage_aircraftcarrier(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
		if var_0_2:judge_stage(var_0_1.trigger_type.close_torpedo_attack, arg_2_5) and arg_2_4:get_ship_type() == var_0_1.ship_type_rule.aircraft_carrier.value then
			self:__update_trigger_count(arg_2_2, 1, arg_2_6, var_0_1.tactics_type.torpedo_learning.value)

			return self._tactics_conf[arg_2_1].effect.a, arg_2_3:get_side(), var_0_1.tactics_type.torpedo_learning.value
		end
	end

	function arg_1_0:__on_team_have_battle_cruiser(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
		self:__set_tactics_trigger_count_by_ship_type(arg_3_2, self._tactics_conf[arg_3_1].effect, arg_3_3, arg_3_4)
	end

	function arg_1_0:__on_artillery_battle_enemy_destroyer(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
		if var_0_2:judge_stage(var_0_1.trigger_type.normal_attack, arg_4_5) and arg_4_4:get_ship_type() == var_0_1.ship_type_rule.destroyer.value then
			self:__update_trigger_count(arg_4_2, 1, arg_4_6, var_0_1.tactics_type.block_fire.value)

			return self._tactics_conf[arg_4_1].effect.a, arg_4_3:get_side(), var_0_1.tactics_type.block_fire.value
		end
	end

	function arg_1_0:__on_torpedo_support_enemy_destroyer(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
		if var_0_2:judge_stage(var_0_1.trigger_type.close_torpedo_attack, arg_5_5) and arg_5_3:get_ship_type() == var_0_1.ship_type_rule.destroyer.value then
			if arg_5_3:get_side() == -1 and arg_5_4:get_side() == 1 then
				self:__update_trigger_count(arg_5_2, 1, arg_5_6, var_0_1.tactics_type.sea_sentry.value)
			end

			return -self._tactics_conf[arg_5_1].effect.a, arg_5_4:get_side(), var_0_1.tactics_type.sea_sentry.value
		end
	end

	function arg_1_0:__on_team_have_heavy_tour(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
		self:__set_tactics_trigger_count_by_ship_type(arg_6_2, self._tactics_conf[arg_6_1].effect, arg_6_3, arg_6_4)
	end

	function arg_1_0:__on_artillery_support_enemy_battle_ship(arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6)
		if var_0_2:judge_stage(var_0_1.trigger_type.normal_attack, arg_7_5) and arg_7_3:get_ship_type() == var_0_1.ship_type_rule.battle_ship.value then
			if arg_7_3:get_side() == -1 and arg_7_4:get_side() == 1 then
				self:__update_trigger_count(arg_7_2, 1, arg_7_6, var_0_1.tactics_type.wear.value)
			end

			return -self._tactics_conf[arg_7_1].effect.a, arg_7_4:get_side(), var_0_1.tactics_type.wear.value
		end
	end

	function arg_1_0:__on_artillery_immune_one_attack(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6)
		if var_0_2:judge_stage(var_0_1.trigger_type.normal_attack, arg_8_5) then
			if self._tactics_conf[arg_8_1].effect.a * 100 == var_0_1.tactics_const.rate_max then
				arg_8_2:set_immune_by_tactics(var_0_1.tactics_type.wide_angle_avoidance.value)

				return
			end

			if var_0_2:get_random_chance({
				self._tactics_conf[arg_8_1].effect.a * 100,
				100 - self._tactics_conf[arg_8_1].effect.a * 100
			}, self._battle_random) == self._tactics_conf[arg_8_1].effect.a * 100 then
				arg_8_2:set_immune_by_tactics(var_0_1.tactics_type.wide_angle_avoidance.value)
			else
				arg_8_2:set_immune_by_tactics(nil)
			end
		end
	end

	function arg_1_0:__on_close_torpedo_more_launch(arg_9_1, arg_9_2)
		arg_9_2:get_attribute().attach_torpedo = {
			num = self._tactics_conf[arg_9_1].effect.a,
			id = var_0_1.tactics_special_type.echelon_torpedo.value
		}
	end

	function arg_1_0:__on_artillery_enemy_battle_ship(arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6)
		if var_0_2:judge_stage(var_0_1.trigger_type.normal_attack, arg_10_5) and arg_10_4:get_ship_type() == var_0_1.ship_type_rule.battle_ship.value then
			if arg_10_3:get_side() == 1 and arg_10_4:get_side() == -1 then
				self:__update_trigger_count(arg_10_2, 1, arg_10_6, var_0_1.tactics_type.shoot.value)
			end

			return self._tactics_conf[arg_10_1].effect.a, arg_10_3:get_side(), var_0_1.tactics_type.shoot.value
		end
	end

	function arg_1_0:__on_team_have_battle_ship(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
		self:__set_tactics_trigger_count_by_ship_type(arg_11_2, self._tactics_conf[arg_11_1].effect, arg_11_3, arg_11_4)
	end

	function arg_1_0:__on_aircraft_enemy_destroyer(arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6)
		if var_0_2:judge_stage(var_0_1.trigger_type.air_attack, arg_12_5) and arg_12_4:get_ship_type() == var_0_1.ship_type_rule.destroyer.value then
			self:__update_trigger_count(arg_12_2, 1, arg_12_6, var_0_1.tactics_type.bounce_attack.value)

			return self._tactics_conf[arg_12_1].effect.a, arg_12_3:get_side(), var_0_1.tactics_type.bounce_attack.value
		end
	end

	function arg_1_0:__on_artillery_support_enemy_battle_cruiser(arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5, arg_13_6)
		if var_0_2:judge_stage(var_0_1.trigger_type.normal_attack, arg_13_5) and arg_13_3:get_ship_type() == var_0_1.ship_type_rule.battle_cruiser.value then
			if arg_13_3:get_side() == -1 and arg_13_4:get_side() == 1 then
				self:__update_trigger_count(arg_13_2, 1, arg_13_6, var_0_1.tactics_type.hardened_armor.value)
			end

			return -self._tactics_conf[arg_13_1].effect.a, arg_13_4:get_side(), var_0_1.tactics_type.hardened_armor.value
		end
	end

	function arg_1_0:__on_aircraft_support_enemy_aircraft_carrier(arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6)
		if var_0_2:judge_stage(var_0_1.trigger_type.air_attack, arg_14_5) and arg_14_3:get_ship_type() == var_0_1.ship_type_rule.aircraft_carrier.value then
			if arg_14_3:get_side() == -1 and arg_14_4:get_side() == 1 then
				self:__update_trigger_count(arg_14_2, 1, arg_14_6, var_0_1.tactics_type.aa_barrage.value)
			end

			return -self._tactics_conf[arg_14_1].effect.a, arg_14_4:get_side(), var_0_1.tactics_type.aa_barrage.value
		end
	end

	function arg_1_0:__on_artillery_beat_back(arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6, arg_15_7)
		if var_0_2:judge_stage(var_0_1.trigger_type.normal_attack, arg_15_5) then
			arg_15_2:get_attribute().fight_back_percentage = {
				num = self._tactics_conf[arg_15_1].effect.a * 100,
				id = var_0_1.tactics_type.interactive_shooting.value
			}

			if arg_15_7 then
				return
			end
		end
	end

	function arg_1_0.__on_supply_owner(arg_16_0, arg_16_1, arg_16_2)
		return
	end

	function arg_1_0:__on_aircraft_owner_enemy_battle_ship(arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5, arg_17_6)
		if var_0_2:judge_stage(var_0_1.trigger_type.air_attack, arg_17_5) and arg_17_4:get_ship_type() == var_0_1.ship_type_rule.battle_ship.value then
			self:__update_trigger_count(arg_17_2, 1, arg_17_6, var_0_1.tactics_type.aerial_bombs.value)

			return self._tactics_conf[arg_17_1].effect.a, arg_17_3:get_side(), var_0_1.tactics_type.aerial_bombs.value
		end
	end

	function arg_1_0:__on_team_have_aircraft_carrier(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
		self:__set_tactics_trigger_count_by_ship_type(arg_18_2, self._tactics_conf[arg_18_1].effect, arg_18_3, arg_18_4)
	end

	function arg_1_0:__on_artillery_owner_enemy_battle_cruiser(arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5, arg_19_6)
		if var_0_2:judge_stage(var_0_1.trigger_type.normal_attack, arg_19_5) and arg_19_4:get_ship_type() == var_0_1.ship_type_rule.battle_cruiser.value then
			self:__update_trigger_count(arg_19_2, 1, arg_19_6, var_0_1.tactics_type.armour_grenade.value)

			return self._tactics_conf[arg_19_1].effect.a, arg_19_3:get_side(), var_0_1.tactics_type.armour_grenade.value
		end
	end

	function arg_1_0:__on_night_support_enemy_heavy_cruiser(arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5, arg_20_6)
		if var_0_2:judge_stage(var_0_1.trigger_type.night_war, arg_20_5) and arg_20_3:get_ship_type() == var_0_1.ship_type_rule.heavy_cruiser.value then
			if arg_20_3:get_side() == -1 and arg_20_4:get_side() == 1 then
				self:__update_trigger_count(arg_20_2, 1, arg_20_6, var_0_1.tactics_type.searchlight_alert.value)
			end

			return -self._tactics_conf[arg_20_1].effect.a, arg_20_4:get_side(), var_0_1.tactics_type.searchlight_alert.value
		end
	end

	function arg_1_0:__on_aircraft_support_enemy_light_carrier(arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5, arg_21_6)
		if var_0_2:judge_stage(var_0_1.trigger_type.air_attack, arg_21_5) and arg_21_3:get_ship_type() == var_0_1.ship_type_rule.light_aircraft_carrier.value then
			if arg_21_3:get_side() == -1 and arg_21_4:get_side() == 1 then
				self:__update_trigger_count(arg_21_2, 1, arg_21_6, var_0_1.tactics_type.armored_deck.value)
			end

			return -self._tactics_conf[arg_21_1].effect.a, arg_21_4:get_side(), var_0_1.tactics_type.armored_deck.value
		end
	end

	function arg_1_0:__on_owner_to_battle(arg_22_1, arg_22_2, arg_22_3)
		self:__update_trigger_count(arg_22_2, 1, false, var_0_1.tactics_special_type.flare_correction.value)
		arg_22_2:set_add_attrs_when_night_attack({
			hit = self._tactics_conf[arg_22_1].effect.a
		})
	end

	function arg_1_0:__on_aircraft_owner_immune_one_attack(arg_23_1, arg_23_2, arg_23_3, arg_23_4, arg_23_5, arg_23_6)
		if var_0_2:judge_stage(var_0_1.trigger_type.air_attack, arg_23_5) then
			if self._tactics_conf[arg_23_1].effect.a * 100 == var_0_1.tactics_const.rate_max then
				arg_23_2:set_immune_by_tactics(var_0_1.tactics_type.air_warning.value)

				return
			end

			if var_0_2:get_random_chance({
				self._tactics_conf[arg_23_1].effect.a * 100,
				100 - self._tactics_conf[arg_23_1].effect.a * 100
			}, self._battle_random) == self._tactics_conf[arg_23_1].effect.a * 100 then
				arg_23_2:set_immune_by_tactics(var_0_1.tactics_type.air_warning.value)
			else
				arg_23_2:set_immune_by_tactics(nil)
			end
		end
	end

	function arg_1_0:__update_trigger_count(arg_24_1, arg_24_2, arg_24_3, arg_24_4)
		if arg_24_3 then
			return
		end

		if self:__ignore_tactics_by_map() then
			return
		end

		arg_24_1:set_tactics_trigger_count((arg_24_2 == nil or nil) and 0, arg_24_4)
	end

	function arg_1_0:__ignore_tactics_by_map()
		local var_25_0 = self._battle_scene:get_map_id()
		local var_25_1 = self._battle_scene:get_battle_point()
		local var_25_2 = false
		local var_25_4 = var_0_9(var_0_8(var_25_1), 1, 4)
		local var_25_5 = var_0_9(var_0_8(var_25_1), 1, 3)

		if self._battle_scene:get_fight_type() == var_0_1.fight_type.main then
			for iter_25_0, iter_25_1 in pairs(var_0_1.ignore_tactics_maps) do
				if var_25_5 == iter_25_1 then
					var_25_2 = true
				end
			end
		end

		if self._battle_scene:get_fight_type() == var_0_1.fight_type.seventh then
			local var_25_8 = var_0_10.find_object_by_id(var_25_0)

			if var_25_8 then
				return var_25_8.difficulty == 0
			end
		end

		if self._battle_scene:get_fight_type() == var_0_1.fight_type.eighth then
			local var_25_9 = var_0_11.find_object_by_id(var_25_0)

			if var_25_9 then
				return var_25_9.difficulty == 0
			end
		end

		if not var_25_1 then
			return true
		end

		if var_25_1 >= 953601 and var_25_1 <= 953919 then
			return true
		end

		if self._battle_scene:get_fight_type() == var_0_1.fight_type.score then
			local var_25_10 = var_0_9(var_0_8(var_25_1), 1, 5)

			for iter_25_2, iter_25_3 in pairs(var_0_1.ignore_tactics_score_maps) do
				if var_25_10 == iter_25_3 then
					var_25_2 = true
				end
			end
		end

		if self._battle_scene:get_fight_type() == var_0_1.fight_type.ninth then
			local var_25_11 = var_0_9(var_0_8(var_25_1), 1, 5)

			for iter_25_4, iter_25_5 in pairs(var_0_1.ignore_tactics_ninth_maps) do
				if var_25_11 == iter_25_5 then
					var_25_2 = true
				end
			end
		end

		for iter_25_6, iter_25_7 in pairs(var_0_1.ignore_tactics_battle_point) do
			if var_25_4 == iter_25_7 then
				var_25_2 = true
			end
		end

		if self._battle_scene:get_fight_type() == var_0_1.fight_type.campaign then
			return false
		end

		return var_25_2
	end

	function arg_1_0:__set_tactics_trigger_count_by_ship_type(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
		local var_26_0 = false

		if arg_26_2.e then
			for iter_26_0, iter_26_1 in pairs((self._battle_obj_mgr:get_ships_by_side(arg_26_1:get_side()))) do
				if iter_26_1:get_ship_type() == arg_26_2.b then
					var_26_0 = true

					if not arg_26_3 then
						self:__update_ship_attr(iter_26_1, arg_26_2.e, arg_26_2.a, arg_26_4)
					end
				end
			end
		else
			for iter_26_2, iter_26_3 in pairs((self._battle_obj_mgr:get_ships_by_side(arg_26_1:get_side()))) do
				if iter_26_3:get_ship_type() == arg_26_2.b then
					var_26_0 = true

					if not arg_26_3 then
						iter_26_3:set_normal_attack_ap(arg_26_2.a)
					end
				end
			end
		end

		if var_26_0 then
			self:__update_trigger_count(arg_26_1, 1, false, arg_26_4)
		end
	end

	function arg_1_0:__update_ship_attr(arg_27_1, arg_27_2, arg_27_3, arg_27_4)
		local var_27_0 = var_0_6.find_object_by_cid(arg_27_1:get_cid()) or var_0_7.find_object_by_id(arg_27_1:get_cid())
		local var_27_1 = arg_27_1:get_attribute()
		local var_27_2 = var_27_1[arg_27_2]:get_final_value() + arg_27_3

		self._battlefield:append_result(self._owner:get_cid(), arg_27_4 .. "战术触发", (string.format("目标:%s 属性类型:%s 触发前:%d 触发后:%d", var_27_0.title, arg_27_2, var_27_1[arg_27_2]:get_final_value(), var_27_2)))
		var_27_1[arg_27_2]:modify_to_value(var_27_2)
	end
end

function var_0_0.extend_obj(arg_28_0)
	return
end

return var_0_0
