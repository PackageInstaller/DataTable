-- chunkname: @IQIGame\\UI\\BattleSettlementUI.lua

local BattleSettlementUI = {
	Playing = false,
	battleAttackTroopAliveNum = 0,
	FightResult = 0,
	CompanionUnitCells = {}
}

BattleSettlementUI = Base:Extend("BattleSettlementUI", "IQIGame.Onigao.UI.BattleSettlementUI", BattleSettlementUI)

local BattleUnitSettlementCell = require("IQIGame.UI.Battle.BattleUnitSettlementCell")

function BattleSettlementUI:OnInit()
	function self.DelegateOutBattleHandler()
		self:OutBattleHandler()
	end

	self.outBattleBtnTxt:GetComponent("Text").text = BattleUIApi:GetString("outBattleBtnTxt")

	local prefabPath = AssetPath.Get(GlobalKey.UIPrefabPath, "_BattleUI/BattleEndUnitCell")
	local prefab = self.UIController:GetPreloadedAsset(prefabPath)

	for i = 1, 5 do
		local battleUnitCell = BattleUnitSettlementCell.New(UnityEngine.Object.Instantiate(prefab))

		battleUnitCell.View.transform:SetParent(self.dollUnitNode.transform, false)
		table.insert(self.CompanionUnitCells, battleUnitCell)
	end
end

function BattleSettlementUI:GetPreloadAssetPaths()
	local unitCellPrefabPath = AssetPath.Get(GlobalKey.UIPrefabPath, "_BattleUI/BattleEndUnitCell")

	return {
		unitCellPrefabPath
	}
end

function BattleSettlementUI:GetOpenPreloadAssetPaths(userData)
	local isWin = userData.FightResult == Constant.BattleFightResult.Win
	local atkDataList = userData.Attacker.ArrFightUnitPOD
	local aliveCompanionFightUnitPODList = {}

	for i = 1, #atkDataList do
		local fightUnitPOD = atkDataList[i]
		local isUnitDead = fightUnitPOD.SPStatus[4]

		if not isUnitDead or not isWin then
			table.insert(aliveCompanionFightUnitPODList, fightUnitPOD)
		end
	end

	local attackerIndex = math.random(1, #aliveCompanionFightUnitPODList)
	local attackerData = aliveCompanionFightUnitPODList[attackerIndex]

	self.ShowDollCfgMonsterData = CfgMonsterTable[attackerData.MonsterCfgId]

	local soulResID = self.ShowDollCfgMonsterData.SoulRes
	local soulCid

	for id, cfgDressData in pairsCfg(CfgDressTable) do
		if cfgDressData.SoulResID == soulResID then
			soulCid = cfgDressData.SoulID

			break
		end
	end

	self.SoulPortraitPrefabPath = UIGlobalApi.GetSoulPortraitPath(soulCid, soulResID)

	return {
		self.SoulPortraitPrefabPath
	}
end

function BattleSettlementUI:OnOpen(userData)
	self.Playing = true
	self.FightResult = userData.FightResult

	self:UpdateView(userData.Attacker.ArrFightUnitPOD, userData.DmgRecords, userData.HurtRecords, userData.HealRecords)
end

function BattleSettlementUI:OnAddListeners()
	self.outBattleBtn:GetComponent("Button").onClick:AddListener(self.DelegateOutBattleHandler)
end

function BattleSettlementUI:OnRemoveListeners()
	self.outBattleBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOutBattleHandler)
end

