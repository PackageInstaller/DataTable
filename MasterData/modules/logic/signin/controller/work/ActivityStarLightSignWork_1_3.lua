-- chunkname: @modules/logic/signin/controller/work/ActivityStarLightSignWork_1_3.lua

module("modules.logic.signin.controller.work.ActivityStarLightSignWork_1_3", package.seeall)

local ActivityStarLightSignWork_1_3 = class("ActivityStarLightSignWork_1_3", BaseWork)
local startIndex = 0
local actIds = {
	ActivityEnum.Activity.StarLightSignPart1_1_3,
	ActivityEnum.Activity.StarLightSignPart2_1_3
}

local function _initViewNames()
	ActivityStarLightSignWork_1_3.kViewNames = ActivityStarLightSignWork_1_3.kViewNames or {
		ViewName.ActivityStarLightSignPart1PaiLianView_1_3,
		ViewName.ActivityStarLightSignPart2PaiLianView_1_3
	}
end

function ActivityStarLightSignWork_1_3:onStart()
	_initViewNames()

	if self:_isExistGuide() then
		self:_endBlock()
		GuideController.instance:registerCallback(GuideEvent.FinishGuideLastStep, self._work, self)
	else
		self:_work()
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self._refreshNorSignActivity, self)
end

function ActivityStarLightSignWork_1_3:_refreshNorSignActivity()
	if not self._actId then
		return
	end

	if not ActivityType101Model.instance:isType101RewardCouldGetAnyOne(self._actId) then
		if ViewMgr.instance:isOpen(self._viewName) then
			return
		end

		self:_work()

		return
	end

	ViewMgr.instance:openView(self._viewName)
end

function ActivityStarLightSignWork_1_3:_onCloseViewFinish(viewName)
	if viewName ~= self._viewName then
		return
	end

	if ViewMgr.instance:isOpen(self._viewName) then
		return
	end

	self:_work()
end

function ActivityStarLightSignWork_1_3:_onOpenViewFinish(viewName)
	if viewName ~= self._viewName then
		return
	end

	self:_endBlock()
end

function ActivityStarLightSignWork_1_3:clearWork()
	if not self.isSuccess then
		self:_endBlock()
	end

	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, self._work, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self._refreshNorSignActivity, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)

	self._actId = nil
	self._viewName = nil
	startIndex = 0
end

function ActivityStarLightSignWork_1_3:_pop()
	startIndex = startIndex + 1

	local viewName = ActivityStarLightSignWork_1_3.kViewNames[startIndex]
	local actId = actIds[startIndex]

	return actId, viewName
end

function ActivityStarLightSignWork_1_3:_work()
	self:_startBlock()

	self._actId, self._viewName = self:_pop()

	if not self._actId then
		self:onDone(true)

		return
	end

	local actId = self._actId

	if ActivityModel.instance:isActOnLine(actId) then
		Activity101Rpc.instance:sendGet101InfosRequest(actId)
	else
		return self:_work()
	end
end

function ActivityStarLightSignWork_1_3:_isExistGuide()
	if GuideModel.instance:isDoingClickGuide() and not GuideController.instance:isForbidGuides() then
		return true
	end

	if GuideController.instance:isGuiding() then
		return true
	end

	return false
end

function ActivityStarLightSignWork_1_3:_endBlock()
	if not self:_isBlock() then
		return
	end

	UIBlockMgr.instance:endBlock()
end

function ActivityStarLightSignWork_1_3:_startBlock()
	if self:_isBlock() then
		return
	end

	UIBlockMgr.instance:startBlock()
end

function ActivityStarLightSignWork_1_3:_isBlock()
	return not not UIBlockMgr.instance:isBlock()
end

return ActivityStarLightSignWork_1_3
