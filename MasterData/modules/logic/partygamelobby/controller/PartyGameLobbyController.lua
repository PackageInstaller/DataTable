-- chunkname: @modules/logic/partygamelobby/controller/PartyGameLobbyController.lua

module("modules.logic.partygamelobby.controller.PartyGameLobbyController", package.seeall)

local PartyGameLobbyController = class("PartyGameLobbyController", BaseController)

function PartyGameLobbyController:onInit()
	self:reInit()
end

function PartyGameLobbyController:reInit()
	TaskDispatcher.cancelTask(self._delayUpdateOpenInfo, self)

	self._playerList = nil
	self._getRoomInfo = nil
	self._getMatchInfoTime = nil
	self._getMatchInfo = nil

	self:clearRoomStates()
end

function PartyGameLobbyController:onInitFinish()
	return
end

function PartyGameLobbyController:addConstEvents()
	self.registerCallback(self, PartyGameLobbyEvent.PartyInvitePush, self._onPartyInvitePush, self)
	self.registerCallback(self, PartyGameLobbyEvent.JoinPartyRoom, self._onJoinPartyRoom, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self._checkActivity, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnHour, self._onDayRefresh, self)
	GameSceneMgr.instance:registerCallback(SceneEventName.ExitScene, self._onExistScene, self)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, self._onEnterSceneFinish, self)
	PartyClothController.instance:registerCallback(PartyClothEvent.WearClothUpdate, self._onWearClothUpdate, self)
	SocialController.instance:registerCallback(SocialEvent.FriendsInfoChangedSpecial, self._onFriendsInfoChanged, self)
	PartyGameController.instance:registerCallback(PartyGameEvent.GuideNewGame, self._onGuideNewGame, self)
	GuideController.instance:registerCallback(GuideEvent.InterruptGuide, self._onInterruptGuide, self)
end

function PartyGameLobbyController:_onInterruptGuide(guideId)
	guideId = tonumber(guideId)

	if guideId and guideId >= PartyGameLobbyEnum.GuideIds.GuideId1 and guideId <= PartyGameLobbyEnum.GuideIds.GuideId6 then
		PartyGameController.instance:dispatchEvent(PartyGameEvent.GuideResultPause, 0)
		PartyGameController.instance:gamePause(false)

		if guideId <= PartyGameLobbyEnum.GuideIds.GuideId6 then
			GuideController.instance:toStartGudie(guideId + 1)
		end
	end
end

function PartyGameLobbyController:_onFriendsInfoChanged(noPlayer)
	if noPlayer then
		local curSceneType = GameSceneMgr.instance:getCurSceneType()

		if curSceneType == SceneType.PartyGameLobby then
			FriendRpc.instance:sendGetFriendInfoListRequest()

			return
		end

		if SocialModel.instance:checkGetInfo() then
			FriendRpc.instance:sendGetFriendInfoListRequest()
		end
	end
end

function PartyGameLobbyController:_onExistScene(curSceneType, curSceneId, nextSceneType)
	if curSceneType ~= nextSceneType and curSceneType == SceneType.PartyGameLobby then
		self._readyTime = nil

		TaskDispatcher.cancelTask(self._checkRoomOwnerReady, self)
		PartyGameRoomModel.instance:clearRoom()
	end
end

function PartyGameLobbyController:_onEnterSceneFinish(sceneType)
	if sceneType == SceneType.PartyGameLobby then
		self._checkRoomOwnerReadyTime = tonumber(PartyGameConfig.instance:getConstValue(19))

		TaskDispatcher.cancelTask(self._checkRoomOwnerReady, self)
		TaskDispatcher.runRepeat(self._checkRoomOwnerReady, self, 1)
	end
end

function PartyGameLobbyController:_checkRoomOwnerReady()
	if PartyGameRoomModel.instance:inGameRoom() and not PartyGameRoomModel.instance:inGameMatch() and PartyGameRoomModel.instance:isRoomOwner() and PartyGameRoomModel.instance:isAllReady() and PartyGameRoomModel.instance:getPlayerNum() > 1 then
		self._readyTime = self._readyTime or Time.time

		if self._readyTime and Time.time - self._readyTime >= self._checkRoomOwnerReadyTime then
			self._readyTime = nil

			logNormal("PartyGameLobbyController:_checkRoomOwnerReady ExitPartyRoom")
			PartyRoomRpc.instance:sendExitPartyRoomRequest(PlayerModel.instance:getMyUserId(), PartyGameRoomModel.instance:getRoomId())
		end
	else
		self._readyTime = nil
	end
