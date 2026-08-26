-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/main/view/LaplaceForumMainView.lua

module("modules.logic.versionactivity3_4.laplaceforum.main.view.LaplaceForumMainView", package.seeall)

local LaplaceForumMainView = class("LaplaceForumMainView", BaseView)

function LaplaceForumMainView:onInitView()
	self._txttime = gohelper.findChildText(self.viewGO, "content/timebg/#txt_time")
	self._gotitleappoint = gohelper.findChild(self.viewGO, "content/#go_titleappoint")
	self._btntitleappointjump = gohelper.findChildButton(self.viewGO, "content/#go_titleappoint/#btn_titleappointjump")
	self._txttitleappointnum = gohelper.findChildText(self.viewGO, "content/#go_titleappoint/#btn_titleappointjump/#txt_titleappointnum")
	self._gotitleappointreddot = gohelper.findChild(self.viewGO, "content/#go_titleappoint/#btn_titleappointjump/#go_titleappointreddot")
	self._gotitleappointspreward = gohelper.findChild(self.viewGO, "content/#go_titleappoint/#go_titleappointspreward")
	self._txttitleappointprogress = gohelper.findChildText(self.viewGO, "content/#go_titleappoint/#go_titleappointspreward/#txt_titleappointprogress")
	self._gorewardicon = gohelper.findChild(self.viewGO, "content/#go_titleappoint/#go_titleappointspreward/#go_rewardicon")
	self._gomusebox = gohelper.findChild(self.viewGO, "content/#go_musebox")
	self._gorole = gohelper.findChild(self.viewGO, "content/#go_musebox/#go_role")
	self._btnmusebox = gohelper.findChildButton(self.viewGO, "content/#go_musebox/#btn_musebox")
	self._gomuseboxlock = gohelper.findChild(self.viewGO, "content/#go_musebox/#go_museboxlock")
	self._txtmuseboxlocktime = gohelper.findChildText(self.viewGO, "content/#go_musebox/#go_museboxlock/limittip/#txt_museboxlocktime")
	self._gomuseboxunlock = gohelper.findChild(self.viewGO, "content/#go_musebox/#go_museboxunlock")
	self._gomuseboxtip = gohelper.findChild(self.viewGO, "content/#go_musebox/#go_txttip")
	self._txtmuseboxtip = gohelper.findChildText(self.viewGO, "content/#go_musebox/#go_txttip/txt_desc")
	self._gomuseboxreddot = gohelper.findChild(self.viewGO, "content/#go_musebox/#go_museboxunlock/#go_museboxreddot")
	self._goobserverbox = gohelper.findChild(self.viewGO, "content/#go_observerbox")
	self._simagegame2icon = gohelper.findChildSingleImage(self.viewGO, "content/#go_observerbox/#simage_game2icon")
	self._goobserverboxlock = gohelper.findChild(self.viewGO, "content/#go_observerbox/#go_observerboxlock")
	self._txtobserverboxlocktime = gohelper.findChildText(self.viewGO, "content/#go_observerbox/#go_observerboxlock/#txt_observerboxlocktime")
	self._goobserverboxtag = gohelper.findChild(self.viewGO, "content/#go_observerbox/#go_observerboxtag")
	self._txtobserverboxtag = gohelper.findChildText(self.viewGO, "content/#go_observerbox/#go_observerboxtag/#txt_observerboxtag")
	self._goobserverboxreddot = gohelper.findChild(self.viewGO, "content/#go_observerbox/#go_observerboxreddot")
	self._btnobserverboxclick = gohelper.findChildButton(self.viewGO, "content/#go_observerbox/#btn_observerboxclick")
	self._gominiparty = gohelper.findChild(self.viewGO, "content/#go_miniparty")
	self._gominipartytag = gohelper.findChild(self.viewGO, "content/#go_miniparty/#go_minipartytag")
	self._txtminipartytag = gohelper.findChildText(self.viewGO, "content/#go_miniparty/#go_minipartytag/#txt_minipartytag")
	self._btnminipartyclick = gohelper.findChildButton(self.viewGO, "content/#go_miniparty/#btn_minipartyclick")
	self._gominipartyreddot = gohelper.findChild(self.viewGO, "content/#go_miniparty/#go_minipartyreddot")
	self._gochatroom = gohelper.findChild(self.viewGO, "content/#go_chatroom")
	self._gochatroomtag = gohelper.findChild(self.viewGO, "content/#go_chatroom/#go_chatroomtag")
	self._txtchatroomtag = gohelper.findChildText(self.viewGO, "content/#go_chatroom/#go_chatroomtag/#txt_chatroomtag")
	self._gochatroomlock = gohelper.findChild(self.viewGO, "content/#go_chatroom/#go_chatroomlock")
	self._txtchatroomlocktime = gohelper.findChildText(self.viewGO, "content/#go_chatroom/#go_chatroomlock/#txt_chatroomlocktime")
	self._btnchatroomclick = gohelper.findChildButton(self.viewGO, "content/#go_chatroom/#btn_chatroomclick")
	self._gochatroomunlock = gohelper.findChild(self.viewGO, "content/#go_chatroom/#go_chatroomunlock")
	self._btnchatroomenter = gohelper.findChildButton(self.viewGO, "content/#go_chatroom/#go_chatroomunlock/#btn_chatroomenter")
	self._gochatroomreddot = gohelper.findChild(self.viewGO, "content/#go_chatroom/#go_chatroomreddot")
	self._gotoweralbum = gohelper.findChild(self.viewGO, "content/#go_toweralbum")
	self._simagegame5icon = gohelper.findChildSingleImage(self.viewGO, "content/#go_toweralbum/#simage_game5icon")
	self._simagetoweralbumreward = gohelper.findChildSingleImage(self.viewGO, "content/#go_toweralbum/#simage_toweralbumreward")
	self._gotoweralbumreceive = gohelper.findChild(self.viewGO, "content/#go_toweralbum/go_receive")
	self._gotoweralbumtag = gohelper.findChild(self.viewGO, "content/#go_toweralbum/#go_toweralbumtag")
	self._txttoweralbumtag = gohelper.findChildText(self.viewGO, "content/#go_toweralbum/#go_toweralbumtag/#txt_toweralbumtag")
	self._btntoweralbumclick = gohelper.findChildButton(self.viewGO, "content/#go_toweralbum/#btn_toweralbumclick")
	self._gotoweralbumreddot = gohelper.findChild(self.viewGO, "content/#go_toweralbum/#go_toweralbumreddot")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LaplaceForumMainView:addEvents()
	self._btntitleappointjump:AddClickListener(self._btntitleappointjumpOnClick, self)
	self._btnmusebox:AddClickListener(self._btnmuseboxOnClick, self)
	self._btnobserverboxclick:AddClickListener(self._btnobserverboxclickOnClick, self)
	self._btnminipartyclick:AddClickListener(self._btnminipartyclickOnClick, self)
	self._btnchatroomclick:AddClickListener(self._btnchatroomclickOnClick, self)
	self._btnchatroomenter:AddClickListener(self._btnchatroomenterOnClick, self)
	self._btntoweralbumclick:AddClickListener(self._btntoweralbumclickOnClick, self)
