-- chunkname: @modules/logic/fight/view/FightView.lua

module("modules.logic.fight.view.FightView", package.seeall)

local FightView = class("FightView", BaseView)

function FightView:onInitView()
	self._rootGO = gohelper.findChild(self.viewGO, "root")
	self._topRightBtnRoot = gohelper.findChild(self.viewGO, "root/btns")
	self._btnBack = gohelper.findChildButtonWithAudio(self.viewGO, "root/btns/btnBack")
	self._btnSpecialTip = gohelper.findChildButtonWithAudio(self.viewGO, "root/btns/btnSpecialTip")
	self._btnSpeed = gohelper.findChildButtonWithAudio(self.viewGO, "root/btns/btnSpeed")
	self._imageSpeed = gohelper.findChildImage(self.viewGO, "root/btns/btnSpeed/image")
	self._btnCareerRestrain = gohelper.findChildButtonWithAudio(self.viewGO, "root/btnRestraintInfo")
	self._roundGO = gohelper.findChild(self.viewGO, "root/topLeftContent/imgRound")
	self.roundAnimator = gohelper.onceAddComponent(self._roundGO, typeof(UnityEngine.Animator))
	self._txtWave = gohelper.findChildText(self.viewGO, "root/topLeftContent/imgRound/txtWave")
	self._txtRound = gohelper.findChildText(self.viewGO, "root/topLeftContent/imgRound/txtRound")
	self._txtRound_add = gohelper.findChildText(self.viewGO, "root/topLeftContent/imgRound/txtRound_add")
	self._txtSpeed = gohelper.findChildText(self.viewGO, "root/btns/btnSpeed/Text")
	self._goReplay = gohelper.findChild(self.viewGO, "root/#go_replay")
	self._goEnemyNum = gohelper.findChild(self.viewGO, "root/enemynum")
	self._txtEnemyNum = gohelper.findChildText(self.viewGO, "root/enemynum/#txt_enemynum")
	self._enemyinfoRoot = gohelper.findChild(self.viewGO, "root/topLeftContent/enemyinfo")
	self._enemyActionRoot = gohelper.findChild(self.viewGO, "root/topLeftContent/enemyaction")
	self.enemyActionNormal = gohelper.findChild(self.viewGO, "root/topLeftContent/enemyaction/normal")
	self.enemyActionSelect = gohelper.findChild(self.viewGO, "root/topLeftContent/enemyaction/selected")
	self.enemyActionLocked = gohelper.findChild(self.viewGO, "root/topLeftContent/enemyaction/locked")
	self.btnEnemyAction = gohelper.findChildButtonWithAudio(self.viewGO, "root/topLeftContent/enemyaction/#btn_enemyaction")
	self.weeklyWalkSubEnemy = gohelper.findChild(self.viewGO, "root/enemyweekwalkheart")
	self.btnCheckSub = gohelper.findChildClickWithDefaultAudio(self.viewGO, "root/enemyweekwalkheart/btn_checkSub")
end

