local var_0_0 = {}
local core_data = require("data.core_data")
local var_0_2 = {}
local servant_data = require("data.servant_data")
local model_data = require("data.model_data")
local role_break_gold_data = require("data.role_break_gold_data")
local role_break_material_data = require("data.role_break_material_data")
local role_resonance_consume_data = require("data.role_resonance_consume_data")
local role_resonance_element_consume_data = require("data.role_resonance_element_consume_data")
local item_data = require("data.item_data")
local network = require("network.network")
local item_manager = require("controller.item_manager")
local playermodel = require("model.playermodel")
local souls_manager = require("controller.souls_manager")
local servant_level_data = require("data.servant_level_data")
local var_0_15 = {}
local var_0_16 = false

function var_0_0:init()
	var_0_2 = require("data.core_strengthen_1")
	var_0_15 = {}

	for iter_1_0 = 0, TOTAL_RANK - 1 do
		var_0_15[iter_1_0] = {}
	end

	for iter_1_1, iter_1_2 in pairs(var_0_2) do
		var_0_15[iter_1_2.equip_rank][iter_1_2.intensify_level] = iter_1_2
	end

	self:getCoreMaxClass()
end

function var_0_0.getFutureExp(arg_2_0, arg_2_1, arg_2_2)
	if not require("model.playermodel").cores[arg_2_1] then
		return 0
	end

	return (servant_level_data[arg_2_2] or nil) and (servant_level_data[arg_2_2].consume_intensitem_number or 0)
end

function var_0_0:getFutureLevel(arg_3_1, arg_3_2)
	if not require("model.playermodel").cores[arg_3_1] then
		return 0
	end

	local var_3_2 = self:getCoreLv(arg_3_1)
	local var_3_3 = 0
	local var_3_4 = var_3_2 + 1

	arg_3_2 = arg_3_2 + self:getCoreExp(arg_3_1)

	while servant_level_data[var_3_4] and arg_3_2 - servant_level_data[var_3_4].consume_intensitem_number >= 0 do
		arg_3_2 = arg_3_2 - servant_level_data[var_3_4].consume_intensitem_number
		var_3_3 = var_3_3 + 1
		var_3_4 = var_3_4 + 1
	end

	local var_3_5 = servant_level_data[var_3_4] and servant_level_data[var_3_4].consume_intensitem_number or 0
	local var_3_6
	local var_3_7 = self:getCoreMaxLevelByGrade()
	local var_3_8 = self:getServantCoreRank(arg_3_1)
	local var_3_9 = self:get_core_lv_lock(arg_3_1)

	if var_3_7 < var_3_2 + var_3_3 then
		var_3_6 = var_3_7
		var_3_5 = -1
	elseif var_3_9 <= var_3_2 + var_3_3 then
		var_3_6 = var_3_9
		var_3_5 = -1
	elseif var_3_2 + var_3_3 >= self:getCoreMaxTotalLv() and var_3_3 ~= 0 then
		var_3_6 = self:getCoreMaxTotalLv()
		var_3_5 = -3
	else
		var_3_6 = var_3_2 + var_3_3
	end

	return var_3_6, arg_3_2, var_3_5
end

function var_0_0.getCoreLv(arg_4_0, arg_4_1)
	local playermodel = require("model.playermodel")

	if not playermodel.cores[arg_4_1] then
		return 0
	end

	if playermodel.cores[arg_4_1].level then
		return playermodel.cores[arg_4_1].level
	end

	return core_data[playermodel.cores[arg_4_1].coreid].original_intensify_level + playermodel.cores[arg_4_1].extra
end

function var_0_0.getCoreExp(arg_5_0, arg_5_1)
	return require("model.playermodel").cores[arg_5_1].exp or 0
end

function var_0_0:getCoreMaxExp(arg_6_1)
	local var_6_0 = core_data[require("model.playermodel").cores[arg_6_1].coreid].rank
	local var_6_1 = self:getCoreLv(arg_6_1)

	return self:isCoreMax(arg_6_1) and -1 or var_6_1 < self:getCoreMaxTotalLv() and servant_level_data[var_6_1 + 1].consume_intensitem_number or -1
end

