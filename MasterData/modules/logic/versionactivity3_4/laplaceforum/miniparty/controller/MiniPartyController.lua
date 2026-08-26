-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/miniparty/controller/MiniPartyController.lua

module("modules.logic.versionactivity3_4.laplaceforum.miniparty.controller.MiniPartyController", package.seeall)

local MiniPartyController = class("MiniPartyController", BaseController)

function MiniPartyController:onInit()
	self:reInit()
end

function MiniPartyController:reInit()
	self._hasGet = nil
end

function MiniPartyController:onInitFinish()
	return
end

function MiniPartyController:addConstEvents()
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self._refreshActInfo, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
end

function MiniPartyController:_onDailyRefresh()
	self._hasGet = nil

	self:_refreshActInfo()
end

function MiniPartyController:_refreshActInfo()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity3_4Enum.ActivityId.LaplaceMiniParty]

	if not actInfoMo then
		return
	end

	local isExpired = actInfoMo:getRealEndTimeStamp() - ServerTime.now() < 1
	local couldGet = actInfoMo:isOnline() and actInfoMo:isOpen() and not isExpired

	if couldGet and self._hasGet ~= couldGet then
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.MiniParty
		})

		if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Friend) then
			FriendRpc.instance:sendGetFriendInfoListRequest(self._onGetFriendInfoSuccess, self)
		end
	end

	self._hasGet = couldGet
end

function MiniPartyController:_onGetFriendInfoSuccess(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity223Rpc.instance:sendGetAct223InfoRequest(VersionActivity3_4Enum.ActivityId.LaplaceMiniParty)
end

MiniPartyController.instance = MiniPartyController.New()

return MiniPartyController
