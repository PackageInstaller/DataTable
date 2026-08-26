-- chunkname: @modules/logic/fight/system/work/FightWorkShowRoundView.lua

module("modules.logic.fight.system.work.FightWorkShowRoundView", package.seeall)

local FightWorkShowRoundView = class("FightWorkShowRoundView", BaseWork)

function FightWorkShowRoundView:onStart()
	if FightModel.instance.hasNextWave and FightController.instance:canOpenRoundView() and GMFightShowState.roundSpecialView then
		FightController.instance:openRoundView()
		TaskDispatcher.runDelay(self._delayDone, self, 1 / FightModel.instance:getUISpeed())
	else
		self:onDone(true)
	end
end

function FightWorkShowRoundView:_delayDone()
	self:onDone(true)
end

function FightWorkShowRoundView:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
end

return FightWorkShowRoundView
