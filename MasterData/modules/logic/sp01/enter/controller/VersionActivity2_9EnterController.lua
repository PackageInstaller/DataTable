-- chunkname: @modules/logic/sp01/enter/controller/VersionActivity2_9EnterController.lua

module("modules.logic.sp01.enter.controller.VersionActivity2_9EnterController", package.seeall)

local VersionActivity2_9EnterController = class("VersionActivity2_9EnterController", VersionActivityFixedEnterController)

function VersionActivity2_9EnterController:onInitFinish()
	VersionActivity2_9EnterController.super.onInitFinish(self)

	self._lastEnterMainActId = nil
end

function VersionActivity2_9EnterController:openVersionActivityEnterView(openCb, openCbObj, jumpActId, isDirectOpen, isExitFight)
	self.openEnterViewCb = openCb
	self.openEnterViewCbObj = openCbObj

	local actId = self:getShowMainActId()

	self:recordLastEnterMainActId(actId)

	local viewParams = {
		actId = actId,
		activityIdListWithGroup = VersionActivity2_9Enum.EnterViewActIdListWithGroup,
		mainActIdList = VersionActivity2_9Enum.EnterViewMainActIdList,
		actId2AmbientDict = VersionActivity2_9Enum.ActId2Ambient,
		actId2OpenAudioDict = VersionActivity2_9Enum.ActId2OpenAudio,
		jumpActId = jumpActId,
		isExitFight = isExitFight,
		skipOpenAnim = isDirectOpen,
		isDirectOpen = isDirectOpen
	}
	local openFunc

	if not isDirectOpen then
		openFunc = self._internalOpenEnterView
	end

	local function rpcCallBack()
		self._internalOpenView(self, ViewName.VersionActivity2_9EnterView, actId, openFunc, self, viewParams, self.openEnterViewCb, self.openEnterViewCbObj)
	end

	if ActivityHelper.isOpen(VersionActivity2_9Enum.ActivityId.Dungeon2) then
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.Odyssey
		})
		OdysseyRpc.instance:sendOdysseyGetInfoRequest()
	end

	if ActivityHelper.isOpen(VersionActivity2_9Enum.ActivityId.Outside) then
		AssassinOutSideRpc.instance:sendGetAssassinLibraryInfoRequest(VersionActivity2_9Enum.ActivityId.Outside, rpcCallBack)

		return
	end

	rpcCallBack()
end

function VersionActivity2_9EnterController:getShowMainActId()
	if self._lastEnterMainActId then
		return self._lastEnterMainActId
	end

	local showMainActId = VersionActivity2_9Enum.EnterViewMainActIdList[1]

	for _, enterActId in ipairs(VersionActivity2_9Enum.EnterViewMainActIdList) do
		local status = ActivityHelper.getActivityStatus(enterActId)

		if status == ActivityEnum.ActivityStatus.Normal then
			local guideId = VersionActivity2_9Enum.actId2GuideId[enterActId]

			if guideId and not GuideModel.instance:isGuideFinish(guideId) then
				break
			end

			showMainActId = enterActId
		end
	end

	return showMainActId
end

function VersionActivity2_9EnterController:openSeasonStoreView()
	local actId = Activity104Model.instance:getCurSeasonId()
	local viewName = SeasonViewHelper.getViewName(actId, Activity104Enum.ViewName.StoreView)
	local storeActId = Activity104Enum.SeasonStore[actId]

	self._enterVersionActivityView(self, viewName, storeActId, self._openStoreView, self)
end

function VersionActivity2_9EnterController:_openStoreView(viewName, actId)
	Activity107Rpc.instance:sendGet107GoodsInfoRequest(actId, function()
		ViewMgr.instance:openView(viewName, {
			actId = actId
		})
	end)
end

function VersionActivity2_9EnterController:openTaskView()
	self._enterVersionActivityView(self, ViewName.VersionActivityTaskView, VersionActivity1_5Enum.ActivityId.Act113, self._openTaskView, self)
end

function VersionActivity2_9EnterController:_openTaskView()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, function()
		ViewMgr.instance:openView(ViewName.VersionActivityTaskView)
	end)
end

function VersionActivity2_9EnterController:_enterVersionActivityView(viewName, actId, callback, callbackObj)
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

function VersionActivity2_9EnterController:recordLastEnterMainActId(mainActId)
	self._lastEnterMainActId = mainActId
end

function VersionActivity2_9EnterController:clearLastEnterMainActId()
	self._lastEnterMainActId = nil
end

VersionActivity2_9EnterController.instance = VersionActivity2_9EnterController.New()

LuaEventSystem.addEventMechanism(VersionActivity2_9EnterController.instance)

return VersionActivity2_9EnterController