end

function LaplaceForumMainView:removeEvents()
	self._btntitleappointjump:RemoveClickListener()
	self._btnmusebox:RemoveClickListener()
	self._btnobserverboxclick:RemoveClickListener()
	self._btnminipartyclick:RemoveClickListener()
	self._btnchatroomclick:RemoveClickListener()
	self._btnchatroomenter:RemoveClickListener()
	self._btntoweralbumclick:RemoveClickListener()
end

function LaplaceForumMainView:_btntitleappointjumpOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)

	local actId = VersionActivity3_4Enum.ActivityId.LaplaceTitleAppoint
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isExpire = actInfoMo:isExpired()

	if isExpire then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	local isUnlock = actInfoMo:isOnline() and actInfoMo:isOpen()

	if not isUnlock then
		GameFacade.showToast(ToastEnum.ActivityNotOpen)

		return
	end

	LaplaceForumController.instance:openLaplaceTitleAppointmentView()
end

function LaplaceForumMainView:_btnmuseboxOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)

	local actId = VersionActivity3_4Enum.ActivityId.PartyGame
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isExpire = actInfoMo:isExpired()

	if isExpire then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	local isUnlock = actInfoMo:isOnline() and actInfoMo:isOpen()

	if not isUnlock then
		GameFacade.showToast(ToastEnum.ActivityNotOpen)

		return
	end

	GameFacade.jump(JumpEnum.JumpId.LaplaceMuseBox)
