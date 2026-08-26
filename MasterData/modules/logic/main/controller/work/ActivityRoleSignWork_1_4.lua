-- chunkname: @modules/logic/main/controller/work/ActivityRoleSignWork_1_4.lua

module("modules.logic.main.controller.work.ActivityRoleSignWork_1_4", package.seeall)

local ActivityRoleSignWork_1_4 = class("ActivityRoleSignWork_1_4", BaseWork)
local startIndex = 0
local actIds = {
	ActivityEnum.Activity.RoleSignViewPart1_1_4,
	ActivityEnum.Activity.RoleSignViewPart2_1_4
}

local function _initViewNames()
	ActivityRoleSignWork_1_4.kViewNames = ActivityRoleSignWork_1_4.kViewNames or {
		ViewName.V1a4_Role_PanelSignView_Part1,
		ViewName.V1a4_Role_PanelSignView_Part2
	}
end

function ActivityRoleSignWork_1_4:onStart()
	_initViewNames()

	startIndex = 0

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

function ActivityRoleSignWork_1_4:_refreshNorSignActivity()
	local actId = self._actId
	local viewName = self._viewName

	if not actId then
		return
	end

	if not ActivityType101Model.instance:isType101RewardCouldGetAnyOne(actId) then
		if ViewMgr.instance:isOpen(viewName) then
			return
		end

		self:_work()

		return
	end

	local viewParam = {
		actId = actId
	}

	ViewMgr.instance:openView(viewName, viewParam)
end

function ActivityRoleSignWork_1_4:_onCloseViewFinish(viewName)
	if viewName ~= self._viewName then
		return
	end

	if ViewMgr.instance:isOpen(self._viewName) then
		return
	end

	self:_work()
end

function ActivityRoleSignWork_1_4:_onOpenViewFinish(viewName)
	if viewName ~= self._viewName then
		return
	end

	self:_endBlock()
end

function ActivityRoleSignWork_1_4:clearWork()
	self:_endBlock()
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, self._work, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self._refreshNorSignActivity, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)

	self._actId = nil
	self._viewName = nil
end

function ActivityRoleSignWork_1_4:_pop()
	startIndex = startIndex + 1

	local viewName = ActivityRoleSignWork_1_4.kViewNames[startIndex]
	local actId = actIds[startIndex]

	return actId, viewName
end

function ActivityRoleSignWork_1_4:_work()
	self:_startBlock()

	self._actId, self._viewName = self:_pop()

	local actId = self._actId

	if not actId then
		self:onDone(true)

		return
	end

	if ActivityModel.instance:isActOnLine(actId) then
		Activity101Rpc.instance:sendGet101InfosRequest(actId)

		return
	end

	self:_work()
end

function ActivityRoleSignWork_1_4:_isExistGuide()
	if GuideModel.instance:isDoingClickGuide() and not GuideController.instance:isForbidGuides() then
		return true
	end

	if GuideController.instance:isGuiding() then
		return true
	end

	return false
end

function ActivityRoleSignWork_1_4:_endBlock()
	if not self:_isBlock() then
		return
	end

	UIBlockMgr.instance:endBlock()
end

function ActivityRoleSignWork_1_4:_startBlock()
	if self:_isBlock() then
		return
	end

	UIBlockMgr.instance:startBlock()
end

function ActivityRoleSignWork_1_4:_isBlock()
	return not not UIBlockMgr.instance:isBlock()
end

return ActivityRoleSignWork_1_4
