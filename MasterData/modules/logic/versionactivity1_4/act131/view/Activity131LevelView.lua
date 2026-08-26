-- chunkname: @modules/logic/versionactivity1_4/act131/view/Activity131LevelView.lua

module("modules.logic.versionactivity1_4.act131.view.Activity131LevelView", package.seeall)

local Activity131LevelView = class("Activity131LevelView", BaseView)

function Activity131LevelView:onInitView()
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "#simage_mask")
	self._gopath = gohelper.findChild(self.viewGO, "#go_path")
	self._goscrollcontent = gohelper.findChild(self.viewGO, "#go_path/#go_scrollcontent")
	self._gostages = gohelper.findChild(self.viewGO, "#go_path/#go_scrollcontent/#go_stages")
	self._gotitle = gohelper.findChild(self.viewGO, "#go_title")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#go_title/#simage_title")
	self._gotime = gohelper.findChild(self.viewGO, "#go_title/#go_time")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_task", 25001038)
	self._gotaskani = gohelper.findChild(self.viewGO, "#btn_task/ani")
	self._goreddotreward = gohelper.findChild(self.viewGO, "#btn_task/#go_reddotreward")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._goexcessive = gohelper.findChild(self.viewGO, "#go_excessive")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity131LevelView:addEvents()
	self._btntask:AddClickListener(self._btntaskOnClick, self)
end

function Activity131LevelView:removeEvents()
	self._btntask:RemoveClickListener()
end

function Activity131LevelView:_btntaskOnClick()
	Activity131Controller.instance:openActivity131TaskView()
end

function Activity131LevelView:_editableInitView()
	self._viewAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self._simagemask:LoadImage(ResUrl.getV1a4Role37SingleBg("v1a4_role37_igfullmask"))

	local gopath2 = gohelper.findChild(self.viewGO, "#go_path/#go_scrollcontent/path/path_2")

	self._pathAnimator = gopath2:GetComponent(typeof(UnityEngine.Animator))
	self._taskAnimator = self._gotaskani:GetComponent(typeof(UnityEngine.Animator))
end

function Activity131LevelView:onUpdateParam()
	return
end

function Activity131LevelView:onOpen()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_4Enum.ActivityId.Role6)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_4Enum.ActivityId.Role6
	})
	RedDotController.instance:addRedDot(self._goreddotreward, RedDotEnum.DotNode.Activity1_4Role6Task)

	local maxEpisode = Activity131Model.instance:getMaxUnlockEpisode()

	if maxEpisode == 1 then
		self._pathAnimator:Play("go1", 0, 0)

		self._pathAnimator.speed = 0
	end

	self:_initStages()
	self:_addEvents()
	self:_backToLevelView()
	self:_refreshTask()
end

function Activity131LevelView:_refreshTask()
	local hasRewards = RedDotModel.instance:isDotShow(RedDotEnum.DotNode.Activity1_4Role6Task, 0)

	if hasRewards then
		self._taskAnimator:Play("loop", 0, 0)
	else
		self._taskAnimator:Play("idle", 0, 0)
	end
end

function Activity131LevelView:_initStages()
	if self._stageItemList then
		return
	end

	local prefabPath = self.viewContainer:getSetting().otherRes[1]

	self._stageItemList = {}

	local levelCount = Activity131Model.instance:getMaxEpisode()

	for i = 1, levelCount do
		local stageGo = gohelper.findChild(self._gostages, "stage" .. i)
		local cloneGo = self:getResInst(prefabPath, stageGo)
		local stageItem = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, Activity131LevelViewStageItem, self)
		local actId = VersionActivity1_4Enum.ActivityId.Role6
		local co = Activity131Config.instance:getActivity131EpisodeCo(actId, i)

		stageItem:refreshItem(co, i)
		table.insert(self._stageItemList, stageItem)
	end
end

function Activity131LevelView:_refreshStageItem(playAnim, episodeId)
	for i = 1, #self._stageItemList do
		local actId = VersionActivity1_4Enum.ActivityId.Role6
		local co = Activity131Config.instance:getActivity131EpisodeCo(actId, i)

		self._stageItemList[i]:refreshItem(co, i)
	end
end

function Activity131LevelView:_refreshUI()
	local episodeId = Activity131Model.instance:getMaxUnlockEpisode()
	local newEpisode = Activity131Model.instance:getNewUnlockEpisode()

	if newEpisode > -1 then
		episodeId = newEpisode
	end

	if episodeId == 1 then
		self._pathAnimator.speed = 0

		self._pathAnimator:Play("go1", 0, 0)
	else
		self._pathAnimator.speed = 1

		self._pathAnimator:Play("go" .. episodeId - 1, 0, 1)
	end

	Activity131Model.instance:setNewUnlockEpisode(-1)
	self:_refreshStageItem()
