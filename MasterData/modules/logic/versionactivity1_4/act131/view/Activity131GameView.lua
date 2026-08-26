-- chunkname: @modules/logic/versionactivity1_4/act131/view/Activity131GameView.lua

module("modules.logic.versionactivity1_4.act131.view.Activity131GameView", package.seeall)

local Activity131GameView = class("Activity131GameView", BaseView)

function Activity131GameView:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._gostage = gohelper.findChild(self.viewGO, "#go_lefttop/#go_stage")
	self._txtstagenum = gohelper.findChildText(self.viewGO, "#go_lefttop/#go_stage/#txt_stagenum")
	self._txtstagename = gohelper.findChildText(self.viewGO, "#go_lefttop/#go_stage/#txt_stagename")
	self._gotargetitem = gohelper.findChild(self.viewGO, "#go_lefttop/#go_targetitem")
	self._imagetargeticon = gohelper.findChildImage(self.viewGO, "#go_lefttop/#go_targetitem/#image_targeticon")
	self._txttargetdesc = gohelper.findChildText(self.viewGO, "#go_lefttop/#go_targetitem/#txt_targetdesc")
	self._gotopbtns = gohelper.findChild(self.viewGO, "#go_topbtns")
	self._btnStory = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Story")
	self._goFinished = gohelper.findChild(self.viewGO, "#go_Finished")
	self._gofinishing = gohelper.findChild(self.viewGO, "#go_Finished/vx_finished")
	self._gofinished = gohelper.findChild(self.viewGO, "#go_Finished/image_Finished")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reset")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity131GameView:addEvents()
	self._btnStory:AddClickListener(self._btnStoryOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
end

function Activity131GameView:removeEvents()
	self._btnStory:RemoveClickListener()
	self._btnreset:RemoveClickListener()
end

function Activity131GameView:_btnStoryOnClick()
	Activity131Controller.instance:openLogView()
end

function Activity131GameView:_btnresetOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.Activity130GameRestart, MsgBoxEnum.BoxType.Yes_No, function()
		local actId = VersionActivity1_4Enum.ActivityId.Role6
		local episodeId = Activity131Model.instance:getCurEpisodeId()

		Activity131Rpc.instance:sendAct131RestartEpisodeRequest(actId, episodeId)
	end)
end

function Activity131GameView:_editableInitView()
	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self:_addEvents()
end

function Activity131GameView:onOpen()
	Activity131Model.instance:refreshLogDics()
	AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_level_title_appear)

	local actId = VersionActivity1_4Enum.ActivityId.Role6
	local episodeId = Activity131Model.instance:getCurEpisodeId()

	self._config = Activity131Config.instance:getActivity131EpisodeCo(actId, episodeId)

	local progress = Activity131Model.instance:getEpisodeProgress(self._config.episodeId)

	if self.viewParam and self.viewParam.exitFromBattle and progress == Activity131Enum.ProgressType.Finished then
		self:onPlayFinishAnim()
	else
		gohelper.setActive(self._gofinishing, false)
		gohelper.setActive(self._gofinished, progress == Activity131Enum.ProgressType.Finished)
	end

	if progress == Activity131Enum.ProgressType.BeforeStory then
		if self._config.beforeStoryId > 0 then
			StoryController.instance:playStory(self._config.beforeStoryId, nil, self._onStoryFinished, self)
		else
			self:_onStoryFinished()
		end
	elseif progress == Activity131Enum.ProgressType.Interact then
		self:_backToGameView()
	else
		self:_backToGameView()
	end
end

function Activity131GameView:onPlayFinishAnim()
	if self.viewParam.exitFromBattle then
		self.viewParam.exitFromBattle = nil
	end

	gohelper.setActive(self._gofinished, false)
	gohelper.setActive(self._gofinishing, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_molu_exit_appear)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("finishAnim")
	TaskDispatcher.runDelay(self._finishAnimCallBack, self, 3.5)
end

