-- chunkname: @modules/logic/versionactivity3_3/igor/view/IgorEpisodeLevelView.lua

module("modules.logic.versionactivity3_3.igor.view.IgorEpisodeLevelView", package.seeall)

local IgorEpisodeLevelView = class("IgorEpisodeLevelView", BaseView)
local FocusDuration = 0.5

function IgorEpisodeLevelView:onInitView()
	self._trsBg = gohelper.findChild(self.viewGO, "#simage_FullBG").transform
	self._scrollstory = gohelper.findChildScrollRect(self.viewGO, "#go_storyPath")
	self._scrollstoryRect = self._scrollstory.gameObject:GetComponent(gohelper.Type_ScrollRect)
	self._gostoryScroll = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll")
	self._gostages = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "#go_Title/#go_time/image_LimitTimeBG/#txt_LimitTime")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Task")
	self._goreddotreward = gohelper.findChild(self.viewGO, "#btn_Task/#go_reddot")
	self._gotaskani = gohelper.findChild(self.viewGO, "#btn_Task/ani")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._gopath = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll/path")
	self._animPath = self._gopath:GetComponent(typeof(UnityEngine.Animator))
	self._animTask = self._gotaskani:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function IgorEpisodeLevelView:addEvents()
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self.addEventCb(self, Activity220Controller.instance, Activity220Event.EpisodeFinished, self._onEpisodeFinished, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
	self._scrollstory:AddOnValueChanged(self.onValueChanged, self)
end

function IgorEpisodeLevelView:removeEvents()
	self._btntask:RemoveClickListener()
	self.removeEventCb(self, Activity220Controller.instance, Activity220Event.EpisodeFinished, self._onEpisodeFinished, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
	self._scrollstory:RemoveOnValueChanged()
end

function IgorEpisodeLevelView:_btntaskOnClick()
	IgorController.instance:openTaskView(self.actId)
end

function IgorEpisodeLevelView:_enterGame()
	IgorController.instance:enterGame(self.lastCo)
end

function IgorEpisodeLevelView:_onGameFinished()
	Activity220Controller.instance:onGameFinished(self.lastCo.activityId, self.lastCo.episodeId)
end

function IgorEpisodeLevelView:_refreshTask()
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.Activity220Task, self.actId) then
		self._animTask:Play("loop")
	else
		self._animTask:Play("idle")
	end
end

function IgorEpisodeLevelView:_onCloseTask()
	self:_refreshTask()
end

function IgorEpisodeLevelView:_removeEvents()
	return
end

function IgorEpisodeLevelView:_editableInitView()
	self._scrollWidth = recthelper.getWidth(self._gostoryScroll.transform)
	self._viewAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	local width = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local bgwidth = recthelper.getWidth(self._trsBg)

	self._halfbg = bgwidth / 2
	self._offsetX = width / 2
	self._canMoveBgWidth = self._halfbg - self._offsetX
	self.minContentAnchorX = -self._scrollWidth + width
end

function IgorEpisodeLevelView:onValueChanged()
	local per = self._scrollstory.horizontalNormalizedPosition

	if per > 1 then
		per = 1
	end

	if per < 0 then
		per = 0
	end

	local moveX = self._canMoveBgWidth * per

	recthelper.setAnchorX(self._trsBg, -moveX)
end

function IgorEpisodeLevelView:_onScreenSizeChange()
	self:_checkLockHorizontal()

	local width = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local bgwidth = recthelper.getWidth(self._trsBg)

	self._halfbg = bgwidth / 2
	self._offsetX = width / 2
	self._canMoveBgWidth = self._halfbg - self._offsetX
	self.minContentAnchorX = -self._scrollWidth + width

	local per = self._scrollstory.horizontalNormalizedPosition

	if per > 1 then
		per = 1
	end

	local moveX = self._canMoveBgWidth * per

	recthelper.setAnchorX(self._trsBg, -moveX)
end

function IgorEpisodeLevelView:onOpen()
	self.actId = self.viewParam.activityId

	RedDotController.instance:addRedDot(self._goreddotreward, RedDotEnum.DotNode.Activity220Task, self.actId)
	self:_initLevelItems()
	self:_refreshLeftTime()
	self:_refreshTask()
	self:_checkLockHorizontal()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
end

function IgorEpisodeLevelView:_checkLockHorizontal()
	return
end

function IgorEpisodeLevelView:_refreshLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function IgorEpisodeLevelView:_initLevelItems()
	local path = self.viewContainer:getSetting().otherRes[1]

	self._episodeItems = {}

	local episodeCos = Activity220Config.instance:getEpisodeConfigList(self.actId)
	local maxUnlockEpisode = Activity220Model.instance:getMaxUnlockEpisodeId(self.actId)

	self._curEpisodeIndex = Activity220Config.instance:getEpisodeIndex(self.actId, maxUnlockEpisode)

	local animname = "idle" .. self._curEpisodeIndex

	self._animPath:Play(animname, 0, 0)
	Activity220Model.instance:setCurEpisode(self.actId, self._curEpisodeIndex, maxUnlockEpisode)

	for i = 1, #episodeCos do
		local nodeRoot = gohelper.findChild(self._gostages, "stage" .. i)
		local cloneGo = self:getResInst(path, nodeRoot)

		self._episodeItems[i] = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, IgorStoryItem, self)

		self._episodeItems[i]:setParam(episodeCos[i], i, self.actId)
	end

	self:_focusStoryItem(self._curEpisodeIndex)
