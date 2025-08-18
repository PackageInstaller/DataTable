-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\FrameBattle\\AttackProcess\\DamageCalc.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local ResAttackEffect = require("ClientData/ResAttackEffect")
local PropBoard = require("ClientData/PropBoard")
local logerror = logerror
local math = math
local DamageCalc = {}
local CRIT_POWER_CACHE = {}
local DEF_POWER_CACHE = {}

DamageCalc.Props = {
	"shield",
	"id",
	"race",
	"lastBeHurtNum",
	"lastDamage",
	"camp",
	"attackCamp"
}

for pName, pLevel in pairs(PropBoard.PROP_LEVELS) do
	if pLevel == 2 then
		table.insert(DamageCalc.Props, pName)
	end
end

for pName, pStr in pairs(BattleConst.STATE_CALC_ATTR) do
	table.insert(DamageCalc.Props, pName)
end

DamageCalc.SpecialProps = {}

local BOX_TYPE_PHYSICS = 0
local BOX_TYPE_MAGIC = 1
local BOX_TYPE_SACRED = 2
local BOX_TYPE_HEAL = 3
local BOX_TYPE_SHIELD = 4
local BOX_TYPE_HP_REMOVE = 5
local BOX_TYPE_FIRE = 6
local BOX_TYPE_ICE = 7
local BOX_TYPE_NO_ARMOR = 8
local BOX_TYPE_HP_SHIELD_REMOVE = 9

DamageCalc.BOX_TYPE_CONFIG = {
	[BOX_TYPE_PHYSICS] = {
		true,
		true,
		false,
		true,
		true,
		true,
		true
	},
	[BOX_TYPE_MAGIC] = {
		true,
		true,
		false,
		true,
		true,
		true,
		true
	},
	[BOX_TYPE_SACRED] = {
		false,
		false,
		false,
		false,
		false,
		true,
		true
	},
	[BOX_TYPE_HEAL] = {
		false,
		false,
		false,
		true,
		false,
		false,
		false
	},
	[BOX_TYPE_SHIELD] = {
		false,
		false,
		false,
		true,
		false,
		false,
		false
	},
	[BOX_TYPE_HP_REMOVE] = {
		false,
		false,
		false,
		false,
		false,
		false,
		false
	},
	[BOX_TYPE_FIRE] = {
		true,
		true,
		true,
		true,
		true,
		false,
		true
	},
	[BOX_TYPE_ICE] = {
		false,
		true,
		true,
		true,
		true,
		false,
		true
	},
	[BOX_TYPE_NO_ARMOR] = {
		false,
		true,
		false,
		true,
		true,
		true,
		true
	},
	[BOX_TYPE_HP_SHIELD_REMOVE] = {
		false,
		false,
		false,
		false,
		true,
		false,
		false
	}
}

