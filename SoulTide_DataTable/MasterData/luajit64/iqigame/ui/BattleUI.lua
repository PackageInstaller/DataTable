-- chunkname: @IQIGame\\UI\\BattleUI.lua

local BattleUI = {
	_isInit = false,
	_SkillEnergyMax = 0,
	BornMonsterCount = 0,
	SkillCGEffectPlayId = 0,
	SkillCGSoundPlayId = 0,
	IsPlayingVideo = false,
	ActingDollEntityId = 0,
	_myBattleUnitId = 0,
	ActingDollUnitId = 0,
	TurnDamage = 0,
	UpdateExecutedFrame = 0,
	_attackerCellTabList = {},
	_defenderCellTabList = {}
}

BattleUI = Base:Extend("BattleUI", "IQIGame.Onigao.UI.BattleUI", BattleUI)

local BattleAttackUnitCell = require("IQIGame.UI.Battle.BattleAttackUnitCell")
local BattleDefenderUnitCell = require("IQIGame.UI.Battle.BattleDefenderUnitCell")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local BattleRoundController = require("IQIGame.UI.Battle.BattleRoundController")
local DamageStatisticsController = require("IQIGame.UI.Battle.DamageStatisticsController")
local BattleCastSkillButtonGroup = require("IQIGame.UI.Battle.BattleCastSkillButtonGroup")
local BattleActionSequence = require("IQIGame.UI.Battle.BattleActionSequence")
local BattleSkillTipController = require("IQIGame.UI.Battle.BattleSkillTipController")

function BattleUI:OnInit()
	function self.DelegateOnUpdateUnitHp(sender, args)
		self:OnUpdateUnitHp(sender, args)
	end

	function self.DelegateOnInitEnemyHp(unitId)
		self:OnInitEnemyHp(unitId)
	end

	function self.DelegateOnShowBattleUI(sender, args)
		self:OnShowBattleUI(sender, args)
	end

	function self.DelegateOnStartNewRound()
		self:OnStartNewRound()
	end

	function self.DelegateOnEndRound(sender, args)
		self:OnEndRound(sender, args)
	end

	function self.DelegateUpdateSkillFlyDelayTime()
		self:UpdateSkillFlyDelayTime()
	end

	function self.DelegateEffectFlyComplete(go)
		self:EffectFlyComplete(go)
	end

	function self.DelegateOnBattleUnitAddBuff(unitId, buffs, troopType, newBuff, changeStackBuffs, addStackBuffs)
		self:OnBattleUnitAddBuff(unitId, buffs, troopType, newBuff, changeStackBuffs, addStackBuffs)
	end

	function self.DelegateOnBattleUnitRemoveBuff(unitId, buffCid, troopType)
		self:OnBattleUnitRemoveBuff(unitId, buffCid, troopType)
	end

	function self.DelegateOnBattleUnitDead(sender, args)
		self:OnBattleUnitDead(sender, args)
	end

	function self.DelegateOnShowContent(sender, args)
		self:OnShowContent(sender, args)
	end

	function self.DelegateOnHideContent(sender, args)
		self:OnHideContent(sender, args)
	end

	function self.DelegateOnClickSkipFightBtn()
		self:OnClickSkipFightBtn()
	end

	function self.DelegateOnClickDisabledAutoFightBtn()
		self:OnClickDisabledAutoFightBtn()
	end

	function self.DelegateOnClickSpeedBtn()
		self:OnClickSpeedBtn()
	end

	function self.DelegateOnClickGiveUpBtn()
		self:OnClickGiveUpBtn()
	end

	function self.DelegateOnClickDisabledGiveUpBtn()
		self:OnClickDisabledGiveUpBtn()
	end

	function self.DelegateOnDamageStatistics(sender, args)
		self:OnDamageStatistics(sender, args)
	end

	function self.DelegateOnBattleTurnEnd(unitId)
		self:OnBattleTurnEnd(unitId)
	end

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	function self.DelegateOnShowElementEntityFailure(sender, args)
		self:OnShowElementEntityFailure(sender, args)
	end

	function self.DelegateOnBattleEnd(battleOverCommand)
		self:OnBattleEnd(battleOverCommand)
	end

	function self.DelegateOnGestureOnElement(sender, args)
		self:OnGestureOnElement(sender, args)
	end

	function self.DelegateOnSelectSkill(nextUnitId)
		self:OnSelectSkill(nextUnitId)
	end

	function self.DelegateOnTurnStart(unitId)
		self:OnTurnStart(unitId)
	end

	function self.DelegateOnShowSkillTip(skillCid, skillStrengths)
		self:OnShowSkillTip(skillCid, skillStrengths)
	end

	function self.DelegateOnClickHelpBtn()
		self:OnClickHelpBtn()
	end

	function self.DelegateOnBattleLogicEnd()
		self:OnBattleLogicEnd()
	end

	function self.DelegateOnAutoNormalAtkChanged()
		self:OnAutoModeChanged()
	end

	function self.DelegateOnAutoSkillAtkChanged()
		self:OnAutoModeChanged()
	end

	function self.DelegateOnPrepareCastSkill(unitId, monsterCid, skillCid, skillActionCid, needPlayCG)
		self:OnPrepareCastSkill(unitId, monsterCid, skillCid, skillActionCid, needPlayCG)
	end

	function self.DelegateOnClickSkipSkillCGBtn()
		self:OnClickSkipSkillCGBtn()
	end

	function self.DelegateOnMediaPlayerEvent(mediaPlayer, eventType, errorCode)
		self:OnMediaPlayerEvent(mediaPlayer, eventType, errorCode)
	end

	function self.DelegateOnBattleTimeScaleChanged()
		self:OnBattleTimeScaleChanged()
	end

	function self.DelegateOnClickSettingBtn()
		self:OnClickSettingBtn()
	end

	function self.DelegateOnUIResolutionChange()
		self:OnUIResolutionChange()
	end

	function self.DelegateOnShowOrEndPlot(isOn)
		self:OnShowOrEndPlot(isOn)
	end

	self._SkillEnergyMax = tonumber(CfgGlobalTable[1029].Parameter)
	self._UICanvas = self.UIController:GetComponent("Canvas")

	local assetPath = AssetPath.Get(GlobalKey.UIPrefabPath, "_BattleUI/BattlePuppetUI")
	local companionCellPrefab = self.UIController:GetPreloadedAsset(assetPath)

	assetPath = AssetPath.Get(GlobalKey.UIPrefabPath, "_BattleUI/Defender_Hp")
	self._defenderUnitHpPrefab = self.UIController:GetPreloadedAsset(assetPath)
	self._attackerCellTabList = {}

	for i = 1, 5 do
		local attackerCellGO = UnityEngine.Object.Instantiate(companionCellPrefab)

		attackerCellGO.transform:SetParent(self["AttackerUnit" .. i].transform, false)

		local attackerCell = BattleAttackUnitCell.New(attackerCellGO, self._UICanvas, i)

		self._attackerCellTabList[i] = attackerCell
	end

	self.EnemyCellPool = UIObjectPool.New(5, function()
		return BattleDefenderUnitCell.New(UnityEngine.Object.Instantiate(self._defenderUnitHpPrefab), nil, false)
	end, function(cell)
		cell:Dispose()
	end)
	self.BattleRoundController = BattleRoundController.New(self.CurRoundNum, self.TotalRoundNum)
	self.BossUnitCell = BattleDefenderUnitCell.New(self.BossTopBar, self, true)

	table.insert(self._defenderCellTabList, self.BossUnitCell)

	self.DamageStatisticsController = DamageStatisticsController.New(self.DamageStatisticsView)
	self.BattleActionSequence = BattleActionSequence.New(self.ActionSequence)
	self.BattleCastSkillButtonGroup = BattleCastSkillButtonGroup.New(self.SkillView, function(cfgSkillData, isStandby)
		self:OnClickSkill(cfgSkillData, isStandby)
	end)

	self.BattleCastSkillButtonGroup:Hide(true)

	self.SkillTipController = BattleSkillTipController.New(self.SkillTipView)

	UGUIUtil.SetTextInChildren(self.SkipSkillCGBtn, BattleUIApi:GetString("SkipSkillCGBtnText"))
	UGUIUtil.SetTextInChildren(self.HelpBtn, BattleUIApi:GetString("HelpBtnText"))
	UGUIUtil.SetText(self.SpeedBtnLabelText, BattleUIApi:GetString("SpeedBtnLabelText"))
	UGUIUtil.SetTextInChildren(self.SettingBtn, BattleUIApi:GetString("SettingBtnText"))
	UGUIUtil.SetTextInChildren(self.GiveUpBtn, BattleUIApi:GetString("GiveUpBtnText"))
	UGUIUtil.SetTextInChildren(self.DisabledGiveUpBtn, BattleUIApi:GetString("GiveUpBtnText"))
	UGUIUtil.SetText(self.AutoModeLabel, BattleUIApi:GetString("AutoModeLabel"))
	UGUIUtil.SetText(self.AutoFightDisableNormalText, BattleUIApi:GetString("AutoNormalAtkToggleText"))
	UGUIUtil.SetText(self.AutoFightDisableSkillText, BattleUIApi:GetString("AutoSkillAtkToggleText"))

	self.AutoNormalAtkToggle:GetComponent("ToggleHelperComponent").text = BattleUIApi:GetString("AutoNormalAtkToggleText")
	self.AutoSkillAtkToggle:GetComponent("ToggleHelperComponent").text = BattleUIApi:GetString("AutoSkillAtkToggleText")

	self.SkillCGNode:SetActive(false)
