-- chunkname: @modules/logic/fight/system/work/FightWorkTriggerResistance.lua

module("modules.logic.fight.system.work.FightWorkTriggerResistance", package.seeall)

local FightWorkTriggerResistance = class("FightWorkTriggerResistance", FightEffectBase)

FightWorkTriggerResistance.effectPath = "buff/buff_streamer"
FightWorkTriggerResistance.hangPoint = "mountroot"
FightWorkTriggerResistance.relaseTime = 2

function FightWorkTriggerResistance:onStart()
	local targetEntity = FightHelper.getEntity(self.actEffectData.targetId)

	if not targetEntity then
		self:onDone(true)

		return
	end

	local effectWrap = targetEntity.effect:addHangEffect(FightWorkTriggerResistance.effectPath, FightWorkTriggerResistance.hangPoint, nil, FightWorkTriggerResistance.relaseTime)

	effectWrap:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(targetEntity.id, effectWrap)
	self:onDone(true)
end

return FightWorkTriggerResistance