end

function PartyGameLobbyController:_onDayRefresh()
	self:_delayUpdateOpenInfo()
end

function PartyGameLobbyController:_checkActivity(actId)
	if actId and actId ~= VersionActivity3_9Enum.ActivityId.V3_A9_PartyGame then
		return
	end

	TaskDispatcher.cancelTask(self._delayUpdateOpenInfo, self)

	actId = VersionActivity3_9Enum.ActivityId.V3_A9_PartyGame

	if not ActivityModel.instance:isActOnLine(VersionActivity3_9Enum.ActivityId.V3_A9_PartyGame) then
		return
	end

	local openId = PartyGameLobbyEnum.DailyOpenId

	self._actOpenId = openId

	local openCO = OpenConfig.instance:getOpenCo(openId)

	if not openCO then
		return
	end

	local dailyOpenTime = openCO.dailyOpenTime
	local openTimeParams = GameUtil.splitString2(dailyOpenTime, true, "|", "#")

	if openTimeParams and #openTimeParams <= 0 then
		logError("PartyGameLobbyController:_checkActivity error openId = ", tostring(openId), " dailyOpenTime = ", tostring(dailyOpenTime))

		return
	end

	local deltaTime = 0

	for i, timeParams in ipairs(openTimeParams) do
		local time = self:_getRefreshTime(timeParams, dailyOpenTime)

		if time and time > 0 then
			deltaTime = deltaTime == 0 and time or math.min(deltaTime, time)
		end
	end

	if deltaTime > 0 then
		TaskDispatcher.runDelay(self._delayUpdateOpenInfo, self, deltaTime + 0.5)
	else
		logError("PartyGameLobbyController:_checkActivity no refreshTime openId = ", tostring(openId), " dailyOpenTime = ", tostring(dailyOpenTime))
		TaskDispatcher.runDelay(self._delayUpdateOpenInfo, 1)
	end
end

function PartyGameLobbyController:_getRefreshTime(timeParams, dailyOpenTime)
	local startTime = math.min(timeParams[1], timeParams[2])
	local endTime = math.max(timeParams[1], timeParams[2])

	if startTime == endTime then
		logError("PartyGameLobbyController:_getRefreshTime startTime == endTime dailyOpenTime:", dailyOpenTime)

		return
	end

	local time = ServerTime.now()
	local serverDate = ServerTime.nowDateInLocal()

	serverDate.hour = 0
	serverDate.min = 0
	serverDate.sec = 0

	local timeStamp = TimeUtil.dtTableToTimeStamp(serverDate) - ServerTime.clientToServerOffset() - ServerTime.getDstOffset()
	local startTimeStamp = timeStamp + startTime * 3600
	local endTimeStamp = timeStamp + endTime * 3600
	local deltaTime = 0

	if time < startTimeStamp then
		deltaTime = startTimeStamp - time
	elseif time < endTimeStamp then
		deltaTime = endTimeStamp - time
	end

	return deltaTime
end

function PartyGameLobbyController:_delayUpdateOpenInfo()
	if not ActivityModel.instance:isActOnLine(VersionActivity3_9Enum.ActivityId.V3_A9_PartyGame) then
		return
	end

	self._oldOpenTimeStatus = self:inOpenTime()

	OpenRpc.instance:sendGetOpenInfoRequest(self._actOpenId, function()
		local newOpenTimeStatus = self:inOpenTime()

		if self._oldOpenTimeStatus ~= newOpenTimeStatus then
			PartyGameLobbyController.instance:dispatchEvent(PartyGameLobbyEvent.OpenTimeStatusChange, newOpenTimeStatus)
			self:checkActivityDailyOpen(newOpenTimeStatus)

			self._oldOpenTimeStatus = newOpenTimeStatus
		end

		self:_checkActivity()
	end)