function FightView:addEvents()
	self._btnBack:AddClickListener(self._onClickBack, self)
	self._btnSpeed:AddClickListener(self._onClickSpeed, self)
	self._btnSpecialTip:AddClickListener(self._onClickBtnSpecialTip, self)
	self._btnCareerRestrain:AddClickListener(self._onClickCareerRestrain, self)
	self.btnEnemyAction:AddClickListener(self.onClickEnemyAction, self)
	self.addClickCb(self, self.btnCheckSub, self.onBtnCheckSub, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnCombineCardEnd, self._onBlockOperateEnd, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnUniversalAppear, self._onBlockOperateEnd, self)
	self.addEventCb(self, FightController.instance, FightEvent.SetIsShowUI, self._setIsShowUI, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnChangeEntity, self._onChangeEntity, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnBeginWave, self._onBeginWave, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnFightReconnectLastWork, self._onFightReconnectLastWork, self)
	self.addEventCb(self, FightController.instance, FightEvent.GMHideFightView, self._onGMShowChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.SetStateForDialogBeforeStartFight, self._onSetStateForDialogBeforeStartFight, self)
	self.addEventCb(self, FightController.instance, FightEvent.StageChanged, self.onStageChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.RefreshUIRound, self._onRefreshUIRound, self)
	self.addEventCb(self, FightController.instance, FightEvent.AddSubEntity, self._onAddSubEntity, self)
	self.addEventCb(self, FightController.instance, FightEvent.ClearMonsterSub, self._onClearMonsterSub, self)
	self.addEventCb(self, FightController.instance, FightEvent.RefreshMonsterSubCount, self._onRefreshMonsterSubCount, self)
	self.addEventCb(self, FightController.instance, FightEvent.SetBtnListVisibleWhenHidingFightView, self.onSetBtnListVisibleWhenHidingFightView, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnStartSequenceFinish, self.onStartSequenceFinish, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, FightController.instance, FightEvent.ChangeRound, self._onChangeRound, self)
	self.addEventCb(self, FightController.instance, FightEvent.RefreshMaxRoundUI, self.onRefreshMaxRoundUI, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyBattleOpentips, self._onClickBack, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyBattleSpeedUp, self._onClickSpeed, self)
end

function FightView:removeEvents()
	self._btnBack:RemoveClickListener()
	self._btnSpecialTip:RemoveClickListener()
	self._btnSpeed:RemoveClickListener()
	self._btnCareerRestrain:RemoveClickListener()
	self.btnEnemyAction:RemoveClickListener()
	self.removeEventCb(self, FightController.instance, FightEvent.OnCombineCardEnd, self._onBlockOperateEnd, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnUniversalAppear, self._onBlockOperateEnd, self)
	self.removeEventCb(self, FightController.instance, FightEvent.SetIsShowUI, self._setIsShowUI, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnChangeEntity, self._onChangeEntity, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnBeginWave, self._onBeginWave, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnFightReconnectLastWork, self._onFightReconnectLastWork, self)
	self.removeEventCb(self, FightController.instance, FightEvent.GMHideFightView, self._onGMShowChange, self)
	self.removeEventCb(self, FightController.instance, FightEvent.SetStateForDialogBeforeStartFight, self._onSetStateForDialogBeforeStartFight, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.removeEventCb(self, FightController.instance, FightEvent.ChangeRound, self._onChangeRound, self)
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyBattleOpentips, self._onClickBack, self)
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyBattleSpeedUp, self._onClickSpeed, self)
end

function FightView:onStartSequenceFinish()
	self:_showEnemySubCount()
end

function FightView:onOpen()
	local episodeId = FightModel.instance:getFightParam().episodeId
	local battleId = FightModel.instance:getFightParam().battleId

	self:_updateRound()
	self:_updateReplay()

	local firstGuide = GuideModel.instance:isDoingFirstGuide()
	local forbidGuides = GuideController.instance:isForbidGuides()
	local hasOpenSpeed = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightSpeed) and (not firstGuide or forbidGuides)
	local isBackShow = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightBack) and (not firstGuide or forbidGuides)

	gohelper.setActive(self._btnSpecialTip.gameObject, FightView.canShowSpecialBtn())

	if not hasOpenSpeed and (episodeId == OpenConfig.instance:getOpenCo(OpenEnum.UnlockFunc.FightSpeed).episodeId or GuideModel.instance:isGuideFinish(110)) then
		hasOpenSpeed = true
	end

	if hasOpenSpeed then
		if FightDataHelper.stateMgr.isReplay then
			FightModel.instance:setUserSpeed(2)
		else
			local speed = PlayerPrefsHelper.getNumber(self:_getPlayerPrefKeySpeed(), 1)

			if FightDataHelper.fieldMgr:isRouge2() then
				local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Rouge2EnterBattled)
				local value = PlayerPrefsHelper.getNumber(key, 0)

				if value ~= 1 then
					speed = FightModel.instance:getMaxSpeed()

					PlayerPrefsHelper.setNumber(key, 1)
				end
			end

			if FightDataHelper.fieldMgr:isSurvival() or FightDataHelper.fieldMgr:isShelter() then
				local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.SurvivalEnterBattled)
				local value = PlayerPrefsHelper.getNumber(key, 0)

				if value ~= 1 then
					speed = FightModel.instance:getMaxSpeed()

					PlayerPrefsHelper.setNumber(key, 1)
				end
			end

			FightModel.instance:setUserSpeed(speed)
		end
	else
		FightModel.instance:setUserSpeed(1)
	end

	self:_updateSpeed()
	FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
	gohelper.setActive(self._btnSpeed.gameObject, hasOpenSpeed)
	gohelper.setActive(self._btnCareerRestrain.gameObject, false)
	gohelper.setActive(self._btnBack.gameObject, isBackShow)
	gohelper.setActive(self._roundGO, isBackShow and GMFightShowState.topRightRound)
	NavigateMgr.instance:addEscape(ViewName.FightView, self._onEscapeBtnClick, self)
	gohelper.setActive(self._goEnemyNum, false)
	gohelper.setActive(self.weeklyWalkSubEnemy, false)
	self:initEnemyActionStatus()
	self:_refreshDouQuQu()
