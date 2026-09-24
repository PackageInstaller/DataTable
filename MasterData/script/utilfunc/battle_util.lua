local var_0_0 = {}
local var_0_1 = gameenum.battle_type
local var_0_2 = table.insert
local var_0_6 = gamecore.user
local var_0_7 = gameconfig.ship_config
local var_0_10 = math.floor

function var_0_0.get_fleet_course(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7)
	local var_1_0 = 1
	local var_1_1 = 1

	if not arg_1_1 then
		var_1_0 = 0
		var_1_1 = -1
	end

	local var_1_2 = math.min(arg_1_2 - arg_1_4, arg_1_3 - arg_1_5) + 5 * var_1_1 + 15
	local var_1_3 = arg_1_3 - arg_1_5 + 5 * var_1_0 + 30

	var_1_3 = arg_1_3 - arg_1_5 + 5 * var_1_0 + 30 < 5 and 5 or var_1_3

	local var_1_4 = arg_1_4 - arg_1_2 - 5 * var_1_0 + 30
	local var_1_5 = arg_1_5 - arg_1_3 - 5 * var_1_1 + 10
	local var_1_6
	local var_1_7

	if arg_1_7 then
		var_1_3 = var_1_3 + var_1_4 + var_1_5
		var_1_4 = 0
		var_1_5 = 0
		var_1_6 = arg_1_6:randRange(0, var_1_2 + var_1_3 + var_1_4 + var_1_5)
		var_1_7 = {}
	end

	var_1_7.T优势权重 = string.format("T优势权重%f=math.min(玩家旗舰航速%f-敌方旗舰航速%f, 玩家平均航速%f-敌方平均航速%f + 5 * mul%d) + 15", var_1_2, arg_1_2, arg_1_4, arg_1_3, arg_1_5, var_1_1)
	var_1_7.T劣势权重 = string.format("T劣权重%f=敌方平均航速%f-玩家平均航速%f-5*mul%d+10", var_1_5, arg_1_5, arg_1_3, var_1_1)
	var_1_7.同航权重 = string.format("同航权重%f=玩家平均航速%f-敌方平均航速%f+5*add%d+30", var_1_3, arg_1_3, arg_1_5, var_1_0)
	var_1_7.返航权重 = string.format("返航权重%f=敌方旗舰航速%f-玩家旗舰航速%f-5*add%d+30", var_1_4, arg_1_4, arg_1_2, var_1_0)
	var_1_7.随机值 = var_1_6
	var_1_7.总权重分布 = string.format("T优势权重<=%f + %f<同航权重<=%f + %f<返航权重<=%f + <%fT劣势权重<=%f", var_1_2, var_1_2, var_1_2 + var_1_3, var_1_2 + var_1_3, var_1_2 + var_1_3 + var_1_4, var_1_2 + var_1_3 + var_1_4, var_1_2 + var_1_3 + var_1_4 + var_1_5)

	if var_1_6 <= var_1_2 then
		return var_0_1.course_type_rule.t_advantage, var_1_7
	end

	if var_1_2 < var_1_6 and var_1_6 <= var_1_2 + var_1_3 then
		return var_0_1.course_type_rule.same, var_1_7
	end

	if var_1_6 > var_1_2 + var_1_3 and var_1_6 <= var_1_2 + var_1_3 + var_1_4 then
		return var_0_1.course_type_rule.reversal, var_1_7
	end

	return var_0_1.course_type_rule.t_disadvantage, var_1_7
end

function var_0_0.dict_length(arg_2_0, arg_2_1)
	local var_2_0 = 0

	if not arg_2_1 then
		return var_2_0
	end

	for iter_2_0, iter_2_1 in pairs(arg_2_1) do
		var_2_0 = var_2_0 + 1
	end

	return var_2_0
end

function var_0_0.get_attribute_by_index(arg_3_0, arg_3_1, arg_3_2)
	local var_3_1 = arg_3_1:get_attribute()

	return (var_3_1[var_0_1.skil_attribute_type[arg_3_2]] or nil) and var_3_1[var_0_1.skil_attribute_type[arg_3_2]]:get_final_value()
end