end

function LaplaceForumMainView:_btnobserverboxclickOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)

	local actId = VersionActivity3_4Enum.ActivityId.LaplaceObserverBox
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isExpire = actInfoMo:isExpired()

	if isExpire then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	local isUnlock = actInfoMo:isOnline() and actInfoMo:isOpen()

	if not isUnlock then
		GameFacade.showToast(ToastEnum.ActivityNotOpen)

		return
	end

	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.LaplaceObserverBoxShowed), "1")
	self:_refreshReddot()
	LaplaceForumController.instance:openLaplaceObserverBoxView()
end

function LaplaceForumMainView:_btnminipartyclickOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)

	local actId = VersionActivity3_4Enum.ActivityId.LaplaceMiniParty
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isExpire = actInfoMo:isExpired()

	if isExpire then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	local isUnlock = actInfoMo:isOnline() and actInfoMo:isOpen()

	if not isUnlock then
		GameFacade.showToast(ToastEnum.ActivityNotOpen)

		return
	end

	LaplaceForumController.instance:openLaplaceMiniPartyView()
end

function LaplaceForumMainView:_btnchatroomclickOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)

	local actId = VersionActivity3_4Enum.ActivityId.LaplaceChatRoom
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isExpire = actInfoMo:isExpired()

	if isExpire then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	local isUnlock = actInfoMo:isOnline() and actInfoMo:isOpen()

	if not isUnlock then
		GameFacade.showToast(ToastEnum.ActivityNotOpen)

		return
	end

	LaplaceForumController.instance:openLaplaceChatRoomView()
end

function LaplaceForumMainView:_btnchatroomenterOnClick()
	self:_btnchatroomclickOnClick()
end

function LaplaceForumMainView:_btntoweralbumclickOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)

	local actId = VersionActivity3_4Enum.ActivityId.LaplaceTowerAlbum
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isExpire = actInfoMo:isExpired()

	if isExpire then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	local isUnlock = actInfoMo:isOnline() and actInfoMo:isOpen()

	if not isUnlock then
		GameFacade.showToast(ToastEnum.ActivityNotOpen)

		return
	end

	GameFacade.jump(JumpEnum.JumpId.LaplaceTowerAlbum)
end

function LaplaceForumMainView:_editableInitView()
	self:_addSelfEvents()

	self._actId = VersionActivity3_4Enum.ActivityId.LaplaceMain

	PartyClothController.instance:tryGetPartyWearInfo()

	self._museBoxAnim = self._gomusebox:GetComponent(typeof(UnityEngine.Animator))
	self._chatRoomAnim = self._gochatroom:GetComponent(typeof(UnityEngine.Animator))
	self._observerBoxAnim = self._gochatroom:GetComponent(typeof(UnityEngine.Animator))
	self._isChatRoomUnlock = ActivityModel.instance:isActOnLine(VersionActivity3_4Enum.ActivityId.LaplaceChatRoom)
	self._isMuseBoxUnlock = ActivityModel.instance:isActOnLine(VersionActivity3_4Enum.ActivityId.PartyGame)
	self._isObserverBoxUnlock = ActivityModel.instance:isActOnLine(VersionActivity3_4Enum.ActivityId.LaplaceObserverBox)
	self._redDotMiniPartyComp = RedDotController.instance:addNotEventRedDot(self._gominipartyreddot, self._isMiniPartyShowRedDot, self)
	self._redDotObserverBoxComp = RedDotController.instance:addNotEventRedDot(self._goobserverboxreddot, self._isObserverShowReddot, self)
end

function LaplaceForumMainView:_isMiniPartyShowRedDot()
	local isMiniPartyDotShow = RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V3a4LaplaceMiniParty, 0)
	local uncheckCount = MiniPartyModel.instance:getAllUncheckInviteCount()

	if isMiniPartyDotShow or uncheckCount > 0 then
		return true
	end

	return false
