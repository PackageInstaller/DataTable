-- chunkname: @modules/logic/versionactivity3_4/lusijian/view/LuSiJianLevelView.lua

module("modules.logic.versionactivity3_4.lusijian.view.LuSiJianLevelView", package.seeall)

local LuSiJianLevelView = class("LuSiJianLevelView", BaseView)
local FocusDuration = 0.5

function LuSiJianLevelView:onInitView()
	self._trsBg = gohelper.findChild(self.viewGO, "#simage_FullBG").transform
	self._scrollstory = gohelper.findChildScrollRect(self.viewGO, "#scroll_Story")
	self._scrollstoryRect = self._scrollstory.gameObject:GetComponent(gohelper.Type_ScrollRect)
	self._gostoryScroll = gohelper.findChild(self.viewGO, "#scroll_Story")
	self._goMove = gohelper.findChild(self.viewGO, "#scroll_Story/#go_Move")
	self._gostages = gohelper.findChild(self.viewGO, "#scroll_Story/#go_Move/#go_StoryStages")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "#go_Title/image_LimitTimeBG/#txt_LimitTime")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Task")
	self._goreddotreward = gohelper.findChild(self.viewGO, "#btn_Task/#go_Reddot")
	self._gotaskani = gohelper.findChild(self.viewGO, "#btn_Task/ani")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._gopath = gohelper.findChild(self.viewGO, "#scroll_Story/#go_Move/path")
	self._gopath2 = gohelper.findChild(self.viewGO, "#scroll_Story/#go_Move/path/Path2")
	self._animTask = self._gotaskani:GetComponent(typeof(UnityEngine.Animator))
	self._animPath = self._gopath2:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LuSiJianLevelView:addEvents()
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self.addEventCb(self, LuSiJianController.instance, LuSiJianEvent.EpisodeFinished, self._onEpisodeFinished, self)
	self.addEventCb(self, LuSiJianController.instance, LuSiJianEvent.OnBackToLevel, self._onBackToLevel, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
	self._scrollstory:AddOnValueChanged(self.onValueChanged, self)
end

function LuSiJianLevelView:removeEvents()
	self._btntask:RemoveClickListener()
	self.removeEventCb(self, LuSiJianController.instance, LuSiJianEvent.EpisodeFinished, self._onEpisodeFinished, self)
	self.removeEventCb(self, LuSiJianController.instance, LuSiJianEvent.OnBackToLevel, self._onBackToLevel, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
	self._scrollstory:RemoveOnValueChanged()
end

function LuSiJianLevelView:_btntaskOnClick()
	ViewMgr.instance:openView(ViewName.LuSiJianTaskView)
end

function LuSiJianLevelView:_refreshTask()
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.Activity220Task, self.actId) then
		self._animTask:Play("loop")
	else
		self._animTask:Play("idle")
	end
end

function LuSiJianLevelView:_onCloseTask()
	self:_refreshTask()
end

function LuSiJianLevelView:_removeEvents()
	return
end

function LuSiJianLevelView:_editableInitView()
	self:_initViewInfo()

	self.actId = VersionActivity3_4Enum.ActivityId.LuSiJian
	self._viewAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	RedDotController.instance:addRedDot(self._goreddotreward, RedDotEnum.DotNode.Activity220Task, self.actId)
end

function LuSiJianLevelView:_initViewInfo()
	self._scrollWidth = recthelper.getWidth(self._goMove.transform)

	local width = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local bgwidth = recthelper.getWidth(self._trsBg)

	self._halfbg = bgwidth / 2
	self._offsetX = width / 2
	self._canMoveBgWidth = self._halfbg - self._offsetX
	self.minContentAnchorX = -self._scrollWidth + width
end

function LuSiJianLevelView:onValueChanged()
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

function LuSiJianLevelView:_onScreenSizeChange()
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

function LuSiJianLevelView:_focusStoryItem(index, needPlay)
	local contentAnchorX = recthelper.getAnchorX(self._episodeItems[index].transform.parent)
	local offsetX = self._offsetX - contentAnchorX

	if offsetX > 0 then
		offsetX = 0
	elseif offsetX < self.minContentAnchorX then
		offsetX = self.minContentAnchorX
	end

	if needPlay then
		ZProj.TweenHelper.DOAnchorPosX(self._goMove.transform, offsetX, FocusDuration)
	else
		recthelper.setAnchorX(self._goMove.transform, offsetX)
	end
end

function LuSiJianLevelView:onOpen()
	LuSiJianTaskListModel.instance:init(self.actId)
	self:_initLevelItems()
	self:_refreshLeftTime()
	self:_refreshTask()

	if self._curEpisodeIndex > 8 then
		self._curEpisodeIndex = 8
	end

	self:_focusStoryItem(self._curEpisodeIndex)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
end

function LuSiJianLevelView:_refreshLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function LuSiJianLevelView:_initLevelItems()
	local path = self.viewContainer:getSetting().otherRes[1]

	self._episodeItems = {}

	local episodeCos = LuSiJianConfig.instance:getEpisodeCoList(self.actId)
	local maxUnlockEpisode = LuSiJianModel.instance:getMaxUnlockEpisodeId()

	self._curEpisodeIndex = LuSiJianModel.instance:getEpisodeIndex(maxUnlockEpisode)

	local animname = "idle" .. self._curEpisodeIndex

	self._animPath:Play(animname, 0, 0)
	LuSiJianModel.instance:setCurEpisode(self._curEpisodeIndex, maxUnlockEpisode)

	for i = 1, #episodeCos do
		local nodeRoot = gohelper.findChild(self._gostages, "stage" .. i)
		local cloneGo = self:getResInst(path, nodeRoot)

		self._episodeItems[i] = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, LuSiJianLevelItem, self)

		self._episodeItems[i]:setParam(episodeCos[i], i, self.actId)
	end