end

function FightView:_refreshDouQuQu()
	local isDouQuQu = FightDataHelper.fieldMgr:isDouQuQu() or FightDataHelper.fieldMgr:is191DouQuQu()

	if isDouQuQu then
		gohelper.setActive(self._enemyinfoRoot, false)

		if FightDataModel.instance.douQuQuMgr and FightDataModel.instance.douQuQuMgr.isRecord then
			return
		end

		if FightDataHelper.fieldMgr:is191DouQuQu() then
			return
		end

		gohelper.setActive(self._btnBack.gameObject, false)
		NavigateMgr.instance:removeEscape(ViewName.FightView)
	end
end

function FightView:initEnemyActionStatus()
	local isOpen = self:checkEnemyActionIsOpen()

	if isOpen then
		self:setEnemyActionStatus(FightEnum.EnemyActionStatus.Normal)
	else
		self:setEnemyActionStatus(FightEnum.EnemyActionStatus.NotOpen)
	end
end

function FightView:checkEnemyActionIsOpen()
	local battleId = FightModel.instance:getBattleId()
	local battleCo = battleId and lua_battle.configDict[battleId]

	if not battleCo then
		return false
	end

	if battleCo.aiLink ~= 0 then
		return true
	end

	if battleCo.actShow ~= 0 then
		return true
	end

	return false
end

function FightView:onClose()
	FightModel.instance:setUserSpeed(1)
	TaskDispatcher.cancelTask(self._showBtnSpeedAni, self, 0.001)
end

function FightView:_setIsShowUI(isVisible)
	self._canvasGroup = self._canvasGroup or gohelper.onceAddComponent(self._rootGO, typeof(UnityEngine.CanvasGroup))

	if FightDataHelper.tempMgr.aiJiAoSelectTargetView then
		isVisible = false
	end

	gohelper.setActiveCanvasGroup(self._canvasGroup, isVisible)
end

function FightView:_onOpenView(viewName)
	return
end

function FightView:_onCloseView(viewName)
	if viewName == ViewName.FightFocusView then
		TaskDispatcher.runDelay(self._resetCamera, self, 0.16)
	end

	if viewName == ViewName.FightEnemyActionView and self.actionStatus == FightEnum.EnemyActionStatus.Select then
		self:setEnemyActionStatus(FightEnum.EnemyActionStatus.Normal)
	end
end

function FightView:_onBlockOperateEnd()
	if self._blockOperate then
		self._blockOperate = nil
	end
end

function FightView:_updateSpeed()
	local speed = FightModel.instance:getUserSpeed()
	local speedShow = Mathf.Clamp(speed, 1, FightModel.instance:getMaxSpeed())

	UISpriteSetMgr.instance:setFightSprite(self._imageSpeed, "btn_x" .. speedShow, true)

	self._txtSpeed.text = string.format("X%d", speedShow)

	TaskDispatcher.runDelay(self._showBtnSpeedAni, self, 0.001)
end

