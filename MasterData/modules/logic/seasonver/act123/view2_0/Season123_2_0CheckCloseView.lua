-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0CheckCloseView.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0CheckCloseView", package.seeall)

local Season123_2_0CheckCloseView = class("Season123_2_0CheckCloseView", BaseView)

function Season123_2_0CheckCloseView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_2_0CheckCloseView:addEvents()
	return
end

function Season123_2_0CheckCloseView:removeEvents()
	return
end

function Season123_2_0CheckCloseView:onOpen()
	if self:checkActNotOpen() then
		return
	end

	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.handleReceiveActChanged, self)
end

function Season123_2_0CheckCloseView:onClose()
	return
end

function Season123_2_0CheckCloseView:handleReceiveActChanged()
	self:checkActNotOpen()
end

function Season123_2_0CheckCloseView:checkActNotOpen()
	local actId = self.viewParam.actId
	local actMO = ActivityModel.instance:getActMO(actId)

	if not actMO or not actMO:isOpen() or actMO:isExpired() then
		TaskDispatcher.runDelay(self.handleNoActDelayClose, self, 0.1)

		return true
	end

	return false
end

function Season123_2_0CheckCloseView:handleNoActDelayClose()
	self:closeThis()
end

return Season123_2_0CheckCloseView
