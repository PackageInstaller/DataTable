-- chunkname: @modules/logic/versionactivity1_3/act125/view/Activity125WarmUpViewBaseContainer.lua

module("modules.logic.versionactivity1_3.act125.view.Activity125WarmUpViewBaseContainer", package.seeall)

local Activity125WarmUpViewBaseContainer = class("Activity125WarmUpViewBaseContainer", Activity125ViewBaseContainer)

function Activity125WarmUpViewBaseContainer:onContainerInit()
	Activity125WarmUpViewBaseContainer.super.onContainerInit(self)
end

function Activity125WarmUpViewBaseContainer:onContainerOpen()
	Activity125WarmUpViewBaseContainer.super.onContainerOpen(self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
	ActivityController.instance:registerCallback(ActivityEvent.UpdateActivity, self._onUpdateActivity, self)
	Activity125Controller.instance:registerCallback(Activity125Event.DataUpdate, self._onDataUpdate, self)
	Activity125Controller.instance:registerCallback(Activity125Event.SwitchEpisode, self._onSwitchEpisode, self)

	if not self._isInited then
		Activity125Controller.instance:getAct125InfoFromServer(self:actId())
	end
end

function Activity125WarmUpViewBaseContainer:onContainerClose()
	ActivityController.instance:unregisterCallback(ActivityEvent.UpdateActivity, self._onUpdateActivity, self)
	Activity125Controller.instance:unregisterCallback(Activity125Event.SwitchEpisode, self._onSwitchEpisode, self)
	Activity125Controller.instance:unregisterCallback(Activity125Event.DataUpdate, self._onDataUpdate, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	Activity125WarmUpViewBaseContainer.super.onContainerClose(self)
end

function Activity125WarmUpViewBaseContainer:onContainerDestroy()
	self._isInited = false

	Activity125WarmUpViewBaseContainer.super.onContainerDestroy(self)
end

function Activity125WarmUpViewBaseContainer:_onDataUpdate(msg)
	if msg and msg.activityId ~= self:actId() then
		return
	end

	local first = self._isInited

	if not self._isInited then
		self:onDataUpdateFirst()

		self._isInited = true
	end

	self:onDataUpdate()

	if first ~= self._isInited then
		self:onDataUpdateDoneFirst()
	end
end

function Activity125WarmUpViewBaseContainer:_onSwitchEpisode()
	if not self._isInited then
		return
	end

	self:onSwitchEpisode()
end

function Activity125WarmUpViewBaseContainer:_onUpdateActivity()
	if not self._isInited then
		return
	end

	self:onUpdateActivity()
end

function Activity125WarmUpViewBaseContainer:_onDailyRefresh()
	Activity125Controller.instance:getAct125InfoFromServer(self:actId())
end

function Activity125WarmUpViewBaseContainer:_onCloseViewFinish(...)
	if not self._isInited then
		return
	end

	self:onCloseViewFinish(...)
end

function Activity125WarmUpViewBaseContainer:actId()
	return self.viewParam.actId
end

function Activity125WarmUpViewBaseContainer:dispatchRedEvent()
	Activity125Model.instance:setHasCheckEpisode(self:actId(), self:getCurSelectedEpisode())
	RedDotController.instance:dispatchEvent(RedDotEvent.RedDotEvent.UpdateActTag)
end

function Activity125WarmUpViewBaseContainer:onDataUpdateFirst()
	return
end

function Activity125WarmUpViewBaseContainer:onDataUpdate()
	assert(false, "please override this function")
end

function Activity125WarmUpViewBaseContainer:onDataUpdateDoneFirst()
	return
end

function Activity125WarmUpViewBaseContainer:onSwitchEpisode()
	return
end

function Activity125WarmUpViewBaseContainer:onCloseViewFinish(...)
	return
end

function Activity125WarmUpViewBaseContainer:onUpdateActivity()
	return
end

return Activity125WarmUpViewBaseContainer
