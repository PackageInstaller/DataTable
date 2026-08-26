-- chunkname: @modules/logic/sp01/enter/view/VersionActivity2_9EnterView.lua

module("modules.logic.sp01.enter.view.VersionActivity2_9EnterView", package.seeall)

local VersionActivity2_9EnterView = class("VersionActivity2_9EnterView", VersionActivityEnterBaseViewWithGroup)

VersionActivity2_9EnterView.UnitCameraKey = "VersionActivity2_9EnterView_UnitCameraKey"

function VersionActivity2_9EnterView:onInitView()
	VersionActivity2_9EnterView.super.onInitView(self)

	self._txtremaintime = gohelper.findChildText(self.viewGO, "logo/Time/timebg/#txt_remaintime")
	self._txtremaintime2 = gohelper.findChildText(self.viewGO, "logo2/Time/timebg/#txt_remaintime")
	self.txtDungeonStoreNum1 = gohelper.findChildText(self.viewGO, "entrance/#go_group1/activityContainer3/normal/#txt_num")
	self.txtDungeonStoreNum2 = gohelper.findChildText(self.viewGO, "entrance/#go_group2/activityContainer6/normal/#txt_num")
	self.txtDungeonStoreRemainTime1 = gohelper.findChildText(self.viewGO, "entrance/#go_group1/activityContainer3/#go_time/#txt_time")
	self.txtDungeonStoreRemainTime2 = gohelper.findChildText(self.viewGO, "entrance/#go_group2/activityContainer6/#go_time/#txt_time")
	self._btnachievementpreview = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_achievementpreview")
	self._btnodysseyreward = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#go_group2/activityContainer9/btn_reward")
	self._txtodysseylevel = gohelper.findChildText(self.viewGO, "entrance/#go_group2/activityContainer9/normal/#txt_level")
	self._gojumpblock = gohelper.findChild(self.viewGO, "#go_jumpblock")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_9EnterView:addEvents()
	VersionActivity2_9EnterView.super.addEvents(self)
	self._btnachievementpreview:AddClickListener(self._btnachievementpreviewOnClick, self)
	self._btnodysseyreward:AddClickListener(self._btnodysseyrewardOnClick, self)
end

function VersionActivity2_9EnterView:removeEvents()
	VersionActivity2_9EnterView.super.removeEvents(self)
	self._btnachievementpreview:RemoveClickListener()
	self._btnodysseyreward:RemoveClickListener()
end

function VersionActivity2_9EnterView:_editableInitView()
	VersionActivity2_9EnterView.super._editableInitView(self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.refreshActivityState, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshCurrency, self)
	self.addEventCb(self, VersionActivity2_9EnterController.instance, VersionActivity2_9Event.SwitchGroup, self._switchGroupIndex, self)
	self.addEventCb(self, OdysseyController.instance, OdysseyEvent.RefreshHeroInfo, self.refreshOdysseyLevel, self)
	self.addEventCb(self, OdysseyController.instance, OdysseyEvent.OdysseyTaskUpdated, self.refreshReddot, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, NavigateMgr.instance, NavigateEvent.ClickHome, self._clickHome, self)

	self.reddotIconMap = self:getUserDataTb_()

	CameraMgr.instance:setSceneCameraActive(false, VersionActivity2_9EnterView.UnitCameraKey)

	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
end

function VersionActivity2_9EnterView:_btnachievementpreviewOnClick()
	local activityCfg = ActivityConfig.instance:getActivityCo(self.actId)
	local achievementJumpId = activityCfg and activityCfg.achievementJumpId

	JumpController.instance:jump(achievementJumpId)
end

function VersionActivity2_9EnterView:_btnodysseyrewardOnClick()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Odyssey
	}, function()
		OdysseyTaskModel.instance:setTaskInfoList()
		OdysseyDungeonController.instance:openLevelRewardView()
	end)
end

function VersionActivity2_9EnterView:_activityBtnOnClick(activityItem)
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

function VersionActivity2_9EnterView:onClickActivity130504()
	AssassinController.instance:openAssassinMapView(nil, true)
end

function VersionActivity2_9EnterView:onClickActivity130505()
	BossRushController.instance:openMainView()
end

function VersionActivity2_9EnterView:onClickActivity130503()
	VersionActivity2_9DungeonController.instance:openStoreView()
end

function VersionActivity2_9EnterView:onClickActivity130502()
	local chapterId = VersionActivity2_9DungeonEnum.DungeonChapterId.Story
	local isAdvancePass = VersionActivity2_9DungeonHelper.isAllEpisodeAdvacePass(chapterId)

	if isAdvancePass then
		local focusEpisodeId = AssassinConfig.instance:getAssassinConst(AssassinEnum.ConstId.FocusEpisodeId, true)

		VersionActivity2_9DungeonController.instance:openVersionActivityDungeonMapView(chapterId, focusEpisodeId)
	else
		VersionActivity2_9DungeonController.instance:openVersionActivityDungeonMapView()
	end
end

function VersionActivity2_9EnterView:onClickActivity130507()
	OdysseyDungeonModel.instance:cleanLastElementFightParam()
	OdysseyDungeonController.instance:openDungeonView()
