-- chunkname: @modules/logic/versionactivity1_6/goldenmilletpresent/controller/GoldenMilletPresentController.lua

module("modules.logic.versionactivity1_6.goldenmilletpresent.controller.GoldenMilletPresentController", package.seeall)

local GoldenMilletPresentController = class("GoldenMilletPresentController", BaseController)

function GoldenMilletPresentController:addConstEvents()
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self._checkActivityInfo, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._checkActivityInfo, self)
end

function GoldenMilletPresentController:reInit()
	TaskDispatcher.cancelTask(self._delayGetInfo, self)
end

function GoldenMilletPresentController:_checkActivityInfo()
	TaskDispatcher.cancelTask(self._delayGetInfo, self)
	TaskDispatcher.runDelay(self._delayGetInfo, self, 0.2)
end

function GoldenMilletPresentController:_delayGetInfo()
	self:getGoldenMilletPresentActivityInfo()
end

function GoldenMilletPresentController:getGoldenMilletPresentActivityInfo(cb, cbObj)
	local isOpen = GoldenMilletPresentModel.instance:isGoldenMilletPresentOpen()

	if not isOpen then
		return
	end

	local actId = GoldenMilletPresentModel.instance:getGoldenMilletPresentActId()

	Activity101Rpc.instance:sendGet101InfosRequest(actId, cb, cbObj)
end

function GoldenMilletPresentController:openGoldenMilletPresentView()
	local isOpen = GoldenMilletPresentModel.instance:isGoldenMilletPresentOpen(true)

	if not isOpen then
		return
	end

	local actId = GoldenMilletPresentModel.instance:getGoldenMilletPresentActId()

	Activity101Rpc.instance:sendGet101InfosRequest(actId, self._realOpenGoldenMilletPresentView, self)
end

function GoldenMilletPresentController:_realOpenGoldenMilletPresentView()
	local isShowRedDot = GoldenMilletPresentModel.instance:isShowRedDot()
	local viewName = GameBranchMgr.instance:Vxax_ViewName("GoldenMilletPresent", ViewName.GoldenMilletPresent)

	ViewMgr.instance:openView(viewName, {
		isDisplayView = not isShowRedDot
	})
end

function GoldenMilletPresentController:receiveGoldenMilletPresent(cb, cbObj)
	local isOpen = GoldenMilletPresentModel.instance:isGoldenMilletPresentOpen(true)

	if not isOpen then
		return
	end

	local actId = GoldenMilletPresentModel.instance:getGoldenMilletPresentActId()
	local index = GoldenMilletEnum.REWARD_INDEX
	local canReceive = ActivityType101Model.instance:isType101RewardCouldGet(actId, index)

	if not canReceive then
		GameFacade.showToast(ToastEnum.ActivityRewardHasReceive)

		return
	end

	Activity101Rpc.instance:sendGet101BonusRequest(actId, index, cb, cbObj)
end

GoldenMilletPresentController.instance = GoldenMilletPresentController.New()

return GoldenMilletPresentController
