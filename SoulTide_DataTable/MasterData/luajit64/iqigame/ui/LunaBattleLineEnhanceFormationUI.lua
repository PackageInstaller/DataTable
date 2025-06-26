-- chunkname: @IQIGame\\UI\\LunaBattleLineEnhanceFormationUI.lua

local LunaBattleLineEnhanceFormationUI = {
	ZoneId = 0,
	MonsterElementCells = {},
	SoulCells = {}
}

LunaBattleLineEnhanceFormationUI = Base:Extend("LunaBattleLineEnhanceFormationUI", "IQIGame.Onigao.UI.LunaBattleLineEnhanceFormationUI", LunaBattleLineEnhanceFormationUI)

require("IQIGame.UIExternalApi.LunaBattleLineEnhanceFormationUIApi")
require("IQIGame.UIExternalApi.LunaBattleLineAssistantUIApi")

local LunaBattleEnhanceSoulAttrPanel = require("IQIGame.UI.LunaBattleLine.Enhance.LunaBattleEnhanceSoulAttrPanel")
local LunaBattleAssistantSoulSkill = require("IQIGame.UI.LunaBattleLine.Assistant.LunaBattleAssistantSoulSkill")
local LunaBattleAssistantSoulEquip = require("IQIGame.UI.LunaBattleLine.Assistant.LunaBattleAssistantSoulEquip")
local MazeRewardCell = require("IQIGame.UI.MazeDetail.MazeRewardCell")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MonsterElementCell = require("IQIGame.UI.MazeDetail.MonsterElementCell")
local LunaBattleEnhanceSoulCell = require("IQIGame.UI.LunaBattleLine.Enhance.LunaBattleEnhanceSoulCell")

function LunaBattleLineEnhanceFormationUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickEnterBtn()
		self:OnClickEnterBtn()
	end

	self.SoulAttrController = LunaBattleEnhanceSoulAttrPanel.New(self.AttrView)
	self.SoulSkillController = LunaBattleAssistantSoulSkill.New(self.SkillView)
	self.SoulEquipController = LunaBattleAssistantSoulEquip.New(self.EquipView)
	self.MonsterElementPool = UIObjectPool.New(5, function()
		local cell = MonsterElementCell.New(UnityEngine.Object.Instantiate(self.WeakPrefab))

		return cell
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
	self.RewardCells = {}

	for i = 1, 5 do
		local itemCell = MazeRewardCell.New(UnityEngine.Object.Instantiate(self.RewardPrefab))

		itemCell.View.transform:SetParent(self.RewardGrid.transform, false)
		table.insert(self.RewardCells, itemCell)
	end

	for i = 1, 5 do
		local cell = LunaBattleEnhanceSoulCell.New(UnityEngine.Object.Instantiate(self.SoulCellPrefab), function(cell)
			self:OnSelectSoul(cell)
		end, function(cell)
			self:OnPickSoul(cell)
		end)

		cell.View.transform:SetParent(self.SoulCellGrid.transform, false)
		table.insert(self.SoulCells, cell)
	end

	UGUIUtil.SetText(self.TitleText, LunaBattleLineEnhanceFormationUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.FormationTitleText, LunaBattleLineEnhanceFormationUIApi:GetString("FormationTitleText"))
	UGUIUtil.SetText(self.SoulPrefabStrengthLevelLabel, LunaBattleLineEnhanceFormationUIApi:GetString("SoulPrefabStrengthLevelLabel"))
	UGUIUtil.SetText(self.WeakLabel, LunaBattleLineEnhanceFormationUIApi:GetString("WeakLabel"))
	UGUIUtil.SetText(self.RewardLabel, LunaBattleLineEnhanceFormationUIApi:GetString("RewardLabel"))
	UGUIUtil.SetTextInChildren(self.EnterBtn, LunaBattleLineEnhanceFormationUIApi:GetString("EnterBtnText"))
end

function LunaBattleLineEnhanceFormationUI:GetPreloadAssetPaths()
	return nil
end

function LunaBattleLineEnhanceFormationUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LunaBattleLineEnhanceFormationUI:IsManualShowOnOpen(userData)
	return false
end

function LunaBattleLineEnhanceFormationUI:GetBGM(userData)
	return nil
end

function LunaBattleLineEnhanceFormationUI:OnOpen(userData)
	self:UpdateView(userData.zoneId, userData.soulPrefabs)
end

function LunaBattleLineEnhanceFormationUI:OnClose(userData)
	return
end

function LunaBattleLineEnhanceFormationUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.EnterBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickEnterBtn)
end

function LunaBattleLineEnhanceFormationUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.EnterBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickEnterBtn)
end

function LunaBattleLineEnhanceFormationUI:OnPause()
	return
end

function LunaBattleLineEnhanceFormationUI:OnResume()
	return
end

function LunaBattleLineEnhanceFormationUI:OnCover()
	return
end

function LunaBattleLineEnhanceFormationUI:OnReveal()
	return
end

function LunaBattleLineEnhanceFormationUI:OnRefocus(userData)
	return
end

function LunaBattleLineEnhanceFormationUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LunaBattleLineEnhanceFormationUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LunaBattleLineEnhanceFormationUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LunaBattleLineEnhanceFormationUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LunaBattleLineEnhanceFormationUI:OnDestroy()
	self.SoulAttrController:Dispose()
	self.SoulSkillController:Dispose()
	self.SoulEquipController:Dispose()
	self:ClearMonsterElementCells(true)
	self.MonsterElementPool:Dispose()

	for i = 1, #self.RewardCells do
		local itemCell = self.RewardCells[i]

		itemCell:Dispose()
	end

	self.RewardCells = nil

	for i = 1, #self.SoulCells do
		local cell = self.SoulCells[i]

		cell:Dispose()
	end
end

function LunaBattleLineEnhanceFormationUI:UpdateView(zoneId, soulPrefabs)
	self.ZoneId = zoneId
	self.SoulPrefabs = soulPrefabs

	local cfgLunaBattleLineZoneData = CfgLunaBattleLineZoneTable[zoneId]

	UGUIUtil.SetText(self.ZoneNameText, cfgLunaBattleLineZoneData.Name)
	UGUIUtil.SetText(self.ZoneDescText, cfgLunaBattleLineZoneData.Name)
	self:RefreshWeakAndReward(cfgLunaBattleLineZoneData.TrainingLevel)

	local sampleSoulPrefab = soulPrefabs[1]

	UGUIUtil.SetText(self.LevelText, LunaBattleLineEnhanceFormationUIApi:GetString("LevelText", sampleSoulPrefab.lv))

	local startComponent = self.StarView:GetComponent("SimpleStarComponent")
	local cfgSoulQualityData = CfgSoulQualityTable[sampleSoulPrefab.qualityId]

	startComponent:UpdateView(5, cfgSoulQualityData.Quality)

	for i = 1, #self.SoulCells do
		local cell = self.SoulCells[i]

		cell:SetData(nil)
	end

	self:ShowSoulInfo(nil)
end

function LunaBattleLineEnhanceFormationUI:ShowSoulInfo(soulPrefab)
	self.SoulInfoView:SetActive(soulPrefab ~= nil)

	if soulPrefab ~= nil then
		self.SoulAttrController:SetData(soulPrefab)
		self.SoulSkillController:SetData(soulPrefab)
		self.SoulEquipController:SetData(soulPrefab)
	end
end

function LunaBattleLineEnhanceFormationUI:RefreshWeakAndReward(mazeInstanceCid)
	local cfgMazeInstanceData = CfgMazeInstanceTable[mazeInstanceCid]

	self:ClearMonsterElementCells(false)

	local elements = MazeModule.GetWeakShowData(cfgMazeInstanceData)

	self.WeakView:SetActive(#elements > 0)

	for i = 1, #elements do
		local cell = self.MonsterElementPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.WeakGrid.transform, false)
		cell:SetData(elements[i], cfgMazeInstanceData.MainWeakType)
		table.insert(self.MonsterElementCells, cell)
	end

	local rewards = MazeModule.GetRewardShowData(cfgMazeInstanceData)

	for i = 1, #self.RewardCells do
		local itemCell = self.RewardCells[i]
		local itemInfo = rewards[i]
		local itemCid = 0
		local itemNum = 0
		local isFirstPassReward = false
		local isUncertain = false

		if itemInfo ~= nil then
			itemCid = itemInfo.cid
			itemNum = itemInfo.number
			isFirstPassReward = itemInfo.isFirstPassReward
			isUncertain = itemInfo.isUncertain
		end

		itemCell:SetData(itemCid, itemNum, isFirstPassReward, isUncertain)
	end