end

function BattleUI:OnOpen(userData)
	if not BattleModule.Initialized then
		return
	end

	self:UpdateView()
	self.BattleActionSequence:Show()
	self.ButtonNode:SetActive(false)
	self.InfoNode:SetActive(false)
	self.InputBlock:SetActive(true)
	self.Block:SetActive(false)
	self.SkillTipController:Hide()

	if BattleModule.Round > 0 then
		self:OnStartNewRound()
	end
end

function BattleUI:GetPreloadAssetPaths()
	local preLoadAssetsTable = {}
	local assetsPath = AssetPath.Get(GlobalKey.UIPrefabPath, "_BattleUI/BattlePuppetUI")

	table.insert(preLoadAssetsTable, assetsPath)

	assetsPath = AssetPath.Get(GlobalKey.UIPrefabPath, "_BattleUI/Defender_Hp")

	table.insert(preLoadAssetsTable, assetsPath)

	for i = 1, Constant.BattleDamageType.ElementTypeNum do
		table.insert(preLoadAssetsTable, BattleUIApi:GetString("EnergyShieldImage", i))
	end

	return preLoadAssetsTable
end

function BattleUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function BattleUI:OnAddListeners()
	self.BattleActionSequence:AddListeners()

	self.UIController.onRectTransformDimensionChanged = self.UIController.onRectTransformDimensionChanged + self.DelegateOnUIResolutionChange

	self.SkipFightBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSkipFightBtn)
	self.AutoFightDisabledView:GetComponent("Button").onClick:AddListener(self.DelegateOnClickDisabledAutoFightBtn)
	self.SpeedBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSpeedBtn)
	self.GiveUpBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickGiveUpBtn)
	self.DisabledGiveUpBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickDisabledGiveUpBtn)
	self.HelpBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickHelpBtn)
	self.AutoNormalAtkToggle:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnAutoNormalAtkChanged)
	self.AutoSkillAtkToggle:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnAutoSkillAtkChanged)
	self.SkipSkillCGBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSkipSkillCGBtn)
	self.SettingBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSettingBtn)
	GameEntry.LuaEvent:Subscribe(BattleUnitUpdateHpToLuaEventArgs.EventId, self.DelegateOnUpdateUnitHp)
	GameEntry.LuaEvent:Subscribe(LoadSceneExtResEndEventArgs.EventId, self.DelegateOnShowBattleUI)
	GameEntry.LuaEvent:Subscribe(BattleEndRoundEventArgs.EventId, self.DelegateOnEndRound)
	GameEntry.LuaEvent:Subscribe(BattleUnitDeadEventArgs.EventId, self.DelegateOnBattleUnitDead)
	GameEntry.LuaEvent:Subscribe(ShowBattleUIContentEventArgs.EventId, self.DelegateOnShowContent)
	GameEntry.LuaEvent:Subscribe(HideBattleUIContentEventArgs.EventId, self.DelegateOnHideContent)
	GameEntry.LuaEvent:Subscribe(BattleDamageStatisticsEventArgs.EventId, self.DelegateOnDamageStatistics)
	GameEntry.LuaEvent:Subscribe(BattleGestureOnElementEventArgs.EventId, self.DelegateOnGestureOnElement)
	EventDispatcher.AddEventListener(EventID.BattleAddBuff, self.DelegateOnBattleUnitAddBuff)
	EventDispatcher.AddEventListener(EventID.BattleRemoveBuff, self.DelegateOnBattleUnitRemoveBuff)
	EventDispatcher.AddEventListener(EventID.BattleTurnEnd, self.DelegateOnBattleTurnEnd)
	EventDispatcher.AddEventListener(EventID.BattleEnd, self.DelegateOnBattleEnd)
	EventDispatcher.AddEventListener(EventID.BattleSelectSkill, self.DelegateOnSelectSkill)
	EventDispatcher.AddEventListener(EventID.BattleTurnStart, self.DelegateOnTurnStart)
	EventDispatcher.AddEventListener(EventID.BattleStartRound, self.DelegateOnStartNewRound)
	EventDispatcher.AddEventListener(EventID.BattleShowSkillTip, self.DelegateOnShowSkillTip)
	EventDispatcher.AddEventListener(EventID.BattleInitEnemyHp, self.DelegateOnInitEnemyHp)
	EventDispatcher.AddEventListener(EventID.BattleLogicEnd, self.DelegateOnBattleLogicEnd)
	EventDispatcher.AddEventListener(EventID.BattlePrepareCastSkill, self.DelegateOnPrepareCastSkill)
	EventDispatcher.AddEventListener(EventID.BattleTimeScaleChanged, self.DelegateOnBattleTimeScaleChanged)
	EventDispatcher.AddEventListener(EventID.BattleShowOrEndPlot, self.DelegateOnShowOrEndPlot)
