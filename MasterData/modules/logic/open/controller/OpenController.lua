-- chunkname: @modules/logic/open/controller/OpenController.lua

module("modules.logic.open.controller.OpenController", package.seeall)

local OpenController = class("OpenController", BaseController)

function OpenController:onInit()
	return
end

function OpenController:addConstEvents()
	OpenController.instance:registerCallback(OpenEvent.GetOpenInfoSuccess, self._onCheckFuncUnlock, self)
	MainController.instance:registerCallback(MainEvent.OnFuncUnlockRefresh, self._onCheckFuncUnlock, self)
	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, self._newFuncUnlock, self)
end

function OpenController:reInit()
	TaskDispatcher.cancelTask(self._delayCheckFuncUnlock, self)
end

function OpenController:_onCheckFuncUnlock()
	TaskDispatcher.cancelTask(self._delayCheckFuncUnlock, self)
	TaskDispatcher.runDelay(self._delayCheckFuncUnlock, self, 0.2)
end

function OpenController:_delayCheckFuncUnlock()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Friend) then
		FriendRpc.instance:sendLoadFriendInfosRequest()
	end

	SignInController.instance:sendGetSignInInfoRequestIfUnlock()

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Bank) then
		StoreRpc.instance:sendGetStoreInfosRequest()
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Explore) then
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.Explore
		})
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Task) then
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.Daily,
			TaskEnum.TaskType.Weekly,
			TaskEnum.TaskType.Novice,
			TaskEnum.TaskType.WeekWalk,
			TaskEnum.TaskType.WeekWalk_2,
			TaskEnum.TaskType.ActivityShow,
			TaskEnum.TaskType.Activity189
		})
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BGMSwitch) then
		BgmRpc.instance:sendGetBgmInfoRequest()
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Room) then
		RoomController.instance:sendInitRoomObInfo()
	end

	local isCritterUnlock = CritterModel.instance:isCritterUnlock()

	if isCritterUnlock then
		CritterRpc.instance:sendCritterGetInfoRequest()
	end

	MailRpc.instance:sendGetAllMailsRequest()
	ActivityRpc.instance:sendGetActivityInfosRequest(function()
		ActivityController.instance:updateAct101Infos()

		if ActivityModel.instance:isActOnLine(ActivityEnum.Activity.V2a9_Act208) then
			local channelId = Act208Helper.getCurPlatformType()

			Act208Controller.instance:getActInfo(ActivityEnum.Activity.V2a9_Act208, channelId)
		end
	end)
	HandbookRpc.instance:sendGetHandbookInfoRequest()
	RedDotRpc.instance:sendGetRedDotInfosRequest()
	DungeonRpc.instance:sendInstructionDungeonInfoRequest()

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BP) and not BpModel.instance:hasGetInfo() then
		BpRpc.instance:sendGetBpInfoRequest(false)
	end

	TurnbackController.instance:sendGetTurnbackInfoRequest()
	UserSettingRpc.instance:sendGetSettingInfosRequest()
	ItemRpc.instance:sendGetPowerMakerInfoRequest(false, true)
end

function OpenController:_newFuncUnlock(newIds)
	for i, id in ipairs(newIds) do
		if id == OpenEnum.UnlockFunc.Talent then
			HeroRpc.instance:sendHeroInfoListRequest(self._heroInfoUpdate, self)
		elseif id == OpenEnum.UnlockFunc.WeekWalk then
			WeekwalkRpc.instance:sendGetWeekwalkInfoRequest()
			Weekwalk_2Rpc.instance:sendWeekwalkVer2GetInfoRequest()
		elseif id == OpenEnum.UnlockFunc.Explore then
			ExploreRpc.instance:sendGetExploreSimpleInfoRequest()
		end
	end
end

function OpenController:_heroInfoUpdate()
	CharacterController.instance:tryStatAllTalent()
end

OpenController.instance = OpenController.New()

return OpenController
