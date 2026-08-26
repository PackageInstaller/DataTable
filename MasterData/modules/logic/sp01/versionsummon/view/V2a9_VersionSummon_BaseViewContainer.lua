-- chunkname: @modules/logic/sp01/versionsummon/view/V2a9_VersionSummon_BaseViewContainer.lua

module("modules.logic.sp01.versionsummon.view.V2a9_VersionSummon_BaseViewContainer", package.seeall)

local V2a9_VersionSummon_BaseViewContainer = class("V2a9_VersionSummon_BaseViewContainer", Activity101SignViewBaseContainer)

function V2a9_VersionSummon_BaseViewContainer:buildViews()
	self.__mainView = self:_createMainView()

	return self:onBuildViews()
end

function V2a9_VersionSummon_BaseViewContainer:onBuildViews()
	return {
		self.__mainView
	}
end

function V2a9_VersionSummon_BaseViewContainer:onContainerInit()
	self.__onceGotRewardFetch101Infos = false

	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self._onRefreshNorSignActivity, self)
end

function V2a9_VersionSummon_BaseViewContainer:getActMO()
	local actId = self:actId()

	return ActivityModel.instance:getActMO(actId)
end

function V2a9_VersionSummon_BaseViewContainer:getActRemainTimeStr()
	local actInfoMo = self:getActMO()

	if not actInfoMo then
		return ""
	end

	return actInfoMo:getRemainTimeStr3(false, true)
end

function V2a9_VersionSummon_BaseViewContainer:sendGet101BonusRequest(cb, cbObj)
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

function V2a9_VersionSummon_BaseViewContainer:isType101RewardCouldGetAnyOne()
	local actId = self:actId()
	local isOpen = ActivityType101Model.instance:isOpen(actId)

	return (isOpen or nil) and ActivityType101Model.instance:isType101RewardCouldGetAnyOne(actId)
end

return V2a9_VersionSummon_BaseViewContainer