function FightView:_showBtnSpeedAni()
	local speed = FightModel.instance:getUserSpeed()
	local play_name = speed == 1 and "idle" or "click"

	self._btnSpeed:GetComponent(typeof(UnityEngine.Animator)):Play(play_name)
end

function FightView:_onRefreshUIRound()
	self:_updateRound()
end

function FightView:_updateRound()
	self:_refreshWaveUI()
	self:_refreshRoundUI()
	self:_showEnemySubHeroCount()
end

function FightView:_refreshWaveUI()
	local maxWave = FightModel.instance.maxWave
	local curWaveId = FightModel.instance:getCurWaveId()

	curWaveId = math.min(curWaveId, maxWave)

	if FightDataHelper.fieldMgr:isDouQuQu() then
		local dataMgr = FightDataModel.instance.douQuQuMgr

		curWaveId = dataMgr.index or 1
		maxWave = dataMgr.maxIndex or 1
	end

	self._txtWave.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("fight_wave_lang"), curWaveId, maxWave)
end

function FightView:_refreshRoundUI()
	local maxRound = FightModel.instance:getMaxRound() + FightDataHelper.fieldMgr.maxRoundOffset
	local curRound = FightModel.instance:getCurRoundId()

	curRound = math.min(curRound, maxRound)
	self._txtRound.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("fight_round_lang"), curRound, maxRound)
end

function FightView:_onChangeRound()
	self:_refreshRoundUI()
end

function FightView:onRefreshMaxRoundUI(offsetNum)
	if offsetNum > 0 then
		self._txtRound_add.text = "+" .. offsetNum or offsetNum
	end

	self.roundAnimator:Play("add", 0, 0)
	self:_refreshRoundUI()
end

function FightView:_showEnemySubHeroCount()
	local subList = FightDataHelper.entityMgr:getEnemySubList()

	self._txtEnemyNum.text = #subList

	if #subList > 0 then
		FightController.instance:dispatchEvent(FightEvent.OnGuideShowEnemyNum)
	end

	local customData = FightDataHelper.fieldMgr.customData
	local limitless = customData and customData[FightCustomData.CustomDataType.WeekwalkVer2]

	if limitless then
		self._txtEnemyNum.text = "∞"
	end
end

function FightView:onBtnCheckSub()
	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	local customData = FightDataHelper.fieldMgr.customData
	local limitless = customData and customData[FightCustomData.CustomDataType.WeekwalkVer2]

	if limitless then
		ViewMgr.instance:openView(ViewName.FightWeekWalkEnemyTipsView)
	end
end

function FightView:_showEnemySubCount()
	if FightDataHelper.entityMgr:checkSideHasBuffAct(FightEnum.EntitySide.EnemySide, FightEnum.BuffActId.CycleToSub) then
		gohelper.setActive(self._goEnemyNum, false)
		gohelper.setActive(self.weeklyWalkSubEnemy, true)

		return
	end

	local subList = FightDataHelper.entityMgr:getEnemySubList()
	local gmLeftMonster = GMFightShowState.leftMonster

	gohelper.setActive(self._goEnemyNum, #subList > 0 and gmLeftMonster)
	gohelper.setActive(self.weeklyWalkSubEnemy, false)
end

function FightView:_onAddSubEntity()
	self:_showEnemySubCount()
	self:_showEnemySubHeroCount()
end

function FightView:_onClearMonsterSub()
	self:_showEnemySubHeroCount()
end

function FightView:_onRefreshMonsterSubCount()
	self:_showEnemySubHeroCount()
end

function FightView:_onBeginWave()
	self:_showEnemySubCount()
	self:_refreshWaveUI()
end

function FightView:_onChangeEntity()
	self:_showEnemySubHeroCount()
end

function FightView:_updateReplay()
	gohelper.setActive(self._goReplay, FightDataHelper.stateMgr.isReplay)
end

function FightView:_onEscapeBtnClick()
	if self._btnBack.gameObject.activeInHierarchy then
		self:_onClickBack()
	end
end

function FightView:_onClickBack()
	if FightDataMgr.instance.stateMgr:isPlayingEnd() then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightBack) then
		local desc, param = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.FightBack)

		GameFacade.showToast(desc, param)

		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidAutoFight) then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightMoveCard) then
		return
	end

	local inDistribute = FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DistributeCard)

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.Enter) or inDistribute then
		local guideList = GuideModel.instance:getDoingGuideIdList()

		if guideList and #guideList > 0 then
			return
		end
	end

	GameSceneMgr.instance:getCurScene().camera:enablePostProcessSmooth(false)
	ViewMgr.instance:openView(ViewName.FightQuitTipView)
