-- chunkname: @modules/logic/versionactivity1_5/aizila/view/game/AiZiLaGameView.lua

module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameView", package.seeall)

local AiZiLaGameView = class("AiZiLaGameView", BaseView)

function AiZiLaGameView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Top/#txt_Title")
	self._txtHeight = gohelper.findChildText(self.viewGO, "Top/#txt_Height")
	self._txtRemainingTimesNum = gohelper.findChildText(self.viewGO, "LeftTop/RemainingTimes/#txt_RemainingTimesNum")
	self._txtTargetDesc = gohelper.findChildText(self.viewGO, "LeftTop/TargetList/TargetItem/#txt_TargetDesc")
	self._btnstate = gohelper.findChildButtonWithAudio(self.viewGO, "LeftBottm/#btn_state")
	self._btnpack = gohelper.findChildButtonWithAudio(self.viewGO, "LeftBottm/#btn_pack")
	self._btnequip = gohelper.findChildButtonWithAudio(self.viewGO, "LeftBottm/#btn_equip")
	self._txtInfo = gohelper.findChildText(self.viewGO, "RightTop/#txt_Info")
	self._txtdaydesc = gohelper.findChildText(self.viewGO, "RightTop/#txt_daydesc")
	self._btnforwardgame = gohelper.findChildButtonWithAudio(self.viewGO, "RightBottm/#btn_forwardgame")
	self._goCostBG = gohelper.findChild(self.viewGO, "RightBottm/#btn_forwardgame/#go_CostBG")
	self._txtforwardCost = gohelper.findChildText(self.viewGO, "RightBottm/#btn_forwardgame/#go_CostBG/#txt_forwardCost")
	self._goEnable = gohelper.findChild(self.viewGO, "RightBottm/#btn_forwardgame/#go_Enable")
	self._goDisable = gohelper.findChild(self.viewGO, "RightBottm/#btn_forwardgame/#go_Disable")
	self._btnexitgame = gohelper.findChildButtonWithAudio(self.viewGO, "RightBottm/#btn_exitgame")
	self._btnContinue = gohelper.findChildButtonWithAudio(self.viewGO, "RightBottm/#btn_Continue")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_BackBtns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AiZiLaGameView:addEvents()
	self._btnstate:AddClickListener(self._btnstateOnClick, self)
	self._btnpack:AddClickListener(self._btnpackOnClick, self)
	self._btnequip:AddClickListener(self._btnequipOnClick, self)
	self._btnforwardgame:AddClickListener(self._btnforwardgameOnClick, self)
	self._btnexitgame:AddClickListener(self._btnexitgameOnClick, self)
	self._btnContinue:AddClickListener(self._btnContinueOnClick, self)
end

function AiZiLaGameView:removeEvents()
	self._btnstate:RemoveClickListener()
	self._btnpack:RemoveClickListener()
	self._btnequip:RemoveClickListener()
	self._btnforwardgame:RemoveClickListener()
	self._btnexitgame:RemoveClickListener()
	self._btnContinue:RemoveClickListener()
end

function AiZiLaGameView:_btnContinueOnClick()
	if self:isLockOp() then
		return
	end

	ViewMgr.instance:openView(ViewName.AiZiLaGameEventView)
end

function AiZiLaGameView:_btnstateOnClick()
	if self:isLockOp() then
		return
	end

	ViewMgr.instance:openView(ViewName.AiZiLaGameStateView)
end

function AiZiLaGameView:_btnpackOnClick()
	if self:isLockOp() then
		return
	end

	ViewMgr.instance:openView(ViewName.AiZiLaGamePackView)
end

function AiZiLaGameView:_btnequipOnClick()
	if self:isLockOp() then
		return
	end

	ViewMgr.instance:openView(ViewName.AiZiLaEquipView)
end

function AiZiLaGameView:_btnforwardgameOnClick()
	if self:isLockOp() then
		return
	end

	local episodeMO = self:_getMO()

	if not episodeMO then
		GameFacade.showToast(ToastEnum.V1a5AiZiLaActionPointLack)

		return
	end

	self._isNeedShowBtnForwrdGame = false

	if self:_isNotForwardGame() then
		ViewMgr.instance:openView(ViewName.AiZiLaGameEventView)
		self:refreshUI()

		return
	end

	local costNum = self:_getCostActionPoint()

	if costNum > episodeMO.actionPoint then
		GameFacade.showToast(ToastEnum.V1a5AiZiLaActionPointLack)

		return
	end

	self:_setLockOpTime(0.2)
	AiZiLaGameController.instance:forwardGame()
end

function AiZiLaGameView:_btnexitgameOnClick()
	if self:isLockOp() then
		return
	end

	AiZiLaGameController.instance:exitGame()
