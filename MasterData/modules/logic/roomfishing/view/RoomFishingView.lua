-- chunkname: @modules/logic/roomfishing/view/RoomFishingView.lua

module("modules.logic.roomfishing.view.RoomFishingView", package.seeall)

local RoomFishingView = class("RoomFishingView", BaseView)

function RoomFishingView:onInitView()
	self._goSelf = gohelper.findChild(self.viewGO, "Root/Left/playerInfo/#go_Self")
	self._goFriend = gohelper.findChild(self.viewGO, "Root/Left/playerInfo/#go_Friend")
	self._goheadicon = gohelper.findChild(self.viewGO, "Root/Left/playerInfo/#go_headicon")
	self._txtPlayerName = gohelper.findChildText(self.viewGO, "Root/Left/playerInfo/#txt_PlayerName")
	self._btnInfoCopy = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Left/playerInfo/#btn_Copy")
	self._txtrefreshTime = gohelper.findChildText(self.viewGO, "Root/Left/playerInfo/#txt_refreshTime")
	self._btnExpandFriendList = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Left/FriendList/#btn_Expand")
	self._input = gohelper.findChildTextMeshInputField(self.viewGO, "Root/Left/FriendList/#go_Expand/#input_inform")
	self._btnFoldFriendList = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Left/FriendList/#go_Expand/#btn_Fold")
	self._gounfishingTab = gohelper.findChild(self.viewGO, "Root/Left/FriendList/#go_Expand/Tab/Tab1/#go_Selected")
	self._btnunfishingTab = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Left/FriendList/#go_Expand/Tab/Tab1/image_TabBG")
	self._gofishingTab = gohelper.findChild(self.viewGO, "Root/Left/FriendList/#go_Expand/Tab/Tab2/#go_Selected")
	self._btnfishingTab = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Left/FriendList/#go_Expand/Tab/Tab2/image_TabBG")
	self._btnhide = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Left/btn_hide")
	self._btnback = gohelper.findChildButtonWithAudio(self.viewGO, "Root/btn_back")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomFishingView:addEvents()
	self._btnInfoCopy:AddClickListener(self._btnInfoCopyOnClick, self)
	self._btnExpandFriendList:AddClickListener(self._btnExpandFriendListOnClick, self)
	self._btnFoldFriendList:AddClickListener(self._btnFoldFriendListOnClick, self)
	self._btnunfishingTab:AddClickListener(self._btnFriendTabOnClick, self, FishingEnum.FriendListTag.UnFishing)
	self._btnfishingTab:AddClickListener(self._btnFriendTabOnClick, self, FishingEnum.FriendListTag.Fishing)
	self._btnhide:AddClickListener(self._btnHideOnClick, self)
	self._btnback:AddClickListener(self._btnbackOnClick, self)
	self._input:AddOnValueChanged(self._inputValueChanged, self)
	self._input:AddOnEndEdit(self._onEndEdit, self)
	self.addEventCb(self, FishingController.instance, FishingEvent.OnFishingInfoUpdate, self._onFishingInfoUpdate, self)
	self.addEventCb(self, FishingController.instance, FishingEvent.OnFishingProgressUpdate, self._onFishingProgressUpdate, self)
	self.addEventCb(self, FishingController.instance, FishingEvent.OnSelectFriendTab, self.refreshFriendTab, self)
	self.addEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
	self.addEventCb(self, GameSceneMgr.instance, SceneEventName.EnterSceneFinish, self._onSceneDone, self, LuaEventSystem.Low)
	self.addEventCb(self, RoomController.instance, RoomEvent.OnSwitchModeDone, self._onSceneDone, self, LuaEventSystem.Low)
end

function RoomFishingView:removeEvents()
	self._btnInfoCopy:RemoveClickListener()
	self._btnExpandFriendList:RemoveClickListener()
	self._btnFoldFriendList:RemoveClickListener()
	self._btnunfishingTab:RemoveClickListener()
	self._btnfishingTab:RemoveClickListener()
	self._btnhide:RemoveClickListener()
	self._btnback:RemoveClickListener()
	self._input:RemoveOnValueChanged()
	self._input:RemoveOnEndEdit()
	self.removeEventCb(self, FishingController.instance, FishingEvent.OnFishingInfoUpdate, self._onFishingInfoUpdate, self)
	self.removeEventCb(self, FishingController.instance, FishingEvent.OnFishingProgressUpdate, self._onFishingProgressUpdate, self)
	self.removeEventCb(self, FishingController.instance, FishingEvent.OnSelectFriendTab, self.refreshFriendTab, self)
	self.removeEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
	self.removeEventCb(self, GameSceneMgr.instance, SceneEventName.EnterSceneFinish, self._onSceneDone, self)
	self.removeEventCb(self, RoomController.instance, RoomEvent.OnSwitchModeDone, self._onSceneDone, self)
