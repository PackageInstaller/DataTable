-- chunkname: @modules/common/work/CloseViewWork.lua

module("modules.common.work.CloseViewWork", package.seeall)

local CloseViewWork = class("CloseViewWork", BaseWork)

function CloseViewWork:ctor(viewName)
	self.viewName = viewName
end

function CloseViewWork:onStart()
	TaskDispatcher.runDelay(self.onDelayDone, self, 0.1)
	ViewMgr.instance:closeView(self.viewName)

	return self:onDone(true)
end

function CloseViewWork:onDelayDone()
	logError("CloseViewWork delay !")

	return self:onDone(true)
end

function CloseViewWork:clearWork()
	TaskDispatcher.cancelTask(self.onDelayDone, self)
end

return CloseViewWork