function DamageCalc.calcDamageResult(propCache, target, boxId, eventLevel, randomGenerate, skillPower, objectMgr, skillInfo)
	local effectData = ResAttackEffect[boxId]
	local results = {}
	local effectLevelData = effectData[1]

	if eventLevel and eventLevel > 1 and effectData[eventLevel] then
		effectLevelData = effectData[eventLevel]
	end

	local boxType = effectLevelData.dmg_type

	if target.stateGroup:getProp(BattleConst.STATE_MAGIC_IMMUNE, 0) > 0 and boxType == BOX_TYPE_MAGIC then
		target:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SOMETHING, {
			BattleConst.ENTITY_SOMETHING_IMMUE_MAGIC
		})

		return results
	elseif target.stateGroup:getProp(BattleConst.STATE_PHYSICS_IMMUNE, 0) > 0 and boxType == BOX_TYPE_PHYSICS then
		local attacker = objectMgr:getObjectByKey(propCache.id)

		target:raiseSimpleEvent({
			BattleConst.ENTITY_SOMETHING_IMMUE_PHYSICS,
			attacker
		})

		if attacker then
			target:beHited(attacker, 0, BattleConst.DAMAGE_TYPE_HURT_IMMUE)
		end

		return results
	end

	if not DamageCalc.BOX_TYPE_CONFIG[boxType] then
		boxType = BOX_TYPE_PHYSICS
	end

	local conditionPower = skillInfo[1].stateGroup:getSkillConditionEnhanceRate(skillInfo[2], skillInfo[3], boxType, target, boxId)

	if conditionPower ~= 10000 then
		skillPower = skillPower * conditionPower * 0.0001
	end

	local boxConfig = DamageCalc.BOX_TYPE_CONFIG[boxType]
	local damageAmount = DamageCalc.AttackCalc(propCache, target, effectLevelData, boxType, objectMgr, skillInfo[4], skillInfo[5])
	local isCrit = false
	local shield = 0
	local isBlock = false

	if boxConfig[1] then
		damageAmount = DamageCalc.DefenseCalc(damageAmount, propCache, target, boxType)
	end

	if boxConfig[2] then
		damageAmount, isCrit = DamageCalc.CritCalc(damageAmount, propCache, target, randomGenerate, effectLevelData)
	end

	if boxConfig[4] then
		damageAmount, isBlock = DamageCalc.PowerCalc(damageAmount, boxType, propCache, target, skillPower, randomGenerate)
	end

	local targets = {}
	local linkDamage = 0

	if boxConfig[7] then
		targets, linkDamage = DamageCalc.CheckSoulLimit(damageAmount, target, objectMgr, targets)
	else
		table.insert(targets, {
			target,
			damageAmount
		})
	end

	local boxRealType = boxType

	if effectLevelData.final_dmg_type then
		boxRealType = effectLevelData.final_dmg_type
	end

	for index, hurtInfo in ipairs(targets) do
		local oneTarget = hurtInfo[1]
		local oneDmg = hurtInfo[2] + linkDamage

		if boxConfig[5] then
			oneDmg, shield = DamageCalc.ShieldCalc(oneDmg, oneTarget)
		end

		DamageCalc.recordMainResults(oneDmg, shield, isCrit, boxRealType, results, oneTarget, {
			index > 1,
			effectLevelData.shield_time,
			effectLevelData.burning,
			isBlock
		}, hurtInfo[3])

		if boxConfig[6] then
			DamageCalc.HandleVampire(objectMgr, oneDmg, oneTarget, propCache, results)
		end
	end

	return results
end

function DamageCalc.recordMainResults(damageAmount, shield, isCrit, boxType, results, target, extraInfo, fixedType)
	damageAmount = math.floor(damageAmount)
	shield = math.floor(shield)

	if fixedType then
		table.insert(results, {
			fixedType,
			{
				damageAmount,
				shield
			},
			isCrit,
			target,
			extraInfo
		})
	elseif boxType == BOX_TYPE_HEAL then
		table.insert(results, {
			BattleConst.DAMAGE_TYPE_HEAL,
			damageAmount,
			isCrit,
			target,
			extraInfo
		})
	elseif boxType == BOX_TYPE_SHIELD then
		table.insert(results, {
			BattleConst.DAMAGE_TYPE_SHIELD,
			damageAmount,
			isCrit,
			target,
			extraInfo
		})
	elseif boxType == BOX_TYPE_HP_REMOVE then
		table.insert(results, {
			BattleConst.DAMAGE_TYPE_HP_REMOVE,
			damageAmount,
			isCrit,
			target,
			extraInfo
		})
	elseif boxType == BOX_TYPE_HP_SHIELD_REMOVE then
		table.insert(results, {
			BattleConst.DAMAGE_TYPE_HP_SHIELD_REMOVE,
			{
				damageAmount,
				shield
			},
			isCrit,
			target,
			extraInfo
		})
	elseif boxType == BOX_TYPE_FIRE then
		table.insert(results, {
			BattleConst.DAMAGE_TYPE_HURT_FIRE,
			{
				damageAmount,
				shield
			},
			isCrit,
			target,
			extraInfo
		})
	elseif boxType == BOX_TYPE_ICE then
		table.insert(results, {
			BattleConst.DAMAGE_TYPE_HURT_ICE,
			{
				damageAmount,
				shield
			},
			isCrit,
			target,
			extraInfo
		})
	else
		table.insert(results, {
			BattleConst.DAMAGE_TYPE_HURT,
			{
				damageAmount,
				shield
			},
			isCrit,
			target,
			extraInfo
		})
	end
end

