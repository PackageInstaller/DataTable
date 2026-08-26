-- chunkname: @modules/logic/versionactivity3_2/beilier/view/BeiLiErLevelView.lua

module("modules.logic.versionactivity3_2.beilier.view.BeiLiErLevelView", package.seeall)

local BeiLiErLevelView = class("BeiLiErLevelView", BaseView)
local FocusDuration = 0.5

function BeiLiErLevelView:onInitView()
	self._trsBg = gohelper.findChild(self.viewGO, "#simage_FullBG").transform
	self._scrollstory = gohelper.findChildScrollRect(self.viewGO, "#go_storyPath")
	self._scrollstoryRect = self._scrollstory.gameObject:GetComponent(gohelper.Type_ScrollRect)
	self._gostoryScroll = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll")
	self._gostages = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "#go_Title/#go_time/image_LimitTimeBG/#txt_limittime")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Task")
	self._goreddotreward = gohelper.findChild(self.viewGO, "#btn_Task/#go_reddot")
	self._gotaskani = gohelper.findChild(self.viewGO, "#btn_Task/ani")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._goEndless = gohelper.findChild(self.viewGO, "#go_Endless")
	self._btnEndless = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Endless/#btn_click")
	self._txtEndlessname = gohelper.findChildText(self.viewGO, "#go_Endless/#txt_StageName")
	self._goendlessstar = gohelper.findChild(self.viewGO, "#go_Endless/#txt_StageName/Star/#go_star")
	self._goendlessnostar = gohelper.findChild(self.viewGO, "#go_Endless/#txt_StageName/Star/no")
	self._gopath = gohelper.findChild(self.viewGO, "#go_storyPath/#go_storyScroll/path")
	self._animPath = self._gopath:GetComponent(typeof(UnityEngine.Animator))
	self._animTask = self._gotaskani:GetComponent(typeof(UnityEngine.Animator))
	self._animEndless = self._goEndless:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function BeiLiErLevelView:addEvents()
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self._btnEndless:AddClickListener(self._btnEndlessOnClick, self)
	self.addEventCb(self, BeiLiErController.instance, BeiLiErEvent.EpisodeFinished, self._onEpisodeFinished, self)
	self.addEventCb(self, BeiLiErController.instance, BeiLiErEvent.OnBackToLevel, self._onBackToLevel, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
	self._scrollstory:AddOnValueChanged(self.onValueChanged, self)
end

function BeiLiErLevelView:removeEvents()
	self._btntask:RemoveClickListener()
	self._btnEndless:RemoveClickListener()
	self.removeEventCb(self, BeiLiErController.instance, BeiLiErEvent.EpisodeFinished, self._onEpisodeFinished, self)
	self.removeEventCb(self, BeiLiErController.instance, BeiLiErEvent.OnBackToLevel, self._onBackToLevel, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
	self._scrollstory:RemoveOnValueChanged()
end

function BeiLiErLevelView:_btntaskOnClick()
	ViewMgr.instance:openView(ViewName.BeiLiErTaskView)
end

function BeiLiErLevelView:_btnEndlessOnClick()
	if self.lastCo and self.lastCo.gameId == 0 then
		if self.lastCo.storyBefore > 0 then
			local param = {}

			param.mark = true

			StoryController.instance:playStory(self.lastCo.storyBefore, param, self._onGameFinished, self)
		end
	elseif self.lastCo.storyBefore > 0 then
		local param = {}

		param.mark = true

		StoryController.instance:playStory(self.lastCo.storyBefore, param, self._enterGame, self)
	else
		self:_enterGame()
	end
end

function BeiLiErLevelView:_enterGame()
	BeiLiErGameController.instance:enterGame(self.lastCo.episodeId)
end

function BeiLiErLevelView:_onGameFinished()
	BeiLiErController.instance:_onGameFinished(self.actId, self.lastCo.episodeId)
end

function BeiLiErLevelView:_refreshTask()
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.Activity220Task, self.actId) then
		self._animTask:Play("loop")
	else
		self._animTask:Play("idle")
	end
end

function BeiLiErLevelView:_onCloseTask()
	self:_refreshTask()
end

function BeiLiErLevelView:_removeEvents()
	return
end

function BeiLiErLevelView:_editableInitView()
	self:_initViewInfo()

	self.actId = VersionActivity3_2Enum.ActivityId.BeiLiEr
	self._viewAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	RedDotController.instance:addRedDot(self._goreddotreward, RedDotEnum.DotNode.Activity220Task, self.actId)
end

function BeiLiErLevelView:_initViewInfo()
	self._scrollWidth = recthelper.getWidth(self._gostoryScroll.transform)

	local width = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local bgwidth = recthelper.getWidth(self._trsBg)

	self._halfbg = bgwidth / 2
	self._offsetX = width / 2
	self._canMoveBgWidth = self._halfbg - self._offsetX
	self.minContentAnchorX = -self._scrollWidth + width
end

function BeiLiErLevelView:onValueChanged()
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

function BeiLiErLevelView:_onScreenSizeChange()
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

function BeiLiErLevelView:onOpen()
	BeiLiErTaskListModel.instance:init(self.actId)
	self:_initLevelItems()
	self:_refreshLeftTime()
	self:_refreshTask()

	if self._curEpisodeIndex > 8 then
		self._curEpisodeIndex = 8
	end

	self:_checkLockHorizontal()
	self:_focusStoryItem(self._curEpisodeIndex)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
end

function BeiLiErLevelView:_checkLockHorizontal()
	local itemwidth = 440
	local startSpace = 330 - itemwidth / 2
	local currentWidth = itemwidth * self._curEpisodeIndex + startSpace
	local width = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)

	if currentWidth < width then
		self._scrollstoryRect.horizontal = false
	else
		self._scrollstoryRect.horizontal = true

		recthelper.setWidth(self._gostoryScroll.transform, currentWidth)

		self._scrollWidth = currentWidth

		self:_initViewInfo()
	end
