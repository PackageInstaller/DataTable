-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8CheckCloseView.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8CheckCloseView", package.seeall)

local Season123_1_8CheckCloseView = class("Season123_1_8CheckCloseView", BaseView)

function Season123_1_8CheckCloseView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_1_8CheckCloseView:addEvents()
	return
end

function Season123_1_8CheckCloseView:removeEvents()
	return
end

function Season123_1_8CheckCloseView:onOpen()
	if self:checkActNotOpen() then
		return
	end

	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.handleReceiveActChanged, self)
end

function Season123_1_8CheckCloseView:onClose()
	return
end

function Season123_1_8CheckCloseView:handleReceiveActChanged()
	self:checkActNotOpen()
end

function Season123_1_8CheckCloseView:checkActNotOpen()
	local actId = self.viewParam.actId
	local actMO = ActivityModel.instance:getActMO(actId)

	if not actMO or not actMO:isOpen() or actMO:isExpired() then
		TaskDispatcher.runDelay(self.handleNoActDelayClose, self, 0.1)

		return true
	end

	return false
end

function Season123_1_8CheckCloseView:handleNoActDelayClose()
	self:closeThis()
end

return Season123_1_8CheckCloseView