function DamageCalc.AttackCalc(propCache, target, effectLevelData, boxType, objectMgr, hitNum, baseId)
	local damageAmount = 0
	local attack = propCache.atk

	if effectLevelData.dmg_percent and effectLevelData.dmg_percent ~= 0 then
		damageAmount = damageAmount + effectLevelData.dmg_percent * attack * 0.0001
	end

	if effectLevelData.dmg_value then
		damageAmount = damageAmount + effectLevelData.dmg_value
	end

	if effectLevelData.self_hp_percent and effectLevelData.self_hp_percent ~= 0 then
		local value = propCache.hp * effectLevelData.self_hp_percent * 0.0001

		if effectLevelData.percent_limit and effectLevelData.percent_limit ~= 0 then
			value = math.min(value, attack * effectLevelData.percent_limit * 0.0001)
		end

		damageAmount = damageAmount + value
	end

	if effectLevelData.self_mhp_percent and effectLevelData.self_mhp_percent ~= 0 then
		local value = propCache.mhp * effectLevelData.self_mhp_percent * 0.0001

		if effectLevelData.percent_limit and effectLevelData.percent_limit ~= 0 then
			value = math.min(value, attack * effectLevelData.percent_limit * 0.0001)
		end

		damageAmount = damageAmount + value
	end

	if effectLevelData.extra_hp_lost and effectLevelData.extra_hp_lost ~= 0 then
		damageAmount = damageAmount + effectLevelData.extra_hp_lost * math.max(0, propCache.mhp - propCache.hp) * 0.0001
	end

	if effectLevelData.target_hp_lost and effectLevelData.target_hp_lost ~= 0 then
		local value = effectLevelData.target_hp_lost * math.max(0, target.mhp - target.hp) * 0.0001

		if effectLevelData.percent_limit and effectLevelData.percent_limit ~= 0 then
			value = math.min(value, propCache.atk * effectLevelData.percent_limit * 0.0001)
		end

		damageAmount = damageAmount + value
	end

	if effectLevelData.extra_last_damage and effectLevelData.extra_last_damage ~= 0 then
		local value = effectLevelData.extra_last_damage * (propCache.lastDamage or 0) * 0.0001

		if effectLevelData.percent_limit and effectLevelData.percent_limit ~= 0 then
			value = math.min(value, propCache.atk * effectLevelData.percent_limit * 0.0001)
		end

		damageAmount = damageAmount + value
	end

	if effectLevelData.extra_last_heal and effectLevelData.extra_last_heal ~= 0 then
		damageAmount = damageAmount + effectLevelData.extra_last_heal * (propCache.lastHeal or 0) * 0.0001
	end

	if effectLevelData.hp_percent and effectLevelData.hp_percent ~= 0 then
		local value = target.hp * effectLevelData.hp_percent * 0.0001

		if effectLevelData.percent_limit and effectLevelData.percent_limit ~= 0 then
			value = math.min(value, attack * effectLevelData.percent_limit * 0.0001)
		end

		damageAmount = damageAmount + value
	end

	if effectLevelData.mhp_percent and effectLevelData.mhp_percent ~= 0 then
		local value = target.mhp * effectLevelData.mhp_percent * 0.0001

		if effectLevelData.percent_limit and effectLevelData.percent_limit ~= 0 then
			value = math.min(value, attack * effectLevelData.percent_limit * 0.0001)
		end

		damageAmount = damageAmount + value
	end

	if effectLevelData.self_shield_percent and effectLevelData.self_shield_percent ~= 0 then
		local value = propCache.shield * effectLevelData.self_shield_percent * 0.0001

		if effectLevelData.percent_limit and effectLevelData.percent_limit ~= 0 then
			value = math.min(value, propCache.atk * effectLevelData.percent_limit * 0.0001)
		end

		damageAmount = damageAmount + value
	end

	if effectLevelData.filter_target_state and effectLevelData.filter_target_dmg then
		damageAmount = damageAmount + effectLevelData.filter_target_dmg * attack * 0.0001 * target:getStateLayer(effectLevelData.filter_target_state, propCache.id)
	end

	if effectLevelData.target_debuff_dmg then
		damageAmount = damageAmount + effectLevelData.target_debuff_dmg * attack * 0.0001 * target:getStateDebuffNum()
	end

	if effectLevelData.target_shield_percent then
		damageAmount = damageAmount + effectLevelData.target_shield_percent * (target.shield or 0) * 0.0001
	end

	if effectLevelData.add_last_hurt then
		damageAmount = damageAmount + effectLevelData.add_last_hurt * (propCache.lastBeHurtNum or 0) * 0.0001
	end

	local attacker = objectMgr:getObjectByKey(propCache.id)

	if attacker then
		if effectLevelData.extra_attr_dmg then
			damageAmount = damageAmount + attacker:calcAttrValue(effectLevelData.extra_attr_dmg)
		end

		if effectLevelData.filter_attacker_state and effectLevelData.filter_target_dmg then
			damageAmount = damageAmount + effectLevelData.filter_target_dmg * attack * 0.0001 * attacker:getStateLayer(effectLevelData.filter_attacker_state, propCache.id)
		end
	end

	local base = objectMgr:getObjectByKey(baseId)

	if base and effectLevelData.extra_passive_record then
		local passiveKey = effectLevelData.extra_passive_record[1]
		local passiveValue = base:getDamageRecordValue(passiveKey)
		local dmgRate = effectLevelData.extra_passive_record[2]

		if passiveValue > 0 and dmgRate then
			passiveValue = passiveValue * dmgRate * 0.0001

			if effectLevelData.extra_passive_record[3] == 1 and hitNum and hitNum > 0 then
				passiveValue = passiveValue / hitNum
			end

			damageAmount = damageAmount + passiveValue
		end
	end

	if effectLevelData.state_extra_rate then
		if effectLevelData.filter_target_state and target:hasBattleState(effectLevelData.filter_target_state) then
			damageAmount = damageAmount * (1 + effectLevelData.state_extra_rate * 0.0001)
		end

		if effectLevelData.filter_attacker_state then
			local attacker = objectMgr:getObjectByKey(propCache.id)

			if attacker and attacker:hasBattleState(effectLevelData.filter_attacker_state) then
				damageAmount = damageAmount * (1 + effectLevelData.state_extra_rate * 0.0001)
			end
		end
	end

	return damageAmount