end

function BattleUI:OnRemoveListeners()
	self.BattleActionSequence:RemoveListeners()

	self.UIController.onRectTransformDimensionChanged = self.UIController.onRectTransformDimensionChanged - self.DelegateOnUIResolutionChange

	self.SkipFightBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSkipFightBtn)
	self.AutoFightDisabledView:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickDisabledAutoFightBtn)
	self.SpeedBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSpeedBtn)
	self.GiveUpBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickGiveUpBtn)
	self.DisabledGiveUpBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickDisabledGiveUpBtn)
	self.HelpBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickHelpBtn)
	self.AutoNormalAtkToggle:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnAutoNormalAtkChanged)
	self.AutoSkillAtkToggle:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnAutoSkillAtkChanged)
	self.SkipSkillCGBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSkipSkillCGBtn)
	self.SettingBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSettingBtn)
	GameEntry.LuaEvent:Unsubscribe(BattleUnitUpdateHpToLuaEventArgs.EventId, self.DelegateOnUpdateUnitHp)
	GameEntry.LuaEvent:Unsubscribe(LoadSceneExtResEndEventArgs.EventId, self.DelegateOnShowBattleUI)
	GameEntry.LuaEvent:Unsubscribe(BattleEndRoundEventArgs.EventId, self.DelegateOnEndRound)
	GameEntry.LuaEvent:Unsubscribe(BattleUnitDeadEventArgs.EventId, self.DelegateOnBattleUnitDead)
	GameEntry.LuaEvent:Unsubscribe(ShowBattleUIContentEventArgs.EventId, self.DelegateOnShowContent)
	GameEntry.LuaEvent:Unsubscribe(HideBattleUIContentEventArgs.EventId, self.DelegateOnHideContent)
	GameEntry.LuaEvent:Unsubscribe(BattleDamageStatisticsEventArgs.EventId, self.DelegateOnDamageStatistics)
	GameEntry.LuaEvent:Unsubscribe(BattleGestureOnElementEventArgs.EventId, self.DelegateOnGestureOnElement)
	EventDispatcher.RemoveEventListener(EventID.BattleAddBuff, self.DelegateOnBattleUnitAddBuff)
	EventDispatcher.RemoveEventListener(EventID.BattleRemoveBuff, self.DelegateOnBattleUnitRemoveBuff)
	EventDispatcher.RemoveEventListener(EventID.BattleTurnEnd, self.DelegateOnBattleTurnEnd)
	EventDispatcher.RemoveEventListener(EventID.BattleEnd, self.DelegateOnBattleEnd)
	EventDispatcher.RemoveEventListener(EventID.BattleSelectSkill, self.DelegateOnSelectSkill)
	EventDispatcher.RemoveEventListener(EventID.BattleTurnStart, self.DelegateOnTurnStart)
	EventDispatcher.RemoveEventListener(EventID.BattleStartRound, self.DelegateOnStartNewRound)
	EventDispatcher.RemoveEventListener(EventID.BattleShowSkillTip, self.DelegateOnShowSkillTip)
	EventDispatcher.RemoveEventListener(EventID.BattleInitEnemyHp, self.DelegateOnInitEnemyHp)
	EventDispatcher.RemoveEventListener(EventID.BattleLogicEnd, self.DelegateOnBattleLogicEnd)
	EventDispatcher.RemoveEventListener(EventID.BattlePrepareCastSkill, self.DelegateOnPrepareCastSkill)
	EventDispatcher.RemoveEventListener(EventID.BattleTimeScaleChanged, self.DelegateOnBattleTimeScaleChanged)
	EventDispatcher.RemoveEventListener(EventID.BattleShowOrEndPlot, self.DelegateOnShowOrEndPlot)
end

