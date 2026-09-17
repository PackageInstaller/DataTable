local var_0_0 = {}
local major_factor_data = require("data.major_factor_data")
local servant_data = require("data.servant_data")
local model_data = require("data.model_data")
local item_data = require("data.item_data")
local total_skill_data = require("data.total_skill_data")
local core_manager = require("controller.core_manager")
local goodwell_manager = require("controller.goodwell_manager")
local playermodel = require("model.playermodel")
local souls_manager = require("controller.souls_manager")
local weapon_manager = require("controller.weapon_manager")

function var_0_0:init()
	self.major = nil
	self.majorAttr = nil
	self.contract = 0
	self.classtype = nil
	self.cfg = ""
	self.spinecfg = ""
	self.spinemodel = ""
	self.clothesmodel = nil
	self.mainattr = ""
	self.passiveskill = nil
	self.skills = {}
	self.modelid = nil
	self.tenacity = 0
	self.range = 0
	self.xpcd = 0
	self.cd_minus = 0
	self.cd_minus_const = 0
	self.xpdistance = 320
	self.rage = 0
	self.maxrage = 100
	self.rage_recover_speed = 0
	self.model_scale = 1
	self.model_weight = 0
	self.model_height = 0
	self.model_flip = 1
	self.career = ""
	self.hatred_tank = 0
	self.hatred_shooter = 0
	self.hatred_support = 0
	self.hatred_fighter = 0
	self.hatred_assassin = 0
	self.hatred_witcher = 0
	self.initialhp = 0
	self.initialdamage = 0

	self:initFightModel()
end

function var_0_0:initFightModel()
	self.science_point = 0
	self.damageFactor = 0
	self.hpFactor = 0
	self.spellFactor = 0
	self.wind = 0
	self.fire = 0
	self.water = 0
	self.light = 0
	self.dark = 0
	self.hp = 0
	self.damage = 0
	self.spellpower = 0
	self.attackspeed = 0
	self.movingspeed = 0
	self.curhp = 0
	self.healrate = 0
	self.healconst = 0
	self.hpcount = 1
	self.curhpcount = 1
	self.singlehp = 0
	self.equipsinglehp = 0
	self.defence = 0
	self.critical = 0
	self.dodge = 0
	self.strike = 0
	self.healpoint = 0
	self.energydefence = 0
	self.pierce = 0
	self.energypierce = 0
	self.piercepercent = 0
	self.energypiercepercent = 0
	self.force = 0
	self.reforce = 0
	self.hematophagy = 0
	self.blind = 0
	self.exe_critical = 0
	self.exe_dodge = 0
	self.exe_strike = 0
	self.cri_damage_add = 1
	self.dodge_damage_add = 0.5
	self.strike_damage_add = 0.5
	self.defence_rate = 0
	self.cri_rate = 0
	self.strike_rate = 0
	self.energydefence_rate = 0
	self.extra_attack = 0
	self.extra_defence = 0
	self.extra_injure = 0
	self.extra_weak = 0
	self.extra_attackspeed = 0
	self.extra_heal = 0
	self.extra_heal_extern = 0
	self.extra_attack_const = 0
	self.extra_defence_const = 0
	self.extra_heal_const = 0
	self.extra_mechanical_attack = 0
	self.extra_mechanical_defence = 0
	self.extra_mechanical_weak = 0
	self.extra_mechanical_injure = 0
	self.extra_mechanical_attackconst = 0
	self.extra_mechanical_defenceconst = 0
	self.extra_energy_attack = 0
	self.extra_energy_defence = 0
	self.extra_energy_weak = 0
	self.extra_energy_injure = 0
	self.extra_energy_attackconst = 0
	self.extra_energy_defenceconst = 0
	self.extra_attack_rage = 0
	self.extra_attack_rage_const = 0
	self.extra_skill_rage = 0
	self.extra_skill_rage_const = 0
	self.extra_recovery_rage = 0
	self.extra_recovery_rage_const = 0
	self.extra_rage = 0
	self.extra_rage_const = 0
	self.max_taken_damage = 0
	self.skill_cd_count_minus = 0
	self.critical_resistance = 0
	self.exe_strike_resistance = 0
	self.energy_attack_resistance = 0
	self.mechanical_attack_resistance = 0
	self.max_cause_damage = 0
	self.max_cause_damage_holy = 0
	self.max_cause_damage_mechanical = 0
	self.max_cause_damage_energy = 0
	self.maxattackspeedlimit = 0
	self.minattackspeedlimit = 0
	self.cur_locked_attackspeed = 0

	self:initBasicAttributes()
end

local var_0_11 = {
	"hp",
	"damage",
	"spellpower",
	"attackspeed",
	"movingspeed",
	"healrate",
	"healconst",
	"defence",
	"critical",
	"dodge",
	"strike",
	"healpoint",
	"energydefence",
	"force",
	"reforce",
	"hematophagy",
	"blind",
	"cri_damage_add",
	"dodge_damage_add",
	"strike_damage_add",
	"defence_rate",
	"cri_rate",
	"strike_rate",
	"energydefence_rate",
	"extra_attack",
	"extra_defence",
	"extra_injure",
	"extra_weak",
	"extra_attackspeed",
	"extra_heal",
	"extra_attack_const",
	"extra_defence_const",
	"extra_heal_const",
	"extra_mechanical_attack",
	"extra_mechanical_defence",
	"extra_mechanical_weak",
	"extra_mechanical_injure",
	"extra_mechanical_attackconst",
	"extra_mechanical_defenceconst",
	"extra_energy_attack",
	"extra_energy_defence",
	"extra_energy_weak",
	"extra_energy_injure",
	"extra_energy_attackconst",
	"extra_energy_defenceconst",
	"extra_rage",
	"extra_rage_const",
	"range",
	"extra_heal_extern",
	"singlehp",
	"pierce",
	"energypierce",
	"piercepercent",
	"energypiercepercent",
	"max_taken_damage",
	"critical_resistance",
	"exe_strike_resistance",
	"energy_attack_resistance",
	"mechanical_attack_resistance",
	"max_cause_damage",
	"max_cause_damage_holy",
	"max_cause_damage_mechanical",
	"max_cause_damage_energy",
	"maxattackspeedlimit",
	"minattackspeedlimit",
	"cur_locked_attackspeed"
}

function var_0_0:initBasicAttributes()
	self.modelbasicattrs = {}

	for iter_3_0, iter_3_1 in ipairs(var_0_11) do
		self.modelbasicattrs[iter_3_1] = 0
	end

	self.extra_recovery_rage = 0
	self.extra_recovery_rage_const = 0
	self.rage_recover_speed = 0
end

function var_0_0:updateBasicAttributes()
	for iter_4_0, iter_4_1 in ipairs(var_0_11) do
		self.modelbasicattrs[iter_4_1] = self[iter_4_1]
	end
end

function var_0_0:getBasicAttribute(arg_5_1)
	if self.modelbasicattrs[arg_5_1] then
		return self.modelbasicattrs[arg_5_1]
	else
		return self:getAttribute(arg_5_1)
	end
end

function var_0_0:addBasicAttribute(arg_6_1, arg_6_2)
	if self.modelbasicattrs[arg_6_1] then
		self.modelbasicattrs[arg_6_1] = self.modelbasicattrs[arg_6_1] + arg_6_2
	end

	self:addAttribute(arg_6_1, arg_6_2)
end

