-- chunkname: @modules/logic/versionactivity1_4/act130/view/Activity130GameView.lua

module("modules.logic.versionactivity1_4.act130.view.Activity130GameView", package.seeall)

local Activity130GameView = class("Activity130GameView", BaseView)

function Activity130GameView:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._gostage = gohelper.findChild(self.viewGO, "#go_lefttop/#go_stage")
	self._txtstagenum = gohelper.findChildText(self.viewGO, "#go_lefttop/#go_stage/#txt_stagenum")
	self._txtstagename = gohelper.findChildText(self.viewGO, "#go_lefttop/#go_stage/#txt_stagename")
	self._gotargetitem = gohelper.findChild(self.viewGO, "#go_lefttop/#go_targetitem")
	self._imagetargeticon = gohelper.findChildImage(self.viewGO, "#go_lefttop/#go_targetitem/#image_targeticon")
	self._txttargetdesc = gohelper.findChildText(self.viewGO, "#go_lefttop/#go_targetitem/targetbg/#txt_targetdesc")
	self._gotopbtns = gohelper.findChild(self.viewGO, "#go_topbtns")
	self._gocollect = gohelper.findChild(self.viewGO, "#go_collect")
	self._btncollect = gohelper.findChildButtonWithAudio(self.viewGO, "#go_collect/#btn_collect")
	self._gocollectreddot = gohelper.findChild(self.viewGO, "#go_collect/#go_collectreddot")
	self._gocollecteffect = gohelper.findChild(self.viewGO, "vx_collect")
	self._godecrypt = gohelper.findChild(self.viewGO, "#go_decrypt")
	self._btndecrypt = gohelper.findChildButtonWithAudio(self.viewGO, "#go_decrypt/#btn_decrypt", 25001033)
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reset")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity130GameView:addEvents()
	self._btncollect:AddClickListener(self._btncollectOnClick, self)
	self._btndecrypt:AddClickListener(self._btndecryptOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
end

function Activity130GameView:removeEvents()
	self._btncollect:RemoveClickListener()
	self._btndecrypt:RemoveClickListener()
	self._btnreset:RemoveClickListener()
end

function Activity130GameView:_btncollectOnClick()
	local episodeId = Activity130Model.instance:getCurEpisodeId()

	Activity130Model.instance:setNewCollect(episodeId, false)
	self:_showCollect(true)
	Activity130Controller.instance:openActivity130CollectView()
end

function Activity130GameView:_btndecryptOnClick()
	local episodeId = Activity130Model.instance:getCurEpisodeId()
	local decryptId = Activity130Model.instance:getEpisodeDecryptId(episodeId)

	if decryptId ~= 0 then
		Role37PuzzleModel.instance:setPuzzleId(decryptId)
		Activity130Controller.instance:openPuzzleView()
	end
end

function Activity130GameView:_btnresetOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.Activity130GameRestart, MsgBoxEnum.BoxType.Yes_No, function()
		local actId = VersionActivity1_4Enum.ActivityId.Role37
		local episodeId = Activity130Model.instance:getCurEpisodeId()

		Activity130Rpc.instance:sendAct130RestartEpisodeRequest(actId, episodeId)
		Activity130Model.instance:setNewCollect(episodeId, false)
		StatActivity130Controller.instance:statReset()
	end)
end

function Activity130GameView:_editableInitView()
	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._collectAnimator = self._gocollecteffect:GetComponent(typeof(UnityEngine.Animator))

	self:_addEvents()
end

function Activity130GameView:onOpen()
	Activity130Controller.instance:dispatchEvent(Activity130Event.ShowLevelScene, false)
	AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_level_title_appear)

	local actId = VersionActivity1_4Enum.ActivityId.Role37
	local episodeId = Activity130Model.instance:getCurEpisodeId()

	self._config = Activity130Config.instance:getActivity130EpisodeCo(actId, episodeId)

	local progress = Activity130Model.instance:getCurMapInfo().progress

	if progress == Activity130Enum.ProgressType.BeforeStory then
		if self._config.beforeStoryId > 0 then
			StoryController.instance:playStory(self._config.beforeStoryId, nil, self._onStoryFinished, self)
		else
			self:_onStoryFinished()
		end
	elseif progress == Activity130Enum.ProgressType.Interact then
		self:_backToGameView()
	elseif progress == Activity130Enum.ProgressType.AfterStory then
		if self._config.afterStoryId > 0 then
			StoryController.instance:playStory(self._config.afterStoryId, nil, self._onStoryFinished, self)
		else
			self:_onStoryFinished()
		end
	else
		self:_backToGameView()
	end