end

function DamageCalc.DefenseCalc(damageAmount, propCache, target, boxType)
	local defenseReduce = 0

	if boxType == BOX_TYPE_MAGIC then
		local realArmor = target.m_def / (target.level * BattleConst.BATTLE_ARMOR_ARG2)

		if propCache.spp_percent and propCache.spp_percent > 0 then
			realArmor = realArmor * (1 - propCache.spp_percent)
		end

		realArmor = math.max(realArmor, 0)
		damageAmount = damageAmount * math.max(target.defReduceLimit, 1 / (1 + realArmor / BattleConst.BATTLE_ARMOR_ARG1))
	else
		local realArmor = target.p_def / (target.level * BattleConst.BATTLE_ARMOR_ARG2)

		if propCache.arp_percent and propCache.arp_percent > 0 then
			realArmor = realArmor * (1 - propCache.arp_percent)
		end

		realArmor = math.max(realArmor, 0)
		damageAmount = damageAmount * math.max(target.defReduceLimit, 1 / (1 + realArmor / BattleConst.BATTLE_ARMOR_ARG1))
	end

	return damageAmount
end

function DamageCalc.CritCalc(damageAmount, propCache, target, randomGenerate, effectLevelData)
	local critRate = propCache.cri_rate - target.cri_reduce
	local isCrit = false

	if critRate > 0.0001 and critRate > randomGenerate:random() then
		damageAmount = damageAmount * math.max(1.25, propCache.cri_dmg - target.cri_dmg_reduce + (effectLevelData.cri_dmg_add or 0) * 0.0001)
		isCrit = true
	end

	return damageAmount, isCrit
end

function DamageCalc.GetSpProp(propCache, propName, defValue, target)
	return propCache[propName] or defValue
end