function Activity131GameView:_finishAnimCallBack()
	UIBlockMgr.instance:endBlock("finishAnim")

	if self._config.afterStoryId > 0 and not StoryModel.instance:isStoryFinished(self._config.afterStoryId) then
		local actId = VersionActivity1_4Enum.ActivityId.Role6
		local episodeId = Activity131Model.instance:getCurEpisodeId()
		local co = Activity131Config.instance:getActivity131EpisodeCo(actId, episodeId)

		StoryController.instance:playStory(co.afterStoryId, nil, self._onPlayStorySucess, self)
	elseif self.firstFinishId and self.firstFinishId == self._config.episodeId then
		self:_backToLevelView()

		self.firstFinishId = nil
	end
end

function Activity131GameView:_onPlayStorySucess()
	Activity131Rpc.instance:sendAct131StoryRequest(self._config.activityId, self._config.episodeId)
	self:_backToLevelView()
end

function Activity131GameView:_backToLevelView()
	self:closeThis()
	Activity131Controller.instance:dispatchEvent(Activity131Event.BackToLevelView, true)
end

function Activity131GameView:_onFirstFinish(episodeId)
	self.firstFinishId = episodeId
end

function Activity131GameView:_onStoryFinished()
	Activity131Rpc.instance:sendAct131StoryRequest(self._config.activityId, self._config.episodeId, self._backToGameView, self)
end

function Activity131GameView:_backToGameView()
	if not self._viewAnim then
		return
	end

	Activity131Controller.instance:dispatchEvent(Activity131Event.AutoStartElement)
	self:_refreshUI()
end

function Activity131GameView:_refreshUI()
	self:_showStage(true)

	local isFinish = Activity131Model.instance:isEpisodeFinished(self._config.episodeId)
	local tipId, stepId = Activity131Model.instance:getEpisodeTaskTip(self._config.episodeId)

	if tipId ~= 0 and not isFinish then
		local dialogCo = Activity131Config.instance:getActivity131DialogCo(tipId, stepId)

		self:_showTarget(true, dialogCo)
	else
		self:_showTarget(false)
	end
end

function Activity131GameView:_showStage(show)
	gohelper.setActive(self._gostage, show)

	if not show then
		return
	end

	self._txtstagenum.text = self._config.episodetag
	self._txtstagename.text = self._config.name
end

function Activity131GameView:_showTarget(show, dialogCo)
	gohelper.setActive(self._gotargetitem, show)

	if not show then
		return
	end

	self._txttargetdesc.text = dialogCo.content
end

function Activity131GameView:onRefreshTaskTips(mapInfo)
	local episodeId = Activity131Model.instance:getCurEpisodeId()
	local actId = VersionActivity1_4Enum.ActivityId.Role6

	Activity131Rpc.instance:sendAct131GeneralRequest(actId, episodeId, mapInfo.elementId, self._backToRefreshTaskTips, self)
end

function Activity131GameView:onElementUpdate()
	local progress = Activity131Model.instance:getEpisodeProgress(self._config.episodeId)

	if progress == Activity131Enum.ProgressType.Finished then
		self:onPlayFinishAnim()
	elseif progress ~= Activity131Enum.ProgressType.AfterStory then
		gohelper.setActive(self._gofinishing, false)
		gohelper.setActive(self._gofinished, false)
	end

	self:_refreshUI()
end

function Activity131GameView:_backToRefreshTaskTips()
	if not self._viewAnim then
		return
	end

	local episodeId = Activity131Model.instance:getCurEpisodeId()
	local tipId, stepId = Activity131Model.instance:getEpisodeTaskTip(episodeId)
	local dialogCo = Activity131Config.instance:getActivity131DialogCo(tipId, stepId)

	self:_showTarget(true, dialogCo)
	self:_backToGameView()
end

function Activity131GameView:_onCheckAutoStartElement()
	self:_refreshUI()
end

function Activity131GameView:_onRestartSet()
	self:_backToGameView()
end

function Activity131GameView:onClose()
	self:_removeEvents()
end