function var_0_0.getStrengthenValue(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_1 = math.round(0.1 * ((servant_level_data[arg_7_3] or nil) and (servant_level_data[arg_7_3].strengthen_attribute or 0)))
	local var_7_3 = math.max(playermodel.soulContract[arg_7_1], 0)
	local sciencepoint_add_data = require("data.sciencepoint_add_data")

	return core_data[arg_7_2].attr + var_7_1 + (sciencepoint_add_data[arg_7_1] and (sciencepoint_add_data[arg_7_1]["n" .. var_7_3] or sciencepoint_add_data[arg_7_1].n5) or sciencepoint_add_data[servant_data[arg_7_1].roll_rarity]["n" .. var_7_3] or sciencepoint_add_data[servant_data[arg_7_1].roll_rarity].n5)
end

function var_0_0.getNextOcPointAdd(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_1 = math.round(0.1 * ((servant_level_data[arg_8_3] or nil) and (servant_level_data[arg_8_3].strengthen_attribute or 0)))
	local var_8_3 = math.max(playermodel.soulContract[arg_8_1], 0)
	local sciencepoint_add_data = require("data.sciencepoint_add_data")

	return core_data[arg_8_2].attr + var_8_1 + (sciencepoint_add_data[arg_8_1] and (sciencepoint_add_data[arg_8_1]["n" .. var_8_3 + 1] or sciencepoint_add_data[arg_8_1].n5) or sciencepoint_add_data[servant_data[arg_8_1].roll_rarity]["n" .. var_8_3 + 1] or sciencepoint_add_data[servant_data[arg_8_1].roll_rarity].n5)
end

function var_0_0:getServantCoreOfhundred(arg_9_1)
	return (self:getCoreLv(arg_9_1))
end

function var_0_0.getServantCoreRank(arg_10_0, arg_10_1)
	return core_data[require("model.playermodel").cores[arg_10_1].coreid].rank
end

function var_0_0:getServantCoreValue(arg_11_1)
	return self:getStrengthenValue(arg_11_1, require("model.playermodel").cores[arg_11_1].coreid, self:getCoreLv(arg_11_1))
end

function var_0_0:StrengthenJudge(arg_12_1, arg_12_2)
	local playermodel = require("model.playermodel")

	arg_12_2 = arg_12_2 or 1

	if not playermodel.cores[arg_12_1] then
		return 0
	end

	if not playermodel.haveServant[arg_12_1] then
		return 0
	end

	local var_12_2 = core_data[playermodel.cores[arg_12_1].coreid].rank
	local var_12_3 = self:getCoreLv(arg_12_1)
	local var_12_4 = self:getCoreMaxTotalLv()
	local var_12_5 = playermodel.grade >= 100 and var_12_3 == playermodel.grade and playermodel.grade % 100 == 0

	if var_12_3 == 300 then
		return 3
	elseif var_12_3 >= souls_manager:get_can_up_level() then
		return 7, souls_manager:get_next_up_level_limit() - souls_manager:get_total_contract_attr()
	elseif var_12_5 then
		return 6
	elseif self:check_core_lv_lock(arg_12_1) then
		if var_12_2 < SERVANT_CORE_BREAK_MAX then
			return 2
		else
			return 5
		end
	elseif var_12_3 < var_12_4 then
		local var_12_6 = 0

		while 1 <= arg_12_2 and servant_level_data[var_12_3 + 1] do
			var_12_6 = var_12_6 + servant_level_data[var_12_3 + 1].consume_intensitem_number
		end

		local var_12_8 = var_12_6 - self:getCoreExp(arg_12_1)

		if playermodel.strengthpoint == 0 then
			return 4
		end

		return 1, var_12_8, var_12_4
	elseif self:isCoreMax(arg_12_1) then
		return 3
	elseif var_12_2 < SERVANT_CORE_BREAK_MAX then
		return 2
	else
		return 5
	end
end

function var_0_0:check_core_lv_lock(arg_13_1)
	return core_data[require("model.playermodel").cores[arg_13_1].coreid].unlocklevel <= self:getCoreLv(arg_13_1)
end

function var_0_0.get_core_lv_lock(arg_14_0, arg_14_1)
	return core_data[require("model.playermodel").cores[arg_14_1].coreid].unlocklevel
end

function var_0_0:isCoreMax(arg_15_1)
	if core_data[require("model.playermodel").cores[arg_15_1].coreid].rank >= #CLASS_TYPE_ID and self:getCoreMaxTotalLv() <= self:getCoreLv(arg_15_1) then
		return true
	end

	return false
end

local var_0_17 = L_STRENGTHEN_ERR_MSG

function var_0_0:check_strengthen_point(arg_16_1, arg_16_2)
	if arg_16_2 <= 0 then
		return 0
	end

	local var_16_0 = core_data[require("model.playermodel").cores[arg_16_1].coreid].rank
	local var_16_1 = self:getCoreLv(arg_16_1)
	local var_16_2 = self:getCoreMaxLevelByGrade()

	if var_16_2 <= var_16_1 then
		return 0
	end

	if var_16_2 < var_16_1 + arg_16_2 then
		arg_16_2 = var_16_2 - var_16_1
	end

	return arg_16_2
end

function var_0_0:check_strengthen_point_by_grade(arg_17_1, arg_17_2)
	if arg_17_2 <= 0 then
		return 0
	end

	local playermodel = require("model.playermodel")
	local var_17_1 = self:getCoreLv(arg_17_1)

	if var_17_1 >= playermodel.grade then
		return 0
	end

	if self:getCoreMaxExp(arg_17_1) > playermodel.strengthpoint + self:getCoreExp(arg_17_1) then
		return 0
	end

	return math.min(arg_17_2, playermodel.grade - var_17_1)
end

function var_0_0:strengthenCoreToServer(arg_18_1, arg_18_2, arg_18_3)
	local playermodel = require("model.playermodel")

	if var_0_16 then
		if arg_18_3 then
			arg_18_3(1)
		end

		return
	end

	if not playermodel.cores[arg_18_1] then
		if arg_18_3 then
			arg_18_3(0, var_0_17[0])
		end

		return
	end

	if arg_18_2 <= 0 or self:getCoreLv(arg_18_1) == playermodel.grade then
		if arg_18_3 then
			arg_18_3(4, var_0_17[4])
		end

		return
	end

	if self:getCoreLv(arg_18_1) + arg_18_2 > 300 then
		if arg_18_3 then
			arg_18_3(7, var_0_17[7])
		end

		return
	end

	if self:getCoreLv(arg_18_1) + arg_18_2 > souls_manager:get_can_up_level() then
		if arg_18_3 then
			arg_18_3(3, var_0_17[3])
		end

		return
	end

	arg_18_2 = tonumber(arg_18_2)

	network:rpc("strengthen_core", {
		servantid = arg_18_1,
		point = arg_18_2
	}, function(arg_19_0)
		if arg_19_0.result == 1 then
			playermodel.strengthpoint = tonumber(arg_19_0.strengthpoint)

			global_update_strengthpoint()

			if arg_19_0.core then
				playermodel.cores[arg_18_1] = arg_19_0.core
			end

			if playermodel:isSoulInFight(arg_18_1) then
				FightManager.registerPlayerUpdate()
				cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("syncFightPower"))
			end

			local role_false_level_manager = require("controller.role_false_level_manager")

			role_false_level_manager:updateSoulsAfkLevel()

			if role_false_level_manager:isFalseLevelRoleInHangup() then
				FightManager.registerPlayerUpdate()
				cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("syncFightPower"))
			end

			local alert_manager = require("controller.alert_manager")

			alert_manager:check_servant_breakout(true)
			alert_manager:check_horcrux_strenghth(false)

			if arg_18_3 then
				arg_18_3(1)
			end

			sendNotification("StrengthenCoreSuccess")
		else
			playermodel.strengthpoint = tonumber(arg_19_0.strengthpoint)

			if arg_18_3 then
				arg_18_3(arg_19_0.result, var_0_17[arg_19_0.result])
			end
		end
	end)
end

function var_0_0:check_upgrade_conditions(arg_20_1)
	local playermodel = require("model.playermodel")

	if not playermodel.cores[arg_20_1] then
		return false
	end

	local var_20_1 = core_data[playermodel.cores[arg_20_1].coreid].rank

	if core_data[playermodel.cores[arg_20_1].coreid].rank >= 14 then
		return false
	end

	if not self:getBreakOutCostGold(arg_20_1, var_20_1 + 1) then
		return false
	end

	if playermodel.gold < self:getBreakOutCostGold(arg_20_1, var_20_1 + 1) then
		return false
	end

	for iter_20_0, iter_20_1 in pairs((self:getBreakOutCostMaterial(arg_20_1, var_20_1 + 1))) do
		if not item_manager:isHaveEnoughItem(iter_20_1.itemid, iter_20_1.num) then
			return false
		end
	end

	return (core_data[playermodel.cores[arg_20_1].coreid].unlocklevel or 5) <= playermodel.grade
end

