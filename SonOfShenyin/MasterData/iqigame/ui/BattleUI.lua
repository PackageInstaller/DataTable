-- chunkname: @IQIGame\\UI\\BattleUI.lua

local BattleSkillInfoView = require("IQIGame.UI.Battle.BattleSkillInfoView")
local BattleSkillView = require("IQIGame.UI.Battle.BattleSkillView")
local BattleTeamActionsView = require("IQIGame.UI.Battle.BattleTeamActionsView")
local BattleConfirmActionView = require("IQIGame.UI.Battle.BattleConfirmActionView")
local BattleUnitDetailView = require("IQIGame.UI.Battle.BattleUnitDetailView")
local BattleAnimationView = require("IQIGame.UI.Battle.BattleAnimationView")
local BattleReservesView = require("IQIGame.UI.Battle.BattleReservesView")
local BattleDialogView = require("IQIGame.UI.Battle.BattleDialogView")
local BattleSkillSelectTargetView = require("IQIGame.UI.Battle.BattleSkillSelectTargetView")
local BattleHUDView = require("IQIGame/UI/Battle/BattleHUD/BattleHUDView")
local BattleSkillNotifyView = require("IQIGame/UI/Battle/BattleSkillNotifyView")
local BattleUICutinView = require("IQIGame.UI.Battle.BattleUICutinView")
local BattleAutoFightView = require("IQIGame/UI/Battle/BattleAutoFightView")
local BattleBossInfoView = require("IQIGame/UI/Battle/BattleBossInfoView")
local BattleCommonAPView = require("IQIGame/UI/Battle/BattleCommonAPView")
local BattleWaveProgressView = require("IQIGame/UI/Battle/BattleWaveProgressView")
local BattleSkillPreviewView = require("IQIGame/UI/Battle/BattleSkillPreviewView")
local BattleUI = Base:Extend("BattleUI", "IQIGame.Onigao.UI.BattleUI", {})

function BattleUI:OnInit()
	if PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.HideUIControl) == "true" then
		self.debugModule.gameObject:SetActive(true)
	else
		self.debugModule.gameObject:SetActive(false)
	end

	self:__OnInit()
	self:__OnInitDelegateFunc()
	self:InitPreloadAssets()
end

function BattleUI:GetPreloadAssetPaths()
	return BattleScatteredResModule.GetScatteredResPaths()
end

function BattleUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function BattleUI:IsManualShowOnOpen(userData)
	return false
end

function BattleUI:GetBGM(userData)
	return nil
end

function BattleUI:OnOpen(userData)
	self:__OnUIOpen(userData)

	if StoryModule.IsHideBattleButton then
		self:SetRightTopPanelShow(false)

		StoryModule.IsHideBattleButton = false
	end
end

function BattleUI:OnClose(userData)
	self:DestroyPlayerSkill()
	self.battleSkillInfoView:OnClose()
	self.battleSkillView:OnClose()
	self.battleTeamActionsView:OnClose()
	self.battleConfirmActionView:OnClose()
	self.battleUnitDetailView:OnClose()
	self:__CloseHUD()
end