function DamageCalc.PowerCalc(damageAmount, boxType, propCache, target, skillPower, randomGenerate)
	local isBlock = false
	local attackerHurtPercent = 1 + propCache.damage_percent
	local targetDamagePercent = 1 - target.damage_reduce_percent

	if boxType == BOX_TYPE_HEAL then
		attackerHurtPercent = math.max(0, propCache.heal_effect)
		targetDamagePercent = math.max(0, target.heal_enhance_percent)
	elseif boxType == BOX_TYPE_SHIELD then
		if propCache.shieldEnhance then
			attackerHurtPercent = 1 + propCache.shieldEnhance / 10000
		else
			attackerHurtPercent = 1
		end

		if target.beShieldEnhance then
			targetDamagePercent = 1 + target.beShieldEnhance / 10000
		else
			targetDamagePercent = 1
		end
	elseif target.blockRate and target.blockRate >= 1 and randomGenerate:random(10000) <= target.blockRate then
		target:addOutput(BattleConst.MATRIX_EVENT_ENTITY_SOMETHING, {
			BattleConst.STATE_BLOCK_RATE
		})

		targetDamagePercent = targetDamagePercent * BattleConst.BLOCK_REDUCE
		isBlock = true
	end

	damageAmount = math.max(0, damageAmount * attackerHurtPercent * targetDamagePercent * skillPower / 10000)

	if target.camp ~= propCache.attackCamp and target.race and BattleConst.HERO_CAMP_OVERCOME[propCache.race] == target.race then
		local extraDamage = damageAmount * BattleConst.OVERCOME_VALUE

		if propCache.campOvercomeAdd and propCache.campOvercomeAdd ~= 0 then
			extraDamage = extraDamage + damageAmount * propCache.campOvercomeAdd * 0.0001
		end

		if target.beCampOvercomeAdd and target.beCampOvercomeAdd ~= 0 then
			extraDamage = extraDamage + damageAmount * target.beCampOvercomeAdd * 0.0001
		end

		damageAmount = damageAmount + extraDamage
	end

	if boxType == BOX_TYPE_FIRE then
		local fireHurtPercent = 1 + propCache.fire_damage
		local fireHurtReducePercent = 1 - target.fire_damage_reduce

		damageAmount = math.max(0, damageAmount * fireHurtPercent * fireHurtReducePercent)
	elseif boxType == BOX_TYPE_ICE then
		local iceHurtPercent = 1 + propCache.ice_damage
		local iceHurtReducePercent = 1 - target.ice_damage_reduce

		damageAmount = math.max(0, damageAmount * iceHurtPercent * iceHurtReducePercent)
	end

	return damageAmount, isBlock
end

function DamageCalc.ShieldCalc(damageAmount, target)
	local onceMaxHurtPercent = target[BattleConst.STATE_ONCE_HURT_PERCENT]

	if onceMaxHurtPercent and onceMaxHurtPercent > 0 then
		local maxDmg = target.mhp * onceMaxHurtPercent * 0.0001

		if maxDmg < damageAmount then
			damageAmount = maxDmg
		end
	end

	if damageAmount <= target.shield then
		return 0, damageAmount
	else
		return damageAmount - target.shield, target.shield
	end
end

function DamageCalc.HandleVampire(objectMgr, damageAmount, target, propCache, refResults)
	if damageAmount > 0 then
		local vampire = 0

		if propCache.vampirePercent and propCache.vampirePercent > 0 then
			vampire = damageAmount * (propCache.vampirePercent / 10000)
		end

		if vampire > 0 then
			table.insert(refResults, {
				BattleConst.DAMAGE_TYPE_VAMPIRE,
				math.floor(vampire),
				false,
				target
			})
		end

		local rebound = target[BattleConst.STATE_DAMAGE_REBOUND]

		if rebound and rebound > 0 then
			local attacker = objectMgr:getObjectByKey(propCache.id)

			if attacker and attacker.stateGroup:getProp(BattleConst.STATE_DAMAGE_IMMUNE, 0) <= 0 then
				local dam = math.floor(rebound * 0.0001 * damageAmount)

				if dam <= attacker.shield then
					table.insert(refResults, {
						BattleConst.DAMAGE_TYPE_REBOUND,
						{
							0,
							dam
						},
						false,
						target
					})
				else
					table.insert(refResults, {
						BattleConst.DAMAGE_TYPE_REBOUND,
						{
							dam - attacker.shield,
							attacker.shield
						},
						false,
						target
					})
				end
			end
		end
	end
end

function DamageCalc.CheckSoulLimit(damageAmount, target, objectMgr, targets)
	local linkDamage = 0
	local soulLink = target[BattleConst.STATE_LINK] or 0

	if soulLink > 0 and damageAmount > 0 then
		linkDamage = damageAmount * math.min(10000, soulLink) * 0.0001

		table.insert(targets, {
			target,
			damageAmount - linkDamage
		})

		for _, objId in ipairs(objectMgr.orderObjects) do
			local obj = objectMgr.objects[objId]

			if obj.camp == target.camp and obj ~= target and obj:isAlive() and obj.stateGroup:getProp(BattleConst.STATE_LINK, 0) > 0 then
				table.insert(targets, {
					obj,
					0,
					BattleConst.DAMAGE_TYPE_LINK
				})
			end
		end

		linkDamage = linkDamage / #targets
	else
		table.insert(targets, {
			target,
			damageAmount
		})
	end

	return targets, linkDamage
end

return DamageCalc
