-- chunkname: @modules/logic/seasonver/act123/view/Season123CheckCloseView.lua

module("modules.logic.seasonver.act123.view.Season123CheckCloseView", package.seeall)

local Season123CheckCloseView = class("Season123CheckCloseView", BaseView)

function Season123CheckCloseView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123CheckCloseView:addEvents()
	return
end

function Season123CheckCloseView:removeEvents()
	return
end

function Season123CheckCloseView:onOpen()
	if self:checkActNotOpen() then
		return
	end

	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.handleReceiveActChanged, self)
end

function Season123CheckCloseView:onClose()
	return
end

function Season123CheckCloseView:handleReceiveActChanged()
	self:checkActNotOpen()
end

function Season123CheckCloseView:checkActNotOpen()
	local actId = self.viewParam.actId
	local actMO = ActivityModel.instance:getActMO(actId)

	if not actMO or not actMO:isOpen() or actMO:isExpired() then
		TaskDispatcher.runDelay(self.handleNoActDelayClose, self, 0.1)

		return true
	end

	return false
end

function Season123CheckCloseView:handleNoActDelayClose()
	self:closeThis()
end

return Season123CheckCloseView
