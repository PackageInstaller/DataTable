local var_0_0 = {}
local playermodel = require("model.playermodel")
local network = require("network.network")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local horcrux_strength_data = require("data.horcrux_strength_data")
local horcrux_break_data = require("data.horcrux_break_data")
local model_data = require("data.model_data")
local total_skill_data = require("data.total_skill_data")
local item_data = require("data.item_data")
local var_0_10 = require("data.item_data")
local var_0_11 = require("data.total_skill_data")
local servant_data = require("data.servant_data")
local eat_horcrux_ele_data = require("data.eat_horcrux_ele_data")

ASSIST_STATUS_FREE = 0
ASSIST_STATUS_WORKING = 1
ASSIST_STATUS_COMPLETE = 2
ASSIST_STATUS_UNVERIFY = 3

function var_0_0.init(arg_1_0)
	return
end

function var_0_0.getHorcruxListByParam(arg_2_0, arg_2_1)
	print("getHorcruxListByParam in horcrux_manager is deprecated!!!!, please use bag_manager...")
end

function var_0_0.sortHorcruxByType(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	print("sortHorcruxByType in horcrux_manager is deprecated!!!!, please use bag_manager...")
end

function var_0_0.sortOwnedHorcrux(arg_4_0)
	print("sortOwnedHorcrux is deprecated!!!!, please use bag_manager...")
end

function var_0_0.updateOwnedHorcrux(arg_5_0)
	print("updateOwnedHorcrux is deprecated!!!!!")
end

function var_0_0.registerNewHorcrux(arg_6_0, arg_6_1)
	print("registerNewHorcrux is deprecated!!!!")
end

function var_0_0.getOwnedCount(arg_7_0, arg_7_1)
	print("getOwnedCount is deprecated!!!!")

	return 0
end

function var_0_0.haveHorcrux(arg_8_0, arg_8_1)
	print("haveHorcrux is deprecated!!!!!")

	return false
end

function var_0_0.getHorcruxList(arg_9_0, arg_9_1)
	print("getHorcruxList is deprecated!!!!")
end

function var_0_0.getHorcruxListByConditions(arg_10_0, arg_10_1, arg_10_2)
	print("getHorcruxListByConditions is deprecated!!!!, please use bag_manager...")
end

function var_0_0.getHorcruxMainSkill(arg_11_0, arg_11_1)
	return item_data[playermodel.items[arg_11_1].itemid].skill
end

function var_0_0:getHorcruxSkills(arg_12_1, arg_12_2)
	return self:getHorcruxSkillsByItemid(playermodel.items[arg_12_1].itemid, arg_12_2 or self:getHorcruxStarLevel(arg_12_1))
end

function var_0_0.getHorcruxSkillsByItemid(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = {}
	local var_13_1 = arg_13_2 or 1
	local var_13_2 = 1

	while item_data[arg_13_1]["upstar_" .. var_13_1 .. "_skill" .. var_13_2] or item_data[arg_13_1]["skill" .. var_13_2] do
		table.insert(var_13_0, item_data[arg_13_1]["upstar_" .. var_13_1 .. "_skill" .. var_13_2] or item_data[arg_13_1]["skill" .. var_13_2])

		var_13_2 = var_13_2 + 1
	end

	return var_13_0
end

function var_0_0.getHorcruxSkillConfig(arg_14_0, arg_14_1)
	return {}
end

function var_0_0.getHorcruxScore(arg_15_0, arg_15_1, arg_15_2)
	return 0
end

function var_0_0.getHorcruxDamageFacAdditionByEntityid(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	return var_0_0:getHorcruxDamageFacAddition(playermodel.items[arg_16_1].itemid, arg_16_2 or var_0_0:getHorcruxHClass(arg_16_1), arg_16_3 or var_0_0:getHorcruxStarLevel(arg_16_1))
end

function var_0_0.getHorcruxDamageFacAddition(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	return 1 * (item_data[arg_17_1]["damage_addition_class_" .. arg_17_2] or 0)
end

function var_0_0.getHorcruxDamageUpstarAddition(arg_18_0, arg_18_1, arg_18_2)
	return item_data[arg_18_1]["star_" .. arg_18_2 .. "_add_damage"] or 0
end

function var_0_0:getHorcruxDamageAddition(arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5, arg_19_6)
	local var_19_1 = (horcrux_strength_data[arg_19_3].attr + horcrux_break_data[arg_19_4].attr) * (item_data[arg_19_1].point_k or 1)
	local var_19_2 = item_data[arg_19_1].point_b

	if not item_data[arg_19_1].point_b then
		var_19_2 = 0
		arg_19_2 = arg_19_2 + self:getHorcruxDamageFacAddition(arg_19_1, arg_19_5, arg_19_6)
		arg_19_2 = arg_19_2 * 0.01
	end

	return (var_19_1 + var_19_2) * arg_19_2 + self:getHorcruxDamageUpstarAddition(arg_19_1, arg_19_6)
end

function var_0_0.getHorcruxHpFacAdditionByEntityid(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	return var_0_0:getHorcruxHpFacAddition(playermodel.items[arg_20_1].itemid, arg_20_2 or var_0_0:getHorcruxHClass(arg_20_1), arg_20_3 or var_0_0:getHorcruxStarLevel(arg_20_1))
end

function var_0_0.getHorcruxHpFacAddition(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	return 1 * (item_data[arg_21_1]["hp_addition_class_" .. arg_21_2] or 0)
end

function var_0_0.getHorcruxHpUpstarAddition(arg_22_0, arg_22_1, arg_22_2)
	return item_data[arg_22_1]["star_" .. arg_22_2 .. "_add_hp"] or 0
end

function var_0_0:getHorcruxHpAddition(arg_23_1, arg_23_2, arg_23_3, arg_23_4, arg_23_5, arg_23_6)
	local var_23_1 = (horcrux_strength_data[arg_23_3].attr + horcrux_break_data[arg_23_4].attr) * (item_data[arg_23_1].point_k or 1)
	local var_23_2 = item_data[arg_23_1].point_b

	if not item_data[arg_23_1].point_b then
		var_23_2 = 0
		arg_23_2 = arg_23_2 + self:getHorcruxHpFacAddition(arg_23_1, arg_23_5, arg_23_6)
		arg_23_2 = math.floor(arg_23_2 * 0.01)
	end

	return (var_23_1 + var_23_2) * arg_23_2 + self:getHorcruxHpUpstarAddition(arg_23_1, arg_23_6)
end

function var_0_0:getHorcruxAssistConfig(arg_24_1, arg_24_2)
	if not arg_24_1 then
		return nil
	end

	if not playermodel.items[arg_24_1] then
		return
	end

	local var_24_0 = playermodel.items[arg_24_1].itemid
	local var_24_1 = item_data[playermodel.items[arg_24_1].itemid]
	local var_24_2 = playermodel.items[arg_24_1].horcrux_attr
	local var_24_3 = {
		hp = 0,
		damage = 0,
		modelid = playermodel.items[arg_24_1].itemid,
		skills = {}
	}
	local var_24_4 = self:getHorcruxStarLevel(arg_24_1) or 1

	while var_24_1["upstar_" .. var_24_4 .. "_skill" .. 1] or var_24_1["skill" .. 1] do
		table.insert(var_24_3.skills, var_24_1["upstar_" .. var_24_4 .. "_skill" .. 1] or var_24_1["skill" .. 1])
	end

	var_24_3.damage = self:getHorcruxDamageAddition(var_24_0, var_24_2.dfac, arg_24_2 or var_24_2.hlv, var_24_2.hbreak, var_24_2.hclass, var_24_2.star)
	var_24_3.hp = self:getHorcruxHpAddition(var_24_0, var_24_2.hfac, arg_24_2 or var_24_2.hlv, var_24_2.hbreak, var_24_2.hclass, var_24_2.star)
	var_24_3.attr = var_24_1.attr
	var_24_3.typeskill = self:getTypeSkillByItemid(var_24_0)
	var_24_3.hclass = var_24_2.hclass or 0

	return var_24_3
end

function var_0_0:getHorcruxAssistConfigWithServant(arg_25_1, arg_25_2)
	arg_25_2 = arg_25_2 or 10

	if not arg_25_1 then
		return nil
	end

	if not playermodel.items[arg_25_1] then
		return nil
	end

	local var_25_0 = playermodel.items[arg_25_1].itemid
	local var_25_1 = item_data[playermodel.items[arg_25_1].itemid]
	local var_25_2 = playermodel.items[arg_25_1].horcrux_attr
	local var_25_3 = {
		hp = 0,
		damage = 0,
		skills = {},
		itemid = playermodel.items[arg_25_1].itemid
	}
	local var_25_4 = self:getHorcruxStarLevel(arg_25_1) or 1

	while var_25_1["upstar_" .. var_25_4 .. "_skill" .. 1] or var_25_1["skill" .. 1] do
		table.insert(var_25_3.skills, var_25_1["upstar_" .. var_25_4 .. "_skill" .. 1] or var_25_1["skill" .. 1])
	end

	local var_25_7 = var_25_2.hbreak

	var_25_3.damage = self:getHorcruxDamageAddition(var_25_0, var_25_2.dfac, var_25_2.hlv, var_25_2.hbreak, var_25_2.hclass, var_25_2.star)
	var_25_3.hp = self:getHorcruxHpAddition(var_25_0, var_25_2.hfac, var_25_2.hlv, var_25_7, var_25_2.hclass, var_25_2.star)
	var_25_3.attr = var_25_1.attr
	var_25_3.typeskill = self:getTypeSkillByItemid(var_25_0)
	var_25_3.hclass = var_25_2.hclass or 0

	return var_25_3
end

function var_0_0:getSubHorcruxAssistConfigWithServant(arg_26_1, arg_26_2)
	arg_26_2 = arg_26_2 or 10

	local var_26_0 = var_0_10[arg_26_1.itemid]
	local var_26_1 = {
		hp = 0,
		damage = 0,
		skills = {},
		itemid = itemid
	}

	while var_26_0["skill" .. 1] do
		table.insert(var_26_1.skills, var_26_0["skill" .. 1])
	end

	local var_26_3 = arg_26_1.hbreak

	var_26_1.damage = self:getHorcruxDamageAddition(arg_26_1.itemid, arg_26_1.dfac, arg_26_1.hlv, arg_26_1.hbreak, arg_26_1.hclass, arg_26_1.star)
	var_26_1.hp = self:getHorcruxHpAddition(arg_26_1.itemid, arg_26_1.hfac, arg_26_1.hlv, var_26_3, arg_26_1.hclass, arg_26_1.star)
	var_26_1.attr = var_26_0.attr

	return var_26_1
end

function var_0_0:getArenaHorcruxAssistConfig(arg_27_1)
	if not arg_27_1 then
		return nil
	end

	local var_27_0 = arg_27_1.itemid
	local var_27_1 = item_data[arg_27_1.itemid]
	local var_27_2 = {
		hp = 0,
		damage = 0,
		skills = {}
	}
	local var_27_3 = arg_27_1.star or 1

	while var_27_1["upstar_" .. var_27_3 .. "_skill" .. 1] or var_27_1["skill" .. 1] do
		table.insert(var_27_2.skills, var_27_1["upstar_" .. var_27_3 .. "_skill" .. 1] or var_27_1["skill" .. 1])
	end

	var_27_2.damage = self:getHorcruxDamageAddition(var_27_0, arg_27_1.dfac, arg_27_1.hlv, arg_27_1.hbreak, arg_27_1.hclass, arg_27_1.star)
	var_27_2.hp = self:getHorcruxHpAddition(var_27_0, arg_27_1.hfac, arg_27_1.hlv, arg_27_1.hbreak, arg_27_1.hclass, arg_27_1.star)
	var_27_2.attr = var_27_1.attr
	var_27_2.typeskill = self:getTypeSkillByItemid(var_27_0)
	var_27_2.hclass = arg_27_1.hclass or 0

	return var_27_2, var_27_0
end

function var_0_0:getArenaHorcruxAssistConfigWithServant(arg_28_1, arg_28_2)
	arg_28_2 = arg_28_2 or 10

	if not arg_28_1 then
		return nil
	end

	local var_28_0 = arg_28_1.itemid
	local var_28_1 = item_data[arg_28_1.itemid]
	local var_28_2 = {
		hp = 0,
		damage = 0,
		skills = {}
	}
	local var_28_3 = arg_28_1.star or 1

	while var_28_1["upstar_" .. var_28_3 .. "_skill" .. 1] or var_28_1["skill" .. 1] do
		table.insert(var_28_2.skills, var_28_1["upstar_" .. var_28_3 .. "_skill" .. 1] or var_28_1["skill" .. 1])
	end

	local var_28_6 = arg_28_1.hbreak

	var_28_2.damage = self:getHorcruxDamageAddition(var_28_0, arg_28_1.dfac, arg_28_1.hlv, arg_28_1.hbreak, arg_28_1.hclass, arg_28_1.star)
	var_28_2.hp = self:getHorcruxHpAddition(var_28_0, arg_28_1.hfac, arg_28_1.hlv, var_28_6, arg_28_1.hclass, arg_28_1.star)
	var_28_2.attr = var_28_1.attr
	var_28_2.typeskill = self:getTypeSkillByItemid(var_28_0)
	var_28_2.hclass = arg_28_1.hclass or 0

	return var_28_2, var_28_0
end

function var_0_0.getMonsterHorcruxAssistConfig(arg_29_0, arg_29_1)
	if not arg_29_1 then
		return nil
	end

	local var_29_0 = {
		skills = {}
	}

	while arg_29_1["horcruxskill_" .. 1] do
		table.insert(var_29_0.skills, arg_29_1["horcruxskill_" .. 1])
	end

	return var_29_0
end

function var_0_0.getHorcruxItemid(arg_30_0, arg_30_1)
	if not arg_30_1 then
		return nil
	end

	if not playermodel.items[arg_30_1] then
		return nil
	end

	return playermodel.items[arg_30_1].itemid
end

function var_0_0.isHorcruxLocked(arg_31_0, arg_31_1)
	return playermodel.items[arg_31_1].horcrux_attr.lock
end

function var_0_0.isInArrays(arg_32_0, arg_32_1)
	for iter_32_0, iter_32_1 in pairs(playermodel.arrays) do
		for iter_32_2, iter_32_3 in pairs(iter_32_1) do
			if type(iter_32_3) == "table" and string.find(iter_32_2, "pos_") and iter_32_3.assist_girl == arg_32_1 then
				return true
			end
		end
	end

	return false
end

function var_0_0.getHorcruxType(arg_33_0, arg_33_1)
	return item_data[playermodel.items[arg_33_1].itemid].horcruxtype
end

function var_0_0.getHorcruxModel(arg_34_0, arg_34_1)
	return item_data[playermodel.items[arg_34_1].itemid].model
end

function var_0_0.getHorcruxName(arg_35_0, arg_35_1)
	return item_data[playermodel.items[arg_35_1].itemid].name
end

function var_0_0.getHorcruxStarLevel(arg_36_0, arg_36_1)
	return playermodel.items[arg_36_1].horcrux_attr.star
end

local var_0_14 = {
	[3054431] = 3054431,
	[3054511] = 3054511
}

function var_0_0.getHorcruxDamageFac(arg_37_0, arg_37_1)
	local var_37_0 = playermodel.items[arg_37_1].horcrux_attr.dfac

	if var_0_14[playermodel.items[arg_37_1].itemid] then
		var_37_0 = math.floor(var_37_0 / 10)
		var_37_0 = var_37_0 * 10
	end

	return var_37_0
end

function var_0_0.getHorcruxDamageFacByItemid(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = arg_38_2

	if var_0_14[arg_38_1] then
		var_38_0 = math.floor(var_38_0 / 10)
		var_38_0 = var_38_0 * 10
	end

	return var_38_0
end

function var_0_0.getHorcruxHpFac(arg_39_0, arg_39_1)
	local var_39_0 = playermodel.items[arg_39_1].horcrux_attr.hfac

	if var_0_14[playermodel.items[arg_39_1].itemid] then
		var_39_0 = math.floor(var_39_0 / 10)
		var_39_0 = var_39_0 * 10
	end

	return var_39_0
end

function var_0_0.getHorcruxHpFacByItemid(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = arg_40_2

	if var_0_14[arg_40_1] then
		var_40_0 = math.floor(var_40_0 / 10)
		var_40_0 = var_40_0 * 10
	end

	return var_40_0
end

function var_0_0:getHorcruxLevel(arg_41_1)
	return self:getHorcruxStarLevel(arg_41_1)
end

function var_0_0.getHorcruxHLV(arg_42_0, arg_42_1)
	return playermodel.items[arg_42_1].horcrux_attr.hlv or 0
end

function var_0_0.getHorcruxExp(arg_43_0, arg_43_1)
	if not playermodel.items[arg_43_1] then
		return 0
	end

	if not playermodel.items[arg_43_1].horcrux_attr then
		return 0
	end

	return playermodel.items[arg_43_1].horcrux_attr.exp or 0
end

function var_0_0.getCompoundExp(arg_44_0, arg_44_1)
	return (horcrux_strength_data[var_0_0:getHorcruxHLV(arg_44_1)].totalexp + var_0_0:getHorcruxExp(arg_44_1)) / 2 + item_data[playermodel.items[arg_44_1].itemid].returnexp
end

function var_0_0.getHorcruxNextBreakLimitExp(arg_45_0, arg_45_1)
	local var_45_0 = var_0_0:getHorcruxBreakLv(arg_45_1)

	if var_45_0 > 10 then
		return 0
	end

	return horcrux_strength_data[var_45_0 * 10].totalexp - horcrux_strength_data[var_0_0:getHorcruxHLV(arg_45_1)].totalexp - var_0_0:getHorcruxExp(arg_45_1)
end

function var_0_0:getHorcruxDataWithPreset(arg_46_1, arg_46_2, arg_46_3, arg_46_4)
	return {
		damage = 0,
		hp = 0,
		damage = self:getHorcruxDamageAddition(playermodel.items[arg_46_1].itemid, playermodel.items[arg_46_1].horcrux_attr.dfac, arg_46_2 or playermodel.items[arg_46_1].horcrux_attr.hlv, arg_46_3 or playermodel.items[arg_46_1].horcrux_attr.hbreak, arg_46_4 or playermodel.items[arg_46_1].horcrux_attr.hclass, playermodel.items[arg_46_1].horcrux_attr.star),
		hp = self:getHorcruxHpAddition(playermodel.items[arg_46_1].itemid, playermodel.items[arg_46_1].horcrux_attr.hfac, arg_46_2 or playermodel.items[arg_46_1].horcrux_attr.hlv, arg_46_3 or playermodel.items[arg_46_1].horcrux_attr.hbreak, arg_46_4 or playermodel.items[arg_46_1].horcrux_attr.hclass, playermodel.items[arg_46_1].horcrux_attr.star)
	}
end

function var_0_0:horcruxCanBreakOut(arg_47_1)
	local var_47_0 = var_0_0:getHorcruxHLV(arg_47_1)
	local var_47_1 = var_0_0:getHorcruxBreakLv(arg_47_1)
	local var_47_2 = var_0_0:getHorcruxAttr(arg_47_1)

	if var_47_0 >= self:get_max_level_with_star((self:getHorcruxStarLevel(arg_47_1))) then
		return false
	end

	if var_47_1 <= 4 and var_47_1 >= playermodel.class * 2 then
		return false
	end

	if not item_data[playermodel.items[arg_47_1].itemid]["break" .. var_47_1 .. "_item1"] then
		return false
	end

	if item_data[playermodel.items[arg_47_1].itemid]["cost_gold" .. var_47_1] and item_data[playermodel.items[arg_47_1].itemid]["cost_gold" .. var_47_1] > playermodel.gold then
		return false
	end

	if var_47_1 * 10 <= var_47_0 and var_47_1 < #horcrux_break_data then
		while item_data[playermodel.items[arg_47_1].itemid].break1_item1 and item_data[playermodel.items[arg_47_1].itemid]["break" .. var_47_1 .. "_item" .. 1] do
			if item_data[playermodel.items[arg_47_1].itemid]["break" .. var_47_1 .. "_num" .. 1] > item_manager:getItemNumber(item_data[playermodel.items[arg_47_1].itemid]["break" .. var_47_1 .. "_item" .. 1]) then
				return false
			end
		end
	else
		return false
	end

	return true
end

function var_0_0.horcruxBagIsTipsHorcruxUpgrade(arg_48_0, arg_48_1)
	return false
end

function var_0_0:horcruxBagCanBreakOut(arg_49_1)
	local var_49_0 = self:getHorcruxStarLevel(arg_49_1)

	if self:getHorcruxHLV(arg_49_1) == self:get_max_level_with_star(var_49_0) and var_49_0 < item_data[self:getHorcruxItemid(arg_49_1)].max_star and var_49_0 < 5 then
		return false
	end

	if require("controller.array_manager"):isHorcruxInArrayNow(arg_49_1) then
		return var_0_0:horcruxCanBreakOut(arg_49_1)
	end

	return false
end

function var_0_0.getHorcruxMaxHclass(arg_50_0, arg_50_1)
	local var_50_0 = 0

	while item_data[arg_50_1]["lv" .. var_50_0 + 1 .. "_material1"] do
		var_50_0 = var_50_0 + 1
	end

	return var_50_0
end

function var_0_0.isTipsHorcruxUpgrade(arg_51_0, arg_51_1)
	return false
end

function var_0_0.horcruxBagIsTipsUpLevelToNext(arg_52_0, arg_52_1)
	return false
end

function var_0_0:isUpLevelToNext(arg_53_1)
	local var_53_0 = var_0_0:getHorcruxHLV(arg_53_1)
	local var_53_1 = var_0_0:getHorcruxExp(arg_53_1)

	if var_53_0 >= var_0_0:getHorcruxBreakLv(arg_53_1) * 10 then
		return false
	end

	local var_53_2 = {
		[3050031] = true,
		[3050014] = true,
		[3050021] = true,
		[3050051] = true,
		[3050011] = true,
		[3050041] = true
	}
	local var_53_3 = horcrux_strength_data[var_53_0 + 1].totalexp - horcrux_strength_data[var_53_0].totalexp

	for iter_53_0, iter_53_1 in pairs(playermodel.items) do
		if item_data[iter_53_1.itemid].bag_item_type == kITEM_HORCRUX and var_53_2[iter_53_1.itemid] then
			var_53_3 = var_53_3 - self:getCompoundExp(iter_53_0)

			if var_53_3 <= 0 then
				return true
			end
		end
	end

	return false
end

function var_0_0.getHorcruxBreakLv(arg_54_0, arg_54_1)
	return playermodel.items[arg_54_1].horcrux_attr.hbreak
end

function var_0_0.getHorcruxHClass(arg_55_0, arg_55_1)
	return playermodel.items[arg_55_1].horcrux_attr.hclass
end

function var_0_0.getHorcruxAttr(arg_56_0, arg_56_1)
	return item_data[playermodel.items[arg_56_1].itemid].attr
end

function var_0_0.getHorcruxClass(arg_57_0, arg_57_1)
	return item_data[playermodel.items[arg_57_1].itemid].class
end

function var_0_0.getHorcruxIconImage(arg_58_0, arg_58_1)
	return item_data[arg_58_1].image_id
end

function var_0_0.getHorcruxRoleImage(arg_59_0, arg_59_1)
	return model_data[item_data[arg_59_1].model].cute_Q
end

function var_0_0.getHorcruxRoleImageByItemSprite(arg_60_0, arg_60_1)
	return item_data[arg_60_1].image_id
end

function var_0_0.getHorcruxHeadImage(arg_61_0, arg_61_1)
	return model_data[item_data[arg_61_1].model].head_image
end

function var_0_0.switchLockStatus(arg_62_0, arg_62_1, arg_62_2)
	if not playermodel.items[arg_62_1] then
		if arg_62_2 then
			arg_62_2()
		end

		return
	end

	network:rpc("switch_horcrux_lock_status", {
		entityid = arg_62_1
	}, function(arg_63_0)
		if arg_63_0.result == 1 then
			playermodel.items[arg_62_1].horcrux_attr.lock = not playermodel.items[arg_62_1].horcrux_attr.lock
		end

		if arg_62_2 then
			arg_62_2(arg_63_0.result)
		end
	end)
end

function var_0_0.decomposeHorcruxBatch(arg_64_0, arg_64_1, arg_64_2)
	if not next(arg_64_1) then
		if arg_64_2 then
			arg_64_2(5)
		end

		return
	end

	for iter_64_0, iter_64_1 in pairs(arg_64_1) do
		if playermodel.items[iter_64_1].horcrux_attr.lock or var_0_10[playermodel.items[iter_64_1].itemid].break_lock then
			if arg_64_2 then
				arg_64_2(3)
			end

			return
		end

		if playermodel.items[iter_64_1].itemtype ~= kITEM_HORCRUX then
			if arg_64_2 then
				arg_64_2(4)
			end

			return
		end
	end

	network:rpc("decompose_horcrux_batch", {
		entityids = arg_64_1
	}, function(arg_65_0)
		if arg_65_0.result == 1 then
			if arg_65_0.successes then
				for iter_65_0, iter_65_1 in pairs(arg_65_0.successes) do
					item_manager:deleteItem(iter_65_1)
				end
			end

			global_gain({
				gold = arg_65_0.gold,
				items = arg_65_0.items
			})

			for iter_65_2, iter_65_3 in pairs(playermodel.arrays) do
				for iter_65_4, iter_65_5 in pairs(iter_65_3) do
					if type(iter_65_5) == "table" then
						for iter_65_6, iter_65_7 in pairs(arg_64_1) do
							if iter_65_5.assist_girl == iter_65_7 then
								iter_65_5.assist_girl = nil

								break
							end
						end
					end
				end
			end

			if arg_64_2 then
				arg_64_2(arg_65_0.result)
			end
		elseif arg_64_2 then
			arg_64_2(arg_65_0.result)
		end
	end)
end

local function var_0_15(arg_66_0)
	local var_66_0 = {}
	local var_66_1 = var_0_0:getHorcruxItemid(arg_66_0)

	for iter_66_0 = 1, var_0_0:getHorcruxBreakLv(arg_66_0) - 1 do
		while item_data[var_66_1]["break" .. iter_66_0 .. "_item" .. 1] do
			table.insert(var_66_0, {
				itemid = item_data[var_66_1]["break" .. iter_66_0 .. "_item" .. 1],
				num = math.floor(item_data[var_66_1]["break" .. iter_66_0 .. "_num" .. 1] / 2)
			})
		end

		table.insert(var_66_0, {
			itemid = "gold",
			num = math.ceil(item_data[var_66_1]["cost_gold" .. iter_66_0] / 2)
		})
	end

	return var_66_0
end

local function var_0_16(arg_67_0)
	local var_67_0 = var_0_0:getHorcruxItemid(arg_67_0)
	local var_67_1 = {}

	for iter_67_0 = 1, var_0_0:getHorcruxHClass(arg_67_0) do
		while item_data[var_67_0]["lv" .. iter_67_0 .. "_material" .. 1] do
			table.insert(var_67_1, {
				itemid = item_data[var_67_0]["lv" .. iter_67_0 .. "_material" .. 1],
				num = math.floor(item_data[var_67_0]["lv" .. iter_67_0 .. "_material" .. 1 .. "_num"] / 2)
			})
		end

		table.insert(var_67_1, {
			itemid = "gold",
			num = math.floor(item_data[var_67_0]["lv" .. iter_67_0 .. "_gold"] / 2)
		})
	end

	return var_67_1
end

local function var_0_17(arg_68_0)
	local var_68_0 = math.floor((horcrux_strength_data[var_0_0:getHorcruxHLV(arg_68_0)].totalexp + var_0_0:getHorcruxExp(arg_68_0)) * 0.5)

	if math.ceil(var_68_0 / 1000) == 0 then
		return {}
	else
		return {
			{
				itemid = 1601000,
				num = math.ceil(var_68_0 / 1000)
			}
		}
	end
end

function var_0_0.getHorcruxDecomposeReturnMaterial(arg_69_0, arg_69_1)
	if type(arg_69_1) ~= "table" then
		arg_69_1 = {
			arg_69_1
		}
	end

	local var_69_0 = {}

	for iter_69_0, iter_69_1 in pairs(arg_69_1) do
		for iter_69_2, iter_69_3 in pairs((var_0_15(iter_69_1))) do
			var_69_0[iter_69_3.itemid] = var_69_0[iter_69_3.itemid] or 0
			var_69_0[iter_69_3.itemid] = var_69_0[iter_69_3.itemid] + iter_69_3.num
		end

		for iter_69_4, iter_69_5 in pairs((var_0_16(iter_69_1))) do
			var_69_0[iter_69_5.itemid] = var_69_0[iter_69_5.itemid] or 0
			var_69_0[iter_69_5.itemid] = var_69_0[iter_69_5.itemid] + iter_69_5.num
		end

		for iter_69_6, iter_69_7 in pairs((var_0_17(iter_69_1))) do
			var_69_0[iter_69_7.itemid] = var_69_0[iter_69_7.itemid] or 0
			var_69_0[iter_69_7.itemid] = var_69_0[iter_69_7.itemid] + iter_69_7.num
		end

		local var_69_2 = drop_manager:getDropMsg(item_data[playermodel.items[iter_69_1].itemid].dropid)

		if var_69_2.gold then
			var_69_0.gold = var_69_0.gold or 0
			var_69_0.gold = var_69_0.gold + var_69_2.gold
		end

		for iter_69_8, iter_69_9 in pairs(var_69_2.equips) do
			var_69_0[iter_69_9.dropid] = var_69_0[iter_69_9.dropid] or 0
			var_69_0[iter_69_9.dropid] = var_69_0[iter_69_9.dropid] + iter_69_9.dropNum
		end
	end

	local var_69_4 = {}

	for iter_69_10, iter_69_11 in pairs(var_69_0) do
		table.insert(var_69_4, {
			itemid = iter_69_10,
			num = iter_69_11
		})
	end

	local var_69_5 = {
		[2] = {
			weight = 1,
			func = function(self, arg_70_1)
				return self.num > arg_70_1.num
			end
		},
		{
			weight = 2,
			func = function(self, arg_71_1)
				local var_71_0 = 10
				local var_71_1 = 10

				if self.itemid ~= "gold" and item_data[self.itemid] then
					var_71_0 = item_data[self.itemid].equip_quality
				end

				if arg_71_1.itemid ~= "gold" and item_data[arg_71_1.itemid] then
					var_71_1 = item_data[arg_71_1.itemid].equip_quality
				end

				if var_71_0 == var_71_1 then
					return "=="
				else
					return var_71_1 < var_71_0
				end
			end
		}
	}

	table.sort(var_69_5, function(arg_72_0, arg_72_1)
		return arg_72_0.weight > arg_72_1.weight
	end)
	table.sort(var_69_4, function(arg_73_0, arg_73_1)
		for iter_73_0 = 1, #var_69_5 do
			if var_69_5[iter_73_0].func(arg_73_0, arg_73_1) ~= "==" then
				return var_69_5[iter_73_0].func(arg_73_0, arg_73_1)
			end
		end
	end)

	return var_69_4
end

function var_0_0.decomposeHorcrux(arg_74_0, arg_74_1, arg_74_2)
	if not playermodel.items[arg_74_1] then
		if arg_74_2 then
			arg_74_2(0)
		end

		return
	end

	if playermodel.items[arg_74_1].horcrux_attr.lock then
		if arg_74_2 then
			arg_74_2(2)
		end

		return
	end

	network:rpc("decompose_horcrux", {
		entityid = arg_74_1
	}, function(arg_75_0)
		if arg_75_0.result == 1 then
			if arg_75_0.items then
				local var_75_0 = {}
				local item_data = require("data.item_data")

				for iter_75_0, iter_75_1 in pairs(arg_75_0.items) do
					table.insert(var_75_0, L_HORCRUX_DECOMPOSE.Get .. item_data[iter_75_1.itemid].name .. "*" .. item_manager:setItemByServerItem(iter_75_1))
				end

				global_riseWords(var_75_0)
			end

			item_manager:deleteItem(arg_74_1)

			if arg_74_2 then
				arg_74_2(1)
			end
		elseif arg_74_2 then
			arg_74_2(arg_75_0.result)
		end
	end)
end

local function var_0_18(arg_76_0)
	return false
end

function var_0_0.gethorcruxChipInfo(arg_77_0, arg_77_1)
	if item_data[arg_77_1].bag_item_type ~= kITEM_HORCRUX_CHIP then
		return ""
	end

	return (string.format(L_HORCRUX_COMPOSE, item_data[arg_77_1].compound_consume))
end

function var_0_0.horcruxChipCompound(arg_78_0, arg_78_1, arg_78_2, arg_78_3)
	if not arg_78_1 then
		if arg_78_3 then
			arg_78_3(0)
		end

		return
	end

	if item_data[arg_78_1].bag_item_type ~= kITEM_HORCRUX_CHIP then
		if arg_78_3 then
			arg_78_3(0)
		end

		return
	end

	local var_78_0 = item_data[arg_78_1].compound_consume

	if not item_manager:isHaveEnoughItem(arg_78_1, arg_78_2) then
		if arg_78_3 then
			arg_78_3(2)
		end

		return
	end

	if arg_78_2 < var_78_0 and arg_78_3 then
		arg_78_3(2)
	end

	arg_78_2 = math.floor(arg_78_2 / var_78_0) * var_78_0

	network:rpc("horcruxchip_compound", {
		horcruxchip = arg_78_1,
		num = arg_78_2
	}, function(arg_79_0)
		if arg_79_0.result == 1 then
			item_manager:deleteItem(arg_78_1, arg_78_2)

			if arg_78_3 then
				arg_78_3(1, arg_79_0.items)
			end
		elseif arg_78_3 then
			arg_78_3(arg_79_0.result)
		end
	end)
end

function var_0_0.horcruxLevelUp(arg_80_0, arg_80_1, arg_80_2, arg_80_3)
	if not arg_80_1 then
		if arg_80_3 then
			arg_80_3(0)
		end

		return
	end

	network:rpc("horcrux_levelup", {
		horcrux = arg_80_1,
		consumes = arg_80_2
	}, function(arg_81_0)
		if arg_81_0.result == 1 then
			playermodel.items[arg_80_1].horcrux_attr.hlv = arg_81_0.hlv
			playermodel.items[arg_80_1].horcrux_attr.exp = arg_81_0.exp

			AnalyticManager.LevelUp({
				HorcruxId = playermodel.items[arg_80_2[1].entityid].itemid,
				HorcruxLevel = playermodel.items[arg_80_1].horcrux_attr.hlv,
				HorcruxStar = playermodel.items[arg_80_1].horcrux_attr.hclass
			})

			for iter_81_0, iter_81_1 in ipairs(arg_80_2) do
				item_manager:deleteItem(iter_81_1.entityid, iter_81_1.num)
			end

			if playermodel.items[arg_80_1].horcrux_attr.hlv ~= arg_81_0.hlv and var_0_18(arg_80_1) then
				FightManager.registerPlayerUpdateHorcrux()
				cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("syncFightPower"))
			end

			AlertManager:check_horcrux_strenghth()

			if arg_80_3 then
				arg_80_3(1)
			end

			sendNotification("HorcruxLevelUpSucceeded", {
				entityid = arg_80_1
			})
		elseif arg_80_3 then
			arg_80_3(arg_81_0.result)
		end
	end)
end

function var_0_0.horcruxBreakOut(arg_82_0, arg_82_1, arg_82_2, arg_82_3, arg_82_4)
	if not arg_82_1 then
		if arg_82_4 then
			arg_82_4(0)
		end

		return
	end

	network:rpc("horcrux_breakout", {
		horcrux = arg_82_1
	}, function(arg_83_0)
		if arg_83_0.result == 1 then
			playermodel.items[arg_82_1].horcrux_attr.hbreak = arg_83_0.hbreaklv
			playermodel.items[arg_82_1].horcrux_attr.hlv = arg_83_0.hlv
			playermodel.items[arg_82_1].horcrux_attr.exp = arg_83_0.exp

			if var_0_18(arg_82_1) then
				FightManager.registerPlayerUpdateHorcrux()
				cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("syncFightPower"))
			end

			for iter_83_0, iter_83_1 in ipairs(arg_82_2) do
				item_manager:deleteItem(iter_83_1.entityid, iter_83_1.num)
			end

			AlertManager:check_servant_breakout(true)
			AlertManager:check_horcrux_strenghth(false)

			playermodel.gold = playermodel.gold - arg_82_3

			global_update_gold_stone_diamond(arg_82_3)

			if arg_82_4 then
				arg_82_4(1)
			end

			AnalyticManager.breakSuccess({
				HorcruxId = playermodel.items[arg_82_1].itemid,
				HorcruxGrade = playermodel.items[arg_82_1].horcrux_attr.hbreak,
				HorcruxStar = playermodel.items[arg_82_1].horcrux_attr.hclass
			})
			sendNotification("HorcruxBreakoutSucceeded", {
				entityid = arg_82_1
			})
		elseif arg_82_4 then
			arg_82_4(arg_83_0.result)
		end
	end)
end

function var_0_0.horcruxUpgrade(arg_84_0, arg_84_1, arg_84_2, arg_84_3)
	if not arg_84_1 then
		if arg_84_3 then
			arg_84_3(0)
		end

		return
	end

	network:rpc("horcrux_upgrade", {
		horcrux = arg_84_1,
		consumes = arg_84_2
	}, function(arg_85_0)
		if arg_85_0.result == 1 then
			playermodel.items[arg_84_1].horcrux_attr.hclass = arg_85_0.hclass

			if arg_85_0.cost_items and next(arg_85_0.cost_items) then
				for iter_85_0, iter_85_1 in ipairs(arg_85_0.cost_items) do
					item_manager:deleteItem(iter_85_1.entityid, iter_85_1.num)
				end
			end

			if arg_85_0.gold then
				playermodel.gold = playermodel.gold - arg_85_0.gold

				global_update_gold_stone_diamond(arg_85_0.gold)
			end

			if var_0_18(arg_84_1) then
				FightManager.registerPlayerUpdateHorcrux()
				cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("syncFightPower"))
			end

			AlertManager:check_horcrux_strenghth()

			if arg_84_3 then
				arg_84_3(1)
			end
		elseif arg_84_3 then
			arg_84_3(arg_85_0.result)
		end
	end)
end

function var_0_0.getHorcruxAssistNewConfig(arg_86_0, arg_86_1)
	local var_86_0 = type(arg_86_1) == "table" and arg_86_1.itemid or arg_86_1
	local var_86_1 = item_data[var_86_0]
	local var_86_2 = {
		modelid = var_86_0,
		skills = {}
	}

	while var_86_1["skill" .. 1] do
		table.insert(var_86_2.skills, var_86_1["skill" .. 1])
	end

	return var_86_2
end

function var_0_0.getHelpGirlData(arg_87_0, arg_87_1)
	local var_87_0 = {}

	for iter_87_0 = 1, 4 do
		if arg_87_1[iter_87_0] and arg_87_1[iter_87_0].horcrux then
			var_87_0[#var_87_0 + 1] = var_0_0:getHorcruxAssistNewConfig(arg_87_1[iter_87_0].horcrux)
		end
	end

	return var_87_0
end

function var_0_0.handleHelpGirlData(arg_88_0, arg_88_1)
	local var_88_1 = {}

	for iter_88_0 = 1, #arg_88_1 do
		while arg_88_1[iter_88_0].skills[1] do
			if var_0_11[arg_88_1[iter_88_0].skills[1]].enter_trigger then
				var_88_1[#var_88_1 + 1] = {
					modelid = arg_88_1[iter_88_0].modelid,
					skillid = arg_88_1[iter_88_0].skills[1]
				}
			end
		end
	end

	return var_88_1
end

local var_0_19 = {
	{
		value = "c",
		key = 0
	},
	{
		value = "b_minus",
		key = 0.1
	},
	{
		value = "b",
		key = 0.2
	},
	{
		value = "b_plus",
		key = 0.3
	},
	{
		value = "a_minus",
		key = 0.4
	},
	{
		value = "a",
		key = 0.5
	},
	{
		value = "a_puls",
		key = 0.65
	},
	{
		value = "s",
		key = 0.75
	},
	{
		value = "s_plus",
		key = 0.95
	}
}
local var_0_20 = {
	c = {
		max = 0.1,
		min = 0
	},
	b = {
		max = 0.4,
		min = 0.1
	},
	a = {
		max = 0.75,
		min = 0.4
	},
	s = {
		max = 1,
		min = 0.75
	}
}

function var_0_0:getHorcruxDamageFacSectionGrade(arg_89_1)
	local var_89_9000
	local var_89_0 = var_0_19[1].value
	local var_89_1 = self:getHorcruxItemid(arg_89_1)
	local var_89_2 = self:getHorcruxDamageFac(arg_89_1)
	local var_89_3 = 1
	local var_89_4 = 1

	while item_data[var_89_1]["star_weight_" .. 1] do
		if item_data[var_89_1]["star_weight_" .. 1] ~= 0 then
			if var_89_3 == 1 then
				var_89_3 = 1
			end

			var_89_4 = 1
		end
	end

	local var_89_6 = tonumber(split(item_data[var_89_1]["fac_range_damage_" .. var_89_3], ",")[1])
	local var_89_7 = tonumber(split(item_data[var_89_1]["fac_range_damage_" .. var_89_4], ",")[2])
	local var_89_8 = var_89_6 - var_89_9000

	for iter_89_0, iter_89_1 in pairs(var_0_19) do
		if (((var_89_2 - (var_89_6 - var_89_9000)) / (var_89_7 - var_89_6 % 10 - (var_89_6 - var_89_9000)) == 0 or nil) and 0.01) > iter_89_1.key then
			var_89_0 = iter_89_1.value
		end
	end

	return (var_89_7 - var_89_6 % 10 == var_89_8 or nil) and "s_plus"
end

function var_0_0.getHorcruxDamageFacSectionGradeInPhotoFile(arg_90_0, arg_90_1)
	local var_90_9000
	local var_90_0 = 1
	local var_90_1 = 1

	while item_data[arg_90_1]["star_weight_" .. 1] do
		if item_data[arg_90_1]["star_weight_" .. 1] ~= 0 then
			if var_90_0 == 1 then
				var_90_0 = 1
			end

			var_90_1 = 1
		end
	end

	local var_90_3 = tonumber(split(item_data[arg_90_1]["fac_range_damage_" .. var_90_0], ",")[1])
	local var_90_4 = tonumber(split(item_data[arg_90_1]["fac_range_damage_" .. var_90_1], ",")[2])
	local var_90_5 = var_90_3 - var_90_9000
	local var_90_7 = {}

	for iter_90_0, iter_90_1 in pairs(var_0_20) do
		var_90_7[iter_90_0] = {}
		var_90_7[iter_90_0].min = (var_90_5 + iter_90_1.min * (var_90_4 - var_90_3 % 10 - var_90_5)) / 100
		var_90_7[iter_90_0].max = (var_90_5 + iter_90_1.max * (var_90_4 - var_90_3 % 10 - var_90_5)) / 100
		var_90_7[iter_90_0].min = var_90_7[iter_90_0].min - var_90_7[iter_90_0].min % 0.1
		var_90_7[iter_90_0].max = var_90_7[iter_90_0].max - var_90_7[iter_90_0].max % 0.1
	end

	return var_90_7
end

function var_0_0:getHorcruxHpFacSectionGrade(arg_91_1)
	local var_91_9000
	local var_91_0 = var_0_19[1].value
	local var_91_1 = self:getHorcruxItemid(arg_91_1)
	local var_91_2 = self:getHorcruxHpFac(arg_91_1)
	local var_91_3 = 1
	local var_91_4 = 1

	while item_data[var_91_1]["star_weight_" .. 1] do
		if item_data[var_91_1]["star_weight_" .. 1] ~= 0 then
			if var_91_3 == 1 then
				var_91_3 = 1
			end

			var_91_4 = 1
		end
	end

	local var_91_6 = tonumber(split(item_data[var_91_1]["fac_range_hp_" .. var_91_3], ",")[1])
	local var_91_7 = tonumber(split(item_data[var_91_1]["fac_range_hp_" .. var_91_4], ",")[2])
	local var_91_8 = var_91_6 - var_91_9000

	for iter_91_0, iter_91_1 in pairs(var_0_19) do
		if (((var_91_2 - (var_91_6 - var_91_9000)) / (var_91_7 - var_91_6 % 100 - (var_91_6 - var_91_9000)) == 0 or nil) and 0.01) > iter_91_1.key then
			var_91_0 = iter_91_1.value
		end
	end

	return (var_91_7 - var_91_6 % 100 == var_91_8 or nil) and "s_plus"
end

function var_0_0.getHorcruxHpFacSectionGradeInPhotoFile(arg_92_0, arg_92_1)
	local var_92_9000
	local var_92_0 = 1
	local var_92_1 = 1

	while item_data[arg_92_1]["star_weight_" .. 1] do
		if item_data[arg_92_1]["star_weight_" .. 1] ~= 0 then
			if var_92_0 == 1 then
				var_92_0 = 1
			end

			var_92_1 = 1
		end
	end

	local var_92_3 = tonumber(split(item_data[arg_92_1]["fac_range_hp_" .. var_92_0], ",")[1])
	local var_92_4 = tonumber(split(item_data[arg_92_1]["fac_range_hp_" .. var_92_1], ",")[2])
	local var_92_5 = var_92_3 - var_92_9000
	local var_92_7 = {}

	for iter_92_0, iter_92_1 in pairs(var_0_20) do
		var_92_7[iter_92_0] = {}
		var_92_7[iter_92_0].min = math.floor((var_92_5 + iter_92_1.min * (var_92_4 - var_92_3 % 100 - var_92_5)) / 100)
		var_92_7[iter_92_0].max = math.floor((var_92_5 + iter_92_1.max * (var_92_4 - var_92_3 % 100 - var_92_5)) / 100)
	end

	return var_92_7
end

function var_0_0.getTypeSkillByItemid(arg_93_0, arg_93_1)
	return item_data[arg_93_1].typeskill or 9901004
end

function var_0_0:getTypeSkillByEntityid(arg_94_1)
	return self:getTypeSkillByItemid(playermodel.items[arg_94_1].itemid)
end

function var_0_0.getRaceByItemid(arg_95_0, arg_95_1)
	return item_data[arg_95_1].race or 9901004
end

function var_0_0:getRaceByEntityid(arg_96_1)
	return self:getRaceByItemid(playermodel.items[arg_96_1].itemid)
end

local function var_0_22(arg_98_0, arg_98_1)
	return {
		damage = math.min(2, arg_98_0.damage * arg_98_1.damage),
		hp = math.min(2, arg_98_0.hp * arg_98_1.hp)
	}
end

function var_0_0.getServantAttrAddPercent(arg_100_0, arg_100_1, arg_100_2)
	return {
		damage = 1,
		hp = 1
	}
end

function var_0_0:horcrux_upstar(arg_101_1, arg_101_2, arg_101_3)
	if playermodel.items[arg_101_1].horcrux_attr.star >= self:get_max_upstar(arg_101_1) then
		return arg_101_3({
			result = 10
		})
	end

	if not playermodel.items[arg_101_1] then
		if arg_101_3 then
			arg_101_3({
				result = 2
			})
		end

		return
	end

	if not arg_101_2 then
		if arg_101_3 then
			arg_101_3({
				result = 2
			})
		end

		return
	end

	if not next(arg_101_2) then
		if arg_101_3 then
			arg_101_3({
				result = 2
			})
		end

		return
	end

	for iter_101_0, iter_101_1 in pairs(arg_101_2) do
		if arg_101_1 == iter_101_1 then
			if arg_101_3 then
				arg_101_3({
					result = 6
				})
			end

			return
		end

		if self:isHorcruxLocked(iter_101_1) then
			global_ShowBlockWords("材料魂器已被锁定，操作无效")

			if arg_101_3 then
				arg_101_3({
					result = 7
				})
			end

			return
		end

		if var_0_18(iter_101_1) then
			global_ShowBlockWords("材料魂器处于编队中，操作无效")

			if arg_101_3 then
				arg_101_3({
					result = 8
				})
			end

			return
		end

		if playermodel.items[iter_101_1].itemtype ~= kITEM_HORCRUX then
			if arg_101_3 then
				arg_101_3({
					result = 9
				})
			end

			return
		end
	end

	local var_101_0 = {}

	if item_data[playermodel.items[arg_101_1].itemid]["upstar_" .. playermodel.items[arg_101_1].horcrux_attr.star + 1 .. "_need_self"] then
		local var_101_1 = 0

		for iter_101_2, iter_101_3 in pairs(arg_101_2) do
			if var_101_1 < item_data[playermodel.items[arg_101_1].itemid]["upstar_" .. playermodel.items[arg_101_1].horcrux_attr.star + 1 .. "_need_self"] and playermodel.items[iter_101_3].horcrux_attr.star >= playermodel.items[arg_101_1].horcrux_attr.star and (item_data[playermodel.items[iter_101_3].itemid].select_type == item_data[playermodel.items[arg_101_1].itemid].select_type or item_data[playermodel.items[iter_101_3].itemid].upstar_material == 1) then
				var_101_1 = var_101_1 + 1
				var_101_0[iter_101_3] = true
			end
		end

		if var_101_1 < item_data[playermodel.items[arg_101_1].itemid]["upstar_" .. playermodel.items[arg_101_1].horcrux_attr.star + 1 .. "_need_self"] then
			if arg_101_3 then
				arg_101_3({
					result = 4
				})
			end

			return
		end
	end

	if item_data[playermodel.items[arg_101_1].itemid]["upstar_" .. playermodel.items[arg_101_1].horcrux_attr.star + 1 .. "_need_other"] then
		local var_101_2 = 0

		for iter_101_4, iter_101_5 in pairs(arg_101_2) do
			if var_101_2 < item_data[playermodel.items[arg_101_1].itemid]["upstar_" .. playermodel.items[arg_101_1].horcrux_attr.star + 1 .. "_need_other"] and not var_101_0[iter_101_5] and playermodel.items[iter_101_5].horcrux_attr.star >= playermodel.items[arg_101_1].horcrux_attr.star and (item_data[playermodel.items[iter_101_5].itemid].attr == item_data[playermodel.items[arg_101_1].itemid].attr or item_data[playermodel.items[iter_101_5].itemid].attr == 6) then
				var_101_2 = var_101_2 + 1
				var_101_0[iter_101_5] = true
			end
		end

		if var_101_2 < item_data[playermodel.items[arg_101_1].itemid]["upstar_" .. playermodel.items[arg_101_1].horcrux_attr.star + 1 .. "_need_other"] then
			if arg_101_3 then
				arg_101_3({
					result = 5
				})
			end

			return
		end
	end

	network:rpc("horcrux_upstar", {
		entityid = arg_101_1,
		consumes = arg_101_2
	}, function(arg_102_0)
		if arg_102_0.result == 1 then
			playermodel.items[arg_101_1].horcrux_attr.star = arg_102_0.item.horcrux_attr.star

			for iter_102_0, iter_102_1 in pairs(arg_102_0.consumes) do
				item_manager:deleteItem(iter_102_1)
			end

			sendNotification("HorcruxUpStarSucceeded", {
				entityid = arg_101_1
			})
		elseif arg_102_0.result == 8 then
			global_ShowBlockWords("材料魂器处于抢位赛编队中，操作无效")
		end

		if arg_101_3 then
			arg_101_3(arg_102_0)
		end
	end)
end

function var_0_0:get_max_upstar(arg_103_1)
	return item_data[self:getHorcruxItemid(arg_103_1)].max_star or 2
end

function var_0_0:get_max_level(arg_104_1)
	local var_104_0 = self:getHorcruxStarLevel(arg_104_1)
	local var_104_1 = 0

	for iter_104_0, iter_104_1 in pairs(horcrux_strength_data) do
		if var_104_0 >= iter_104_1.starlimit then
			var_104_1 = iter_104_0
		else
			break
		end
	end

	return var_104_1
end

function var_0_0.get_max_level_with_star(arg_105_0, arg_105_1)
	local var_105_0 = 0

	for iter_105_0, iter_105_1 in pairs(horcrux_strength_data) do
		if arg_105_1 >= iter_105_1.starlimit then
			var_105_0 = iter_105_0
		else
			break
		end
	end

	return var_105_0
end

function var_0_0.getHorcruxFilterAttr(arg_106_0, arg_106_1)
	return not ({
		wind = 1,
		water = 1,
		positive = 1,
		devil = 1,
		fire = 1,
		light = 1,
		dark = 1,
		imaginary = 1
	})[global_get_model_attr(item_data[arg_106_1].model)] and "other" or var_0_10[arg_106_1].attr
end

function var_0_0.createMaxHorcruxData(arg_107_0, arg_107_1)
	if not arg_107_1 then
		return
	end

	local var_107_0 = item_data[arg_107_1]
	local var_107_1 = item_data[arg_107_1].max_star
	local var_107_3
	local var_107_2

	if not item_data[arg_107_1].max_star then
		var_107_1 = 5

		function var_107_2()
			return #horcrux_break_data
		end

		var_107_3 = {
			itemid = arg_107_1
		}
	end

	var_107_3.hclass = (function()
		local var_108_0 = 1

		while var_107_0[string.format("lv%d_gold", var_108_0)] do
			var_108_0 = var_108_0 + 1
		end

		return var_108_0 - 1
	end)()
	var_107_3.star = var_107_1
	var_107_3.dfac = (function()
		local var_109_0 = ""

		while var_107_0[string.format("fac_range_damage_%d", 1)] do
			var_109_0 = var_107_0[string.format("fac_range_damage_%d", 1)]
		end

		return tonumber(split(var_109_0, ",")[2])
	end)()
	var_107_3.hfac = (function()
		local var_110_0 = ""

		while var_107_0[string.format("fac_range_hp_%d", 1)] do
			var_110_0 = var_107_0[string.format("fac_range_hp_%d", 1)]
		end

		return tonumber(split(var_110_0, ",")[2])
	end)()
	var_107_3.hbreak = var_107_2()
	var_107_3.hlv = (function()
		local var_112_0 = 1

		for iter_112_0, iter_112_1 in pairs(horcrux_strength_data) do
			if iter_112_1.starlimit == var_107_1 then
				var_112_0 = math.max(var_112_0, iter_112_1.level)
			end
		end

		return math.min(var_112_0, (var_107_2() + 1) * 10)
	end)()

	return var_107_3
end

function var_0_0:calculateHorcruxScore(arg_113_1, arg_113_2)
	local var_113_0 = self:getHorcruxAssistConfig(arg_113_1)
	local var_113_1 = servant_data[arg_113_2]
	local var_113_2 = item_data[playermodel.items[arg_113_1].itemid]
	local var_113_3 = 1.25

	for iter_113_0, iter_113_1 in pairs(ATTR_ID) do
		if model_data[servant_data[arg_113_2].modelid][iter_113_1] then
			if eat_horcrux_ele_data[iter_113_0] and eat_horcrux_ele_data[iter_113_0][ATTR_ID[item_data[playermodel.items[arg_113_1].itemid].attr]] then
				var_113_3 = 1.5

				break
			end
		end
	end

	var_113_3 = (model_data[servant_data[arg_113_2].modelid].zerosupperession or model_data[servant_data[arg_113_2].modelid].imaginary) and 1.5

	local var_113_4 = HORCRUX_SCORE_CAREER_ADD[model_data[servant_data[arg_113_2].modelid].career]
	local var_113_5

	if not HORCRUX_SCORE_CAREER_ADD[model_data[servant_data[arg_113_2].modelid].career] then
		var_113_4 = HORCRUX_SCORE_CAREER_ADD.other
		var_113_5 = var_113_0.damage * var_113_4.damage * var_113_3 + 0.05 * (var_113_0.hp * var_113_4.hp * var_113_3)
	end

	return var_113_5 * (1 + (var_113_1.race1 == var_113_2.race and 0.03 or 0))
end

return var_0_0
