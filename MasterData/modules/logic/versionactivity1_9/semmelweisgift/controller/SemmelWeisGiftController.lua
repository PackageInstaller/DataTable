-- chunkname: @modules/logic/versionactivity1_9/semmelweisgift/controller/SemmelWeisGiftController.lua

module("modules.logic.versionactivity1_9.semmelweisgift.controller.SemmelWeisGiftController", package.seeall)

local SemmelWeisGiftController = class("SemmelWeisGiftController", BaseController)

function SemmelWeisGiftController:addConstEvents()
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self._checkActivityInfo, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._checkActivityInfo, self)
end

function SemmelWeisGiftController:_checkActivityInfo()
	self:getSemmelWeisGiftActivityInfo()
end

function SemmelWeisGiftController:getSemmelWeisGiftActivityInfo(cb, cbObj)
	local isOpen = SemmelWeisGiftModel.instance:isSemmelWeisGiftOpen()

	if not isOpen then
		return
	end

	local actId = SemmelWeisGiftModel.instance:getSemmelWeisGiftActId()

	Activity101Rpc.instance:sendGet101InfosRequest(actId, cb, cbObj)
end

function SemmelWeisGiftController:openSemmelWeisGiftView()
	self.getSemmelWeisGiftActivityInfo(self, self._realOpenSemmelWeisGiftView, self)
end

function SemmelWeisGiftController:_realOpenSemmelWeisGiftView()
	ViewMgr.instance:openView(ViewName.SemmelWeisGiftView)
end

function SemmelWeisGiftController:receiveSemmelWeisGift(cb, cbObj)
	local isOpen = SemmelWeisGiftModel.instance:isSemmelWeisGiftOpen()

	if not isOpen then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	local actId = SemmelWeisGiftModel.instance:getSemmelWeisGiftActId()
	local index = SemmelWeisGiftModel.REWARD_INDEX
	local canReceive = ActivityType101Model.instance:isType101RewardCouldGet(actId, index)

	if canReceive then
		Activity101Rpc.instance:sendGet101BonusRequest(actId, index, cb, cbObj)
	else
		GameFacade.showToast(ToastEnum.ActivityRewardHasReceive)
	end
end

SemmelWeisGiftController.instance = SemmelWeisGiftController.New()

return SemmelWeisGiftController