end

function Activity131LevelView:onClose()
	self:_removeEvents()
end

function Activity131LevelView:_onDragBegin(param, pointerEventData)
	self._initDragPos = pointerEventData.position.x
end

function Activity131LevelView:_onDrag(param, pointerEventData)
	local curSpineRootPosX = recthelper.getAnchorX(self._goscrollcontent.transform)

	curSpineRootPosX = curSpineRootPosX + pointerEventData.delta.x * Activity131Enum.SlideSpeed
	curSpineRootPosX = curSpineRootPosX > 0 and 0 or curSpineRootPosX
	curSpineRootPosX = curSpineRootPosX > -Activity131Enum.MaxSlideX and curSpineRootPosX or -Activity131Enum.MaxSlideX

	recthelper.setAnchorX(self._goscrollcontent.transform, curSpineRootPosX)

	local scenePos = curSpineRootPosX * Activity131Enum.SceneMaxX / Activity131Enum.MaxSlideX

	Activity131Controller.instance:dispatchEvent(Activity131Event.SetScenePos, scenePos)
end

function Activity131LevelView:_onDragEnd(param, pointerEventData)
	return
end

function Activity131LevelView:_checkLevelUpdate()
	local episodeId = Activity131Model.instance:getCurEpisodeId()
	local state = Activity131Model.instance:getEpisodeState(episodeId)
	local isEpisodeFinished = Activity131Model.instance:isEpisodeFinished(episodeId)
	local maxEpisode = Activity131Model.instance:getMaxEpisode()

	if episodeId < maxEpisode then
		if not (episodeId + 1) then
			local nextEpisode = episodeId
			local isNextEpisodeUnlock = Activity131Model.instance:isEpisodeUnlock(nextEpisode)

			if not isEpisodeFinished then
				return
			end

			if isNextEpisodeUnlock and nextEpisode ~= episodeId then
				return
			end

			Activity131Model.instance:setNewFinishEpisode(episodeId)

			local newUnlockEpisode = nextEpisode == episodeId and -1 or nextEpisode

			Activity131Model.instance:setNewUnlockEpisode(newUnlockEpisode)

			local activityId = VersionActivity1_4Enum.ActivityId.Role6

			Activity131Rpc.instance:sendGet131InfosRequest(activityId, self._getInfoSuccess, self)
		end
	end
end

function Activity131LevelView:_getInfoSuccess(cmd, resultCode)
	if resultCode ~= 0 then
		return
	end

	Activity131Controller.instance:dispatchEvent(Activity131Event.NewEpisodeUnlock)
	self:_backToLevelView()
end

function Activity131LevelView:_setToPos()
	self:_onSlideFinish()
end

function Activity131LevelView:_onSlideFinish()
	local episodeId = Activity131Model.instance:getCurEpisodeId()
	local newEpisode = Activity131Model.instance:getNewUnlockEpisode()

	if newEpisode > -1 then
		episodeId = newEpisode
	end

	local index = episodeId and episodeId or 1

	if index < Activity131Enum.MaxShowEpisodeCount + 1 then
		return
	end

	local totalEpisodes = Activity131Model.instance:getTotalEpisodeCount()
	local pos = (index - Activity131Enum.MaxShowEpisodeCount) * Activity131Enum.MaxSlideX / (totalEpisodes - Activity131Enum.MaxShowEpisodeCount)

	pos = pos > Activity131Enum.MaxSlideX and Activity131Enum.MaxSlideX or pos

	transformhelper.setLocalPos(self._goscrollcontent.transform, -pos, 0, 0)

	local scenePos = -pos * Activity131Enum.SceneMaxX / Activity131Enum.MaxSlideX

	Activity131Controller.instance:dispatchEvent(Activity131Event.SetScenePos, scenePos)
end

function Activity131LevelView:_backToLevelView()
	StoryController.instance:closeStoryView()
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("newepisode")
	self._viewAnimator:Play("open", 0, 0)

	local newEpisode = Activity131Model.instance:getNewFinishEpisode()
	local episodeId = Activity131Model.instance:getCurEpisodeId()

	if newEpisode > -1 then
		episodeId = newEpisode

		if newEpisode == 1 then
			self._pathAnimator.speed = 0

			self._pathAnimator:Play("go1", 0, 0)
		else
			self._pathAnimator.speed = 1

			self._pathAnimator:Play("go" .. newEpisode - 1, 0, 1)
		end
	else
		local maxEpisode = Activity131Model.instance:getMaxUnlockEpisode()

		self._pathAnimator.speed = 1

		self._pathAnimator:Play("go" .. maxEpisode - 1, 0, 1)
	end

	self:_setToPos()
	TaskDispatcher.runDelay(self._checkNewFinishEpisode, self, 1)
