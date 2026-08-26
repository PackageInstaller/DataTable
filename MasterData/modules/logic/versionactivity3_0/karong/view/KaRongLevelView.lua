-- chunkname: @modules/logic/versionactivity3_0/karong/view/KaRongLevelView.lua

module("modules.logic.versionactivity3_0.karong.view.KaRongLevelView", package.seeall)

local KaRongLevelView = class("KaRongLevelView", BaseView)
local FocusDuration = 0.5

function KaRongLevelView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
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
	self._btnTask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Task")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._btnTrial = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Try/#btn_Trial")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function KaRongLevelView:addEvents()
	self._btnTask:AddClickListener(self._btnTaskOnClick, self)
	self._btnTrial:AddClickListener(self._btnTrialOnClick, self)
end

function KaRongLevelView:removeEvents()
	self._btnTask:RemoveClickListener()
	self._btnTrial:RemoveClickListener()
end

function KaRongLevelView:_btnTrialOnClick()
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

function KaRongLevelView:_clickLock()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.actConfig.openId)

	if toastId and toastId ~= 0 then
		GameFacade.showToastWithTableParam(toastId, toastParamList)
	end
end

function KaRongLevelView:_btnTaskOnClick()
	ViewMgr.instance:openView(ViewName.KaRongTaskView)
end

function KaRongLevelView:_editableInitView()
	self._anim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.lineAnimList = {}

	for i = 1, 7 do
		local go = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll/path/path2/Line" .. i)

		self.lineAnimList[i] = go:GetComponent(gohelper.Type_Animator)
	end

	local goTaskAnim = gohelper.findChild(self.viewGO, "#btn_Task/ani")

	self._animTask = goTaskAnim:GetComponent(gohelper.Type_Animator)
	self._scrollStory = gohelper.findChildScrollRect(self._gostoryPath, "")
	self.actId = VersionActivity3_0Enum.ActivityId.KaRong
	self.actConfig = ActivityConfig.instance:getActivityCo(self.actId)

	RoleActivityModel.instance:initData(self.actId)

	self._audioScroll = MonoHelper.addLuaComOnceToGo(self._gostoryPath, DungeonMapEpisodeAudio, self._scrollStory)
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._gostoryPath)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)

	self._touch = SLFramework.UGUI.UIClickListener.Get(self._gostoryPath)

	self._touch:AddClickDownListener(self._onClickDown, self)

	local width = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local rightOffsetX = -300

	self._offsetX = (width - rightOffsetX) / 2
	self.minContentAnchorX = -4560 + width

	self:_initStageItems()
	gohelper.setActive(self._btnPlayBtn, self.actConfig.storyId > 0)
	gohelper.setActive(self._gotime, false)
end

function KaRongLevelView:onOpen()
	self.addEventCb(self, RoleActivityController.instance, RoleActivityEvent.StoryItemClick, self.OnStoryItemClick, self)
	self.addEventCb(self, StoryController.instance, StoryEvent.Finish, self.OnStoryFinish, self)
	self.addEventCb(self, StoryController.instance, StoryEvent.Start, self.OnStoryStart, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnEndDungeonPush, self.OnEndDungeonPush, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, self.OnDotChange, self)

	local goreddot = gohelper.findChild(self._btnTask.gameObject, "#go_reddot")

	RedDotController.instance:addRedDot(goreddot, RedDotEnum.DotNode.PermanentRoleActivityTask, self.actId)
	self:OnDotChange()
	self:_showLeftTime()
	TaskDispatcher.runRepeat(self._showLeftTime, self, 1)

	if self:_checkFirstEnter() then
		self:_lockScreen(true)
		self.storyItemList[1]:lockStatus()
		TaskDispatcher.runDelay(self._playFirstUnlock, self, 0.8)
	end

	self:_initPathStatus()
end

function KaRongLevelView:_checkFirstEnter()
	if not self.storyItemList[2]:isUnlock() then
		local record = PlayerPrefsHelper.getNumber("ActKaRongFirstEnter", 0)

		if record == 0 then
			PlayerPrefsHelper.setNumber("ActKaRongFirstEnter", 1)

			return true
		end
	end

	return false
end

function KaRongLevelView:onClose()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	TaskDispatcher.cancelTask(self._playFirstUnlock, self)
	TaskDispatcher.cancelTask(self._delayOpenStory, self)
	TaskDispatcher.cancelTask(self._unlockStoryEnd, self)
	TaskDispatcher.cancelTask(self._finishStoryEnd, self)
	TaskDispatcher.cancelTask(self._playPathAnim, self)
	TaskDispatcher.cancelTask(self._unlockStory, self)
	TaskDispatcher.cancelTask(self._playStoryFinishAnim, self)
	self:_lockScreen(false)
end

function KaRongLevelView:onDestroyView()
	self.storyItemList = nil

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

