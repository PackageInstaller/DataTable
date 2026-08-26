-- chunkname: @modules/logic/versionactivity3_9/hedone/controller/skill/effect/HedoneEffectAttack.lua

module("modules.logic.versionactivity3_9.hedone.controller.skill.effect.HedoneEffectAttack", package.seeall)

local HedoneEffectAttack = class("HedoneEffectAttack", HedoneBaseEffect)

function HedoneEffectAttack:onHit(context)
	local targetUid = context.targetUid
	local skillCaster = context.skillCaster
	local affectedUidList = self:getAffectedTargetUidList(skillCaster, targetUid)

	if not affectedUidList or #affectedUidList <= 0 then
		return
	end

	local atk = skillCaster:getAttrValue(HedoneGameEnum.Attribute.Atk)
	local effectValMul = self:getEffectValMul(skillCaster)
	local baseFactor = HedoneGameEnum.Const.EffectBaseFactor
	local comboFactor = baseFactor

	if context.isCombo then
		local comboDmg = skillCaster:getAttrValue(HedoneGameEnum.Attribute.ComboDmg)

		comboFactor = comboFactor + comboDmg
	end

	local effectId = self:getId()
	local effectGroup = HedoneConfig.instance:getHedoneEffectGroup(effectId)
	local critRate = skillCaster:getAttrValue(HedoneGameEnum.Attribute.CritRate, effectGroup)
	local critDmgAttr = skillCaster:getAttrValue(HedoneGameEnum.Attribute.CritDmg)
	local critDmgBaseFactor = HedoneConfig.instance:getHedoneConst(HedoneEnum.ConstId.CritDmgBaseFactor, false, true)
	local critDmgFactor = critDmgBaseFactor + critDmgAttr
	local damageInfoList = {}

	for _, uid in ipairs(affectedUidList) do
		local randVal = math.random()
		local isCrit = randVal < critRate
		local critFactor = isCrit and critDmgFactor or baseFactor
		local damage = self:_calDamageToOne(uid, atk, effectValMul, comboFactor, critFactor, isCrit, effectGroup)

		if damage then
			damageInfoList[#damageInfoList + 1] = {
				uid = uid,
				damage = damage
			}
		end
	end

	self:_logDamage(damageInfoList)

	return affectedUidList
end

function HedoneEffectAttack:_logDamage(damageInfoList)
	local isLogDamage = HedoneGameModel.instance:getIsLogDamage()

	if not canLogNormal or not isLogDamage or #damageInfoList <= 0 then
		return
	end

	local skillName = HedoneConfig.instance:getHedoneSkillName(self._skillId)
	local skillType = HedoneConfig.instance:getHedoneSkillType(self._skillId)
	local title = string.format("HedoneGameLog:[%s] skillId=<color=#00FF00>%d</color> skillType=<color=#00FF00>%d</color> Damage Details:", skillName, self._skillId, skillType)
	local parts = {
		title
	}

	for _, info in ipairs(damageInfoList) do
		parts[#parts + 1] = string.format("\nMonster UID:<color=#00FF00>%d</color> takes <color=#FF0000>%d</color> damage", info.uid, info.damage)
	end

	logNormal(table.concat(parts))
end

function HedoneEffectAttack:_calDamageToOne(uid, atk, effectValueMul, comboFactor, critFactor, isCrit, effectGroup)
	local targetMO = HedoneGameModel.instance:getEntityMO(uid)
	local isAlive = targetMO and targetMO:getIsAlive()

	if not isAlive then
		return
	end

	local def = targetMO:getAttrValue(HedoneGameEnum.Attribute.Def)
	local baseDmg = math.max(atk - def, 1)
	local damage = math.floor(baseDmg * effectValueMul * comboFactor * critFactor + 0.5)
	local realDamage = HedoneGameController.instance:entityTakeDamage(uid, damage, isCrit, self._skillId, effectGroup)

	if isCrit then
		HedoneTriggerMgr.instance:trigger(HedoneGameEnum.TriggerPoint.AfterAttackEffectCrit, effectGroup, {
			targetUid = uid
		})
	end

	return realDamage
end

return HedoneEffectAttack