local var_0_12 = {
	extra_weak = 0,
	extra_attackspeed = 0,
	extra_energy_defenceconst = 0,
	extra_defence = 0,
	extra_injure = 0,
	extra_mechanical_attackconst = 0,
	dodge = 0,
	strike_damage_add = 0,
	critical = 0,
	extra_mechanical_injure = 0,
	dodge_damage_add = 0,
	extra_mechanical_defenceconst = 0,
	extra_energy_attack = 0,
	extra_attack_rage_const = 0,
	healpoint = 0,
	exe_strike_resistance = 0,
	defence = 0,
	strike_rate = 0,
	damage = 0,
	energydefence_rate = 0,
	cri_rate = 0,
	energydefence = 0,
	strike = 0,
	extra_energy_defence = 0,
	extra_energy_attackconst = 0,
	exe_critical = 0,
	movingspeed = 0,
	spellpower = 0,
	force = 0,
	extra_skill_rage = 0,
	extra_recovery_rage_const = 0,
	pierce = 0,
	extra_attack = 0,
	extra_energy_weak = 0,
	reforce = 0,
	energypierce = 0,
	exe_dodge = 0,
	piercepercent = 0,
	energypiercepercent = 0,
	attackspeed = 0,
	cri_damage_add = 0,
	healconst = 0,
	exe_strike = 0,
	extra_mechanical_defence = 0,
	defence_rate = 0,
	extra_defence_const = 0,
	energy_attack_resistance = 0,
	mechanical_attack_resistance = 0,
	extra_recovery_rage = 0,
	extra_attack_rage = 0,
	extra_attack_const = 0,
	healrate = 0,
	extra_heal_const = 0,
	extra_heal_extern = 0,
	blind = 0,
	extra_mechanical_weak = 0,
	extra_energy_injure = 0,
	extra_heal = 0,
	extra_skill_rage_const = 0,
	extra_mechanical_attack = 0,
	critical_resistance = 0
}