function var_0_0:upgradeCoreToServer(arg_21_1, arg_21_2)
	local playermodel = require("model.playermodel")

	if var_0_16 then
		if arg_21_2 then
			arg_21_2(1)
		end

		return
	end

	if not playermodel.cores[arg_21_1] then
		if arg_21_2 then
			arg_21_2(0, L_STRENGTHEN_ERR_MSG[0])
		end

		return
	end

	local var_21_1 = core_data[playermodel.cores[arg_21_1].coreid].rank
	local var_21_2 = self:getBreakOutCostGold(arg_21_1, core_data[playermodel.cores[arg_21_1].coreid].rank + 1)

	if not var_21_2 then
		if arg_21_2 then
			arg_21_2(4, L_CORE2SERVE_MSG[4])
		end

		return
	end

	if var_21_2 > playermodel.gold then
		if arg_21_2 then
			arg_21_2(5, L_CORE2SERVE_MSG[5])
		end

		return
	end

	local var_21_3 = {}

	for iter_21_0, iter_21_1 in pairs((self:getBreakOutCostMaterial(arg_21_1, var_21_1 + 1))) do
		if not item_manager:isHaveEnoughItem(iter_21_1.itemid, iter_21_1.num) then
			if arg_21_2 then
				arg_21_2(6, L_CORE2SERVE_MSG[6])
			end

			return
		end

		table.insert(var_21_3, {
			dropid = iter_21_1.itemid,
			dropNum = iter_21_1.num
		})
	end

	network:rpc("upgrade_core", {
		servantid = arg_21_1
	}, function(arg_22_0)
		if arg_22_0.result == 1 then
			if arg_22_0.core then
				playermodel.gold = playermodel.gold - var_21_2

				global_update_gold_stone_diamond(var_21_2)

				playermodel.cores[arg_21_1] = arg_22_0.core

				if playermodel:isSoulInFight(arg_21_1) then
					FightManager.registerPlayerUpdate()
					cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("syncFightPower"))
				end

				if require("controller.role_false_level_manager"):isFalseLevelRoleInHangup() then
					FightManager.registerPlayerUpdate()
					cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("syncFightPower"))
				end

				for iter_22_0, iter_22_1 in ipairs(var_21_3) do
					item_manager:deleteItem(iter_22_1.dropid, iter_22_1.dropNum)
				end

				require("controller.alert_manager"):check_servant_breakout(false)

				if arg_21_2 then
					arg_21_2(1)
				end
			end
		elseif arg_22_0.result == 2 then
			if arg_21_2 then
				arg_21_2(2, L_CORE2SERVE_MSG[2])
			end
		elseif arg_22_0.result == 3 then
			local var_22_1 = core_data[playermodel.cores[arg_21_1].coreid].unlocklevel or 5

			if arg_21_2 then
				arg_21_2(3, (string.format(L_CORE2SERVE_MSG[3], CLASS_TABLE[math.ceil(var_22_1 / 100)], (var_22_1 % 100 == 0 or nil) and 100)))
			end
		elseif arg_22_0.result == 4 then
			if arg_21_2 then
				arg_21_2(4, L_CORE2SERVE_MSG[4])
			end
		elseif arg_22_0.result == 5 then
			if arg_21_2 then
				arg_21_2(5, L_CORE2SERVE_MSG[5])
			end
		elseif arg_22_0.result == 6 and arg_21_2 then
			arg_21_2(6, L_CORE2SERVE_MSG[6])
		end
	end)
end

function var_0_0.servantCoreReset(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	if require("controller.array_manager"):isServantPatrolNow(arg_23_1) then
		global_ShowBlockWords(L_PATROL_NO_HOLIDAY)

		if arg_23_3 then
			arg_23_3(5)
		end

		return
	end

	local playermodel = require("model.playermodel")

	network:rpc("reset_core", {
		servantid = arg_23_1,
		useticket = arg_23_2
	}, function(arg_24_0)
		print(dump(arg_24_0))

		if arg_24_0.result == 1 then
			if arg_24_0.weaponid then
				playermodel.items[playermodel.weaponId[arg_23_1]].weapon_attr.level = 0
			end

			global_gain({
				sp = arg_24_0.sp,
				gold = arg_24_0.gold,
				items = arg_24_0.items
			})

			if arg_24_0.cost_diamond then
				playermodel.diamond = playermodel.diamond - arg_24_0.cost_diamond
			end

			global_update_gold_stone_diamond(arg_24_0.gold, nil, arg_24_0.cost_diamond)
			global_update_strengthpoint()

			playermodel.cores[arg_23_1] = arg_24_0.core

			if playermodel:isSoulInFight(arg_23_1) then
				FightManager.registerPlayerUpdate()
				cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("syncFightPower"))
			end

			if require("controller.role_false_level_manager"):isFalseLevelRoleInHangup() then
				FightManager.registerPlayerUpdate()
				cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("syncFightPower"))
			end

			AnalyticManager.reset_core({
				servantid = arg_23_1,
				grade = var_0_0:getServantCoreRank(arg_23_1)
			})

			if arg_23_3 then
				arg_23_3(1)
			end

			sendNotification("CoreResetSuccess")
		elseif arg_24_0.result == 5 then
			global_ShowBlockWords(L_RESET_SOUL_IN_AFK)
		elseif arg_23_3 then
			arg_23_3(arg_24_0.result)
		end
	end)
end

function var_0_0:isTipsBreakOut(arg_25_1)
	return self:check_upgrade_conditions(arg_25_1)
end

function var_0_0.getCoreCurRankTotalLv(arg_26_0, arg_26_1)
	if not var_0_15[arg_26_1] then
		return 0
	end

	return #var_0_15[arg_26_1]
end

function var_0_0.canUpgradeByClass(arg_27_0, arg_27_1)
	arg_27_1 = require("common.Utility"):clamp(arg_27_1, 0, 3)

	return arg_27_1 < playermodel.class
end

function var_0_0.getCoreTotalLv(arg_28_0, arg_28_1)
	if not var_0_15[arg_28_1] then
		return 0
	end

	local var_28_0 = 0

	for iter_28_0 = 0, arg_28_1 do
		var_28_0 = var_28_0 + #var_0_15[iter_28_0]
	end

	return var_28_0
end

function var_0_0.getCoreMaxClass(arg_29_0, arg_29_1)
	network:rpc("get_cur_maxroleclass", nil, function(arg_30_0)
		if arg_30_0.maxclass then
			CLASS_TYPE_ID = {}

			for iter_30_0 = 1, arg_30_0.maxclass do
				CLASS_TYPE_ID[iter_30_0] = iter_30_0
			end

			if arg_29_1 then
				arg_29_1()
			end
		end
	end)
end

function var_0_0.getCoreMaxTotalLv(arg_31_0)
	local var_31_0 = 0

	for iter_31_0 = 0, #CLASS_TYPE_ID do
		var_31_0 = var_31_0 + #var_0_15[iter_31_0]
	end

	return var_31_0
end

function var_0_0.getCoreMaxLevelByGrade(arg_32_0)
	return math.min(math.min(souls_manager:get_can_up_level(), playermodel.grade), 300)
end

function var_0_0.get_servant_rarity(arg_33_0, arg_33_1)
	if not arg_33_1 then
		print(debug.traceback())
	end

	assert(arg_33_1, "servantid is nil")
	assert(servant_data[arg_33_1], "servant_data id is nil " .. arg_33_1)

	return RARITY_STR_TBL[servant_data[arg_33_1].roll_rarity]
end

function var_0_0.getBreakOutCostGold(arg_34_0, arg_34_1, arg_34_2)
	assert(arg_34_1, "servantid id is nil")

	arg_34_2 = arg_34_2 or core_data[playermodel.cores[arg_34_1].coreid].rank

	return role_break_gold_data["break_" .. arg_34_2].cost_gold
end

