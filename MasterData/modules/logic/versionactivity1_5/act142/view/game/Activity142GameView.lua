-- chunkname: @modules/logic/versionactivity1_5/act142/view/game/Activity142GameView.lua

module("modules.logic.versionactivity1_5.act142.view.game.Activity142GameView", package.seeall)

local Activity142GameView = class("Activity142GameView", BaseView)
local TOAST_TIME = 5

function Activity142GameView:onInitView()
	self._txtStage = gohelper.findChildText(self.viewGO, "Top/#txt_Stage")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Top/#txt_Title")
	self._goTips = gohelper.findChild(self.viewGO, "Top/Tips")
	self._txtTips = gohelper.findChildText(self.viewGO, "Top/Tips/image_TipsBG/#txt_Tips")

	gohelper.setActive(self._goTips, false)

	self._goMainTargetFinishBg = gohelper.findChild(self.viewGO, "LeftTop/TargetList/Target1/image_TargetFinishedBG")
	self._imgMainTargetIcon = gohelper.findChildImage(self.viewGO, "LeftTop/TargetList/Target1/image_TargetIcon")
	self._goMainTargetLightIcon = gohelper.findChild(self.viewGO, "LeftTop/TargetList/Target1/image_TargetIcon/image_TargetIconLight")
	self._txtMainTargetDesc = gohelper.findChildText(self.viewGO, "LeftTop/TargetList/Target1/#txt_TargetDesc")
	self._goMainTargetFinishEff = gohelper.findChild(self.viewGO, "LeftTop/TargetList/Target1/vx_finish")

	gohelper.setActive(self._goMainTargetFinishBg, true)
	gohelper.setActive(self._goMainTargetLightIcon, false)
	gohelper.setActive(self._goMainTargetFinishEff, false)

	self._goSubTargetFinishBg = gohelper.findChild(self.viewGO, "LeftTop/TargetList/Target2/image_TargetFinishedBG")
	self._imgSubTargetIcon = gohelper.findChildImage(self.viewGO, "LeftTop/TargetList/Target2/image_TargetIcon")
	self._goSubTargetLightIcon = gohelper.findChild(self.viewGO, "LeftTop/TargetList/Target2/image_TargetIcon/image_TargetIconLight")
	self._txtSubTargetDesc = gohelper.findChildText(self.viewGO, "LeftTop/TargetList/Target2/#txt_TargetDesc")
	self._goSubTargetFinishEff = gohelper.findChild(self.viewGO, "LeftTop/TargetList/Target2/vx_finish")

	gohelper.setActive(self._goSubTargetFinishBg, false)
	gohelper.setActive(self._goSubTargetLightIcon, false)
	gohelper.setActive(self._goSubTargetFinishEff, false)

	self._btnBacktrack = gohelper.findChildButtonWithAudio(self.viewGO, "RightTop/#btn_Backtrack")
	self._btnResetBtn = gohelper.findChildButtonWithAudio(self.viewGO, "RightTop/#btn_Reset")
	self._goChangeMapEff = gohelper.findChild(self.viewGO, "#go_excessive")

	gohelper.setActive(self._goChangeMapEff, false)

	local goAnim = gohelper.findChild(self.viewGO, "#go_excessive/anim")

	self._changeMapAnimator = goAnim:GetComponent(Va3ChessEnum.ComponentType.Animator)
	self._goCloseEyeEff = gohelper.findChild(self.viewGO, "excessive")

	gohelper.setActive(self._goCloseEyeEff, false)

	local goCloseAnim = gohelper.findChild(self.viewGO, "excessive/anim")

	self._closeEyeAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(goCloseAnim)
	self._viewAnimator = self.viewGO:GetComponent(Va3ChessEnum.ComponentType.Animator)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity142GameView:addEvents()
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.SetViewVictory, self.onSetViewVictory, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.SetViewFail, self.onSetViewFail, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.GameResultQuit, self.onResultQuit, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.GameToastUpdate, self._onToastUpdate, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.CurrentConditionUpdate, self.refreshConditions, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.GameMapDataUpdate, self.refreshUI, self)
	self._btnBacktrack:AddClickListener(self._btnBackTrackOnClick, self)
	self._btnResetBtn:AddClickListener(self._btnResetBtnOnClick, self)
end