end

function BeiLiErLevelView:_refreshLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function BeiLiErLevelView:_initLevelItems()
	local path = self.viewContainer:getSetting().otherRes[1]

	self._episodeItems = {}

	local episodeCos = BeiLiErConfig.instance:getEpisodeCoList(self.actId)
	local maxUnlockEpisode = BeiLiErModel.instance:getMaxUnlockEpisodeId()

	self._curEpisodeIndex = BeiLiErModel.instance:getEpisodeIndex(maxUnlockEpisode)
	self._lastIndex = #episodeCos
	self._beforeLastEpisodeId = episodeCos[#episodeCos - 1].episodeId
	self.lastCo = episodeCos[#episodeCos]

	self:_initEndless()
	self:chekcShowHardNode()

	local animname = "idle" .. self._curEpisodeIndex

	self._animPath:Play(animname, 0, 0)
	BeiLiErModel.instance:setCurEpisode(self._curEpisodeIndex, maxUnlockEpisode)

	for i = 1, #episodeCos - 1 do
		local nodeRoot = gohelper.findChild(self._gostages, "stage" .. i)
		local cloneGo = self:getResInst(path, nodeRoot)

		self._episodeItems[i] = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, BeiLiErStoryItem, self)

		self._episodeItems[i]:setParam(episodeCos[i], i, self.actId)
	end
end

function BeiLiErLevelView:_initEndless()
	local ispass = BeiLiErModel.instance:isEpisodePass(self.lastCo.episodeId)

	gohelper.setActive(self._goendlessnostar, not ispass)
	gohelper.setActive(self._goendlessstar, ispass)

	self._txtEndlessname.text = self.lastCo.name
end

function BeiLiErLevelView:_focusStoryItem(index, needPlay)
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

function BeiLiErLevelView:onStoryItemClick(index)
	return
end

function BeiLiErLevelView:_onBackToLevel()
	local newEpisode = BeiLiErModel.instance:getNewFinishEpisode()

	if newEpisode and newEpisode ~= 0 then
		local maxUnlockEpisode = BeiLiErModel.instance:getMaxUnlockEpisodeId()

		self._curEpisodeIndex = BeiLiErModel.instance:getEpisodeIndex(maxUnlockEpisode)

		BeiLiErModel.instance:setCurEpisode(self._curEpisodeIndex, maxUnlockEpisode)
	end

	self:_refreshTask()
end

function BeiLiErLevelView:_onEpisodeFinished()
	local newEpisode = BeiLiErModel.instance:getNewFinishEpisode()

	if newEpisode then
		TaskDispatcher.runDelay(self._playStoryFinishAnim, self, 1)
	end
end

function BeiLiErLevelView:_playStoryFinishAnim()
	TaskDispatcher.cancelTask(self._playStoryFinishAnim, self)

	local newEpisode = BeiLiErModel.instance:getNewFinishEpisode()

	if newEpisode then
		if newEpisode == BeiLiErEnum.HardGameId then
			self:_onEndLessFinish()
		else
			for k, episodeItem in ipairs(self._episodeItems) do
				if episodeItem.id == newEpisode then
					self._finishEpisodeIndex = k

					episodeItem:playFinish()
					episodeItem:playStarAnim()
					TaskDispatcher.runDelay(self._finishStoryEnd, self, 1.5)

					break
				end
			end
		end

		BeiLiErModel.instance:clearFinishEpisode()
	end
end

function BeiLiErLevelView:_onEndLessFinish()
	local ispass = BeiLiErModel.instance:isEpisodePass(self.lastCo.episodeId)

	gohelper.setActive(self._goendlessnostar, not ispass)
	gohelper.setActive(self._goendlessstar, ispass)
	self._animEndless:Play("finish", 0, 0)
end

function BeiLiErLevelView:_finishStoryEnd()
	if self._finishEpisodeIndex == #self._episodeItems then
		self._curEpisodeIndex = self._finishEpisodeIndex
		self._finishEpisodeIndex = nil

		self:chekcShowHardNode()
		self._animPath:Play("movesp", 0, 0)
		AudioMgr.instance:trigger(AudioEnum3_2.BeiLiEr.play_ui_shengyan_beilier_open_sp)
	else
		self._curEpisodeIndex = self._finishEpisodeIndex + 1

		local animname = "move" .. self._finishEpisodeIndex + 1

		self._animPath:Play(animname, 0, 0)
		AudioMgr.instance:trigger(AudioEnum3_2.BeiLiEr.play_ui_shengyan_beilier_open_1)
		self:_onScreenSizeChange()
		TaskDispatcher.runDelay(self._unlockStory, self, 0.5)
	end
end

function BeiLiErLevelView:chekcShowHardNode()
	local isPassBeforeLast = BeiLiErModel.instance:isEpisodePass(self._beforeLastEpisodeId)

	gohelper.setActive(self._goEndless, isPassBeforeLast)

	if isPassBeforeLast and GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.BeiLiErLevelViewHardAnim, 0) == 0 then
		GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.BeiLiErLevelViewHardAnim, 1)
		self._animEndless:Play("unlock", 0, 0)
		AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.play_ui_lushang_level_appear)
	end
