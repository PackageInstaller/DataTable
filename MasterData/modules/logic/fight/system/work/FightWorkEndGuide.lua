-- chunkname: @modules/logic/fight/system/work/FightWorkEndGuide.lua

module("modules.logic.fight.system.work.FightWorkEndGuide", package.seeall)

local FightWorkEndGuide = class("FightWorkEndGuide", BaseWork)

function FightWorkEndGuide:onStart()
	FightController.instance:GuideFlowPauseAndContinue("OnGuideFightEndPause", FightEvent.OnGuideFightEndPause, FightEvent.OnGuideFightEndContinue, self._done, self)
end

function FightWorkEndGuide:_done()
	self:onDone(true)
end

return FightWorkEndGuide