end

function PartyGameLobbyController:forceUpdateOpenInfo()
	self:_delayUpdateOpenInfo()
end

function PartyGameLobbyController:checkActivityDailyOpen(isOpen)
	local curSceneType = GameSceneMgr.instance:getCurSceneType()

	if curSceneType ~= SceneType.PartyGameLobby then
		return
	end

	if not isOpen then
		if PartyGameRoomModel.instance:isRoomOwner() and PartyGameRoomModel.instance:inGameMatch() then
			PartyMatchRpc.instance:sendCancelPartyMatchRequest(PlayerModel.instance:getMyUserId(), PartyGameRoomModel.instance:getRoomId())
		end

		if PartyGameRoomModel.instance:inGameRoom() and not PartyGameRoomModel.instance:inGameMatch() then
			PartyRoomRpc.instance:sendExitPartyRoomRequest(PlayerModel.instance:getMyUserId(), PartyGameRoomModel.instance:getRoomId())
		end

		local function yesFunc()
			self:openActivityEnterView()
		end

		GameFacade.showMessageBox(MessageBoxIdDefine.PartyGameTimeoutTip, MsgBoxEnum.BoxType.Yes, yesFunc)
	end
end

function PartyGameLobbyController:inOpenTime()
	if PartyGameLobbyEnum.FakeInCloseTime then
		logError("PartyGameLobbyEnum.FakeInCloseTime")

		return false
	end

	return ActivityModel.instance:isActOnLine(VersionActivity3_9Enum.ActivityId.V3_A9_PartyGame) and OpenModel.instance:isFunctionUnlock(PartyGameLobbyEnum.DailyOpenId)
end

function PartyGameLobbyController:_onJoinPartyRoom()
	local curSceneType = GameSceneMgr.instance:getCurSceneType()

	if curSceneType ~= SceneType.PartyGameLobby then
		self:enterGameLobby()
	end
end

function PartyGameLobbyController:_onOpenView()
	self:_checkPartyInviteTip()
end

function PartyGameLobbyController:_onWearClothUpdate()
	self._wearClothUpdate = ViewMgr.instance:isOpen(ViewName.PartyClothView)
end

function PartyGameLobbyController:_onCloseViewFinish(viewName)
	self:_checkPartyInviteTip()

	if viewName == ViewName.PartyClothView and self._wearClothUpdate then
		self._wearClothUpdate = false
	end
end

function PartyGameLobbyController:sendUploadPartyClothInfo()
	if PartyGameRoomModel.instance:inGameRoom() and not PartyGameRoomModel.instance:inGameMatch() then
		PartyRoomRpc.instance:sendUploadPartyClothInfoRequest(PartyGameRoomModel.instance:getRoomId())
	end
end

function PartyGameLobbyController:_checkPartyInviteTip()
	if not self:_canShowInviteTip() then
		ToastController.instance:dispatchEvent(ToastEvent.ClearToast, ToastEnum.PartyGameLobbyInviteTip)
	end
end

function PartyGameLobbyController.clearInviteTip(msg)
	PartyRoomRpc.instance:sendRefuseInviteRequest(PlayerModel.instance:getMyUserId(), msg.extraParams.roomId, msg.extraParams.fromUserId)
end

function PartyGameLobbyController:_onPartyInvitePush(params)
	if self:_canShowInviteTip() then
		if not SocialModel.instance:checkGetInfo() then
			FriendRpc.instance:sendGetFriendInfoListRequest(function()
				if SocialModel.instance:checkGetInfo() then
					PartyGameLobbyController.instance:showInviteTip(params.fromUserId, params)
				else
					PartyRoomRpc.instance:sendRefuseInviteRequest(PlayerModel.instance:getMyUserId(), params.roomId, params.fromUserId)
				end
			end, nil)
		else
			PartyGameLobbyController.instance:showInviteTip(params.fromUserId, params)
		end
	else
		PartyRoomRpc.instance:sendRefuseInviteRequest(PlayerModel.instance:getMyUserId(), params.roomId, params.fromUserId)
	end
end

