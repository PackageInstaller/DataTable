-- chunkname: @modules/logic/versionactivity3_8/dianjishi/view/DianJiShiLevelView.lua

module("modules.logic.versionactivity3_8.dianjishi.view.DianJiShiLevelView", package.seeall)

local DianJiShiLevelView = class("DianJiShiLevelView", BaseView)
local FocusDuration = 0.5

function DianJiShiLevelView:onInitView()
	self._trsBg = gohelper.findChild(self.viewGO, "#simage_FullBG").transform
	self._scrollstory = gohelper.findChildScrollRect(self.viewGO, "#scroll_Story")
	self._scrollstoryRect = self._scrollstory.gameObject:GetComponent(gohelper.Type_ScrollRect)
	self._gostoryScroll = gohelper.findChild(self.viewGO, "#scroll_Story/#go_Move")
	self._gostages = gohelper.findChild(self.viewGO, "#scroll_Story/#go_Move/#go_StoryStages")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "#go_Title/image_LimitTimeBG/#txt_LimitTime")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Task")
	self._goreddotreward = gohelper.findChild(self.viewGO, "#btn_Task/#go_Reddot")
	self._gotaskani = gohelper.findChild(self.viewGO, "#btn_Task/ani")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gopath = gohelper.findChild(self.viewGO, "#scroll_Story/#go_Move/path")
	self._animPath = gohelper.onceAddComponent(self._gopath, typeof(UnityEngine.Animator))
	self._animTask = self._gotaskani:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DianJiShiLevelView:addEvents()
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self.addEventCb(self, DianJiShiLevelController.instance, DianJiShiGameEvent.EpisodeFinished, self._onEpisodeFinished, self)
	self.addEventCb(self, DianJiShiLevelController.instance, DianJiShiGameEvent.OnBackToLevel, self._onBackToLevel, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
	self._scrollstory:AddOnValueChanged(self.onValueChanged, self)
end

function DianJiShiLevelView:removeEvents()
	self._btntask:RemoveClickListener()
	self.removeEventCb(self, DianJiShiLevelController.instance, DianJiShiGameEvent.EpisodeFinished, self._onEpisodeFinished, self)
	self.removeEventCb(self, DianJiShiLevelController.instance, DianJiShiGameEvent.OnBackToLevel, self._onBackToLevel, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
	self._scrollstory:RemoveOnValueChanged()
end

function DianJiShiLevelView:_btntaskOnClick()
	ViewMgr.instance:openView(ViewName.DianJiShiTaskView)
end

function DianJiShiLevelView:_refreshTask()
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.Activity220Task, self.actId) then
		self._animTask:Play("loop")
	else
		self._animTask:Play("idle")
	end
end

function DianJiShiLevelView:_onCloseTask()
	self:_refreshTask()
end

function DianJiShiLevelView:_removeEvents()
	return
end

function DianJiShiLevelView:_editableInitView()
	self:_initViewInfo()
	self:_initPathAnim()

	self.actId = VersionActivity3_8Enum.ActivityId.DianJiShi
	self._viewAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	RedDotController.instance:addRedDot(self._goreddotreward, RedDotEnum.DotNode.Activity220Task, self.actId)
end

function DianJiShiLevelView:_initPathAnim()
	self._pathAnimTab = self:getUserDataTb_()

	for i = 1, math.huge do
		local goPath = gohelper.findChild(self._gopath, "Image_Path" .. i)

		if gohelper.isNil(goPath) then
			return
		end

		self._pathAnimTab[i] = gohelper.onceAddComponent(goPath, typeof(UnityEngine.Animator))
	end
end

function DianJiShiLevelView:_initViewInfo()
	self._scrollWidth = recthelper.getWidth(self._gostoryScroll.transform)

	local width = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local bgwidth = recthelper.getWidth(self._trsBg)

	self._halfbg = bgwidth / 2
	self._offsetX = width / 2
	self._canMoveBgWidth = self._halfbg - self._offsetX
	self.minContentAnchorX = -self._scrollWidth + width
end

function DianJiShiLevelView:onValueChanged()
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

function DianJiShiLevelView:_onScreenSizeChange()
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

function DianJiShiLevelView:onOpen()
	DianJiShiTaskListModel.instance:init(self.actId)
	self:_initLevelItems()
	self:_refreshLeftTime()

	if self._curEpisodeIndex > 8 then
		self._curEpisodeIndex = 8
	end

	self:_focusStoryItem(self._curEpisodeIndex)
	self:_refreshTask()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
end

function DianJiShiLevelView:_refreshLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function DianJiShiLevelView:_initLevelItems()
	local path = self.viewContainer:getSetting().otherRes[1]

	self._episodeItems = {}

	local episodeCos = Activity220Config.instance:getEpisodeConfigList(self.actId)
	local maxUnlockEpisode = DianJiShiModel.instance:getMaxUnlockEpisodeId()

	self._curEpisodeIndex = DianJiShiModel.instance:getEpisodeIndex(maxUnlockEpisode)

	DianJiShiModel.instance:setCurEpisode(self._curEpisodeIndex, maxUnlockEpisode)

	for i = 1, #episodeCos do
		local nodeRoot = gohelper.findChild(self._gostages, "stage" .. i)
		local cloneGo = self:getResInst(path, nodeRoot)

		self._episodeItems[i] = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, DianJiShiLevelItem, self)

		self._episodeItems[i]:setParam(episodeCos[i], i, self.actId)

		local isPass = DianJiShiModel.instance:isEpisodePass(episodeCos[i].episodeId)

		self:_playPathAnim(i, isPass and "idle2" or "idle1")
	end