function var_0_0.set_battle_node_data(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_2 == gameenum.battle_type.fight_type.maneuver or arg_4_2 == gameenum.battle_type.fight_type.campaign or arg_4_2 == gameenum.battle_type.fight_type.climb_tower or arg_4_2 == gameenum.battle_type.fight_type.ocean_attack then
		return 0, 0
	end

	local var_4_0 = arg_4_1

	arg_4_1 = tostring(arg_4_1)

	local var_4_1 = string.sub(arg_4_1, 1, #arg_4_1 - 2)

	if arg_4_2 == gameenum.battle_type.fight_type.climb_tower then
		var_4_1 = arg_4_1
	end

	local var_4_2 = {}
	local var_4_3, var_4_4 = gameconfig.map_node_config:get_sequence()

	if arg_4_2 == gameenum.battle_type.fight_type.plot_main or arg_4_2 == gameenum.battle_type.fight_type.sixth then
		local var_4_5

		var_4_3, var_4_5 = gameconfig.sixth_map_node_config:get_sequence()
	end

	if arg_4_2 == gameenum.battle_type.fight_type.push then
		local var_4_6

		var_4_3, var_4_6 = gameconfig.pve_active_map_node_config:get_sequence()
	end

	if arg_4_2 == gameenum.battle_type.fight_type.abyss or arg_4_2 == gameenum.battle_type.fight_type.abyss_2 then
		local var_4_7

		var_4_3, var_4_7 = gameconfig.abyss_map_node_config:get_sequence()
	end

	if arg_4_2 == gameenum.battle_type.fight_type.strike then
		local var_4_8

		var_4_3, var_4_8 = gameconfig.strike_map_node_config:get_sequence()

		for iter_4_0, iter_4_1 in pairs(var_4_3) do
			if iter_4_1.strike_id == tonumber(var_4_1) then
				var_4_2[#var_4_2 + 1] = {
					id = iter_4_1.id
				}
			end
		end

		return var_4_2[1].id, var_4_2[#var_4_2].id
	end

	if arg_4_2 == gameenum.battle_type.fight_type.war_concerto or arg_4_2 == gameenum.battle_type.fight_type.war_concerto_play then
		local var_4_9

		var_4_3, var_4_9 = gameconfig.fifth_map_node_config:get_sequence()
	end

	if arg_4_2 == gameenum.battle_type.fight_type.score then
		local var_4_10

		var_4_3, var_4_10 = gameconfig.score_map_node_config:get_sequence()

		for iter_4_2, iter_4_3 in pairs(var_4_3) do
			if iter_4_3.id == tonumber(var_4_0) then
				var_4_2[#var_4_2 + 1] = {
					id = iter_4_3.start_node_id
				}
			end
		end

		local var_4_11 = var_4_2[1].id

		for iter_4_4, iter_4_5 in pairs(var_4_2) do
			if arg_4_3 == iter_4_5.id then
				var_4_11 = iter_4_5.id
			end
		end

		return var_4_11
	end

	if arg_4_2 == gameenum.battle_type.fight_type.ninth then
		var_4_3 = gameconfig.pve_ninth_level_node_config:get_sequence()

		for iter_4_6, iter_4_7 in pairs(var_4_3) do
			if iter_4_7.id == tonumber(var_4_0) then
				var_4_2[#var_4_2 + 1] = {
					id = iter_4_7.start_node_id
				}
			end
		end

		local var_4_12 = var_4_2[1].id

		for iter_4_8, iter_4_9 in pairs(var_4_2) do
			if arg_4_3 == iter_4_9.id then
				var_4_12 = iter_4_9.id
			end
		end

		return var_4_12
	end

	for iter_4_10, iter_4_11 in pairs(var_4_3) do
		if iter_4_11.pve_level_id == tonumber(var_4_1) then
			var_4_2[#var_4_2 + 1] = {
				id = iter_4_11.id
			}
		end
	end

	if arg_4_2 == gameenum.battle_type.fight_type.seventh then
		if not tonumber(var_4_1) then
			return 0, 0
		end

		local var_4_13, var_4_14 = gameconfig.pve_mix_level_node_config:get_sequence()

		for iter_4_12, iter_4_13 in pairs(var_4_13) do
			if iter_4_13.pve_level_id == tonumber(var_4_1) then
				var_4_2[#var_4_2 + 1] = {
					id = iter_4_13.id
				}
			end
		end
	end

	if arg_4_2 == gameenum.battle_type.fight_type.eighth then
		if not tonumber(var_4_1) then
			return 0, 0
		end

		local var_4_15, var_4_16 = gameconfig.pve_eighth_level_node_config:get_sequence()

		for iter_4_14, iter_4_15 in pairs(var_4_15) do
			if iter_4_15.pve_level_id == tonumber(var_4_1) then
				var_4_2[#var_4_2 + 1] = {
					id = iter_4_15.id
				}
			end
		end
	end

	if arg_4_2 == gameenum.battle_type.fight_type.mist then
		if not tonumber(var_4_1) then
			return 0, 0
		end

		local var_4_17, var_4_18 = gameconfig.pve_mist_level_node_config:get_sequence()

		for iter_4_16, iter_4_17 in pairs(var_4_17) do
			if iter_4_17.pve_level_id == tonumber(var_4_1) then
				var_4_2[#var_4_2 + 1] = {
					id = iter_4_17.id
				}
			end
		end
	end

	return var_4_2[1].id, var_4_2[#var_4_2].id
end

function var_0_0.multiple_attr_value(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = arg_5_1:get_attribute()
	local var_5_1 = arg_5_4:get_multiple_attr_value() * arg_5_3

	if arg_5_2 == "torpedo" then
		var_5_0.pre_torpedo:modify_to_value(var_5_0.pre_torpedo:get_final_value() + var_5_1)
	end

	if var_5_0[arg_5_2] then
		var_5_0[arg_5_2]:modify_to_value(var_5_0[arg_5_2]:get_final_value() + var_5_1)
	end

	return var_5_1
end

function var_0_0.modify_attr_value(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = arg_6_1:get_attribute()

	if not var_6_0[arg_6_2] then
		return
	end

	local var_6_1 = var_6_0[arg_6_2]:get_final_value() + arg_6_3

	var_6_0[arg_6_2]:modify_to_value((arg_6_4 == true or nil) and arg_6_3)
end

function var_0_0.get_random_chance(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = 0
	local var_7_1 = {}
	local var_7_2 = 0

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		var_7_2 = var_7_2 + iter_7_1

		var_0_2(var_7_1, var_7_2)
	end

	local var_7_3 = arg_7_2:randRange(1, var_7_2)

	for iter_7_2, iter_7_3 in ipairs(var_7_1) do
		if var_7_3 <= iter_7_3 then
			var_7_0 = arg_7_1[iter_7_2]

			break
		end
	end

	return var_7_0, var_7_3
end

function var_0_0.judge_stage(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == arg_8_2 then
		return true
	end

	if arg_8_2 == var_0_1.trigger_type.expedition or arg_8_2 == var_0_1.trigger_type.exercise then
		return true
	end

	if arg_8_1 == var_0_1.trigger_type.all_step then
		return true
	end

	if arg_8_1 == var_0_1.trigger_type.normal_attack then
		return arg_8_2 == var_0_1.trigger_type.first_normal_attack or arg_8_2 == var_0_1.trigger_type.second_normal_attack
	end

	if arg_8_1 == var_0_1.trigger_type.day_war then
		return arg_8_2 < var_0_1.trigger_type.day_war and arg_8_2 ~= var_0_1.trigger_type.night_war
	end

	return false
end

function var_0_0.update_target_attr(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = arg_9_1:get_attribute()

	if not var_9_0[arg_9_2] then
		return
	end

	if arg_9_2 == "crit_repair" then
		arg_9_4 = false
	end

	local var_9_2 = math.floor(arg_9_4 and var_9_0[arg_9_2]:get_final_value() * (1 + arg_9_3) or var_9_0[arg_9_2]:get_final_value() + arg_9_3)

	if arg_9_2 == "atk" then
		var_9_0.ship_atk:modify_to_value(var_9_0.ship_atk:get_final_value() + arg_9_3)
	end

	if arg_9_2 == "air_def" then
		var_9_0.ship_air_def:modify_to_value(var_9_0.ship_air_def:get_final_value() + arg_9_3)
	end

	var_9_0[arg_9_2]:modify_to_value(var_9_2)
end

function var_0_0.get_exist_state(arg_10_0, arg_10_1, arg_10_2)
	for iter_10_0, iter_10_1 in pairs(arg_10_1) do
		if iter_10_1 == arg_10_2 then
			return true
		end
	end

	return false
end

function var_0_0.get_first_hit_targets(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = {}
	local var_11_1 = arg_11_1:get_attribute().first_hit_by_type.ship_type
	local var_11_2 = arg_11_1:get_attribute().first_hit_by_type.num

	for iter_11_0, iter_11_1 in pairs(arg_11_2) do
		if var_11_1 == "shipTypes" then
			for iter_11_2, iter_11_3 in pairs(var_11_2) do
				if iter_11_1:get_ship_type() == iter_11_3 then
					var_0_2(var_11_0, iter_11_1)
				end
			end
		elseif var_11_1 == "shipTons" then
			for iter_11_4, iter_11_5 in pairs(var_11_2) do
				if iter_11_1:get_ship_ton() == iter_11_5 then
					var_0_2(var_11_0, iter_11_1)
				end
			end
		elseif var_11_1 == "guardTypes" then
			for iter_11_6, iter_11_7 in pairs(var_11_2) do
				if iter_11_1:get_ship_guard_type() == iter_11_7 then
					var_0_2(var_11_0, iter_11_1)
				end
			end
		end
	end

	return var_11_0
end

function var_0_0.first_hit_by_type_by_num_targets(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = {}
	local var_12_1 = arg_12_1:get_attribute().first_hit_by_type_by_num.ship_type

	for iter_12_0, iter_12_1 in pairs(arg_12_1:get_attribute().first_hit_by_type_by_num.num) do
		for iter_12_2, iter_12_3 in pairs(arg_12_2) do
			if var_12_1 == "shipTypes" then
				if iter_12_3:get_ship_type() == iter_12_1 then
					var_0_2(var_12_0, iter_12_3)
				end
			elseif var_12_1 == "shipTons" then
				if iter_12_3:get_ship_ton() == iter_12_1 then
					var_0_2(var_12_0, iter_12_3)
				end
			elseif var_12_1 == "guardTypes" and iter_12_3:get_ship_guard_type() == iter_12_1 then
				var_0_2(var_12_0, iter_12_3)
			end
		end
	end

	return var_12_0
end

function var_0_0.first_hit_by_flag_targets(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs(arg_13_2) do
		if iter_13_1:is_flag() then
			var_0_2(var_13_0, iter_13_1)
		end
	end

	return var_13_0
end

function var_0_0.first_hit_by_not_flag_targets(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in pairs(arg_14_2) do
		if not iter_14_1:is_flag() then
			var_0_2(var_14_0, iter_14_1)
		end
	end

	return var_14_0
end

function var_0_0.attack_scoure_index_target(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = {}
	local var_15_1 = arg_15_1:get_attribute().attack_scoure_index_target.attack_index

	for iter_15_0, iter_15_1 in pairs(arg_15_2) do
		if iter_15_1:get_index() == var_15_1 then
			var_0_2(var_15_0, iter_15_1)
		end
	end

	return var_15_0
end

function var_0_0.first_hit_by_max_attr_targets(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = {}
	local var_16_1 = var_0_1.skil_attribute_type[arg_16_1:get_attribute().first_hit_by_max_attr.attr]

	for iter_16_0, iter_16_1 in pairs(arg_16_2) do
		if 0 < iter_16_1:get_attribute()[var_16_1]:get_final_value() then
			var_16_0 = {}

			var_0_2(var_16_0, iter_16_1)
		end
	end

	return var_16_0
end

function var_0_0.first_hit_by_min_attr_targets(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = {}
	local var_17_1 = var_0_1.skil_attribute_type[arg_17_1:get_attribute().first_hit_by_min_attr.attr]
	local var_17_2

	for iter_17_0, iter_17_1 in pairs(arg_17_2) do
		local var_17_3 = iter_17_1:get_attribute()[var_17_1]:get_final_value()

		if var_17_2 == nil or var_17_3 < var_17_2 then
			var_17_2 = var_17_3
			var_17_0 = {}

			table.insert(var_17_0, iter_17_1)
		elseif var_17_3 == var_17_2 then
			-- block empty
		end
	end

	return var_17_0
end

function var_0_0.judge_ship(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_1:get_ship_type()
	local var_18_1 = arg_18_1:get_ship_ton()
	local var_18_2 = arg_18_1:get_country()
	local var_18_3 = arg_18_1:get_ship_guard_type()
	local var_18_4 = false

	for iter_18_0, iter_18_1 in pairs(arg_18_2) do
		if iter_18_0 == "shipType" then
			for iter_18_2, iter_18_3 in pairs(iter_18_1) do
				if var_18_0 == iter_18_3 then
					var_18_4 = true

					break
				end
			end
		elseif iter_18_0 == "shipTon" then
			for iter_18_4, iter_18_5 in pairs(iter_18_1) do
				if var_18_1 == iter_18_5 then
					var_18_4 = true

					break
				end
			end
		elseif iter_18_0 == "guardType" then
			for iter_18_6, iter_18_7 in pairs(iter_18_1) do
				if var_18_3 == iter_18_7 then
					var_18_4 = true

					break
				end
			end
		elseif iter_18_0 == "country" then
			for iter_18_8, iter_18_9 in pairs(iter_18_1) do
				if var_18_2 == iter_18_9 then
					var_18_4 = true

					break
				end
			end
		end
	end

	return var_18_4
end

function var_0_0.judge_enemy_ship(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_1:get_ship_type()
	local var_19_1 = false
	local var_19_2 = false

	for iter_19_0, iter_19_1 in pairs(arg_19_2) do
		if iter_19_0 == "shipType1s" then
			var_19_2 = true

			for iter_19_2, iter_19_3 in pairs(iter_19_1) do
				if var_19_0 == iter_19_3 then
					var_19_1 = true

					break
				end
			end
		end
	end

	return (not var_19_2 or nil) and true
end

function var_0_0.__get_meet_shipCountry_data(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = {}

	if arg_20_2 then
		for iter_20_0, iter_20_1 in pairs(arg_20_1) do
			if var_0_7.find_object_by_cid(var_0_6:find_character_by_id(iter_20_1).cid).country == arg_20_2 then
				var_0_2(var_20_0, iter_20_1)

				break
			end
		end
	end

	return var_20_0
end

function var_0_0.chance(arg_21_0, arg_21_1)
	return arg_21_0 >= arg_21_1:randRange(0, 100) / 100
end

function var_0_0.get_avg_speed(arg_22_0, arg_22_1)
	local var_22_0 = 0
	local var_22_1 = 0
	local var_22_2 = 0
	local var_22_3 = 0
	local var_22_4 = 0
	local var_22_5 = 0
	local var_22_6 = 1
	local var_22_7 = 0
	local var_22_8 = 0
	local var_22_9 = 0

	for iter_22_0, iter_22_1 in pairs(arg_22_1) do
		local var_22_10 = iter_22_1:get_attribute().speed
		local var_22_11 = var_22_10:get_final_value() < 0 and 0 or var_22_10:get_final_value()
		local var_22_12, var_22_13 = var_0_1:get_avg_speed_class((iter_22_1:get_ship_type()))

		if var_22_12 == "class1" then
			var_22_0 = var_22_0 + var_22_13 * var_22_11
			var_22_1 = var_22_1 + var_22_13
			var_22_6 = 0
		end

		if var_22_12 == "class2" then
			var_22_2 = var_22_2 + var_22_13 * var_22_11
			var_22_3 = var_22_3 + var_22_13
			var_22_6 = 0
		end

		if var_22_12 == "class3" then
			var_22_4 = var_22_4 + var_22_13 * var_22_11
			var_22_5 = var_22_5 + var_22_13
		end
	end

	if var_22_6 == 1 then
		var_22_7 = math.floor(var_22_4 / var_22_5)

		return var_22_7
	end

	if var_22_0 ~= 0 then
		var_22_8 = var_22_0 / var_22_1
		var_22_7 = var_22_0 / var_22_1
	end

	if var_22_2 ~= 0 then
		var_22_9 = var_22_2 / var_22_3
		var_22_7 = var_22_2 / var_22_3
	end

	if var_22_8 ~= 0 and var_22_9 ~= 0 then
		var_22_7 = math.floor(math.min(var_22_8, var_22_9))
	end

	return var_22_7
end

function var_0_0.attr_impact_by_speed(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	if not arg_23_1 then
		return arg_23_2
	end

	arg_23_3 = arg_23_3 or 0
	arg_23_4 = arg_23_4 or 0

	return math.floor(arg_23_2 * (1 + ((arg_23_1 < 12.2 or nil) and arg_23_3 + (12.2 - arg_23_1) * (arg_23_4 - arg_23_3) / 12.2)))
end

function var_0_0.have_data(arg_24_0, arg_24_1, arg_24_2)
	for iter_24_0, iter_24_1 in pairs(arg_24_1) do
		if iter_24_1 == arg_24_2 then
			return true
		end
	end

	return false
end

function var_0_0.calculate_some_attr_by_level(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	arg_25_1 = arg_25_1 or 0
	arg_25_2 = arg_25_2 or 0
	arg_25_3 = arg_25_3 or 0
	arg_25_4 = arg_25_4 or 1

	return var_0_10(arg_25_1 + (arg_25_2 - arg_25_1) * arg_25_4 / 100)
end

return var_0_0