function PartyGameLobbyController:_canShowInviteTip()
	local curSceneType = GameSceneMgr.instance:getCurSceneType()

	if curSceneType == SceneType.Main and ViewHelper.instance:checkViewOnTheTop(ViewName.MainView) then
		return true
	end

	if ViewMgr.instance:isOpen(ViewName.PartyGameLobbyStoreView) then
		return false
	end

	if not GuideController.instance:isForbidGuides() and GuideModel.instance:isDoingClickGuide() then
		logNormal("PartyGameLobbyController _canShowInviteTip 有引导，不显示邀请提示")

		return false
	end

	return curSceneType == SceneType.PartyGameLobby and self._curRoomState == PartyGameLobbyEnum.RoomState.None or self._curRoomState == PartyGameLobbyEnum.RoomState.Create and ViewMgr.instance:isOpen(ViewName.PartyGameLobbyMainView)
end

function PartyGameLobbyController:sendInteraction(emojIndex, x, y)
	if not PartyGameRoomModel.instance:inGameRoom() then
		return
	end

	gohelper.setActive(self._goemojiTips, false)

	self._playerList = self._playerList or {}

	tabletool.clear(self._playerList)
	PartyGameRoomModel.instance:getOtherPlayerList(self._playerList)

	if #self._playerList <= 0 then
		return
	end

	if emojIndex > 0 then
		PartyRoomRpc.instance:sendPartyRoomInteractRequest(PlayerModel.instance:getMyUserId(), PartyGameRoomModel.instance:getRoomId(), self._playerList, emojIndex)
	else
		PartyRoomRpc.instance:sendPartyRoomPosSyncRequest(PartyGameRoomModel.instance:getRoomId(), self._playerList, math.floor(x * PartyGameLobbyEnum.MovePosScale), math.floor(y * PartyGameLobbyEnum.MovePosScale))
	end
end

function PartyGameLobbyController:sendPartyServerListRequest()
	if PartyGameRoomModel.instance._partyServers == nil or tabletool.len(PartyGameRoomModel.instance._partyServers) > 0 then
		return
	end

	PartyMatchRpc.instance:sendPartyServerListRequest()
end

function PartyGameLobbyController:GetPartyRoomInfo()
	self:sendPartyServerListRequest()

	if not self._getRoomInfo then
		self._getRoomInfo = true

		PartyRoomRpc.instance:sendClearAndRefreshPartyRoomInfoRequest(self._onGetPartyRoomInfo, self)

		return
	end

	if self._getMatchInfo and self._getMatchInfoTime and Time.time - self._getMatchInfoTime < 15 then
		PartyRoomRpc.instance:onReceiveClearAndRefreshPartyRoomInfoReply(0, self._getMatchInfo)

		return
	end

	PartyRoomRpc.instance:sendGetPartyRoomInfoRequest(self._onGetPartyRoomInfo, self)
end

