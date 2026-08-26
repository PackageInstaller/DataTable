-- chunkname: @modules/logic/versionactivity2_3/zhixinquaner/view/ZhiXinQuanErLevelView.lua

module("modules.logic.versionactivity2_3.zhixinquaner.view.ZhiXinQuanErLevelView", package.seeall)

local ZhiXinQuanErLevelView = class("ZhiXinQuanErLevelView", BaseView)
local FocusDuration = 0.5

function ZhiXinQuanErLevelView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "bgs/#simage_FullBG")
	self._simageFullBG2 = gohelper.findChildSingleImage(self.viewGO, "bgs/#simage_FullBG/#simage_FullBG2")
	self._gostoryPath = gohelper.findChild(self.viewGO, "#go_storyPath")
	self._gostoryScroll = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll")
	self._gostoryStages = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages")
	self._gofightPath = gohelper.findChild(self.viewGO, "#go_fightPath")
	self._gofightScroll = gohelper.findChild(self.viewGO, "#go_fightPath/#go_fightScroll")
	self._gofightStages = gohelper.findChild(self.viewGO, "#go_fightPath/#go_fightScroll/#go_fightStages")
	self._goTitle = gohelper.findChild(self.viewGO, "#go_Title")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#go_Title/#simage_title")
	self._gotime = gohelper.findChild(self.viewGO, "#go_Title/#go_time")
	self._txtlimittime = gohelper.findChildText(self.viewGO, "#go_Title/#go_time/image_LimitTimeBG/#txt_limittime")
	self._btnPlayBtn = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Title/#btn_PlayBtn")
	self._btnTask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Task")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")

	local goPath = gohelper.findChild(self._gostoryScroll, "path/path_2")

	self._animPath = goPath:GetComponent(gohelper.Type_Animator)

	local goTaskAnim = gohelper.findChild(self.viewGO, "#btn_Task/ani")

	self._animTask = goTaskAnim:GetComponent(gohelper.Type_Animator)
	self._scrollStory = gohelper.findChildScrollRect(self._gostoryPath, "")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ZhiXinQuanErLevelView:addEvents()
	self._btnPlayBtn:AddClickListener(self._btnPlayBtnOnClick, self)
	self._btnTask:AddClickListener(self._btnTaskOnClick, self)
	self._btnTrial:AddClickListener(self._btnTrialOnClick, self)
end

function ZhiXinQuanErLevelView:removeEvents()
	self._btnPlayBtn:RemoveClickListener()
	self._btnTask:RemoveClickListener()
	self._btnTrial:RemoveClickListener()
end

function ZhiXinQuanErLevelView:_btnPlayBtnOnClick()
	if self.actConfig.storyId > 0 then
		StoryController.instance:playStory(self.actConfig.storyId)
	end
end

function ZhiXinQuanErLevelView:_btnTaskOnClick()
	ViewMgr.instance:openView(ViewName.ZhiXinQuanErTaskView)
end

function ZhiXinQuanErLevelView:_btnTrialOnClick()
	if ActivityHelper.getActivityStatus(self.actId) == ActivityEnum.ActivityStatus.Normal then
		local episodeId = self.actConfig.tryoutEpisode

		if episodeId <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		local config = DungeonConfig.instance:getEpisodeCO(episodeId)

		DungeonFightController.instance:enterFight(config.chapterId, episodeId)
	else
		self:_clickLock()
	end
end

function ZhiXinQuanErLevelView:_clickLock()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.actConfig.openId)

	if toastId and toastId ~= 0 then
		GameFacade.showToastWithTableParam(toastId, toastParamList)
	end
end