function BattleUI:OnAddListeners()
	self.autoButton:GetComponent(typeof(UnityEngine.UI.Button)).onClick:AddListener(self.delegateChangeAuto)
	self.speedButton:GetComponent(typeof(UnityEngine.UI.Button)).onClick:AddListener(self.delegateChangeSpeed)
	self.pauseButton:GetComponent(typeof(UnityEngine.UI.Button)).onClick:AddListener(self.delegatePauseBattle)
	self.PlayerSkillBtn:GetComponent("Button").onClick:AddListener(self.__OnPlayerSKillBtnClickEventProxy)
	self.helpBtn:GetComponent("Button").onClick:AddListener(self.__OnBattleHelperBtnClick)
	EventDispatcher.AddEventListener(EventID.ActiveBattleUI, self.delegateActiveBattleUI)
	EventDispatcher.AddEventListener(EventID.BattleWaveSetBlackScreen, self.delegateOnSetBlackScreenActive)
	EventDispatcher.AddEventListener(EventID.BattleUpdateWave, self.delegateOnUpdateWave)
	EventDispatcher.AddEventListener(EventID.BattleUpdateRound, self.delegateOnUpdateRound)
	EventDispatcher.AddEventListener(EventID.ReservesUpdate, self.delegateReservesUpdate)
	EventDispatcher.AddEventListener(EventID.ShowTotalDamageNumber, self.delegateOnShowTotalDamageNumber)
	EventDispatcher.AddEventListener(EventID.ShowCommonDamageNumber, self.delegateOnShowCommonDamageEffect)
	EventDispatcher.AddEventListener(EventID.ShowBattleDialog, self.delegateOnShowBattleDialog)
	EventDispatcher.AddEventListener(EventID.BattleShowPlaySkillNotify, self.delegateOnShowPlaySkillNotify)
	EventDispatcher.AddEventListener(EventID.BattleShowPlaySkillCutin, self.delegateOnShowSkillCutin)
	EventDispatcher.AddEventListener(EventID.OnBattleUnitSetTurnOrder, self.delegateOnBattleUnitSetTurnOrder)
	EventDispatcher.AddEventListener(EventID.BattleUnitSelectedOrderEvent, self.delegateOnBattleUnitSelectedOrder)
	EventDispatcher.AddEventListener(EventID.OnBattleUnitSelectedSkill, self.delegateOnBattleUnitSelectedSkill)
	EventDispatcher.AddEventListener(EventID.OnBattleUnitSelectedTarget, self.delegateOnBattleUnitSelectedTarget)
	EventDispatcher.AddEventListener(EventID.OnBattleUnitOrderComplete, self.delegateOnBattleUnitOrderComplete)
	EventDispatcher.AddEventListener(EventID.BattleUnitJoinFight, self.delegateOnBattleUnitJoinFight)
	EventDispatcher.AddEventListener(EventID.ResetBattleUIShow, self.delegateOnResetBattleUIShow)
	EventDispatcher.AddEventListener(EventID.SetRightTopPanelShow, self.SetRightTopPanelShowDelegate)
	EventDispatcher.AddEventListener(EventID.ShowBattleUnitDetailView, self.delegateOnShowBattleUnitDetailView)
	EventDispatcher.AddEventListener(EventID.BattleUnitDead, self.delegateOnBattleUnitDead)
	EventDispatcher.AddEventListener(EventID.OnShowBossInfoView, self.delegateOnShowBossInfoView)
	EventDispatcher.AddEventListener(EventID.HideRoleSkillSelectView, self.delegateOnHideRoleSkillSelectView)
	EventDispatcher.AddEventListener(EventID.OnBattleTotalDamageChange, self.delegateOnBattleTotalDamageChange)
end

function BattleUI:OnRemoveListeners()
	self.speedButton:GetComponent(typeof(UnityEngine.UI.Button)).onClick:RemoveListener(self.delegateChangeSpeed)
	self.pauseButton:GetComponent(typeof(UnityEngine.UI.Button)).onClick:RemoveListener(self.delegatePauseBattle)
	self.autoButton:GetComponent(typeof(UnityEngine.UI.Button)).onClick:RemoveListener(self.delegateChangeAuto)
	self.PlayerSkillBtn:GetComponent("Button").onClick:RemoveListener(self.__OnPlayerSKillBtnClickEventProxy)
	self.helpBtn:GetComponent("Button").onClick:RemoveListener(self.__OnBattleHelperBtnClick)
	EventDispatcher.RemoveEventListener(EventID.ActiveBattleUI, self.delegateActiveBattleUI)
	EventDispatcher.RemoveEventListener(EventID.BattleWaveSetBlackScreen, self.delegateOnSetBlackScreenActive)
	EventDispatcher.RemoveEventListener(EventID.BattleUpdateWave, self.delegateOnUpdateWave)
	EventDispatcher.RemoveEventListener(EventID.BattleUpdateRound, self.delegateOnUpdateRound)
	EventDispatcher.RemoveEventListener(EventID.ReservesUpdate, self.delegateReservesUpdate)
	EventDispatcher.RemoveEventListener(EventID.ShowTotalDamageNumber, self.delegateOnShowTotalDamageNumber)
	EventDispatcher.RemoveEventListener(EventID.ShowCommonDamageNumber, self.delegateOnShowCommonDamageEffect)
	EventDispatcher.RemoveEventListener(EventID.ShowBattleDialog, self.delegateOnShowBattleDialog)
	EventDispatcher.RemoveEventListener(EventID.BattleShowPlaySkillNotify, self.delegateOnShowPlaySkillNotify)
	EventDispatcher.RemoveEventListener(EventID.BattleShowPlaySkillCutin, self.delegateOnShowSkillCutin)
	EventDispatcher.RemoveEventListener(EventID.OnBattleUnitSetTurnOrder, self.delegateOnBattleUnitSetTurnOrder)
	EventDispatcher.RemoveEventListener(EventID.BattleUnitSelectedOrderEvent, self.delegateOnBattleUnitSelectedOrder)
	EventDispatcher.RemoveEventListener(EventID.OnBattleUnitSelectedSkill, self.delegateOnBattleUnitSelectedSkill)
	EventDispatcher.RemoveEventListener(EventID.OnBattleUnitSelectedTarget, self.delegateOnBattleUnitSelectedTarget)
	EventDispatcher.RemoveEventListener(EventID.OnBattleUnitOrderComplete, self.delegateOnBattleUnitOrderComplete)
	EventDispatcher.RemoveEventListener(EventID.BattleUnitJoinFight, self.delegateOnBattleUnitJoinFight)
	EventDispatcher.RemoveEventListener(EventID.ResetBattleUIShow, self.delegateOnResetBattleUIShow)
	EventDispatcher.RemoveEventListener(EventID.SetRightTopPanelShow, self.SetRightTopPanelShowDelegate)
	EventDispatcher.RemoveEventListener(EventID.ShowBattleUnitDetailView, self.delegateOnShowBattleUnitDetailView)
	EventDispatcher.RemoveEventListener(EventID.BattleUnitDead, self.delegateOnBattleUnitDead)
	EventDispatcher.RemoveEventListener(EventID.OnShowBossInfoView, self.delegateOnShowBossInfoView)
	EventDispatcher.RemoveEventListener(EventID.HideRoleSkillSelectView, self.delegateOnHideRoleSkillSelectView)
	EventDispatcher.RemoveEventListener(EventID.OnBattleTotalDamageChange, self.delegateOnBattleTotalDamageChange)
