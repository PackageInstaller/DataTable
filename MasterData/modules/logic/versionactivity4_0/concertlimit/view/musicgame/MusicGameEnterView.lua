-- chunkname: @modules/logic/versionactivity4_0/concertlimit/view/musicgame/MusicGameEnterView.lua

module("modules.logic.versionactivity4_0.concertlimit.view.musicgame.MusicGameEnterView", package.seeall)

local MusicGameEnterView = class("MusicGameEnterView", BaseView)

function MusicGameEnterView:onInitView()
	self._txttime = gohelper.findChildText(self.viewGO, "timebg/#txt_time")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_start")
	self._gofirst = gohelper.findChild(self.viewGO, "#go_first")
	self._txtfirst = gohelper.findChildText(self.viewGO, "#go_first/#txt_first")
	self._goprocess = gohelper.findChild(self.viewGO, "#go_process")
	self._txttotalScore = gohelper.findChildText(self.viewGO, "#go_process/layout/#txt_totalScore")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "#go_process/#scroll_view")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_process/#scroll_view/Viewport/#go_content")
	self._imagefill = gohelper.findChildImage(self.viewGO, "#go_process/#scroll_view/Viewport/#go_content/progressbg/#image_fill")
	self._gorewarditem = gohelper.findChild(self.viewGO, "#go_process/#scroll_view/Viewport/#go_content/#go_rewarditem")
	self._gorewardlight = gohelper.findChild(self.viewGO, "#go_process/#scroll_view/Viewport/#go_content/#go_rewarditem/go_light")
	self._gorewardreward = gohelper.findChild(self.viewGO, "#go_process/#scroll_view/Viewport/#go_content/#go_rewarditem/go_reward")
	self._gorewardpoint = gohelper.findChild(self.viewGO, "#go_process/#scroll_view/Viewport/#go_content/#go_rewarditem/go_point")
	self._gorewardpointgrey = gohelper.findChild(self.viewGO, "#go_process/#scroll_view/Viewport/#go_content/#go_rewarditem/go_point/go_pointgrey")
	self._gorewardpointlight = gohelper.findChild(self.viewGO, "#go_process/#scroll_view/Viewport/#go_content/#go_rewarditem/go_point/go_pointlight")
	self._txtrewardgrad = gohelper.findChildText(self.viewGO, "#go_process/#scroll_view/Viewport/#go_content/#go_rewarditem/go_point/txt_grad")
	self._txtrewardpoint = gohelper.findChildText(self.viewGO, "#go_process/#scroll_view/Viewport/#go_content/#go_rewarditem/go_point/txt_point")
	self._gorewardpreview = gohelper.findChild(self.viewGO, "#go_process/#go_rewardpreview")
	self._gosprewarditem = gohelper.findChild(self.viewGO, "#go_process/#go_rewardpreview/#go_sprewarditem")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MusicGameEnterView:addEvents()
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
end

function MusicGameEnterView:removeEvents()
	self._btnstart:RemoveClickListener()
end

function MusicGameEnterView:_btnstartOnClick()
	AudioMgr.instance:trigger(AudioEnum4_0.MusicGame.stop_ui_yingmen4_0_open_music)
	MusicGameController.instance:openMusicGameMainView()
end

function MusicGameEnterView:_editableInitView()
	self._actId = VersionActivity4_0Enum.ActivityId.ConcertMusicGame

	self:_initView()
	self:_addSelfEvents()
end

function MusicGameEnterView:_initView()
	self._rewardItems = self:getUserDataTb_()

	gohelper.setActive(self._gorewardpreview, true)
end

function MusicGameEnterView:_addSelfEvents()
	self._scrollview:AddOnValueChanged(self._onScrollRectValueChanged, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onCheckActState, self)
	self.addEventCb(self, GuessGameController.instance, GuessGameEvent.OnFinishGame, self._refresh, self)
	self.addEventCb(self, GuessGameController.instance, GuessGameEvent.OnReceiveAcceptReward, self._refresh, self)
end

function MusicGameEnterView:_removeSelfEvents()
	self._scrollview:RemoveOnValueChanged()
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onCheckActState, self)
	self.removeEventCb(self, GuessGameController.instance, GuessGameEvent.OnFinishGame, self._refresh, self)
	self.removeEventCb(self, GuessGameController.instance, GuessGameEvent.OnReceiveAcceptReward, self._refresh, self)
end

function MusicGameEnterView:_onScrollRectValueChanged()
	self:_refreshSpRewards()
end

function MusicGameEnterView:_onCheckActState()
	local status = ActivityHelper.getActivityStatus(self._actId)

	if status == ActivityEnum.ActivityStatus.Expired then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

		return
	end
end

function MusicGameEnterView:onOpen()
	AudioMgr.instance:trigger(AudioEnum4_0.MusicGame.play_ui_yingmen4_0_open_music)
	self:_refresh()
	self:_refreshTime()
	TaskDispatcher.runRepeat(self._refreshTime, self, 1)
