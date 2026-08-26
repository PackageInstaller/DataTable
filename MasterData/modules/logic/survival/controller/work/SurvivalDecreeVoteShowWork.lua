-- chunkname: @modules/logic/survival/controller/work/SurvivalDecreeVoteShowWork.lua

module("modules.logic.survival.controller.work.SurvivalDecreeVoteShowWork", package.seeall)

local SurvivalDecreeVoteShowWork = class("SurvivalDecreeVoteShowWork", BaseWork)

function SurvivalDecreeVoteShowWork:ctor(param)
	self:initParam(param)
end

function SurvivalDecreeVoteShowWork:initParam(param)
	self.go = param.go
	self.callback = param.callback
	self.callbackObj = param.callbackObj
	self.time = param.time or 0
	self.audioId = param.audioId
end

function SurvivalDecreeVoteShowWork:onStart()
	gohelper.setActive(self.go, true)

	if self.callback then
		self.callback(self.callbackObj)
	end

	if self.audioId then
		AudioMgr.instance:trigger(self.audioId)
	end

	TaskDispatcher.runDelay(self.onBuildFinish, self, self.time)
end

function SurvivalDecreeVoteShowWork:onBuildFinish()
	self:onDone(true)
end

function SurvivalDecreeVoteShowWork:clearWork()
	TaskDispatcher.cancelTask(self.onBuildFinish, self)
end

return SurvivalDecreeVoteShowWork