function BattleUI:UpdateView()
	local actingHeroEntityPoint = UnityEngine.GameObject.Find("BattleCamera/ActingHeroEntityPoint")
	local screenPos = self._UICanvas.worldCamera:WorldToScreenPoint(self.SkillSpinePoint.transform.position)
	local scenePos = BattleModule.BattleCamera:GetComponent("Camera"):ScreenToWorldPoint(screenPos)

	scenePos.z = actingHeroEntityPoint.transform.position.z
	actingHeroEntityPoint.transform.position = scenePos
	self.ActingDollFirstRoot = actingHeroEntityPoint.transform:Find("Root").gameObject
	self.ActingDollAnimationNode = self.ActingDollFirstRoot.transform:Find("Root1").gameObject
	self.ActingDollEntityRoot = self.ActingDollAnimationNode.transform:Find("Root2").gameObject

	local speed = PlayerModule.GetBattleSpeed(BattleModule.Type)

	UGUIUtil.SetText(self.SpeedBtnValueText, BattleUIApi:GetString("SpeedBtnValueText", speed))

	local cfgMonsterTeamData = CfgMonsterTeamTable[BattleModule.GetMonsterTeamCid()]
	local isBossBattle = cfgMonsterTeamData.Type == Constant.Battle.MonsterTeamTypeBoss

	self.BossTopBar:SetActive(isBossBattle)
	self.NormalTopBar:SetActive(not isBossBattle)

	if isBossBattle then
		self.BossUnitCell:Reset()

		local battleUnitPODs = BattleModule.GetDefendTroopPodsTable()

		for i = 1, #battleUnitPODs do
			local battleUnitPOD = battleUnitPODs[i]
			local cfgMonsterData = CfgMonsterTable[battleUnitPOD.MonsterCfgId]

			if cfgMonsterData.IsBoss then
				self.BossUnitCell.NameText:GetComponent("Text").text = cfgMonsterData.Name

				self.BossUnitCell:SetHp(0, battleUnitPOD.MaxHP)
				self.BossUnitCell.BuffGroupController:Clear()

				break
			end
		end
	end

	self.BattleRoundController:SetRound(0, BattleModule.MaxRound)

	self.BornMonsterCount = 0
	self.BossBornData = nil

	local cfgBattleAreaData = CfgBattleAreaTable[BattleModule.GetBattleAreaCid()]
	local isAutoFightUnlock = UnlockFunctionModule.IsUnlock(Constant.UnlockType.AUTO_FIGHT) and cfgBattleAreaData.Auto

	self.AutoFightNormalView:SetActive(isAutoFightUnlock)
	self.AutoFightDisabledView:SetActive(not isAutoFightUnlock)
	self:SetAutoFightMode(PlayerModule.GetAutoFightMode(BattleModule.Type))
	self.DamageStatisticsController.View:SetActive(cfgBattleAreaData.Record)
	self.SkipFightBtn:SetActive(GmListModule.EnableSkipBattle())
	self.SpeedBtn:SetActive(cfgBattleAreaData.Speed)
	self.GiveUpBtn:SetActive(cfgBattleAreaData.GiveUp)
	self.DisabledGiveUpBtn:SetActive(not cfgBattleAreaData.GiveUp)

	if PlayerModule.CurrAdditiveSceneID == SceneID.Battle then
		self:ShowBattleUI()
	end
end

function BattleUI:OnShowBattleUI(sender, args)
	self:ShowBattleUI()
end

function BattleUI:ShowBattleUI()
	for i = 1, #self._attackerCellTabList do
		local battleAttackUnitCell = self._attackerCellTabList[i]

		battleAttackUnitCell:Clear()
	end

	local attackBattleUnitList = BattleModule.GetAttackTroopPodsTable()
	local heroRoot = UnityEngine.GameObject.Find("HeroRoot").transform

	for i = 1, #attackBattleUnitList do
		local battleUnitPOD = attackBattleUnitList[i]
		local pos = battleUnitPOD.BattlePos > 5 and battleUnitPOD.BattlePos - 5 or battleUnitPOD.BattlePos
		local battleAttackUnitCell = self._attackerCellTabList[pos]

		battleAttackUnitCell:SetItem(attackBattleUnitList[i], heroRoot:Find("HeroPoint" .. pos))
	end

	for unitId, enemyHpInitData in pairs(BattleModule.EnemyHpInitDataList) do
		self:CreateEnemyHp(enemyHpInitData)
	end

	BattleModule.ClearEnemyHpInitDataList()

	self._isInit = true
end

function BattleUI:OnInitEnemyHp(unitId)
	if self._isInit then
		local enemyHpInitData = BattleModule.ObtainEnemyHpInitData(unitId)

		self:CreateEnemyHp(enemyHpInitData)
	end
end

function BattleUI:CreateEnemyHp(argTable)
	local cfgMonsterTeamData = CfgMonsterTeamTable[BattleModule.GetMonsterTeamCid()]
	local isBossBattle = cfgMonsterTeamData.Type == Constant.Battle.MonsterTeamTypeBoss
	local cfgMonsterData = CfgMonsterTable[argTable.MonsterCfgId]

	if isBossBattle and cfgMonsterData.IsBoss then
		if self.BossBornData ~= nil then
			logError("创建敌人血条错误。且MonsterTeam表配置的是Boss战，但存在多个Boss。（MonsterTeam表配置为Boss战的情况只支持一个Boss）。MonsterTeamCid: " .. cfgMonsterTeamData.Id)
		end

		self.BossBornData = argTable
	elseif argTable.BattleUnitHp > 0 then
		local defenderCell = self.EnemyCellPool:Obtain()

		defenderCell.View.transform:SetParent(self:GetEnemyHpCanvas(argTable.UnitPos).transform, false)
		defenderCell:Reset()
		defenderCell:SetItem(argTable)
		table.insert(self._defenderCellTabList, defenderCell)
	end

	self.BornMonsterCount = self.BornMonsterCount + 1

	if self.BornMonsterCount >= #BattleModule.GetDefendTroopPodsTable() then
		if self.BossBornData ~= nil then
			self.BossUnitCell:SetItem(self.BossBornData)

			self.BossBornData = nil
		end

		local timer = Timer.New(function()
			for i = 1, #self._defenderCellTabList do
				local battleUnitCell = self._defenderCellTabList[i]

				battleUnitCell:PlayHpAnimation()
			end

			GameEntry.Sound:PlaySound(10226, Constant.SoundGroup.UI)
		end, 0.5)

		timer:Start()
	end
end

function BattleUI:OnUpdateUnitHp(sender, args)
	local isAttackChangeHp = false

	for i = 1, #self._attackerCellTabList do
		local battleUnitCell = self._attackerCellTabList[i]

		if battleUnitCell.BattleUnitID == args.BattleUnitID then
			battleUnitCell:SetHpAndShield(args.BattleUnitHp, args.BattleUnitMaxHp, args.BattleUnitShield, args.RemoveShield)

			isAttackChangeHp = true

			break
		end
	end

	if not isAttackChangeHp then
		for i = 1, #self._defenderCellTabList do
			local battleUnitCell = self._defenderCellTabList[i]

			if battleUnitCell.BattleUnitID == args.BattleUnitID then
				battleUnitCell:SetHpAndShield(args.BattleUnitHp, args.BattleUnitMaxHp, args.BattleUnitShield, args.RemoveShield)

				break
			end
		end
	end
end

function BattleUI:OnBattleUnitAddBuff(unitId, buffs, troopType, newBuff, changeStackBuffs, addStackBuffs)
	if self._isInit then
		if troopType == Constant.BattleTroopType.Attack then
			for i = 1, #self._attackerCellTabList do
				local battleUnitCell = self._attackerCellTabList[i]

				if battleUnitCell.BattleUnitID == unitId then
					battleUnitCell:AddBuff(buffs)
				end
			end
		elseif troopType == Constant.BattleTroopType.Defend then
			for i = 1, #self._defenderCellTabList do
				local battleUnitCell = self._defenderCellTabList[i]

				if battleUnitCell.BattleUnitID == unitId then
					battleUnitCell:AddBuff(buffs)
				end
			end
		end
	end
end

