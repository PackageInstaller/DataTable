-- chunkname: @modules/logic/versionactivity1_4/act130/view/Activity130LevelView.lua

module("modules.logic.versionactivity1_4.act130.view.Activity130LevelView", package.seeall)

local Activity130LevelView = class("Activity130LevelView", BaseView)

function Activity130LevelView:onInitView()
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
	self._goblack = gohelper.findChild(self.viewGO, "black")
	self._goexcessive = gohelper.findChild(self.viewGO, "#go_excessive")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity130LevelView:addEvents()
	self._btntask:AddClickListener(self._btntaskOnClick, self)
end

function Activity130LevelView:removeEvents()
	self._btntask:RemoveClickListener()
end

function Activity130LevelView:_btntaskOnClick()
	Activity130Controller.instance:openActivity130TaskView()
end

function Activity130LevelView:_editableInitView()
	self._viewAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self._simagemask:LoadImage(ResUrl.getV1a4Role37SingleBg("v1a4_role37_igfullmask"))

	local gopath2 = gohelper.findChild(self.viewGO, "#go_path/#go_scrollcontent/path/path_2")

	self._pathAnimator = gopath2:GetComponent(typeof(UnityEngine.Animator))
	self._excessAnimator = self._goexcessive:GetComponent(typeof(UnityEngine.Animator))
	self._blackAnimator = self._goblack:GetComponent(typeof(UnityEngine.Animator))
	self._taskAnimator = self._gotaskani:GetComponent(typeof(UnityEngine.Animator))
end

function Activity130LevelView:onUpdateParam()
	return
end

function Activity130LevelView:onOpen()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_4Enum.ActivityId.Role37)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_4Enum.ActivityId.Role37
	})
	RedDotController.instance:addRedDot(self._goreddotreward, RedDotEnum.DotNode.Activity1_4Role37Task)

	local newEpisode = Activity130Model.instance:getNewFinishEpisode()

	if newEpisode == 0 then
		self._pathAnimator:Play("go1", 0, 0)

		self._pathAnimator.speed = 0
	elseif newEpisode < 0 then
		self:_setToPos()
	end

	self:_initStages()
	self:_addEvents()
	self:_backToLevelView(true)
end

function Activity130LevelView:_initStages()
	if self._stageItemList then
		return
	end

	local prefabPath = self.viewContainer:getSetting().otherRes[1]

	self._stageItemList = {}

	local levelCount = Activity130Model.instance:getMaxEpisode()

	for i = 1, 1 + levelCount do
		local stageGo = gohelper.findChild(self._gostages, "stage" .. i)
		local cloneGo = self:getResInst(prefabPath, stageGo)
		local stageItem = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, Activity130LevelViewStageItem, self)
		local actId = VersionActivity1_4Enum.ActivityId.Role37
		local co = Activity130Config.instance:getActivity130EpisodeCo(actId, i - 1)

		stageItem:refreshItem(co, i)
		table.insert(self._stageItemList, stageItem)
	end
end

function Activity130LevelView:_refreshStageItem(playAnim, episodeId)
	for i = 1, #self._stageItemList do
		local actId = VersionActivity1_4Enum.ActivityId.Role37
		local co = Activity130Config.instance:getActivity130EpisodeCo(actId, i - 1)

		self._stageItemList[i]:refreshItem(co, i)
	end
end

function Activity130LevelView:_refreshUI()
	local episodeId = Activity130Model.instance:getMaxUnlockEpisode()
	local newEpisode = Activity130Model.instance:getNewUnlockEpisode()

	if newEpisode > -1 then
		episodeId = newEpisode
	end

	self._pathAnimator.speed = 1

	self._pathAnimator:Play("go" .. episodeId, 0, 1)
	Activity130Model.instance:setNewUnlockEpisode(-1)
	self:_refreshStageItem()
	self:_refreshTask()
end

function Activity130LevelView:_refreshTask()
	local hasRewards = RedDotModel.instance:isDotShow(RedDotEnum.DotNode.Activity1_4Role37Task, 0)

	if hasRewards then
		self._taskAnimator:Play("loop", 0, 0)
	else
		self._taskAnimator:Play("idle", 0, 0)
	end
end

function Activity130LevelView:onClose()
	self:_removeEvents()
end

function Activity130LevelView:_onDragBegin(param, pointerEventData)
	self._initDragPos = pointerEventData.position.x
end

function Activity130LevelView:_onDrag(param, pointerEventData)
	local curSpineRootPosX = recthelper.getAnchorX(self._goscrollcontent.transform)

	curSpineRootPosX = curSpineRootPosX + pointerEventData.delta.x * Activity130Enum.SlideSpeed
	curSpineRootPosX = curSpineRootPosX > 0 and 0 or curSpineRootPosX
	curSpineRootPosX = curSpineRootPosX > -Activity130Enum.MaxSlideX and curSpineRootPosX or -Activity130Enum.MaxSlideX

	recthelper.setAnchorX(self._goscrollcontent.transform, curSpineRootPosX)

	local scenePos = curSpineRootPosX * Activity130Enum.SceneMaxX / Activity130Enum.MaxSlideX

	Activity130Controller.instance:dispatchEvent(Activity130Event.SetScenePos, scenePos)