end

function BattleUI:InitShow()
	self:OnUpdateRound(1)
	self:ShowAutoButton(BattleTeamActionModule.isAuto)
	self:ShowSpeedButton(BattleTimeScaleManager.TimeScale)
end

function BattleUI:ShowAutoButton(isAuto)
	LuaUtility.SetGameObjectShow(self.AutoIconImage, isAuto)
	LuaUtility.SetGameObjectShow(self.ManualIconImage, not isAuto)

	if isAuto then
		self.autoFightView:Show()
	else
		self.autoFightView:Hide()
	end
end

function BattleUI:ShowSpeedButton(timescale)
	UGUIUtil.SetText(self.SpeedText, BattleUIApi:GetSpeedText(timescale))
	UGUIUtil.SetText(self.X, BattleUIApi:GetSpeedTextX(timescale))

	local isSpeedUp = timescale ~= 1

	LuaUtility.SetGameObjectShow(self.speedSelectImg, isSpeedUp)
end

function BattleUI:OnPause()
	return
end

function BattleUI:OnResume()
	return
end

function BattleUI:OnCover()
	return
end

function BattleUI:OnReveal()
	return
end

function BattleUI:OnRefocus(userData)
	return
end

function BattleUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.battleTeamActionsView:OnUpdate()
	self.battleHUDView:OnUpdate()
	self.cutInView:OnUpdate()
end

function BattleUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function BattleUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function BattleUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function BattleUI:OnDestroy()
	self.__DamageTextCom = nil

	self.apView:Dispose()
	self.battleDialogView:Dispose()
	self.battleSkillInfoView:OnDestroy()
	self.battleSkillView:OnDestroy()
	self.battleTeamActionsView:OnDestroy()
	self.battleConfirmActionView:OnDestroy()
	self.battleUnitDetailView:OnDestroy()
	self.battleDamageEffectView:Dispose()

	self.battleDamageEffectView = nil

	self.battleAnimationView:Dispose()
	self.reservesView:Dispose()
	self.leftSkillPlayNotify:Dispose()
	self.rightSkillPlayNotify:Dispose()
	self.skillSelectTargetView:Dispose()
	self.battleHUDView:Dispose()
	self.cutInView:Dispose()
	self.autoFightView:Dispose()
	self.bossInfoView:Dispose()
	self.waveProgressView:Dispose()
	self.skillPreviewView:Dispose()
	BattleScatteredResModule.ClearAllRes()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
	self.lastCutinImgPath = nil

	AssetUtil.UnloadAsset(self)
end