end

function RoomFishingView:_btnInfoCopyOnClick()
	local curPoolUserId = FishingModel.instance:getCurShowingUserId()

	ZProj.UGUIHelper.CopyText(curPoolUserId)
	GameFacade.showToast(ToastEnum.ClickPlayerId)
end

function RoomFishingView:_btnExpandFriendListOnClick()
	FishingController.instance:getFriendListInfo(self._realExpandFriendList, self)
end

function RoomFishingView:_realExpandFriendList()
	self._isFriendListExpand = true

	self:_btnFriendTabOnClick(FishingEnum.FriendListTag.UnFishing)
	self:refreshFriendListExpand(true)
end

function RoomFishingView:_btnFoldFriendListOnClick()
	self._isFriendListExpand = false

	self.refreshFriendListExpand(self, true, self._btnFriendTabOnClick, self)
end

function RoomFishingView:_btnFriendTabOnClick(tab)
	FishingController.instance:selectFriendTab(tab)
end

function RoomFishingView:_btnHideOnClick()
	if RoomMapController.instance:isUIHide() then
		RoomMapController.instance:setUIHide(false)
	else
		RoomMapController.instance:setUIHide(true)
	end
end

function RoomFishingView:_btnbackOnClick()
	FishingController.instance:enterFishingMode(true)
end

function RoomFishingView:_inputValueChanged()
	local inputValue = self._input:GetText()
	local inputStr = string.gsub(inputValue, "[^0-9]", "")
	local limit = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.UidInputCountLimit, true)
	local newInput = GameUtil.utf8sub(inputStr, 1, math.min(GameUtil.utf8len(inputStr), limit))

	if newInput ~= inputValue then
		self._input:SetTextWithoutNotify(newInput)
	end
end

function RoomFishingView:_onEndEdit(inputStr)
	if not tonumber(inputStr) then
		return
	end

	FishingController.instance:visitOtherFishingPool(inputStr)
end

function RoomFishingView:_onFishingInfoUpdate(userId)
	if userId then
		FishingController.instance:updateFriendListInfo()
	end
end

function RoomFishingView:_onFishingProgressUpdate()
	FishingController.instance:getFriendListInfo()
end

function RoomFishingView:_onDailyRefresh()
	local isShowMyself = FishingModel.instance:getIsShowingMySelf()

	if isShowMyself then
		self:_updateFishingInfo(true)
	else
		self:_btnbackOnClick()
	end
end

function RoomFishingView:_onSceneDone()
	TaskDispatcher.runDelay(self._delayDispatchOpen, self, 0.1)
end

function RoomFishingView:_delayDispatchOpen()
	FishingController.instance:dispatchEvent(FishingEvent.GuideOnOpenFishingView)
end

function RoomFishingView:_editableInitView()
	local friendList = gohelper.findChild(self.viewGO, "Root/Left/FriendList")

	self._friendListAnimator = friendList:GetComponent(typeof(UnityEngine.Animator))
	self._friendListAnimatorPlayer = SLFramework.AnimatorPlayer.Get(friendList)
	self._selectedFriendTag = FishingEnum.FriendListTag.UnFishing

	self:setPlayerInfo()

	self._PcBtnHide = gohelper.findChild(self.viewGO, "Root/Left/btn_hide/#go_pcbtn")

	PCInputController.instance:showkeyTips(self._PcBtnHide, PCInputModel.Activity.room, PCInputModel.RoomActivityFun.hide)
end

function RoomFishingView:onUpdateParam()
	return
end

function RoomFishingView:onOpen()
	self:refresh()
	self:everySecondCall()
	TaskDispatcher.cancelTask(self.everySecondCall, self)
	TaskDispatcher.runRepeat(self.everySecondCall, self, TimeUtil.OneSecond)
	FishingController.instance:dispatchEvent(FishingEvent.GuideOnOpenFishingView)
end