function var_0_0.getBreakOutCostMaterial(arg_35_0, arg_35_1, arg_35_2)
	arg_35_2 = arg_35_2 or core_data[playermodel.cores[arg_35_1].coreid].rank

	local var_35_0 = servant_data[arg_35_1].modelid
	local var_35_1 = {}

	if role_break_material_data[arg_35_1 .. "_" .. arg_35_2] then
		local var_35_2 = 1

		while role_break_material_data[arg_35_1 .. "_" .. arg_35_2]["itemid_" .. var_35_2] do
			table.insert(var_35_1, {
				itemid = role_break_material_data[arg_35_1 .. "_" .. arg_35_2]["itemid_" .. var_35_2],
				num = role_break_material_data[arg_35_1 .. "_" .. arg_35_2]["num_" .. var_35_2]
			})

			var_35_2 = var_35_2 + 1
		end
	else
		local var_35_3 = global_get_model_attr(var_35_0)

		if role_break_material_data["attr_" .. var_35_3 .. "_" .. arg_35_2] then
			local var_35_4 = 1

			while role_break_material_data["attr_" .. var_35_3 .. "_" .. arg_35_2]["itemid_" .. var_35_4] do
				table.insert(var_35_1, {
					itemid = role_break_material_data["attr_" .. var_35_3 .. "_" .. arg_35_2]["itemid_" .. var_35_4],
					num = role_break_material_data["attr_" .. var_35_3 .. "_" .. arg_35_2]["num_" .. var_35_4]
				})

				var_35_4 = var_35_4 + 1
			end
		end

		if role_break_material_data["career_" .. model_data[var_35_0].career .. "_" .. arg_35_2] then
			local var_35_5 = 1

			while role_break_material_data["career_" .. model_data[var_35_0].career .. "_" .. arg_35_2]["itemid_" .. var_35_5] do
				table.insert(var_35_1, {
					itemid = role_break_material_data["career_" .. model_data[var_35_0].career .. "_" .. arg_35_2]["itemid_" .. var_35_5],
					num = role_break_material_data["career_" .. model_data[var_35_0].career .. "_" .. arg_35_2]["num_" .. var_35_5]
				})

				var_35_5 = var_35_5 + 1
			end
		end

		if role_break_material_data["break_" .. arg_35_2] then
			local var_35_6 = 1

			while role_break_material_data["break_" .. arg_35_2]["itemid_" .. var_35_6] do
				table.insert(var_35_1, {
					itemid = role_break_material_data["break_" .. arg_35_2]["itemid_" .. var_35_6],
					num = role_break_material_data["break_" .. arg_35_2]["num_" .. var_35_6]
				})

				var_35_6 = var_35_6 + 1
			end
		end
	end

	return var_35_1
end

function var_0_0:getUpgradeCostRoleCardNum(arg_36_1, arg_36_2)
	local var_36_0 = souls_manager:get_roll_rarity_str(arg_36_1)

	if role_resonance_consume_data[tostring(arg_36_1)] then
		return role_resonance_consume_data[tostring(arg_36_1)]["numNeedPlus" .. arg_36_2 .. var_36_0] or role_resonance_consume_data[tostring(arg_36_1)]["numNeedPlusMaterialNum" .. arg_36_2 .. var_36_0]
	else
		return role_resonance_consume_data[self:get_servant_rarity(arg_36_1)]["numNeedPlus" .. arg_36_2 .. var_36_0]
	end
end

function var_0_0:getUpgradeCostMaterial(arg_37_1, arg_37_2)
	local var_37_0 = souls_manager:get_roll_rarity_str(arg_37_1)

	if role_resonance_consume_data[tostring(arg_37_1)] then
		return role_resonance_consume_data[tostring(arg_37_1)]["numNeedPlusMaterial" .. arg_37_2 .. var_37_0]
	else
		return role_resonance_consume_data[self:get_servant_rarity(arg_37_1)]["numNeedPlusMaterial" .. arg_37_2 .. var_37_0]
	end
end

function var_0_0:getUpgradeCostMaterialNum(arg_38_1, arg_38_2)
	local var_38_0 = souls_manager:get_roll_rarity_str(arg_38_1)

	if role_resonance_consume_data[tostring(arg_38_1)] then
		return role_resonance_consume_data[tostring(arg_38_1)]["numNeedPlusMaterialNum" .. arg_38_2 .. var_38_0]
	else
		return role_resonance_consume_data[self:get_servant_rarity(arg_38_1)]["numNeedPlusMaterialNum" .. arg_38_2 .. var_38_0]
	end
end

function var_0_0:getServantRarityCard(arg_39_1)
	if arg_39_1 == 215020 or arg_39_1 == 25920 then
		return nil
	end

	return role_resonance_consume_data[self:get_servant_rarity(arg_39_1)].rarityCard
end

function var_0_0:getServantRarityCardRate(arg_40_1)
	if arg_40_1 == 215020 or arg_40_1 == 25920 then
		return nil
	end

	return role_resonance_consume_data[self:get_servant_rarity(arg_40_1)].rarityCardRate
end

function var_0_0.getServantElementCard(arg_41_0, arg_41_1)
	return role_resonance_element_consume_data[global_get_model_attr(servant_data[arg_41_1].modelid)].eleCard
end

function var_0_0:getServantElementCardRate(arg_42_1)
	return role_resonance_consume_data[self:get_servant_rarity(arg_42_1)].eleCardRate
end

function var_0_0:oc_pre_resonance_level(arg_43_1)
	if role_resonance_consume_data[tostring(arg_43_1)] then
		return role_resonance_consume_data[tostring(arg_43_1)].oc_pre_resonance_level1
	else
		return role_resonance_consume_data[self:get_servant_rarity(arg_43_1)].oc_pre_resonance_level1
	end
end

function var_0_0:getOcCpuId(arg_44_1, arg_44_2)
	if role_resonance_consume_data[tostring(arg_44_1)] then
		return role_resonance_consume_data[tostring(arg_44_1)]["oc_cost_cpu_id" .. arg_44_2]
	else
		return role_resonance_consume_data[self:get_servant_rarity(arg_44_1)]["oc_cost_cpu_id" .. arg_44_2]
	end
end

function var_0_0:getOcCostCpuNum(arg_45_1, arg_45_2)
	if role_resonance_consume_data[tostring(arg_45_1)] then
		return role_resonance_consume_data[tostring(arg_45_1)]["oc_cost_cpu_num" .. arg_45_2]
	else
		return role_resonance_consume_data[self:get_servant_rarity(arg_45_1)]["oc_cost_cpu_num" .. arg_45_2]
	end
end

function var_0_0:getOcCostCardNum(arg_46_1, arg_46_2)
	if role_resonance_consume_data[tostring(arg_46_1)] then
		return role_resonance_consume_data[tostring(arg_46_1)]["oc_cost_card_num" .. arg_46_2]
	else
		return role_resonance_consume_data[self:get_servant_rarity(arg_46_1)]["oc_cost_card_num" .. arg_46_2]
	end
