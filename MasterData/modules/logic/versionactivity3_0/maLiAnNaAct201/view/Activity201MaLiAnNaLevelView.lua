-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/view/Activity201MaLiAnNaLevelView.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.Activity201MaLiAnNaLevelView", package.seeall)

local Activity201MaLiAnNaLevelView = class("Activity201MaLiAnNaLevelView", BaseView)

Activity201MaLiAnNaLevelView.HardId = 1301111
Activity201MaLiAnNaLevelView.TaskId = 610011

function Activity201MaLiAnNaLevelView:onInitView()
	self._gopath = gohelper.findChild(self.viewGO, "#go_path")
	self._goscrollcontent = gohelper.findChild(self.viewGO, "#go_path/#go_scrollcontent")
	self._golineroot = gohelper.findChild(self.viewGO, "#go_path/#go_scrollcontent/path")
	self._gostages = gohelper.findChild(self.viewGO, "#go_path/#go_scrollcontent/#go_stages")
	self._gotitle = gohelper.findChild(self.viewGO, "#go_title")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#go_title/#simage_title")
	self._txtLimitTimeContainer = gohelper.findChild(self.viewGO, "#go_title/image_LimitTimeBG")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "#go_title/image_LimitTimeBG/#txt_LimitTime")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_task")
	self._btnEndless = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Endless")
	self._goreddotreward = gohelper.findChild(self.viewGO, "#btn_task/#go_reddotreward")
	self._gotaskani = gohelper.findChild(self.viewGO, "#btn_task/ani")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._animEndless = self._btnEndless.gameObject:GetComponent(typeof(UnityEngine.Animator))
	self._animTask = self._gotaskani:GetComponent(typeof(UnityEngine.Animator))
	self._btnTrial = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Try/#btn_Trial")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity201MaLiAnNaLevelView:addEvents()
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self._btnEndless:AddClickListener(self._btnEndlessOnClick, self)
	self.addEventCb(self, Activity201MaLiAnNaController.instance, Activity201MaLiAnNaEvent.EpisodeFinished, self._onEpisodeFinished, self)
	self.addEventCb(self, Activity201MaLiAnNaController.instance, Activity201MaLiAnNaEvent.OnBackToLevel, self._onBackToLevel, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self._btnTrial:AddClickListener(self._btnTrialOnClick, self)
end

function Activity201MaLiAnNaLevelView:removeEvents()
	self._btntask:RemoveClickListener()
	self._btnEndless:RemoveClickListener()
	self.removeEventCb(self, Activity201MaLiAnNaController.instance, Activity201MaLiAnNaEvent.EpisodeFinished, self._onEpisodeFinished, self)
	self.removeEventCb(self, Activity201MaLiAnNaController.instance, Activity201MaLiAnNaEvent.OnBackToLevel, self._onBackToLevel, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self._btnTrial:RemoveClickListener()
end

function Activity201MaLiAnNaLevelView:_btnTrialOnClick()
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

function Activity201MaLiAnNaLevelView:_clickLock()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.actConfig.openId)

	if toastId and toastId ~= 0 then
		GameFacade.showToastWithTableParam(toastId, toastParamList)
	end
end

function Activity201MaLiAnNaLevelView:_btntaskOnClick()
	ViewMgr.instance:openView(ViewName.Activity201MaLiAnNaTaskView)
end

function Activity201MaLiAnNaLevelView:_btnEndlessOnClick()
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

function Activity201MaLiAnNaLevelView:_enterGame()
	Activity201MaLiAnNaGameController.instance:enterGame(self.lastCo.gameId, self.lastCo.episodeId)

	if self.lastCo.episodeId == Activity201MaLiAnNaLevelView.HardId then
		TaskRpc.instance:sendFinishReadTaskRequest(Activity201MaLiAnNaLevelView.TaskId)
	end
end

function Activity201MaLiAnNaLevelView:_onGameFinished()
	Activity201MaLiAnNaController.instance:_onGameFinished(self.actId, self.lastCo.episodeId)
end

function Activity201MaLiAnNaLevelView:_refreshTask()
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V3a0MaLiAnNaTask, 0) then
		self._animTask:Play("loop")
	else
		self._animTask:Play("idle")
	end
end

function Activity201MaLiAnNaLevelView:_onCloseTask()
	self:_refreshTask()
end

function Activity201MaLiAnNaLevelView:_removeEvents()
	return
end

function Activity201MaLiAnNaLevelView:_editableInitView()
	self.actId = VersionActivity3_0Enum.ActivityId.MaLiAnNa
	self.actConfig = ActivityConfig.instance:getActivityCo(self.actId)
	self._viewAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	RedDotController.instance:addRedDot(self._goreddotreward, RedDotEnum.DotNode.V3a0MaLiAnNaTask)
	gohelper.setActive(self._txtLimitTimeContainer, false)
end

function Activity201MaLiAnNaLevelView:onOpen()
	self:_initLevelItems()
	self:_refreshLeftTime()
	self:_refreshTask()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
end

