-- chunkname: @modules/logic/main/controller/work/NewCultivationGiftPatFaceWork.lua

module("modules.logic.main.controller.work.NewCultivationGiftPatFaceWork", package.seeall)

local NewCultivationGiftPatFaceWork = class("NewCultivationGiftPatFaceWork", PatFaceWorkBase)

function NewCultivationGiftPatFaceWork:_viewName()
	return PatFaceConfig.instance:getPatFaceViewName(self._patFaceId)
end

function NewCultivationGiftPatFaceWork:_actId()
	return PatFaceConfig.instance:getPatFaceActivityId(self._patFaceId)
end

function NewCultivationGiftPatFaceWork:checkCanPat()
	local actId = self:_actId()

	if not ActivityModel.instance:isActOnLine(actId) then
		return false
	end

	local activityInfoMo = ActivityModel.instance:getActMO(actId)

	if activityInfoMo == nil then
		return false
	end

	return activityInfoMo:isOpen() and not activityInfoMo:isExpired()
end

function NewCultivationGiftPatFaceWork:startPat()
	self:_startBlock()

	local actId = self:_actId()

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	Activity125Controller.instance:getAct125InfoFromServer(actId)
	Activity125Controller.instance:registerCallback(Activity125Event.DataUpdate, self.onReceiveActivityInfo, self)
end

function NewCultivationGiftPatFaceWork:clearWork()
	self:_endBlock()

	self._needRevert = false

	Activity125Controller.instance:unregisterCallback(Activity125Event.DataUpdate, self.onReceiveActivityInfo, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.OnGetReward, self)
end

function NewCultivationGiftPatFaceWork:_onOpenViewFinish(openingViewName)
	local viewName = self:_viewName()

	if openingViewName ~= viewName then
		return
	end

	self:_endBlock()
end

function NewCultivationGiftPatFaceWork:_onCloseViewFinish(closingViewName)
	local viewName = self:_viewName()

	if closingViewName ~= viewName then
		return
	end

	if ViewMgr.instance:isOpen(viewName) then
		return
	end

	self:patComplete()
end

function NewCultivationGiftPatFaceWork:onReceiveActivityInfo()
	local actId = self:_actId()
	local viewName = self:_viewName()

	if self:isActivityRewardGet() then
		if ViewMgr.instance:isOpen(viewName) then
			return
		end

		self:patComplete()

		return
	end

	local viewParam = {
		actId = actId
	}

	ViewMgr.instance:openView(viewName, viewParam)
end

function NewCultivationGiftPatFaceWork:_endBlock()
	if not self:_isBlock() then
		return
	end

	UIBlockMgr.instance:endBlock()
end

function NewCultivationGiftPatFaceWork:_startBlock()
	if self:_isBlock() then
		return
	end

	UIBlockMgr.instance:startBlock()
end

function NewCultivationGiftPatFaceWork:_isBlock()
	return not not UIBlockMgr.instance:isBlock()
end

function NewCultivationGiftPatFaceWork:isActivityRewardGet()
	local actId = self:_actId()
	local activityInfo = Activity125Model.instance:getById(actId)

	if activityInfo == nil then
		return true
	end

	return activityInfo:isEpisodeFinished(1)
end

return NewCultivationGiftPatFaceWork