end

function MusicGameEnterView:_refresh()
	self:_refreshUI()
	self:_refreshInitReward()
	self:_refreshRewards()
	self:_refreshSpRewards()
end

function MusicGameEnterView:_refreshUI()
	local isFirstShow = MusicGameModel.instance:isFirstShow(self._actId)

	gohelper.setActive(self._gofirst, isFirstShow)

	local curScore = MusicGameModel.instance:getTotalScore(self._actId)

	self._txttotalScore.text = curScore

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

local maxAnchorX = -1824
local minScore = 1000

function MusicGameEnterView:_focusScore(score)
	local rewardCos = MusicGameConfig.instance:getBonusCos(self._actId)

	if rewardCos then
		if not rewardCos[#rewardCos].coinNum then
			local totalScore = 0

			recthelper.setAnchorX(self._gocontent.transform, (score > minScore or nil) and (totalScore > 0 and score * maxAnchorX / totalScore or 0))
		end
	end
end

function MusicGameEnterView:_playProgrogress(fromScore, toScore)
	self._tweenId = ZProj.TweenHelper.DOTweenFloat(fromScore, toScore, 1, self._progressUpadate, self._progressFinished, self)
end

function MusicGameEnterView:_progressUpadate(value)
	local rewardCos = MusicGameConfig.instance:getBonusCos()

	if rewardCos then
		if not rewardCos[#rewardCos].coinNum then
			local totalScore = 0

			if totalScore > 0 then
				self._imagefill.fillAmount = 0.965 * value / totalScore or 0
			end
		end
	end
end

function MusicGameEnterView:_progressFinished()
	return
end

function MusicGameEnterView:_refreshRewards()
	local rewardCos = MusicGameConfig.instance:getBonusCos()

	if not rewardCos then
		return
	end

	for i = 1, #rewardCos do
		if not self._rewardItems[i] then
			self._rewardItems[i] = MusicGameEnterRewardItem.New()

			local go = gohelper.cloneInPlace(self._gorewarditem)

			self._rewardItems[i]:init(go)
		end

		self._rewardItems[i]:refresh(rewardCos[i])
	end
end

function MusicGameEnterView:_refreshInitReward()
	gohelper.setActive(self._gorewarditem, true)
	gohelper.setActive(self._gorewardlight, false)
	gohelper.setActive(self._gorewardreward, false)
	gohelper.setActive(self._gorewardpoint, true)

	local score = MusicGameModel.instance:getTotalScore(self._actId)

	gohelper.setActive(self._gorewardpointgrey, score <= 0)
	gohelper.setActive(self._gorewardpointlight, score > 0)
	gohelper.setActive(self._txtrewardgrad.gameObject, score <= 0)
	gohelper.setActive(self._txtrewardpoint.gameObject, score > 0)

	self._txtrewardgrad.text = "0"
	self._txtrewardpoint.text = "0"
end

local startPosX = 0
local endPosX = -1607
local startLv = 4

function MusicGameEnterView:_refreshSpRewards()
	local keyLvs = MusicGameConfig.instance:getBonusLvs()
	local keyLv = #keyLvs
	local bonusCos = MusicGameConfig.instance:getBonusCos(self._actId)
	local endLv = #bonusCos
	local curPosX, _, _ = transformhelper.getLocalPos(self._gocontent.transform)
	local curLvIndex = startLv + math.floor((curPosX - startPosX) * (endLv - startLv) / (endPosX - startPosX))

	for i = curLvIndex, endLv do
		if bonusCos[i] and bonusCos[i].isBigReward and bonusCos[i].isBigReward >= 1 then
			keyLv = i

			break
		end
	end

	if keyLv <= 0 then
		for i = curLvIndex, 1, -1 do
			if bonusCos[i] and bonusCos[i].isBigReward and bonusCos[i].isBigReward >= 1 then
				keyLv = i

				break
			end
		end
	end

	self._keyLv = keyLv

	local co = MusicGameConfig.instance:getBonusCo(self._keyLv, self._actId)

	if not co then
		return
	end

	if not self._keyBonusItem then
		self._keyBonusItem = MusicGameEnterRewardItem.New()

		self._keyBonusItem:init(self._gosprewarditem)
	end

	self._keyBonusItem:refresh(co)
end

function MusicGameEnterView:_refreshTime()
	self._txttime.text = ActivityModel.getRemainTimeStr(self._actId)
end

function MusicGameEnterView:onClose()
	AudioMgr.instance:trigger(AudioEnum4_0.MusicGame.stop_ui_yingmen4_0_open_music)
end

function MusicGameEnterView:onDestroyView()
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

	if self._keyBonusItem then
		self._keyBonusItem:destroy()

		self._keyBonusItem = nil
	end
end

return MusicGameEnterView