end

function LaplaceForumMainView:_isObserverShowReddot()
	local actId = VersionActivity3_4Enum.ActivityId.LaplaceObserverBox
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isExpire = actInfoMo:isExpired()
	local isUnlock = actInfoMo:isOnline() and actInfoMo:isOpen()

	if isExpire or not isUnlock then
		return false
	end

	local isObserverDotShow = RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V3a4LaplaceObserverBox, 0)
	local observerStr = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.LaplaceObserverBoxShowed), "")

	if isObserverDotShow or LuaUtil.isEmptyStr(observerStr) then
		return true
	end

	return false
end

function LaplaceForumMainView:_addSelfEvents()
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self._refreshReddot, self)
	self.addEventCb(self, MiniPartyController.instance, MiniPartyEvent.InviteTypeSelectChanged, self._refreshReddot, self)
	self.addEventCb(self, PartyClothController.instance, PartyClothEvent.GetWearInfoReply, self._refreshMuseBox, self)
	self.addEventCb(self, ObserverBoxController.instance, ObserverBoxEvent.RewardInfoChanged, self._refreshObserverBox, self)
	self.addEventCb(self, ObserverBoxController.instance, ObserverBoxEvent.RewardBonusGet, self._refreshObserverBox, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshTitleAppointment, self)
	self.addEventCb(self, TitleAppointmentController.instance, TitleAppointmentEvent.RewardInfoChanged, self._refreshTitleAppointment, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refreshTowerAlbum, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._refresh, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onRefreshActivity, self)
end

function LaplaceForumMainView:_removeSelfEvents()
	self.removeEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self._refreshReddot, self)
	self.removeEventCb(self, MiniPartyController.instance, MiniPartyEvent.InviteTypeSelectChanged, self._refreshReddot, self)
	self.removeEventCb(self, PartyClothController.instance, PartyClothEvent.GetWearInfoReply, self._refreshMuseBox, self)
	self.removeEventCb(self, ObserverBoxController.instance, ObserverBoxEvent.RewardInfoChanged, self._refreshObserverBox, self)
	self.removeEventCb(self, ObserverBoxController.instance, ObserverBoxEvent.RewardBonusGet, self._refreshObserverBox, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshTitleAppointment, self)
	self.removeEventCb(self, TitleAppointmentController.instance, TitleAppointmentEvent.RewardInfoChanged, self._refreshTitleAppointment, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refreshTowerAlbum, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._refresh, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onRefreshActivity, self)
end

function LaplaceForumMainView:_onRefreshActivity()
	local status = ActivityHelper.getActivityStatus(VersionActivity3_4Enum.ActivityId.LaplaceMain)

	if status == ActivityEnum.ActivityStatus.Expired then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

		return
	end

	local isChatRoomUnlock = ActivityModel.instance:isActOnLine(VersionActivity3_4Enum.ActivityId.LaplaceChatRoom)

	if not self._isChatRoomUnlock and isChatRoomUnlock then
		self._chatRoomAnim:Play("unlock", 0, 0)
	end

	local isMuseBoxUnlock = ActivityModel.instance:isActOnLine(VersionActivity3_4Enum.ActivityId.PartyGame)

	if not self._isMuseBoxUnlock and isMuseBoxUnlock then
		self._museBoxAnim:Play("unlock", 0, 0)
	end

	local isObserverBoxUnlock = ActivityModel.instance:isActOnLine(VersionActivity3_4Enum.ActivityId.LaplaceObserverBox)

	if not self._isObserverBoxUnlock and isObserverBoxUnlock then
		self._observerBoxAnim:Play("unlock", 0, 0)
	end

	self:_refresh()
end

function LaplaceForumMainView:onUpdateParam()
	return
end

function LaplaceForumMainView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_plot_playback)
	self:_refresh()
	self:_addReddot()
	self:_refreshTimeTick()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
	self:_checkLuckyRainChanged()
	TaskDispatcher.runRepeat(self._checkLuckyRainChanged, self, 0.5)
