-- chunkname: @modules/logic/versionactivity3_3/arcade/view/ArcadeEnterView.lua

module("modules.logic.versionactivity3_3.arcade.view.ArcadeEnterView", package.seeall)

local ArcadeEnterView = class("ArcadeEnterView", VersionActivityEnterBaseSubView)

function ArcadeEnterView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Right/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Right/image_LimitTimeBG/#txt_LimitTime")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Right/#txt_Descr")
	self._gorewards = gohelper.findChild(self.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Enter")
	self._goreddot = gohelper.findChild(self.viewGO, "Right/#btn_Enter/#go_reddot")
	self._btnLocked = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Locked")
	self._txtUnLocked = gohelper.findChildText(self.viewGO, "Right/#btn_Locked/#txt_UnLocked")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_task")
	self._gotaskreddot = gohelper.findChild(self.viewGO, "Right/#btn_task/#go_reddot")
	self._btnachievement = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_achievementpreview")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeEnterView:addEvents()
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
	self._btnLocked:AddClickListener(self._btnLockedOnClick, self)
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self._btnachievement:AddClickListener(self._btnachievementOnClick, self)
	self.addEventCb(self, ArcadeController.instance, ArcadeEvent.OnExitHallView, self._onExitHallView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function ArcadeEnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnLocked:RemoveClickListener()
	self._btntask:RemoveClickListener()
	self._btnachievement:RemoveClickListener()
	self.removeEventCb(self, ArcadeController.instance, ArcadeEvent.OnExitHallView, self._onExitHallView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function ArcadeEnterView:_btnachievementOnClick()
	local jumpId = self.actCo.achievementJumpId

	JumpController.instance:jump(jumpId)
end

function ArcadeEnterView:_btnEnterOnClick()
	self._animPlayer:Play(UIAnimationName.Close, function()
		ArcadeGameController.instance:getArcadeInSideInfo()
	end, self)
	ArcadeController.instance:dispatchEvent(ArcadeEvent.OnReadyEnterHallView)
end

function ArcadeEnterView:_btnLockedOnClick()
	ArcadeModel.instance:isAct222Open(true)
end

function ArcadeEnterView:_btntaskOnClick()
	return
end

function ArcadeEnterView:_editableInitView()
	self.actId = ArcadeModel.instance:getAct222Id()
	self.actCo = ActivityConfig.instance:getActivityCo(self.actId)
	self._txtDescr.text = self.actCo.actDesc
	self._animPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO.gameObject)

	if self.actCo.redDotId ~= 0 then
		gohelper.setActive(self._goreddot, true)
		RedDotController.instance:addRedDot(self._goreddot, self.actCo.redDotId)
	end
end

function ArcadeEnterView:onOpen()
	local viewAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if viewAnimator then
		viewAnimator.enabled = true

		viewAnimator:Play(UIAnimationName.Open, 0, 0)
	end

	AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_game_open)
	self:everySecondCall()
	self:beginPerSecondRefresh()
end

function ArcadeEnterView:onEnterVideoFinished()
	local viewAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	viewAnimator.enabled = true

	viewAnimator:Play(UIAnimationName.Open, 0, 0)
	AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_game_open)
end

function ArcadeEnterView:_onExitHallView()
	self._animPlayer:Play(UIAnimationName.Open, nil, nil)
end

function ArcadeEnterView:_onCloseViewFinish(viewName)
	local isOpenHallView = ViewMgr.instance:isOpen(ViewName.ArcadeHallView)

	if viewName == ViewName.ArcadeGameView and not isOpenHallView then
		self._animPlayer:Play(UIAnimationName.Open, nil, nil)
	end
end

function ArcadeEnterView:everySecondCall()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]

	if actInfoMo then
		local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

		gohelper.setActive(self._txtLimitTime.gameObject, offsetSecond > 0)

		if offsetSecond > 0 then
			self._txtLimitTime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
		end

		local isLock = ActivityHelper.getActivityStatus(self.actId) ~= ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(self._btnEnter, not isLock)
		gohelper.setActive(self._btnLocked, isLock)
	end
end

return ArcadeEnterView
