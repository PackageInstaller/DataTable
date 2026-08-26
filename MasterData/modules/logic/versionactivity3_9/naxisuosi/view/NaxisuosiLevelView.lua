-- chunkname: @modules/logic/versionactivity3_9/naxisuosi/view/NaxisuosiLevelView.lua

module("modules.logic.versionactivity3_9.naxisuosi.view.NaxisuosiLevelView", package.seeall)

local NaxisuosiLevelView = class("NaxisuosiLevelView", BaseView)
local FocusDuration = 0.5

function NaxisuosiLevelView:onInitView()
	self._trsBg = gohelper.findChild(self.viewGO, "#simage_FullBG").transform
	self._scrollstory = gohelper.findChildScrollRect(self.viewGO, "#scroll_Story")
	self._scrollstoryRect = self._scrollstory.gameObject:GetComponent(gohelper.Type_ScrollRect)
	self._gostoryScroll = gohelper.findChild(self.viewGO, "#scroll_Story/#go_Move")
	self._gostages = gohelper.findChild(self.viewGO, "#scroll_Story/#go_Move/#go_StoryStages")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "#go_Title/image_LimitTimeBG/#txt_LimitTime")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Task")
	self._goreddotreward = gohelper.findChild(self.viewGO, "#btn_Task/#go_Reddot")
	self._gotaskani = gohelper.findChild(self.viewGO, "#btn_Task/ani")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._gopath = gohelper.findChild(self.viewGO, "#scroll_Story/#go_Move/path")
	self._animPath = gohelper.findChildComponent(self.viewGO, "#scroll_Story/#go_Move/path", typeof(UnityEngine.Animator))
	self._animTask = self._gotaskani:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NaxisuosiLevelView:addEvents()
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self._scrollstory:AddOnValueChanged(self.onValueChanged, self)
	self.addEventCb(self, Activity220Controller.instance, Activity220Event.EpisodeFinished, self._onEpisodeFinished, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
end

function NaxisuosiLevelView:removeEvents()
	self._btntask:RemoveClickListener()
	self._scrollstory:RemoveOnValueChanged()
	self.removeEventCb(self, Activity220Controller.instance, Activity220Event.EpisodeFinished, self._onEpisodeFinished, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
end

function NaxisuosiLevelView:_btntaskOnClick()
	NaxisuosiController.instance:openTaskView()
end

function NaxisuosiLevelView:onValueChanged()
	local per = GameUtil.clamp(self._scrollstory.horizontalNormalizedPosition, 0, 1)
	local moveX = self._canMoveBgWidth * per

	recthelper.setAnchorX(self._trsBg, -moveX)
end

function NaxisuosiLevelView:_onEpisodeFinished()
	local mo = Activity220Model.instance:getById(self.actId)

	if not mo then
		return
	end

	local newEpisode = mo:getNewFinishEpisode()

	if newEpisode then
		TaskDispatcher.runDelay(self._playStoryFinishAnim, self, 1)

		local maxUnlockEpisode = Activity220Model.instance:getMaxUnlockEpisodeId(self.actId)

		self._curEpisodeIndex = NaxisuosiConfig.instance:getEpisodeIndex(maxUnlockEpisode)

		Activity220Model.instance:setCurEpisode(self.actId, self._curEpisodeIndex, maxUnlockEpisode)
	end

	self:_refreshTask()
end

function NaxisuosiLevelView:_playStoryFinishAnim()
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
				TaskDispatcher.cancelTask(self._finishStoryEnd, self)
				TaskDispatcher.runDelay(self._finishStoryEnd, self, 1.5)

				break
			end
		end

		mo:clearFinishEpisode()
	end
end

function NaxisuosiLevelView:_finishStoryEnd()
	if self._finishEpisodeIndex == #self._episodeItems then
		self._curEpisodeIndex = self._finishEpisodeIndex
		self._finishEpisodeIndex = nil
	else
		self._curEpisodeIndex = self._finishEpisodeIndex + 1

		local animName = "move" .. self._curEpisodeIndex

		self._animPath:Play(animName, 0, 0)
		self:_onScreenSizeChange()
		TaskDispatcher.cancelTask(self._unlockStory, self)
		TaskDispatcher.runDelay(self._unlockStory, self, 0.5)
	end
end

function NaxisuosiLevelView:_unlockStory()
	if self._finishEpisodeIndex then
		if not self._finishEpisodeIndex then
			return
		end

		self._finishEpisodeIndex:refreshUI()
		self._finishEpisodeIndex:playUnlock()
		self:_focusStoryItem(self._finishEpisodeIndex + 1, true)
		TaskDispatcher.cancelTask(self._unlockLvEnd, self)
		TaskDispatcher.runDelay(self._unlockLvEnd, self, 1.5)
	end
end

function NaxisuosiLevelView:_unlockLvEnd()
	self._finishEpisodeIndex = nil
end

function NaxisuosiLevelView:_onCloseView(viewName)
	if viewName == ViewName.NaxisuosiTaskView then
		self:_refreshTask()
	end
end

function NaxisuosiLevelView:_onScreenSizeChange()
	local width = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local bgwidth = recthelper.getWidth(self._trsBg)

	self._halfbg = bgwidth / 2
	self._offsetX = width / 2
	self._canMoveBgWidth = self._halfbg - self._offsetX
	self.minContentAnchorX = -self._scrollWidth + width

	self:onValueChanged()
end

function NaxisuosiLevelView:_editableInitView()
	self:_initViewInfo()

	self.actId = NaxisuosiModel.instance:getActId()
	self._viewAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	RedDotController.instance:addRedDot(self._goreddotreward, RedDotEnum.DotNode.Activity220Task, self.actId)
end

function NaxisuosiLevelView:_initViewInfo()
	self._scrollWidth = recthelper.getWidth(self._gostoryScroll.transform)

	local width = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local bgwidth = recthelper.getWidth(self._trsBg)

	self._halfbg = bgwidth / 2
	self._offsetX = width / 2
	self._canMoveBgWidth = self._halfbg - self._offsetX
	self.minContentAnchorX = -self._scrollWidth + width
end

function NaxisuosiLevelView:onUpdateParam()
	if self._curEpisodeIndex then
		self:_focusStoryItem(self._curEpisodeIndex)
	end
end

function NaxisuosiLevelView:onOpen()
	self:_initLevelItems()
	self:_refreshTask()
	self:_refreshLeftTime()
	TaskDispatcher.cancelTask(self._refreshLeftTime, self)
	TaskDispatcher.runRepeat(self._refreshLeftTime, self, TimeUtil.OneMinuteSecond)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
end

function NaxisuosiLevelView:_initLevelItems()
	local path = self.viewContainer:getSetting().otherRes[1]

	self._episodeItems = {}

	local episodeCos = NaxisuosiConfig.instance:getEpisodeConfigList()
	local maxUnlockEpisode = Activity220Model.instance:getMaxUnlockEpisodeId(self.actId)

	self._curEpisodeIndex = NaxisuosiConfig.instance:getEpisodeIndex(maxUnlockEpisode)

	local animName = "idle" .. self._curEpisodeIndex

	self._animPath:Play(animName, 0, 0)
	Activity220Model.instance:setCurEpisode(self.actId, self._curEpisodeIndex, maxUnlockEpisode)

	for i = 1, #episodeCos do
		local nodeRoot = gohelper.findChild(self._gostages, "stage" .. i)

		if nodeRoot then
			local cloneGo = self:getResInst(path, nodeRoot)

			self._episodeItems[i] = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, NaxisuosiLevelItem, self)

			self._episodeItems[i]:setParam(episodeCos[i], i, self.actId)
		else
			logError(string.format("NaxisuosiLevelView:_initLevelItems error, no stage node, index:%s", i))
		end
	end

	self:_focusStoryItem(self._curEpisodeIndex)
end

function NaxisuosiLevelView:_focusStoryItem(index, needPlay)
	if self._episodeItems then
		local episodeItem = self._episodeItems[index]

		if not episodeItem then
			return
		end

		local contentAnchorX = recthelper.getAnchorX(episodeItem.transform.parent)
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
			self:onValueChanged()
		end
	end
end

function NaxisuosiLevelView:_refreshTask()
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.Activity220Task, self.actId) then
		self._animTask:Play("loop")
	else
		self._animTask:Play("idle")
	end
end

function NaxisuosiLevelView:_refreshLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function NaxisuosiLevelView:onClose()
	TaskDispatcher.cancelTask(self._refreshLeftTime, self)
	TaskDispatcher.cancelTask(self._playStoryFinishAnim, self)
	TaskDispatcher.cancelTask(self._finishStoryEnd, self)
	TaskDispatcher.cancelTask(self._unlockStory, self)
	TaskDispatcher.cancelTask(self._unlockLvEnd, self)
end

function NaxisuosiLevelView:onDestroyView()
	self._episodeItems = nil
end

return NaxisuosiLevelView