end

function VersionActivity2_9EnterView:refreshUI()
	VersionActivity2_9EnterView.super.refreshUI(self)
	self:refreshOdysseyLevel()
	self:refreshEnterViewTime()
	self:updateAchievementBtnVisible()
	self:refreshCurrency()
	self:refreshDungeonStoreTime()
	self:refreshReddot()
end

function VersionActivity2_9EnterView:refreshOdysseyLevel()
	self._txtodysseylevel.text = OdysseyModel.instance:getHeroCurLevelAndExp() or 1
end

function VersionActivity2_9EnterView:refreshEnterViewTime()
	self:refreshRemainTime()
end

function VersionActivity2_9EnterView:refreshCurrency()
	local currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V2a9Dungeon)

	if currencyMO then
		if not currencyMO.quantity then
			local quantity = 0

			self.txtDungeonStoreNum1.text = quantity
			self.txtDungeonStoreNum2.text = quantity
		end
	end
end

function VersionActivity2_9EnterView:refreshDungeonStoreTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity2_9Enum.ActivityId.DungeonStore]
	local remainTimeStr = actInfoMo and actInfoMo:getRemainTimeStr2ByEndTime(true)

	self.txtDungeonStoreRemainTime1.text = remainTimeStr
	self.txtDungeonStoreRemainTime2.text = remainTimeStr
end

function VersionActivity2_9EnterView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()
	local str = string.format(luaLang("remain"), TimeUtil.SecondToActivityTimeFormat(offsetSecond))

	self._txtremaintime.text = str
	self._txtremaintime2.text = str
end

function VersionActivity2_9EnterView:everyMinuteCall()
	VersionActivity2_9EnterView.super.everyMinuteCall(self)
	self:refreshRemainTime()
	self:refreshDungeonStoreTime()
end

function VersionActivity2_9EnterView:updateAchievementBtnVisible()
	local actCfg = ActivityConfig.instance:getActivityCo(self.actId)

	gohelper.setActive(self._btnachievementpreview.gameObject, actCfg and actCfg.achievementJumpId ~= 0)
end

function VersionActivity2_9EnterView:initBtnGroup()
	self.groupItemList = {}
end

function VersionActivity2_9EnterView:onCloseViewFinish(viewName)
	VersionActivity2_9EnterView.super.onCloseViewFinish(self, viewName)
	self:playAnimWhileCloseTargetView(viewName)
	self:tryTriggerGuide()
end

function VersionActivity2_9EnterView:playAnimWhileCloseTargetView(viewName)
	if viewName ~= ViewName.VersionActivity2_9DungeonMapView and viewName ~= ViewName.OdysseyDungeonView then
		return
	end

	local stateName = self.showGroupIndex == 1 and "game_a" or "game_b"

	self.animator:Play(stateName, 0, 0)
end

function VersionActivity2_9EnterView:_switchGroupIndex()
	self.showGroupIndex = self.showGroupIndex == 1 and 2 or 1

	local animName = self.showGroupIndex == 1 and "switch_b" or "switch_a"

	self._animatorPlayer:Play(animName, self._onSwitchGroupIndexDone, self)
	VersionActivity2_9EnterController.instance:dispatchEvent(VersionActivity2_9Event.StopBgm)
end

function VersionActivity2_9EnterView:_onSwitchGroupIndexDone()
	ActivityStageHelper.recordOneActivityStage(self.mainActIdList[self.showGroupIndex])
	VersionActivity2_9EnterController.instance:recordLastEnterMainActId(self.mainActIdList[self.showGroupIndex])
	VersionActivity2_9EnterController.instance:dispatchEvent(VersionActivity2_9Event.ManualSwitchBgm)
end

function VersionActivity2_9EnterView:playAmbientAudio()
	return
end

function VersionActivity2_9EnterView:initGroupIndex()
	self.showGroupIndex = tabletool.indexOf(VersionActivity2_9Enum.EnterViewMainActIdList, self.actId) or 1

	ActivityStageHelper.recordOneActivityStage(self.mainActIdList[self.showGroupIndex])
end

function VersionActivity2_9EnterView:onOpen()
	VersionActivity2_9EnterView.super.onOpen(self)
	gohelper.setActive(self._gojumpblock, self.viewParam and self.viewParam.skipOpenAnim)
end

function VersionActivity2_9EnterView:onOpenFinish()
	VersionActivity2_9EnterView.super.onOpenFinish(self)
	CameraMgr.instance:setSceneCameraActive(true, VersionActivity2_9EnterView.UnitCameraKey)
end

function VersionActivity2_9EnterView:tryTriggerGuide()
	local isGuideFinish = GuideModel.instance:isGuideFinish(VersionActivity2_9Enum.NextGroupGuideId)
	local isTriggerGuide = not isGuideFinish and not self.onOpening and ViewHelper.instance:checkViewOnTheTop(self.viewName) and ActivityHelper.isOpen(VersionActivity2_9Enum.ActivityId.EnterView2)

	if isTriggerGuide then
		VersionActivity2_9EnterController.instance:dispatchEvent(VersionActivity2_9Event.UnlockNextHalf)
	end
