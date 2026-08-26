-- chunkname: @modules/logic/activity/controller/chessmap/step/ActivityChessStepBase.lua

module("modules.logic.activity.controller.chessmap.step.ActivityChessStepBase", package.seeall)

local ActivityChessStepBase = class("ActivityChessStepBase")

function ActivityChessStepBase:init(stepData)
	self.originData = stepData
end

function ActivityChessStepBase:start()
	return
end

function ActivityChessStepBase:finish()
	local evtMgr = ActivityChessGameController.instance.event

	if evtMgr then
		evtMgr:nextStep()
	end
end

function ActivityChessStepBase:dispose()
	self.originData = nil
end

return ActivityChessStepBase
