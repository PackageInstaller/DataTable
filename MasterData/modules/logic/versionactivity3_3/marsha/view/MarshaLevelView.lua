-- chunkname: @modules/logic/versionactivity3_3/marsha/view/MarshaLevelView.lua

module("modules.logic.versionactivity3_3.marsha.view.MarshaLevelView", package.seeall)

local MarshaLevelView = class("MarshaLevelView", BaseView)

function MarshaLevelView:onInitView()
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

function MarshaLevelView:addEvents()
	self._btnTask:AddClickListener(self._btnTaskOnClick, self)
end

function MarshaLevelView:removeEvents()
	self._btnTask:RemoveClickListener()
end

function MarshaLevelView:_btnTaskOnClick()
	ViewMgr.instance:openView(ViewName.MarshaTaskView)
end

function MarshaLevelView:_editableInitView()
	self.actId = VersionActivity3_3Enum.ActivityId.Marsha
	self._viewAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._transBg = self._simageFullBG.gameObject.transform
	self._scrollRect = self._scrollStory.gameObject:GetComponent(gohelper.Type_ScrollRect)
	self._width = recthelper.getWidth(self._goMove.transform)

	local width = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local bgwidth = recthelper.getWidth(self._transBg)

	self._halfbg = bgwidth / 2
	self._offsetX = width / 2
	self._canMoveBgWidth = self._halfbg - self._offsetX
	self.minContentAnchorX = -self._width + width

	RedDotController.instance:addRedDot(self._goReddot, RedDotEnum.DotNode.Activity220Task, self.actId)

	self.goLines = {}
	self.animLines = {}

	for i = 1, 7 do
		self.goLines[i] = gohelper.findChild(self._goMove, "path/Line" .. i)
		self.animLines[i] = self.goLines[i]:GetComponent(gohelper.Type_Animator)
	end

	local goTaskAni = gohelper.findChild(self._btnTask.gameObject, "ani")

	self._animTask = goTaskAni:GetComponent(typeof(UnityEngine.Animator))
end

function MarshaLevelView:onOpen()
	self.addEventCb(self, MarshaController.instance, MarshaEvent.EpisodeFinished, self._onEpisodeFinished, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
	self:_initLevelItems()
	self:_refreshLeftTime()
	self:_refreshTaskAnim()

	if self._curEpisodeIndex > 8 then
		self._curEpisodeIndex = 8
	end

	self:_checkLockHorizontal()
	self:_focusStoryItem(self._curEpisodeIndex)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
end

function MarshaLevelView:onClose()
	TaskDispatcher.cancelTask(self._refreshLeftTime, self)
	TaskDispatcher.cancelTask(self._playStoryFinishAnim, self)
	TaskDispatcher.cancelTask(self._finishStoryEnd, self)
	TaskDispatcher.cancelTask(self._unlockLvEnd, self)
	TaskDispatcher.cancelTask(self._unlockStory, self)
end

function MarshaLevelView:onDestroyView()
	self._episodeItems = nil

	TaskDispatcher.cancelTask(self._refreshLeftTime, self)
end

function MarshaLevelView:_checkLockHorizontal()
	local itemwidth = 540
	local startSpace = 330 - itemwidth / 2
	local currentWidth = itemwidth * self._curEpisodeIndex + startSpace
	local width = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)

	if currentWidth < width then
		self._scrollRect.horizontal = false
	else
		self._scrollRect.horizontal = true

		recthelper.setWidth(self._goMove.transform, currentWidth)

		self._width = currentWidth
	end
end

function MarshaLevelView:_focusStoryItem(index, needPlay)
	if not self._scrollRect.horizontal then
		return
	end

	local contentAnchorX = recthelper.getAnchorX(self._episodeItems[index].transform.parent)
	local offsetX = self._offsetX - contentAnchorX

	if offsetX > 0 then
		offsetX = 0
	elseif offsetX < self.minContentAnchorX then
		offsetX = self.minContentAnchorX
	end

	if needPlay then
		ZProj.TweenHelper.DOAnchorPosX(self._goMove.transform, offsetX, 0.5)
	else
		recthelper.setAnchorX(self._goMove.transform, offsetX)
	end
end

function MarshaLevelView:_refreshTaskAnim()
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.Activity220Task, self.actId) then
		self._animTask:Play("loop")
	else
		self._animTask:Play("idle")
	end