end

function LaplaceForumMainView:_addReddot()
	RedDotController.instance:addRedDot(self._gotitleappointreddot, RedDotEnum.DotNode.V3a4LaplaceTitleAppointment)
	RedDotController.instance:addRedDot(self._gochatroomreddot, RedDotEnum.DotNode.V3a4LaplaceChatRoom)
	RedDotController.instance:addRedDot(self._gominipartyreddot, RedDotEnum.DotNode.V3a4LaplaceMiniParty)
	RedDotController.instance:addRedDot(self._goobserverboxreddot, RedDotEnum.DotNode.V3a4LaplaceObserverBox)
	RedDotController.instance:addRedDot(self._gotoweralbumreddot, RedDotEnum.DotNode.V3a4LaplaceTowerAlbum, VersionActivity3_4Enum.ActivityId.LaplaceTowerAlbum)
end

function LaplaceForumMainView:_refreshReddot()
	self._redDotMiniPartyComp:refreshRedDot()
	self._redDotObserverBoxComp:refreshRedDot()
end

function LaplaceForumMainView:_refreshTimeTick()
	self._txttime.text = ActivityModel.getRemainTimeStr(self._actId)

	local isMuseBoxUnlock = ActivityModel.instance:isActOnLine(VersionActivity3_4Enum.ActivityId.PartyGame)

	if not isMuseBoxUnlock then
		local second = ActivityModel.instance:getActStartTime(VersionActivity3_4Enum.ActivityId.PartyGame) / 1000 - ServerTime.now()

		self._txtmuseboxlocktime.text = self:_getLockStr(second)
	end

	local isChatRoomUnlock = ActivityModel.instance:isActOnLine(VersionActivity3_4Enum.ActivityId.LaplaceChatRoom)

	if not isChatRoomUnlock then
		local second = ActivityModel.instance:getActStartTime(VersionActivity3_4Enum.ActivityId.LaplaceChatRoom) / 1000 - ServerTime.now()

		self._txtchatroomlocktime.text = self:_getLockStr(second)
	end

	local isObserverBoxUnlock = ActivityModel.instance:isActOnLine(VersionActivity3_4Enum.ActivityId.LaplaceObserverBox)

	if not isObserverBoxUnlock then
		local second = ActivityModel.instance:getActStartTime(VersionActivity3_4Enum.ActivityId.LaplaceObserverBox) / 1000 - ServerTime.now()

		self._txtobserverboxlocktime.text = self:_getLockStr(second)
	end
end

function LaplaceForumMainView:_getLockStr(second)
	return string.format(luaLang("seasonmainview_timeopencondition"), string.format("%s%s", TimeUtil.secondToRoughTime2(second)))
end

function LaplaceForumMainView:_refresh()
	self:_refreshUI()
	self:_refreshBtns()
	self:_refreshReddot()
end

function LaplaceForumMainView:_refreshUI()
	return
end

function LaplaceForumMainView:_refreshBtns()
	self:_refreshMiniParty()
	self:_refreshMuseBox()
	self:_refreshObserverBox()
	self:_refreshChatRoom()
	self:_refreshTitleAppointment()
	self:_refreshTowerAlbum()
end

function LaplaceForumMainView:_refreshMiniParty()
	local selfTaskCouldGetCount = MiniPartyTaskModel.instance:getCanGetTaskCount(MiniPartyEnum.TaskType.SelfTask)
	local groupTaskCouldGetCount = MiniPartyTaskModel.instance:getCanGetTaskCount(MiniPartyEnum.TaskType.GroupTask)
	local hasRewardCouldGet = selfTaskCouldGetCount > 0 or groupTaskCouldGetCount > 0

	gohelper.setActive(self._gominiparty, true)

	if hasRewardCouldGet then
		self._txtminipartytag.text = luaLang("v3a4_laplacemainview_txt_minipartytag2")

		return
	end

	local hasLucyRainUnfinished = MiniPartyTaskModel.instance:hasLucyRainUnfinished()

	if hasLucyRainUnfinished then
		self._txtminipartytag.text = luaLang("v3a4_laplacemainview_txt_minipartytag3")

		return
	end

	local selfUnfinishedTasks = MiniPartyTaskModel.instance:getAllUnfinishedTasks(MiniPartyEnum.TaskType.SelfTask)
	local groupUnfinishedTasks = MiniPartyTaskModel.instance:getAllUnfinishedTasks(MiniPartyEnum.TaskType.GroupTask)
	local hasNotFinished = #selfUnfinishedTasks > 0 or #groupUnfinishedTasks > 0

	gohelper.setActive(self._gominipartytag, hasNotFinished)

	if hasNotFinished then
		self._txtminipartytag.text = luaLang("v3a4_laplacemainview_txt_minipartytag1")
	end
