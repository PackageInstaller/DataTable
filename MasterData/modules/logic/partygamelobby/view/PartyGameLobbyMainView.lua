-- chunkname: @modules/logic/partygamelobby/view/PartyGameLobbyMainView.lua

module("modules.logic.partygamelobby.view.PartyGameLobbyMainView", package.seeall)

local PartyGameLobbyMainView = class("PartyGameLobbyMainView", BaseView)

function PartyGameLobbyMainView:onInitView()
	self._goplayerhead = gohelper.findChild(self.viewGO, "root/#go_playerhead")
	self._gojoystick = gohelper.findChild(self.viewGO, "root/#go_joystick")
	self._gogameCreate = gohelper.findChild(self.viewGO, "root/#go_gameCreate")
	self._btnmutiPlayer = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_gameCreate/#btn_mutiPlayer")
	self._btnsinglePlayer = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_gameCreate/#btn_singlePlayer")
	self._btncloth = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_gameCreate/#btn_cloth")
	self._btninput = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_gameCreate/#btn_input")
	self._btnexit = gohelper.findChildButtonWithAudio(self.viewGO, "go_topleft/#btn_exit")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PartyGameLobbyMainView:addEvents()
	self._btnmutiPlayer:AddClickListener(self._btnmutiPlayerOnClick, self)
	self._btnsinglePlayer:AddClickListener(self._btnsinglePlayerOnClick, self)
	self._btncloth:AddClickListener(self._btnclothOnClick, self)
	self._btninput:AddClickListener(self._btninputOnClick, self)
	self._btnexit:AddClickListener(self._btnexitOnClick, self)
end

function PartyGameLobbyMainView:removeEvents()
	self._btnmutiPlayer:RemoveClickListener()
	self._btnsinglePlayer:RemoveClickListener()
	self._btncloth:RemoveClickListener()
	self._btninput:RemoveClickListener()
	self._btnexit:RemoveClickListener()
end

function PartyGameLobbyMainView:_btnclothOnClick()
	PartyClothController.instance:openPartyClothView()
end

function PartyGameLobbyMainView:_btnmutiPlayerOnClick()
	PartyRoomRpc.instance:simpleCreatePartyRoomReq()
end

function PartyGameLobbyMainView:_btnsinglePlayerOnClick()
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.PartyGameLocalGame1) then
		GuideModel.instance:clearFlagValue(GuideModel.GuideFlag.PartyGameLocalGame1)

		return
	end

	PartyMatchRpc.instance:simpleSingleStartPartyMatchReq()
end

function PartyGameLobbyMainView:_btninputOnClick()
	PartyGameLobbyController.instance:setRoomState(PartyGameLobbyEnum.RoomState.Create)
end

function PartyGameLobbyMainView:_btnexitOnClick()
	if PartyGameRoomModel.instance:inGameRoom() then
		local function yesFunc()
			self:_onExitParty()
		end

		GameFacade.showMessageBox(MessageBoxIdDefine.PartyGameLobbyTips5, MsgBoxEnum.BoxType.Yes_No, yesFunc)

		return
	end

	self:_onExitParty()
end

function PartyGameLobbyMainView:_onExitParty()
	if PartyGameRoomModel.instance:inGameRoom() and not PartyGameRoomModel.instance:inGameMatch() then
		PartyRoomRpc.instance:sendExitPartyRoomRequest(PlayerModel.instance:getMyUserId(), PartyGameRoomModel.instance:getRoomId())
	end

	GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.PartyGameLobbyLoadingView)
	SceneHelper.instance:waitSceneDone(SceneType.Main, self._onEnterMainSceneDone, self)
	MainController.instance:enterMainScene()
end

function PartyGameLobbyMainView:_onEnterMainSceneDone()
	VersionActivity3_9EnterController.instance:directOpenVersionActivityEnterView(VersionActivity3_9Enum.ActivityId.V3_A9_PartyGame)
end