function ZhiXinQuanErLevelView:_editableInitView()
	self.actId = VersionActivity2_3Enum.ActivityId.ZhiXinQuanEr
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._gostoryPath)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self._scrollStory:AddOnValueChanged(self._onScrollValueChanged, self)

	self._touch = SLFramework.UGUI.UIClickListener.Get(self._gostoryPath)

	self._touch:AddClickDownListener(self._onClickDown, self)

	self._audioScroll = MonoHelper.addLuaComOnceToGo(self._gostoryPath, DungeonMapEpisodeAudio, self._scrollStory)
	self.actConfig = ActivityConfig.instance:getActivityCo(self.actId)

	local width = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local rightOffsetX = -300

	self._offsetX = (width - rightOffsetX) / 2
	self.minContentAnchorX = -4560 + width

	RoleActivityModel.instance:initData(self.actId)
	self:_initStageItems()
	gohelper.setActive(self._btnPlayBtn, self.actConfig.storyId > 0)

	self._bgWidth = recthelper.getWidth(self._simageFullBG.transform) + recthelper.getWidth(self._simageFullBG2.transform)
	self._minBgPositionX = BootNativeUtil.getDisplayResolution() - self._bgWidth
	self._maxBgPositionX = 0
	self._bgPositonMaxOffsetX = math.abs(self._maxBgPositionX - self._minBgPositionX)
	self._btnTrial = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Try/image_TryBtn")
end

function ZhiXinQuanErLevelView:onOpen()
	self.addEventCb(self, RoleActivityController.instance, RoleActivityEvent.StoryItemClick, self.OnStoryItemClick, self)
	self.addEventCb(self, RoleActivityController.instance, RoleActivityEvent.FightItemClick, self.OnFightItemClick, self)
	self.addEventCb(self, StoryController.instance, StoryEvent.Finish, self.OnStoryFinish, self)
	self.addEventCb(self, StoryController.instance, StoryEvent.Start, self.OnStoryStart, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnEndDungeonPush, self.OnEndDungeonPush, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, self.OnDotChange, self)

	local goreddot = gohelper.findChild(self._btnTask.gameObject, "#go_reddot")

	RedDotController.instance:addRedDot(goreddot, RedDotEnum.DotNode.PermanentRoleActivityTask, self.actId)
	self:OnDotChange()
	self:_showLeftTime()
	TaskDispatcher.runRepeat(self._showLeftTime, self, 1)

	if self.viewParam and self.viewParam.needShowFight then
		local fightIndex = RoleActivityModel.instance:getEnterFightIndex(self.actId)

		if fightIndex then
			self.latestfightItem = fightIndex

			for _, fightItem in ipairs(self.fightItemList) do
				fightItem:refreshSelect(fightIndex)
			end
		end

		self:_lockScreen(true)
		TaskDispatcher.runDelay(self._delayOpenFight, self, 0.3)
	elseif self:_checkFirstEnter() then
		self:_lockScreen(true)
		self.storyItemList[1]:lockStatus()
		TaskDispatcher.runDelay(self._playFirstUnlock, self, 0.8)
	end

	self:_initBgPosition()
	self:_initPathStatus()
end

function ZhiXinQuanErLevelView:_checkFirstEnter()
	if not self.storyItemList[2]:isUnlock() then
		local record = PlayerPrefsHelper.getNumber("ActZhiXinQuanErFirstEnter", 0)

		if record == 0 then
			PlayerPrefsHelper.setNumber("ActZhiXinQuanErFirstEnter", 1)

			return true
		end
	end

	return false
end

function ZhiXinQuanErLevelView:onClose()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	TaskDispatcher.cancelTask(self._delayOpenFight, self)
	TaskDispatcher.cancelTask(self._playFirstUnlock, self)
	TaskDispatcher.cancelTask(self._delayOpenStory, self)
	TaskDispatcher.cancelTask(self._unlockStoryEnd, self)
	TaskDispatcher.cancelTask(self._finishStoryEnd, self)
	TaskDispatcher.cancelTask(self._playPathAnim, self)
	TaskDispatcher.cancelTask(self._unlockFightEnd, self)
	TaskDispatcher.cancelTask(self._unlockStory, self)
	TaskDispatcher.cancelTask(self._starShowEnd, self)
	TaskDispatcher.cancelTask(self._playStoryFinishAnim, self)
	self:_lockScreen(false)
end

function ZhiXinQuanErLevelView:onDestroyView()
	self.storyItemList = nil
	self.fightItemList = nil

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragEndListener()

		self._drag = nil
	end

	if self._touch then
		self._touch:RemoveClickDownListener()

		self._touch = nil
	end

	if self._scrollStory then
		self._scrollStory:RemoveOnValueChanged()
	end
