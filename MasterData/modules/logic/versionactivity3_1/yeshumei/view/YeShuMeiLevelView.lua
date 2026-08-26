-- chunkname: @modules/logic/versionactivity3_1/yeshumei/view/YeShuMeiLevelView.lua

module("modules.logic.versionactivity3_1.yeshumei.view.YeShuMeiLevelView", package.seeall)

local YeShuMeiLevelView = class("YeShuMeiLevelView", BaseView)
local FocusDuration = 0.5

function YeShuMeiLevelView:onInitView()
	self._trsBg = gohelper.findChild(self.viewGO, "#simage_FullBG").transform
	self._gostoryScroll = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll")
	self._scrollstory = gohelper.findChildScrollRect(self.viewGO, "#go_storyPath")
	self._gostages = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "#go_Title/#go_time/image_LimitTimeBG/#txt_limittime")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Task")
	self._goreddotreward = gohelper.findChild(self.viewGO, "#btn_Task/#go_reddot")
	self._gotaskani = gohelper.findChild(self.viewGO, "#btn_Task/ani")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._animTask = self._gotaskani:GetComponent(typeof(UnityEngine.Animator))
	self._btnTrial = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Try/image_TryBtn")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function YeShuMeiLevelView:addEvents()
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self.addEventCb(self, YeShuMeiController.instance, YeShuMeiEvent.EpisodeFinished, self._onEpisodeFinished, self)
	self.addEventCb(self, YeShuMeiController.instance, YeShuMeiEvent.OnBackToLevel, self._onBackToLevel, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.ReOpenWhileOpen, self._onOpenView, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
	self._btnTrial:AddClickListener(self._btnTrialOnClick, self)
	self._scrollstory:AddOnValueChanged(self.onValueChanged, self)
end

function YeShuMeiLevelView:removeEvents()
	self._btntask:RemoveClickListener()
	self.removeEventCb(self, YeShuMeiController.instance, YeShuMeiEvent.EpisodeFinished, self._onEpisodeFinished, self)
	self.removeEventCb(self, YeShuMeiController.instance, YeShuMeiEvent.OnBackToLevel, self._onBackToLevel, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.ReOpenWhileOpen, self._onOpenView, self)
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
	self._btnTrial:RemoveClickListener()
	self._scrollstory:RemoveOnValueChanged()
end

function YeShuMeiLevelView:_btnTrialOnClick()
	if ActivityHelper.isOpen(self.actId) then
		local episodeId = self.config.tryoutEpisode

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

function YeShuMeiLevelView:_clickLock()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.config.openId)

	if toastId and toastId ~= 0 then
		GameFacade.showToastWithTableParam(toastId, toastParamList)
	end
end

function YeShuMeiLevelView:onValueChanged()
	local per = self._scrollstory.horizontalNormalizedPosition

	if per > 1 then
		per = 1
	end

	local moveX = self._canMoveBgWidth * per

	recthelper.setAnchorX(self._trsBg, -moveX)
end

function YeShuMeiLevelView:_btntaskOnClick()
	ViewMgr.instance:openView(ViewName.YeShuMeiTaskView)
end

function YeShuMeiLevelView:_refreshTask()
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V3a1YeShuMeiTask, 0) then
		self._animTask:Play("loop")
	else
		self._animTask:Play("idle")
	end
end

function YeShuMeiLevelView:_onCloseTask()
	self:_refreshTask()
end

function YeShuMeiLevelView:_removeEvents()
	return
end

function YeShuMeiLevelView:_editableInitView()
	self.actId = VersionActivity3_1Enum.ActivityId.YeShuMei
	self.config = ActivityConfig.instance:getActivityCo(self.actId)
	self._viewAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	local width = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local bgwidth = recthelper.getWidth(self._trsBg)

	self._halfbg = bgwidth / 2
	self._offsetX = width / 2
	self._canMoveBgWidth = self._halfbg - self._offsetX
	self.minContentAnchorX = -4000 + width

	RedDotController.instance:addRedDot(self._goreddotreward, RedDotEnum.DotNode.V3a1YeShuMeiTask)
end

function YeShuMeiLevelView:_onOpenView()
	self._focusId = self.viewParam and self.viewParam.episodeId

	local index = YeShuMeiModel.instance:getEpisodeIndex(self._focusId)

	self:_focusStoryItem(index, true)

	self._focusId = nil
end

function YeShuMeiLevelView:onOpen()
	self._focusId = self.viewParam and self.viewParam.episodeId

	self:_initLines()
	self:_initLevelItems()
	self:_refreshLines()
	self:_refreshLeftTime()
	TaskDispatcher.runRepeat(self._refreshLeftTime, self, 1)
	self:_refreshTask()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
end

function YeShuMeiLevelView:_initLines()
	self._linesList = {}

	for i = 1, 7 do
		local line = self:getUserDataTb_()

		line.go = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll/path/path2/Line" .. i)
		line.animator = line.go:GetComponent(typeof(UnityEngine.Animator))

		gohelper.setActive(line.go, false)
		table.insert(self._linesList, line)
	end
end

function YeShuMeiLevelView:_refreshLines()
	for i = 1, self._curEpisodeIndex - 1 do
		local line = self._linesList[i]

		if line then
			gohelper.setActive(line.go, true)
		end
	end
end

