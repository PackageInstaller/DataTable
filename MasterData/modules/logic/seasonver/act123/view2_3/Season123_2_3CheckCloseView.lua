-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3CheckCloseView.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3CheckCloseView", package.seeall)

local Season123_2_3CheckCloseView = class("Season123_2_3CheckCloseView", BaseView)

function Season123_2_3CheckCloseView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_2_3CheckCloseView:addEvents()
	return
end

function Season123_2_3CheckCloseView:removeEvents()
	return
end

function Season123_2_3CheckCloseView:onOpen()
	if self:checkActNotOpen() then
		return
	end

	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.handleReceiveActChanged, self)
end

function Season123_2_3CheckCloseView:onClose()
	return
end

function Season123_2_3CheckCloseView:handleReceiveActChanged()
	self:checkActNotOpen()
end

function Season123_2_3CheckCloseView:checkActNotOpen()
	local actId = self.viewParam.actId
	local actMO = ActivityModel.instance:getActMO(actId)

	if not actMO or not actMO:isOpen() or actMO:isExpired() then
		TaskDispatcher.runDelay(self.handleNoActDelayClose, self, 0.1)

		return true
	end

	return false
end

function Season123_2_3CheckCloseView:handleNoActDelayClose()
	self:closeThis()
end

return Season123_2_3CheckCloseView
