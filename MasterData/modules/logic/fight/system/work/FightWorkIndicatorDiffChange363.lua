-- chunkname: @modules/logic/fight/system/work/FightWorkIndicatorDiffChange363.lua

module("modules.logic.fight.system.work.FightWorkIndicatorDiffChange363", package.seeall)

local FightWorkIndicatorDiffChange363 = class("FightWorkIndicatorDiffChange363", FightEffectBase)

function FightWorkIndicatorDiffChange363:onStart()
	local indicatorId = tonumber(self.actEffectData.targetId)
	local offsetNum = self.actEffectData.effectNum

	self:com_sendFightEvent(FightEvent.OnIndicatorChangeByOffset, indicatorId, offsetNum)

	return self:onDone(true)
end

return FightWorkIndicatorDiffChange363
