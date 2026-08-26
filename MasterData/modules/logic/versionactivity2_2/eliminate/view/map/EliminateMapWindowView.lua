-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/map/EliminateMapWindowView.lua

module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateMapWindowView", package.seeall)

local EliminateMapWindowView = class("EliminateMapWindowView", BaseView)

function EliminateMapWindowView:onInitView()
	self._goselect = gohelper.findChild(self.viewGO, "window/bottom/node1/#go_select")
	self._txtindex = gohelper.findChildText(self.viewGO, "window/bottom/node1/info/#txt_nodename/#txt_index")
	self._txtnodenameen = gohelper.findChildText(self.viewGO, "window/bottom/node1/info/#txt_nodename/#txt_nodename_en")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "window/title/#simage_title")
	self._txttime = gohelper.findChildText(self.viewGO, "window/title/#txt_time")

	gohelper.setActive(self._txttime, false)

	self._simagebottom = gohelper.findChildSingleImage(self.viewGO, "window/bottom/#simage_bottom")
	self._goleft = gohelper.findChild(self.viewGO, "#go_left")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EliminateMapWindowView:addEvents()
	return
end

function EliminateMapWindowView:removeEvents()
	return
end

EliminateMapWindowView.UnlockKey = "EliminateMapWindowViewUnlockKey"

function EliminateMapWindowView:onRewardClick()
	ViewMgr.instance:openView(ViewName.EliminateTaskView)
end

function EliminateMapWindowView:_editableInitView()
	self._goexcessive = gohelper.findChild(self.viewGO, "excessive")

	local aniGo = gohelper.findChild(self.viewGO, "window/righttop/reward/ani")

	self._rewardAnimator = aniGo:GetComponent("Animator")
	self.rewardClick = gohelper.findChildClick(self.viewGO, "window/righttop/reward/clickArea")

	self.rewardClick:AddClickListener(self.onRewardClick, self)
	EliminateTaskListModel.instance:initTask()
	EliminateTaskListModel.instance:sortTaskMoList()

	self.goRedDot = gohelper.findChild(self.viewGO, "window/righttop/reward/reddot")
	self._redDotComp = RedDotController.instance:addNotEventRedDot(self.goRedDot, self._isShowRedDot, self)
	self.chapterNodeList = {}
	self.chapterAnimatorList = self:getUserDataTb_()

	for i = 1, EliminateMapModel.getChapterNum() do
		local nodeTab = self:getUserDataTb_()

		nodeTab.index = i
		nodeTab.go = gohelper.findChild(self.viewGO, "window/bottom/node" .. i)
		nodeTab.goSelect = gohelper.findChild(nodeTab.go, "#go_unlock/#go_select")
		nodeTab.goUnSelect = gohelper.findChild(nodeTab.go, "#go_unlock/#go_unselect")
		nodeTab.goLock = gohelper.findChild(nodeTab.go, "#go_lock")
		nodeTab.goUnLock = gohelper.findChild(nodeTab.go, "#go_unlock")
		nodeTab.goUnLockCanvasGroup = nodeTab.goUnLock:GetComponent(typeof(UnityEngine.CanvasGroup))
		nodeTab.click = gohelper.findChildClick(nodeTab.go, "clickarea")

		nodeTab.click:AddClickListener(self.onClickChapterItem, self, nodeTab)
		table.insert(self.chapterAnimatorList, nodeTab.goLock:GetComponent(typeof(UnityEngine.Animator)))
		table.insert(self.chapterNodeList, nodeTab)
	end

	self.addEventCb(self, EliminateMapController.instance, EliminateMapEvent.OnSelectChapterChange, self.onSelectChapterChange, self)
	self.addEventCb(self, EliminateMapController.instance, EliminateMapEvent.OnUpdateEpisodeInfo, self.onUpdateEpisodeInfo, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self, LuaEventSystem.Low)
	self.addEventCb(self, EliminateMapController.instance, EliminateMapEvent.UpdateTask, self._updateTaskHandler, self, LuaEventSystem.Low)