function BattleUI:__OnInit()
	self.submitActionButton:SetActive(false)

	local battleAnimations = {
		BattleStart = self.battleStartAnimation:GetComponent(typeof(UnityEngine.Playables.PlayableDirector)),
		FriendlyTurn = self.friendlyTurnAnimation:GetComponent(typeof(UnityEngine.Playables.PlayableDirector)),
		EnemyTurn = self.enemyTurnAnimation:GetComponent(typeof(UnityEngine.Playables.PlayableDirector))
	}

	self.battleAnimationView = BattleAnimationView.New(battleAnimations)
	self.battleHUDView = BattleHUDView.New(self.hudRoot)
	self.leftSkillPlayNotify = BattleSkillNotifyView.New(self.leftSkillNotify)
	self.rightSkillPlayNotify = BattleSkillNotifyView.New(self.rightSkillNotify)
	self.battleSkillInfoView = BattleSkillInfoView.New(self.tfSkillInfo.gameObject)

	self.battleSkillInfoView:Close()

	self.battleSkillView = BattleSkillView.New(self.tfSkillUI.gameObject)
	self.battleSkillView.battleUI = self
	self.battleTeamActionsView = BattleTeamActionsView.New(self.teamActionPanel)
	self.battleConfirmActionView = BattleConfirmActionView.New(self.battleConfirmActionPanel)

	self.battleConfirmActionView:Close()

	self.battleUnitDetailView = BattleUnitDetailView.New(self.battleUnitDetailPanel)

	self.battleUnitDetailView:Close()

	self.reservesView = BattleReservesView.New(self.ReserveWaveParent)
	self.battleDialogView = BattleDialogView.New(self.dialogRoot)
	self.skillSelectTargetView = BattleSkillSelectTargetView.New(self.BottomSelectState)
	self.battleDamageEffectView = BattleDamageEffectComponent.New(self.battleDamageEffectPanel)
	self.roundText:GetComponent(typeof(UnityEngine.UI.Text)).text = BattleUIApi:GetRoundTips()
	self.cutInView = BattleUICutinView.New(self.cutinRoot)
	self.autoFightView = BattleAutoFightView.New(self.autoFightRoot)

	self.autoFightView:Hide()

	self.bossInfoView = BattleBossInfoView.New(self.bossInfoPanel)

	self.bossInfoView:Hide()

	self.waveProgressView = BattleWaveProgressView.New(self.waveProgress)

	self:SetRightTopPanelShow(BattleModule.showRightToolsButton)

	self.apView = BattleCommonAPView.New(self.apViewRoot)
	self.skillPreviewView = BattleSkillPreviewView.New(self.SkillPreviewRoot)
end

