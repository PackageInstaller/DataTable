-- chunkname: @modules/logic/versionactivity1_2/jiexika/system/work/Activity114OpenViewWork.lua

module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114OpenViewWork", package.seeall)

local Activity114OpenViewWork = class("Activity114OpenViewWork", Activity114BaseWork)

function Activity114OpenViewWork:ctor(viewName)
	self._viewName = viewName

	Activity114OpenViewWork.super.ctor(self)
end

function Activity114OpenViewWork:onStart(context)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseViewFinish, self)
	ViewMgr.instance:openView(self._viewName, context)
end

function Activity114OpenViewWork:_onCloseViewFinish(viewName)
	if viewName == self._viewName then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseViewFinish, self)
		self:onDone(true)
	end
end

function Activity114OpenViewWork:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseViewFinish, self)
	Activity114OpenViewWork.super.clearWork(self)
end

return Activity114OpenViewWork