function KaRongLevelView:OnStoryItemClick(index)
	self:_focusStoryItem(index, true)
end

function KaRongLevelView:OnStoryStart(storyId)
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

function KaRongLevelView:OnStoryFinish()
	RoleActivityModel.instance:updateData(self.actId)
	TaskDispatcher.runDelay(self._playStoryFinishAnim, self, 0.73)
	TaskDispatcher.runDelay(self._delayOpenStory, self, 0.4)
end

function KaRongLevelView:OnEndDungeonPush()
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

function KaRongLevelView:getLatestStoryCo()
	local storyConfigList = RoleActivityConfig.instance:getStoryLevelList(self.actId)

	return storyConfigList and storyConfigList[self.latestStoryItem]
end

function KaRongLevelView:OnDotChange()
	local isDotShow = RedDotModel.instance:isDotShow(RedDotEnum.DotNode.PermanentRoleActivityTask, self.actId)

	if isDotShow then
		self._animTask:Play("loop")
	else
		self._animTask:Play("idle")
	end
end

function KaRongLevelView:_onStoryOpenEnd()
	self:_initPathStatus()
end

function KaRongLevelView:_onGoStoryEnd()
	self:_initPathStatus()
end

function KaRongLevelView:_onDragBegin()
	self._audioScroll:onDragBegin()
end

function KaRongLevelView:_onDragEnd()
	self._audioScroll:onDragEnd()
end

function KaRongLevelView:_onClickDown()
	self._audioScroll:onClickDown()
end

function KaRongLevelView:_initStageItems()
	local levelCount, path

	path = self.viewContainer:getSetting().otherRes[1]
	self.storyItemList = {}

	local storyConfigList = RoleActivityConfig.instance:getStoryLevelList(self.actId)

	for i = 1, #storyConfigList do
		local stageGo = gohelper.findChild(self._gostoryStages, "stage" .. i)
		local cloneGo = self:getResInst(path, stageGo)

		self.storyItemList[i] = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, KaRongStoryItem, self)

		self.storyItemList[i]:setParam(storyConfigList[i], i, self.actId)

		if self.storyItemList[i]:isUnlock() then
			self.latestStoryItem = i
		end
	end

	self:_focusStoryItem(self.latestStoryItem)
end

function KaRongLevelView:_playFirstUnlock()
	self.finishStoryIndex = 0

	self.storyItemList[1]:playUnlock()
	TaskDispatcher.runDelay(self._unlockStoryEnd, self, 1.33)
end

function KaRongLevelView:_playStoryFinishAnim()
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

function KaRongLevelView:_finishStoryEnd()
	if self.finishStoryIndex == #self.storyItemList then
		self.latestStoryItem = self.finishStoryIndex
		self.finishStoryIndex = nil

		self:_lockScreen(false)
	else
		self.latestStoryItem = self.finishStoryIndex + 1

		self:_playPathAnim()
	end
end

function KaRongLevelView:_playPathAnim()
	self.lineAnimList[self.finishStoryIndex]:Play("open", 0, 0)
	TaskDispatcher.runDelay(self._unlockStory, self, 0.33)
end

function KaRongLevelView:_unlockStory()
	self.storyItemList[self.finishStoryIndex + 1]:playUnlock()
	TaskDispatcher.runDelay(self._unlockStoryEnd, self, 1)
end

function KaRongLevelView:_unlockStoryEnd()
	self.storyItemList[self.finishStoryIndex + 1]:refreshStatus()

	self.finishStoryIndex = nil

	self:_lockScreen(false)
end

function KaRongLevelView:_delayOpenStory()
	self._anim:Play("openstory", 0, 0)
end

function KaRongLevelView:_showLeftTime()
	self._txtlimittime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function KaRongLevelView:_initPathStatus()
	for i = 1, 7 do
		if i <= self.latestStoryItem - 1 then
			self.lineAnimList[i]:Play("open", 0, 1)
		end
	end
end

function KaRongLevelView:_focusStoryItem(index, needPlay)
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

	self:_setFocusFlag(index)
end

function KaRongLevelView:_onFocusEnd(index)
	self.storyItemList[index]:playStory()
end

function KaRongLevelView:_setFocusFlag(index)
	local preFocusStoryItem = self.storyItemList[self._focusStoryIndex]
	local curFocusStoryItem = self.storyItemList[index]

	if preFocusStoryItem then
		preFocusStoryItem:setFocusFlag(false)
	end

	if curFocusStoryItem then
		curFocusStoryItem:setFocusFlag(true)
	end

	self._focusStoryIndex = index

	self:_lockScreen(false)
end

function KaRongLevelView:_lockScreen(lock)
	if lock then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("KaRongLock")
	else
		UIBlockMgr.instance:endBlock("KaRongLock")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

return KaRongLevelView