end

function ZhiXinQuanErLevelView:OnStoryItemClick(index)
	self:_focusStoryItem(index, true)
end

function ZhiXinQuanErLevelView:OnFightItemClick(_index)
	if self.latestfightItem == _index then
		return
	end

	self.latestfightItem = _index

	AudioMgr.instance:trigger(AudioEnum.RoleActivity.fight_switch)

	for _, fightItem in ipairs(self.fightItemList) do
		fightItem:refreshSelect(_index)
	end
end

function ZhiXinQuanErLevelView:OnStoryStart(storyId)
	local latestStoryCo = self:getLatestStoryCo()

	if not latestStoryCo or latestStoryCo.afterStory ~= storyId then
		return
	end

	local isPass = DungeonModel.instance:hasPassLevelAndStory(latestStoryCo.id)

	if isPass then
		return
	end

	self._newFinishStoryLvlId = latestStoryCo.id
end

function ZhiXinQuanErLevelView:OnStoryFinish()
	RoleActivityModel.instance:updateData(self.actId)
	TaskDispatcher.runDelay(self._playStoryFinishAnim, self, 0.73)
end

function ZhiXinQuanErLevelView:OnEndDungeonPush()
	RoleActivityModel.instance:updateData(self.actId)

	local latestStoryCo = self:getLatestStoryCo()
	local latestEpisodeId = latestStoryCo and latestStoryCo.id
	local hasElement = Activity176Config.instance:hasElementCo(self.actId, latestEpisodeId)

	if latestStoryCo and latestStoryCo.afterStory ~= 0 then
		return
	end

	local baseDelayTime = 0.73
	local addDelayTime = hasElement and 1.5 or 0
	local targetDelayTime = baseDelayTime + addDelayTime

	TaskDispatcher.runDelay(self._playStoryFinishAnim, self, targetDelayTime)
end

function ZhiXinQuanErLevelView:getLatestStoryCo()
	local storyConfigList = RoleActivityConfig.instance:getStoryLevelList(self.actId)

	return storyConfigList and storyConfigList[self.latestStoryItem]
end

function ZhiXinQuanErLevelView:OnDotChange()
	local isDotShow = RedDotModel.instance:isDotShow(RedDotEnum.DotNode.PermanentRoleActivityTask, self.actId)

	if isDotShow then
		self._animTask:Play("loop")
	else
		self._animTask:Play("idle")
	end
end

function ZhiXinQuanErLevelView:_onStoryOpenEnd()
	self:_initPathStatus()
end

function ZhiXinQuanErLevelView:_onFightOpenEnd()
	self:_playFightFinishAnim()
end

function ZhiXinQuanErLevelView:_onGoStoryEnd()
	self:_initPathStatus()
end

function ZhiXinQuanErLevelView:_onDragBegin()
	self._audioScroll:onDragBegin()
end

function ZhiXinQuanErLevelView:_onDragEnd()
	self._audioScroll:onDragEnd()
end

function ZhiXinQuanErLevelView:_onScrollValueChanged()
	self:_initBgPosition()
end

function ZhiXinQuanErLevelView:_initBgPosition()
	local bgPositionX = -self._scrollStory.horizontalNormalizedPosition * self._bgPositonMaxOffsetX

	bgPositionX = Mathf.Clamp(bgPositionX, self._minBgPositionX, self._maxBgPositionX)

	recthelper.setAnchorX(self._simageFullBG.transform, bgPositionX)
end

function ZhiXinQuanErLevelView:_onClickDown()
	self._audioScroll:onClickDown()
end

