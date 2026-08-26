-- chunkname: @modules/logic/fight/view/FightAutoBtnView.lua

module("modules.logic.fight.view.FightAutoBtnView", package.seeall)

local FightAutoBtnView = class("FightAutoBtnView", FightBaseView)

function FightAutoBtnView:onInitView()
	self.btn = gohelper.findButtonWithAudio(self.viewGO)
	self.lock = gohelper.findChild(self.viewGO, "lock")
	self.image = gohelper.findChildImage(self.viewGO, "image")
	self.autoAnimation = self.image:GetComponent(typeof(UnityEngine.Animation))
end

function FightAutoBtnView:addEvents()
	self:com_registClick(self.btn, self.onClick)
	self:com_registEvent(PCInputController.instance, PCInputEvent.NotifyBattleAutoFight, self.OnKeyAutoPress)
	self:com_registFightEvent(FightEvent.SetAutoState, self._updateAutoAnim)
	self:com_registFightEvent(FightEvent.OnGuideStopAutoFight, self._onGuideStopAutoFight)
	self:com_registFightEvent(FightEvent.GuideRecordAutoState, self.onGuideRecordAutoState)
	self:com_registFightEvent(FightEvent.GuideRefreshAutoStateByRecord, self.onGuideRefreshAutoStateByRecord)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyBattleAutoFight, self.onClick, self)
end

function FightAutoBtnView:OnKeyAutoPress()
	if not FightDataHelper.stateMgr.isReplay then
		self:onClick()
	end
end

function FightAutoBtnView:onClick()
	if FightDataHelper.stateMgr.isReplay then
		gohelper.setActive(self.viewGO, false)

		return
	end

	if FightDataHelper.stateMgr.forceAuto then
		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.PlaySeasonChangeHero) then
		return
	end

	if not FightDataHelper.stageMgr:isEmptyOperateState() then
		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightAuto) then
		local desc, param = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.FightAuto)

		GameFacade.showToast(desc, param)

		return
	end

	local battleId = FightDataHelper.fieldMgr.battleId
	local battleCO = battleId and lua_battle.configDict[battleId]
	local episodeCanAutoFight = battleCO and (not battleCO.noAutoFight or battleCO.noAutoFight == 0)

	if not episodeCanAutoFight then
		GameFacade.showToast(ToastEnum.EpisodeCantUse)

		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidAutoFight) then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightMoveCard) then
		return
	end

	local isAuto = not FightDataHelper.stateMgr:getIsAuto()

	FightDataHelper.stateMgr:setAutoState(isAuto)
	FightController.instance:setPlayerPrefKeyAuto(0, isAuto)
	self:_updateAutoAnim()

	if isAuto then
		FightGameMgr.operateMgr:requestAutoFight()
	end
end

function FightAutoBtnView:_onGuideStopAutoFight()
	FightDataHelper.stateMgr:setAutoState(false)
	self:_updateAutoAnim()
end

function FightAutoBtnView:onGuideRecordAutoState()
	self.guideRecordAutoState = FightDataHelper.stateMgr:getIsAuto()

	if self.forceAuto then
		self.guideRecordAutoState = true
	end
end

function FightAutoBtnView:onGuideRefreshAutoStateByRecord()
	if self.guideRecordAutoState then
		FightDataHelper.stateMgr:setAutoState(true)
		self:_updateAutoAnim()
		FightGameMgr.operateMgr:requestAutoFight()
	end
end

function FightAutoBtnView:_updateAutoAnim()
	if FightDataHelper.stateMgr:getIsAuto() then
		self.autoAnimation.enabled = true

		self.autoAnimation:Play()
	else
		self.autoAnimation:Stop()

		self.autoAnimation.enabled = false

		transformhelper.setLocalRotation(self.image.transform, 0, 0, 0)
	end
end

function FightAutoBtnView:onOpen()
	if FightDataHelper.stateMgr.isReplay then
		gohelper.setActive(self.viewGO, false)

		return
	end

	if not DungeonModel.instance:hasPassLevelAndStory(10101) then
		gohelper.setActive(self.viewGO, false)

		return
	end

	local battleId = FightDataHelper.fieldMgr.battleId
	local battleConfig = battleId and lua_battle.configDict[battleId]
	local episodeCanAutoFight = battleConfig and (not battleConfig.noAutoFight or battleConfig.noAutoFight == 0)
	local firstGuide = GuideModel.instance:isDoingFirstGuide()
	local forbidGuides = GuideController.instance:isForbidGuides()
	local hasOpenAuto = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightAuto) and (not firstGuide or forbidGuides)

	hasOpenAuto = hasOpenAuto and episodeCanAutoFight
	self.forceAuto = FightDataHelper.stateMgr.forceAuto

	gohelper.setActive(self.lock, self.forceAuto or FightDataHelper.fieldMgr:isDouQuQu())

	if hasOpenAuto then
		UISpriteSetMgr.instance:setFightSprite(self.image, "bt_zd", true)
	else
		UISpriteSetMgr.instance:setFightSprite(self.image, "zd_dis", true)
	end

	self:com_registTimer(self._updateAutoAnim, 0.01)
end

return FightAutoBtnView
