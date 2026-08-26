-- chunkname: @modules/logic/fight/system/work/FightWorkIndicatorChange.lua

module("modules.logic.fight.system.work.FightWorkIndicatorChange", package.seeall)

local FightWorkIndicatorChange = class("FightWorkIndicatorChange", FightEffectBase)

FightWorkIndicatorChange.ConfigEffect = {
	ClearIndicator = 60017,
	AddIndicator = 60016
}

function FightWorkIndicatorChange:onStart()
	local indicatorId = tonumber(self.actEffectData.targetId)

	FightModel.instance:setWaitIndicatorAnimation(false)
	self:com_sendFightEvent(FightEvent.OnIndicatorChange, indicatorId, self.actEffectData.effectNum)

	if FightModel.instance:isWaitIndicatorAnimation() then
		self:com_registTimer(self._delayDone, 3)
		self:com_registFightEvent(FightEvent.OnIndicatorAnimationDone, self._delayDone)
	else
		self:onDone(true)
	end
end

function FightWorkIndicatorChange:_delayDone()
	self:onDone(true)
end

function FightWorkIndicatorChange:clearWork()
	return
end

return FightWorkIndicatorChange