function BattleSettlementUI:UpdateView(soulPODs, dmgRecords, hurtRecords, healRecords)
	local prefab = self.UIController:GetPreloadedAsset(self.SoulPortraitPrefabPath)

	if prefab ~= nil then
		self.SoulPortrait = UnityEngine.Object.Instantiate(prefab)

		self.SoulPortrait.transform:SetParent(self.PortraitNode.transform, false)
	else
		logError("找不到灵魂肖像预设：" .. self.SoulPortraitPrefabPath)
	end

	local isWin = self.FightResult == Constant.BattleFightResult.Win
	local cfgBattleAreaData = CfgBattleAreaTable[BattleModule.GetBattleAreaCid()]

	self.battleWinNode:SetActive(not cfgBattleAreaData.AwaysDraw and isWin)
	self.battleFailNode:SetActive(not cfgBattleAreaData.AwaysDraw and not isWin)
	self.CompleteNode:SetActive(cfgBattleAreaData.AwaysDraw)

	local totalDmg = 0
	local totalHurt = 0
	local totalHeal = 0
	local maxDmg = 0
	local maxHurt = 0
	local maxHeal = 0

	for i = 1, #soulPODs do
		local fightUnitPOD = soulPODs[i]

		totalDmg = totalDmg + dmgRecords[fightUnitPOD.MonsterCfgId]
		totalHurt = totalHurt + hurtRecords[fightUnitPOD.MonsterCfgId]
		totalHeal = totalHeal + healRecords[fightUnitPOD.MonsterCfgId]
		maxDmg = math.max(maxDmg, dmgRecords[fightUnitPOD.MonsterCfgId])
		maxHurt = math.max(maxHurt, hurtRecords[fightUnitPOD.MonsterCfgId])
		maxHeal = math.max(maxHeal, healRecords[fightUnitPOD.MonsterCfgId])
	end

	local animCells = {}
	local posDataMap = {}

	for i = 1, #soulPODs do
		local fightUnitPOD = soulPODs[i]
		local battlePos = fightUnitPOD.BattlePos

		if battlePos > 5 then
			battlePos = battlePos - 5
		end

		posDataMap[battlePos] = fightUnitPOD
	end

	for i = 1, #self.CompanionUnitCells do
		local battleUnitCell = self.CompanionUnitCells[i]
		local fightUnitPOD = posDataMap[i]
		local monsterCid = -1

		if fightUnitPOD ~= nil then
			monsterCid = fightUnitPOD.MonsterCfgId

			table.insert(animCells, battleUnitCell)
		end

		battleUnitCell:SetItem(fightUnitPOD, dmgRecords[monsterCid], hurtRecords[monsterCid], healRecords[monsterCid], maxDmg, maxHurt, maxHeal, totalDmg, totalHurt, totalHeal, cfgBattleAreaData.AwaysDraw)
	end

	local soundCid, cvCid

	if isWin then
		soundCid = 10401
		cvCid = self.ShowDollCfgMonsterData.BattleEndWinSpeak
	else
		soundCid = 10402
		cvCid = self.ShowDollCfgMonsterData.BattleEndLoseSpeak
	end

	GameEntry.Sound:PlaySound(soundCid, Constant.SoundGroup.UI)
	self.TalkView:SetActive(false)
	self:StopTimer()

	self.SoulSpeakTimer = Timer.New(function()
		self.SoulSpeakTimer = nil

		self.TalkView:SetActive(cvCid ~= 0)

		if cvCid ~= 0 then
			local cfgCVData = CfgCVTable[cvCid]

			self.TalkText:GetComponent("Text").text = cfgCVData.Text

			GameEntry.Sound:PlaySound(10230, Constant.SoundGroup.UI)
			GameEntry.Sound:PlaySound(cfgCVData.SoundID, Constant.SoundGroup.CHARACTER)
		end
	end, 2)

	self.SoulSpeakTimer:Start()

	self.CellTweenTimer = FrameTimer.New(function()
		if self.CellTweenTimer.loop == 1 then
			self.CellTweenTimer = nil
		end

		local battleUnitCell = animCells[1]

		battleUnitCell:DoTweenPlay()
		table.remove(animCells, 1)

		if #animCells == 0 then
			self.Playing = false
		end
	end, 5, #animCells)

	self.CellTweenTimer:Start()
end

function BattleSettlementUI:OutBattleHandler()
	if self.Playing then
		return
	end

	UIModule.Close(Constant.UIControllerName.BattleSettlementUI)
	MazeModule.QuitBattle()
end

function BattleSettlementUI:OnClose(userData)
	self:StopTimer()

	if self.SoulPortrait ~= nil then
		UnityEngine.Object.DestroyImmediate(self.SoulPortrait)

		self.SoulPortrait = nil
	end
end

function BattleSettlementUI:OnPause()
	return
end

function BattleSettlementUI:OnResume()
	return
end

function BattleSettlementUI:OnCover()
	return
end

function BattleSettlementUI:OnReveal()
	return
end

function BattleSettlementUI:OnRefocus(userData)
	return
end

function BattleSettlementUI:OnUpdate(elapseSeconds, realElapseSeconds)
	for i = 1, #self.CompanionUnitCells do
		self.CompanionUnitCells[i]:OnUpdate()
	end
end

function BattleSettlementUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function BattleSettlementUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function BattleSettlementUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function BattleSettlementUI:OnDestroy()
	for i = 1, #self.CompanionUnitCells do
		self.CompanionUnitCells[i]:Dispose()
	end
end

function BattleSettlementUI:StopTimer()
	if self.SoulSpeakTimer ~= nil then
		self.SoulSpeakTimer:Stop()

		self.SoulSpeakTimer = nil
	end

	if self.CellTweenTimer ~= nil then
		self.CellTweenTimer:Stop()

		self.CellTweenTimer = nil
	end
end

return BattleSettlementUI