function Activity142GameView:removeEvents()
	self.removeEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.SetViewVictory, self.onSetViewVictory, self)
	self.removeEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.SetViewFail, self.onSetViewFail, self)
	self.removeEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.GameResultQuit, self.onResultQuit, self)
	self.removeEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.GameToastUpdate, self._onToastUpdate, self)
	self.removeEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.CurrentConditionUpdate, self.refreshConditions, self)
	self.removeEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.GameMapDataUpdate, self.refreshUI, self)
	self._btnResetBtn:RemoveClickListener()
	self._btnBacktrack:RemoveClickListener()
end

function Activity142GameView:onSetViewVictory()
	self:refreshConditions()
	Activity142Helper.openWinResult()
	Activity142StatController.instance:statSuccess()
end

function Activity142GameView:onSetViewFail()
	self:back2CheckPointWithEff(true)
end

function Activity142GameView:onResultQuit()
	local episodeCfg = self:_getEpisodeCfg()

	if not episodeCfg or episodeCfg.storyClear == 0 then
		self:closeThis()

		return
	end

	local storyId = episodeCfg.storyClear
	local needPlayStory = episodeCfg.storyRepeat == 1 or not StoryModel.instance:isStoryHasPlayed(storyId)

	if needPlayStory then
		local param = {}

		param.blur = true
		param.mark = true
		param.hideStartAndEndDark = true
		param.isReplay = false

		StoryController.instance:playStories({
			storyId
		}, param, self.closeThis, self)
	else
		self:closeThis()
	end
end

function Activity142GameView:_onToastUpdate(toastId)
	local actId = Va3ChessModel.instance:getActId()

	if actId ~= Va3ChessEnum.ActivityId.Act142 then
		return
	end

	local co = Va3ChessConfig.instance:getTipsCfg(actId, toastId)

	if not co then
		return
	end

	if co.audioId and co.audioId ~= 0 then
		AudioMgr.instance:trigger(co.audioId)
	end

	TaskDispatcher.cancelTask(self._onHideToast, self)
	TaskDispatcher.runDelay(self._onHideToast, self, TOAST_TIME)

	self._txtTips.text = co.tips

	gohelper.setActive(self._goTips, true)
end

function Activity142GameView:_onHideToast()
	gohelper.setActive(self._goTips, false)
end

function Activity142GameView:_btnBackTrackOnClick()
	if Va3ChessGameController.instance:isNeedBlock() then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.Activity142BackTrace, MsgBoxEnum.BoxType.Yes_No, self.back2CheckPointWithEff, nil, nil, self)
end

function Activity142GameView:_btnResetBtnOnClick()
	if Va3ChessGameController.instance:isNeedBlock() then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.PushBoxReset, MsgBoxEnum.BoxType.Yes_No, self.resetWithEff, nil, nil, self)
end

function Activity142GameView:_editableInitView()
	return
end

function Activity142GameView:onOpen()
	self:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.chess_activity142.EnterGameView)
end

function Activity142GameView:_getEpisodeCfg()
	local actId = Va3ChessModel.instance:getActId()
	local episodeId = Va3ChessModel.instance:getEpisodeId()

	if self._episodeCfg and self._episodeCfg.activity == actId and self._episodeCfg.id == episodeId then
		return self._episodeCfg
	end

	if actId ~= nil and episodeId ~= nil then
		self._episodeCfg = Va3ChessConfig.instance:getEpisodeCo(actId, episodeId)

		return self._episodeCfg
	end
end

function Activity142GameView:refreshUI()
	local episodeCfg = self:_getEpisodeCfg()

	if episodeCfg then
		self._txtStage.text = episodeCfg.orderId
		self._txtTitle.text = episodeCfg.name
	end

	self:refreshConditions()
end

function Activity142GameView:refreshConditions()
	local episodeCfg = self:_getEpisodeCfg()

	if not episodeCfg then
		return
	end

	local actId = episodeCfg.activityId

	self._txtMainTargetDesc.text = episodeCfg.mainConditionStr

	local isFinishAllMainCon = Activity142Helper.checkConditionIsFinish(episodeCfg.mainConfition, actId)

	if self._lastIsFinishAllMainCon ~= isFinishAllMainCon then
		self._lastIsFinishAllMainCon = isFinishAllMainCon

		self:_isTriggerFinish(isFinishAllMainCon, self._goMainTargetLightIcon, nil, self._goMainTargetFinishEff)
	end

	self._txtSubTargetDesc.text = episodeCfg.conditionStr

	local isFinishAllSubCon = Activity142Helper.checkConditionIsFinish(episodeCfg.extStarCondition, actId)

	if self._lastIsFinishAllSubCon ~= isFinishAllSubCon then
		self._lastIsFinishAllSubCon = isFinishAllSubCon

		self:_isTriggerFinish(isFinishAllSubCon, self._goSubTargetLightIcon, nil, self._goSubTargetFinishEff)
	end
