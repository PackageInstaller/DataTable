-- chunkname: @modules/common/work/OpenViewWorkNew.lua

module("modules.common.work.OpenViewWorkNew", package.seeall)

local OpenViewWorkNew = class("OpenViewWorkNew", BaseWork)

function OpenViewWorkNew:ctor(viewName, viewParam)
	self.viewName = viewName
	self.viewParam = viewParam
end

function OpenViewWorkNew:onStart()
	TaskDispatcher.runDelay(self.onDelayDone, self, 0.1)
	ViewMgr.instance:openView(self.viewName, self.viewParam)

	return self:onDone(true)
end

function OpenViewWorkNew:onDelayDone()
	logError("OpenViewWorkNew delay !")

	return self:onDone(true)
end

function OpenViewWorkNew:clearWork()
	TaskDispatcher.cancelTask(self.onDelayDone, self)
end

return OpenViewWorkNew