function PartyGameLobbyMainView:_editableInitView()
	self._btntrialplay = gohelper.findChildButtonWithAudio(self.viewGO, "go_topleft/#btn_trialplay")

	self._btntrialplay:AddClickListener(self._btnTrialPlayerOnClick, self)

	local itemRes = self.viewContainer:getSetting().otherRes.joystick
	local go = self.viewContainer:getResInst(itemRes, self._gojoystick)

	MonoHelper.addNoUpdateLuaComOnceToGo(go, PartyGameLobbyJoystickComp)
	recthelper.setSize(go.transform, 300, 300)
	gohelper.setActive(self._gobuildingArrow, false)
	gohelper.setActive(self._gobuildingBubble, false)
	gohelper.setActive(self._gogameCreate, false)

	self._createAnimator = self._gogameCreate:GetComponent("Animator")

	local roomIsOpen = tonumber(PartyGameConfig.instance:getConstValue(13)) == 0

	gohelper.setActive(self._btnmutiPlayer, roomIsOpen)
	gohelper.setActive(self._btninput, roomIsOpen)
	NavigateMgr.instance:addEscape(self.viewName, self._btnexitOnClick, self)
end

function PartyGameLobbyMainView:onUpdateParam()
	return
end

function PartyGameLobbyMainView:onOpen()
	self._roomStateViewMap = {
		[PartyGameLobbyEnum.RoomState.InRoom] = {
			ViewName.PartyGameLobbyInRoomView,
			ViewName.PartyGameLobbyFriendListView,
			ViewName.PartyGameLobbyFriendDetailView
		},
		[PartyGameLobbyEnum.RoomState.Create] = {
			ViewName.PartyGameLobbyAddRoomView
		},
		[PartyGameLobbyEnum.RoomState.InMatch] = {
			ViewName.PartyGameLobbyMatchView
		}
	}

	self.addEventCb(self, PartyGameLobbyController.instance, PartyGameLobbyEvent.RoomStateChange, self._onRoomStateChange, self)
	self.addEventCb(self, PartyGameLobbyController.instance, PartyGameLobbyEvent.MatchStatusChange, self._onMatchStatusChange, self)
	self.addEventCb(self, PartyGameLobbyController.instance, PartyGameLobbyEvent.CreatePartyRoom, self._onCreatePartyRoom, self)
	self.addEventCb(self, PartyGameLobbyController.instance, PartyGameLobbyEvent.ExitPartyRoom, self._onExitPartyRoom, self)
	self.addEventCb(self, PartyGameLobbyController.instance, PartyGameLobbyEvent.CustomGetPartyRoomInfo, self._onClearAndRefreshPartyRoomInfo, self)
	self.addEventCb(self, PartyGameLobbyController.instance, PartyGameLobbyEvent.JoinPartyRoom, self._onJoinPartyRoom, self)
	self.addEventCb(self, PartyGameLobbyController.instance, PartyGameLobbyEvent.GetInviteList, self._onGetInviteList, self)
	self.addEventCb(self, PartyGameLobbyController.instance, PartyGameLobbyEvent.KickedOutPush, self._onKickedOutPush, self)
	self.addEventCb(self, PartyGameLobbyController.instance, PartyGameLobbyEvent.PartyNeedLogoutPush, self._onPartyNeedLogoutPush, self)
	self.addEventCb(self, PartyGameController.instance, PartyGameEvent.KcpConnectFail, self._onKcpConnectFail, self)

	if not PartyGameLobbyController.instance:inOpenTime() then
		self:_onOpenTimeStatusChange(false)

		return
	end

	if PartyGameLobbyController.instance:enterGameLobbyGuide() then
		return
	end

	PartyClothController.instance:tryGetPartyWearInfo()

	if PartyGameRoomModel.instance:inGameRoom() then
		PartyGameLobbyController.instance:setRoomState(PartyGameLobbyEnum.RoomState.InRoom)
	else
		PartyGameLobbyController.instance:setRoomState(PartyGameLobbyEnum.RoomState.None)
		PartyGameLobbyController.instance:GetPartyRoomInfo()
	end

	if not SocialModel.instance:checkGetInfo() then
		FriendRpc.instance:sendGetFriendInfoListRequest()
	end