end

function LuSiJianLevelView:onStoryItemClick(index)
	return
end

function LuSiJianLevelView:_onBackToLevel()
	local newEpisode = LuSiJianModel.instance:getNewFinishEpisode()

	if newEpisode and newEpisode ~= 0 then
		local maxUnlockEpisode = LuSiJianModel.instance:getMaxUnlockEpisodeId()

		self._curEpisodeIndex = LuSiJianModel.instance:getEpisodeIndex(maxUnlockEpisode)

		LuSiJianModel.instance:setCurEpisode(self._curEpisodeIndex, maxUnlockEpisode)
	end

	self:_refreshTask()
end

function LuSiJianLevelView:_onEpisodeFinished()
	local newEpisode = LuSiJianModel.instance:getNewFinishEpisode()

	if newEpisode then
		TaskDispatcher.runDelay(self._playStoryFinishAnim, self, 1)
	end
end

function LuSiJianLevelView:_playStoryFinishAnim()
	TaskDispatcher.cancelTask(self._playStoryFinishAnim, self)

	local newEpisode = LuSiJianModel.instance:getNewFinishEpisode()

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

		LuSiJianModel.instance:clearFinishEpisode()
	end
end

function LuSiJianLevelView:_finishStoryEnd()
	if self._finishEpisodeIndex == #self._episodeItems then
		self._curEpisodeIndex = self._finishEpisodeIndex
		self._finishEpisodeIndex = nil
	else
		local animname = "move" .. self._finishEpisodeIndex + 1

		self._animPath:Play(animname, 0, 0)

		self._curEpisodeIndex = self._finishEpisodeIndex + 1

		self:_onScreenSizeChange()
		TaskDispatcher.runDelay(self._unlockStory, self, 0.5)
	end
end

function LuSiJianLevelView:_unlockStory()
	TaskDispatcher.cancelTask(self._unlockStory, self)
	self._episodeItems[self._finishEpisodeIndex + 1]:refreshUI()
	self._episodeItems[self._finishEpisodeIndex + 1]:playUnlock()
	self:_focusStoryItem(self._finishEpisodeIndex + 1, true)
	TaskDispatcher.runDelay(self._unlockLvEnd, self, 1.5)
end

function LuSiJianLevelView:_unlockLvEnd()
	self._finishEpisodeIndex = nil
end

function LuSiJianLevelView:onClose()
	TaskDispatcher.cancelTask(self._refreshLeftTime, self)
	TaskDispatcher.cancelTask(self._playStoryFinishAnim, self)
	TaskDispatcher.cancelTask(self._finishStoryEnd, self)
	TaskDispatcher.cancelTask(self._unlockLvEnd, self)
	TaskDispatcher.cancelTask(self._unlockStory, self)
end

function LuSiJianLevelView:onDestroyView()
	self:_removeEvents()

	self._episodeItems = nil

	TaskDispatcher.cancelTask(self._refreshLeftTime, self)
end

function LuSiJianLevelView:_onCloseView(viewName)
	if viewName == ViewName.LuSiJianGameView then
		gohelper.setActive(self.viewGO, true)
	elseif viewName == ViewName.LuSiJianTaskView then
		self:_onCloseTask()
	end
end

return LuSiJianLevelView
