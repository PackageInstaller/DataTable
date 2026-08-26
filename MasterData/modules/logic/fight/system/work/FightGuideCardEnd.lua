-- chunkname: @modules/logic/fight/system/work/FightGuideCardEnd.lua

module("modules.logic.fight.system.work.FightGuideCardEnd", package.seeall)

local FightGuideCardEnd = class("FightGuideCardEnd", BaseWork)

function FightGuideCardEnd:ctor()
	return
end

function FightGuideCardEnd:onStart(context)
	FightController.instance:GuideFlowPauseAndContinue("OnGuideCardEndPause", FightEvent.OnGuideCardEndPause, FightEvent.OnGuideCardEndContinue, self._done, self)
end

function FightGuideCardEnd:_done()
	self:onDone(true)
end

return FightGuideCardEnd