end

function PartyGameLobbyMainView:_onKcpConnectFail()
	PartyGameLobbyController.instance:GetPartyRoomInfo()
end

function PartyGameLobbyMainView:_onPartyNeedLogoutPush(needLogoutUserIds)
	local myUserId = PlayerModel.instance:getMyUserId()

	if tabletool.indexOf(needLogoutUserIds, myUserId) then
		local function yesFunc()
			LoginController.instance:logout()
		end

		GameFacade.showMessageBox(MessageBoxIdDefine.PartyGameLobbyTips2, MsgBoxEnum.BoxType.Yes, yesFunc)
	else
		GameFacade.showMessageBox(MessageBoxIdDefine.PartyGameLobbyTips3, MsgBoxEnum.BoxType.Yes)
	end
end

function PartyGameLobbyMainView:_onOpenTimeStatusChange(isOpen)
	PartyGameLobbyController.instance:checkActivityDailyOpen(isOpen)
end

function PartyGameLobbyMainView:_onKickedOutPush()
	if not PartyGameRoomModel.instance:inGameRoom() then
		PartyGameLobbyController.instance:setRoomState(PartyGameLobbyEnum.RoomState.None)
	end
end

function PartyGameLobbyMainView:_onGetInviteList()
	PartyGameLobbyController.instance:openPartyGameLobbyFriendListView()
end

function PartyGameLobbyMainView:_onJoinPartyRoom()
	if PartyGameRoomModel.instance:inGameRoom() then
		PartyGameLobbyController.instance:setRoomState(PartyGameLobbyEnum.RoomState.InRoom)
	end
end

function PartyGameLobbyMainView:_onClearAndRefreshPartyRoomInfo(matchInfo)
	if matchInfo then
		if PartyGameRoomModel.instance:inGameRoom() then
			PartyGameLobbyController.instance:setSkipGame(PartyGameLobbyEnum.SkipGame.Playing)

			return
		end

		PartyRoomRpc.instance:sendResetPartyInviteStateRequest()
		PartyRoomRpc.instance:sendClearSuccessMatchInfoRequest()
	end

	if PartyGameRoomModel.instance:inGameRoom() then
		if PartyGameRoomModel.instance:inGameMatch() then
			PartyGameLobbyController.instance:setRoomState(PartyGameLobbyEnum.RoomState.InMatch)
		else
			local myPlayerInfo = PartyGameRoomModel.instance:getMyPlayerInfo()
			local resVersion = PartyGameRoomModel.getResVersion()

			if myPlayerInfo and myPlayerInfo.version ~= resVersion then
				PartyRoomRpc.instance:sendUpdatePartyClientVersionRequest(PartyGameRoomModel.instance:getRoomId(), resVersion)
			end

			PartyGameLobbyController.instance:setRoomState(PartyGameLobbyEnum.RoomState.InRoom)
		end
	end
end

function PartyGameLobbyMainView:_onGetPartyRoomInfo(matchInfo)
	return
end

function PartyGameLobbyMainView:_onExitPartyRoom()
	PartyGameLobbyController.instance:setRoomState(PartyGameLobbyEnum.RoomState.None)
end

function PartyGameLobbyMainView:_onCreatePartyRoom()
	PartyGameLobbyController.instance:setRoomState(PartyGameLobbyEnum.RoomState.InRoom)
end

