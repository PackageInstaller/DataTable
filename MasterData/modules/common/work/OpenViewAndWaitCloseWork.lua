-- chunkname: @modules/common/work/OpenViewAndWaitCloseWork.lua

module("modules.common.work.OpenViewAndWaitCloseWork", package.seeall)

local OpenViewAndWaitCloseWork = class("OpenViewAndWaitCloseWork", BaseWork)

function OpenViewAndWaitCloseWork:ctor(viewName, viewParam)
	self.viewName = viewName
	self.viewParam = viewParam
end

function OpenViewAndWaitCloseWork:onStart()
	ViewMgr.instance:openView(self.viewName, self.viewParam)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function OpenViewAndWaitCloseWork:_onCloseViewFinish(viewName)
	if self.viewName == viewName then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
		self:onDone(true)
	end
end

function OpenViewAndWaitCloseWork:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

return OpenViewAndWaitCloseWork