end

function Activity131LevelView:_checkNewFinishEpisode()
	local newEpisode = Activity131Model.instance:getNewFinishEpisode()

	if newEpisode > -1 then
		Activity131Controller.instance:dispatchEvent(Activity131Event.playNewFinishEpisode, newEpisode)
		Activity131Model.instance:setNewFinishEpisode(-1)
		TaskDispatcher.runDelay(self._checkNewUnlockEpisode, self, 1.5)
	else
		self:_checkNewUnlockEpisode()
	end
end

function Activity131LevelView:_checkNewUnlockEpisode()
	local newEpisode = Activity131Model.instance:getNewUnlockEpisode()

	if newEpisode > -1 then
		self._pathAnimator.speed = 1

		self._pathAnimator:Play("go" .. newEpisode - 1, 0, 0)
		TaskDispatcher.runDelay(self._startShowUnlock, self, 0.34)
	else
		self:_startShowUnlock()
	end
end

function Activity131LevelView:_startShowUnlock()
	UIBlockMgr.instance:endBlock("newepisode")

	local newEpisode = Activity131Model.instance:getNewUnlockEpisode()

	if newEpisode > -1 then
		Activity131Controller.instance:dispatchEvent(Activity131Event.playNewUnlockEpisode, newEpisode)
		TaskDispatcher.runDelay(self._showUnlockFinished, self, 0.67)
	else
		self:_showUnlockFinished()
	end
end

function Activity131LevelView:_showUnlockFinished()
	local newEpisode = Activity131Model.instance:getNewUnlockEpisode()

	if newEpisode > -1 then
		Activity131Controller.instance:dispatchEvent(Activity131Event.PlayChessAutoToNewEpisode, newEpisode)
	end

	self:_refreshUI()
end

function Activity131LevelView:_enterGameView()
	self._viewAnimator:Play("close", 0, 0)
	TaskDispatcher.runDelay(self._realEnterGameView, self, 0.34)
end

function Activity131LevelView:_realEnterGameView()
	local param = {}

	param.episodeId = Activity131Model.instance:getCurEpisodeId()

	Activity131Controller.instance:openActivity131GameView(param)
end

function Activity131LevelView:_playCloseLevelView()
	self._viewAnimator:Play("close", 0, 0)
end

function Activity131LevelView:_addEvents()
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._gopath.gameObject)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self._drag:AddDragListener(self._onDrag, self)
	self.addEventCb(self, Activity131Controller.instance, Activity131Event.OnDialogMarkSuccess, self._checkLevelUpdate, self)
	self.addEventCb(self, Activity131Controller.instance, Activity131Event.OnGeneralGameSuccess, self._checkLevelUpdate, self)
	self.addEventCb(self, Activity131Controller.instance, Activity131Event.OnStoryFinishedSuccess, self._checkLevelUpdate, self)
	self.addEventCb(self, Activity131Controller.instance, Activity131Event.BackToLevelView, self._backToLevelView, self)
	self.addEventCb(self, Activity131Controller.instance, Activity131Event.StartEnterGameView, self._enterGameView, self)
	self.addEventCb(self, Activity131Controller.instance, Activity131Event.PlayLeaveLevelView, self._playCloseLevelView, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._refreshTask, self)
end

function Activity131LevelView:_removeEvents()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragListener()
	self._drag:RemoveDragEndListener()
	self.removeEventCb(self, Activity131Controller.instance, Activity131Event.OnDialogMarkSuccess, self._checkLevelUpdate, self)
	self.removeEventCb(self, Activity131Controller.instance, Activity131Event.OnGeneralGameSuccess, self._checkLevelUpdate, self)
	self.removeEventCb(self, Activity131Controller.instance, Activity131Event.OnStoryFinishedSuccess, self._checkLevelUpdate, self)
	self.removeEventCb(self, Activity131Controller.instance, Activity131Event.BackToLevelView, self._backToLevelView, self)
	self.removeEventCb(self, Activity131Controller.instance, Activity131Event.StartEnterGameView, self._enterGameView, self)
	self.removeEventCb(self, Activity131Controller.instance, Activity131Event.PlayLeaveLevelView, self._playCloseLevelView, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._refreshTask, self)
end

function Activity131LevelView:onDestroyView()
	if self._stageItemList then
		for _, stageItem in ipairs(self._stageItemList) do
			stageItem:onDestroyView()
		end

		self._stageItemList = nil
	end

	TaskDispatcher.cancelTask(self._showUnlockFinished, self)
	self._simagemask:UnLoadImage()
end

return Activity131LevelView