function var_0_0.initExternModel(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(var_0_12) do
		arg_7_0[iter_7_0] = iter_7_1
	end
end

function var_0_0:refreshExternModel()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs(var_0_12) do
		if self[iter_8_0] ~= iter_8_1 then
			self[iter_8_0] = iter_8_1

			table.insert(var_8_0, iter_8_0)
		end
	end

	return var_8_0
end

function var_0_0.isAttributeIncludeExtern(arg_9_0, arg_9_1)
	return var_0_12[arg_9_1] ~= nil
end

function var_0_0:setAttribute(arg_10_1, arg_10_2)
	self[arg_10_1] = arg_10_2
	self[arg_10_1 .. "_confusion_1"] = arg_10_2
	self[arg_10_1 .. "_confusion_2"] = arg_10_2
	self[arg_10_1 .. "_confusion_3"] = arg_10_2
	self[arg_10_1 .. "_confusion_4"] = arg_10_2
	self[arg_10_1 .. "_confusion_5"] = arg_10_2

	if arg_10_1 == "hp" then
		self:setAttribute("singlehp", math.floor(arg_10_2 / self.hpcount))
	end
end

function var_0_0:addAttribute(arg_11_1, arg_11_2)
	assert(type(self[arg_11_1]) == "number", "addAttribute " .. arg_11_1 .. " recommand a number param!")

	self[arg_11_1] = self[arg_11_1] + arg_11_2
	self[arg_11_1 .. "_confusion_1"] = self[arg_11_1 .. "_confusion_1"] or 0 + arg_11_2
	self[arg_11_1 .. "_confusion_2"] = self[arg_11_1 .. "_confusion_2"] or 0 + arg_11_2
	self[arg_11_1 .. "_confusion_3"] = self[arg_11_1 .. "_confusion_3"] or 0 + arg_11_2
	self[arg_11_1 .. "_confusion_4"] = self[arg_11_1 .. "_confusion_4"] or 0 + arg_11_2
	self[arg_11_1 .. "_confusion_5"] = self[arg_11_1 .. "_confusion_5"] or 0 + arg_11_2
end

function var_0_0:getAttribute(arg_12_1)
	return self[arg_12_1]
end

function var_0_0.setFactorAttribute(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0[arg_13_1 .. "_confusion_1"] = arg_13_2 - 100
	arg_13_0[arg_13_1 .. "_confusion_2"] = arg_13_2 - 50
	arg_13_0[arg_13_1 .. "_confusion_3"] = arg_13_2 - 20
	arg_13_0[arg_13_1 .. "_confusion_4"] = arg_13_2 + 20
	arg_13_0[arg_13_1 .. "_confusion_5"] = arg_13_2 + 50
	arg_13_0[arg_13_1 .. "_confusion_6"] = arg_13_2 + 100
end

function var_0_0:getFactorAttribute(arg_14_1)
	local var_14_0 = 0

	for iter_14_0 = 1, 6 do
		var_14_0 = var_14_0 + self[arg_14_1 .. "_confusion_" .. iter_14_0]
	end

	return var_14_0 / 6
end

local function var_0_13(arg_15_0, arg_15_1)
	if arg_15_0 % arg_15_1 > 0 then
		return arg_15_0 % arg_15_1
	else
		return arg_15_1
	end
end

local function var_0_14(arg_16_0, arg_16_1)
	local var_16_0 = math.floor(arg_16_0 / arg_16_1)

	if arg_16_0 % arg_16_1 == 0 then
		return var_16_0
	else
		return var_16_0 + 1
	end
end

function var_0_0:getInitialHp()
	return self.initialhp
end

function var_0_0:getInitialDamage()
	return self.initialdamage
end

function var_0_0:initCharacterAttribute(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	assert(arg_19_1, "monster is nil: " .. arg_19_2)

	local monster_weapon_data = require("data.monster_weapon_data")

	self.modelid = arg_19_1.modelid
	self.origin_modelid = self.modelid
	self.oc_modelid = self.modelid
	self.monsterid = arg_19_2
	self.contract = arg_19_1.contract or 0
	self.passiveLevel = arg_19_1.passiveLevel or 0
	self.skill1Level = arg_19_1.skill1Level or 0
	self.monsterlevel = arg_19_1.level
	self.iscaptainmonster = arg_19_3 and arg_19_1.showcaptainhp ~= nil
	self.servantrank = 0
	self.overclockRank = 0
	self.ai_monster_level = arg_19_1.ai_monster_level
	self.classtype = 3
	self.science_point = arg_19_1.science_point or math.round(arg_19_1.damage_point)

	self:initModelData()
	self:calculateBattleAttr()

	for iter_19_0, iter_19_1 in pairs(FIGHT_ATTR_INFO) do
		if iter_19_0 == "damage" then
			self.damage = self.damage * (1 + (arg_19_1.damage_percent or 0)) + (arg_19_1.damage or 0)
		elseif iter_19_0 == "hp" then
			self.hp = self.hp * (1 + (arg_19_1.hp_percent or 0)) + (arg_19_1.hp or 0)
		elseif iter_19_0 == "spellpower" then
			self.spellpower = self.spellpower * (1 + (arg_19_1.spellpower_percent or 0)) + (arg_19_1.spellpower or 0)
		elseif iter_19_0 ~= "damage_percent" and iter_19_0 ~= "hp_percent" and iter_19_0 ~= "spellpower_percent" then
			self[iter_19_0] = self[iter_19_0] + (arg_19_1[iter_19_0] or 0)
		end
	end

	self.hpcount = arg_19_1.hpcount or 1
	self.singlehp = math.floor(self.hp / self.hpcount)

	self:updateBasicAttributes()

	self.curhp = arg_19_4 and var_0_13(arg_19_4, self.singlehp) or self.singlehp
	self.curhpcount = arg_19_4 and var_0_14(arg_19_4, self.singlehp) or self.hpcount
	self.teamskill = {}
end

function var_0_0:initTowerBaseAttribute(arg_20_1, arg_20_2)
	assert(arg_20_1, "Tower baseid is nil: " .. arg_20_2)

	local monster_weapon_data = require("data.monster_weapon_data")

	self.modelid = arg_20_1.modelid
	self.origin_modelid = self.modelid
	self.oc_modelid = self.modelid
	self.baseid = arg_20_2
	self.contract = arg_20_1.contract or 0
	self.passiveLevel = arg_20_1.passiveLevel or 0
	self.skill1Level = arg_20_1.skill1Level or 0
	self.monsterlevel = arg_20_1.level
	self.iscaptainmonster = checkcaptain and arg_20_1.showcaptainhp ~= nil
	self.servantrank = 0
	self.overclockRank = 0
	self.ai_monster_level = arg_20_1.ai_monster_level
	self.classtype = 3
	self.science_point = arg_20_1.science_point or math.round(arg_20_1.damage_point)

	self:initModelData()
	self:calculateBattleAttr()

	local var_20_1, var_20_2 = self:getEnemyConfByPlayerLv(arg_20_1)

	for iter_20_0, iter_20_1 in pairs(FIGHT_ATTR_INFO) do
		if iter_20_0 == "damage" then
			self.damage = self.damage * (1 + (arg_20_1.damage_percent or 0)) + (var_20_1 or 0)
		elseif iter_20_0 == "hp" then
			self.hp = self.hp * (1 + (arg_20_1.hp_percent or 0)) + (var_20_2 or 0)
		elseif iter_20_0 == "spellpower" then
			self.spellpower = self.spellpower * (1 + (arg_20_1.spellpower_percent or 0)) + (arg_20_1.spellpower or 0)
		elseif iter_20_0 ~= "damage_percent" and iter_20_0 ~= "hp_percent" and iter_20_0 ~= "spellpower_percent" then
			self[iter_20_0] = self[iter_20_0] + (arg_20_1[iter_20_0] or 0)
		end
	end

	self.hpcount = arg_20_1.hpcount or 1
	self.singlehp = math.floor(self.hp / self.hpcount)

	self:updateBasicAttributes()

	self.curhp = specialhp and var_0_13(specialhp, self.singlehp) or self.singlehp
	self.curhpcount = specialhp and var_0_14(specialhp, self.singlehp) or self.hpcount
	self.teamskill = {}
end

function var_0_0:initTowerEnemyAttribute(arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	assert(arg_21_1, "monster is nil: " .. arg_21_2)

	local monster_weapon_data = require("data.monster_weapon_data")

	self.modelid = arg_21_1.modelid
	self.origin_modelid = self.modelid
	self.oc_modelid = self.modelid
	self.monsterid = arg_21_2
	self.contract = arg_21_1.contract or 0
	self.passiveLevel = arg_21_1.passiveLevel or 0
	self.skill1Level = arg_21_1.skill1Level or 0
	self.monsterlevel = arg_21_1.level
	self.iscaptainmonster = arg_21_3 and arg_21_1.showcaptainhp ~= nil
	self.servantrank = 0
	self.overclockRank = 0
	self.ai_monster_level = arg_21_1.ai_monster_level
	self.classtype = 3
	self.science_point = arg_21_1.science_point or math.round(arg_21_1.damage_point)

	self:initModelData()
	self:calculateBattleAttr()

	local var_21_1, var_21_2 = self:getEnemyConfByPlayerLv(arg_21_1)

	for iter_21_0, iter_21_1 in pairs(FIGHT_ATTR_INFO) do
		if iter_21_0 == "damage" then
			self.damage = self.damage * (1 + (arg_21_1.damage_percent or 0)) + (var_21_1 or 0)
		elseif iter_21_0 == "hp" then
			self.hp = self.hp * (1 + (arg_21_1.hp_percent or 0)) + (var_21_2 or 0)
		elseif iter_21_0 == "spellpower" then
			self.spellpower = self.spellpower * (1 + (arg_21_1.spellpower_percent or 0)) + (arg_21_1.spellpower or 0)
		elseif iter_21_0 ~= "damage_percent" and iter_21_0 ~= "hp_percent" and iter_21_0 ~= "spellpower_percent" then
			self[iter_21_0] = self[iter_21_0] + (arg_21_1[iter_21_0] or 0)
		end
	end

	self.hpcount = arg_21_1.hpcount or 1
	self.singlehp = math.floor(self.hp / self.hpcount)

	self:updateBasicAttributes()

	self.curhp = arg_21_4 and var_0_13(arg_21_4, self.singlehp) or self.singlehp
	self.curhpcount = arg_21_4 and var_0_14(arg_21_4, self.singlehp) or self.hpcount
	self.teamskill = {}
end

function var_0_0.getEnemyConfByPlayerLv(arg_22_0, arg_22_1)
	local var_22_0 = {}
	local var_22_1 = {}

	for iter_22_0, iter_22_1 in pairs(arg_22_1) do
		if iter_22_0:find("damage_%d+") then
			table.insert(var_22_0, {
				lv = tonumber((string.match(iter_22_0, "%d+"))),
				value = iter_22_1
			})
		elseif iter_22_0:find("hp_%d+") then
			table.insert(var_22_1, {
				lv = tonumber((string.match(iter_22_0, "%d+"))),
				value = iter_22_1
			})
		end
	end

	table.sort(var_22_0, function(arg_23_0, arg_23_1)
		return arg_23_0.lv < arg_23_1.lv
	end)
	table.sort(var_22_1, function(arg_24_0, arg_24_1)
		return arg_24_0.lv < arg_24_1.lv
	end)

	local var_22_2
	local var_22_3

	for iter_22_2, iter_22_3 in ipairs(var_22_0) do
		if playermodel.grade <= iter_22_3.lv then
			var_22_2 = iter_22_3.value

			break
		end
	end

	for iter_22_4, iter_22_5 in ipairs(var_22_1) do
		if playermodel.grade <= iter_22_5.lv then
			var_22_3 = iter_22_5.value

			break
		end
	end

	var_22_2 = var_22_2 or arg_22_1.damage
	var_22_3 = var_22_3 or arg_22_1.hp

	return var_22_2, var_22_3
end

local function var_0_15(arg_25_0)
	return servant_data[arg_25_0].modelid
end

function var_0_0:initPlayerAttribute(arg_26_1, arg_26_2, arg_26_3)
	local playermodel = require("model.playermodel")

	self.servantid = arg_26_1
	self.soulid = servant_data[arg_26_1].major
	self.contract = playermodel.soulContract[arg_26_1]
	self.passiveLevel = playermodel.passiveLevel[arg_26_1] or 0
	self.skill1Level = playermodel.skill1Level[arg_26_1] or 0
	self.servantrank = core_manager:getServantCoreRank(arg_26_1)
	self.overclockRank = servant_data[arg_26_1].oc_isopen1 == 1 and (playermodel.soulOverClock[arg_26_1] or 0) or 0
	self.classtype = 1
	self.modelid = global_get_servant_skin(arg_26_1, arg_26_3)
	self.origin_modelid = var_0_15(arg_26_1)
	self.oc_modelid = servant_data[arg_26_1].model_oc

	local var_26_1 = core_manager:getStrengthenValue(self.servantid, playermodel.cores[arg_26_1].coreid, core_manager:getCoreLv(arg_26_1))

	self.basicmodel = {
		science_point = var_26_1
	}
	self.science_point = arg_26_2 or var_26_1
	self.damageFacPlus = souls_manager:get_add_damage_factor(arg_26_1) + (servant_data[arg_26_1]["damageOverPlus" .. self.overclockRank] or 0)
	self.hpFacPlus = souls_manager:get_add_hp_factor(arg_26_1) + (servant_data[arg_26_1]["hpOverPlus" .. self.overclockRank] or 0)

	self:initModelData()
	self:calculateBattleAttr()
	self:initAssistAttr()
	self:initComponentAttr()
	self:initWeaponAttr()

	self.hpcount = servant_data[arg_26_1].hpcount or 1
	self.curhpcount = self.hpcount
	self.singlehp = math.floor(self.hp / self.hpcount)
	self._returnBuffHp = self._returnBuffHp or 1
	self._returnBuffDamage = self._returnBuffHp or 1
	self.hp = self.hp * self._returnBuffHp
	self.damage = self.damage * self._returnBuffDamage
	self.singlehp = math.floor(self.hp / (self.hpcount or 1))
	self.curhp = self.singlehp

	self:updateBasicAttributes()

	self.hp = self.hp + math.round(self:getBasicAttribute("hp") * goodwell_manager:getFavorHp(self.soulid))
	self.damage = self.damage + math.round(self:getBasicAttribute("damage") * goodwell_manager:getFavorDamage(self.soulid))
	self.hp = self.hp + math.round(self:getBasicAttribute("hp") * CONTRACT_ATTR_ADD * souls_manager:get_total_contract_attr())
	self.damage = self.damage + math.round(self:getBasicAttribute("damage") * CONTRACT_ATTR_ADD * souls_manager:get_total_contract_attr())
	self.singlehp = math.floor(self.hp / self.hpcount)
	self.curhp = self.singlehp
	self.teamskill = {}
end

function var_0_0:initPvpAttribute(arg_27_1)
	if servant_data[arg_27_1.servantid] then
		self.modelid = global_get_servant_skin(arg_27_1.servantid, arg_27_1.servantskin or -1) or arg_27_1.modelid
	end

	self.origin_modelid = servant_data[arg_27_1.servantid] and var_0_15(arg_27_1.servantid) or arg_27_1.modelid

	if arg_27_1.servantid then
		self.oc_modelid = servant_data[arg_27_1.servantid].model_oc or self.origin_modelid
	end

	self.servantid = arg_27_1.servantid
	self.soulid = arg_27_1.soulid
	self.contract = arg_27_1.contract
	self.passiveLevel = arg_27_1.passiveLevel or 0
	self.skill1Level = arg_27_1.skill1Level or 0
	self.servantrank = arg_27_1.servantrank or 0
	self.overclockRank = arg_27_1.overclock or 0
	self.addRollRarity = arg_27_1.addRollRarity or 0
	self.classtype = 2
	self.science_point = arg_27_1.science_point or arg_27_1.damage_point

	local var_27_2 = souls_manager:get_roll_rarity_str(self.servantid, self.addRollRarity)

	self.damageFacPlus = souls_manager:get_add_damage_factor_for_pvp(self.servantid, self.contract, self.addRollRarity) + (servant_data[self.servantid]["damageOverPlus" .. self.overclockRank] or 0)
	self.hpFacPlus = souls_manager:get_add_hp_factor_for_pvp(self.servantid, self.contract, self.addRollRarity) + (servant_data[self.servantid]["hpOverPlus" .. self.overclockRank] or 0)
	self.wind = arg_27_1.wind or 0
	self.fire = arg_27_1.fire or 0
	self.water = arg_27_1.water or 0
	self.light = arg_27_1.light or 0
	self.dark = arg_27_1.dark or 0
	self.defence = arg_27_1.defence or 0
	self.energydefence = arg_27_1.energydefence or 0
	self.critical = arg_27_1.critical or 0
	self.dodge = arg_27_1.dodge or 0
	self.strike = arg_27_1.strike or 0
	self.spellpower = arg_27_1.spellpower or 0

	self:initModelData()
	self:calculateBattleAttr()
	self:initAssistAttr()
	self:initComponentAttr()
	self:initWeaponAttr()

	if servant_data[self.servantid] then
		self.hpcount = servant_data[self.servantid].hpcount or 1
	end

	self.curhpcount = self.hpcount
	self.singlehp = math.floor(self.hp / self.hpcount)

	self:updateBasicAttributes()

	self.hp = self.hp + math.round(self:getBasicAttribute("hp") * goodwell_manager:getFavorHpByLv(arg_27_1.favorlevel or 0))
	self.damage = self.damage + math.round(self:getBasicAttribute("damage") * goodwell_manager:getFavorDamageByLv(arg_27_1.favorlevel or 0))

	if arg_27_1.star then
		print("总共振星级加成:", arg_27_1.star)

		self.hp = self.hp + math.round(self:getBasicAttribute("hp") * CONTRACT_ATTR_ADD * arg_27_1.star)
		self.damage = self.damage + math.round(self:getBasicAttribute("damage") * CONTRACT_ATTR_ADD * arg_27_1.star)
	end

	self.singlehp = math.floor(self.hp / self.hpcount)
	self.curhp = self.singlehp
	self.teamskill = {}
end

function var_0_0:initDevCharacterAttribute(arg_28_1)
	self.modelid = arg_28_1.modelid

	if not arg_28_1.servantid then
		for iter_28_0, iter_28_1 in pairs(servant_data) do
			if iter_28_1.classtype == 1 then
				if iter_28_1.modelid == self.modelid then
					arg_28_1.servantid = iter_28_1.id
				else
					local var_28_0 = 1

					while iter_28_1["modelid" .. var_28_0] do
						if iter_28_1["modelid" .. var_28_0] == self.modelid then
							arg_28_1.servantid = iter_28_1.id
						end

						var_28_0 = var_28_0 + 1
					end
				end

				if iter_28_1.model_oc == self.modelid then
					arg_28_1.servantid = iter_28_1.id
				end
			end
		end
	end

	self.origin_modelid = self.modelid
	self.oc_modelid = servant_data[arg_28_1.servantid] and servant_data[arg_28_1.servantid].model_oc
	self.servantid = arg_28_1.servantid
	self.soulid = arg_28_1.soulid
	self.contract = arg_28_1.contract
	self.passiveLevel = arg_28_1.passiveLevel or 0
	self.skill1Level = arg_28_1.skill1Level or 0
	self.servantrank = arg_28_1.servantrank or 0
	self.overclockRank = arg_28_1.overclockRank or 0
	self.classtype = 2
	self.science_point = arg_28_1.science_point or arg_28_1.damage_point
	self.damageFacPlus = 0
	self.hpFactorPlus = 0
	self.wind = arg_28_1.wind or 0
	self.fire = arg_28_1.fire or 0
	self.water = arg_28_1.water or 0
	self.light = arg_28_1.light or 0
	self.dark = arg_28_1.dark or 0
	self.defence = arg_28_1.defence or 0
	self.energydefence = arg_28_1.energydefence or 0
	self.critical = arg_28_1.critical or 0
	self.dodge = arg_28_1.dodge or 0
	self.strike = arg_28_1.strike or 0
	self.spellpower = arg_28_1.spellpower or 0
	self.extra_heal_extern = arg_28_1.extra_heal_extern or 0

	self:initModelData()

	self.hpcount = 1
	self.curhpcount = self.hpcount
	self.singlehp = math.floor(self.hp / self.hpcount)

	self:updateBasicAttributes()
	self:setFightDebugData(arg_28_1)
	self:calculateBattleAttr()
	self:initAssistAttr()
	self:initComponentAttr()
	self:initWeaponAttr()

	self.curhp = self.singlehp
	self.teamskill = {}
end

function var_0_0:initModelData()
	local var_29_0 = model_data[self.modelid]
	local var_29_1 = model_data[self.origin_modelid]

	if self.overclockRank > 0 then
		self.cfg = "fight.behavior." .. model_data[self.oc_modelid].behavior or "fight.behavior." .. var_29_0.behavior
	end

	self.spinecfg = "fight.spine." .. var_29_0.spinecfg
	self.spinemodel = var_29_0.spine_model
	self.clothesmodel = var_29_0.clothes_model
	self.changeslot = var_29_0.changeslot
	self.changeattachment = var_29_0.changeattachment
	self.changetexture = var_29_0.changetexture
	self.model_weight = var_29_0.modelweight
	self.model_height = var_29_0.modelheight
	self.model_scale = var_29_0.modelscale or 1
	self.model_flip = var_29_0.modelflip or 1
	self.headimg = var_29_0.head_image
	self.name = var_29_0.name
	self.cuteQ = var_29_0.cute_Q
	self.modeltype = var_29_0.modeltype

	self:setFactorAttribute("hpFactor", var_29_1.hpFactor + (self.hpFacPlus or 0))
	self:setFactorAttribute("damageFactor", var_29_1.damageFactor + (self.damageFacPlus or 0))
	self:setFactorAttribute("spellFactor", var_29_1.spellFactor or 0)

	self.hp = math.round(self.science_point * self:getFactorAttribute("hpFactor"))
	self.damage = math.round(self.science_point * self:getFactorAttribute("damageFactor"))
	self.initialhp = self.hp
	self.initialdamage = self.damage
	self.spellpower = self.spellpower + (var_29_1.spellpower or 0)

	self:setAttribute("attackspeed", var_29_1.attackspeed)

	self.movingspeed = var_29_1.movingspeed
	self.force = self.force + (var_29_1.force or 0)
	self.reforce = self.reforce + (var_29_1.reforce or 0)
	self.defence = self.defence + (var_29_1.defence or 0)
	self.energydefence = self.energydefence + (var_29_1.energydefence or 0)
	self.critical = self.critical + (var_29_1.critical or 0)
	self.dodge = self.dodge + (var_29_1.dodge or 0)
	self.strike = self.strike + (var_29_1.strike or 0)
	self.tenacity = self.tenacity + (var_29_1.tenacity or 0)
	self.healrate = self.healrate + (var_29_1.healrate or 0)
	self.maxrage = var_29_1.maxrage or 100
	self.attack_rage_fac = var_29_1.attack_rage_fac or ATTACK_RAGE_FAC
	self.hitted_rage_fac = var_29_1.hitted_rage_fac or HITTED_RAGE_FAC
	self.heal_rage_fac = var_29_1.heal_rage_fac or HEAL_RAGE_FAC
	self.rage_on_kill = var_29_1.rage_on_kill or RAGE_ON_KILL
	self.rage_recover_speed = var_29_1.rage_recover_speed or RAGE_RECOVER_SPEED
	self.passiveskill = var_29_1["passive" .. self.passiveLevel] or var_29_1.passive
	self.xpskill = var_29_1.XP
	self.spskill = var_29_1.sp
	self.exskill = var_29_1["ex_" .. (self.servantrank > 3 and 3 or self.servantrank)]
	self.range = var_29_1.range
	self.max_range = var_29_1.max_range

	local var_29_2 = 1

	while var_29_1["skill" .. var_29_2] do
		self.skills[var_29_2] = var_29_1["skill" .. var_29_2]
		var_29_2 = var_29_2 + 1
	end

	self.skills[1] = var_29_1["skill1" .. "_" .. self.skill1Level] or var_29_1.skill1

	if self.overclockRank and self.overclockRank > 0 then
		self.ocskill = var_29_1.over_clocking_skill
		self.oc_active_skills = {}

		local var_29_3 = 1

		while var_29_1["over_clocking_active_skill" .. var_29_3] do
			self.oc_active_skills[var_29_3] = var_29_1["over_clocking_active_skill" .. var_29_3]
			var_29_3 = var_29_3 + 1
		end
	end

	self.career = var_29_1.career
	self.hatred_tank = var_29_1.hatred_tank
	self.hatred_witcher = var_29_1.hatred_witcher
	self.hatred_assassin = var_29_1.hatred_assassin
	self.hatred_fighter = var_29_1.hatred_fighter
	self.hatred_support = var_29_1.hatred_support
	self.hatred_shooter = var_29_1.hatred_shooter
	self.majorAttr = global_get_model_attr(self.origin_modelid)
	self.allAttrs = global_get_all_model_attrs(self.origin_modelid)
	self.validAttr = {}
	self.validAttr[self.allAttrs.main] = true

	if self.allAttrs.sub then
		for iter_29_0, iter_29_1 in pairs(self.allAttrs.sub) do
			self.validAttr[iter_29_1] = true
		end
	end

	self.imaginaryConvertAttr = {}

	local var_29_4 = 1

	while var_29_1["slave" .. var_29_4] do
		self["slave" .. var_29_4] = var_29_1["slave" .. var_29_4]
		var_29_4 = var_29_4 + 1
	end

	self.upgradeskills = {}

	for iter_29_2 = 1, self.contract do
		if model_data[self.origin_modelid]["upgrade_skill_" .. iter_29_2] then
			table.insert(self.upgradeskills, model_data[self.origin_modelid]["upgrade_skill_" .. iter_29_2])
		end
	end
end

function var_0_0:setFightDebugData(arg_30_1)
	if config._DEVELOP_MODE ~= "FIGHTDEV" then
		return
	end

	self.defence = arg_30_1.defence or self.defence or 0
	self.energydefence = arg_30_1.energydefence or self.energydefence or 0
	self.critical = arg_30_1.critical or self.critical or 0
	self.dodge = arg_30_1.dodge or self.dodge or 0
	self.strike = arg_30_1.strike or self.strike or 0
	self.spellpower = arg_30_1.spellpower or self.spellpower or 0
	self.cri_damage_add = arg_30_1.cri_damage_add or self.cri_damage_add or 1
	self.dodge_damage_add = arg_30_1.dodge_damage_add or self.dodge_damage_add or 0.5
	self.strike_damage_add = arg_30_1.strike_damage_add or self.strike_damage_add or 0.5
	self.attackspeed = arg_30_1.attackspeed or self.attackspeed or 0
	self.extra_attack = arg_30_1.extra_attack or self.extra_attack or 0
	self.extra_defence = arg_30_1.extra_defence or self.extra_defence or 0
	self.range = arg_30_1.range or self.range or 0
	self.movingspeed = arg_30_1.movingspeed or self.movingspeed or 0
	self.force = arg_30_1.force or self.force or 0
	self.reforce = arg_30_1.reforce or self.reforce or 0
	self.hematophagy = arg_30_1.hematophagy or self.hematophagy or 0
	self.healrate = arg_30_1.healrate or self.healrate or 0
	self.maxrage = arg_30_1.maxrage or self.maxrage or 100

	if arg_30_1.hpFactor then
		self:setFactorAttribute("hpFactor", arg_30_1.hpFactor)
	end

	if arg_30_1.damageFactor then
		self:setFactorAttribute("damageFactor", arg_30_1.damageFactor)
	end

	self.damageFacPlus = 0
	self.hpFacPlus = 0

	local var_30_0

	for iter_30_0, iter_30_1 in pairs(servant_data) do
		for iter_30_2, iter_30_3 in pairs(iter_30_1) do
			if arg_30_1.modelid == iter_30_3 then
				var_30_0 = iter_30_1.id
			end
		end
	end

	if var_30_0 and arg_30_1.contract then
		self.damageFacPlus = (servant_data[var_30_0]["damageFactorPlus" .. arg_30_1.contract] or 0) + (servant_data[var_30_0]["damageOverPlus" .. (arg_30_1.overclockRank or 0)] or 0)
		self.hpFacPlus = (servant_data[var_30_0]["hpFactorPlus" .. arg_30_1.contract] or 0) + (servant_data[var_30_0]["hpOverPlus" .. (arg_30_1.overclockRank or 0)] or 0)
	end

	self.hp = math.round(self.science_point * (self:getFactorAttribute("hpFactor") + self.hpFacPlus))
	self.damage = math.round(self.science_point * (self:getFactorAttribute("damageFactor") + self.damageFacPlus))
	self.damage = self.damage * ((arg_30_1.damage_percent or 0) + 1)
	self.hp = self.hp * ((arg_30_1.hp_percent or 0) + 1)
	self.attackspeed = self.attackspeed * ((arg_30_1.extra_attackspeed or 0) + 1)
	self.hp = self.hp + (arg_30_1.extra_hp or 0)
	self.damage = self.damage + (arg_30_1.extra_damage or 0)
	self.hp = self.hp + (arg_30_1.hp or 0)
	self.damage = self.damage + (arg_30_1.damage or 0)
	self.extra_rage = arg_30_1.extra_rage or 0
	self.testSkills = arg_30_1.testSkills or {}
	self.maxrage = arg_30_1.maxrage or self.maxrage or 100
	self.attack_rage_fac = arg_30_1.attack_rage_fac or self.attack_rage_fac or ATTACK_RAGE_FAC
	self.hitted_rage_fac = arg_30_1.hitted_rage_fac or self.hitted_rage_fac or HITTED_RAGE_FAC
	self.rage_on_kill = arg_30_1.rage_on_kill or self.rage_on_kill or RAGE_ON_KILL
	self.heal_rage_fac = arg_30_1.heal_rage_fac or self.heal_rage_fac or HITTED_RAGE_FAC
	self.rage_recover_speed = arg_30_1.rage_recover_speed or self.rage_recover_speed or RAGE_RECOVER_SPEED
end

function var_0_0:calculateBattleAttr()
	self.defence = self.defence + self.wind
	self.critical = self.critical + self.fire
	self.dodge = self.dodge + self.water
	self.strike = self.strike + self.dark
	self.healpoint = self.healpoint + self.light
end

function var_0_0.initAssistAttr(arg_32_0)
	arg_32_0.a_attr = {
		damage = 0,
		hp = 0
	}
end

function var_0_0:initComponentAttr()
	self.origin_damage = self.damage
	self.origin_hp = self.hp
	self.origin_spellpower = self.spellpower
	self.componenteffect = nil
	self.c_attr = {}
	self.c_damage_percent = 0
	self.c_hp_percent = 0

	for iter_33_0, iter_33_1 in pairs(FIGHT_ATTR_INFO) do
		if iter_33_0 ~= "damage_percent" and iter_33_0 ~= "hp_percent" and iter_33_0 ~= "spellpower_percent" and iter_33_0 ~= "science_point" then
			self.c_attr[iter_33_0] = 0
		end
	end
end

function var_0_0:initWeaponAttr()
	self.w_origin_damage = self.damage
	self.w_origin_hp = self.hp
	self.w_origin_spellpower = self.spellpower
	self.w_attr = {}
	self.w_damage_percent = 0
	self.w_hp_percent = 0
	self.w_science_point = 0

	for iter_34_0, iter_34_1 in pairs(FIGHT_ATTR_INFO) do
		if iter_34_0 ~= "damage_percent" and iter_34_0 ~= "hp_percent" and iter_34_0 ~= "spellpower_percent" and iter_34_0 ~= "science_point" then
			self.w_attr[iter_34_0] = 0
		end
	end
end

function var_0_0:updatePlayerModel()
	local var_35_0 = core_manager:getStrengthenValue(self.servantid, require("model.playermodel").cores[self.servantid].coreid, core_manager:getCoreLv(self.servantid))

	self:updateModelSciencePoint(var_35_0 - self.basicmodel.science_point)

	self.basicmodel = {
		science_point = var_35_0
	}
end

function var_0_0:changePlayerWeapon(arg_36_1)
	local playermodel = require("model.playermodel")

	self.modelid = arg_36_1
	self.spinemodel = model_data[self.modelid].spine_model
	self.clothesmodel = model_data[self.modelid].clothes_model
	self.cfg = "fight.behavior." .. model_data[self.modelid].behavior
	self.spinecfg = "fight.spine." .. model_data[self.modelid].spinecfg
	self.model_weight = model_data[self.modelid].modelweight
	self.model_height = model_data[self.modelid].modelheight
	self.model_scale = model_data[self.modelid].modelscale or 1
	self.headimg = model_data[self.modelid].head_image
	self.range = model_data[self.modelid].range
	self.max_range = model_data[self.modelid].max_range
end

function var_0_0.changePlayerClothes(arg_37_0, arg_37_1)
	print("model_manager.changePlayerClothes is deprecated")
end

function var_0_0.changePlayerDress(arg_38_0, arg_38_1)
	print("model_manager.changePlayerDress is deprecated")
end

function var_0_0:updateAssistAttr(arg_39_1)
	self:addAttribute("damage", -self.a_attr.damage)
	self:addAttribute("hp", -self.a_attr.hp)

	self.a_attr.damage = arg_39_1.damage
	self.a_attr.hp = arg_39_1.hp

	self:addAttribute("damage", self.a_attr.damage)
	self:addAttribute("hp", self.a_attr.hp)
end

function var_0_0:updateComponentAttr(arg_40_1)
	local var_40_0 = {}

	for iter_40_0, iter_40_1 in pairs(arg_40_1) do
		if iter_40_0 ~= "effect" and iter_40_0 ~= "reinforce_component" then
			for iter_40_2, iter_40_3 in pairs(iter_40_1.main) do
				var_40_0[iter_40_2] = (var_40_0[iter_40_2] or 0) + iter_40_3
			end

			if iter_40_1.main2 then
				for iter_40_4, iter_40_5 in pairs(iter_40_1.main2) do
					var_40_0[iter_40_4] = (var_40_0[iter_40_4] or 0) + iter_40_5
				end
			end
		end
	end

	local var_40_3 = {}

	for iter_40_6, iter_40_7 in pairs(self.c_attr) do
		if iter_40_6 == "damage" then
			var_40_3.damage = (var_40_0.damage or 0) + math.round((var_40_0.damage_percent or 0) * self.origin_damage) - iter_40_7
			self.c_attr.damage = (var_40_0.damage or 0) + math.round((var_40_0.damage_percent or 0) * self.origin_damage)
		elseif iter_40_6 == "hp" then
			var_40_3.hp = (var_40_0.hp or 0) + math.round((var_40_0.hp_percent or 0) * self.origin_hp) - iter_40_7
			self.c_attr.hp = (var_40_0.hp or 0) + math.round((var_40_0.hp_percent or 0) * self.origin_hp)
		elseif iter_40_6 == "spellpower" then
			var_40_3.spellpower = (var_40_0.spellpower or 0) + math.round((var_40_0.spellpower_percent or 0) * self.origin_spellpower) - iter_40_7
			self.c_attr.spellpower = (var_40_0.spellpower or 0) + math.round((var_40_0.spellpower_percent or 0) * self.origin_spellpower)
		else
			var_40_3[iter_40_6] = (var_40_0[iter_40_6] or 0) - iter_40_7
			self.c_attr[iter_40_6] = var_40_0[iter_40_6] or 0
		end
	end

	self.c_damage_percent = var_40_0.damage_percent or 0
	self.c_hp_percent = var_40_0.hp_percent or 0

	for iter_40_8, iter_40_9 in pairs(var_40_3) do
		if iter_40_9 ~= 0 then
			self:addAttribute(iter_40_8, iter_40_9)
		end
	end
end

function var_0_0:updateHelpBattle(arg_41_1)
	local help_battle_manager = require("controller/help_battle/help_battle_manager")
	local var_41_1 = {}

	for iter_41_0, iter_41_1 in pairs(help_battle_manager.value) do
		var_41_1[iter_41_0] = iter_41_1
	end

	for iter_41_2, iter_41_3 in pairs(help_battle_manager:getInstance():getBonusByList(arg_41_1, self.career).percent) do
		var_41_1[iter_41_2] = var_41_1[iter_41_2] or 0

		if iter_41_2 == "damage" then
			var_41_1[iter_41_2] = var_41_1[iter_41_2] + iter_41_3 * self.origin_damage
		elseif iter_41_2 == "hp" then
			var_41_1[iter_41_2] = var_41_1[iter_41_2] + iter_41_3 * self.origin_hp
		elseif iter_41_2 == "extra_heal_extern" then
			var_41_1[iter_41_2] = var_41_1[iter_41_2]
		end
	end

	for iter_41_4, iter_41_5 in pairs(var_41_1) do
		var_41_1[iter_41_4] = math.round(iter_41_5)
	end

	for iter_41_6, iter_41_7 in pairs(var_41_1) do
		if iter_41_7 ~= 0 then
			self:addAttribute(iter_41_6, iter_41_7)
		end
	end
end

function var_0_0:updateArenaEnemyHelpBattle()
	local help_battle_manager = require("controller/help_battle/help_battle_manager")
	local var_42_1 = {}

	for iter_42_0, iter_42_1 in pairs(help_battle_manager.value) do
		var_42_1[iter_42_0] = iter_42_1
	end

	for iter_42_2, iter_42_3 in pairs(help_battle_manager:getInstance():getArenaEnemyBonus(self.career).percent) do
		var_42_1[iter_42_2] = var_42_1[iter_42_2] or 0

		if iter_42_2 == "damage" then
			var_42_1[iter_42_2] = var_42_1[iter_42_2] + iter_42_3 * self.origin_damage
		elseif iter_42_2 == "hp" then
			var_42_1[iter_42_2] = var_42_1[iter_42_2] + iter_42_3 * self.origin_hp
		elseif iter_42_2 == "extra_heal_extern" then
			var_42_1[iter_42_2] = var_42_1[iter_42_2]
		end
	end

	for iter_42_4, iter_42_5 in pairs(var_42_1) do
		var_42_1[iter_42_4] = math.round(iter_42_5)
	end

	for iter_42_6, iter_42_7 in pairs(var_42_1) do
		if iter_42_7 ~= 0 then
			self:addAttribute(iter_42_6, iter_42_7)
		end
	end
end

function var_0_0:updateWeaponAttr(arg_43_1)
	local var_43_0 = {}

	if arg_43_1 and next(arg_43_1) ~= nil then
		if arg_43_1.sub_attr and next(arg_43_1.sub_attr) then
			for iter_43_0, iter_43_1 in pairs(arg_43_1.sub_attr) do
				var_43_0[iter_43_1.attrtype] = var_43_0[iter_43_1.attrtype] or 0
				var_43_0[iter_43_1.attrtype] = var_43_0[iter_43_1.attrtype] + iter_43_1.value
			end
		end

		var_43_0[arg_43_1.base_attr.attrtype] = var_43_0[arg_43_1.base_attr.attrtype] or 0
		var_43_0[arg_43_1.base_attr.attrtype] = var_43_0[arg_43_1.base_attr.attrtype] + arg_43_1.base_attr.value

		if arg_43_1.main_attr and next(arg_43_1.main_attr) then
			for iter_43_2, iter_43_3 in pairs(arg_43_1.main_attr) do
				for iter_43_4, iter_43_5 in pairs(iter_43_3) do
					var_43_0[iter_43_5.attrtype] = var_43_0[iter_43_5.attrtype] or 0
					var_43_0[iter_43_5.attrtype] = var_43_0[iter_43_5.attrtype] + iter_43_5.value * (ATTR_TRANS_FAC[iter_43_5.attrtype] or 1)
				end
			end
		end
	end

	if var_43_0.science_point and var_43_0.science_point > 0 then
		self:updateModelSciencePoint(var_43_0.science_point - self.w_science_point)

		self.w_science_point = var_43_0.science_point
	end

	local var_43_1 = {}

	for iter_43_6, iter_43_7 in pairs(self.w_attr) do
		if iter_43_6 == "damage" then
			var_43_1.damage = (var_43_0.damage or 0) + math.round((var_43_0.damage_percent or 0) * self.w_origin_damage) - iter_43_7
			self.w_attr.damage = (var_43_0.damage or 0) + math.round((var_43_0.damage_percent or 0) * self.w_origin_damage)
		elseif iter_43_6 == "hp" then
			var_43_1.hp = (var_43_0.hp or 0) + math.round((var_43_0.hp_percent or 0) * self.w_origin_hp) - iter_43_7
			self.w_attr.hp = (var_43_0.hp or 0) + math.round((var_43_0.hp_percent or 0) * self.w_origin_hp)
		elseif iter_43_6 == "spellpower" then
			var_43_1.spellpower = (var_43_0.spellpower or 0) + math.round((var_43_0.spellpower_percent or 0) * self.w_origin_spellpower) - iter_43_7
			self.w_attr.spellpower = (var_43_0.spellpower or 0) + math.round((var_43_0.spellpower_percent or 0) * self.w_origin_spellpower)
		else
			var_43_1[iter_43_6] = (var_43_0[iter_43_6] or 0) - iter_43_7
			self.w_attr[iter_43_6] = var_43_0[iter_43_6] or 0
		end
	end

	self.w_damage_percent = var_43_0.damage_percent or 0
	self.w_hp_percent = var_43_0.hp_percent or 0

	for iter_43_8, iter_43_9 in pairs(var_43_1) do
		if iter_43_9 ~= 0 then
			self:addAttribute(iter_43_8, iter_43_9)
		end
	end

	self.cfg = arg_43_1.behavior and "fight.behavior." .. arg_43_1.behavior or "fight.behavior." .. model_data[self.modelid].behavior
	self.spinecfg = arg_43_1.spinecfg and "fight.spine." .. arg_43_1.spinecfg or "fight.spine." .. model_data[self.modelid].spinecfg
end

function var_0_0:updateModelSciencePoint(arg_44_1)
	self:addAttribute("science_point", arg_44_1)

	local var_44_0 = math.round(self:getFactorAttribute("damageFactor") * arg_44_1)

	self:addBasicAttribute("damage", var_44_0)

	local var_44_1 = math.round(self:getFactorAttribute("hpFactor") * arg_44_1)

	self:addBasicAttribute("hp", var_44_1)
	self:addBasicAttribute("singlehp", math.floor(var_44_1 / self.hpcount))

	self.origin_damage = self:getBasicAttribute("damage")

	local var_44_2 = math.round(var_44_0 * (self.c_damage_percent or 0))

	self.c_attr.damage = self.c_attr.damage + var_44_2

	self:addAttribute("damage", var_44_2)

	self.origin_hp = self:getBasicAttribute("hp")

	local var_44_3 = math.round(var_44_1 * (self.c_hp_percent or 0))

	self.c_attr.hp = self.c_attr.hp + var_44_3

	self:addAttribute("hp", var_44_3)
	self:addAttribute("singlehp", math.floor(var_44_3 / self.hpcount))

	self.w_origin_damage = self:getBasicAttribute("damage")

	local var_44_4 = math.round(var_44_0 * (self.w_damage_percent or 0))

	self.w_attr.damage = self.w_attr.damage + var_44_4

	self:addAttribute("damage", var_44_4)

	self.w_origin_hp = self:getBasicAttribute("hp")

	local var_44_5 = math.round(var_44_1 * (self.w_hp_percent or 0))

	self.w_attr.hp = self.w_attr.hp + var_44_5

	self:addAttribute("hp", var_44_5)
	self:addAttribute("singlehp", math.floor(var_44_5 / self.hpcount))
end

function var_0_0:updateSkills(arg_45_1)
	local playermodel = require("model.playermodel")

	if arg_45_1 == SKILL_PASSIVE then
		self.passiveLevel = playermodel.passiveLevel[self.servantid]
		self.passiveskill = model_data[self.modelid]["passive" .. self.passiveLevel] or model_data[self.modelid].passive
	elseif arg_45_1 == SKILL_SKILL1 then
		self.skill1Level = playermodel.skill1Level[self.servantid]
		self.skills[1] = model_data[self.modelid]["skill1" .. "_" .. self.skill1Level] or model_data[self.modelid].skill1
	end
end

function var_0_0:updateRestrain(arg_46_1, arg_46_2)
	if next(arg_46_2) == nil then
		return
	end

	for iter_46_0, iter_46_1 in pairs(self.allAttrs) do
		if iter_46_1 == "imaginary" then
			self.imaginaryConvertAttr = arg_46_2

			break
		end
	end
end

function var_0_0:updateTeamskill(arg_47_1)
	self.teamskill = {}

	if not arg_47_1 then
		return
	end

	for iter_47_0, iter_47_1 in pairs(arg_47_1) do
		table.insert(self.teamskill, iter_47_1.skillid)
	end
end

local var_0_16 = {
	model_scale = true,
	spinemodel = true,
	passiveLevel = true,
	passiveskill = true,
	xpskill = true,
	cfg = true,
	modelid = true,
	skills = true,
	spinecfg = true,
	model_weight = true,
	model_height = true
}

function var_0_0:initSlaveCharacter(arg_48_1, arg_48_2)
	local var_48_0

	if type(arg_48_1) ~= "table" then
		var_48_0 = arg_48_1
		arg_48_1 = model_data[arg_48_1]
	end

	self.modelid = var_48_0 or "20104"
	self.cfg = "fight.behavior." .. arg_48_1.behavior
	self.spinecfg = "fight.spine." .. arg_48_1.spinecfg
	self.spinemodel = arg_48_1.spine_model
	self.model_weight = arg_48_1.modelweight
	self.model_height = arg_48_1.modelheight
	self.model_scale = arg_48_1.modelscale or 1
	self.passiveLevel = arg_48_2
	self.passiveskill = arg_48_1["passive" .. self.passiveLevel] or arg_48_1.passive
	self.slave_attrs = setmetatable({}, {
		__index = var_0_16
	})
	self.slave_facs = setmetatable({}, {
		__index = function(arg_49_0, arg_49_1)
			return 1
		end
	})

	for iter_48_0, iter_48_1 in pairs(arg_48_1.slave_attr) do
		self[iter_48_0] = (self[iter_48_0] or 0) + iter_48_1
		self.slave_attrs[iter_48_0] = true
	end

	for iter_48_2, iter_48_3 in pairs(arg_48_1.slave_attr_fac) do
		if not self.slave_attrs[iter_48_2] then
			self.slave_facs[iter_48_2] = iter_48_3
		end
	end
end

function var_0_0:isSlaveAttribute(arg_50_1)
	return self.slave_attrs[arg_50_1]
end

function var_0_0:getSlaveAttrFac(arg_51_1)
	return self.slave_facs[arg_51_1]
end

function var_0_0:updateFalseLevel(arg_52_1, arg_52_2)
	if require("controller.role_false_level_manager"):isRoleFalseLevelMember(self.servantid, arg_52_1, arg_52_2) then
		self:updateFalseLevelByAllRole(arg_52_1, arg_52_2)
	end
end

function var_0_0:updateFalseLevelByAllRole(arg_53_1, arg_53_2)
	local role_false_level_manager = require("controller.role_false_level_manager")

	if role_false_level_manager:isRoleFalseLevelMember(self.servantid, arg_53_1, arg_53_2) then
		local var_53_1 = model_data[self.origin_modelid]
		local var_53_2, var_53_3, var_53_4 = role_false_level_manager:getRoleFalseAttrInfoByAllRole(self.servantid, arg_53_1, arg_53_2)

		self.science_point = core_manager:getStrengthenValue(self.servantid, var_53_4, var_53_3)
		self.hp = math.round(self.science_point * self:getFactorAttribute("hpFactor"))
		self.damage = math.round(self.science_point * self:getFactorAttribute("damageFactor"))
		self._returnBuffHp = self._returnBuffHp or 1
		self._returnBuffDamage = self._returnBuffHp or 1
		self.hp = self.hp * self._returnBuffHp
		self.damage = self.damage * self._returnBuffDamage
		self.basicmodel = {
			science_point = self.science_point
		}
		self.servantrank = var_53_2
		self.exskill = var_53_1["ex_" .. ((self.servantrank > SERVANT_CORE_BREAK_MAX or nil) and (SERVANT_CORE_BREAK_MAX or self.servantrank))]
		self.singlehp = math.floor(self.hp / (self.hpcount or 1))
		self.curhp = self.singlehp

		self:updateFalseLevelBasicAttributes()

		self.hp = self.hp + math.round(self:getBasicAttribute("hp") * goodwell_manager:getFavorHp(self.soulid))
		self.damage = self.damage + math.round(self:getBasicAttribute("damage") * goodwell_manager:getFavorDamage(self.soulid))
		self.hp = self.hp + math.round(self:getBasicAttribute("hp") * CONTRACT_ATTR_ADD * souls_manager:get_total_contract_attr())
		self.damage = self.damage + math.round(self:getBasicAttribute("damage") * CONTRACT_ATTR_ADD * souls_manager:get_total_contract_attr())
		self.singlehp = math.floor(self.hp / (self.hpcount or 1))
		self.curhp = self.singlehp
	end
end

function var_0_0:updateRoundBuff()
	local var_54_0 = FightManager.fightActivityData().fightRound

	print(var_54_0, "rrrrrrrrrrrrrooooo", self.hp, self.damage, self.hpcount)

	self.hp = 12000 * var_54_0 * var_54_0 * var_54_0 + 104883 * var_54_0 * var_54_0 - 157620 * var_54_0 + 556500
	self.damage = 190 * var_54_0 * var_54_0 * var_54_0 - 3079 * var_54_0 * var_54_0 + 16072 * var_54_0 - 12500
	self.hpcount = var_54_0 * 5 + self.hpcount

	print(self.hp, self.damage, self.hpcount, "afterrrrrrrr")

	self.singlehp = math.floor(self.hp / (self.hpcount or 1))
	self.curhpcount = self.hpcount
	self.curhp = self.singlehp
end

function var_0_0:updateOfflineBuff()
	local var_55_0 = require("model.playermodel"):getOfflineBuff()

	self.hp = self.hp * var_55_0
	self.damage = self.damage * var_55_0

	self:updateFalseLevelBasicAttributes()

	self.singlehp = math.floor(self.hp / (self.hpcount or 1))
	self.curhp = self.singlehp

	print("offline buff : " .. var_55_0)
end

function var_0_0:updateFalseLevelBasicAttributes()
	for iter_56_0, iter_56_1 in ipairs({
		"hp",
		"damage",
		"singlehp"
	}) do
		self.modelbasicattrs[iter_56_1] = self[iter_56_1]
	end
end

function var_0_0:updatePseudoLevelBasicAttributes()
	for iter_57_0, iter_57_1 in ipairs({
		"hp",
		"damage",
		"singlehp"
	}) do
		self.modelbasicattrs[iter_57_1] = self[iter_57_1]
	end
end

function var_0_0.initReturnBuff(arg_58_0)
	local activity_return_manager = require("controller.activity_return_manager")

	if not activity_return_manager:is_have_catchup_buff(activity_return_manager.BUFF_TYPES.BUFF_PVE_FIGNT_ATTRIBUTE) then
		return
	end

	arg_58_0._returnBuffHp = 1.3
	arg_58_0._returnBuffDamage = 1.3
end

function var_0_0:updateAttrByWorldBossFight(arg_59_1, arg_59_2)
	self.hp = self.hp * arg_59_1
	self.damage = self.damage * arg_59_2
end

local var_0_17 = {
	__index = var_0_0
}

function var_0_17.new()
	local var_60_0 = {}

	setmetatable(var_60_0, var_0_17)
	var_60_0:init()

	return var_60_0
end

function var_0_17.newExternModel()
	local var_61_0 = {}

	setmetatable(var_61_0, var_0_17)
	var_61_0:initExternModel()

	return var_61_0
end

return var_0_17