end

function BeiLiErLevelView:_unlockStory()
	TaskDispatcher.cancelTask(self._unlockStory, self)
	self._episodeItems[self._finishEpisodeIndex + 1]:refreshUI()
	self._episodeItems[self._finishEpisodeIndex + 1]:playUnlock()
	self:_focusStoryItem(self._finishEpisodeIndex + 1, true)
	TaskDispatcher.runDelay(self._unlockLvEnd, self, 1.5)
end

function BeiLiErLevelView:_unlockLvEnd()
	self._finishEpisodeIndex = nil
end

function BeiLiErLevelView:onClose()
	TaskDispatcher.cancelTask(self._refreshLeftTime, self)
	TaskDispatcher.cancelTask(self._playStoryFinishAnim, self)
	TaskDispatcher.cancelTask(self._finishStoryEnd, self)
	TaskDispatcher.cancelTask(self._unlockLvEnd, self)
	TaskDispatcher.cancelTask(self._unlockStory, self)
end

function BeiLiErLevelView:onDestroyView()
	self:_removeEvents()

	self._episodeItems = nil

	TaskDispatcher.cancelTask(self._refreshLeftTime, self)
end

function BeiLiErLevelView:_onCloseView(viewName)
	if viewName == ViewName.BeiLiErGameView then
		gohelper.setActive(self.viewGO, true)
	elseif viewName == ViewName.BeiLiErTaskView then
		self:_onCloseTask()
	end
end

return BeiLiErLevelView
