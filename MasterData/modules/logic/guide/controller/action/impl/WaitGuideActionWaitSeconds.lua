-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionWaitSeconds.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionWaitSeconds", package.seeall)

local WaitGuideActionWaitSeconds = class("WaitGuideActionWaitSeconds", BaseGuideAction)

function WaitGuideActionWaitSeconds:onStart(context)
	logNormal(string.format("<color=#EA00B3>start guide_%d_%d WaitGuideActionWaitSeconds second:%s</color>", self.guideId, self.stepId, self.actionParam))

	local blockTime = tonumber(self.actionParam)

	GuideBlockMgr.instance:startBlock((blockTime or 0) + GuideBlockMgr.BlockTime)

	self.context = context
	self.status = WorkStatus.Running

	local seconds = blockTime or 0.01

	TaskDispatcher.runDelay(self._onTimeEnd, self, seconds)
end

function WaitGuideActionWaitSeconds:_onTimeEnd()
	self:onDone(true)
end

function WaitGuideActionWaitSeconds:clearWork()
	TaskDispatcher.cancelTask(self._onTimeEnd, self)
end

return WaitGuideActionWaitSeconds
