-- chunkname: @modules/logic/versionactivity2_6/dicehero/view/DiceHeroMainView.lua

module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroMainView", package.seeall)

local DiceHeroMainView = class("DiceHeroMainView", BaseView)

function DiceHeroMainView:onInitView()
	self._btnTask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Task")
	self._gotaskred = gohelper.findChild(self.viewGO, "#btn_Task/#go_reddot")
	self._taskAnimator = gohelper.findChildAnim(self.viewGO, "#btn_Task/ani")
	self._btnTrial = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Try/#btn_Trial")
	self._goTrial = gohelper.findChild(self.viewGO, "#go_Try")

	for i = 1, 5 do
		self["_btnstage" .. i] = gohelper.findChildButton(self.viewGO, "#btn_stage" .. i)
		self["_lockAnim" .. i] = gohelper.findChildAnim(self.viewGO, "#btn_stage" .. i .. "/lock")
	end

	self._lockAnim5 = gohelper.findChildAnim(self.viewGO, "#btn_stage5")
end

function DiceHeroMainView:addEvents()
	self._btnTask:AddClickListener(self._onClickTask, self)

	for i = 1, 5 do
		self["_btnstage" .. i]:AddClickListener(self._onClickStage, self, i)
	end

	self._btnTrial:AddClickListener(self._btnTrialOnClick, self)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.InfoUpdate, self._onInfoUpdate, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, self._refreshTask, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onRefreshActivityState, self)
end

function DiceHeroMainView:removeEvents()
	self._btnTask:RemoveClickListener()

	for i = 1, 5 do
		self["_btnstage" .. i]:RemoveClickListener()
	end

	self._btnTrial:RemoveClickListener()
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.InfoUpdate, self._onInfoUpdate, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, self._refreshTask, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onRefreshActivityState, self)
end

function DiceHeroMainView:_clickLock()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.config.openId)

	if toastId and toastId ~= 0 then
		GameFacade.showToastWithTableParam(toastId, toastParamList)
	end
end

function DiceHeroMainView:_btnTrialOnClick()
	if ActivityHelper.isOpen(self.activityId) then
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

function DiceHeroMainView:onOpen()
	self:_refreshTask()

	self.activityId = VersionActivity2_6Enum.ActivityId.DiceHero
	self.config = ActivityConfig.instance:getActivityCo(self.activityId)
	DiceHeroModel.instance.isUnlockNewChapter = false

	RedDotController.instance:addRedDot(self._gotaskred, RedDotEnum.DotNode.V2a6DiceHero)
	self:_onInfoUpdate()
	self:_refreshTryBtn()
end

function DiceHeroMainView:_refreshTask()
	local hasRewards = RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V2a6DiceHero, 0)

	if hasRewards then
		self._taskAnimator:Play("loop", 0, 0)
	else
		self._taskAnimator:Play("idle", 0, 0)
	end
end

function DiceHeroMainView:_onClickTask()
	ViewMgr.instance:openView(ViewName.DiceHeroTaskView)
end

function DiceHeroMainView:_onCloseViewFinish(viewName)
	if viewName == ViewName.DiceHeroLevelView and DiceHeroModel.instance.isUnlockNewChapter then
		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_unclockchapter)

		DiceHeroModel.instance.isUnlockNewChapter = false

		self:_onInfoUpdate()
		UIBlockHelper.instance:startBlock("DiceHeroMainView_PlayUnlock", 1.5)

		local lastUnlockChapter = #DiceHeroModel.instance.unlockChapterIds

		if lastUnlockChapter == 5 then
			self._lockAnim5:Play("open", 0, 0)
		else
			gohelper.setActive(self["_lockAnim" .. lastUnlockChapter], true)
			self["_lockAnim" .. lastUnlockChapter]:Play("unlock", 0, 0)
		end

		TaskDispatcher.runDelay(self._delayRefreshAnim, self, 1.5)
	end
end

function DiceHeroMainView:_delayRefreshAnim()
	local lastUnlockChapter = #DiceHeroModel.instance.unlockChapterIds

	if lastUnlockChapter == 5 then
		self._lockAnim5:Play("loop", 0, 0)
	else
		gohelper.setActive(self["_lockAnim" .. lastUnlockChapter], false)
	end
end

function DiceHeroMainView:_onInfoUpdate()
	if DiceHeroModel.instance.isUnlockNewChapter then
		return
	end

	local unlockChapterIds = DiceHeroModel.instance.unlockChapterIds

	for i = 1, 5 do
		local gameInfo = DiceHeroModel.instance:getGameInfo(i)
		local go = self["_btnstage" .. i].gameObject
		local normal = gohelper.findChild(go, "normal")
		local lock = gohelper.findChild(go, "lock")
		local challenge = gohelper.findChild(go, "challenge")
		local name = gohelper.findChildTextMesh(go, "Name/#txt_name") or gohelper.findChildTextMesh(go, "#txt_name")
		local nameRoot = gohelper.findChild(go, "Name")

		gohelper.setActive(normal, unlockChapterIds[i] and gameInfo.allPass)
		gohelper.setActive(lock, not unlockChapterIds[i])
		gohelper.setActive(nameRoot, unlockChapterIds[i])
		gohelper.setActive(challenge, unlockChapterIds[i] and not gameInfo.allPass)

		if i == 5 then
			gohelper.setActive(go, unlockChapterIds[i])
		end

		local co = DiceHeroConfig.instance:getLevelCo(i, 1)

		if co and name then
			name.text = GameUtil.setFirstStrSize(co.chapterName, 70)
		end
	end
end

function DiceHeroMainView:_onClickStage(index)
	local unlockChapterIds = DiceHeroModel.instance.unlockChapterIds

	if not unlockChapterIds[index] then
		GameFacade.showToast(ToastEnum.DiceHeroLockChapter)

		return
	end

	self._enterChapterId = index

	self:_enterChapter()
end

function DiceHeroMainView:_enterChapter()
	if not self._enterChapterId then
		return
	end

	local co = DiceHeroConfig.instance:getLevelCo(self._enterChapterId, 1)

	if not co then
		return
	end

	ViewMgr.instance:openView(ViewName.DiceHeroLevelView, {
		chapterId = self._enterChapterId,
		isInfinite = co.mode == 2
	})
end

function DiceHeroMainView:onDestroyView()
	TaskDispatcher.cancelTask(self._delayRefreshAnim, self)
end

function DiceHeroMainView:_onRefreshActivityState(actId)
	self:_refreshTryBtn()
end

function DiceHeroMainView:_refreshTryBtn()
	local isOpen = self:_isOpenAct()

	gohelper.setActive(self._goTrial, isOpen)
end

function DiceHeroMainView:_isOpenAct()
	if not ActivityHelper.isOpen(self.activityId) then
		return false
	end

	local permanentActId = VersionActivity2_6Enum.ActivityId.EnterView
	local actInfo = ActivityModel.instance:getActMO(permanentActId)

	if not actInfo then
		return false
	end

	if not actInfo:isPermanentUnlock() then
		return false
	end

	return true
end

return DiceHeroMainView