end

function VersionActivity2_9EnterView:refreshActivityState(actId)
	if not ActivityHelper.isOpen(actId) then
		return
	end

	if actId == VersionActivity2_9Enum.ActivityId.Dungeon2 then
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.Odyssey
		}, function()
			OdysseyTaskModel.instance:setTaskInfoList()
		end)
	elseif actId == VersionActivity2_9Enum.ActivityId.EnterView2 then
		self:tryTriggerGuide()
	end
end

function VersionActivity2_9EnterView:refreshReddot()
	for _, activityItem in ipairs(self.activityItemListWithGroup[self.showGroupIndex]) do
		local reddotIconItem = self.reddotIconMap[activityItem.index]

		if not reddotIconItem then
			reddotIconItem = {
				goRedPoint = activityItem.goRedPoint,
				rootGo = activityItem.rootGo
			}
			reddotIconItem.reddotIcon = activityItem.goRedPoint and RedDotController.instance:getRedDotComp(activityItem.goRedPoint)
			reddotIconItem.customReddotIconGO = gohelper.findChild(activityItem.rootGo, "go_RedPoint")
			self.reddotIconMap[activityItem.index] = reddotIconItem
		end

		gohelper.setActive(reddotIconItem.goRedPoint, false)

		if reddotIconItem.reddotIcon then
			reddotIconItem.reddotIcon:defaultRefreshDot()
		end

		gohelper.setActive(reddotIconItem.customReddotIconGO, reddotIconItem.reddotIcon and reddotIconItem.reddotIcon.show)
	end

	self:refreshLevelRewardEnterReddot()
end

function VersionActivity2_9EnterView:refreshLevelRewardEnterReddot()
	local reddotIconItem = self.reddotIconMap[9]

	if not reddotIconItem then
		return
	end

	local reddotIconGO = gohelper.findChild(reddotIconItem.rootGo, "go_RedPoint1")
	local hasRewardCanGet = OdysseyTaskModel.instance:checkHasLevelReawrdTaskCanGet()

	gohelper.setActive(reddotIconGO, hasRewardCanGet)
end

function VersionActivity2_9EnterView:getVersionActivityItem(actId)
	if self.activityItemListWithGroup then
		if self.activityItemListWithGroup then
			for _, activityItem in ipairs(self.activityItemListWithGroup) do
				if activityItem.actId == actId then
					return activityItem
				end
			end
		end
	end
end

function VersionActivity2_9EnterView:_onOpenView(viewName)
	if viewName ~= ViewName.VersionActivity2_9DungeonMapView and viewName ~= ViewName.OdysseyDungeonView then
		return
	end

	local stateName = self.showGroupIndex == 1 and "close_a" or "close_b"

	self.animator:Play(stateName, 0, 0)
end

function VersionActivity2_9EnterView:refreshActivityItem(activityItem)
	VersionActivity2_9EnterView.super.refreshActivityItem(self, activityItem)

	if activityItem.txtRemainTime then
		activityItem.txtRemainTime.text = ActivityHelper.getActivityRemainTimeStr(activityItem.actId)
	end

	local isOpen = ActivityHelper.isOpen(activityItem.actId)
	local showTimeFlag = isOpen and not activityItem.showTag

	gohelper.setActive(activityItem.goTime, showTimeFlag)
end

function VersionActivity2_9EnterView:_playActTagAnimation(activityItem)
	VersionActivity2_9EnterView.super._playActTagAnimation(self, activityItem)

	local isOpen = ActivityHelper.isOpen(activityItem.actId)
	local showTimeFlag = isOpen and not activityItem.showTag

	gohelper.setActive(activityItem.goTime, showTimeFlag)
end

function VersionActivity2_9EnterView:getLockText(activityItem, activityStatus)
	local lockText = VersionActivity2_9EnterView.super.getLockText(self, activityItem, activityStatus)

	return (activityStatus == ActivityEnum.ActivityStatus.NotUnlock or nil) and OpenHelper.getActivityUnlockTxt(activityItem.openId)
end

function VersionActivity2_9EnterView:onOpenAnimationDone()
	VersionActivity2_9EnterView.super.onOpenAnimationDone(self)
	gohelper.setActive(self._gojumpblock, false)
	self:tryTriggerGuide()
end

function VersionActivity2_9EnterView:onClose()
	CameraMgr.instance:setSceneCameraActive(true, VersionActivity2_9EnterView.UnitCameraKey)
	VersionActivity2_9EnterView.super.onClose(self)
end

function VersionActivity2_9EnterView:beforePlayOpenAnimation()
	local enterActId = self.mainActIdList[self.showGroupIndex]
	local audioId = enterActId and self.actId2OpenAudioDict[enterActId]

	if audioId and audioId ~= 0 then
		AudioMgr.instance:trigger(audioId)
	end
end

function VersionActivity2_9EnterView:_clickHome()
	VersionActivity2_9EnterController.instance:clearLastEnterMainActId()
end

return VersionActivity2_9EnterView