end

function FightView:onSetBtnListVisibleWhenHidingFightView(state, showBtnNames)
	local transform = self._topRightBtnRoot.transform

	if not self.originBtnPosX then
		self.originBtnPosX = recthelper.getAnchorX(transform)
		self.btnRootSiblingIndex = gohelper.getSibling(self._topRightBtnRoot) - 1

		local var_33_0

		if state then
			var_33_0 = self.viewGO or self._rootGO
		end
	end

	gohelper.addChild(var_33_0, self._topRightBtnRoot)
	recthelper.setAnchorX(transform, self.originBtnPosX)
	gohelper.setSibling(self._topRightBtnRoot, self.btnRootSiblingIndex)

	if showBtnNames then
		if not self.originBtnVisibleNames then
			self.originBtnVisibleNames = {}

			for i = 0, transform.childCount - 1 do
				local child = transform:GetChild(i)

				self.originBtnVisibleNames[child.name] = child.gameObject.activeSelf
			end
		end

		if state then
			for i = 0, transform.childCount - 1 do
				local child = transform:GetChild(i)

				gohelper.setActive(child.gameObject, tabletool.indexOf(showBtnNames, child.name))
			end
		else
			for i = 0, transform.childCount - 1 do
				local child = transform:GetChild(i)

				gohelper.setActive(child.gameObject, self.originBtnVisibleNames[child.name])
			end
		end
	end
end

function FightView:_onClickSpeed()
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidSpeed) then
		return
	end

	local newSpeed = FightModel.instance:addSpeed()

	PlayerPrefsHelper.setNumber(self:_getPlayerPrefKeySpeed(), newSpeed)
	FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
	self:_updateSpeed()
end

function FightView:onOpenSpecialTip()
	if ViewMgr.instance:isOpen(ViewName.FightSpecialTipView) then
		ViewMgr.instance:closeView(ViewName.FightSpecialTipView)

		return
	end

	self:_onClickBtnSpecialTip()
end

function FightView:_onClickBtnSpecialTip()
	local guideFlag = GuideModel.instance:getFlagValue(GuideModel.GuideFlag.FightForbidClickOpenView)

	if guideFlag then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightMoveCard) then
		return
	end

	local doingGuideIdList = GuideModel.instance:getDoingGuideIdList()

	if doingGuideIdList then
		if not #doingGuideIdList then
			local doingGuideIdCount = 0

			if not FightModel.instance:isStartFinish() and doingGuideIdCount > 0 then
				return
			end

			FightController.instance:openFightSpecialTipView()
		end
	end
end

function FightView:_getPlayerPrefKeySpeed()
	return PlayerPrefsKey.FightSpeed .. PlayerModel.instance:getPlayinfo().userId
end

function FightView:_onClickCareerRestrain()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightProperty) then
		local desc, param = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.FightProperty)

		GameFacade.showToast(desc, param)

		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightMoveCard) then
		return
	end

	ViewMgr.instance:openView(ViewName.HeroGroupCareerTipView)
end

function FightView:_onFightReconnectLastWork()
	gohelper.setActive(self._btnSpecialTip.gameObject, FightView.canShowSpecialBtn())
end

function FightView:_onGMShowChange()
	self:_showEnemySubCount()
end

function FightView:onDestroyView()
	TaskDispatcher.cancelTask(self._resetCamera, self)
end