function ZhiXinQuanErLevelView:_initStageItems()
	local levelCount, path

	path = self.viewContainer:getSetting().otherRes[1]
	self.storyItemList = {}

	local storyConfigList = RoleActivityConfig.instance:getStoryLevelList(self.actId)

	levelCount = #storyConfigList

	for i = 1, #storyConfigList do
		local stageGo = gohelper.findChild(self._gostoryStages, "stage" .. i)
		local cloneGo = self:getResInst(path, stageGo)

		self.storyItemList[i] = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, ZhiXinQuanErStoryItem, self)

		self.storyItemList[i]:setParam(storyConfigList[i], i, self.actId)

		if self.storyItemList[i]:isUnlock() then
			self.latestStoryItem = i
		end
	end

	self:_focusStoryItem(self.latestStoryItem)

	path = self.viewContainer:getSetting().otherRes[2]
	self.fightItemList = {}

	local fightConfigList = RoleActivityConfig.instance:getBattleLevelList(self.actId)

	for i = 1, #fightConfigList / 2 do
		local stageGo = gohelper.findChild(self._gofightStages, "stage" .. i)
		local cloneGo = self:getResInst(path, stageGo)

		self.fightItemList[i] = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, RoleActFightItem, self)

		self.fightItemList[i]:setParam(fightConfigList[2 * i - 1], i, self.actId)

		if self.fightItemList[i]:isUnlock() then
			self.latestfightItem = i
		end
	end

	local lastFightItem = self.fightItemList[self.latestfightItem]

	if lastFightItem then
		lastFightItem:refreshSelect()
	end
end

function ZhiXinQuanErLevelView:_updateStoryFocusFlag(index, needPlay)
	local preFocusStoryItem = self.storyItemList[self._focusStoryIndex]
	local curFocusStoryItem = self.storyItemList[index]
	local allHasStoryItem = preFocusStoryItem ~= nil and curFocusStoryItem ~= nil

	if needPlay and allHasStoryItem then
		self:_lockScreen(true)

		local preFocusFlgTran = preFocusStoryItem:getFocusFlagTran()
		local curFocusFlgTran = curFocusStoryItem:getFocusFlagTran()
		local focusFlagPosX, focusFlagPosY = recthelper.rectToRelativeAnchorPos2(curFocusFlgTran.position, preFocusStoryItem.viewGO.transform)
		local isMoveLeftDir = index < self._focusStoryIndex

		preFocusStoryItem:setFocusFlagDir(isMoveLeftDir)
		ZProj.TweenHelper.DOAnchorPos(preFocusFlgTran, focusFlagPosX, focusFlagPosY, FocusDuration, self._onMoveFocusFlagDone, self, index)
	else
		self:_onMoveFocusFlagDone(index)
	end
end

function ZhiXinQuanErLevelView:_onMoveFocusFlagDone(index)
	local preFocusStoryItem = self.storyItemList[self._focusStoryIndex]
	local curFocusStoryItem = self.storyItemList[index]

	if preFocusStoryItem then
		preFocusStoryItem:setFocusFlag(false)
		preFocusStoryItem:setFocusFlagDir(false)
	end

	if curFocusStoryItem then
		if self._focusStoryIndex then
			local isMoveLeftDir = index < self._focusStoryIndex

			curFocusStoryItem:setFocusFlag(true)
			curFocusStoryItem:setFocusFlagDir(isMoveLeftDir)
		end
	end

	self._focusStoryIndex = index

	self:_lockScreen(false)
end

function ZhiXinQuanErLevelView:_playFirstUnlock()
	self.finishStoryIndex = 0

	self.storyItemList[1]:playUnlock()
	TaskDispatcher.runDelay(self._unlockStoryEnd, self, 1.33)
end

function ZhiXinQuanErLevelView:_playStoryFinishAnim()
	local newFinishStoryLvlId = RoleActivityModel.instance:getNewFinishStoryLvl()
	local targetNewFinishStoryLvlId = newFinishStoryLvlId or self._newFinishStoryLvlId

	if targetNewFinishStoryLvlId then
		for k, storyItem in ipairs(self.storyItemList) do
			if storyItem.id == targetNewFinishStoryLvlId then
				self:_lockScreen(true)

				self.finishStoryIndex = k

				storyItem:playFinish()
				storyItem:playStarAnim()
				TaskDispatcher.runDelay(self._finishStoryEnd, self, 1)

				break
			end
		end

		self._newFinishStoryLvlId = nil

		RoleActivityModel.instance:clearNewFinishStoryLvl()
	end
end

function ZhiXinQuanErLevelView:_finishStoryEnd()
	if self.finishStoryIndex == #self.storyItemList then
		self.latestStoryItem = self.finishStoryIndex
		self.finishStoryIndex = nil

		self:_lockScreen(false)
	else
		self.latestStoryItem = self.finishStoryIndex + 1

		self:_playPathAnim()
	end