end

function LaplaceForumMainView:_refreshMuseBox()
	local actId = VersionActivity3_4Enum.ActivityId.PartyGame
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isNotUnlock = actInfoMo and not actInfoMo:isOpen() and not actInfoMo:isExpired()
	local isUnlock = actInfoMo and actInfoMo:isOpen() and not actInfoMo:isExpired()

	gohelper.setActive(self._gomuseboxlock, isNotUnlock)
	gohelper.setActive(self._gomuseboxunlock, isUnlock)

	if isNotUnlock then
		self._txtmuseboxtip.text = luaLang("p_v3a4_laplacemainview_txt3")
	else
		local isOpen = OpenModel.instance:isFunctionUnlock(PartyGameLobbyEnum.DailyOpenId)
		local openCO = OpenConfig.instance:getOpenCo(PartyGameLobbyEnum.DailyOpenId)
		local openTimeParams = GameUtil.splitString2(openCO.dailyOpenTime, true, "|", "#")
		local inGameTime = false

		if openTimeParams and #openTimeParams > 0 then
			local time = TimeUtil.timestampToTable(ServerTime.now())

			for _, openTimeParam in ipairs(openTimeParams) do
				if openTimeParam[1] <= time.hour and openTimeParam[2] >= time.hour then
					inGameTime = true
				end
			end
		end

		self._txtmuseboxtip.text = isOpen and inGameTime and luaLang("p_v3a4_laplacemainview_txt5") or luaLang("p_v3a4_laplacemainview_txt4")
	end

	self._spine = self._spine or PartyGameGuiSpine.Create(self._gorole)

	local initResMap = PartyClothConfig.instance:getInitClothIdMap()

	if isNotUnlock then
		local var_27_0 = PartyClothConfig.instance:getSkinRes(initResMap)

		if not var_27_0 then
			var_27_0 = PartyClothModel.instance:getCurWearClothRes()

			local skinResMap = var_27_0

			self._spine:setSkin(skinResMap)
			self._spine:setResPath(PartyGameEnum.PartyGameUISpineRes)
		end
	end
end

function LaplaceForumMainView:_refreshObserverBox()
	local actId = VersionActivity3_4Enum.ActivityId.LaplaceObserverBox
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isUnlock = actInfoMo and actInfoMo:isOpen() and not actInfoMo:isExpired()

	gohelper.setActive(self._goobserverboxlock, not isUnlock)

	if not isUnlock then
		local startTime = ActivityModel.instance:getActStartTime(actId) / 1000
		local limitDay = math.ceil((startTime - ServerTime.now()) / TimeUtil.OneDaySecond)

		self._txtobserverboxlocktime.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("season166_unlockHardEpisodeTime"), limitDay)

		gohelper.setActive(self._goobserverboxtag, false)
	else
		local isAllFinished = ObserverBoxModel.instance:isAllPageCardGet()

		gohelper.setActive(self._goobserverboxtag, true)

		if isAllFinished then
			self._txtobserverboxtag.text = luaLang("v3a4_laplacemainview_txt_observerboxtag2")

			return
		end

		local couldGetCount = ObserverBoxModel.instance:couldGetCardCount()
		local hasCouldGetTask = ObserverBoxModel.instance:isHasTaskNotGet()
		local show = couldGetCount > 0 or hasCouldGetTask

		gohelper.setActive(self._goobserverboxtag, show)

		if not show then
			return
		end

		self._txtobserverboxtag.text = luaLang("v3a4_laplacemainview_txt_observerboxtag1")
	end
