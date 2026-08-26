-- chunkname: @modules/logic/activity/controller/chessmap/step/ActivityChessStepNextRound.lua

module("modules.logic.activity.controller.chessmap.step.ActivityChessStepNextRound", package.seeall)

local ActivityChessStepNextRound = class("ActivityChessStepNextRound", ActivityChessStepBase)

function ActivityChessStepNextRound:start()
	self:finish()
end

function ActivityChessStepNextRound:finish()
	local evtMgr = ActivityChessGameController.instance.event

	if evtMgr then
		evtMgr:setCurEvent(nil)
	end

	local curRound = self.originData.currentRound

	ActivityChessGameModel.instance:setRound(curRound)
	ActivityChessGameController.instance:tryResumeSelectObj()
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.CurrentRoundUpdate)
	ActivityChessStepNextRound.super.finish(self)
end

return ActivityChessStepNextRound