end

function ZhiXinQuanErLevelView:_playPathAnim()
	local animName = "go" .. self.finishStoryIndex

	self._animPath.speed = 1

	self._animPath:Play(animName)
	TaskDispatcher.runDelay(self._unlockStory, self, 0.33)
end

function ZhiXinQuanErLevelView:_unlockStory()
	self.storyItemList[self.finishStoryIndex + 1]:playUnlock()
	TaskDispatcher.runDelay(self._unlockStoryEnd, self, 1)
end

function ZhiXinQuanErLevelView:_unlockStoryEnd()
	self.storyItemList[self.finishStoryIndex + 1]:refreshStatus()

	self.finishStoryIndex = nil

	self:_lockScreen(false)
end

function ZhiXinQuanErLevelView:_playFightFinishAnim()
	local newFinishFightLvlId = RoleActivityModel.instance:getNewFinishFightLvl()

	if newFinishFightLvlId then
		RoleActivityModel.instance:updateData(self.actId)

		for k, fightItem in ipairs(self.fightItemList) do
			if fightItem.id == newFinishFightLvlId then
				self.finishFightIndex = k

				fightItem:refreshStar()
				fightItem:playStarAnim(true)
				TaskDispatcher.runDelay(self._starShowEnd, self, 0.67)

				break
			elseif fightItem.hardConfig.id == newFinishFightLvlId then
				fightItem:refreshStar()
				fightItem:playStarAnim()
				self:_lockScreen(false)

				break
			end
		end

		RoleActivityModel.instance:clearNewFinishFightLvl()

		return
	end

	self:_lockScreen(false)
end

function ZhiXinQuanErLevelView:_starShowEnd()
	self.fightItemList[self.finishFightIndex]:playHardUnlock()
	TaskDispatcher.runDelay(self._unlockFightEnd, self, 1.7)

	if self.fightItemList[self.finishFightIndex + 1] then
		self.fightItemList[self.finishFightIndex + 1]:playUnlock()
	end
end

function ZhiXinQuanErLevelView:_unlockFightEnd()
	self.fightItemList[self.finishFightIndex]:refreshStatus()

	if self.fightItemList[self.finishFightIndex + 1] then
		self.fightItemList[self.finishFightIndex + 1]:refreshStatus()
	end

	self.finishFightIndex = nil

	self:_lockScreen(false)
end

function ZhiXinQuanErLevelView:_delayOpenStory()
	self._anim:Play("openstory", 0, 0)
end

function ZhiXinQuanErLevelView:_delayOpenFight()
	self._anim:Play("openfight", 0, 0)
end

function ZhiXinQuanErLevelView:_showLeftTime()
	self._txtlimittime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function ZhiXinQuanErLevelView:_initPathStatus()
	if self.latestStoryItem > 1 then
		self._animPath:Play("go" .. self.latestStoryItem - 1, 0, 1)
	else
		self._animPath.speed = 0

		self._animPath:Play("go1", 0, 0)
	end
end

function ZhiXinQuanErLevelView:_focusStoryItem(index, needPlay)
	local contentAnchorX = recthelper.getAnchorX(self.storyItemList[index].transform.parent)
	local offsetX = self._offsetX - contentAnchorX

	if offsetX > 0 then
		offsetX = 0
	elseif offsetX < self.minContentAnchorX then
		offsetX = self.minContentAnchorX
	end

	if needPlay then
		ZProj.TweenHelper.DOAnchorPosX(self._gostoryScroll.transform, offsetX, FocusDuration, self._onFocusEnd, self, index)
	else
		recthelper.setAnchorX(self._gostoryScroll.transform, offsetX)
	end

	self:_updateStoryFocusFlag(index, needPlay)
end

function ZhiXinQuanErLevelView:_onFocusEnd(index)
	self.storyItemList[index]:playStory()
end

function ZhiXinQuanErLevelView:_lockScreen(lock)
	if lock then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("ZhiXinQuanErLock")
	else
		UIBlockMgr.instance:endBlock("ZhiXinQuanErLock")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

return ZhiXinQuanErLevelView