end

function var_0_0:isBreakLimit(arg_47_1)
	if not playermodel.haveServant[arg_47_1] then
		return false
	end

	local var_47_0 = playermodel.soulContract[arg_47_1]
	local var_47_1 = playermodel.soulOverClock[arg_47_1] or 0
	local var_47_2 = self:getUpgradeCostRoleCardNum(arg_47_1, var_47_0 + 1) or 0
	local var_47_3 = playermodel.servantNum[arg_47_1]
	local var_47_4 = item_manager:getItemNumber(servant_data[arg_47_1].studentCard)

	if var_47_0 >= 5 then
		if servant_data[arg_47_1]["oc_isopen" .. var_47_1 + 1] == 1 and not playermodel:isServantOverclockLockByTime(arg_47_1) then
			return (self:getOcCostCpuNum(arg_47_1, var_47_1 + 1) or 0) <= item_manager:getItemNumber((self:getOcCpuId(arg_47_1, var_47_1 + 1))) and (self:getOcCostCardNum(arg_47_1, var_47_1 + 1) or 0) <= var_47_3 + ((servant_data[arg_47_1].studentCard or nil) and (var_47_4 / servant_data[arg_47_1].studentCardRate or 0))
		else
			return false
		end
	end

	local var_47_7 = self:getUpgradeCostMaterial(arg_47_1, var_47_0 + 1)

	if var_47_7 then
		return self:getUpgradeCostMaterialNum(arg_47_1, var_47_0 + 1) <= item_manager:getItemNumber(var_47_7)
	else
		return var_47_2 <= var_47_3 + ((servant_data[arg_47_1].studentCard or nil) and (var_47_4 / servant_data[arg_47_1].studentCardRate or 0))
	end
end

function var_0_0:requestFastStrengthen(arg_48_1, arg_48_2, arg_48_3, arg_48_4)
	local component_manager = require("controller.component_manager")
	local weapon_manager = require("controller.weapon_manager")
	local var_48_2 = require("controller.fast_soulstrength_setting_manager"):getInstance()
	local item_manager = require("controller.item_manager")
	local alert_manager = require("controller.alert_manager")
	local playermodel = require("model.playermodel")
	local role_false_level_manager = require("controller.role_false_level_manager")
	local item_data = require("data.item_data")
	local var_48_8 = COMPONENT_MAIN_ATTR
	local var_48_9 = FIGHT_ATTR_INFO
	local var_48_10 = setmetatable({}, {
		__index = function(arg_49_0, arg_49_1)
			return var_48_9[var_48_8[arg_49_1]]
		end
	})

	if var_48_2:getOpType() == 0 then
		if arg_48_2 then
			arg_48_2(11)
		end

		return
	end

	arg_48_4 = arg_48_4 or self:getFastStrengthenCostData(arg_48_1)

	local var_48_11
	local var_48_12
	local var_48_13

	if arg_48_4.componentInfo then
		if arg_48_4.componentInfo.posInfo[1] then
			var_48_11 = arg_48_4.componentInfo.posInfo[1].selectComponentList
		end

		if arg_48_4.componentInfo.posInfo[2] then
			var_48_12 = arg_48_4.componentInfo.posInfo[2].selectComponentList
		end

		if arg_48_4.componentInfo.posInfo[3] then
			var_48_13 = arg_48_4.componentInfo.posInfo[3].selectComponentList
		end
	end

	if not arg_48_4.canStrengthen and self:fastStrengthenFailed({}, arg_48_1) then
		if arg_48_2 then
			arg_48_2(10)
		end

		return
	end

	if arg_48_3 == nil then
		arg_48_3 = var_48_2:getConfigure(var_48_2.Setting_Type.SecondConfirmation)
	end

	if arg_48_3 then
		LayerManager:pushInLayer("FastStrengthConfirmLayer", {
			servantid = arg_48_1,
			costData = arg_48_4,
			callBack = arg_48_2
		})

		return true
	end

	local var_48_14 = {
		servantid = arg_48_1
	}

	var_48_14.strengthpoint = arg_48_4.costStrengthpoint or 0
	var_48_14.coreRank = arg_48_4.lastBreakOutRank
	var_48_14.weaponLevel = arg_48_4.lastWeaponLv
	var_48_14.component1 = var_48_11
	var_48_14.component2 = var_48_12
	var_48_14.component3 = var_48_13

	require("network.network"):rpc("servant_strengthen_one_key", var_48_14, function(arg_50_0)
		if arg_50_0.result == 1 then
			if self:fastStrengthenFailed(arg_50_0, arg_48_1) then
				if arg_48_2 then
					arg_48_2(10)
				end

				return
			end

			if arg_50_0.core then
				playermodel.cores[arg_48_1] = arg_50_0.core

				if core_data[playermodel.cores[arg_48_1].coreid].rank < core_data[playermodel.cores[arg_48_1].coreid].rank then
					local var_50_2 = 0
					local var_50_3 = {}

					for iter_50_0 = 1, core_data[playermodel.cores[arg_48_1].coreid].rank - core_data[playermodel.cores[arg_48_1].coreid].rank do
						var_50_2 = var_50_2 + self:getBreakOutCostGold(arg_48_1, core_data[playermodel.cores[arg_48_1].coreid].rank + iter_50_0)

						for iter_50_1, iter_50_2 in pairs((self:getBreakOutCostMaterial(arg_48_1, core_data[playermodel.cores[arg_48_1].coreid].rank + iter_50_0))) do
							table.insert(var_50_3, {
								dropid = iter_50_2.itemid,
								dropNum = iter_50_2.num
							})
						end
					end

					playermodel.gold = playermodel.gold - var_50_2

					global_update_gold_stone_diamond(playermodel.gold, nil, nil)

					for iter_50_3, iter_50_4 in ipairs(var_50_3) do
						item_manager:deleteItem(iter_50_4.dropid, iter_50_4.dropNum)
					end
				end
			end

			if playermodel:isSoulInFight(arg_48_1) then
				FightManager.registerPlayerUpdate()
				cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("syncFightPower"))
			end

			if role_false_level_manager:isFalseLevelRoleInHangup() then
				FightManager.registerPlayerUpdate()
				cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("syncFightPower"))
			end

			alert_manager:check_servant_breakout(true)
			alert_manager:check_horcrux_strenghth(false)

			if playermodel.weaponId[arg_48_1] and arg_50_0.weaponLevel then
				playermodel.items[playermodel.weaponId[arg_48_1]].weapon_attr.level = arg_50_0.weaponLevel

				if playermodel.items[playermodel.weaponId[arg_48_1]].weapon_attr.level < arg_50_0.weaponLevel then
					for iter_50_5, iter_50_6 in pairs(playermodel.curSoul) do
						if iter_50_6.classtype == 1 and playermodel.weaponId[arg_48_1] == playermodel.weaponId[iter_50_6.fight_girl] then
							FightManager.registerPlayerChangeWeaponSkill()
							cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("syncFightPower"))

							break
						end
					end
				end

				for iter_50_7 = 1, arg_50_0.weaponLevel - playermodel.items[playermodel.weaponId[arg_48_1]].weapon_attr.level do
					if item_data[playermodel.items[playermodel.weaponId[arg_48_1]].itemid]["lv" .. playermodel.items[playermodel.weaponId[arg_48_1]].weapon_attr.level + iter_50_7 .. "_material1"] then
						local var_50_4 = 1

						while item_data[playermodel.items[playermodel.weaponId[arg_48_1]].itemid]["lv" .. playermodel.items[playermodel.weaponId[arg_48_1]].weapon_attr.level + iter_50_7 .. "_material" .. var_50_4] do
							item_manager:deleteItem(item_data[playermodel.items[playermodel.weaponId[arg_48_1]].itemid]["lv" .. playermodel.items[playermodel.weaponId[arg_48_1]].weapon_attr.level + iter_50_7 .. "_material" .. var_50_4], item_data[playermodel.items[playermodel.weaponId[arg_48_1]].itemid]["lv" .. playermodel.items[playermodel.weaponId[arg_48_1]].weapon_attr.level + iter_50_7 .. "_material" .. var_50_4 .. "_num"])

							var_50_4 = var_50_4 + 1
						end
					end
				end

				require("controller.alert_manager"):check_weapon_update()
				AnalyticManager.strengthen_weapon({
					weaponid = playermodel.items[playermodel.weaponId[arg_48_1]].itemid,
					level = arg_50_0.weaponLevel
				})
			end

			local var_50_5 = arg_50_0.componentList

			if arg_50_0.componentList and next(var_50_5) then
				for iter_50_8 = 1, #var_50_5 do
					playermodel.items[var_50_5[iter_50_8].entityid].component_attr.extra = var_50_5[iter_50_8].component.extra
					playermodel.items[var_50_5[iter_50_8].entityid].component_attr.attr = var_50_5[iter_50_8].component.attr
					playermodel.items[var_50_5[iter_50_8].entityid].component_attr.strengthen = var_50_5[iter_50_8].component.strengthen
					playermodel.items[var_50_5[iter_50_8].entityid].component_attr.exp = var_50_5[iter_50_8].component.exp

					local var_50_6

					if playermodel.items[var_50_5[iter_50_8].entityid].component_attr.use then
						for iter_50_9, iter_50_10 in pairs(playermodel.curSoul) do
							if iter_50_10.classtype == 1 and playermodel.component[iter_50_10.fight_girl] then
								for iter_50_11, iter_50_12 in pairs(playermodel.component[iter_50_10.fight_girl]) do
									if iter_50_12.id == var_50_5[iter_50_8].entityid then
										FightManager.registerPlayerChangeComponent()
										cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("syncFightPower"))

										break
									end
								end
							end
						end

						var_50_6 = {}
					end

					var_50_6.component_attr = var_48_10[item_data[playermodel.items[var_50_5[iter_50_8].entityid].itemid].main_attr]
					var_50_6.level = playermodel.items[var_50_5[iter_50_8].entityid].component_attr.extra

					AnalyticManager.strengthComponentSuccess(var_50_6)
				end
			end

			if arg_50_0.costgold then
				playermodel.gold = playermodel.gold - arg_50_0.costgold

				global_update_gold_stone_diamond(playermodel.gold, nil, nil)
			end

			if arg_50_0.strengthpoint then
				playermodel.strengthpoint = tonumber(arg_50_0.strengthpoint)

				global_update_strengthpoint()
			end

			if var_48_11 then
				for iter_50_13, iter_50_14 in pairs(var_48_11) do
					item_manager:deleteItem(iter_50_14)
				end
			end

			if var_48_12 then
				for iter_50_15, iter_50_16 in pairs(var_48_12) do
					item_manager:deleteItem(iter_50_16)
				end
			end

			if var_48_13 then
				for iter_50_17, iter_50_18 in pairs(var_48_13) do
					item_manager:deleteItem(iter_50_18)
				end
			end

			if arg_48_2 then
				arg_48_2(1, arg_50_0)
			end

			cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("ONE_BUTTON_STRENGTHENING")))
		end
	end)