end

function AiZiLaGameView:_editableInitView()
	self._goforwardgame = self._btnforwardgame.gameObject
	self._animator = self.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)
	self._animatorTop = gohelper.findChildComponent(self.viewGO, "Top", AiZiLaEnum.ComponentType.Animator)
	self._govxcost = gohelper.findChild(self.viewGO, "LeftTop/RemainingTimes/vx_cost")
	self._goRightBottm = gohelper.findChild(self.viewGO, "RightBottm")
	self._goRightTop = gohelper.findChild(self.viewGO, "RightTop")
	self._goTop = gohelper.findChild(self.viewGO, "Top")
	self._txtExit = gohelper.findChildText(self.viewGO, "RightBottm/#btn_exitgame/txt_Exit")
end

function AiZiLaGameView:onUpdateParam()
	return
end

function AiZiLaGameView:onOpen()
	if self.viewContainer then
		NavigateMgr.instance:addEscape(self.viewContainer.viewName, self._btnexitgameOnClick, self)
	end

	local hasGuide = not GuideController.instance:isForbidGuides() and GuideModel.instance:isGuideRunning(AiZiLaEnum.Guide.FirstEnter)

	self:_setLockOpTime(hasGuide and 4 or 0.6)
	self.addEventCb(self, AiZiLaController.instance, AiZiLaEvent.ExitGame, self.closeThis, self)
	self.addEventCb(self, AiZiLaGameController.instance, AiZiLaEvent.RefreshGameEpsiode, self._onRefreshGameEpsiode, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.DestroyViewFinish, self._onDestroyViewFinish, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)

	self._isNeedShowBtnForwrdGame = true

	self:_refreshParam()
	self:refreshUI()
	self:_setCurElevation(AiZiLaGameModel.instance:getElevation())
	self:_refreshActionPointUI()
	self:_playAnimtor(self._animatorTop, UIAnimationName.Open)
	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_wulu_aizila_level_enter)
end

function AiZiLaGameView:onClose()
	return
end

function AiZiLaGameView:onDestroyView()
	self:_killTween()
	self._simageFullBG:UnLoadImage()
end

function AiZiLaGameView:_onRefreshGameEpsiode()
	self._isHasNeedRefresh = true

	self:refreshUI()
	self:_refreshActionPointUI()
end

function AiZiLaGameView:_onOpenView(viewName)
	self:_refreshGoShow()
end

function AiZiLaGameView:_onDestroyViewFinish(viewName)
	self:_refreshGoShow()

	if self._isHasNeedRefresh and viewName == ViewName.AiZiLaGameEventResult then
		self._isHasNeedRefresh = false

		self:refreshUI()
		self:_refreshAnimUI()

		local episodeMO = self:_getMO()

		if episodeMO:isPass() then
			AiZiLaController.instance:dispatchEvent(AiZiLaEvent.CloseGameEventResult)
		end
	end
end

function AiZiLaGameView:_refreshGoShow()
	local isHide = ViewMgr.instance:isOpen(ViewName.AiZiLaGameEventResult) or ViewMgr.instance:isOpen(ViewName.AiZiLaGameEventView)
	local isShow = not isHide

	if self._lastIsShow ~= isShow then
		self._lastIsShow = isShow

		gohelper.setActive(self._goTop, isShow)
		gohelper.setActive(self._goRightBottm, isShow)
		gohelper.setActive(self._goRightTop, isShow)
	end
end

