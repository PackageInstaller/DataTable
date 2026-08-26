-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1CheckCloseView.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1CheckCloseView", package.seeall)

local Season123_2_1CheckCloseView = class("Season123_2_1CheckCloseView", BaseView)

function Season123_2_1CheckCloseView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_2_1CheckCloseView:addEvents()
	return
end

function Season123_2_1CheckCloseView:removeEvents()
	return
end

function Season123_2_1CheckCloseView:onOpen()
	if self:checkActNotOpen() then
		return
	end

	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.handleReceiveActChanged, self)
end

function Season123_2_1CheckCloseView:onClose()
	return
end

function Season123_2_1CheckCloseView:handleReceiveActChanged()
	self:checkActNotOpen()
end

function Season123_2_1CheckCloseView:checkActNotOpen()
	local actId = self.viewParam.actId
	local actMO = ActivityModel.instance:getActMO(actId)

	if not actMO or not actMO:isOpen() or actMO:isExpired() then
		TaskDispatcher.runDelay(self.handleNoActDelayClose, self, 0.1)

		return true
	end

	return false
end

function Season123_2_1CheckCloseView:handleNoActDelayClose()
	self:closeThis()
end

return Season123_2_1CheckCloseView