end

function DianJiShiLevelView:_focusStoryItem(index, needPlay)
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

function DianJiShiLevelView:_onBackToLevel()
	local newEpisode = DianJiShiModel.instance:getNewFinishEpisode()

	if newEpisode and newEpisode ~= 0 then
		local maxUnlockEpisode = DianJiShiModel.instance:getMaxUnlockEpisodeId()

		self._curEpisodeIndex = DianJiShiModel.instance:getEpisodeIndex(maxUnlockEpisode)

		DianJiShiModel.instance:setCurEpisode(self._curEpisodeIndex, maxUnlockEpisode)
	end

	self:_refreshTask()
end

function DianJiShiLevelView:_onEpisodeFinished()
	local newEpisode = DianJiShiModel.instance:getNewFinishEpisode()

	if newEpisode then
		TaskDispatcher.runDelay(self._playStoryFinishAnim, self, 1)
	end
end

function DianJiShiLevelView:_playStoryFinishAnim()
	TaskDispatcher.cancelTask(self._playStoryFinishAnim, self)

	local newEpisode = DianJiShiModel.instance:getNewFinishEpisode()

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

		DianJiShiModel.instance:clearFinishEpisode()
	end
end

function DianJiShiLevelView:_finishStoryEnd()
	if self._finishEpisodeIndex == #self._episodeItems then
		self._curEpisodeIndex = self._finishEpisodeIndex
		self._finishEpisodeIndex = nil
	else
		self._curEpisodeIndex = self._finishEpisodeIndex + 1

		self:_playPathAnim(self._finishEpisodeIndex, "move")
		self:_onScreenSizeChange()
		TaskDispatcher.runDelay(self._unlockStory, self, 0.5)
	end
end

function DianJiShiLevelView:_playPathAnim(episodeIndex, animName)
	if not episodeIndex or string.nilorempty(animName) then
		return
	end

	if self._pathAnimTab then
		local animPath = self._pathAnimTab[episodeIndex]

		if not animPath then
			return
		end

		animPath:Play(animName, 0, 0)
	end
end

function DianJiShiLevelView:_unlockStory()
	TaskDispatcher.cancelTask(self._unlockStory, self)
	self._episodeItems[self._finishEpisodeIndex + 1]:refreshUI()
	self._episodeItems[self._finishEpisodeIndex + 1]:playUnlock()
	self:_focusStoryItem(self._finishEpisodeIndex + 1, true)
	TaskDispatcher.runDelay(self._unlockLvEnd, self, 1.5)
end

function DianJiShiLevelView:_unlockLvEnd()
	self._finishEpisodeIndex = nil
end

function DianJiShiLevelView:onClose()
	TaskDispatcher.cancelTask(self._refreshLeftTime, self)
	TaskDispatcher.cancelTask(self._playStoryFinishAnim, self)
	TaskDispatcher.cancelTask(self._finishStoryEnd, self)
	TaskDispatcher.cancelTask(self._unlockLvEnd, self)
	TaskDispatcher.cancelTask(self._unlockStory, self)
end

function DianJiShiLevelView:onDestroyView()
	self:_removeEvents()

	self._episodeItems = nil

	TaskDispatcher.cancelTask(self._refreshLeftTime, self)
end

function DianJiShiLevelView:_onCloseView(viewName)
	if viewName == ViewName.DianJiShiTaskView then
		self:_onCloseTask()
	end
end

return DianJiShiLevelView
