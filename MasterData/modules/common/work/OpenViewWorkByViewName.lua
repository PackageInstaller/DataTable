-- chunkname: @modules/common/work/OpenViewWorkByViewName.lua

module("modules.common.work.OpenViewWorkByViewName", package.seeall)

local OpenViewWorkByViewName = class("OpenViewWorkByViewName", BaseWork)

function OpenViewWorkByViewName:ctor(viewName, viewParam, eventName)
	self.viewName = viewName
	self.viewParam = viewParam
	self.eventName = eventName or ViewEvent.OnOpenView
end

function OpenViewWorkByViewName:onStart()
	ViewMgr.instance:registerCallback(self.eventName, self.onEventFinish, self)
	ViewMgr.instance:openView(self.viewName, self.viewParam)
end

function OpenViewWorkByViewName:onEventFinish()
	ViewMgr.instance:unregisterCallback(self.eventName, self.onEventFinish, self)
	self:onDone(true)
end

function OpenViewWorkByViewName:clearWork()
	ViewMgr.instance:unregisterCallback(self.eventName, self.onEventFinish, self)
end

return OpenViewWorkByViewName
