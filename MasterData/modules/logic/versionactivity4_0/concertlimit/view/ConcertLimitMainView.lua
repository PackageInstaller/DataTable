-- chunkname: @modules/logic/versionactivity4_0/concertlimit/view/ConcertLimitMainView.lua

module("modules.logic.versionactivity4_0.concertlimit.view.ConcertLimitMainView", package.seeall)

local ConcertLimitMainView = class("ConcertLimitMainView", BaseView)

function ConcertLimitMainView:onInitView()
	self._txtremaintime = gohelper.findChildText(self.viewGO, "title/timeime/timebg/#txt_remaintime")
	self._goselfselect = gohelper.findChild(self.viewGO, "entrance/#go_selfselect")
	self._btnselfselect = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#go_selfselect/#btn_selfselect", AudioEnum4_0.ConcertLimit.play_ui_yingmeng4_0click)
	self._goselfselectlock = gohelper.findChild(self.viewGO, "entrance/#go_selfselect/#go_selfselectlock")
	self._goselfselecttimetimeContainer = gohelper.findChild(self.viewGO, "entrance/#go_selfselect/#go_selfselecttimetimeContainer")
	self._txtselfselecttimetime = gohelper.findChildText(self.viewGO, "entrance/#go_selfselect/#go_selfselecttimetimeContainer/timebg/#txt_selfselecttimetime")
	self._goselfselectreddot = gohelper.findChild(self.viewGO, "entrance/#go_selfselect/#go_selfselectreddot")
	self._goacttask = gohelper.findChild(self.viewGO, "entrance/#go_acttask")
	self._goacttasklock = gohelper.findChild(self.viewGO, "entrance/#go_acttask/#go_acttasklock")
	self._btnacttask = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#go_acttask/#btn_acttask", AudioEnum4_0.ConcertLimit.play_ui_yingmeng4_0click)
	self._goacttasktime = gohelper.findChild(self.viewGO, "entrance/#go_acttask/#go_acttasktime")
	self._txtacttasktime = gohelper.findChildText(self.viewGO, "entrance/#go_acttask/#go_acttasktime/timebg/#txt_acttasktime")
	self._goacttaskreddot = gohelper.findChild(self.viewGO, "entrance/#go_acttask/#go_acttaskreddot")
	self._gocandyroom = gohelper.findChild(self.viewGO, "entrance/#go_candyroom")
	self._gocandyroomlock = gohelper.findChild(self.viewGO, "entrance/#go_candyroom/#go_candyroomlock")
	self._btncandyroom = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#go_candyroom/#btn_candyroom", AudioEnum4_0.ConcertLimit.play_ui_yingmeng4_0click)
	self._gocandyroomtip = gohelper.findChild(self.viewGO, "entrance/#go_candyroom/tips/#go_candyroomtip")
	self._gocandyroomtime = gohelper.findChild(self.viewGO, "entrance/#go_candyroom/tips/#go_candyroomtime")
	self._txtcandyroomtime = gohelper.findChildText(self.viewGO, "entrance/#go_candyroom/tips/#go_candyroomtime/#txt_candyroomtime")
	self._gocandyroomtime1 = gohelper.findChild(self.viewGO, "entrance/#go_candyroom/tips/#go_candyroomtime1")
	self._txtcandyroomtime1 = gohelper.findChildText(self.viewGO, "entrance/#go_candyroom/tips/#go_candyroomtime1/#txt_candyroomtime")
	self._gocandyroomsummon = gohelper.findChild(self.viewGO, "entrance/#go_candyroom/#go_candyroomsummon")
	self._gocandyroomsummontip = gohelper.findChild(self.viewGO, "entrance/#go_candyroom/#go_candyroomsummon/#go_candysummonTip")
	self._gocandyroomgettip = gohelper.findChild(self.viewGO, "entrance/#go_candyroom/#go_candyroomsummon/#go_candygettip")
	self._gocandyroomreddot = gohelper.findChild(self.viewGO, "entrance/#go_candyroom/#go_candyroomreddot")
	self._gogamelock = gohelper.findChild(self.viewGO, "entrance/#go_game/#go_gamelock")
	self._gogame = gohelper.findChild(self.viewGO, "entrance/#go_game")
	self._btngame = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#go_game/#btn_game", AudioEnum4_0.ConcertLimit.play_ui_yingmeng4_0click)
	self._gogametime = gohelper.findChild(self.viewGO, "entrance/#go_game/#go_gametime")
	self._txtgametime = gohelper.findChildText(self.viewGO, "entrance/#go_game/#go_gametime/TimeBG/#txt_gametime")
	self._gogamereddot = gohelper.findChild(self.viewGO, "entrance/#go_game/#go_gamereddot")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ConcertLimitMainView:addEvents()
	self._btnselfselect:AddClickListener(self._btnselfselectOnClick, self)
	self._btnacttask:AddClickListener(self._btnacttaskOnClick, self)
	self._btncandyroom:AddClickListener(self._btncandyroomOnClick, self)
	self._btngame:AddClickListener(self._btngameOnClick, self)