function BattleUI:OnBattleUnitRemoveBuff(unitId, buffCid, troopType)
	if troopType == Constant.BattleTroopType.Attack then
		for i = 1, #self._attackerCellTabList do
			local battleUnitCell = self._attackerCellTabList[i]

			if battleUnitCell.BattleUnitID == unitId then
				battleUnitCell:RemoveBuff(buffCid)

				break
			end
		end
	elseif troopType == Constant.BattleTroopType.Defend then
		for i = 1, #self._defenderCellTabList do
			if self._defenderCellTabList[i].BattleUnitID == unitId then
				self._defenderCellTabList[i]:RemoveBuff(buffCid)

				break
			end
		end
	end
end

function BattleUI:OnStartNewRound()
	if BattleModule.Round == 1 then
		self.BattleRoundBannerTimer = Timer.New(function()
			self.BattleRoundBannerTimer = nil

			self:PlayTopLeftRoundAnimation(BattleModule.Round)
			self.ButtonNode:SetActive(true)
		end, Constant.Battle.BattleStartEffectPlayTime)

		self.BattleRoundBannerTimer:Start()
		self.InfoNode:SetActive(true)
		self.InputBlock:SetActive(false)
	end

	self.BattleActionSequence:NextRound()
end

function BattleUI:OnEndRound(sender, args)
	self:SettleDamageStatisticShow()

	local round = args.Round

	if round == BattleModule.MaxRound then
		return
	end

	self:PlayTopLeftRoundAnimation(round + 1)
end

function BattleUI:PlayTopLeftRoundAnimation(round)
	self.BattleRoundController:SetRound(round, BattleModule.MaxRound)
	GameEntry.Sound:PlaySound(10227, Constant.SoundGroup.UI)
end

function BattleUI:OnBattleUnitDead(sender, args)
	for i = 1, #self._attackerCellTabList do
		local battleUnitCell = self._attackerCellTabList[i]

		if battleUnitCell.BattleUnitID == args.UnitID then
			battleUnitCell:DoUnitDead()
		end
	end

	for i = 1, #self._defenderCellTabList do
		local battleUnitCell = self._defenderCellTabList[i]

		if battleUnitCell.BattleUnitID == args.UnitID then
			battleUnitCell:DoUnitDead()

			break
		end
	end
end

function BattleUI:ConvertPosToUI(pos)
	local sceneCamera = BattleModule.BattleCamera:GetComponent("Camera")
	local screenPos = sceneCamera:WorldToScreenPoint(pos)
	local uiPos = self._UICanvas.worldCamera:ScreenToWorldPoint(screenPos)
	local newPos = Vector3(uiPos.x, uiPos.y, self._UICanvas.transform.anchoredPosition3D.z - 1)

	return newPos
end

function BattleUI:Round(v, n)
	local mulPow = math.pow(10, n)

	return math.floor(v * mulPow) / mulPow
end

function BattleUI:OnClose(userData)
	self:HideMyTurnView(true)
	ModuleTimerUtil.Stop(Constant.UIControllerName.BattleUI)
	ModuleTimerUtil.Stop(Constant.ModuleTimerName.BattleCastSkillButtonGroup)
	self.BattleActionSequence:Hide()
	self:ClearEnemyHpCells(false)

	for i = 1, #self._attackerCellTabList do
		local battleUnitCell = self._attackerCellTabList[i]

		battleUnitCell:OnClose()
	end

	if self.BattleRoundBannerTimer ~= nil then
		self.BattleRoundBannerTimer:Stop()

		self.BattleRoundBannerTimer = nil
	end

	self.DamageStatisticsController:Clear()

	self.TurnDamage = 0
	self.ActingDollFirstRoot = nil
	self.ActingDollAnimationNode = nil
	self.ActingDollEntityRoot = nil

	self:StopSkillCG()

	self._isInit = false
	self.UpdateExecutedFrame = 0
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
	if not BattleModule.Initialized then
		return
	end

	if self.UpdateExecutedFrame == 0 then
		self.UpdateExecutedFrame = self.UpdateExecutedFrame + 1

		return
	end

	if self.UpdateExecutedFrame == 1 then
		self:SimulatedStart()
	end

	self.UpdateExecutedFrame = self.UpdateExecutedFrame + 1

	self.BattleRoundController:Update(elapseSeconds, realElapseSeconds)
	self.DamageStatisticsController:Update(elapseSeconds, realElapseSeconds)
	self.BattleActionSequence:Update(elapseSeconds, realElapseSeconds)

	for i = 1, #self._attackerCellTabList do
		local battleUnitCell = self._attackerCellTabList[i]

		battleUnitCell:Update(elapseSeconds, realElapseSeconds)
	end

	for i = #self._defenderCellTabList, 1, -1 do
		local battleUnitCell = self._defenderCellTabList[i]

		battleUnitCell:Update(elapseSeconds, realElapseSeconds)

		if battleUnitCell:IsUnitDead() and not battleUnitCell.IsBoss then
			self:ReleaseEnemyHpCell(battleUnitCell, false)
			table.remove(self._defenderCellTabList, i)
		end
	end

	if self.SkillSpineBackAnimName ~= nil and self.SkillSpineAnimation ~= nil and self.SkillSpineAnimation.state:GetCurrent(0).IsComplete then
		self:PlaySpineAnim(self.ActingDollEntityGameObject, self.SkillSpineBackAnimName, true)

		self.SkillSpineBackAnimName = nil
	end

	local actingHeroEntityPoint = UnityEngine.GameObject.Find("BattleCamera/ActingHeroEntityPoint")
	local screenPos = self._UICanvas.worldCamera:WorldToScreenPoint(self.SkillSpinePoint.transform.position)
	local scenePos = BattleModule.BattleCamera:GetComponent("Camera"):ScreenToWorldPoint(screenPos)

	scenePos.z = actingHeroEntityPoint.transform.position.z
	actingHeroEntityPoint.transform.position = scenePos
end

function BattleUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function BattleUI:OnLoadSucceed(assetName, asset, duration, userData)
	if userData ~= nil and userData.AssetParentCell ~= nil then
		userData.AssetParentCell:SetActive(true)

		local imgIcon = userData.AssetParentCell:GetComponent("Image")

		imgIcon.sprite = LuaCodeInterface.ToSprite(asset)
	end
end

function BattleUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function BattleUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i = 1, #self._attackerCellTabList do
		local battleUnitCell = self._attackerCellTabList[i]

		battleUnitCell:Dispose()
	end

	self._attackerCellTabList = nil

	self:ClearEnemyHpCells(true)
	self.BossUnitCell:Dispose()
	self.EnemyCellPool:Dispose()
	self.BattleRoundController:Dispose()
	self.DamageStatisticsController:Dispose()
	self.BattleCastSkillButtonGroup:Dispose()
	self.BattleActionSequence:Dispose()
	self.SkillTipController:Dispose()

	self._UICanvas = nil
end

function BattleUI:OnShowContent()
	self.Content:SetActive(true)
end

function BattleUI:OnHideContent()
	self.Content:SetActive(false)
end

function BattleUI:OnClickSkipFightBtn()
	if LoginModule.ServerTestMode then
		BattleModule.SetIsSkipping()
		BattleLogicAdapter.Instance:AddBattleOrderFromLua(BattleLogicAdapter.ORDER_SKIP_FIGHT)
	end
end

function BattleUI:OnClickSpeedBtn()
	if BattleModule.IsPlayingBulletTime then
		return
	end

	local availableSpeeds = Constant.Battle.SpeedList
	local speed = PlayerModule.GetBattleSpeed(BattleModule.Type)
	local index = table.indexOf(availableSpeeds, speed)

	index = index + 1

	if index > #availableSpeeds then
		index = 1
	end

	speed = availableSpeeds[index]

	BattleModule.SetSpeed(speed)
	PlayerModule.SaveBattleSpeed(BattleModule.Type, speed)
	UGUIUtil.SetText(self.SpeedBtnValueText, BattleUIApi:GetString("SpeedBtnValueText", speed))
end

function BattleUI:OnClickGiveUpBtn()
	local noticeCid

	noticeCid = BattleModule.Type == Constant.BattleType.Maze and 21045010 or 21045011

	NoticeModule.ShowNotice(noticeCid, self.GiveUpBattle, nil, self)
end

function BattleUI:GiveUpBattle()
	BattleLogicAdapter.Instance:AddBattleOrderFromLua(BattleLogicAdapter.ORDER_GIVE_UP)
end

function BattleUI:OnClickDisabledGiveUpBtn()
	NoticeModule.ShowNotice(21045012)
end

function BattleUI:ClearEnemyHpCells(isDestroy)
	for i = 1, #self._defenderCellTabList do
		local battleUnitCell = self._defenderCellTabList[i]

		if not battleUnitCell.IsBoss then
			self:ReleaseEnemyHpCell(battleUnitCell, isDestroy)
		else
			battleUnitCell:OnClose()
		end
	end

	self._defenderCellTabList = {
		self.BossUnitCell
	}
end

function BattleUI:ReleaseEnemyHpCell(cell, isDestroy)
	if not isDestroy then
		cell.View.transform:SetParent(self.UIController.transform, false)
	end

	cell.View:SetActive(false)
	cell:OnClose()
	self.EnemyCellPool:Release(cell)
end

function BattleUI:OnDamageStatistics(sender, args)
	self.TurnDamage = self.TurnDamage + args.AddDamage
end

function BattleUI:OnTurnStart(moverId)
	if self.ActingDollUnitId ~= 0 then
		self:HideMyTurnView()
	end
end

function BattleUI:OnBattleTurnEnd(unitId)
	self:SettleDamageStatisticShow()
end

function BattleUI:SettleDamageStatisticShow()
	if self.TurnDamage ~= 0 then
		self.DamageStatisticsController:AddDamage(self.TurnDamage)

		self.TurnDamage = 0
	end
end

function BattleUI:OnSelectSkill(nextUnitId)
	self:ItsMyTurn(nextUnitId)
end

function BattleUI:ItsMyTurn(unitId)
	if self:IsHiding() then
		self:FinishHideMyTurnViewImmediately()
	end

	if self.ActingDollUnitId ~= 0 then
		logError("打开选择技能面板错误，上一个角色的面板未关闭。")

		return
	end

	self.ActingDollUnitId = unitId

	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntityFailureEventArgs.EventId, self.DelegateOnShowElementEntityFailure)

	self.ActingDollEntityId = GameEntry.Entity:GenerateEntityID()

	local battleUnitPOD = BattleModule.GetBattleUnitPOD(unitId)
	local cfgMonsterData = CfgMonsterTable[battleUnitPOD.MonsterCfgId]

	function self.DelegateShowMyTurnView()
		self:ShowMyTurnView(unitId)
	end

	GameEntry.Entity:ShowBattleElement(self.ActingDollEntityId, cfgMonsterData.SkillEntityID, 0, self.ActingDollEntityRoot.transform, Vector3.zero)
end

function BattleUI:ShowMyTurnView(unitId)
	for i = 1, #self._attackerCellTabList do
		local battleUnitCell = self._attackerCellTabList[i]

		if battleUnitCell.BattleUnitID == unitId then
			battleUnitCell:ItsMyTurn()

			break
		end
	end

	self:SetActingDollPointPositionX(0)
	self:ShowSkills(unitId)
	UIUtil.PlayOrRewindDefaultAnim(self.ActingDollAnimationNode)
end

function BattleUI:HideActingDollEntity(instantly)
	if self.ActingDollEntityId ~= 0 then
		if instantly then
			self:DoHideActingDollEntity()
		else
			UIUtil.PlayOrRewindDefaultAnim(self.ActingDollAnimationNode, true)

			self.HideActingDollEntityTimer = Timer.New(function()
				self.HideActingDollEntityTimer = nil

				self:DoHideActingDollEntity()
			end, 0.67)

			self.HideActingDollEntityTimer:Start()
		end
	end
end

function BattleUI:DoHideActingDollEntity()
	self.HideActingDollEntityTimer = nil

	if self.ActingDollEntityId == 0 then
		return
	end

	local animation = self.ActingDollAnimationNode:GetComponent(typeof(UnityEngine.Animation))

	if animation ~= nil then
		animation:Stop()
	end

	GameEntry.Entity:HideEntity(self.ActingDollEntityId)

	self.ActingDollEntityId = 0
	self.ActingDollEntityGameObject = nil
	self.SkillSpineAnimation = nil
	self.SkillSpineBackAnimName = nil

	if self.DelegateShowMyTurnView ~= nil then
		self.DelegateShowMyTurnView = nil

		GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
		GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntityFailureEventArgs.EventId, self.DelegateOnShowElementEntityFailure)
	end

	self:SetActingDollPointPositionX(10000)
end