end

function LunaBattleLineEnhanceFormationUI:ClearMonsterElementCells(isDestroy)
	for i = 1, #self.MonsterElementCells do
		local cell = self.MonsterElementCells[i]

		cell.View:SetActive(false)

		if not isDestroy then
			cell.View.transform:SetParent(self.UIController.transform, false)
		end

		self.MonsterElementPool:Release(cell)
	end

	self.MonsterElementCells = {}
end

function LunaBattleLineEnhanceFormationUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function LunaBattleLineEnhanceFormationUI:OnClickEnterBtn()
	local soulPrefabPositions = {}

	for i = 1, #self.SoulCells do
		local cell = self.SoulCells[i]

		if cell.SoulPrefab ~= nil then
			local soulPrefabPosition = {
				soulPrefabId = cell.SoulPrefab.id,
				postion = cell:GetPosition()
			}

			table.insert(soulPrefabPositions, soulPrefabPosition)
		end
	end

	if #soulPrefabPositions == 0 then
		NoticeModule.ShowNotice(21040093)

		return
	end

	MazeModule.SaveEntranceDataBeforeEnter(LunaBattleLineModule.GetRecoverMazeEntranceData(self.ZoneId))
	MazeModule.SendEnterStrengthenMaze(self.ZoneId, soulPrefabPositions)
end

function LunaBattleLineEnhanceFormationUI:OnSelectSoul(cell)
	self:ShowSoulInfo(cell.SoulPrefab)
end

function LunaBattleLineEnhanceFormationUI:OnPickSoul(cell)
	local teamPrefabs = {}

	for i = 1, #self.SoulCells do
		local lCell = self.SoulCells[i]

		if lCell.SoulPrefab ~= nil then
			table.insert(teamPrefabs, lCell.SoulPrefab)
		end
	end

	UIModule.Open(Constant.UIControllerName.LunaBattleLineChooseSoulUI, Constant.UILayer.UI, {
		selectCellPrefab = cell.SoulPrefab,
		teamPrefabs = teamPrefabs,
		allPrefabs = self.SoulPrefabs,
		onSelect = function(soulPrefab)
			self:OnPickSoulComplete(cell, soulPrefab)
		end
	})
end

function LunaBattleLineEnhanceFormationUI:OnPickSoulComplete(focusCell, soulPrefab)
	local oldPrefab = focusCell.SoulPrefab

	if oldPrefab ~= soulPrefab then
		focusCell:SetData(soulPrefab)
	end

	if oldPrefab == soulPrefab then
		return
	end

	if soulPrefab ~= nil then
		for i = 1, #self.SoulCells do
			local cell = self.SoulCells[i]

			if cell ~= focusCell and cell.SoulPrefab == soulPrefab then
				cell:SetData(oldPrefab)

				break
			end
		end

		for i = 1, #self.SoulCells do
			local cell = self.SoulCells[i]

			if cell ~= focusCell and cell.SoulPrefab ~= nil and cell.SoulPrefab.soulCid == soulPrefab.soulCid and cell.SoulPrefab.id ~= soulPrefab.id then
				cell:SetData(nil)

				break
			end
		end

		if focusCell:IsSelect() then
			self:ShowSoulInfo(soulPrefab)
		else
			focusCell:Select()
		end
	else
		local hasSoulCell

		for i = 1, #self.SoulCells do
			local cell = self.SoulCells[i]

			if cell.SoulPrefab ~= nil then
				hasSoulCell = cell

				break
			end
		end

		if hasSoulCell == nil then
			self:ShowSoulInfo(nil)
		else
			hasSoulCell:Select()
		end
	end
end

return LunaBattleLineEnhanceFormationUI