end

function LaplaceForumMainView:_refreshChatRoom()
	local actId = VersionActivity3_4Enum.ActivityId.LaplaceChatRoom
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isUnlock = actInfoMo and actInfoMo:isOpen() and not actInfoMo:isExpired()

	gohelper.setActive(self._gochatroomunlock, isUnlock)
	gohelper.setActive(self._gochatroomlock, not isUnlock)
	gohelper.setActive(self._gochatroomtag, isUnlock)

	if not isUnlock then
		return
	end

	local isInLuckyRain = ChatRoomModel.instance:isInLuckyRain()
	local isRewardGet = ChatRoomModel.instance:isRainRewardGet()

	if isInLuckyRain and not isRewardGet then
		self._txtchatroomtag.text = luaLang("v3a4_laplacemainview_txt_chatroomtag1")

		return
	end

	local hasQuestion = ChatRoomModel.instance:hasQuestion()

	if hasQuestion then
		self._txtchatroomtag.text = luaLang("v3a4_laplacemainview_txt_chatroomtag3")

		return
	end

	local gameCount = ChatRoomFingerGameModel.instance:getCurDayFingerGameCount()

	if gameCount < 1 then
		self._txtchatroomtag.text = luaLang("v3a4_laplacemainview_txt_chatroomtag4")

		return
	end

	self._txtchatroomtag.text = luaLang("v3a4_laplacemainview_txt_chatroomtag2")
end

function LaplaceForumMainView:_checkLuckyRainChanged()
	local isLuckyRainEnd = ChatRoomModel.instance:isActLuckyRainEnd()

	if isLuckyRainEnd then
		TaskDispatcher.cancelTask(self._checkLuckyRainChanged, self)

		return
	end

	local isInLuckyRain, rainId = ChatRoomModel.instance:isInLuckyRain()

	if self._isInLuckyRain == nil then
		self._isInLuckyRain = isInLuckyRain
	end

	if isInLuckyRain == self._isInLuckyRain then
		return
	end

	RedDotRpc.instance:sendGetRedDotInfosRequest({
		RedDotEnum.DotNode.V3a4LaplaceChatRoomLuckyRain
	})
	self:_refreshChatRoom()

	self._isInLuckyRain = isInLuckyRain
end

function LaplaceForumMainView:_refreshTitleAppointment()
	local popularCount = TitleAppointmentModel.instance:getPopularValueCount()

	self._txttitleappointnum.text = GameUtil.numberDisplay(popularCount)

	local curSpProgress, spIndex = TitleAppointmentModel.instance:getCurSpRewardProgress()

	gohelper.setActive(self._gotitleappointspreward, curSpProgress > 0)

	if curSpProgress > 0 then
		self._txttitleappointprogress.text = GameUtil.getSubPlaceholderLuaLang(luaLang("v3a4_laplacemainview_txt_num"), {
			GameUtil.numberDisplay(popularCount),
			curSpProgress
		})
	end

	gohelper.setActive(self._gorewardicon, spIndex and spIndex > 0)

	if not spIndex or spIndex <= 0 then
		return
	end

	self._titleRewardItem = self._titleRewardItem or IconMgr.instance:getCommonItemIcon(self._gorewardicon)

	local bonusCo = TitleAppointmentConfig.instance:getMilestoneBonusCo(spIndex)
	local itemCos = string.splitToNumber(bonusCo.bonus, "#")

	self._titleRewardItem:setMOValue(itemCos[1], itemCos[2], itemCos[3])
	self._titleRewardItem:isShowQuality(false)
	self._titleRewardItem:isShowCount(false)
end

function LaplaceForumMainView:_refreshTowerAlbum()
	local actId = VersionActivity3_4Enum.ActivityId.LaplaceTowerAlbum
	local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(actId, 1)

	gohelper.setActive(self._gotoweralbumreceive, not couldGet)
end

function LaplaceForumMainView:onClose()
	return
end

function LaplaceForumMainView:onDestroyView()
	self:_removeSelfEvents()
	TaskDispatcher.cancelTask(self._checkLuckyRainChanged, self)
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

return LaplaceForumMainView