end

function Activity142GameView:_isTriggerFinish(isFinish, iconGO, bgGO, effGO)
	if not gohelper.isNil(iconGO) then
		gohelper.setActive(iconGO, isFinish)
	end

	if not gohelper.isNil(bgGO) then
		gohelper.setActive(bgGO, isFinish)
	end

	if not gohelper.isNil(effGO) then
		if isFinish then
			gohelper.setActive(effGO, false)
			gohelper.setActive(effGO, true)
		else
			gohelper.setActive(effGO, false)
		end
	end
end

function Activity142GameView:back2CheckPointWithEff(isFail)
	Activity142Helper.setAct142UIBlock(true, Activity142Enum.RETURN_CHECK_POINT)

	if isFail then
		Activity142StatController.instance:statFail()
	else
		Activity142StatController.instance:statBack2CheckPoint()
	end

	self._playCloseEyeAnim(self, true, self.beginBack2CheckPoint, self)
end

function Activity142GameView:beginBack2CheckPoint()
	Activity142Controller.instance:act142Back2CheckPoint(self.onBackCheckPointCb, self)
end

function Activity142GameView:onBackCheckPointCb(cmd, resultCode, msg)
	TaskDispatcher.cancelTask(self.back2CheckPointFinish, self)
	TaskDispatcher.runDelay(self.back2CheckPointFinish, self, Activity142Enum.GAME_VIEW_CLOSE_EYE_TIME)
end

function Activity142GameView:back2CheckPointFinish()
	self._playCloseEyeAnim(self, false, self.back2CheckPointWithEffComplete, self)
end

function Activity142GameView:back2CheckPointWithEffComplete()
	Activity142Helper.setAct142UIBlock(false, Activity142Enum.RETURN_CHECK_POINT)
end

function Activity142GameView:resetWithEff()
	Activity142Helper.setAct142UIBlock(true, Activity142Enum.RESET_GAME)
	Activity142StatController.instance:statReset()
	self._playCloseEyeAnim(self, true, self.beginReset, self)
end

function Activity142GameView:beginReset()
	Activity142Controller.instance:act142ResetGame(self.onResetCb, self)
end

function Activity142GameView:onResetCb(cmd, resultCode, msg)
	TaskDispatcher.cancelTask(self.onResetFinish, self)
	TaskDispatcher.runDelay(self.onResetFinish, self, Activity142Enum.GAME_VIEW_CLOSE_EYE_TIME)
end

function Activity142GameView:onResetFinish()
	self._playCloseEyeAnim(self, false, self.resetWithEffComplete, self)
end

function Activity142GameView:resetWithEffComplete()
	Activity142Helper.setAct142UIBlock(false, Activity142Enum.RESET_GAME)
end

function Activity142GameView:_playCloseEyeAnim(isCloseEye, cb, cbObj)
	if gohelper.isNil(self._goCloseEyeEff) or gohelper.isNil(self._closeEyeAnimatorPlayer) then
		if cb then
			cb(cbObj)
		end

		return
	end

	gohelper.setActive(self._goCloseEyeEff, true)

	if isCloseEye then
		if not Activity142Enum.GAME_VIEW_EYE_CLOSE_ANIM then
			local animName = Activity142Enum.GAME_VIEW_EYE_OPEN_ANIM

			self._closeEyeAnimatorPlayer:Play(animName, cb, cbObj)

			if isCloseEye then
				AudioMgr.instance:trigger(AudioEnum.chess_activity142.CloseEye)
			end
		end
	end
end

function Activity142GameView:onClose()
	TaskDispatcher.cancelTask(self._onHideToast, self)
	TaskDispatcher.cancelTask(self.back2CheckPointFinish, self)
	TaskDispatcher.cancelTask(self.onResetFinish, self)
	self:back2CheckPointWithEffComplete()
	self:resetWithEffComplete()
end

return Activity142GameView
