-- chunkname: @modules/logic/sp02/enter/controller/VersionActivity3_10EnterController.lua

module("modules.logic.sp02.enter.controller.VersionActivity3_10EnterController", package.seeall)

local VersionActivity3_10EnterController = class("VersionActivity3_10EnterController", VersionActivityFixedEnterController)

function VersionActivity3_10EnterController:onInitFinish()
	VersionActivity3_10EnterController.super.onInitFinish(self)

	self._lastEnterMainActId = nil
end

function VersionActivity3_10EnterController:openVersionActivityEnterView(openCb, openCbObj, jumpActId, isDirectOpen, isExitFight)
	self.openEnterViewCb = openCb
	self.openEnterViewCbObj = openCbObj

	local actId = self:getShowMainActId()
	local activityIdList = VersionActivity3_10Enum.EnterViewActIdList
	local viewParams = {
		skipOpenAnim = true,
		actId = actId,
		jumpActId = jumpActId,
		activityIdList = activityIdList,
		isExitFight = isExitFight,
		isDirectOpen = isDirectOpen
	}
	local openFunc

	if not isDirectOpen then
		openFunc = self._internalOpenEnterView
	end

	local function rpcCallBack()
		self._internalOpenView(self, ViewName.VersionActivity3_10EnterView, actId, openFunc, self, viewParams, self.openEnterViewCb, self.openEnterViewCbObj)
	end

	if ActivityHelper.isOpen(VersionActivity3_10Enum.ActivityId.Outside) then
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.AtomicDungeon
		})
		AtomicRpc.instance:sendAtomicGetInfoRequest()
		AssassinOutSideRpc.instance:sendGetAssassinLibraryInfoRequest(VersionActivity3_10Enum.ActivityId.Outside, rpcCallBack)

		return
	end

	rpcCallBack()
end

function VersionActivity3_10EnterController:getShowMainActId()
	return VersionActivity3_10Enum.ActivityId.EnterView
end

function VersionActivity3_10EnterController:openSeasonStoreView()
	local actId = Activity104Model.instance:getCurSeasonId()
	local viewName = SeasonViewHelper.getViewName(actId, Activity104Enum.ViewName.StoreView)
	local storeActId = Activity104Enum.SeasonStore[actId]

	self._enterVersionActivityView(self, viewName, storeActId, self._openStoreView, self)
end

function VersionActivity3_10EnterController:_openStoreView(viewName, actId)
	Activity107Rpc.instance:sendGet107GoodsInfoRequest(actId, function()
		ViewMgr.instance:openView(viewName, {
			actId = actId
		})
	end)
end

function VersionActivity3_10EnterController:openTaskView()
	self._enterVersionActivityView(self, ViewName.VersionActivityTaskView, VersionActivity1_5Enum.ActivityId.Act113, self._openTaskView, self)
end

function VersionActivity3_10EnterController:_openTaskView()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, function()
		ViewMgr.instance:openView(ViewName.VersionActivityTaskView)
	end)
end

function VersionActivity3_10EnterController:_enterVersionActivityView(viewName, actId, callback, callbackObj)
	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(actId)

	if ActivityEnum.ActivityStatus.Normal ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToast(toastId, toastParam)
		end

		return
	end

	if callback then
		callback(callbackObj, viewName, actId)

		return
	end

	ViewMgr.instance:openView(viewName)
end

VersionActivity3_10EnterController.instance = VersionActivity3_10EnterController.New()

LuaEventSystem.addEventMechanism(VersionActivity3_10EnterController.instance)

return VersionActivity3_10EnterController