function Activity201MaLiAnNaLevelView:_refreshLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function Activity201MaLiAnNaLevelView:_initLevelItems()
	local path = self.viewContainer:getSetting().otherRes[1]

	self._episodeItems = {}

	local episodeCos = Activity201MaLiAnNaConfig.instance:getEpisodeCoList(self.actId)

	self._lastIndex = #episodeCos
	self._beforeLastEpisodeId = episodeCos[#episodeCos - 1].episodeId
	self.lastCo = episodeCos[#episodeCos]

	self:chekcShowHardNode()

	local maxUnlockEpisode = Activity201MaLiAnNaModel.instance:getMaxUnlockEpisodeId()

	self._curEpisodeIndex = Activity201MaLiAnNaModel.instance:getEpisodeIndex(maxUnlockEpisode)

	Activity201MaLiAnNaModel.instance:setCurEpisode(self._curEpisodeIndex, maxUnlockEpisode)

	for i = 1, #episodeCos - 1 do
		local nodeRoot = gohelper.findChild(self._gostages, "stage" .. i)
		local cloneGo = self:getResInst(path, nodeRoot)

		self._episodeItems[i] = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, Activity201MaLiAnNaLevelItem, self)

		self._episodeItems[i]:setParam(episodeCos[i], i, self.actId)
	end
end

function Activity201MaLiAnNaLevelView:_onBackToLevel()
	local newEpisode = Activity201MaLiAnNaModel.instance:getNewFinishEpisode()

	if newEpisode and newEpisode ~= 0 then
		local maxUnlockEpisode = Activity201MaLiAnNaModel.instance:getMaxUnlockEpisodeId()

		self._curEpisodeIndex = Activity201MaLiAnNaModel.instance:getEpisodeIndex(maxUnlockEpisode)

		Activity201MaLiAnNaModel.instance:setCurEpisode(self._curEpisodeIndex, maxUnlockEpisode)
	end

	self:_refreshTask()
	Activity201MaLiAnNaController.instance:startBurnAudio()
end

function Activity201MaLiAnNaLevelView:_onEpisodeFinished()
	local newEpisode = Activity201MaLiAnNaModel.instance:getNewFinishEpisode()

	if newEpisode then
		TaskDispatcher.runDelay(self._playStoryFinishAnim, self, 1)
	end
end

function Activity201MaLiAnNaLevelView:_playStoryFinishAnim()
	TaskDispatcher.cancelTask(self._playStoryFinishAnim, self)

	local newEpisode = Activity201MaLiAnNaModel.instance:getNewFinishEpisode()

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

		Activity201MaLiAnNaModel.instance:clearFinishEpisode()
	end
end

function Activity201MaLiAnNaLevelView:_finishStoryEnd()
	if self._finishEpisodeIndex == #self._episodeItems then
		self._curEpisodeIndex = self._finishEpisodeIndex
		self._finishEpisodeIndex = nil

		self:chekcShowHardNode()
	else
		self._curEpisodeIndex = self._finishEpisodeIndex + 1

		self:_unlockStory()
	end
end

function Activity201MaLiAnNaLevelView:_unlockStory()
	self._episodeItems[self._finishEpisodeIndex + 1]:refreshUI()
	self._episodeItems[self._finishEpisodeIndex + 1]:playUnlock()
	TaskDispatcher.runDelay(self._unlockLvEnd, self, 1.5)
end

function Activity201MaLiAnNaLevelView:_unlockLvEnd()
	self._finishEpisodeIndex = nil
end

function Activity201MaLiAnNaLevelView:chekcShowHardNode()
	local isPassBeforeLast = Activity201MaLiAnNaModel.instance:isEpisodePass(self._beforeLastEpisodeId)

	gohelper.setActive(self._btnEndless.gameObject, isPassBeforeLast)

	if isPassBeforeLast and GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.Activity201MaLiAnNaLevelViewHardAnim, 0) == 0 then
		GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.Activity201MaLiAnNaLevelViewHardAnim, 1)
		self._animEndless:Play("open")
		AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.play_ui_lushang_level_appear)
	else
		self._animEndless:Play("idle")
	end
end

function Activity201MaLiAnNaLevelView:onClose()
	TaskDispatcher.cancelTask(self._refreshLeftTime, self)
	TaskDispatcher.cancelTask(self._playStoryFinishAnim, self)
	TaskDispatcher.cancelTask(self._finishStoryEnd, self)
	TaskDispatcher.cancelTask(self._unlockLvEnd, self)
end

function Activity201MaLiAnNaLevelView:onDestroyView()
	self:_removeEvents()

	self._episodeItems = nil

	TaskDispatcher.cancelTask(self._refreshLeftTime, self)
end

function Activity201MaLiAnNaLevelView:_onCloseView(viewName)
	if viewName == ViewName.Activity201MaLiAnNaGameView then
		gohelper.setActive(self.viewGO, true)
	elseif viewName == ViewName.Activity201MaLiAnNaTaskView then
		self:_onCloseTask()
	end
end

function Activity201MaLiAnNaLevelView:_onOpenView(viewName)
	if viewName == ViewName.MaLiAnNaNoticeView then
		gohelper.setActive(self.viewGO, false)
	end
end

return Activity201MaLiAnNaLevelView
