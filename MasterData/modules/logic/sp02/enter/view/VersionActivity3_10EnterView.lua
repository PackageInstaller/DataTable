-- chunkname: @modules/logic/sp02/enter/view/VersionActivity3_10EnterView.lua

module("modules.logic.sp02.enter.view.VersionActivity3_10EnterView", package.seeall)

local VersionActivity3_10EnterView = class("VersionActivity3_10EnterView", VersionActivityEnterBaseView)

VersionActivity3_10EnterView.UnitCameraKey = "VersionActivity3_10EnterView_UnitCameraKey"

function VersionActivity3_10EnterView:onInitView()
	VersionActivity3_10EnterView.super.onInitView(self)

	self._txtremaintime = gohelper.findChildText(self.viewGO, "Title/Time/timebg/#txt_remaintime")
	self._btnachievementpreview = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_achievementpreview")
	self.txtDungeonStoreNum = gohelper.findChildText(self.viewGO, "entrance/activityContainer2/normal/#txt_num")
	self.txtDungeonStoreRemainTime = gohelper.findChildText(self.viewGO, "entrance/activityContainer2/#go_time/#txt_time")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity3_10EnterView:addEvents()
	VersionActivity3_10EnterView.super.addEvents(self)
	self.addClickCb(self, self._btnachievementpreview, self._btnachievementpreviewOnClick, self)
end

function VersionActivity3_10EnterView:removeEvents()
	VersionActivity3_10EnterView.super.removeEvents(self)
	self:removeClickCb(self._btnachievementpreview)
end

function VersionActivity3_10EnterView:_editableInitView()
	VersionActivity3_10EnterView.super._editableInitView(self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshCurrency, self)

	self.reddotIconMap = self:getUserDataTb_()

	CameraMgr.instance:setSceneCameraActive(false, VersionActivity3_10EnterView.UnitCameraKey)

	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
end

function VersionActivity3_10EnterView:_btnachievementpreviewOnClick()
	local activityCfg = ActivityConfig.instance:getActivityCo(self.actId)
	local achievementJumpId = activityCfg and activityCfg.achievementJumpId

	JumpController.instance:jump(achievementJumpId)
end

function VersionActivity3_10EnterView:_activityBtnOnClick(activityItem)
	if activityItem.actId == ActivityEnum.PlaceholderActivityId then
		return
	end

	local checkFunc = self["checkActivityCanClickFunc" .. activityItem.index]

	checkFunc = checkFunc or self.defaultCheckActivityCanClick

	if not checkFunc(self, activityItem) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_sign)

	if not self["onClickActivity" .. activityItem.actId] then
		if self["onClickActivity" .. activityItem.actId] then
			self["onClickActivity" .. activityItem.actId](self)
		end

		ActivityEnterMgr.instance:enterActivity(activityItem.actId)
	end
end

function VersionActivity3_10EnterView:onClickActivity138507()
	AtomicDungeonController.instance:openDungeonView()
end

function VersionActivity3_10EnterView:onClickActivity138520()
	BossRushController.instance:openV3a2MainView()
end

function VersionActivity3_10EnterView:onClickActivity138503()
	VersionActivity3_10DungeonController.instance:openStoreView()
end

function VersionActivity3_10EnterView:onClickActivity138502()
	VersionActivity3_10DungeonController.instance:openVersionActivityDungeonMapView()
end

function VersionActivity3_10EnterView:onClickActivity138521()
	AbyssController.instance:getTaskInfo(function()
		AbyssController.instance:openMainView(VersionActivity3_10Enum.ActivityId.Abyss)
	end)
end

function VersionActivity3_10EnterView:refreshUI()
	VersionActivity3_10EnterView.super.refreshUI(self)
	self:refreshEnterViewTime()
	self:updateAchievementBtnVisible()
	self:refreshCurrency()
end

function VersionActivity3_10EnterView:refreshEnterViewTime()
	self:refreshRemainTime()
	self:refreshDungeonStoreTime()
end

function VersionActivity3_10EnterView:refreshCurrency()
	local currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V3a10Dungeon)

	if currencyMO then
		if not currencyMO.quantity then
			self.txtDungeonStoreNum.text = 0
		end
	end
end

function VersionActivity3_10EnterView:refreshDungeonStoreTime()
	local actInfoMo = ActivityModel.instance:getActMO(VersionActivity3_10Enum.ActivityId.DungeonStore)

	self.txtDungeonStoreRemainTime.text = actInfoMo and actInfoMo:getRemainTimeStr2ByEndTime(true)
