-- chunkname: @modules/logic/versionactivity3_9/hedone/controller/skill/effect/HedoneEffectResetCD.lua

module("modules.logic.versionactivity3_9.hedone.controller.skill.effect.HedoneEffectResetCD", package.seeall)

local HedoneEffectResetCD = class("HedoneEffectResetCD", HedoneBaseEffect)

function HedoneEffectResetCD:onHit(context)
	local id = self:getId()
	local param = HedoneConfig.instance:getHedoneEffectParam(id)
	local skillId = tonumber(param)
	local skillCaster = context and context.skillCaster

	if skillCaster and skillId then
		skillCaster:resetSkillCD(skillId)

		local uid = skillCaster:getUid()

		return {
			uid
		}
	end
end

function HedoneEffectResetCD:getMinHitInterval()
	return (HedoneConfig.instance:getHedoneConst(HedoneEnum.ConstId.ResetCDEffectInnerCD, false, true))
end

return HedoneEffectResetCD