function PartyGameLobbyController:_onGetPartyRoomInfo(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local roomId = tonumber(msg.roomId)

	if msg:HasField("matchInfo") then
		if not msg.matchInfo then
			local matchInfo

			if matchInfo and roomId and roomId > 0 then
				self._getMatchInfo = msg
				self._getMatchInfoTime = Time.time
			else
				self._getMatchInfo = nil
				self._getMatchInfoTime = nil
			end
		end
	end
end

function PartyGameLobbyController:clearRoomStates()
	self._curRoomState = nil
	self._prevRoomState = nil
end

function PartyGameLobbyController:getRoomState()
	return self._curRoomState
end

function PartyGameLobbyController:setRoomState(state)
	self._prevRoomState = self._curRoomState
	self._curRoomState = state

	self:dispatchEvent(PartyGameLobbyEvent.RoomStateChange, self._curRoomState, self._prevRoomState)
end

function PartyGameLobbyController:clearSuccessMatchInfo()
	return
end

function PartyGameLobbyController:setAllGuidesFinish()
	for guideId = PartyGameLobbyEnum.GuideIds.FirstGuideId, PartyGameLobbyEnum.GuideIds.LastGuideId do
		GuideInvalidController.instance:setGuideInvalid(guideId, true)
	end
end

function PartyGameLobbyController:enterGameLobbyGuide()
	if GuideController.instance:isForbidGuides() then
		return
	end

	PartyGameRpc.instance:setUpKcpRpcCallBack()
	PartyGameController.instance:setUpLuaCallBack()

	self._guideList = self._guideList or {
		[34012] = self.guideEnterGame1,
		[34013] = self.guideEnterGameRewardGuideView1,
		[34014] = self.guideEnterCardDropGame1,
		[34015] = self.guideEnterGame2,
		[34016] = self.guideEnterGameRewardGuideView2,
		[34017] = self.guideEnterCardDropGame2
	}

	if self._guideList then
		for i = 34012, 34017 do
			if GuideModel.instance:isGuideRunning(i) then
				local func = self._guideList[i]

				if func then
					logNormal("enterGameLobbyGuide run guide:", tostring(i))
					func(self)
				end

				return true
			end
		end
	end
end

function PartyGameLobbyController:_onGuideNewGame(param)
	local gameId = tonumber(param)

	if gameId == PartyGameLobbyEnum.GuideParam.Game2 then
		self:guideEnterGame2()

		return
	elseif gameId == PartyGameLobbyEnum.GuideParam.Game1 then
		self:guideEnterGame1()

		return
	end

	logError("PartyGameLobbyController:_onGuideNewGame not found game:", tostring(gameId))
end

function PartyGameLobbyController:guideEnterGame1()
	logNormal("PartyGameLobbyController:guideEnterGame1")
	PartyGameController.instance:initFakePlayerData(4, nil, nil, 1)
	PartyGameController.instance:enterGame(PartyGameLobbyEnum.GuideParam.Game1, true)
end

function PartyGameLobbyController:guideEnterGame2()
	logNormal("PartyGameLobbyController:guideEnterGame2")
	PartyGameController.instance:initFakePlayerData(2)
	PartyGameController.instance:enterGame(PartyGameLobbyEnum.GuideParam.Game2, true)
end

function PartyGameLobbyController:guideEnterCardDropGame1()
	logNormal("PartyGameLobbyController:guideEnterCardDropGame1")
	CardDropGameController.instance:setGuideTime(1)
	PartyGameController.instance:initFakePlayerData(4, 24, 26, 101)
	PartyGameController.instance:enterGame(PartyGameLobbyEnum.GuideParam.CardDropGame, true)
end

function PartyGameLobbyController:guideEnterCardDropGame2()
	logNormal("PartyGameLobbyController:guideEnterCardDropGame2")
	CardDropGameController.instance:setGuideTime(2)
	PartyGameController.instance:initFakePlayerData(2, 25, 27, 101)
	PartyGameController.instance:enterGame(PartyGameLobbyEnum.GuideParam.CardDropGame, true)
end

function PartyGameLobbyController:guideEnterGameRewardGuideView1()
	logNormal("PartyGameLobbyController:guideEnterGameRewardGuideView1")
	ViewMgr.instance:openView(ViewName.PartyGameRewardGuideView, {
		selectCard = PartyGameLobbyEnum.GuideParam.Result1SelectCard
	})
end

function PartyGameLobbyController:guideEnterGameRewardGuideView2()
	logNormal("PartyGameLobbyController:guideEnterGameRewardGuideView2")
	ViewMgr.instance:openView(ViewName.PartyGameRewardGuideView, {
		selectCard = PartyGameLobbyEnum.GuideParam.Result2SelectCard
	})
end

function PartyGameLobbyController:enterStore()
	local _bigVersion, _smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()

	VersionActivityFixedHelper.getVersionActivityDungeonController(_bigVersion, _smallVersion).instance:openStoreView(VersionActivity3_9Enum.ActivityId.V3_A9_PartyGameStore, ViewName.PartyGameLobbyStoreView)
end

function PartyGameLobbyController:_onEnterMainSceneDone()
	VersionActivity3_9EnterController.instance:directOpenVersionActivityEnterView(VersionActivity3_9Enum.ActivityId.V3_A9_PartyGame)
end

function PartyGameLobbyController:openActivityEnterView()
	GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.PartyGameLobbyLoadingView)

	if ActivityModel.instance:isActOnLine(VersionActivity3_9Enum.ActivityId.V3_A9_PartyGame) then
		SceneHelper.instance:waitSceneDone(SceneType.Main, self._onEnterMainSceneDone, self)
	end

	MainController.instance:enterMainScene()
