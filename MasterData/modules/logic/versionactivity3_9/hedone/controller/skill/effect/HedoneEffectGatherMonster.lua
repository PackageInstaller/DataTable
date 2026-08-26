-- chunkname: @modules/logic/versionactivity3_9/hedone/controller/skill/effect/HedoneEffectGatherMonster.lua

module("modules.logic.versionactivity3_9.hedone.controller.skill.effect.HedoneEffectGatherMonster", package.seeall)

local HedoneEffectGatherMonster = class("HedoneEffectGatherMonster", HedoneBaseEffect)

function HedoneEffectGatherMonster:onHit(context)
	local targetUid = context.targetUid
	local skillCaster = context.skillCaster
	local affectedUidList = self:getAffectedTargetUidList(skillCaster, targetUid)

	if not affectedUidList or #affectedUidList <= 0 then
		return
	end

	local targetMO = HedoneGameModel.instance:getEntityMO(targetUid)
	local targetX = targetMO and targetMO:getPosition()

	if not targetX then
		return
	end

	local step = self:getEffectValMul(skillCaster) * HedoneGameEnum.Const.EffectBaseFactor

	for _, uid in ipairs(affectedUidList) do
		self:_gatherUnit(uid, targetX, step)
	end

	return affectedUidList
end

function HedoneEffectGatherMonster:_gatherUnit(uid, targetX, step)
	local mo = HedoneGameModel.instance:getEntityMO(uid)
	local isAlive = mo and mo:getIsAlive()

	if not isAlive then
		return
	end

	local x, y = mo:getPosition()
	local newX = x < targetX and math.min(x + step, targetX) or math.max(x - step, targetX)

	mo:setPosition(newX, y)
end

return HedoneEffectGatherMonster
