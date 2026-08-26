-- chunkname: @modules/logic/fight/system/work/FightWorkEzioBigSkillDamage1000.lua

module("modules.logic.fight.system.work.FightWorkEzioBigSkillDamage1000", package.seeall)

local FightWorkEzioBigSkillDamage1000 = class("FightWorkEzioBigSkillDamage1000", FightEffectBase)

function FightWorkEzioBigSkillDamage1000:onStart()
	self:onDone(true)
end

function FightWorkEzioBigSkillDamage1000.fakeDecreaseHp(entityId, effectNum)
	local entityData = FightDataHelper.entityMgr:getById(entityId)

	if not entityData then
		return
	end

	if not FightDataHelper.tempMgr.aiJiAoFakeHpOffset[entityData.id] then
		local oldValue = 0

		FightDataHelper.tempMgr.aiJiAoFakeHpOffset[entityData.id] = oldValue + effectNum
	end
end

function FightWorkEzioBigSkillDamage1000.calFakeHpAndShield(entityId, curHp, curShield)
	local aiJiAoFakeHpOffset = FightDataHelper.tempMgr.aiJiAoFakeHpOffset[entityId]

	if aiJiAoFakeHpOffset then
		if curShield > 0 then
			if aiJiAoFakeHpOffset <= curShield then
				curShield = curShield - aiJiAoFakeHpOffset
				aiJiAoFakeHpOffset = 0
			else
				aiJiAoFakeHpOffset = aiJiAoFakeHpOffset - curShield
				curShield = 0
			end
		end

		curHp = curHp - aiJiAoFakeHpOffset
		aiJiAoFakeHpOffset = 0
	end

	return curHp, curShield
end

return FightWorkEzioBigSkillDamage1000