function BattleUI:__OnInitDelegateFunc()
	function self.delegateChangeAuto()
		self:ChangeAuto()
	end

	function self.delegateChangeSpeed()
		self:ChangeSpeed()
	end

	function self.delegatePauseBattle()
		UIModule.Open(Constant.UIControllerName.BattleSettingUI, Constant.UILayer.UI, nil)
	end

	function self.__OnBattleHelperBtnClick()
		UIModule.Open(Constant.UIControllerName.BattleDetailsPanel, Constant.UILayer.UI, nil)
	end

	function self.delegateActiveBattleUI(isActive)
		self:ActiveBattleUI(isActive)
	end

	function self.delegateOnUpdateRound(round)
		self:OnUpdateRound(round)
	end

	function self.delegateOnUpdateWave(wave, maxWave)
		self:OnUpdateWave(wave, maxWave)
	end

	function self.delegateReservesUpdate(id)
		self:OnReservesUpdate(id)
	end

	function self.delegateOnSetBlackScreenActive(isActive)
		self:SetBlackScreenActive(isActive)
	end

	function self.delegateOnShowTotalDamageNumber(damageTable)
		self:OnShowTotalDamageNumber(damageTable)
	end

	function self.delegateOnShowCommonDamageEffect(battleUnitID, text)
		self:OnShowCommonDamageEffect(battleUnitID, text)
	end

	function self.__OnPlayerSKillBtnClickEventProxy()
		self:OnPlayerSKillBtnClickEventHandler()
	end

	function self.delegateOnShowBattleDialog(dialogCid, callback)
		self:OnShowBattleDialog(dialogCid, callback)
	end

	function self.delegateOnShowPlaySkillNotify(troopType, skillCid)
		if troopType == 1 then
			self.leftSkillPlayNotify:Show(skillCid)
		elseif troopType == 2 then
			self.rightSkillPlayNotify:Show(skillCid)
		end
	end

	function self.delegateOnBattleUnitSetTurnOrder(battleUnitID, skillType, skillCid)
		self:OnBattleUnitSetTurnOrder(battleUnitID)
	end

	function self.delegateOnBattleUnitOrderComplete()
		self:OnBattleUnitOrderComplete()
	end

	function self.delegateOnBattleUnitSelectActionTarget(battleSkillData)
		self:OnBattleUnitSelectActionTarget(battleSkillData)
	end

	function self.delegateOnBattleUnitSelectedOrder(battleUnitID, actionType, actionArgs)
		self:OnBattleUnitSelectedOrder(battleUnitID, actionType, actionArgs)
	end

	function self.delegateOnBattleUnitSelectedSkill(battleUnitID, skillType, skillCid)
		self:OnBattleUnitSelectedSkill(battleUnitID, skillType, skillCid)
	end

	function self.delegateOnBattleUnitSelectedTarget(anchorTile, hitTiles)
		self:OnBattleUnitSelectedTarget(anchorTile, hitTiles)
	end

	function self.delegateOnBattleUnitJoinFight(_battleUnitID)
		self:OnBattleUnitJoinFight(_battleUnitID)
	end

	function self.delegateOnBattleUnitDead(_battleUnitID)
		self:OnBattleUnitDead(_battleUnitID)
	end

	function self.delegateOnResetBattleUIShow(userData)
		self:__OnUIOpen(userData)
	end

	function self.delegateOnShowSkillCutin(_battleUnitID, _skillCid, _callback)
		self:__OnShowSkillCutin(_battleUnitID, _skillCid, _callback)
	end

	self.battleHUDView = BattleHUDView.New(self.hudRoot)

	function self.SetRightTopPanelShowDelegate(show)
		self:SetRightTopPanelShow(show)
	end

	function self.delegateOnShowBattleUnitDetailView(battleUnitID)
		self.battleUnitDetailView:UpdateStatus(battleUnitID)
		self.battleUnitDetailView:Open()
	end

	function self.delegateOnShowBossInfoView(battleUnitID)
		self:__OnShowBossInfoView(battleUnitID)
	end

	function self.delegateOnHideRoleSkillSelectView()
		self:OnHideRoleSkillSelectView()
	end

	function self.delegateOnBattleTotalDamageChange(totalDmg, actualDmg)
		self:OnBattleTotalDamageChange(totalDmg, actualDmg)
	end
end

function BattleUI:__OnUIOpen(userData)
	self.cutInView:Hide()
	self.bossInfoView:Hide()
	self:__CloseHUD()
	self.battleAnimationView:StopAllAnimations()
	self.battleSkillInfoView:OnOpen()
	self.battleSkillView:OnOpen()
	self.battleTeamActionsView:OnOpen()
	self.battleConfirmActionView:OnOpen()
	self.skillSelectTargetView:Hide()
	self.apView:Hide()
	self.skillPreviewView:Hide()

	self.maxRoundText:GetComponent(typeof(UnityEngine.UI.Text)).text = string.format("/%d", userData.maxRound)

	self.reservesView:SetData(userData.wave, userData.maxWave, userData.tubstitute)

	if userData.maxWave == 1 then
		self.waveProgressView:Hide()
	else
		self.waveProgressView:Show(userData.wave, userData.maxWave)
	end

	if userData.battleType == Constant.ChapterPassType.Type_ChallengeWorldBoss then
		self.TotalDamageRoot.gameObject:SetActive(true)

		self.DamageText:GetComponent("Text").text = "0"
	else
		self.TotalDamageRoot.gameObject:SetActive(false)
	end

	self:InitShow()
	self:RefreshPlayerSkill()
	self:__InitBattleBossHUDData()
end