end

function Activity130LevelView:_onDragEnd(param, pointerEventData)
	return
end

function Activity130LevelView:_checkLevelUpdate()
	local episodeId = Activity130Model.instance:getCurEpisodeId()
	local state = Activity130Model.instance:getEpisodeState(episodeId)
	local isEpisodeFinished = Activity130Model.instance:isEpisodeFinished(episodeId)
	local maxEpisode = Activity130Model.instance:getMaxEpisode()

	if episodeId < maxEpisode then
		if not (episodeId + 1) then
			local nextEpisode = episodeId
			local isNextEpisodeUnlock = Activity130Model.instance:isEpisodeUnlock(nextEpisode)

			if not isEpisodeFinished then
				return
			end

			if isNextEpisodeUnlock and nextEpisode ~= episodeId then
				return
			end

			Activity130Model.instance:setNewFinishEpisode(episodeId)

			local newUnlockEpisode = nextEpisode == episodeId and -1 or nextEpisode

			Activity130Model.instance:setNewUnlockEpisode(newUnlockEpisode)

			local activityId = VersionActivity1_4Enum.ActivityId.Role37

			Activity130Rpc.instance:sendGet130InfosRequest(activityId, self._getInfoSuccess, self)
		end
	end
end

function Activity130LevelView:_getInfoSuccess(cmd, resultCode)
	if resultCode ~= 0 then
		return
	end

	Activity130Controller.instance:dispatchEvent(Activity130Event.NewEpisodeUnlock)
	self:_backToLevelView()
end

function Activity130LevelView:_setToPos()
	self:_onSlideFinish()
end

function Activity130LevelView:_onSlideFinish()
	local episodeId = Activity130Model.instance:getCurEpisodeId()
	local newEpisode = Activity130Model.instance:getNewUnlockEpisode()

	if newEpisode > -1 then
		episodeId = newEpisode
	end

	if episodeId then
		if not (episodeId + 1) then
			local index = 1

			if index < Activity130Enum.MaxShowEpisodeCount + 1 then
				return
			end

			local totalEpisodes = Activity130Model.instance:getTotalEpisodeCount()
			local pos = (index - Activity130Enum.MaxShowEpisodeCount) * Activity130Enum.MaxSlideX / (totalEpisodes - Activity130Enum.MaxShowEpisodeCount)

			pos = pos > Activity130Enum.MaxSlideX and Activity130Enum.MaxSlideX or pos

			transformhelper.setLocalPos(self._goscrollcontent.transform, -pos, 0, 0)

			local scenePos = -pos * Activity130Enum.SceneMaxX / Activity130Enum.MaxSlideX

			Activity130Controller.instance:dispatchEvent(Activity130Event.SetScenePos, scenePos)
		end
	end
end

function Activity130LevelView:_backToLevelView()
	StoryController.instance:closeStoryView()
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("newepisode")
	self._viewAnimator:Play("open", 0, 0)

	local newEpisode = Activity130Model.instance:getNewFinishEpisode()
	local episodeId = Activity130Model.instance:getCurEpisodeId()

	if newEpisode > -1 then
		if newEpisode == 0 then
			self._pathAnimator:Play("go1", 0, 0)

			self._pathAnimator.speed = 0
		else
			self._pathAnimator:Play("go" .. newEpisode, 0, 1)

			self._pathAnimator.speed = 1
		end
	else
		local maxEpisode = Activity130Model.instance:getMaxUnlockEpisode()

		self._pathAnimator.speed = 1

		self._pathAnimator:Play("go" .. maxEpisode, 0, 1)
	end

	self:_setToPos()
	TaskDispatcher.runDelay(self._checkNewFinishEpisode, self, 1)
end

function Activity130LevelView:_checkNewFinishEpisode()
	local newEpisode = Activity130Model.instance:getNewFinishEpisode()

	if newEpisode > -1 then
		Activity130Controller.instance:dispatchEvent(Activity130Event.playNewFinishEpisode, newEpisode)
		Activity130Model.instance:setNewFinishEpisode(-1)
		TaskDispatcher.runDelay(self._checkNewUnlockEpisode, self, 1.5)
	else
		self:_checkNewUnlockEpisode()
	end
end

function Activity130LevelView:_checkNewUnlockEpisode()
	local newEpisode = Activity130Model.instance:getNewUnlockEpisode()

	if newEpisode > -1 then
		self._pathAnimator.speed = 1

		self._pathAnimator:Play("go" .. newEpisode, 0, 0)
		TaskDispatcher.runDelay(self._startShowUnlock, self, 0.34)
	else
		self:_startShowUnlock()
	end
end