function PartyGameLobbyMainView:_onMatchStatusChange(curMatchState, prevMatchState)
	if curMatchState == PartyGameLobbyEnum.MatchStatus.NoMatch then
		if PartyGameRoomModel.instance:inGameRoom() then
			PartyGameLobbyController.instance:setRoomState(PartyGameLobbyEnum.RoomState.InRoom)
		else
			PartyGameLobbyController.instance:setRoomState(PartyGameLobbyEnum.RoomState.None)
		end
	elseif curMatchState == PartyGameLobbyEnum.MatchStatus.StartMatch or curMatchState == PartyGameLobbyEnum.MatchStatus.Matching or curMatchState == PartyGameLobbyEnum.MatchStatus.MatchSuccess then
		if PartyGameLobbyController.instance:getRoomState() ~= PartyGameLobbyEnum.RoomState.InMatch then
			PartyGameLobbyController.instance:setRoomState(PartyGameLobbyEnum.RoomState.InMatch)
		end
	else
		logError("PartyGameLobbyMainView _onMatchStatusChange error state:", tostring(curMatchState))
	end
end

function PartyGameLobbyMainView:_onRoomStateChange(curRoomState, prevRoomState)
	local oldShowCreateRoom = self._showCreateRoom

	self._showCreateRoom = curRoomState == PartyGameLobbyEnum.RoomState.None

	gohelper.setActive(self._gogameCreate, self._showCreateRoom)

	if curRoomState == PartyGameLobbyEnum.RoomState.Create then
		PartyGameLobbyController.instance:openPartyGameLobbyAddRoomView()
	elseif curRoomState == PartyGameLobbyEnum.RoomState.InRoom then
		PartyGameLobbyController.instance:setAllGuidesFinish()
		PartyGameLobbyController.instance:openPartyGameLobbyInRoomView()
	elseif curRoomState == PartyGameLobbyEnum.RoomState.InMatch then
		PartyGameLobbyController.instance:setAllGuidesFinish()
		PartyGameLobbyController.instance:openPartyGameLobbyMatchView()
	elseif curRoomState == PartyGameLobbyEnum.RoomState.None then
		if oldShowCreateRoom ~= self._showCreateRoom then
			self._createAnimator:Play(self._showCreateRoom and "in" or "out")
		end
	else
		logError("PartyGameLobbyMainView _onRoomStateChange error state:", tostring(curRoomState))
	end

	if prevRoomState ~= curRoomState then
		self:_closeViewByState(prevRoomState)
	end

	gohelper.setActive(self._btnexit, curRoomState ~= PartyGameLobbyEnum.RoomState.InMatch)

	if prevRoomState == PartyGameLobbyEnum.RoomState.InRoom then
		self:_closeOtherView()
	end
end

function PartyGameLobbyMainView:_closeOtherView()
	ViewMgr.instance:closeView(ViewName.PlayerView)
	ViewMgr.instance:closeView(ViewName.NewPlayerCardContentView)
	ViewMgr.instance:closeView(ViewName.PartyGameLobbyPlayerInfoView)
end

function PartyGameLobbyMainView:_closeViewByState(roomState)
	local viewList = self._roomStateViewMap[roomState]

	if viewList then
		for _, viewName in ipairs(viewList) do
			ViewMgr.instance:closeView(viewName)
		end
	end
end

function PartyGameLobbyMainView:onClose()
	PartyGameLobbyController.instance:clearRoomStates()

	for k, list in pairs(self._roomStateViewMap) do
		for i, viewName in ipairs(list) do
			ViewMgr.instance:closeView(viewName)
		end
	end
end

function PartyGameLobbyMainView:_btnTrialPlayerOnClick()
	local matchStatus = PartyGameRoomModel.instance:getMatchStatus()
	local roomState = PartyGameLobbyController.instance:getRoomState()

	if matchStatus ~= nil and matchStatus ~= PartyGameLobbyEnum.MatchStatus.NoMatch or roomState ~= PartyGameLobbyEnum.RoomState.None then
		ToastController.instance:showToast(ExploreConstValue.Toast.ExploreCantTrigger)

		return
	end

	PartyGameTrialController.instance:enterTrialView()
end

function PartyGameLobbyMainView:onDestroyView()
	self._btntrialplay:RemoveClickListener()
end

return PartyGameLobbyMainView