end

function EliminateMapWindowView:_isShowRedDot()
	return EliminateTaskListModel.instance:getFinishTaskCount() > 0
end

function EliminateMapWindowView:_updateTaskHandler()
	EliminateTaskListModel.instance:initTask()
	EliminateTaskListModel.instance:sortTaskMoList()

	local num = EliminateTaskListModel.instance:getFinishTaskCount()
	local showEffect = num > 0

	self._rewardAnimator:Play(showEffect and "loop" or "idle")
	self._redDotComp:refreshRedDot()
end

function EliminateMapWindowView:onUpdateParam()
	return
end

function EliminateMapWindowView:onOpen()
	self.lastCanFightChapterId = EliminateMapModel.instance:getLastCanFightChapterId()
	self.chapterCoList = EliminateMapModel.getChapterConfigList()

	self:refreshUI()
	self:_updateTaskHandler()
end

function EliminateMapWindowView:refreshUI()
	self.chapterId = self.viewContainer.chapterId

	self:refreshChapterUI()
end

function EliminateMapWindowView:refreshChapterUI()
	for i, chapterCo in ipairs(self.chapterCoList) do
		self:refreshChapterItem(chapterCo, self.chapterNodeList[i])
	end

	if self:isPlayedChapterUnlockAnimation(self.chapterId) then
		return
	end

	self:playChapterUnlockAnimation(self.chapterId, self.unlockAnimationDone)
end

function EliminateMapWindowView:refreshChapterItem(chapterCo, nodeTab)
	local isSelected = self.chapterId == chapterCo.id

	gohelper.setActive(nodeTab.goSelect, isSelected)
	gohelper.setActive(nodeTab.goUnSelect, not isSelected)

	local isUnlocked = EliminateMapModel.instance:checkChapterIsUnlock(chapterCo.id)

	gohelper.setActive(nodeTab.goLock, not isUnlocked)
	gohelper.setActive(nodeTab.goUnLock, true)

	nodeTab.goUnLockCanvasGroup.alpha = isUnlocked and 1 or 0.5
end

function EliminateMapWindowView:onClickChapterItem(nodeTab)
	local chapterCo = self.chapterCoList[nodeTab.index]

	if self.chapterId == chapterCo.id then
		return
	end

	local chapterStatus = EliminateMapModel.instance:getChapterStatus(chapterCo.id)

	if chapterStatus == EliminateMapEnum.ChapterStatus.notOpen then
		local toastId, paramList = OpenHelper.getToastIdAndParam(chapterCo.openId)

		GameFacade.showToastWithTableParam(toastId, paramList)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_search_clear)

		return
	end

	if chapterStatus == EliminateMapEnum.ChapterStatus.Lock then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_search_clear)
		GameFacade.showToast(ToastEnum.ConditionLock)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_skin_tag)
	self.viewContainer:changeChapterId(chapterCo.id)
end

function EliminateMapWindowView:onSelectChapterChange()
	self:refreshUI()
end

function EliminateMapWindowView:onUpdateEpisodeInfo()
	self:_updateTaskHandler()

	local newLastCanFightChapterId = EliminateMapModel.instance:getLastCanFightChapterId()

	if newLastCanFightChapterId == self.lastCanFightChapterId then
		self.nextChapterId = nil

		return
	end

	if not EliminateMapModel.instance:checkChapterIsUnlock(newLastCanFightChapterId) then
		self.nextChapterId = nil

		return
	end

	self.nextChapterId = newLastCanFightChapterId
	self.lastCanFightChapterId = newLastCanFightChapterId
end

function EliminateMapWindowView:_onCloseViewFinish(viewName)
	if viewName == ViewName.EliminateLevelView and self.nextChapterId then
		UIBlockMgr.instance:startBlock(EliminateMapWindowView.UnlockKey)
		TaskDispatcher.runDelay(self._delayUnlock, self, EliminateMapEnum.MapViewOpenAnimLength)
	end
