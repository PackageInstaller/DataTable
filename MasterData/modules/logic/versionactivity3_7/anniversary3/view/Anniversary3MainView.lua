-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/Anniversary3MainView.lua

module("modules.logic.versionactivity3_7.anniversary3.view.Anniversary3MainView", package.seeall)

local Anniversary3MainView = class("Anniversary3MainView", BaseView)

function Anniversary3MainView:onInitView()
	self._gotitle = gohelper.findChild(self.viewGO, "#go_title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "#go_title/#txt_LimitTime")
	self._goreport = gohelper.findChild(self.viewGO, "#go_report")
	self._btnreport = gohelper.findChildButtonWithAudio(self.viewGO, "#go_report/#btn_report")
	self._goreportlock = gohelper.findChild(self.viewGO, "#go_report/#go_reportlock")
	self._txtreporttime = gohelper.findChildText(self.viewGO, "#go_report/#go_reportlock/tips/#txt_reporttime")
	self._goreportreddot = gohelper.findChild(self.viewGO, "#go_report/#go_reportreddot")
	self._gomail = gohelper.findChild(self.viewGO, "#go_mail")
	self._btnmail = gohelper.findChildButtonWithAudio(self.viewGO, "#go_mail/root/#btn_mail")
	self._gomaillock = gohelper.findChild(self.viewGO, "#go_mail/root/#go_maillock")
	self._txtmailtips = gohelper.findChildText(self.viewGO, "#go_mail/root/#go_maillock/tips/#txt_mailtips")
	self._gomailreddot = gohelper.findChild(self.viewGO, "#go_mail/root/#go_mailreddot")
	self._goskin = gohelper.findChild(self.viewGO, "#go_skin")
	self._btnskin = gohelper.findChildButtonWithAudio(self.viewGO, "#go_skin/root/#btn_skin")
	self._goskinlock = gohelper.findChild(self.viewGO, "#go_skin/root/#go_skinlock")
	self._txtskintime = gohelper.findChildText(self.viewGO, "#go_skin/root/#go_skinlock/tips/#txt_skintime")
	self._goskinreddot = gohelper.findChild(self.viewGO, "#go_skin/root/#go_skinreddot")
	self._goactbp = gohelper.findChild(self.viewGO, "#go_actbp")
	self._btnactbp = gohelper.findChildButtonWithAudio(self.viewGO, "#go_actbp/root/#btn_actbp")
	self._goactbpopen = gohelper.findChild(self.viewGO, "#go_actbp/root/#go_actbpopen")
	self._goactbplock = gohelper.findChild(self.viewGO, "#go_actbp/root/#go_actbplock")
	self._txtactbptips = gohelper.findChildText(self.viewGO, "#go_actbp/root/#go_actbplock/tips/#txt_actbptips")
	self._goactbprewardtip = gohelper.findChild(self.viewGO, "#go_actbp/root/#go_actbprewardtip")
	self._goactbpreddot = gohelper.findChild(self.viewGO, "#go_actbp/root/#go_actbpreddot")
	self._gosign = gohelper.findChild(self.viewGO, "#go_sign")
	self._btnsign = gohelper.findChildButtonWithAudio(self.viewGO, "#go_sign/root/#btn_sign")
	self._gosignlock = gohelper.findChild(self.viewGO, "#go_sign/root/#go_signlock")
	self._txtsigntips = gohelper.findChildText(self.viewGO, "#go_sign/root/#go_signlock/tips/#txt_signtips")
	self._gosignreddot = gohelper.findChild(self.viewGO, "#go_sign/root/#go_signreddot")
	self._goinvite = gohelper.findChild(self.viewGO, "#go_invite")
	self._btninvite = gohelper.findChildButtonWithAudio(self.viewGO, "#go_invite/root/#btn_invite")
	self._goinvitelock = gohelper.findChild(self.viewGO, "#go_invite/root/#go_invitelock")
	self._txtinvitetips = gohelper.findChildText(self.viewGO, "#go_invite/root/#go_invitelock/tips/#txt_invitetips")
	self._goinvitetips2 = gohelper.findChild(self.viewGO, "#go_invite/root/#go_invitetips2")
	self._goinvitereddot = gohelper.findChild(self.viewGO, "#go_invite/root/#go_invitereddot")
	self._gogame = gohelper.findChild(self.viewGO, "#go_game")
	self._btngame = gohelper.findChildButtonWithAudio(self.viewGO, "#go_game/root/#btn_game")
	self._imageprogresscircle = gohelper.findChildImage(self.viewGO, "#go_game/root/#btn_game/lock_Icon/#image_progresscircle")
	self._gogamelock = gohelper.findChild(self.viewGO, "#go_game/root/#go_gamelock")
	self._txtgametips = gohelper.findChildText(self.viewGO, "#go_game/root/#go_gamelock/tips/#txt_gametips")
	self._gogametips2 = gohelper.findChild(self.viewGO, "#go_game/root/#go_gametips2")
	self._gogamereddot = gohelper.findChild(self.viewGO, "#go_game/root/#go_gamereddot")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Anniversary3MainView:addEvents()
	self._btnreport:AddClickListener(self._btnreportOnClick, self)
	self._btnmail:AddClickListener(self._btnmailOnClick, self)
	self._btnskin:AddClickListener(self._btnskinOnClick, self)
	self._btnactbp:AddClickListener(self._btnactbpOnClick, self)
	self._btnsign:AddClickListener(self._btnsignOnClick, self)
	self._btninvite:AddClickListener(self._btninviteOnClick, self)
	self._btngame:AddClickListener(self._btngameOnClick, self)
end

function Anniversary3MainView:removeEvents()
	self._btnreport:RemoveClickListener()
	self._btnmail:RemoveClickListener()
	self._btnskin:RemoveClickListener()
	self._btnactbp:RemoveClickListener()
	self._btnsign:RemoveClickListener()
	self._btninvite:RemoveClickListener()
	self._btngame:RemoveClickListener()
end

function Anniversary3MainView:_btninviteOnClick()
	local actId = VersionActivity3_7Enum.ActivityId.Anniversary3Invite
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

	Activity199Controller.instance:openV2a8_SelfSelectCharacterView()
end

function Anniversary3MainView:_btnreportOnClick()
	local actId = VersionActivity3_7Enum.ActivityId.Anniversary3Report
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

	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Anniversary3ReportReaded), "1")

	local url = Activity125Config.instance:getH5BaseUrl(VersionActivity3_7Enum.ActivityId.Anniversary3Report)

	WebViewController.instance:simpleOpenWebBrowser(url)
	StatController.instance:track(StatEnum.EventName.ButtonClick, {
		[StatEnum.EventProperties.ViewName] = "Anniversary3MainView",
		[StatEnum.EventProperties.ButtonName] = "YearlyReport"
	})
	self:_refreshReportBtn()