end

function Activity130GameView:_onStoryFinished()
	Activity130Rpc.instance:sendAct130StoryRequest(self._config.activityId, self._config.episodeId, self._storyBackToGame, self)
end

function Activity130GameView:_storyBackToGame(cmd, resultCode)
	if resultCode ~= 0 then
		return
	end

	self:_backToGameView()
end

function Activity130GameView:_puzzleSuccess(success)
	if not success then
		return
	end

	local decryptId, finish = Activity130Model.instance:getEpisodeDecryptId(self._config.episodeId)

	if not finish and decryptId ~= 0 then
		local actId = VersionActivity1_4Enum.ActivityId.Role37
		local episodeId = Activity130Model.instance:getCurEpisodeId()
		local elementInfo = Activity130Model.instance:getElementInfoByDecryptId(decryptId, episodeId)

		Activity130Rpc.instance:sendAct130GeneralRequest(actId, episodeId, elementInfo.elementId, self._waitDecryptResultClose, self)
	end
end

function Activity130GameView:_waitDecryptResultClose(cmd, resultCode)
	if resultCode ~= 0 then
		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function Activity130GameView:_onCloseViewFinish(viewName)
	if viewName == ViewName.Role37PuzzleResultView then
		self:_backToGameView()
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	end
end

function Activity130GameView:_backToGameView()
	Activity130Controller.instance:dispatchEvent(Activity130Event.AutoStartElement)
	self:_refreshUI()
end

function Activity130GameView:_refreshUI()
	self:_showStage(true)

	local tipId, stepId = Activity130Model.instance:getEpisodeTaskTip(self._config.episodeId)

	if tipId ~= 0 then
		local dialogCo = Activity130Config.instance:getActivity130DialogCo(tipId, stepId)

		self:_showTarget(true, dialogCo)
	else
		self:_showTarget(false)
	end

	self:_showCollect(true)

	local decryptId = Activity130Model.instance:getEpisodeDecryptId(self._config.episodeId)

	if decryptId ~= 0 then
		self:_showDecrypt(true)
	else
		self:_showDecrypt(false)
	end
end

function Activity130GameView:_showStage(show)
	gohelper.setActive(self._gostage, show)

	if not show then
		return
	end

	self._txtstagenum.text = self._config.episodetag
	self._txtstagename.text = self._config.name
end

function Activity130GameView:_showTarget(show, dialogCo)
	gohelper.setActive(self._gotargetitem, show)

	if not show then
		return
	end

	self._txttargetdesc.text = dialogCo.content
end

function Activity130GameView:_showCollect(show)
	gohelper.setActive(self._gocollect, show)

	if not show then
		return
	end

	local episodeId = Activity130Model.instance:getCurEpisodeId()
	local reddotShow = Activity130Model.instance:getNewCollectState(episodeId)

	gohelper.setActive(self._gocollectreddot, reddotShow)
end

function Activity130GameView:_showDecrypt(show)
	gohelper.setActive(self._godecrypt, show)

	if not show then
		return
	end
end

function Activity130GameView:onRefreshTaskTips(mapInfo)
	local episodeId = Activity130Model.instance:getCurEpisodeId()
	local actId = VersionActivity1_4Enum.ActivityId.Role37

	Activity130Rpc.instance:sendAct130GeneralRequest(actId, episodeId, mapInfo.elementId, self._backToRefreshTaskTips, self)
end

function Activity130GameView:_backToRefreshTaskTips(cmd, resultCode)
	if resultCode ~= 0 then
		return
	end

	local episodeId = Activity130Model.instance:getCurEpisodeId()
	local tipId, stepId = Activity130Model.instance:getEpisodeTaskTip(episodeId)
	local dialogCo = Activity130Config.instance:getActivity130DialogCo(tipId, stepId)

	self:_showTarget(true, dialogCo)
	self:_backToGameView()
end

function Activity130GameView:onRefreshCollect(mapInfo)
	local actId = VersionActivity1_4Enum.ActivityId.Role37
	local episodeId = Activity130Model.instance:getCurEpisodeId()

	Activity130Rpc.instance:sendAct130GeneralRequest(actId, episodeId, mapInfo.elementId, self._unlockCollectSuccess, self)
end

