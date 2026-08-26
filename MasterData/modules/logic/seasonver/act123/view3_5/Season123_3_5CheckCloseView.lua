-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5CheckCloseView.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5CheckCloseView", package.seeall)

local Season123_3_5CheckCloseView = class("Season123_3_5CheckCloseView", BaseView)

function Season123_3_5CheckCloseView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_3_5CheckCloseView:addEvents()
	return
end

function Season123_3_5CheckCloseView:removeEvents()
	return
end

function Season123_3_5CheckCloseView:onOpen()
	if self:checkActNotOpen() then
		return
	end

	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.handleReceiveActChanged, self)
end

function Season123_3_5CheckCloseView:onClose()
	return
end

function Season123_3_5CheckCloseView:handleReceiveActChanged()
	self:checkActNotOpen()
end

function Season123_3_5CheckCloseView:checkActNotOpen()
	local actId = self.viewParam.actId
	local actMO = ActivityModel.instance:getActMO(actId)

	if not actMO or not actMO:isOpen() or actMO:isExpired() then
		TaskDispatcher.runDelay(self.handleNoActDelayClose, self, 0.1)

		return true
	end

	return false
end

function Season123_3_5CheckCloseView:handleNoActDelayClose()
	self:closeThis()
end

return Season123_3_5CheckCloseView