end

function Anniversary3MainView:_btnmailOnClick()
	local actId = VersionActivity3_7Enum.ActivityId.Anniversary3Mail
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

	Anniversary3Controller.instance:openAnniversary3MailView()
end

function Anniversary3MainView:_btnsignOnClick()
	local actId = VersionActivity3_7Enum.ActivityId.Anniversary3Sign
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

	Anniversary3Controller.instance:openAnniversary3SignView(VersionActivity3_7Enum.ActivityId.Anniversary3Sign)
end

function Anniversary3MainView:_btnskinOnClick()
	local actId = VersionActivity3_7Enum.ActivityId.Anniversary3Skin
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

	GoldenMilletPresentController.instance:openGoldenMilletPresentView()
end

function Anniversary3MainView:_btnactbpOnClick()
	local actId = VersionActivity3_7Enum.ActivityId.Anniversary3ActBp
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

	Anniversary3Controller.instance:openAnniversary3ActBpView()
end

function Anniversary3MainView:_btngameOnClick()
	local actId = VersionActivity3_7Enum.ActivityId.Anniversary3GuessGame
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

	local nowTime = ServerTime.now()

	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.GuessGameFirstShowTime), nowTime)
	self:_refreshGameBtn()
	Anniversary3Controller.instance:openGuessGameMainView()
end

function Anniversary3MainView:_editableInitView()
	self:_addSelfEvents()
end

function Anniversary3MainView:_addSelfEvents()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onCheckActState, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self._onRefreshDot, self)
	self.addEventCb(self, Anniversary3ActBpController.instance, Anniversary3ActBpEvent.OnGetBonus, self._refreshActBpBtn, self)
	self.addEventCb(self, GuessGameController.instance, GuessGameEvent.OnFinishGame, self._refreshGameBtn, self)
