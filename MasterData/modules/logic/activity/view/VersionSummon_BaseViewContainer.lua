-- chunkname: @modules/logic/activity/view/VersionSummon_BaseViewContainer.lua

module("modules.logic.activity.view.VersionSummon_BaseViewContainer", package.seeall)

local VersionSummon_BaseViewContainer = class("VersionSummon_BaseViewContainer", Activity101SignViewBaseContainer)

function VersionSummon_BaseViewContainer:buildViews()
	self.__mainView = self:_createMainView()

	return self:onBuildViews()
end

function VersionSummon_BaseViewContainer:onBuildViews()
	return {
		self.__mainView
	}
end

function VersionSummon_BaseViewContainer:onContainerInit()
	self.__onceGotRewardFetch101Infos = false

	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self._onRefreshNorSignActivity, self)
end

function VersionSummon_BaseViewContainer:getActMO()
	local actId = self:actId()

	return ActivityModel.instance:getActMO(actId)
end

function VersionSummon_BaseViewContainer:getActRemainTimeStr()
	local actInfoMo = self:getActMO()

	if not actInfoMo then
		return ""
	end

	return actInfoMo:getRemainTimeStr3(false, true)
end

function VersionSummon_BaseViewContainer:sendGet101BonusRequest(cb, cbObj)
	local index = 1
	local actId = self:actId()
	local isOpen = ActivityType101Model.instance:isOpen(actId)

	if not isOpen then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	local canReceive = ActivityType101Model.instance:isType101RewardCouldGet(actId, index)

	if not canReceive then
		GameFacade.showToast(ToastEnum.ActivityRewardHasReceive)

		return
	end

	Activity101Rpc.instance:sendGet101BonusRequest(actId, index, cb, cbObj)
end

function VersionSummon_BaseViewContainer:isType101RewardCouldGetAnyOne()
	local actId = self:actId()
	local isOpen = ActivityType101Model.instance:isOpen(actId)

	return (isOpen or nil) and ActivityType101Model.instance:isType101RewardCouldGetAnyOne(actId)
end

return VersionSummon_BaseViewContainer