function BattleUI:__InitBattleBossHUDData()
	self.twinBossItem.gameObject:SetActive(false)
	self.singleBoss.gameObject:SetActive(false)

	self.battleBossViewTable = {}

	local bossCount = #BattleModule.bossTable

	if bossCount == 0 then
		self.battleBossUnitPropertyPanel.gameObject:SetActive(false)

		return
	end

	self.battleBossUnitPropertyPanel.gameObject:SetActive(true)

	if bossCount == 1 then
		local bossUnitID = BattleModule.bossTable[1]

		self.battleBossViewTable[bossUnitID] = self.singleBoss

		self.twinBoss.gameObject:SetActive(false)

		return
	end

	self.singleBoss:SetActive(false)
	self.twinBoss.gameObject:SetActive(true)

	for i = 1, bossCount do
		local bossUnitID = BattleModule.bossTable[i]
		local viewItem = UnityEngine.GameObject.Instantiate(self.twinBossItem)

		viewItem.gameObject.transform:SetParent(self.twinBossItem.transform.parent, false)

		self.battleBossViewTable[bossUnitID] = viewItem
	end
end

function BattleUI:__CloseHUD()
	self.battleHUDView:OnClose()
	self.twinBossItem.gameObject:SetActive(false)
	self.singleBoss.gameObject:SetActive(false)
	self.battleBossUnitPropertyPanel.gameObject:SetActive(false)

	if self.battleBossViewTable ~= nil then
		for _, _view in pairs(self.battleBossViewTable) do
			if _view ~= self.singleBoss then
				GameObject.Destroy(_view)
			end
		end

		self.battleBossViewTable = nil
	end
end

function BattleUI:__OnShowSkillCutin(battleUnitID, skillCid, callback)
	self.cutInView:Show(battleUnitID, skillCid, callback)
end

function BattleUI:__OnShowBossInfoView(battleUnitID)
	self.bossInfoView:Show(battleUnitID)
end

function BattleUI:ChangeAuto()
	BattleTeamActionModule.ChangeAuto()
	self:ShowAutoButton(BattleTeamActionModule.isAuto)
end

function BattleUI:ChangeSpeed()
	BattleModule.SetBattleSpeed()
	self:ShowSpeedButton(BattleTimeScaleManager.TimeScale)
end

function BattleUI:InitPreloadAssets()
	BattleScatteredResModule.LoadScatteredRes(self.UIController, self.gameObject.transform)

	self.battleSkillView.selectSkillEffect = self.selectSkillEffect
	self.battleTeamActionsView.selectSkillEffect = self.selectSkillEffect
end

function BattleUI:ActiveBattleUI(isActive)
	return
end

function BattleUI:OnUpdateRound(round)
	UGUIUtil.SetText(self.roundText, round)
end

function BattleUI:OnUpdateWave(wave, maxWave)
	self.reservesView:UpdateWave(wave, maxWave)

	if maxWave == 1 then
		self.waveProgressView:Hide()
	else
		self.waveProgressView:Show(wave, maxWave)
	end
end

function BattleUI:OnReservesUpdate(id)
	self.reservesView:UpdateReserves(id)
end

local waitForAWhile = CustomWaitForSeconds(0.5)

function BattleUI:OnShowTotalDamageNumber(damageTable)
	if self.battleDamageEffectView == nil then
		logError("战斗伤害数字组件 - BattleUI:ShowCommonDamageEffect: battleDamageEffectView is nil.")

		return
	end

	ForPairs(damageTable, function(battleUnitID, totalDamage)
		local battleUnitView = BattleModule.GetBattleUnitViewByUnitID(battleUnitID)

		self.battleDamageEffectView:ShowTotalDamage(totalDamage, function(item)
			if battleUnitView == nil then
				return false
			end

			local rectTrans = item.gameObject:GetComponent(typeof(UnityEngine.RectTransform))
			local pos = BattleModule.SceneWorldPointToWorldPointInRectangle(battleUnitView.hudFollowTarget.position, rectTrans)

			rectTrans.position = pos

			return true
		end)
	end)
end

function BattleUI:OnShowCommonDamageEffect(battleUnitID, text)
	local battleUnitView = BattleModule.GetBattleUnitViewByUnitID(battleUnitID)

	self.battleDamageEffectView:ShowOtherText(text, function(item)
		if battleUnitView == nil then
			return false
		end

		local rectTrans = item.gameObject:GetComponent(typeof(UnityEngine.RectTransform))
		local pos = BattleModule.SceneWorldPointToWorldPointInRectangle(battleUnitView.hudFollowTarget.position, rectTrans)

		rectTrans.position = pos

		return true
	end)
end

function BattleUI:ResetAllBattleUIAnimations()
	for _, playableDirector in pairs(self.uiAnimationNameToDirector) do
		playableDirector:Stop()

		playableDirector.time = playableDirector.duration

		playableDirector:Evaluate()

		playableDirector.time = 0

		playableDirector:Evaluate()
		playableDirector.gameObject:SetActive(false)
	end
