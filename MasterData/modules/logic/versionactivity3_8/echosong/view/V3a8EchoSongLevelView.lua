-- chunkname: @modules/logic/versionactivity3_8/echosong/view/V3a8EchoSongLevelView.lua

module("modules.logic.versionactivity3_8.echosong.view.V3a8EchoSongLevelView", package.seeall)

local V3a8EchoSongLevelView = class("V3a8EchoSongLevelView", BaseView)

function V3a8EchoSongLevelView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._scrollStory = gohelper.findChildScrollRect(self.viewGO, "#scroll_Story")
	self._goMove = gohelper.findChild(self.viewGO, "#scroll_Story/#go_Move")
	self._goStoryStages = gohelper.findChild(self.viewGO, "#scroll_Story/#go_Move/#go_StoryStages")
	self._goTitle = gohelper.findChild(self.viewGO, "#go_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "#go_Title/image_LimitTimeBG/#txt_LimitTime")
	self._btnTask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Task")
	self._goReddot = gohelper.findChild(self.viewGO, "#btn_Task/#go_Reddot")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a8EchoSongLevelView:addEvents()
	self._btnTask:AddClickListener(self._btnTaskOnClick, self)
end

function V3a8EchoSongLevelView:removeEvents()
	self._btnTask:RemoveClickListener()
end

function V3a8EchoSongLevelView:_btnTaskOnClick()
	V3a8EchoSongController.instance:openV3a8EchoSongTaskView()
end

function V3a8EchoSongLevelView:_editableInitView()
	self._gostoryScroll = gohelper.findChild(self.viewGO, "#scroll_Story/#go_Move")
	self._goreddotreward = gohelper.findChild(self.viewGO, "#btn_Task/#go_Reddot")
	self._trsBg = gohelper.findChild(self.viewGO, "#simage_FullBG").transform
	self._gopath = gohelper.findChild(self.viewGO, "#scroll_Story/#go_Move/path")
	self._gotaskani = gohelper.findChild(self.viewGO, "#btn_Task/ani")
	self._animTask = self._gotaskani:GetComponent(typeof(UnityEngine.Animator))
	self.actId = V3a8EchoSongModel.instance:getActId()
	self._viewAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	RedDotController.instance:addRedDot(self._goreddotreward, RedDotEnum.DotNode.Activity220Task, self.actId)
	self:_initViewInfo()
	self.addEventCb(self, Activity220Controller.instance, Activity220Event.EpisodeFinished, self._onEpisodeFinished, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
end

function V3a8EchoSongLevelView:_onEpisodeFinished()
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

function V3a8EchoSongLevelView:_playStoryFinishAnim()
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

function V3a8EchoSongLevelView:_finishStoryEnd()
	if not self._finishEpisodeIndex then
		return
	end

	if self._finishEpisodeIndex == #self._episodeItems then
		self._curEpisodeIndex = self._finishEpisodeIndex
		self._finishEpisodeIndex = nil
	else
		self._curEpisodeIndex = self._finishEpisodeIndex + 1

		local animator = gohelper.findChildComponent(self.viewGO, "#scroll_Story/#go_Move/path/Image_Path" .. self._finishEpisodeIndex, typeof(UnityEngine.Animator))

		if animator then
			animator:Play("unlock_ing")
		end

		self:_onScreenSizeChange()
		TaskDispatcher.cancelTask(self._unlockStory, self)
		TaskDispatcher.runDelay(self._unlockStory, self, 0.5)
	end
end

function V3a8EchoSongLevelView:_unlockStory()
	if self._finishEpisodeIndex then
		if not self._finishEpisodeIndex then
			return
		end

		self._finishEpisodeIndex:refreshUI()
		self._finishEpisodeIndex:playUnlock()
		self:_focusStoryItem(self._finishEpisodeIndex + 1, true)
		TaskDispatcher.cancelTask(self._unlockLvEnd, self)
		TaskDispatcher.runDelay(self._unlockLvEnd, self, 1.5)
		AudioMgr.instance:trigger(V3a8EchoSongEnum.Audio.play_ui_shiji3_8_hsy_level)
	end
end

function V3a8EchoSongLevelView:_unlockLvEnd()
	self._finishEpisodeIndex = nil
end

function V3a8EchoSongLevelView:_onCloseView(viewName)
	if viewName == ViewName.V3a8EchoSongTaskView then
		self:_refreshTask()
	end
end

function V3a8EchoSongLevelView:_onScreenSizeChange()
	local width = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local bgwidth = recthelper.getWidth(self._trsBg)

	self._halfbg = bgwidth / 2
	self._offsetX = width / 2
	self._canMoveBgWidth = self._halfbg - self._offsetX
	self.minContentAnchorX = -self._scrollWidth + width

	local per = self._scrollStory.horizontalNormalizedPosition

	if per > 1 then
		per = 1
	end
end

function V3a8EchoSongLevelView:_initViewInfo()
	self._scrollWidth = recthelper.getWidth(self._gostoryScroll.transform)

	local width = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local bgwidth = recthelper.getWidth(self._trsBg)

	self._halfbg = bgwidth / 2
	self._offsetX = width / 2
	self._canMoveBgWidth = self._halfbg - self._offsetX
	self.minContentAnchorX = -self._scrollWidth + width
end

function V3a8EchoSongLevelView:onUpdateParam()
	if self._curEpisodeIndex then
		self:_focusStoryItem(self._curEpisodeIndex)
	end
end

function V3a8EchoSongLevelView:onOpen()
	self:_initLevelItems()
	self:_refreshTask()
	self:_refreshLeftTime()
	TaskDispatcher.cancelTask(self._refreshLeftTime, self)
	TaskDispatcher.runRepeat(self._refreshLeftTime, self, TimeUtil.OneMinuteSecond)
end

function V3a8EchoSongLevelView:_initLevelItems()
	local path = self.viewContainer:getSetting().otherRes[1]

	self._episodeItems = self:getUserDataTb_()

	local episodeCos = Activity220Config.instance:getEpisodeConfigList(self.actId)
	local maxUnlockEpisode = Activity220Model.instance:getMaxUnlockEpisodeId(self.actId)

	self._curEpisodeIndex = Activity220Config.instance:getEpisodeIndex(self.actId, maxUnlockEpisode)

	for i = 1, self._curEpisodeIndex - 1 do
		local animator = gohelper.findChildComponent(self.viewGO, "#scroll_Story/#go_Move/path/Image_Path" .. i, typeof(UnityEngine.Animator))

		if animator then
			animator:Play("unlock")
		end
	end

	Activity220Model.instance:setCurEpisode(self.actId, self._curEpisodeIndex, maxUnlockEpisode)

	for i = 1, #episodeCos do
		local nodeRoot = gohelper.findChild(self._goStoryStages, "stage" .. i)

		if nodeRoot then
			local cloneGo = self:getResInst(path, nodeRoot)

			self._episodeItems[i] = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, V3a8EchoSongLevelItem, self)

			self._episodeItems[i]:setParam(episodeCos[i], i, self.actId)
		else
			logError(string.format("V3a8EchoSongLevelView:_initLevelItems error, no stage node, index:%s", i))
		end
	end

	self:_focusStoryItem(self._curEpisodeIndex)
end

local FocusDuration = 0.5

function V3a8EchoSongLevelView:_focusStoryItem(index, needPlay)
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
		end
	end
end

function V3a8EchoSongLevelView:_refreshTask()
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.Activity220Task, self.actId) then
		self._animTask:Play("loop")
	else
		self._animTask:Play("idle")
	end
end

function V3a8EchoSongLevelView:_refreshLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function V3a8EchoSongLevelView:onClose()
	TaskDispatcher.cancelTask(self._refreshLeftTime, self)
	TaskDispatcher.cancelTask(self._playStoryFinishAnim, self)
	TaskDispatcher.cancelTask(self._finishStoryEnd, self)
	TaskDispatcher.cancelTask(self._unlockStory, self)
	TaskDispatcher.cancelTask(self._unlockLvEnd, self)
end

function V3a8EchoSongLevelView:onDestroyView()
	return
end

return V3a8EchoSongLevelView