end

function PartyGameLobbyController:enterGameLobby()
	if not self:inOpenTime() then
		local curSceneType = GameSceneMgr.instance:getCurSceneType()

		if curSceneType ~= SceneType.Main then
			self:openActivityEnterView()
		end

		logNormal("PartyGameLobbyController:enterGameLobby not in open time")

		return
	end

	PartyGameRpc.instance:setUpKcpRpcCallBack()
	PartyGameController.instance:setUpLuaCallBack()
	GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.PartyGameLobbyLoadingView)
	GameSceneMgr.instance:startScene(SceneType.PartyGameLobby, 1, 1, true)
	PartyGameTrialController.instance:clearTrialData()
end

function PartyGameLobbyController:openPartyGameLobbyAddRoomView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.PartyGameLobbyAddRoomView, param, isImmediate)
end

function PartyGameLobbyController:openPartyGameLobbyInRoomView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.PartyGameLobbyInRoomView, param, isImmediate)
end

function PartyGameLobbyController:openPartyGameLobbyMatchView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.PartyGameLobbyMatchView, param, isImmediate)
end

function PartyGameLobbyController:openPartyGameLobbyFriendListView()
	ViewMgr.instance:openView(ViewName.PartyGameLobbyFriendListView)
end

function PartyGameLobbyController:setSkipGame(type)
	if type == PartyGameLobbyEnum.SkipGame.Verison then
		if not MessageBoxIdDefine.PartyGameLobbyTips1 then
			local msgId = MessageBoxIdDefine.PartyGameLobbyTips4

			local function yesFunc()
				GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.PartyGameLobbyLoadingView)

				if ActivityModel.instance:isActOnLine(VersionActivity3_9Enum.ActivityId.V3_A9_PartyGame) then
					SceneHelper.instance:waitSceneDone(SceneType.Main, self._onEnterMainSceneDone, self)
				end

				MainController.instance:enterMainScene()
			end

			GameFacade.showMessageBox(msgId, MsgBoxEnum.BoxType.Yes, yesFunc)
		end
	end
end

function PartyGameLobbyController:showNewPlayerEnterTip(id)
	PartyGameLobbyController.instance:showToast(ToastEnum.PartyGameLobbyJoinTip, PartyGameLobbyEnum.TipsRes.Join, PartyGameLobbyRoomTipsItem, id)
end

function PartyGameLobbyController:showInviteTip(id, extraParams)
	PartyGameLobbyController.instance:showToast(ToastEnum.PartyGameLobbyInviteTip, PartyGameLobbyEnum.TipsRes.Invite, PartyGameLobbyInviteTipsItem, id, extraParams)
end

function PartyGameLobbyController:showToast(toastId, resPath, toastItemComp, id, extraParams)
	local toastParam = {
		resPath = resPath,
		toastItemComp = toastItemComp,
		id = id,
		extraParams = extraParams
	}

	ToastController.instance:showToastWithCustomData(toastId, self.fillToastObj, self, toastParam, tostring(id))
end

function PartyGameLobbyController:fillToastObj(toastObj, toastParam)
	local callbackGroup = ToastCallbackGroup.New()

	callbackGroup.onClose = self.onCloseWhenToastRemove
	callbackGroup.onCloseObj = self
	callbackGroup.onCloseParam = toastParam
	callbackGroup.onOpen = self.onOpenToast
	callbackGroup.onOpenObj = self
	callbackGroup.onOpenParam = toastParam
	toastObj.callbackGroup = callbackGroup
end

function PartyGameLobbyController:onOpenToast(toastParam, toastItem)
	toastParam.item = PartyGameLobbyRoomTipsLoader.New()

	toastParam.item:init(toastItem, toastParam)
end

function PartyGameLobbyController:onCloseWhenToastRemove(toastParam, toastItem)
	if toastParam.item then
		toastParam.item:dispose()

		toastParam.item = nil
	end
end

PartyGameLobbyController.instance = PartyGameLobbyController.New()

return PartyGameLobbyController