end

function Anniversary3MainView:_removeSelfEvents()
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onCheckActState, self)
	self.removeEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self._onRefreshDot, self)
	self.removeEventCb(self, Anniversary3ActBpController.instance, Anniversary3ActBpEvent.OnGetBonus, self._refreshActBpBtn, self)
	self.removeEventCb(self, GuessGameController.instance, GuessGameEvent.OnFinishGame, self._refreshGameBtn, self)
end

function Anniversary3MainView:_onRefreshDot()
	self:_refreshReportBtn()
	self:_refreshActBpBtn()
	self:_refreshGameBtn()
end

function Anniversary3MainView:_onCheckActState()
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

function Anniversary3MainView:onUpdateParam()
	return
end

function Anniversary3MainView:onOpen()
	self._actId = VersionActivity3_7Enum.ActivityId.Anniversary3Main

	AudioMgr.instance:trigger(AudioEnum3_7.Anniversary3.play_ui_heping_open3_7)
	self:_refreshTime()
	TaskDispatcher.runRepeat(self._refreshTime, self, 1)
	self:_refreshBtns()
	self:_initReddot()
end

function Anniversary3MainView:onOpenFinish()
	Anniversary3ActBpController.instance:again‌RequestActivity()
end

function Anniversary3MainView:_initReddot()
	RedDotController.instance:addRedDot(self._goactbpreddot, RedDotEnum.DotNode.V3a7Anniversary3ActBp)
	RedDotController.instance:addRedDot(self._gomailreddot, RedDotEnum.DotNode.V3a7Anniversary3Mail)
	RedDotController.instance:addRedDot(self._goskinreddot, RedDotEnum.DotNode.V3a7Anniversary3Skin)
	RedDotController.instance:addRedDot(self._gosignreddot, RedDotEnum.DotNode.V3a7Anniversary3Sign)
	RedDotController.instance:addRedDot(self._goinvitereddot, RedDotEnum.DotNode.V3a7Anniversary3Invite)

	self._reportReddotComponent = RedDotController.instance:addNotEventRedDot(self._goreportreddot, self._isShowReportReddot, self)
	self._guessGameReddotComponent = RedDotController.instance:addNotEventRedDot(self._gogamereddot, self._isShowGameReddot, self)
end

function Anniversary3MainView:_isShowReportReddot()
	local actId = VersionActivity3_7Enum.ActivityId.Anniversary3Report
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isExpire = actInfoMo:isExpired()
	local isUnlock = actInfoMo:isOnline() and actInfoMo:isOpen()

	if isExpire or not isUnlock then
		return false
	end

	local isDotShow = RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V3a7Anniversary3Report, 0)
	local reportStr = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Anniversary3ReportReaded), "")

	if isDotShow or LuaUtil.isEmptyStr(reportStr) then
		return true
	end

	return false
end

function Anniversary3MainView:_isShowGameReddot()
	local actId = VersionActivity3_7Enum.ActivityId.Anniversary3GuessGame
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isExpire = actInfoMo:isExpired()
	local isUnlock = actInfoMo:isOnline() and actInfoMo:isOpen()

	if isExpire or not isUnlock then
		return false
	end

	local isDotShow = RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V3a7Anniversary3GuessGame, 0)
	local hasMultiRewardCouldGet = GuessGameModel.instance:hasMultiRewardCouldGet(actId)

	if isDotShow or hasMultiRewardCouldGet then
		return true
	end

	return false
end

