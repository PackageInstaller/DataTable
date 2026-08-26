-- chunkname: @modules/logic/versionactivity1_6/decalogpresent/controller/DecalogPresentController.lua

module("modules.logic.versionactivity1_6.decalogpresent.controller.DecalogPresentController", package.seeall)

local DecalogPresentController = class("DecalogPresentController", BaseController)

function DecalogPresentController:addConstEvents()
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self._checkActivityInfo, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._checkActivityInfo, self)
end

function DecalogPresentController:reInit()
	TaskDispatcher.cancelTask(self._delayGetInfo, self)
end

function DecalogPresentController:_checkActivityInfo()
	TaskDispatcher.cancelTask(self._delayGetInfo, self)
	TaskDispatcher.runDelay(self._delayGetInfo, self, 0.2)
end

function DecalogPresentController:_delayGetInfo()
	self:getDecalogActivityInfo()
end

function DecalogPresentController:getDecalogActivityInfo(cb, cbObj)
	local isOpen = DecalogPresentModel.instance:isDecalogPresentOpen()

	if not isOpen then
		return
	end

	local actId = DecalogPresentModel.instance:getDecalogPresentActId()

	Activity101Rpc.instance:sendGet101InfosRequest(actId, cb, cbObj)
end

function DecalogPresentController:openDecalogPresentView(viewName)
	self._viewName = viewName

	self.getDecalogActivityInfo(self, self._realOpenDecalogPresentView, self)
end

function DecalogPresentController:_realOpenDecalogPresentView()
	if not self._viewName then
		ViewMgr.instance:openView(self._viewName)
	end
end

function DecalogPresentController:receiveDecalogPresent(cb, cbObj)
	local actId = DecalogPresentModel.instance:getDecalogPresentActId()
	local isOpen = ActivityType101Model.instance:isOpen(actId)

	if not isOpen then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	local index = DecalogPresentModel.REWARD_INDEX
	local canReceive = ActivityType101Model.instance:isType101RewardCouldGet(actId, index)

	if not canReceive then
		GameFacade.showToast(ToastEnum.ActivityRewardHasReceive)

		return
	end

	Activity101Rpc.instance:sendGet101BonusRequest(actId, index, cb, cbObj)
end

DecalogPresentController.instance = DecalogPresentController.New()

return DecalogPresentController
