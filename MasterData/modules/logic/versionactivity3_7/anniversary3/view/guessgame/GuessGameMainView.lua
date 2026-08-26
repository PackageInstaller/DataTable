-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/guessgame/GuessGameMainView.lua

module("modules.logic.versionactivity3_7.anniversary3.view.guessgame.GuessGameMainView", package.seeall)

local GuessGameMainView = class("GuessGameMainView", BaseView)

function GuessGameMainView:onInitView()
	self._txttime = gohelper.findChildText(self.viewGO, "timebg/#txt_time")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_start")
	self._gofirsttip = gohelper.findChild(self.viewGO, "#go_firsttip")
	self._txtfirst = gohelper.findChildText(self.viewGO, "#go_firsttip/#txt_first")
	self._goprocess = gohelper.findChild(self.viewGO, "#go_process")
	self._simagereward = gohelper.findChildSingleImage(self.viewGO, "#go_process/#simage_reward")
	self._txtprogress = gohelper.findChildText(self.viewGO, "#go_process/#txt_progress")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "#go_process/#scroll_view")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_process/#scroll_view/Viewport/Content")
	self._imagefill = gohelper.findChildImage(self.viewGO, "#go_process/#scroll_view/Viewport/Content/progressbg/#image_fill")
	self._gorewarditem = gohelper.findChild(self.viewGO, "#go_process/#scroll_view/Viewport/Content/#go_rewarditem")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GuessGameMainView:addEvents()
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
end

function GuessGameMainView:removeEvents()
	self._btnstart:RemoveClickListener()
end

function GuessGameMainView:_btnstartOnClick()
	GuessGameController.instance:openGuessGamePlayView()
end

function GuessGameMainView:_editableInitView()
	self._rewardItems = self:getUserDataTb_()

	self:_addSelfEvents()
end

function GuessGameMainView:_addSelfEvents()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onCheckActState, self)
	self.addEventCb(self, GuessGameController.instance, GuessGameEvent.OnFinishGameBackToMain, self._onGameGuessFinished, self)
	self.addEventCb(self, GuessGameController.instance, GuessGameEvent.OnReceiveAcceptReward, self._onRewardGet, self)
end

function GuessGameMainView:_removeSelfEvents()
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onCheckActState, self)
	self.removeEventCb(self, GuessGameController.instance, GuessGameEvent.OnFinishGameBackToMain, self._onGameGuessFinished, self)
	self.removeEventCb(self, GuessGameController.instance, GuessGameEvent.OnReceiveAcceptReward, self._onRewardGet, self)
end

function GuessGameMainView:_onCheckActState()
	local status = ActivityHelper.getActivityStatus(self._actId)

	if status == ActivityEnum.ActivityStatus.Expired then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

		return
	end
end

function GuessGameMainView:_onGameGuessFinished()
	self:_refresh()
end

function GuessGameMainView:_onRewardGet()
	self:_refreshRewards()
end

function GuessGameMainView:onOpen()
	self._actId = VersionActivity3_7Enum.ActivityId.Anniversary3GuessGame

	AudioMgr.instance:trigger(AudioEnum3_2.play_ui_shengyan_box_songjin_open)
	self:_refresh()
	self:_refreshTime()
	TaskDispatcher.runRepeat(self._refreshTime, self, 1)
end

function GuessGameMainView:_refresh()
	self:_refreshUI()
	self:_refreshRewards()
end

function GuessGameMainView:_refreshUI()
	local isFirstShow = GuessGameModel.instance:isFirstShow(self._actId)

	gohelper.setActive(self._gofirsttip, isFirstShow)

	if isFirstShow then
		local multi = Activity234Config.instance:getConstNumberValue(GuessGameEnum.ConstId.DailyFirstBonusMulti)

		self._txtfirst.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("guessgame_dailymutiple_tip"), multi)
	end

	local curScore = GuessGameModel.instance:getTotalScore(self._actId)

	self._txtprogress.text = curScore

	if not self._score then
		self:_focusScore(curScore)
		self:_progressUpadate(curScore)

		self._score = curScore

		return
	end

	if self._score == curScore then
		return
	end

	self:_focusScore(curScore)
	self:_playProgrogress(self._score, curScore)

	self._score = curScore
end

local maxAnchorX = -1480
local minScore = 1000

function GuessGameMainView:_focusScore(score)
	local rewardCos = Activity234Config.instance:getBonusCos(self._actId)
	local totalScore = rewardCos[#rewardCos].coinNum
	local focusPosX = score <= minScore and 0 or score * maxAnchorX / totalScore

	recthelper.setAnchorX(self._gocontent.transform, focusPosX)
end

function GuessGameMainView:_playProgrogress(fromScore, toScore)
	self._tweenId = ZProj.TweenHelper.DOTweenFloat(fromScore, toScore, 1, self._progressUpadate, self._progressFinished, self)
end

function GuessGameMainView:_progressUpadate(value)
	local rewardCos = Activity234Config.instance:getBonusCos(self._actId)
	local totalScore = rewardCos[#rewardCos].coinNum

	self._imagefill.fillAmount = value / totalScore
end

function GuessGameMainView:_progressFinished()
	return
end

function GuessGameMainView:_refreshRewards()
	local rewardCos = Activity234Config.instance:getBonusCos(self._actId)

	if not rewardCos then
		return
	end

	for i = 1, #rewardCos do
		if not self._rewardItems[i] then
			self._rewardItems[i] = GuessGameMainRewardItem.New()

			local go = gohelper.cloneInPlace(self._gorewarditem)

			self._rewardItems[i]:init(go)
		end

		self._rewardItems[i]:refresh(rewardCos[i])
	end
end

function GuessGameMainView:_refreshTime()
	self._txttime.text = ActivityModel.getRemainTimeStr(self._actId)
end

function GuessGameMainView:onClose()
	return
end

function GuessGameMainView:onDestroyView()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	self:_removeSelfEvents()
	TaskDispatcher.cancelTask(self._refreshTime, self)

	if self._rewardItems then
		for _, item in pairs(self._rewardItems) do
			item:destroy()
		end

		self._rewardItems = nil
	end
end

return GuessGameMainView