end

function var_0_0.fastStrengthenFailed(arg_51_0, arg_51_1, arg_51_2)
	local component_manager = require("controller.component_manager")
	local weapon_manager = require("controller.weapon_manager")
	local var_51_2 = require("controller.fast_soulstrength_setting_manager"):getInstance()
	local item_manager = require("controller.item_manager")
	local alert_manager = require("controller.alert_manager")
	local playermodel = require("model.playermodel")
	local role_false_level_manager = require("controller.role_false_level_manager")
	local item_data = require("data.item_data")
	local var_51_8 = COMPONENT_MAIN_ATTR
	local var_51_9 = FIGHT_ATTR_INFO
	local var_51_10 = setmetatable({}, {
		__index = function(arg_52_0, arg_52_1)
			return var_51_9[var_51_8[arg_52_1]]
		end
	})
	local var_51_11 = var_51_2:getOpType()
	local var_51_12 = true
	local var_51_13 = var_51_2:getConfigure(var_51_2.Setting_Type.Level)
	local var_51_14 = var_51_2:getConfigure(var_51_2.Setting_Type.Weapon)
	local var_51_15 = var_51_2:getConfigure(var_51_2.Setting_Type.Component)

	if var_51_13 and arg_51_1.core then
		var_51_12 = false
	end

	if var_51_14 then
		if arg_51_1.weaponLevel then
			var_51_12 = false
		end

		if arg_51_1.core then
			var_51_12 = false
		end
	end

	local var_51_16

	if var_51_15 and arg_51_1.componentList and next(arg_51_1.componentList) then
		var_51_12 = false
		var_51_16 = {}
	end

	var_51_16[1] = function()
		if not var_51_13 or playermodel.grade and playermodel.cores[arg_51_2] and playermodel.cores[arg_51_2].level and playermodel.cores[arg_51_2].level >= playermodel.grade then
			-- block empty
		elseif arg_51_0:StrengthenJudge(arg_51_2) == 4 then
			global_ShowBlockWords(L_CORE_MGR[1])

			return true
		end

		return false
	end
	var_51_16[2] = function()
		if var_51_14 and not playermodel.weaponId[arg_51_2] then
			global_ShowBlockWords(L_CORE_MGR[2])

			return true
		end

		return false
	end
	var_51_16[3] = function()
		if var_51_14 and not weapon_manager:isMaxLevelByServantid(arg_51_2) and playermodel.weaponId[arg_51_2] then
			local var_55_0 = {}

			while item_data[playermodel.items[playermodel.weaponId[arg_51_2]].itemid]["lv" .. playermodel.items[playermodel.weaponId[arg_51_2]].weapon_attr.level + 1 .. "_material" .. 1] do
				table.insert(var_55_0, {
					itemid = item_data[playermodel.items[playermodel.weaponId[arg_51_2]].itemid]["lv" .. playermodel.items[playermodel.weaponId[arg_51_2]].weapon_attr.level + 1 .. "_material" .. 1],
					needNum = item_data[playermodel.items[playermodel.weaponId[arg_51_2]].itemid]["lv" .. playermodel.items[playermodel.weaponId[arg_51_2]].weapon_attr.level + 1 .. "_material" .. 1 .. "_num"],
					ownNum = item_manager:getItemNumber(item_data[playermodel.items[playermodel.weaponId[arg_51_2]].itemid]["lv" .. playermodel.items[playermodel.weaponId[arg_51_2]].weapon_attr.level + 1 .. "_material" .. 1])
				})
			end

			for iter_55_0 = 1, #var_55_0 do
				if var_55_0[iter_55_0].ownNum < var_55_0[iter_55_0].needNum then
					local var_55_2 = {
						itemId = var_55_0[iter_55_0].itemid
					}

					var_55_2.mainNeed = var_55_0[iter_55_0].needNum - var_55_0[iter_55_0].ownNum or 0

					LayerManager:pushInLayer("PopGameCompoundLayer", var_55_2)

					return true
				end
			end
		end

		return false
	end
	var_51_16[4] = function()
		if var_51_14 and not weapon_manager:isMaxLevelByServantid(arg_51_2) and playermodel.weaponId[arg_51_2] then
			if (item_data[playermodel.items[playermodel.weaponId[arg_51_2]].itemid]["lv" .. playermodel.items[playermodel.weaponId[arg_51_2]].weapon_attr.level + 1 .. "_cost"] or 0) > playermodel.gold then
				global_ShowBlockWords(L_CORE_MGR[3])

				return true
			end
		end

		return false
	end
	var_51_16[5] = function()
		if var_51_15 and (not playermodel.component[arg_51_2] or not next(playermodel.component[arg_51_2])) then
			global_ShowBlockWords(L_CORE_MGR[4])

			return true
		end

		return false
	end
	var_51_16[6] = function()
		if var_51_15 and playermodel.component[arg_51_2] and next(playermodel.component[arg_51_2]) then
			local var_58_0

			if not component_manager:isMaxLevelByServantid(arg_51_2) then
				for iter_58_0 = 1, #playermodel.component[arg_51_2] do
					if not component_manager:isMaxLevel(playermodel.component[arg_51_2][iter_58_0].id) then
						local var_58_1 = component_manager:getComponentExp(playermodel.component[arg_51_2][iter_58_0].id)
						local var_58_2 = component_manager:getComponetLevelUpNeedExp(playermodel.component[arg_51_2][iter_58_0].id, playermodel.items[playermodel.component[arg_51_2][iter_58_0].id].component_attr.extra)

						if var_58_2 then
							local var_58_3, var_58_4, var_58_5 = component_manager:getStrengthenExpected(playermodel.component[arg_51_2][iter_58_0].id, var_58_2 - var_58_1)

							if var_58_5 > playermodel.gold then
								if var_58_0 == nil then
									var_58_0 = true
								end
							else
								var_58_0 = false
							end
						else
							local var_58_6, var_58_7, var_58_8 = component_manager:getStrengthenExpected(playermodel.component[arg_51_2][iter_58_0].id, 0)

							if var_58_8 <= playermodel.gold then
								break
							end
						end
					end
				end

				if var_58_0 == true or false then
					-- block empty
				else
					LayerManager:pushInLayer("PopGameCompoundLayer", {
						itemId = 5100123,
						mainNeed = 1
					})

					return true
				end
			end
		end

		return false
	end
	var_51_16[7] = function()
		if var_51_15 and playermodel.component[arg_51_2] and next(playermodel.component[arg_51_2]) then
			local var_59_0

			if not component_manager:isMaxLevelByServantid(arg_51_2) then
				for iter_59_0 = 1, #playermodel.component[arg_51_2] do
					if not component_manager:isMaxLevel(playermodel.component[arg_51_2][iter_59_0].id) then
						local var_59_1 = component_manager:getComponentExp(playermodel.component[arg_51_2][iter_59_0].id)
						local var_59_2 = component_manager:getComponetLevelUpNeedExp(playermodel.component[arg_51_2][iter_59_0].id, playermodel.items[playermodel.component[arg_51_2][iter_59_0].id].component_attr.extra)

						if var_59_2 then
							local var_59_3, var_59_4, var_59_5 = component_manager:getStrengthenExpected(playermodel.component[arg_51_2][iter_59_0].id, var_59_2 - var_59_1)

							if var_59_5 > playermodel.gold then
								if var_59_0 == nil then
									var_59_0 = true
								end
							else
								var_59_0 = false
							end
						end
					end
				end

				if var_59_0 == true then
					global_ShowBlockWords(L_CORE_MGR[5])

					return true
				end
			end
		end

		return false
	end
	var_51_16[8] = function()
		if var_51_13 and playermodel.cores[arg_51_2] and playermodel.cores[arg_51_2].level >= playermodel.grade then
			global_ShowBlockWords(L_CORE_MGR[6])

			return true
		end

		return false
	end
	var_51_16[9] = function()
		if var_51_14 and weapon_manager:isMaxLevelByServantid(arg_51_2) and not weapon_manager:isLargeMaxLevelByServantid(arg_51_2) then
			local var_61_0 = arg_51_0:getBreakOutCostGold(arg_51_2, core_data[playermodel.cores[arg_51_2].coreid].rank + 1)
			local var_61_1 = {}
			local var_61_2 = {}

			for iter_61_0, iter_61_1 in pairs((arg_51_0:getBreakOutCostMaterial(arg_51_2, core_data[playermodel.cores[arg_51_2].coreid].rank + 1))) do
				local var_61_3 = item_manager:getItemNumber(iter_61_1.itemid)

				if var_61_3 < iter_61_1.num then
					var_61_2 = {
						id = iter_61_1.itemid,
						num = iter_61_1.num - var_61_3
					}

					break
				end

				table.insert(var_61_1, {
					dropid = iter_61_1.itemid,
					dropNum = iter_61_1.num
				})
			end

			if next(var_61_2) then
				LayerManager:pushInLayer("PopGameCompoundLayer", {
					itemId = var_61_2.id,
					mainNeed = var_61_2.num
				})

				return true
			end
		end

		return false
	end
	var_51_16[10] = function()
		if var_51_14 and weapon_manager:isMaxLevelByServantid(arg_51_2) and not weapon_manager:isLargeMaxLevelByServantid(arg_51_2) and arg_51_0:getBreakOutCostGold(arg_51_2, core_data[playermodel.cores[arg_51_2].coreid].rank + 1) > playermodel.gold then
			global_ShowBlockWords(L_CORE_MGR[7])

			return true
		end

		return false
	end
	var_51_16[11] = function()
		if not var_51_13 or playermodel.cores[arg_51_2] and playermodel.cores[arg_51_2].level >= playermodel.grade then
			-- block empty
		else
			local var_63_0 = arg_51_0:StrengthenJudge(arg_51_2)

			if var_63_0 == 3 then
				global_ShowBlockWords(L_CORE_MGR[8])

				return true
			elseif var_63_0 == 5 then
				global_ShowBlockWords(L_CORE_MGR[8])

				return true
			elseif var_63_0 == 2 and arg_51_0:getCoreMaxTotalLv() <= arg_51_0:getCoreLv(arg_51_2) then
				global_ShowBlockWords(L_CORE_MGR[8])

				return true
			end
		end

		return false
	end
	var_51_16[12] = function()
		if var_51_14 and weapon_manager:isMaxLevelByServantid(arg_51_2) and weapon_manager:isLargeMaxLevelByServantid(arg_51_2) then
			global_ShowBlockWords(L_CORE_MGR[9])

			return true
		end

		return false
	end
	var_51_16[13] = function()
		if var_51_15 and component_manager:isMaxLevelByServantid(arg_51_2) then
			global_ShowBlockWords(L_CORE_MGR[10])

			return true
		end

		return false
	end

	if var_51_12 then
		for iter_51_0 = 1, #var_51_16 do
			if var_51_16[iter_51_0]() then
				break
			end
		end
	end

	return var_51_12
