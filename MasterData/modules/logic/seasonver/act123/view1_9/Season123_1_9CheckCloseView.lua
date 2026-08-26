-- chunkname: @modules/logic/seasonver/act123/view1_9/Season123_1_9CheckCloseView.lua

module("modules.logic.seasonver.act123.view1_9.Season123_1_9CheckCloseView", package.seeall)

local Season123_1_9CheckCloseView = class("Season123_1_9CheckCloseView", BaseView)

function Season123_1_9CheckCloseView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_1_9CheckCloseView:addEvents()
	return
end

function Season123_1_9CheckCloseView:removeEvents()
	return
end

function Season123_1_9CheckCloseView:onOpen()
	if self:checkActNotOpen() then
		return
	end

	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.handleReceiveActChanged, self)
end

function Season123_1_9CheckCloseView:onClose()
	return
end

function Season123_1_9CheckCloseView:handleReceiveActChanged()
	self:checkActNotOpen()
end

function Season123_1_9CheckCloseView:checkActNotOpen()
	local actId = self.viewParam.actId
	local actMO = ActivityModel.instance:getActMO(actId)

	if not actMO or not actMO:isOpen() or actMO:isExpired() then
		TaskDispatcher.runDelay(self.handleNoActDelayClose, self, 0.1)

		return true
	end

	return false
end

function Season123_1_9CheckCloseView:handleNoActDelayClose()
	self:closeThis()
end

return Season123_1_9CheckCloseView
