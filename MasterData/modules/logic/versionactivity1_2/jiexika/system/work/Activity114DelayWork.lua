-- chunkname: @modules/logic/versionactivity1_2/jiexika/system/work/Activity114DelayWork.lua

module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114DelayWork", package.seeall)

local Activity114DelayWork = class("Activity114DelayWork", Activity114BaseWork)

function Activity114DelayWork:ctor(sec)
	self._sec = sec
end

function Activity114DelayWork:onStart(context)
	if self._sec then
		TaskDispatcher.runDelay(self.onDelay, self, self._sec)
	else
		self:onDone(true)
	end
end

function Activity114DelayWork:onDelay()
	TaskDispatcher.cancelTask(self.onDelay, self)
	self:onDone(true)
end

function Activity114DelayWork:clearWork()
	TaskDispatcher.cancelTask(self.onDelay, self)
end

return Activity114DelayWork