function Anniversary3MainView:_refreshTime()
	self._txtLimitTime.text = ActivityModel.getRemainTimeStr(self._actId)

	local isInviteUnlock = ActivityModel.instance:isActOnLine(VersionActivity3_7Enum.ActivityId.Anniversary3Invite)

	if not isInviteUnlock then
		local second = ActivityModel.instance:getActStartTime(VersionActivity3_7Enum.ActivityId.Anniversary3Invite) / 1000 - ServerTime.now()

		self._txtinvitetips.text = self:_getLockStr(second)
	end

	local isMailUnlock = ActivityModel.instance:isActOnLine(VersionActivity3_7Enum.ActivityId.Anniversary3Mail)

	if not isMailUnlock then
		local second = ActivityModel.instance:getActStartTime(VersionActivity3_7Enum.ActivityId.Anniversary3Mail) / 1000 - ServerTime.now()

		self._txtmailtips.text = self:_getLockStr(second)
	end

	local isSignUnlock = ActivityModel.instance:isActOnLine(VersionActivity3_7Enum.ActivityId.Anniversary3Sign)

	if not isSignUnlock then
		local second = ActivityModel.instance:getActStartTime(VersionActivity3_7Enum.ActivityId.Anniversary3Sign) / 1000 - ServerTime.now()

		self._txtsigntips.text = self:_getLockStr(second)
	end

	local isSkinUnlock = ActivityModel.instance:isActOnLine(VersionActivity3_7Enum.ActivityId.Anniversary3Skin)

	if not isSkinUnlock then
		local second = ActivityModel.instance:getActStartTime(VersionActivity3_7Enum.ActivityId.Anniversary3Skin) / 1000 - ServerTime.now()

		self._txtskintime.text = self:_getLockStr(second)
	end

	local isActBpUnlock = ActivityModel.instance:isActOnLine(VersionActivity3_7Enum.ActivityId.Anniversary3ActBp)

	if not isActBpUnlock then
		local second = ActivityModel.instance:getActStartTime(VersionActivity3_7Enum.ActivityId.Anniversary3ActBp) / 1000 - ServerTime.now()

		self._txtactbptips.text = self:_getLockStr(second)
	end

	local isGameUnlock = ActivityModel.instance:isActOnLine(VersionActivity3_7Enum.ActivityId.Anniversary3GuessGame)

	if not isGameUnlock then
		local second = ActivityModel.instance:getActStartTime(VersionActivity3_7Enum.ActivityId.Anniversary3GuessGame) / 1000 - ServerTime.now()

		self._txtgametips.text = self:_getLockStr(second)
	end
end

function Anniversary3MainView:_refreshBtns()
	self:_refreshReportBtn()
	self:_refreshInviteBtn()
	self:_refreshMailBtn()
	self:_refreshSignBtn()
	self:_refreshSkinBtn()
	self:_refreshActBpBtn()
	self:_refreshGameBtn()
end

function Anniversary3MainView:_refreshReportBtn()
	local actId = VersionActivity3_7Enum.ActivityId.Anniversary3Report
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isOnline = actInfoMo:isOnline() and actInfoMo:isOpen() and not actInfoMo:isExpired()

	gohelper.setActive(self._goreport, isOnline)
	gohelper.setActive(self._goreportlock, false)

	local isReddotShow = isOnline and self:_isShowReportReddot()

	gohelper.setActive(self._goreportreddot, isReddotShow)
end

function Anniversary3MainView:_refreshInviteBtn()
	local actId = VersionActivity3_7Enum.ActivityId.Anniversary3Invite
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isExpire = actInfoMo:isExpired()

	if isExpire then
		gohelper.setActive(self._goinvitelock, true)
		gohelper.setActive(self._goinvitereddot, false)
		gohelper.setActive(self._goinvitetips2, false)

		return
	end

	local isUnlock = actInfoMo:isOnline() and actInfoMo:isOpen()

	gohelper.setActive(self._goinvitelock, not isUnlock)
	gohelper.setActive(self._goinvitetips2, isUnlock)

	if not isUnlock then
		local second = ActivityModel.instance:getActStartTime(actId) / 1000 - ServerTime.now()

		self._txtinvitetips.text = self:_getLockStr(second)
	end
end

function Anniversary3MainView:_refreshMailBtn()
	local actId = VersionActivity3_7Enum.ActivityId.Anniversary3Mail
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isExpire = actInfoMo:isExpired()

	if isExpire then
		gohelper.setActive(self._gomaillock, true)
		gohelper.setActive(self._gomailreddot, false)

		return
	end

	local isUnlock = actInfoMo:isOnline() and actInfoMo:isOpen()

	gohelper.setActive(self._gomaillock, not isUnlock)

	if not isUnlock then
		local second = ActivityModel.instance:getActStartTime(actId) / 1000 - ServerTime.now()

		self._txtsigntips.text = self:_getLockStr(second)
	end
end