end

function MarshaLevelView:onValueChanged()
	local per = self._scrollStory.horizontalNormalizedPosition

	if per > 1 then
		per = 1
	end

	if per < 0 then
		per = 0
	end

	local moveX = self._canMoveBgWidth * per

	recthelper.setAnchorX(self._transBg, -moveX)
end

function MarshaLevelView:_onScreenSizeChange()
	self:_checkLockHorizontal()

	local width = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local bgwidth = recthelper.getWidth(self._transBg)

	self._halfbg = bgwidth / 2
	self._offsetX = width / 2
	self._canMoveBgWidth = self._halfbg - self._offsetX
	self.minContentAnchorX = -self._width + width
end

function MarshaLevelView:_refreshLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function MarshaLevelView:_initLevelItems()
	local path = self.viewContainer:getSetting().otherRes[1]

	self._episodeItems = {}

	local episodeCos = Activity220Config.instance:getEpisodeConfigList(self.actId)
	local maxUnlockEpisode = MarshaModel.instance:getMaxUnlockEpisodeId()

	self._curEpisodeIndex = MarshaModel.instance:getEpisodeIndex(maxUnlockEpisode)
	self._beforeLastEpisodeId = episodeCos[#episodeCos - 1].episodeId

	MarshaModel.instance:setCurEpisode(maxUnlockEpisode)

	for i = 1, 8 do
		if i ~= 8 then
			gohelper.setActive(self.goLines[i], i < self._curEpisodeIndex)
		end

		local nodeRoot = gohelper.findChild(self._goStoryStages, "stage" .. i)

		if nodeRoot then
			local cloneGo = self:getResInst(path, nodeRoot)

			self._episodeItems[i] = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, MarshaLevelItem, self)

			self._episodeItems[i]:setData(episodeCos[i], i, self.actId)
		end
	end
end

function MarshaLevelView:_onEpisodeFinished()
	local newEpisode = MarshaModel.instance:getNewFinishEpisode()

	if newEpisode and newEpisode ~= 0 then
		TaskDispatcher.runDelay(self._playStoryFinishAnim, self, 1)

		local maxUnlockEpisode = MarshaModel.instance:getMaxUnlockEpisodeId()

		self._curEpisodeIndex = MarshaModel.instance:getEpisodeIndex(maxUnlockEpisode)

		MarshaModel.instance:setCurEpisode(maxUnlockEpisode)
		self:_refreshTaskAnim()
	end
end

function MarshaLevelView:_playStoryFinishAnim()
	TaskDispatcher.cancelTask(self._playStoryFinishAnim, self)

	local newEpisode = MarshaModel.instance:getNewFinishEpisode()

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

		MarshaModel.instance:clearFinishEpisode()
	end
end

function MarshaLevelView:_finishStoryEnd()
	if self._finishEpisodeIndex == #self._episodeItems then
		self._curEpisodeIndex = self._finishEpisodeIndex
		self._finishEpisodeIndex = nil
	else
		self._curEpisodeIndex = self._finishEpisodeIndex + 1

		gohelper.setActive(self.goLines[self._finishEpisodeIndex], true)
		self.animLines[self._finishEpisodeIndex]:Play("move", 0, 0)
		AudioMgr.instance:trigger(AudioEnum3_3.Marsha.play_ui_yuanzheng_mrs_level)
		self:_onScreenSizeChange()
		TaskDispatcher.runDelay(self._unlockStory, self, 0.5)
	end
end

function MarshaLevelView:_unlockStory()
	TaskDispatcher.cancelTask(self._unlockStory, self)
	self._episodeItems[self._finishEpisodeIndex + 1]:playUnlock()
	TaskDispatcher.runDelay(self._unlockLvEnd, self, 1.5)
	self:_focusStoryItem(self._finishEpisodeIndex + 1, true)
end

function MarshaLevelView:_unlockLvEnd()
	self._finishEpisodeIndex = nil
end

function MarshaLevelView:_onCloseView(viewName)
	if viewName == ViewName.MarshaGameView then
		gohelper.setActive(self.viewGO, true)
	elseif viewName == ViewName.MarshaTaskView then
		self:_refreshTaskAnim()
	end
end

return MarshaLevelView