function RoomFishingView:setPlayerInfo()
	local userId, name, portrait = FishingModel.instance:getCurFishingPoolUserInfo()

	self._playericon = IconMgr.instance:getCommonPlayerIcon(self._goheadicon)

	self._playericon:setMOValue(userId, "", 0, portrait)
	self._playericon:setEnableClick(false)
	self._playericon:setShowLevel(false)

	self._txtPlayerName.text = name

	local isShowMyself = FishingModel.instance:getIsShowingMySelf()

	gohelper.setActive(self._goSelf, isShowMyself)
	gohelper.setActive(self._goFriend, not isShowMyself)
	gohelper.setActive(self._btnback, not isShowMyself)

	self._isFriendListExpand = not isShowMyself
end

function RoomFishingView:refresh()
	self:refreshTime()
	self:refreshFriendListExpand()
end

function RoomFishingView:refreshFriendListExpand(playAnim, cb, cbObj)
	self:refreshFriendTab()

	if self._isFriendListExpand then
		if not UIAnimationName.Open then
			local animaName = UIAnimationName.Close

			if playAnim then
				self._friendListAnimatorPlayer:Play(animaName, cb, cbObj)
			else
				self._friendListAnimator.enabled = true

				self._friendListAnimator:Play(animaName, 0, 1)
			end
		end
	end
end

function RoomFishingView:refreshFriendTab()
	local selectedTab = FishingFriendListModel.instance:getSelectedTab()

	gohelper.setActive(self._gounfishingTab, selectedTab == FishingEnum.FriendListTag.UnFishing)
	gohelper.setActive(self._gofishingTab, selectedTab == FishingEnum.FriendListTag.Fishing)
end

function RoomFishingView:everySecondCall()
	self:refreshTime()
	self:checkBonus()
end

local GET_INFO_INTERVAL = 2

function RoomFishingView:refreshTime()
	local remainSecond, needRefresh = FishingModel.instance:getCurFishingPoolRefreshTime()
	local timeStr = string.format("%s%s", TimeUtil.secondToRoughTime2(remainSecond))

	self._txtrefreshTime.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("RoomFishing_refresh_time"), timeStr)

	if needRefresh then
		self:_updateFishingInfo()
	end
end

function RoomFishingView:_updateFishingInfo(forceUpdate)
	if not forceUpdate then
		if not self._lastGetInfoTime then
			do
				local lastTime = 0
				local offsetTime = Time.realtimeSinceStartup - lastTime

				if self.gettingInfo or offsetTime < GET_INFO_INTERVAL then
					return
				end
			end

			local isShowMyself = FishingModel.instance:getIsShowingMySelf()

			if isShowMyself then
				FishingController.instance:getFishingInfo(nil, self._afterGetFishingInfo, self)
			else
				local userId = FishingModel.instance:getCurShowingUserId()

				if userId then
					FishingController.instance:getFishingInfo(userId, self._afterGetFishingInfo, self)
				end
			end

			self._lastGetInfoTime = Time.realtimeSinceStartup
			self.gettingInfo = true
		end
	end
end

function RoomFishingView:_afterGetFishingInfo(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self.gettingInfo = false

	self:refreshTime()
	FishingController.instance:getFriendListInfo()
end

local GET_BONUS_INTERVAL = 2

function RoomFishingView:checkBonus()
	local isShowingLoading = ViewMgr.instance:isOpen(ViewName.LoadingRoomView)
	local isKeyBlock = UIBlockMgr.instance:isKeyBlock(RoomController.ENTER_ROOM_BLOCK_KEY)

	if self.gettingBonus or isShowingLoading or isKeyBlock then
		return
	end

	if not self._lastGetBonusTime then
		local lastTime = 0
		local offsetTime = Time.realtimeSinceStartup - lastTime

		if offsetTime < GET_BONUS_INTERVAL then
			return
		end

		self.gettingBonus = FishingController.instance:checkGetBonus(self._afterGetBonus, self)

		if self.gettingBonus then
			self._lastGetBonusTime = Time.realtimeSinceStartup
		end
	end
end

function RoomFishingView:_afterGetBonus()
	self.gettingBonus = false
end

function RoomFishingView:onClose()
	TaskDispatcher.cancelTask(self.everySecondCall, self)
	TaskDispatcher.cancelTask(self._delayDispatchOpen, self)
end

function RoomFishingView:onDestroyView()
	return
end

return RoomFishingView
