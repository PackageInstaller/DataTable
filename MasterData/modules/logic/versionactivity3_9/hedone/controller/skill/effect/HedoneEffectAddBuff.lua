-- chunkname: @modules/logic/versionactivity3_9/hedone/controller/skill/effect/HedoneEffectAddBuff.lua

module("modules.logic.versionactivity3_9.hedone.controller.skill.effect.HedoneEffectAddBuff", package.seeall)

local HedoneEffectAddBuff = class("HedoneEffectAddBuff", HedoneBaseEffect)

function HedoneEffectAddBuff:onHit(context)
	local id = self:getId()
	local param = HedoneConfig.instance:getHedoneEffectParam(id)
	local buffId = tonumber(param)
	local skillCaster = context and context.skillCaster

	if skillCaster and buffId then
		skillCaster:addBuff(buffId)

		local uid = skillCaster:getUid()

		return {
			uid
		}
	end
end

return HedoneEffectAddBuff