end

function var_0_0:getFastStrengthenInfo(arg_66_1, arg_66_2)
	arg_66_2 = arg_66_2 or {}

	local var_66_0 = self:getCoreMaxLevelByGrade()
	local var_66_1 = self:getCoreLv(arg_66_1)
	local var_66_2 = var_66_1 + 1
	local var_66_3 = self:getCoreExp(arg_66_1)
	local var_66_4 = arg_66_2.ownStrengthpoint or playermodel.strengthpoint + var_66_3
	local var_66_5 = 0

	local function var_66_6()
		return servant_level_data[var_66_2].consume_intensitem_number <= var_66_4
	end

	while var_66_2 <= var_66_0 do
		if var_66_6() then
			var_66_4 = var_66_4 - servant_level_data[var_66_2].consume_intensitem_number
			var_66_5 = var_66_5 + servant_level_data[var_66_2].consume_intensitem_number
			var_66_2 = var_66_2 + 1
		else
			if var_66_2 - var_66_1 > 1 then
				var_66_5 = var_66_5 + var_66_4
				var_66_4 = 0
			end

			break
		end
	end

	if (var_66_2 - var_66_1 > 1 or nil) and true then
		UpdataTableData(arg_66_2, {
			ownStrengthpoint = var_66_4
		})

		return {
			ownData = arg_66_2,
			costStrengthpoint = var_66_5 - var_66_3,
			lastCoreLv = var_66_2 - 1,
			curCoreLv = var_66_1
		}
	else
		UpdataTableData(arg_66_2, {
			ownStrengthpoint = 0
		})

		local var_66_8 = {
			ownData = arg_66_2,
			costStrengthpoint = var_66_4 - var_66_3,
			lastCoreLv = var_66_1,
			curCoreLv = var_66_1
		}

		if var_66_1 == var_66_0 then
			var_66_8.costStrengthpoint = 0
		end

		return var_66_8
	end

	return nil