function BattleUI:PlaySpineAnim(spineGo, animationName, loop, backAnimName)
	if spineGo == nil then
		return
	end

	if self.SkillSpineAnimation == nil then
		local animation = spineGo:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

		if animation ~= nil then
			self.SkillSpineAnimation = animation

			if animation.state == nil then
				warning("Play animation error, state is null. Animation name: " .. animationName .. " gameObject: " .. spineGo.name)

				return
			end
		end
	end

	if self.SkillSpineAnimation.state ~= nil then
		local animData = self.SkillSpineAnimation.state.Data.SkeletonData:FindAnimation(animationName)

		if animData ~= nil then
			self.SkillSpineAnimation.state:ClearTrack(0)
			self.SkillSpineAnimation.skeleton:SetToSetupPose()
			self.SkillSpineAnimation.state:SetAnimation(0, animationName, loop)

			self.SkillSpineBackAnimName = backAnimName
		else
			warning("Play animation error, Animation(Spine.Animation) is null. Animation name: " .. animationName .. " gameObject: " .. spineGo.name)
		end
	end
end

function BattleUI:HideMyTurnView(instantly)
	self.ActingDollUnitId = 0

	if self.HideActingDollEntityTimer ~= nil then
		self.HideActingDollEntityTimer:Stop()

		self.HideActingDollEntityTimer = nil
	end

	BattleModule.SetUnitsSelectable({})

	if self.DelegateShowMyTurnView ~= nil then
		instantly = true
	end

	self:HideActingDollEntity(instantly)
	self.BattleCastSkillButtonGroup:Hide(instantly)
end

function BattleUI:IsHiding()
	return self.ActingDollUnitId == 0 and self.ActingDollEntityId ~= 0 and self.BattleCastSkillButtonGroup:IsHiding()
end

function BattleUI:FinishHideMyTurnViewImmediately()
	if self.HideActingDollEntityTimer ~= nil then
		self.HideActingDollEntityTimer:Stop()

		self.HideActingDollEntityTimer = nil

		self:DoHideActingDollEntity()
	end

	self.BattleCastSkillButtonGroup:FinishHideImmediately()
end

function BattleUI:SetActingDollPointPositionX(x)
	local position = self.ActingDollFirstRoot.transform.localPosition

	position.x = x
	self.ActingDollFirstRoot.transform.localPosition = position
end

function BattleUI:OnShowElementEntitySuccess(sender, args)
	if args.Entity.Id == self.ActingDollEntityId then
		GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
		GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntityFailureEventArgs.EventId, self.DelegateOnShowElementEntityFailure)
		setGameObjectLayers(args.Entity.gameObject.transform, IQIGame.Onigao.Game.Constant.Layer.BATTLE_ELEMENT_LAYER_NAME)

		self.ActingDollEntityGameObject = args.Entity.gameObject
		self.ActingDollEntityGameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation)).timeScale = 1 / UnityEngine.Time.timeScale

		self.DelegateShowMyTurnView()

		self.DelegateShowMyTurnView = nil
	end
end

function BattleUI:OnShowElementEntityFailure(sender, args)
	if args.EntityId == self.ActingDollEntityId then
		GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
		GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntityFailureEventArgs.EventId, self.DelegateOnShowElementEntityFailure)
		self.DelegateShowMyTurnView()

		self.DelegateShowMyTurnView = nil
	end
end

function BattleUI:OnBattleTimeScaleChanged()
	if self.ActingDollEntityGameObject ~= nil then
		self.ActingDollEntityGameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation)).timeScale = 1 / UnityEngine.Time.timeScale
	end
end

function BattleUI:ShowSkills(unitId)
	self.BattleCastSkillButtonGroup:Show(unitId)
end

function BattleUI:OnClickSkill(cfgSkillData, isStandby)
	if not BattleModule.LogicStarted then
		return
	end

	local selectedUnitId = self.BattleCastSkillButtonGroup.UnitId

	if selectedUnitId == nil or selectedUnitId == 0 then
		logError("找不到战斗单位，selectedUnitId == " .. tostring(selectedUnitId))

		return
	end

	if not isStandby then
		if cfgSkillData ~= nil then
			local troopType, units, canSelectArea, attackArea = BattleSkillModule.GetSelectableUnits(cfgSkillData, selectedUnitId)

			BattleModule.SetUnitsSelectable(units, troopType, canSelectArea, attackArea, cfgSkillData.Id)
			self:PlaySpineAnim(self.ActingDollEntityGameObject, "action", false, "idle")

			local battleUnitPOD = BattleModule.GetBattleUnitPOD(selectedUnitId)

			if battleUnitPOD == nil then
				logError("找不到battleUnitPOD. selectedUnitId == " .. tostring(selectedUnitId))

				return
			end

			local cfgMonsterData = CfgMonsterTable[battleUnitPOD.MonsterCfgId]

			if #cfgMonsterData.SkillSelectSpeak > 0 then
				local index = math.random(1, #cfgMonsterData.SkillSelectSpeak)

				GameEntry.Sound:PlaySound(cfgMonsterData.SkillSelectSpeak[index], Constant.SoundGroup.CHARACTER)
			end
		else
			logError("没有找到技能")
		end
	else
		self:ConfirmCastSkill(selectedUnitId, -1, nil)
		BattleModule.Standby(selectedUnitId)
	end

	self.SkillTipController:Hide()
end

function BattleUI:OnBattleEnd(battleOverCommand)
	self:HideMyTurnView(true)
end

function BattleUI:OnGestureOnElement(sender, args)
	if args.GestureType == Constant.GestureType.Tap then
		local tappedUnitId = args.UnitId
		local battleUnitData = BattleModule.GetBattleUnitData(tappedUnitId)

		if battleUnitData == nil then
			return
		end

		if battleUnitData.IsDead then
			return
		end

		local cfgSkillData = self.BattleCastSkillButtonGroup:GetCurrentSkill()

		if cfgSkillData == nil then
			return
		end

		local unitId = self.BattleCastSkillButtonGroup.UnitId
		local troopType, units, canSelectArea, attackArea = BattleSkillModule.GetSelectableUnits(cfgSkillData, unitId)

		if table.indexOf(units, tappedUnitId) == -1 then
			BattleModule.NoticeUnitCannotSelect(tappedUnitId)

			return
		end

		local targets = BattleSkillModule.GetTargetsBySampleUnit(tappedUnitId, attackArea)

		self:ConfirmCastSkill(unitId, cfgSkillData.Id, targets)
		self:PlaySpineAnim(self.ActingDollEntityGameObject, "action", false, "idle")
	end
end

function BattleUI:ConfirmCastSkill(unitId, skillCid, targets)
	BattleLogicAdapter.Instance:AddBattleOrderFromLua(BattleLogicAdapter.ORDER_CAST_SKILL, {
		UnitID = unitId,
		SkillCid = skillCid,
		Targets = targets
	})
	self:HideMyTurnView()
end

function BattleUI:OnShowSkillTip(skillCid, skillStrengths)
	self.SkillTipController:Show(skillCid, skillStrengths)
end

function BattleUI:OnClickDisabledAutoFightBtn()
	local result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.AUTO_FIGHT)

	if result then
		NoticeModule.ShowNotice(21045086)
	else
		local cfgFunctionTypeData = CfgFunctionTypeTable[Constant.UnlockType.AUTO_FIGHT]

		NoticeModule.ShowNoticeByType(1, cfgFunctionTypeData.LockNotice)
	end