end

function VersionActivity3_10EnterView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	self._txtremaintime.text = string.format(luaLang("remain"), TimeUtil.SecondToActivityTimeFormat(offsetSecond))
end

function VersionActivity3_10EnterView:everyMinuteCall()
	VersionActivity3_10EnterView.super.everyMinuteCall(self)
	self:refreshEnterViewTime()
end

function VersionActivity3_10EnterView:updateAchievementBtnVisible()
	local actCfg = ActivityConfig.instance:getActivityCo(self.actId)

	gohelper.setActive(self._btnachievementpreview.gameObject, actCfg and actCfg.achievementJumpId ~= 0)
end

function VersionActivity3_10EnterView:initBtnGroup()
	self.groupItemList = {}
end

function VersionActivity3_10EnterView:onCloseViewFinish(viewName)
	VersionActivity3_10EnterView.super.onCloseViewFinish(self, viewName)
	self:playAnimWhileCloseTargetView(viewName)
end

function VersionActivity3_10EnterView:_onSwitchGroupIndexDone()
	ActivityStageHelper.recordOneActivityStage(self.mainActIdList[self.showGroupIndex])
	VersionActivity3_10EnterController.instance:recordLastEnterMainActId(self.mainActIdList[self.showGroupIndex])
	VersionActivity3_10EnterController.instance:dispatchEvent(VersionActivity3_10Event.ManualSwitchBgm)
end

function VersionActivity3_10EnterView:playAmbientAudio()
	return
end

function VersionActivity3_10EnterView:initGroupIndex()
	self.showGroupIndex = tabletool.indexOf(VersionActivity3_10Enum.EnterViewMainActIdList, self.actId) or 1

	ActivityStageHelper.recordOneActivityStage(self.mainActIdList[self.showGroupIndex])
end

function VersionActivity3_10EnterView:onOpen()
	self.onOpening = true

	self:initViewParam()
	self:initActivityNode()
	self:initActivityItemList()
	self:refreshUI()
end

function VersionActivity3_10EnterView:onOpenFinish()
	VersionActivity3_10EnterView.super.onOpenFinish(self)
	CameraMgr.instance:setSceneCameraActive(true, VersionActivity3_10EnterView.UnitCameraKey)
	self:playOpenAnimation()
end

function VersionActivity3_10EnterView:refreshActivityItem(activityItem)
	VersionActivity3_10EnterView.super.refreshActivityItem(self, activityItem)

	if activityItem.txtRemainTime then
		activityItem.txtRemainTime.text = ActivityHelper.getActivityRemainTimeStr(activityItem.actId)
	end
end

function VersionActivity3_10EnterView:getLockText(activityItem, activityStatus)
	local lockText = VersionActivity3_10EnterView.super.getLockText(self, activityItem, activityStatus)

	return (activityStatus == ActivityEnum.ActivityStatus.NotUnlock or nil) and OpenHelper.getActivityUnlockTxt(activityItem.openId)
end

function VersionActivity3_10EnterView:_playActUnlockAnimation(activityItem)
	if not activityItem then
		return
	end

	VersionActivityBaseController.instance:playedActivityUnlockAnimation(activityItem.actId)

	if activityItem.lockAnimator then
		if activityItem.goNormalAnimator then
			activityItem.goNormalAnimator.enabled = true
		end

		activityItem.lockAnimator:Play(UIAnimationName.Unlock, 0, 0)
		self:playTimeUnlock(activityItem)

		if not self.playedActUnlockAudio then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_unlock)

			self.playedActUnlockAudio = true
		end

		self.playingUnlockAnimation = true

		TaskDispatcher.runDelay(self.playUnlockAnimationDone, self, VersionActivityEnterBaseView.ActUnlockAnimationDuration)
	end
end

function VersionActivity3_10EnterView:onRefreshActivity3(activityItem)
	local goBg = gohelper.findChild(activityItem.goNormal, "bg")
	local goBgLock = gohelper.findChild(activityItem.goNormal, "bglock")
	local activityStatus = ActivityHelper.getActivityStatus(activityItem.actId)
	local isNormal = activityStatus == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(goBgLock, not isNormal)
	gohelper.setActive(goBg, isNormal)
end

function VersionActivity3_10EnterView:onClose()
	CameraMgr.instance:setSceneCameraActive(true, VersionActivity3_10EnterView.UnitCameraKey)
	VersionActivity3_10EnterView.super.onClose(self)
end

return VersionActivity3_10EnterView