end

function EliminateMapWindowView:_delayUnlock()
	self:playChapterUnlockAnimation(self.nextChapterId, self.unlockAnimationDoneNeedSwitchChapter)
end

function EliminateMapWindowView:playChapterUnlockAnimation(chapterId, callback)
	if not chapterId then
		UIBlockMgr.instance:endBlock(EliminateMapWindowView.UnlockKey)

		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		UIBlockMgr.instance:endBlock(EliminateMapWindowView.UnlockKey)

		return
	end

	self.nextChapterId = nil

	local nodeTab = self.chapterNodeList[chapterId]

	gohelper.setActive(nodeTab.goLock, true)

	self.playingUnlockAnimationChapterId = chapterId
	self._unlockChapterId = chapterId

	local animator = self.chapterAnimatorList[chapterId]

	if animator then
		UIBlockMgr.instance:startBlock(EliminateMapWindowView.UnlockKey)

		self.unlockCallback = callback

		TaskDispatcher.cancelTask(self._delayUnlockChapter, self)
		TaskDispatcher.runDelay(self._delayUnlockChapter, self, 1)
		TaskDispatcher.runDelay(self.unlockCallback, self, EliminateMapEnum.MapViewChapterUnlockDuration)
		gohelper.setActive(self._goexcessive, false)
		gohelper.setActive(self._goexcessive, true)
	elseif callback then
		callback(self)
	end
end

function EliminateMapWindowView:_delayUnlockChapter()
	local animator = self.chapterAnimatorList[self._unlockChapterId]

	self._unlockChapterId = nil

	if animator then
		gohelper.setActive(animator, true)
		animator:Play(UIAnimationName.Unlock)
	end
end

function EliminateMapWindowView:unlockAnimationDone()
	UIBlockMgr.instance:endBlock(EliminateMapWindowView.UnlockKey)
	self:recordPlayChapterUnlockAnimation(self.playingUnlockAnimationChapterId)

	self.playingUnlockAnimationChapterId = nil
	self.unlockCallback = nil
end

function EliminateMapWindowView:unlockAnimationDoneNeedSwitchChapter()
	local chapterId = self.playingUnlockAnimationChapterId

	self:unlockAnimationDone()
	EliminateMapController.instance:dispatchEvent(EliminateMapEvent.UnlockChapterAnimDone)
	self.viewContainer:changeChapterId(chapterId)
end

function EliminateMapWindowView:initPlayedChapterUnlockAnimationList()
	if self.playedChapterIdList then
		return
	end

	local unlockStr = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EliminateChapterUnlockAnimationKey))

	if string.nilorempty(unlockStr) then
		self.playedChapterIdList = {}
	end

	self.playedChapterIdList = string.splitToNumber(unlockStr, ";")
end

function EliminateMapWindowView:isPlayedChapterUnlockAnimation(chapterId)
	self:initPlayedChapterUnlockAnimationList()

	return true
end

function EliminateMapWindowView:recordPlayChapterUnlockAnimation(chapterId)
	if tabletool.indexOf(self.playedChapterIdList, chapterId) then
		return
	end

	table.insert(self.playedChapterIdList, chapterId)
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EliminateChapterUnlockAnimationKey), table.concat(self.playedChapterIdList, ";"))
end

function EliminateMapWindowView:onClose()
	TaskDispatcher.cancelTask(self._delayUnlockChapter, self)
end

function EliminateMapWindowView:onDestroyView()
	self._simagebottom:UnLoadImage()
	TaskDispatcher.cancelTask(self._delayUnlock, self)

	if self.unlockCallback then
		TaskDispatcher.cancelTask(self.unlockCallback, self)
	end

	self.rewardClick:RemoveClickListener()

	for _, chapterNode in ipairs(self.chapterNodeList) do
		chapterNode.click:RemoveClickListener()
	end
end

return EliminateMapWindowView