function YeShuMeiLevelView:_refreshLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function YeShuMeiLevelView:_initLevelItems()
	local path = self.viewContainer:getSetting().otherRes[1]

	self._episodeItems = {}

	local episodeCos = YeShuMeiConfig.instance:getEpisodeCoList(self.actId)
	local maxUnlockEpisode = YeShuMeiModel.instance:getMaxUnlockEpisodeId()

	self._curEpisodeIndex = YeShuMeiModel.instance:getEpisodeIndex(maxUnlockEpisode)

	YeShuMeiModel.instance:setCurEpisode(self._curEpisodeIndex, maxUnlockEpisode)

	for i = 1, #episodeCos do
		local nodeRoot = gohelper.findChild(self._gostages, "stage" .. i)
		local cloneGo = self:getResInst(path, nodeRoot)

		self._episodeItems[i] = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, YeShuMeiStoryItem, self)

		self._episodeItems[i]:setParam(episodeCos[i], i, self.actId)
	end

	if not self._focusId then
		self:_focusStoryItem(self._curEpisodeIndex)
	else
		local index = YeShuMeiModel.instance:getEpisodeIndex(self._focusId)

		self:_focusStoryItem(index)

		self._focusId = nil
	end
end

function YeShuMeiLevelView:_focusStoryItem(index, needPlay)
	local contentAnchorX = recthelper.getAnchorX(self._episodeItems[index].transform.parent)
	local offsetX = self._offsetX - contentAnchorX

	if offsetX > 0 then
		offsetX = 0
	elseif offsetX < self.minContentAnchorX then
		offsetX = self.minContentAnchorX
	end

	if needPlay then
		ZProj.TweenHelper.DOAnchorPosX(self._gostoryScroll.transform, offsetX, FocusDuration)
	else
		recthelper.setAnchorX(self._gostoryScroll.transform, offsetX)
	end
end

function YeShuMeiLevelView:onStoryItemClick(index)
	self:_focusStoryItem(index, true)
end

function YeShuMeiLevelView:_onBackToLevel()
	local newEpisode = YeShuMeiModel.instance:getNewFinishEpisode()

	if newEpisode and newEpisode ~= 0 then
		local maxUnlockEpisode = YeShuMeiModel.instance:getMaxUnlockEpisodeId()

		self._curEpisodeIndex = YeShuMeiModel.instance:getEpisodeIndex(maxUnlockEpisode)

		YeShuMeiModel.instance:setCurEpisode(self._curEpisodeIndex, maxUnlockEpisode)
	end

	self:_refreshTask()
end

function YeShuMeiLevelView:_onEpisodeFinished()
	local newEpisode = YeShuMeiModel.instance:getNewFinishEpisode()

	if newEpisode then
		TaskDispatcher.runDelay(self._playStoryFinishAnim, self, 1)
	end
end

function YeShuMeiLevelView:_playStoryFinishAnim()
	TaskDispatcher.cancelTask(self._playStoryFinishAnim, self)

	local newEpisode = YeShuMeiModel.instance:getNewFinishEpisode()

	if newEpisode then
		for k, episodeItem in ipairs(self._episodeItems) do
			if episodeItem.id == newEpisode then
				self._finishEpisodeIndex = k

				episodeItem:playFinish()
				episodeItem:playStarAnim()
				TaskDispatcher.runDelay(self._finishStoryEnd, self, 1.5)

				break
			end
		end

		YeShuMeiModel.instance:clearFinishEpisode()
	end
end

function YeShuMeiLevelView:_finishStoryEnd()
	if self._finishEpisodeIndex == #self._episodeItems then
		self._curEpisodeIndex = self._finishEpisodeIndex
		self._finishEpisodeIndex = nil
	else
		self._curEpisodeIndex = self._finishEpisodeIndex + 1

		self:_unlockStory()
	end
end

function YeShuMeiLevelView:_unlockStory()
	self._episodeItems[self._finishEpisodeIndex + 1]:refreshUI()
	self._episodeItems[self._finishEpisodeIndex + 1]:playUnlock()

	local line = self._linesList[self._finishEpisodeIndex]

	if line then
		gohelper.setActive(line.go, true)
		line.animator:Play("open", 0, 0)
	end

	self:_focusStoryItem(self._finishEpisodeIndex + 1, true)
	TaskDispatcher.runDelay(self._unlockLvEnd, self, 1.5)
end

function YeShuMeiLevelView:_unlockLvEnd()
	self._finishEpisodeIndex = nil
end

function YeShuMeiLevelView:_onScreenSizeChange()
	local width = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local bgwidth = recthelper.getWidth(self._trsBg)

	self._halfbg = bgwidth / 2
	self._offsetX = width / 2
	self._canMoveBgWidth = self._halfbg - self._offsetX
	self.minContentAnchorX = -4000 + width

	local per = self._scrollstory.horizontalNormalizedPosition

	if per > 1 then
		per = 1
	end

	local moveX = self._canMoveBgWidth * per

	recthelper.setAnchorX(self._trsBg, -moveX)
end

function YeShuMeiLevelView:onClose()
	TaskDispatcher.cancelTask(self._refreshLeftTime, self)
	TaskDispatcher.cancelTask(self._playStoryFinishAnim, self)
	TaskDispatcher.cancelTask(self._finishStoryEnd, self)
	TaskDispatcher.cancelTask(self._unlockLvEnd, self)
end

function YeShuMeiLevelView:onDestroyView()
	self:_removeEvents()

	self._episodeItems = nil

	TaskDispatcher.cancelTask(self._refreshLeftTime, self)
end

function YeShuMeiLevelView:_onCloseView(viewName)
	if viewName == ViewName.YeShuMeiGameView then
		gohelper.setActive(self.viewGO, true)
	elseif viewName == ViewName.YeShuMeiTaskView then
		self:_onCloseTask()
	end
end

return YeShuMeiLevelView