end

function BattleUI:SetBlackScreenActive(isActive)
	self.BlackTransitionImage:SetActive(isActive)
end

function BattleUI:SetPlayerSkillActive(active)
	self.playerSkillParent:SetActive(false)
end

function BattleUI:RefreshPlayerSkill()
	self:SetPlayerSkillActive(false)
end

function BattleUI:DestroyPlayerSkill()
	if self.playerSkillDatas == nil then
		return
	end

	for _, playerSkillData in pairs(self.playerSkillDatas) do
		LuaCodeInterface.ClearOutlet(playerSkillData.gameObject, playerSkillData)

		playerSkillData.button = nil

		local obj = playerSkillData.gameObject

		playerSkillData.gameObject = nil

		UnityEngine.GameObject.Destroy(obj)
	end

	self.playerSkillDatas = nil
end

function BattleUI:OnPlayerSKillBtnClickEventHandler()
	local active = not self.playerSkillPanel.activeSelf

	self.playerSkillPanel:SetActive(active)
	self.selectImg:SetActive(active)
end

function BattleUI:OnShowBattleDialog(dialogCid, callback)
	EventDispatcher.Dispatch(EventID.OnBattleDialogShowEvent, dialogCid)
	self.battleDialogView:ShowDialog(dialogCid, function()
		self:OnShowBattleDialogComplete(dialogCid)
		callback()
	end)
end

function BattleUI:OnShowBattleDialogComplete(dialogCid)
	EventDispatcher.Dispatch(EventID.OnBattleDialogCompleteEvent, dialogCid)
end

function BattleUI:OnHideRoleSkillSelectView()
	self.apView:Show()
	self.battleSkillView:Hide()
	self.battleTeamActionsView:ClearSelect()
end

function BattleUI:OnBattleUnitSetTurnOrder(battleUnitID)
	self.skillSelectTargetView:Hide()
	self.battleTeamActionsView:Open(battleUnitID)
	self.battleSkillView:ShowSkills(battleUnitID)
	self.apView:Show()
	self.skillPreviewView:Show()
end

function BattleUI:OnBattleUnitSelectActionTarget(battleSkillData)
	self.battleTeamActionsView:Close()
	self.battleSkillView:Hide()

	if battleSkillData == nil then
		self.skillSelectTargetView:Hide()
	else
		self.skillSelectTargetView:Show(battleSkillData)
	end
end

function BattleUI:OnBattleUnitSelectedOrder(battleUnitID, actionType, actionArgs)
	self.battleTeamActionsView:Close()
	self.battleSkillView:Hide()
end

function BattleUI:OnBattleUnitSelectedSkill(battleUnitID, skillType, skillCid)
	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitID)
	local battleSkillData = battleUnitData:GetSkillData(skillCid)

	EventDispatcher.Dispatch(EventID.ShowBattleSkillAPCost, battleSkillData.apCost)
	self.battleSkillView:RefreshSkillSelect(skillType, skillCid)
	self.skillPreviewView:RefreshSkillSelect(battleSkillData)
end

function BattleUI:OnBattleUnitSelectedTarget(anchorTile, hitTiles)
	self.skillSelectTargetView:RefreshTargetSelectedShow(anchorTile, hitTiles)
end

function BattleUI:OnBattleUnitOrderComplete()
	self.skillSelectTargetView:Hide()
	self.battleTeamActionsView:Close()
	self.battleSkillView:Hide()
	self.skillPreviewView:Hide()
	self.apView:Show()
end

function BattleUI:OnBattleUnitJoinFight(battleUnitID)
	local bossHUD = self.battleBossViewTable[battleUnitID]

	self.battleHUDView:AddHUDItem(battleUnitID, bossHUD)
end

function BattleUI:OnBattleUnitDead(battleUnitID)
	self.battleHUDView:RemoveHUDItem(battleUnitID)
end

function BattleUI:SetRightTopPanelShow(show)
	LuaUtility.SetGameObjectShow(self.RightTopPanel, show)
	LuaUtility.SetGameObjectShow(self.helpBtn, show)
end

function BattleUI:OnBattleTotalDamageChange(totalDmg, actualDmg)
	if self.__DamageTextCom == nil then
		self.__DamageTextCom = self.DamageText:GetComponent("Text")
	end

	self.__DamageTextCom.text = totalDmg
end

return BattleUI