end

function var_0_0:getFastStrengthenCostData(arg_68_1)
	local var_68_0 = {
		ownData = {}
	}
	local var_68_1 = require("controller.fast_soulstrength_setting_manager"):getInstance()

	if var_68_1:getConfigure(var_68_1.Setting_Type.Level) then
		local var_68_2 = self:getFastStrengthenInfo(arg_68_1, var_68_0.ownData)

		if var_68_2 then
			UpdataTableData(var_68_0, var_68_2)
		end
	end

	if var_68_1:getConfigure(var_68_1.Setting_Type.Weapon) then
		local var_68_3 = require("controller.weapon_manager"):getFastStrengthenInfo(arg_68_1, var_68_0.ownData)

		if var_68_3 then
			UpdataTableData(var_68_0, var_68_3)
		end
	end

	if var_68_1:getConfigure(var_68_1.Setting_Type.Component) then
		local var_68_4 = require("controller.component_manager"):getFastStrengthenInfo(arg_68_1, var_68_0.ownData)

		if var_68_4 then
			UpdataTableData(var_68_0, var_68_4)
		end
	end

	if var_68_0.componentInfo then
		local var_68_5 = {}

		for iter_68_0, iter_68_1 in pairs(var_68_0.componentInfo) do
			var_68_5[iter_68_1.pos] = iter_68_1
			var_68_5[iter_68_1.pos].entityid = iter_68_0
		end

		var_68_0.componentInfo.posInfo = var_68_5
	end

	var_68_0.canStrengthen = false

	if var_68_0.lastCoreLv and var_68_0.curCoreLv and var_68_0.lastCoreLv > var_68_0.curCoreLv or var_68_0.costStrengthpoint and var_68_0.costStrengthpoint > 0 then
		var_68_0.canStrengthen = true
	end

	if var_68_0.lastBreakOutRank and var_68_0.curBreakOutRank and var_68_0.lastBreakOutRank > var_68_0.curBreakOutRank then
		var_68_0.canStrengthen = true
	end

	if var_68_0.lastWeaponLv and var_68_0.curWeaponLv and var_68_0.lastWeaponLv > var_68_0.curWeaponLv then
		var_68_0.canStrengthen = true
	end

	if var_68_0.componentInfo and var_68_0.componentInfo.posInfo then
		for iter_68_2, iter_68_3 in pairs(var_68_0.componentInfo.posInfo) do
			if iter_68_3.lastLv and iter_68_3.curLv and iter_68_3.lastLv > iter_68_3.curLv then
				var_68_0.canStrengthen = true

				break
			end
		end
	end

	return var_68_0
end

function var_0_0:canFastUpgrade(arg_69_1)
	if not playermodel.haveServant[arg_69_1] then
		return false
	end

	local var_69_0 = playermodel.soulContract[arg_69_1]

	if not playermodel.soulOverClock[arg_69_1] then
		-- block empty
	end

	local var_69_2 = self:getUpgradeCostRoleCardNum(arg_69_1, var_69_0 + 1) or 0
	local var_69_3 = playermodel.servantNum[arg_69_1]
	local var_69_4 = item_manager:getItemNumber(servant_data[arg_69_1].studentCard)

	if var_69_0 >= 5 then
		return false
	end

	local var_69_5 = self:getUpgradeCostMaterial(arg_69_1, var_69_0 + 1)

	if var_69_5 then
		return self:getUpgradeCostMaterialNum(arg_69_1, var_69_0 + 1) <= item_manager:getItemNumber(var_69_5)
	else
		return var_69_2 <= var_69_3 + ((servant_data[arg_69_1].studentCard or nil) and (var_69_4 / servant_data[arg_69_1].studentCardRate or 0))
	end
end

function var_0_0:getFastUpgradeData()
	local var_70_0 = {}

	for iter_70_0, iter_70_1 in pairs(playermodel.haveServant) do
		if self:canFastUpgrade(iter_70_0) then
			table.insert(var_70_0, iter_70_0)
		end
	end

	return var_70_0
end

return var_0_0