end

function BattleUI:GetEnemyHpCanvas(battlePos)
	if battlePos <= 5 then
		return UnityEngine.GameObject.Find("EnemyHpBarUI_Front")
	end

	return UnityEngine.GameObject.Find("EnemyHpBarUI_Back")
end

function BattleUI:OnClickHelpBtn()
	UIModule.Open(Constant.UIControllerName.ComUIInfoUI, Constant.UILayer.UI, 7000)
end

function BattleUI:OnBattleLogicEnd()
	self:HideMyTurnView(true)
end

function BattleUI:SetAutoFightMode(autoFightMode)
	self.AutoNormalAtkToggle:GetComponent("Toggle").isOn = autoFightMode == Constant.Battle.AutoFightModeAutoNormal
	self.AutoSkillAtkToggle:GetComponent("Toggle").isOn = autoFightMode == Constant.Battle.AutoFightModeAutoSkill
end

function BattleUI:OnAutoModeChanged()
	local isAutoNormal = self.AutoNormalAtkToggle:GetComponent("Toggle").isOn
	local isAutoSkill = self.AutoSkillAtkToggle:GetComponent("Toggle").isOn
	local autoMode

	if isAutoNormal then
		autoMode = Constant.Battle.AutoFightModeAutoNormal
	elseif isAutoSkill then
		autoMode = Constant.Battle.AutoFightModeAutoSkill
	else
		autoMode = Constant.Battle.AutoFightModeManual
	end

	PlayerModule.SetAutoFightMode(BattleModule.Type, autoMode)

	if autoMode ~= Constant.Battle.AutoFightModeManual and self.ActingDollUnitId ~= 0 then
		BattleModule.AIChooseSkill(self.ActingDollUnitId, autoMode)
		self:HideMyTurnView()
	end
end

function BattleUI:OnPrepareCastSkill(unitId, monsterCid, skillCid, skillActionCid, needPlayCG)
	if not needPlayCG then
		return
	end

	self.SkillCGNode:SetActive(true)

	local cfgSkillActionData = CfgSkillActionTable[skillActionCid]

	if cfgSkillActionData.CGEffect ~= 0 then
		self.SkillCGEffectPlayId = GameEntry.Effect:PlayMountPointEffect(cfgSkillActionData.CGEffect, Constant.MountPoint.PointRoot, 0, self.SkillCGNode, 0, 0, LayerMask.NameToLayer("UI"), 0, self.UIController:GetComponent("Canvas").sortingOrder + 4)

		if cfgSkillActionData.CGSound ~= 0 then
			self.SkillCGSoundPlayId = GameEntry.Sound:PlaySound(cfgSkillActionData.CGSound, Constant.SoundGroup.ENVIRONMENT)
		end

		self.SkillCGTimer = Timer.New(function()
			self.SkillCGTimer = nil

			self:StopSkillCG()
		end, cfgSkillActionData.CGEffectDuration)

		self.SkillCGTimer:Start()
	else
		self.IsPlayingVideo = true

		local mediaMB = self.MediaPlayer:GetComponent("MediaMB")

		mediaMB:AddListener(self.DelegateOnMediaPlayerEvent)
		mediaMB:OpenVideoFromFile(cfgSkillActionData.Video, true)

		mediaMB.Volume = SettingModule.currentMusicVolume
	end
end

function BattleUI:OnMediaPlayerEvent(mediaPlayer, eventType, errorCode)
	if eventType == RenderHeads.Media.AVProVideo.MediaPlayerEvent.EventType.FinishedPlaying or eventType == RenderHeads.Media.AVProVideo.MediaPlayerEvent.EventType.Error then
		mediaPlayer.Events:RemoveListener(self.DelegateOnMediaPlayerEvent)
		self:StopSkillCG()
	end
end

function BattleUI:OnClickSkipSkillCGBtn()
	self:StopSkillCG()
end

function BattleUI:StopSkillCG()
	self:StopSkillCGEffect()
	self:StopVideoCG()
	self.SkillCGNode:SetActive(false)
	BattleModule.OnSkillCGComplete()
end

function BattleUI:StopSkillCGEffect()
	if self.SkillCGEffectPlayId == 0 then
		return
	end

	if self.SkillCGTimer ~= nil then
		self.SkillCGTimer:Stop()

		self.SkillCGTimer = nil
	end

	GameEntry.Effect:StopEffect(self.SkillCGEffectPlayId)

	self.SkillCGEffectPlayId = 0

	if self.SkillCGSoundPlayId ~= 0 then
		GameEntry.Sound:StopSound(self.SkillCGSoundPlayId)

		self.SkillCGSoundPlayId = 0
	end
end

function BattleUI:StopVideoCG()
	if not self.IsPlayingVideo then
		return
	end

	local mediaMB = self.MediaPlayer:GetComponent("MediaMB")

	mediaMB:CloseVideo()

	self.IsPlayingVideo = false
end

function BattleUI:OnClickSettingBtn()
	UIModule.Open(Constant.UIControllerName.SettingUI, Constant.UILayer.UI, true)
end

function BattleUI:SimulatedStart()
	self:UpdateDollHpScale()
end

function BattleUI:UpdateDollHpScale()
	local canvasHeight = self.UIController.transform.sizeDelta.y
	local canvasScaler = self.UIController:GetComponent("CanvasScaler")
	local standardHeight = canvasScaler.referenceResolution.y

	for i = 1, 5 do
		self["AttackerUnit" .. i].transform.localScale = Vector3(canvasHeight / standardHeight, canvasHeight / standardHeight, 1)
	end
end

function BattleUI:OnUIResolutionChange()
	for i = 1, #self._attackerCellTabList do
		local battleUnitCell = self._attackerCellTabList[i]

		battleUnitCell:RefreshPosition()
	end

	self:UpdateDollHpScale()
end

function BattleUI:OnShowOrEndPlot(isOn)
	self.Block:SetActive(isOn)
end

return BattleUI
