-- chunkname: @IQIGame\\UI\\DoubleFightRewardUI.lua

local DoubleFightRewardUI = {
	scoreTipCellTab = {},
	CompanionUnitCells = {}
}

DoubleFightRewardUI = Base:Extend("DoubleFightRewardUI", "IQIGame.Onigao.UI.DoubleFightRewardUI", DoubleFightRewardUI)

local InvasionScoreTipCell = require("IQIGame.UI.Activity.DoubleFight.InvasionScoreTipCell")
local ActiveDoubleFightScoreUIData = require("IQIGame.Module.ActiveDoubleFight.ActiveDoubleFightScoreUIData")
local BattleUnitSettlementCell = require("IQIGame.UI.Battle.BattleUnitSettlementCell")

function DoubleFightRewardUI:OnInit()
	UGUIUtil.SetText(self.outBattleBtnTxt, DoubleFightRewardUIApi:GetString("outBattleBtnTxt"))
	UGUIUtil.SetText(self.TextInfoTitle, DoubleFightRewardUIApi:GetString("TextInfoTitle"))

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	self.scoreTipCellTab = {}

	for i = 1, 2 do
		local cell = InvasionScoreTipCell.New(self["Bar" .. i])

		self.scoreTipCellTab[i] = cell
	end

	for i = 1, 5 do
		local battleUnitCell = BattleUnitSettlementCell.New(UnityEngine.Object.Instantiate(self.BattleEndUnitCellMould))

		battleUnitCell.View.transform:SetParent(self.SoulGrid.transform, false)
		table.insert(self.CompanionUnitCells, battleUnitCell)
	end
end

function DoubleFightRewardUI:GetPreloadAssetPaths()
	return nil
end

function DoubleFightRewardUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DoubleFightRewardUI:IsManualShowOnOpen(userData)
	return false
end

function DoubleFightRewardUI:GetBGM(userData)
	return nil
end

function DoubleFightRewardUI:OnOpen(userData)
	self.rewardData = userData

	self:UpdateView()
end

function DoubleFightRewardUI:OnClose(userData)
	self:StopTimer()

	MainCityBattleModule.Instance.BattleOverCommand = nil
end

function DoubleFightRewardUI:OnAddListeners()
	self.outBattleBtn:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
end

function DoubleFightRewardUI:OnRemoveListeners()
	self.outBattleBtn:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
end

function DoubleFightRewardUI:OnPause()
	return
end

function DoubleFightRewardUI:OnResume()
	return
end

function DoubleFightRewardUI:OnCover()
	return
end

function DoubleFightRewardUI:OnReveal()
	return
end

function DoubleFightRewardUI:OnRefocus(userData)
	return
end

function DoubleFightRewardUI:OnUpdate(elapseSeconds, realElapseSeconds)
	for i = 1, #self.CompanionUnitCells do
		self.CompanionUnitCells[i]:OnUpdate()
	end
end

function DoubleFightRewardUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DoubleFightRewardUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DoubleFightRewardUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DoubleFightRewardUI:OnDestroy()
	for i, v in pairs(self.scoreTipCellTab) do
		v:Dispose()
	end

	for i = 1, #self.CompanionUnitCells do
		self.CompanionUnitCells[i]:Dispose()
	end
end

function DoubleFightRewardUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.DoubleFightRewardUI)
end

function DoubleFightRewardUI:UpdateView()
	if self.rewardData then
		self.infoNode:SetActive(self.rewardData.win)
		self.WinNode:SetActive(self.rewardData.win)
		self.LoseNode:SetActive(not self.rewardData.win)
		self.ImgUp:SetActive(self.rewardData.isUp)
		self:ShowHurtRank(MainCityBattleModule.Instance.BattleOverCommand)

		local cfgFightList = CfgDoubleFightListTable[self.rewardData.fightListCfgId]
		local currentScore = self.rewardData.hurtScore + self.rewardData.roundScore

		UGUIUtil.SetText(self.TextInfoScore, currentScore)

		local showDataTab = {}

		showDataTab[1] = ActiveDoubleFightScoreUIData.New(1, self.rewardData.hurtPercentage, cfgFightList.HPScore[self.rewardData.index][1], self.rewardData.hurtScore)
		showDataTab[2] = ActiveDoubleFightScoreUIData.New(2, self.rewardData.round, cfgFightList.RoundScore[self.rewardData.index][1], self.rewardData.roundScore)

		for i, v in pairs(self.scoreTipCellTab) do
			local showData = showDataTab[i]

			v:SetData(showData)
		end
	end
end

function DoubleFightRewardUI:ShowHurtRank(battleOverCommandData)
	local isShow = false

	if battleOverCommandData then
		local cfgBattleAreaData = CfgBattleAreaTable[MainCityBattleModule.Instance.BattleAreaCid]
		local soulPODs = battleOverCommandData.Attacker.ArrFightUnitPOD
		local dmgRecords = battleOverCommandData.DmgRecords
		local hurtRecords = battleOverCommandData.HurtRecords
		local healRecords = battleOverCommandData.HealRecords
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

		for i = 1, #self.CompanionUnitCells do
			local battleUnitCell = self.CompanionUnitCells[i]
			local fightUnitPOD = soulPODs[i]
			local monsterCid = -1

			if fightUnitPOD ~= nil then
				monsterCid = fightUnitPOD.MonsterCfgId

				table.insert(animCells, battleUnitCell)
			end

			battleUnitCell:SetItem(fightUnitPOD, dmgRecords[monsterCid], hurtRecords[monsterCid], healRecords[monsterCid], maxDmg, maxHurt, maxHeal, totalDmg, totalHurt, totalHeal, cfgBattleAreaData.AwaysDraw)

			isShow = true
		end

		self:StopTimer()

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

	self.SoulGrid:SetActive(isShow)
end

function DoubleFightRewardUI:StopTimer()
	if self.CellTweenTimer ~= nil then
		self.CellTweenTimer:Stop()

		self.CellTweenTimer = nil
	end
end

return DoubleFightRewardUI