function AiZiLaGameView:_refreshParam()
	local episodeMO = self:_getMO()
	local targetIds = episodeMO and episodeMO:getTargetIds() or {}

	self._minEle = self:getElevation(targetIds[1]) or 0
	self._targetEle = self:getElevation(targetIds[2]) or 0
	self._maxEle = self:getElevation(targetIds[#targetIds]) or 0
	self._showElevation = self._showElevation or self._minEle
end

function AiZiLaGameView:needPlayRiseAnim()
	local curEle = AiZiLaGameModel.instance:getElevation()

	return self._showElevation and curEle > self._showElevation
end

function AiZiLaGameView:refreshUI()
	local episodeMO = self:_getMO()

	if not episodeMO then
		return
	end

	local episodeCfg = episodeMO:getConfig()

	if episodeCfg and self._lastEpisodeId ~= episodeCfg.episodeId and not string.nilorempty(episodeCfg.bgPath) then
		self._lastEpisodeId = episodeCfg.episodeId

		self._simageFullBG:LoadImage(string.format("%s.png", episodeCfg.bgPath))
	end

	self._txtInfo.text = episodeCfg and episodeCfg.name
	self._txtdaydesc.text = formatLuaLang("v1a5_aizila_day_explore", episodeMO.day)

	local isShowNext = not (self:_isNotForwardGame() and not self._isNeedShowBtnForwrdGame)

	gohelper.setActive(self._btnContinue, not isShowNext)
	gohelper.setActive(self._btnforwardgame, isShowNext)
	gohelper.setActive(self._btnContinue, not isShowNext)

	if isShowNext then
		local costAction = self:_getCostActionPoint()

		gohelper.setActive(self._txtforwardCost, costAction > 0)

		if episodeMO.actionPoint then
			local isgray = costAction > episodeMO.actionPoint
			local costStr = formatLuaLang("v1a5_aizila_action_point_cost", -costAction)

			if isgray then
				costStr = string.format("<color=#dc5f56>%s</color>", costStr)
			end

			self._txtforwardCost.text = costStr

			gohelper.setActive(self._goEnable, not isgray)
			gohelper.setActive(self._goDisable, isgray)
			ZProj.UGUIHelper.SetGrayscale(self._goforwardgame, isgray)
		end
	end

	local isSafe = episodeMO:isCanSafe()

	if self._lastIsSafe ~= isSafe then
		self._txtExit.text = luaLang(isSafe and "v1a5_aizila_safe_exit_game" or "v1a5_aizila_exit_game")
	end
end

function AiZiLaGameView:_refreshActionPointUI()
	local episodeMO = self:_getMO()

	if episodeMO then
		if not episodeMO.actionPoint then
			local actionPoint = 0

			actionPoint = math.max(0, actionPoint)

			if self._lastActionPoint and actionPoint < self._lastActionPoint then
				gohelper.setActive(self._govxcost, false)
				gohelper.setActive(self._govxcost, true)
			end

			self._lastActionPoint = actionPoint
			self._txtRemainingTimesNum.text = formatLuaLang("v1a5_aizila_action_point_tag", actionPoint)
		end
	end
end

function AiZiLaGameView:_refreshAnimUI()
	local curEle = AiZiLaGameModel.instance:getElevation()

	self:_killTween()

	if curEle > self._showElevation then
		local animName = "rise"

		self:_playAnimtor(self._animator, animName)
		self:_playAnimtor(self._animatorTop, animName)

		self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1, self._tweenFrameCallback, self._tweenFinishCallback, self, {
			startEle = self._showElevation,
			endEle = curEle
		})

		TaskDispatcher.runDelay(self._refreshActionPointUI, self, 2.4)
		self:_setLockOpTime(AiZiLaEnum.AnimatorTime.MapViewRise)
		AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.ui_wulu_aizila_elevationl_up)
	else
		self:_setCurElevation(curEle)
		self:_refreshActionPointUI()
	end
end

function AiZiLaGameView:_killTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil

		TaskDispatcher.cancelTask(self._refreshActionPointUI, self)
	end
end

function AiZiLaGameView:_tweenFrameCallback(value, param)
	self:_setCurElevation(math.floor((value >= 0.99 or nil) and param.endEle))
end

function AiZiLaGameView:_tweenFinishCallback(value, param)
	return
end

function AiZiLaGameView:_setCurElevation(curEle)
	curEle = math.max(self._minEle, curEle)
	self._showElevation = curEle
	self._txtTargetDesc.text = string.format("<color=#ffa632>%sm</color>/%sm", curEle, self._targetEle)
	self._txtHeight.text = string.format("%sm\n<size=34><color=#c5bfa8>%sm(MAX)</size></color>", curEle, self._maxEle)
end

function AiZiLaGameView:_playAnimtor(animator, animName)
	if animator then
		animator.enabled = true

		animator:Play(animName, 0, 0)
	end
end

function AiZiLaGameView:_getCostActionPoint()
	local episodeMO = self:_getMO()

	if not episodeMO then
		return 0
	end

	return episodeMO:getCostActionPoint()
end

function AiZiLaGameView:_isNotForwardGame()
	local episodeMO = self:_getMO()

	if episodeMO then
		return episodeMO.eventId ~= 0 and (episodeMO.optionResultId == 0 or episodeMO.option == 0)
	end

	return false
end

function AiZiLaGameView:getElevation(showtargetId)
	local cfg = AiZiLaConfig.instance:getEpisodeShowTargetCo(showtargetId)

	return (cfg or nil) and (cfg.elevation or 0)
end

function AiZiLaGameView:_getMO()
	return AiZiLaGameModel.instance:getEpisodeMO()
end

function AiZiLaGameView:_setLockOpTime(lockTime)
	self._lockTime = Time.time + lockTime
end

function AiZiLaGameView:isLockOp()
	if self._lockTime and Time.time < self._lockTime then
		return true
	end

	return false
end

return AiZiLaGameView