function Anniversary3MainView:_refreshSignBtn()
	local actId = VersionActivity3_7Enum.ActivityId.Anniversary3Sign
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isExpire = actInfoMo:isExpired()

	if isExpire then
		gohelper.setActive(self._gosignlock, true)
		gohelper.setActive(self._gosignreddot, false)

		return
	end

	local isUnlock = actInfoMo:isOnline() and actInfoMo:isOpen()

	gohelper.setActive(self._gosignlock, not isUnlock)

	if not isUnlock then
		local second = ActivityModel.instance:getActStartTime(actId) / 1000 - ServerTime.now()

		self._txtmailtips.text = self:_getLockStr(second)
	end
end

function Anniversary3MainView:_refreshSkinBtn()
	local actId = VersionActivity3_7Enum.ActivityId.Anniversary3Skin
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isExpire = actInfoMo:isExpired()

	if isExpire then
		gohelper.setActive(self._goskinlock, true)
		gohelper.setActive(self._goskinreddot, false)

		return
	end

	local isUnlock = actInfoMo:isOnline() and actInfoMo:isOpen()

	gohelper.setActive(self._goskinlock, not isUnlock)

	if not isUnlock then
		local second = ActivityModel.instance:getActStartTime(actId) / 1000 - ServerTime.now()

		self._txtskintime.text = self:_getLockStr(second)
	end
end

function Anniversary3MainView:_refreshActBpBtn()
	local actId = VersionActivity3_7Enum.ActivityId.Anniversary3ActBp
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isExpire = actInfoMo:isExpired()

	if isExpire then
		gohelper.setActive(self._goactbpopen, false)
		gohelper.setActive(self._goactbplock, true)
		gohelper.setActive(self._goactbpreddot, false)
		gohelper.setActive(self._goactbprewardtip, false)

		return
	end

	local isUnlock = actInfoMo:isOnline() and actInfoMo:isOpen()

	gohelper.setActive(self._goactbpopen, isUnlock)
	gohelper.setActive(self._goactbplock, not isUnlock)
	gohelper.setActive(self._goactbpreddot, isUnlock)

	if not isUnlock then
		local second = ActivityModel.instance:getActStartTime(actId) / 1000 - ServerTime.now()

		self._txtactbptips.text = self:_getLockStr(second)

		gohelper.setActive(self._goactbprewardtip, false)
	else
		local isReddotShow = RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V3a7Anniversary3ActBp, 0)

		gohelper.setActive(self._goactbprewardtip, isReddotShow)
	end
end

function Anniversary3MainView:_refreshGameBtn()
	local actId = VersionActivity3_7Enum.ActivityId.Anniversary3GuessGame
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isExpire = actInfoMo:isExpired()

	if isExpire then
		self._imageprogresscircle.fillAmount = 0

		gohelper.setActive(self._gogamelock, true)
		gohelper.setActive(self._gogametips2, false)
		gohelper.setActive(self._gogamereddot, false)

		return
	end

	local isUnlock = actInfoMo:isOnline() and actInfoMo:isOpen()

	gohelper.setActive(self._gogamelock, not isUnlock)
	gohelper.setActive(self._gogametips2, isUnlock)
	gohelper.setActive(self._gogamereddot, isUnlock)

	if not isUnlock then
		local second = ActivityModel.instance:getActStartTime(actId) / 1000 - ServerTime.now()

		self._txtgametips.text = self:_getLockStr(second)
		self._imageprogresscircle.fillAmount = 0
	else
		local actId = VersionActivity3_7Enum.ActivityId.Anniversary3GuessGame
		local score = GuessGameModel.instance:getTotalScore(actId)
		local maxScore = GuessGameModel.instance:getMaxTotalScore(actId)

		if maxScore > 0 then
			if not (score / maxScore) then
				self._imageprogresscircle.fillAmount = 0
			end
		end
	end

	local isReddotShow = self:_isShowGameReddot()

	gohelper.setActive(self._gogamereddot, isReddotShow)
end

function Anniversary3MainView:_getLockStr(second)
	return string.format(luaLang("seasonmainview_timeopencondition"), string.format("%s%s", TimeUtil.secondToRoughTime2(second)))
end

function Anniversary3MainView:onClose()
	return
end

function Anniversary3MainView:onDestroyView()
	TaskDispatcher.cancelTask(self._refreshTime, self)
	self:_removeSelfEvents()
end

return Anniversary3MainView