end

function ConcertLimitMainView:removeEvents()
	self._btnselfselect:RemoveClickListener()
	self._btnacttask:RemoveClickListener()
	self._btncandyroom:RemoveClickListener()
	self._btngame:RemoveClickListener()
end

function ConcertLimitMainView:_btnselfselectOnClick()
	local actId = VersionActivity4_0Enum.ActivityId.ConcertSelfSelect
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

	ConcertLimitController.instance:openSelfSelectView()
end

function ConcertLimitMainView:_btnacttaskOnClick()
	local actId = VersionActivity4_0Enum.ActivityId.ConcertActFlip
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

	ConcertLimitController.instance:openActFlipView()
end

function ConcertLimitMainView:_btncandyroomOnClick()
	local actId = VersionActivity4_0Enum.ActivityId.ConcertCandyRoom
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

	ConcertLimitController.instance:openCandyRoomView()
end

function ConcertLimitMainView:_btngameOnClick()
	local actId = VersionActivity4_0Enum.ActivityId.ConcertMusicGame
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

	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.MusicGameScoreShow), ServerTime.now())
	self:_refreshRedDot()
	ConcertLimitController.instance:openMusicNoteGameView()
end

function ConcertLimitMainView:_editableInitView()
	self:_addSelfEvents()
end

function ConcertLimitMainView:_addSelfEvents()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onCheckActState, self)
	self.addEventCb(self, CandyRoomController.instance, CandyRoomEvent.OnAct245Summon, self._refreshCandyRoomBtn, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refreshCandyRoomBtn, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self._refreshRedDot, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._refreshRedDot, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, self._refreshRedDot, self)
end

function ConcertLimitMainView:_removeSelfEvents()
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onCheckActState, self)
	self.removeEventCb(self, CandyRoomController.instance, CandyRoomEvent.OnAct245Summon, self._refreshCandyRoomBtn, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refreshCandyRoomBtn, self)
	self.removeEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self._refreshRedDot, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self._refreshRedDot, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, self._refreshRedDot, self)
end

function ConcertLimitMainView:_onCheckActState()
	local status = ActivityHelper.getActivityStatus(self._actId)

	if status == ActivityEnum.ActivityStatus.Expired then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

		return
	end

	self:_refreshBtns()
	TaskDispatcher.cancelTask(self._refreshTime, self)
	self:_refreshTime()
	TaskDispatcher.runRepeat(self._refreshTime, self, 1)
end

function ConcertLimitMainView:onOpen()
	self._actId = VersionActivity4_0Enum.ActivityId.ConcertLimitMain

	AudioMgr.instance:trigger(AudioEnum4_0.ConcertLimit.play_ui_yingmeng4_0open)
	self:_refreshTime()
	TaskDispatcher.runRepeat(self._refreshTime, self, 1)
	self:_refreshBtns()
	self:_initReddot()
end

function ConcertLimitMainView:_initReddot()
	RedDotController.instance:addRedDot(self._goacttaskreddot, RedDotEnum.DotNode.V4a0ConcertActFlip)
	RedDotController.instance:addRedDot(self._gocandyroomreddot, RedDotEnum.DotNode.V4a0ConcertCandyRoom)

	self._gameReddot = RedDotController.instance:addNotEventRedDot(self._gogamereddot, self._isShowGameReddot, self)

	RedDotController.instance:addRedDot(self._goselfselectreddot, RedDotEnum.DotNode.V4a0ConcertSelfSelect, VersionActivity4_0Enum.ActivityId.ConcertSelfSelect)
end

function ConcertLimitMainView:_refreshRedDot()
	self._gameReddot:refreshRedDot()
end

function ConcertLimitMainView:_isShowGameReddot()
	local reddotId = RedDotEnum.DotNode.V4a0ConcertMusicGame

	if RedDotModel.instance:isDotShow(reddotId, 0) then
		return true
	end

	local showGameReddot = MusicGameModel.instance:showScoreTipReddot(VersionActivity4_0Enum.ActivityId.ConcertMusicGame)

	if showGameReddot then
		return true
	end

	return false
end