function Activity131GameView:onTriggerLogElement(mapInfo)
	local actId = VersionActivity1_4Enum.ActivityId.Role6
	local episodeId = Activity131Model.instance:getCurEpisodeId()

	Activity131Rpc.instance:sendAct131GeneralRequest(actId, episodeId, mapInfo.elementId, self._backToGameView, self)
end

function Activity131GameView:onTriggerBattleElement(mapInfo)
	local actId = VersionActivity1_4Enum.ActivityId.Role6
	local episodeId = Activity131Model.instance:getCurEpisodeId()

	Activity131Rpc.instance:sendBeforeAct131BattleRequest(actId, episodeId, mapInfo.elementId)
end

function Activity131GameView:OnBattleBeforeSucess(elementId)
	local elementInfo = Activity131Model.instance:getCurMapElementInfo(elementId)
	local elementType = elementInfo:getType()
	local episodeId = elementInfo:getParam()

	if elementType == 1 then
		ViewMgr.instance:openView(ViewName.Activity131BattleView, episodeId)
	else
		logError("元件类型%s不是战斗元件", elementType)
	end
end

function Activity131GameView:_addEvents()
	self.addEventCb(self, Activity131Controller.instance, Activity131Event.RefreshTaskTip, self.onRefreshTaskTips, self)
	self.addEventCb(self, Activity131Controller.instance, Activity131Event.OnElementUpdate, self.onElementUpdate, self)
	self.addEventCb(self, Activity131Controller.instance, Activity131Event.OnRestartEpisodeSuccess, self._onRestartSet, self)
	self.addEventCb(self, Activity131Controller.instance, Activity131Event.OnGeneralGameSuccess, self._onCheckAutoStartElement, self)
	self.addEventCb(self, Activity131Controller.instance, Activity131Event.OnDialogMarkSuccess, self._onCheckAutoStartElement, self)
	self.addEventCb(self, Activity131Controller.instance, Activity131Event.TriggerLogElement, self.onTriggerLogElement, self)
	self.addEventCb(self, Activity131Controller.instance, Activity131Event.TriggerBattleElement, self.onTriggerBattleElement, self)
	self.addEventCb(self, Activity131Controller.instance, Activity131Event.OnBattleBeforeSucess, self.OnBattleBeforeSucess, self)
	self.addEventCb(self, Activity131Controller.instance, Activity131Event.ShowFinish, self.onPlayFinishAnim, self)
	self.addEventCb(self, Activity131Controller.instance, Activity131Event.FirstFinish, self._onFirstFinish, self)
end

function Activity131GameView:_removeEvents()
	self.removeEventCb(self, Activity131Controller.instance, Activity131Event.RefreshTaskTip, self.onRefreshTaskTips, self)
	self.removeEventCb(self, Activity131Controller.instance, Activity131Event.OnElementUpdate, self.onElementUpdate, self)
	self.removeEventCb(self, Activity131Controller.instance, Activity131Event.OnRestartEpisodeSuccess, self._onRestartSet, self)
	self.removeEventCb(self, Activity131Controller.instance, Activity131Event.OnGeneralGameSuccess, self._onCheckAutoStartElement, self)
	self.removeEventCb(self, Activity131Controller.instance, Activity131Event.OnDialogMarkSuccess, self._onCheckAutoStartElement, self)
	self.removeEventCb(self, Activity131Controller.instance, Activity131Event.TriggerLogElement, self.onTriggerLogElement, self)
	self.removeEventCb(self, Activity131Controller.instance, Activity131Event.TriggerBattleElement, self.onTriggerBattleElement, self)
	self.removeEventCb(self, Activity131Controller.instance, Activity131Event.OnBattleBeforeSucess, self.OnBattleBeforeSucess, self)
	self.removeEventCb(self, Activity131Controller.instance, Activity131Event.ShowFinish, self.onPlayFinishAnim, self)
	self.removeEventCb(self, Activity131Controller.instance, Activity131Event.FirstFinish, self._onFirstFinish, self)
end

function Activity131GameView:onDestroyView()
	self._viewAnim = nil

	TaskDispatcher.cancelTask(self._finishAnimCallBack, self)
end

return Activity131GameView