function Activity130GameView:_unlockCollectSuccess(cmd, resultCode)
	if resultCode ~= 0 then
		return
	end

	gohelper.setActive(self._gocollecteffect, true)
	self._collectAnimator:Play("open", 0, 0)
	AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_gather)
	TaskDispatcher.runDelay(self._collectEffectFinished, self, 1.87)

	local episodeId = Activity130Model.instance:getCurEpisodeId()

	Activity130Model.instance:setNewCollect(episodeId, true)
	self:_showCollect(true)
	self:_backToGameView()
end

function Activity130GameView:_collectEffectFinished()
	gohelper.setActive(self._gocollecteffect, false)
	Activity130Controller.instance:dispatchEvent(Activity130Event.OnCollectEffectFinished)
end

function Activity130GameView:onRefreshDecrypt(mapInfo)
	self:_showDecrypt(true)
	Activity130Controller.instance:dispatchEvent(Activity130Event.OnUnlockDecryptBtn, mapInfo.elementId)
end

function Activity130GameView:onCheckDecrypt(mapInfo)
	local actId = VersionActivity1_4Enum.ActivityId.Role37
	local episodeId = Activity130Model.instance:getCurEpisodeId()

	Activity130Rpc.instance:sendAct130GeneralRequest(actId, episodeId, mapInfo.elementId, self._checkDecryptBackToGame, self)
end

function Activity130GameView:_checkDecryptBackToGame(cmd, resultCode)
	if resultCode ~= 0 then
		return
	end

	self:_backToGameView()
end

function Activity130GameView:_onCheckAutoStartElement()
	self:_refreshUI()
end

function Activity130GameView:_onRestartSet()
	self:_backToGameView()
end

function Activity130GameView:_onShowTipDialog(dialogParam)
	local data = {}

	data.dialogParam = dialogParam
	data.isClient = true

	Activity130Controller.instance:openActivity130DialogView(data)
end

function Activity130GameView:onClose()
	self:_removeEvents()
end

function Activity130GameView:_addEvents()
	self.addEventCb(self, Role37PuzzleController.instance, Role37PuzzleEvent.PuzzleResult, self._puzzleSuccess, self)
	self.addEventCb(self, Activity130Controller.instance, Activity130Event.RefreshTaskTip, self.onRefreshTaskTips, self)
	self.addEventCb(self, Activity130Controller.instance, Activity130Event.UnlockDecrypt, self.onRefreshDecrypt, self)
	self.addEventCb(self, Activity130Controller.instance, Activity130Event.UnlockCollect, self.onRefreshCollect, self)
	self.addEventCb(self, Activity130Controller.instance, Activity130Event.CheckDecrypt, self.onCheckDecrypt, self)
	self.addEventCb(self, Activity130Controller.instance, Activity130Event.OnElementUpdate, self._refreshUI, self)
	self.addEventCb(self, Activity130Controller.instance, Activity130Event.OnRestartEpisodeSuccess, self._onRestartSet, self)
	self.addEventCb(self, Activity130Controller.instance, Activity130Event.OnGeneralGameSuccess, self._onCheckAutoStartElement, self)
	self.addEventCb(self, Activity130Controller.instance, Activity130Event.OnDialogMarkSuccess, self._onCheckAutoStartElement, self)
	self.addEventCb(self, Activity130Controller.instance, Activity130Event.ShowTipDialog, self._onShowTipDialog, self)
end

function Activity130GameView:_removeEvents()
	self.removeEventCb(self, Role37PuzzleController.instance, Role37PuzzleEvent.PuzzleResult, self._puzzleSuccess, self)
	self.removeEventCb(self, Activity130Controller.instance, Activity130Event.RefreshTaskTip, self.onRefreshTaskTips, self)
	self.removeEventCb(self, Activity130Controller.instance, Activity130Event.UnlockDecrypt, self.onRefreshDecrypt, self)
	self.removeEventCb(self, Activity130Controller.instance, Activity130Event.UnlockCollect, self.onRefreshCollect, self)
	self.removeEventCb(self, Activity130Controller.instance, Activity130Event.CheckDecrypt, self.onCheckDecrypt, self)
	self.removeEventCb(self, Activity130Controller.instance, Activity130Event.OnElementUpdate, self._refreshUI, self)
	self.removeEventCb(self, Activity130Controller.instance, Activity130Event.OnRestartEpisodeSuccess, self._onRestartSet, self)
	self.removeEventCb(self, Activity130Controller.instance, Activity130Event.OnDialogMarkSuccess, self._onCheckAutoStartElement, self)
	self.removeEventCb(self, Activity130Controller.instance, Activity130Event.ShowTipDialog, self._onShowTipDialog, self)
end

function Activity130GameView:onDestroyView()
	return
end

return Activity130GameView