function Activity130LevelView:_startShowUnlock()
	local newEpisode = Activity130Model.instance:getNewUnlockEpisode()

	if newEpisode > -1 then
		Activity130Controller.instance:dispatchEvent(Activity130Event.playNewUnlockEpisode, newEpisode)
		self:_checkPlaySceneChange(newEpisode)
		TaskDispatcher.runDelay(self._showUnlockFinished, self, 0.67)
	else
		self:_showUnlockFinished()
	end
end

function Activity130LevelView:_showUnlockFinished()
	UIBlockMgr.instance:endBlock("newepisode")

	local newEpisode = Activity130Model.instance:getNewUnlockEpisode()

	if newEpisode > -1 then
		Activity130Controller.instance:dispatchEvent(Activity130Event.PlayChessAutoToNewEpisode, newEpisode)
	end

	self:_refreshUI()
end

function Activity130LevelView:_checkPlaySceneChange(episodeId)
	local curEpisodeId = Activity130Model.instance:getCurEpisodeId()
	local actId = VersionActivity1_4Enum.ActivityId.Role37

	if curEpisodeId < 1 then
		if not Activity130Enum.lvSceneType.Light then
			local curSceneType = Activity130Config.instance:getActivity130EpisodeCo(actId, curEpisodeId).lvscene

			self._toSceneType = Activity130Enum.lvSceneType.Light

			if episodeId and episodeId > 0 then
				self._toSceneType = Activity130Config.instance:getActivity130EpisodeCo(actId, episodeId).lvscene
			end

			if curEpisodeId > 4 and episodeId < 5 then
				gohelper.setActive(self._goexcessive, true)
				self._excessAnimator:Play("hard", 0, 0)
				AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_checkpoint_chap5_switch)
			elseif curEpisodeId < 5 and episodeId > 4 then
				gohelper.setActive(self._goexcessive, true)
				self._excessAnimator:Play("story", 0, 0)
				AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_checkpoint_chap5_switch)
			end

			if self._toSceneType == curSceneType then
				return
			end

			self.viewContainer:changeLvScene(self._toSceneType)
		end
	end
end

function Activity130LevelView:_enterGameView()
	self._viewAnimator:Play("close", 0, 0)
	TaskDispatcher.runDelay(self._realEnterGameView, self, 0.34)
end

function Activity130LevelView:_realEnterGameView()
	local param = {}

	param.episodeId = Activity130Model.instance:getCurEpisodeId()

	Activity130Controller.instance:openActivity130GameView(param)
end

function Activity130LevelView:_playCloseLevelView()
	self._viewAnimator:Play("close", 0, 0)
end

function Activity130LevelView:_addEvents()
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._gopath.gameObject)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self._drag:AddDragListener(self._onDrag, self)
	self.addEventCb(self, Activity130Controller.instance, Activity130Event.OnDialogMarkSuccess, self._checkLevelUpdate, self)
	self.addEventCb(self, Activity130Controller.instance, Activity130Event.OnGeneralGameSuccess, self._checkLevelUpdate, self)
	self.addEventCb(self, Activity130Controller.instance, Activity130Event.OnStoryFinishedSuccess, self._checkLevelUpdate, self)
	self.addEventCb(self, Activity130Controller.instance, Activity130Event.EpisodeClick, self._checkPlaySceneChange, self)
	self.addEventCb(self, Activity130Controller.instance, Activity130Event.BackToLevelView, self._backToLevelView, self)
	self.addEventCb(self, Activity130Controller.instance, Activity130Event.StartEnterGameView, self._enterGameView, self)
	self.addEventCb(self, Activity130Controller.instance, Activity130Event.PlayLeaveLevelView, self._playCloseLevelView, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._refreshTask, self)
end

function Activity130LevelView:_removeEvents()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragListener()
	self._drag:RemoveDragEndListener()
	self.removeEventCb(self, Activity130Controller.instance, Activity130Event.OnDialogMarkSuccess, self._checkLevelUpdate, self)
	self.removeEventCb(self, Activity130Controller.instance, Activity130Event.OnGeneralGameSuccess, self._checkLevelUpdate, self)
	self.removeEventCb(self, Activity130Controller.instance, Activity130Event.OnStoryFinishedSuccess, self._checkLevelUpdate, self)
	self.removeEventCb(self, Activity130Controller.instance, Activity130Event.EpisodeClick, self._checkPlaySceneChange, self)
	self.removeEventCb(self, Activity130Controller.instance, Activity130Event.BackToLevelView, self._backToLevelView, self)
	self.removeEventCb(self, Activity130Controller.instance, Activity130Event.StartEnterGameView, self._enterGameView, self)
	self.removeEventCb(self, Activity130Controller.instance, Activity130Event.PlayLeaveLevelView, self._playCloseLevelView, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._refreshTask, self)
end

function Activity130LevelView:onDestroyView()
	TaskDispatcher.cancelTask(self._showUnlockFinished, self)

	if self._stageItemList then
		for _, stageItem in ipairs(self._stageItemList) do
			stageItem:onDestroyView()
		end

		self._stageItemList = nil
	end

	self._simagemask:UnLoadImage()
end

return Activity130LevelView