function FightView.canShowSpecialBtn()
	local canShow = FightWorkBeforeStartNoticeView.canShowTips()

	if not canShow then
		local episodeId = FightModel.instance:getFightParam().episodeId
		local episode_config = DungeonConfig.instance:getEpisodeCO(episodeId)
		local episodeType = episode_config and episode_config.type

		if Activity104Model.instance:isSeasonEpisodeType(episodeType) then
			local list = Activity104Model.instance:getFightCardDataList()

			canShow = list and #list > 0
		elseif Season123Controller.canUse123EquipEpisodeType(episodeType) then
			local list = Season123Model.instance:getFightCardDataList()

			canShow = list and #list > 0
		end
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidRoundView) then
		canShow = false
	end

	return canShow
end

function FightView:_resetCamera()
	FightController.instance:dispatchEvent(FightEvent.SetIsShowUI, true)
	FightMsgMgr.sendMsg(FightMsgId.CameraFocusChanged, false)
	FightController.instance:dispatchEvent(FightEvent.OnCameraFocusChanged, false)

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight or GameSceneMgr.instance:isClosing() then
		return
	end

	local entityList = FightHelper.getAllEntitys()

	for _, oneEntity in ipairs(entityList) do
		oneEntity:setVisibleByPos(true)

		if oneEntity.buff then
			oneEntity.buff:hideBuffEffects()
			oneEntity.buff:showBuffEffects()
		end

		if oneEntity.nameUI then
			oneEntity.nameUI:setActive(true)
		end
	end

	local fightScene = GameSceneMgr.instance:getScene(SceneType.Fight)

	FightGameMgr.sceneLevelMgr:setFrontVisible(true)
	fightScene.camera:setSceneCameraOffset()
end

function FightView:_onSetStateForDialogBeforeStartFight(state)
	gohelper.setActive(self._topRightBtnRoot, not state)
	gohelper.setActive(self._roundGO, not state)

	if FightDataHelper.fieldMgr:isDouQuQu() or FightDataHelper.fieldMgr:is191DouQuQu() then
		gohelper.setActive(self._enemyinfoRoot, false)
	else
		gohelper.setActive(self._enemyinfoRoot, not state)
	end

	self:refreshEnemyAction(not state)
end

function FightView:refreshEnemyAction(show)
	if self.actionStatus == FightEnum.EnemyActionStatus.NotOpen then
		gohelper.setActive(self._enemyActionRoot, false)

		return
	end

	gohelper.setActive(self._enemyActionRoot, show)
	gohelper.setActive(self.enemyActionNormal, self.actionStatus == FightEnum.EnemyActionStatus.Normal)
	gohelper.setActive(self.enemyActionSelect, self.actionStatus == FightEnum.EnemyActionStatus.Select)
	gohelper.setActive(self.enemyActionLocked, self.actionStatus == FightEnum.EnemyActionStatus.Lock)
end

function FightView:onStageChange()
	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Operate then
		self:_showEnemySubCount()
	end

	if self.actionStatus == FightEnum.EnemyActionStatus.NotOpen then
		return
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		self:setEnemyActionStatus(FightEnum.EnemyActionStatus.Lock)
	else
		self:setEnemyActionStatus(FightEnum.EnemyActionStatus.Normal)
	end
end

function FightView:setEnemyActionStatus(status)
	self.actionStatus = status

	FightController.instance:dispatchEvent(FightEvent.OnEnemyActionStatusChange, self.actionStatus)
	self:refreshEnemyAction(true)
end

function FightView:onClickEnemyAction()
	if self.actionStatus ~= FightEnum.EnemyActionStatus.Normal then
		return
	end

	if self:checkMonsterCardIsEmpty() then
		return
	end

	self:setEnemyActionStatus(FightEnum.EnemyActionStatus.Select)
	ViewMgr.instance:openView(ViewName.FightEnemyActionView)
end

function FightView:checkMonsterCardIsEmpty()
	local roundData = FightDataHelper.roundMgr:getRoundData()
	local cardList = roundData and roundData:getAIUseCardMOList()

	if cardList then
		for _, cardMo in ipairs(cardList) do
			local entityMo = FightDataHelper.entityMgr:getById(cardMo.uid)

			if entityMo then
				return false
			end
		end
	end

	return true
end

return FightView