function ConcertLimitMainView:_refreshTime()
	self._txtremaintime.text = ActivityModel.getRemainTimeStr(self._actId)

	local skinActId = CandyRoomModel.instance:getLoginActivityId(VersionActivity4_0Enum.ActivityId.ConcertCandyRoom)
	local rewardGet = ActivityType101Model.instance:isType101RewardGet(skinActId, 1)

	gohelper.setActive(self._gocandyroomtip, not rewardGet)

	if rewardGet then
		if not self._gocandyroomtime1 then
			local goCandyTime = self._gocandyroomtime

			if rewardGet then
				if not self._txtcandyroomtime1 then
					local txtCandyTime = self._txtcandyroomtime

					gohelper.setActive(self._gocandyroomtime, not rewardGet)
					gohelper.setActive(self._gocandyroomtime1, rewardGet)
					self:_refreshActTime(VersionActivity4_0Enum.ActivityId.ConcertCandyRoom, goCandyTime, txtCandyTime, self._gocandyroomlock)
					self:_refreshActTime(VersionActivity4_0Enum.ActivityId.ConcertSelfSelect, self._goselfselecttimetimeContainer, self._txtselfselecttimetime, self._goselfselectlock)
					self:_refreshActTime(VersionActivity4_0Enum.ActivityId.ConcertActFlip, self._goacttasktime, self._txtacttasktime, self._goacttasklock)
					self:_refreshActTime(VersionActivity4_0Enum.ActivityId.ConcertMusicGame, self._gogametime, self._txtgametime, self._gogamelock)
				end
			end
		end
	end
end

function ConcertLimitMainView:_refreshBtns()
	self:_refreshCandyRoomBtn()
	self:_refreshSelfSelectBtn()
	self:_refreshActFlipBtn()
	self:_refreshGameBtn()
end

function ConcertLimitMainView:_refreshActTime(actId, go, txt, lock)
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isExpire = actInfoMo and actInfoMo:isExpired()

	gohelper.setActive(go, true)

	if isExpire then
		txt.text = luaLang("turnback_end")

		gohelper.setActive(lock, true)

		return
	end

	local isUnlock = actInfoMo and actInfoMo:isOnline() and actInfoMo:isOpen()

	gohelper.setActive(lock, not isUnlock)

	if not isUnlock then
		local second = ActivityModel.instance:getActStartTime(actId) / 1000 - ServerTime.now()
		local formatTime = string.format("%s%s", TimeUtil.secondToRoughTime2(second))

		txt.text = GameUtil.getSubPlaceholderLuaLang(luaLang("concertlimit_mainview_actstart"), {
			formatTime
		})
	else
		local second = ActivityModel.instance:getActEndTime(actId) / 1000 - ServerTime.now()
		local formatTime = string.format("%s%s", TimeUtil.secondToRoughTime2(second))

		txt.text = GameUtil.getSubPlaceholderLuaLang(luaLang("concertlimit_mainview_actend"), {
			formatTime
		})
	end
end

function ConcertLimitMainView:_refreshCandyRoomBtn()
	local actId = VersionActivity4_0Enum.ActivityId.ConcertCandyRoom
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isExpire = actInfoMo:isExpired()

	if isExpire then
		gohelper.setActive(self._gocandyroomsummon, false)
		gohelper.setActive(self._gocandyroomreddot, false)
		gohelper.setActive(self._gocandyroomtip, false)

		return
	end

	local skinActId = CandyRoomModel.instance:getLoginActivityId(VersionActivity4_0Enum.ActivityId.ConcertCandyRoom)
	local rewardGet = ActivityType101Model.instance:isType101RewardGet(skinActId, 1)

	gohelper.setActive(self._gocandyroomtip, not rewardGet)

	local couldSummon = CandyRoomModel.instance:getLimitTimeCount(actId)
	local skinActId = CandyRoomModel.instance:getLoginActivityId(actId)
	local skinCouldGet = ActivityType101Model.instance:isType101RewardCouldGet(skinActId, 1)

	gohelper.setActive(self._gocandyroomsummon, couldSummon > 0 or skinCouldGet)
	gohelper.setActive(self._gocandyroomgettip, skinCouldGet)
	gohelper.setActive(self._gocandyroomsummontip, couldSummon > 0 and not skinCouldGet)
	gohelper.setActive(self._gocandyroomreddot, couldSummon <= 0)
end

function ConcertLimitMainView:_refreshSelfSelectBtn()
	local actId = VersionActivity4_0Enum.ActivityId.ConcertSelfSelect
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isExpire = actInfoMo:isExpired()

	if isExpire then
		gohelper.setActive(self._goselfselectreddot, false)
	end
end

function ConcertLimitMainView:_refreshActFlipBtn()
	local actId = VersionActivity4_0Enum.ActivityId.ConcertActFlip
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isExpire = actInfoMo:isExpired()

	if isExpire then
		gohelper.setActive(self._goacttaskreddot, false)
	end
end

function ConcertLimitMainView:_refreshGameBtn()
	local actId = VersionActivity4_0Enum.ActivityId.ConcertMusicGame
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isExpire = actInfoMo:isExpired()

	if isExpire then
		gohelper.setActive(self._gogamereddot, false)
	end
end

function ConcertLimitMainView:onClose()
	return
end

function ConcertLimitMainView:onDestroyView()
	TaskDispatcher.cancelTask(self._refreshTime, self)
	self:_removeSelfEvents()
end

return ConcertLimitMainView