end

function IgorEpisodeLevelView:_focusStoryItem(index, needPlay)
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

function IgorEpisodeLevelView:_onEpisodeFinished()
	local mo = Activity220Model.instance:getById(self.actId)

	if not mo then
		return
	end

	local newEpisode = mo:getNewFinishEpisode()

	if newEpisode then
		TaskDispatcher.runDelay(self._playStoryFinishAnim, self, 1)

		local maxUnlockEpisode = Activity220Model.instance:getMaxUnlockEpisodeId(self.actId)

		self._curEpisodeIndex = Activity220Config.instance:getEpisodeIndex(self.actId, maxUnlockEpisode)

		mo:setCurEpisode(self._curEpisodeIndex, maxUnlockEpisode)
	end

	self:_refreshTask()
end

function IgorEpisodeLevelView:_playStoryFinishAnim()
	TaskDispatcher.cancelTask(self._playStoryFinishAnim, self)

	local mo = Activity220Model.instance:getById(self.actId)

	if not mo then
		return
	end

	local newEpisode = mo:getNewFinishEpisode()

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

		mo:clearFinishEpisode()
	end
end

function IgorEpisodeLevelView:_finishStoryEnd()
	if not self._finishEpisodeIndex then
		return
	end

	self._curEpisodeIndex = self._finishEpisodeIndex + 1

	local item = self._episodeItems[self._curEpisodeIndex]

	if not item then
		return
	end

	local animname = "move" .. self._finishEpisodeIndex + 1

	self._animPath:Play(animname, 0, 0)
	self:_onScreenSizeChange()
	TaskDispatcher.runDelay(self._unlockStory, self, 0.5)
end

function IgorEpisodeLevelView:_unlockStory()
	TaskDispatcher.cancelTask(self._unlockStory, self)

	if not self._finishEpisodeIndex then
		return
	end

	local item = self._episodeItems[self._finishEpisodeIndex + 1]

	if not item then
		return
	end

	item:refreshUI()
	item:playUnlock()
	self:_focusStoryItem(self._finishEpisodeIndex + 1, true)
	TaskDispatcher.runDelay(self._unlockLvEnd, self, 1.5)
end

function IgorEpisodeLevelView:_unlockLvEnd()
	self._finishEpisodeIndex = nil
end

function IgorEpisodeLevelView:onClose()
	TaskDispatcher.cancelTask(self._refreshLeftTime, self)
	TaskDispatcher.cancelTask(self._playStoryFinishAnim, self)
	TaskDispatcher.cancelTask(self._finishStoryEnd, self)
	TaskDispatcher.cancelTask(self._unlockLvEnd, self)
	TaskDispatcher.cancelTask(self._unlockStory, self)
end

function IgorEpisodeLevelView:onDestroyView()
	self:_removeEvents()

	self._episodeItems = nil

	TaskDispatcher.cancelTask(self._refreshLeftTime, self)
end

function IgorEpisodeLevelView:_onCloseView(viewName)
	if viewName == ViewName.IgorTaskView then
		self:_onCloseTask()
	end
end

return IgorEpisodeLevelView
