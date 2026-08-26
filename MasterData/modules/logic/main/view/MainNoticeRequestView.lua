-- chunkname: @modules/logic/main/view/MainNoticeRequestView.lua

module("modules.logic.main.view.MainNoticeRequestView", package.seeall)

local MainNoticeRequestView = class("MainNoticeRequestView", BaseView)

function MainNoticeRequestView:onInitView()
	return
end

function MainNoticeRequestView:addEvents()
	return
end

function MainNoticeRequestView:removeEvents()
	return
end

MainNoticeRequestView.RequestCD = 600

function MainNoticeRequestView:onOpen()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self, LuaEventSystem.Low)
	self:requestNotice()
end

function MainNoticeRequestView:_onCloseView()
	if ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		self:requestNotice()
	end
end

function MainNoticeRequestView:requestNotice()
	local lastRequestTime = MainController.instance:getLastRequestNoticeTime()

	if lastRequestTime and Time.realtimeSinceStartup - lastRequestTime < MainNoticeRequestView.RequestCD then
		return
	end

	MainController.instance:setRequestNoticeTime()
	NoticeController.instance:startRequest()
end

return MainNoticeRequestView
