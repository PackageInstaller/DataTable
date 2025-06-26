-- chunkname: @IQIGame\\UI\\EvilErosionLevelDetailUI.lua

require("IQIGame.UIExternalApi.EvilErosionLevelDetailUIApi")

local MazeRewardCell = require("IQIGame.UI.MazeDetail.MazeRewardCell")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MonsterElementCell = require("IQIGame.UI.MazeDetail.MonsterElementCell")
local EvilErosionFormationCell = require("IQIGame.UI.EvilErosion.EvilErosionFormationCell")
local EvilErosionLevelDetailSoulInfoPanel = require("IQIGame.UI.EvilErosion.EvilErosionLevelDetailSoulInfoPanel")
local EvilErosionLevelDetailUI = {
	FormationIndex = 0,
	LevelCid = 0,
	MonsterElementCells = {},
	RewardCells = {},
	FormationCells = {}
}

EvilErosionLevelDetailUI = Base:Extend("EvilErosionLevelDetailUI", "IQIGame.Onigao.UI.EvilErosionLevelDetailUI", EvilErosionLevelDetailUI)

function EvilErosionLevelDetailUI:OnInit()
	function self.DelegateOnClickChangeSoulBtn()
		self:OnClickChangeSoulBtn()
	end

	function self.DelegateOnClickEnterLevelBtn()
		self:OnClickEnterLevelBtn()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnChangeFormationPos()
		self:OnChangeFormationPos()
	end

	function self.DelegateOnChangePosition()
		self:OnChangePosition()
	end

	function self.DelegateOnWearingEquipChanged()
		self:OnWearingEquipChanged()
	end

	function self.DelegateOnChangeCustomSkill()
		self:OnChangeCustomSkill()
	end

	self.MonsterElementPool = UIObjectPool.New(5, function()
		local cell = MonsterElementCell.New(UnityEngine.Object.Instantiate(self.MonsterElementPrefab))

		return cell
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)

	for i = 1, 5 do
		local cell = MazeRewardCell.New(UnityEngine.Object.Instantiate(self.RewardPrefab))

		cell.View.transform:SetParent(self.RewardGrid.transform, false)

		self.RewardCells[i] = cell
	end

	for i = 1, 5 do
		local cell = EvilErosionFormationCell.New(UnityEngine.Object.Instantiate(self.FormationCellPrefab), i, function(index, openSoulUIDirectly)
			self:OnFormationCellSelected(index, openSoulUIDirectly)
		end)

		cell.View.transform:SetParent(self.FormationCellGrid.transform, false)

		self.FormationCells[i] = cell
	end

	self.SoulInfoPanel = EvilErosionLevelDetailSoulInfoPanel.New(self.SoulInfoView)

	UGUIUtil.SetText(self.TitleText, EvilErosionLevelDetailUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.MonsterPanelLabel, EvilErosionLevelDetailUIApi:GetString("MonsterPanelLabel"))
	UGUIUtil.SetText(self.RewardLabelText, EvilErosionLevelDetailUIApi:GetString("RewardLabelText"))
	UGUIUtil.SetTextInChildren(self.ChangeSoulBtn, EvilErosionLevelDetailUIApi:GetString("ChangeSoulBtnText"))
	UGUIUtil.SetTextInChildren(self.EnterLevelBtn, EvilErosionLevelDetailUIApi:GetString("EnterLevelBtnText"))
end

function EvilErosionLevelDetailUI:GetPreloadAssetPaths()
	return nil
end

function EvilErosionLevelDetailUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EvilErosionLevelDetailUI:IsManualShowOnOpen(userData)
	return false
end

function EvilErosionLevelDetailUI:GetBGM(userData)
	return nil
end

function EvilErosionLevelDetailUI:OnOpen(userData)
	self:UpdateView(userData.levelCid)
end

function EvilErosionLevelDetailUI:OnClose(userData)
	return
end

function EvilErosionLevelDetailUI:OnAddListeners()
	self.ChangeSoulBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickChangeSoulBtn)
	self.EnterLevelBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickEnterLevelBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.AddEventListener(EventID.EvilErosionChangeFormationPos, self.DelegateOnChangeFormationPos)
	EventDispatcher.AddEventListener(EventID.EvilErosionChangePosition, self.DelegateOnChangePosition)
	EventDispatcher.AddEventListener(EventID.EvilErosionWearingEquipChanged, self.DelegateOnWearingEquipChanged)
	EventDispatcher.AddEventListener(EventID.EvilErosionChangeCustomSkill, self.DelegateOnChangeCustomSkill)
end

function EvilErosionLevelDetailUI:OnRemoveListeners()
	self.ChangeSoulBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickChangeSoulBtn)
	self.EnterLevelBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickEnterLevelBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.RemoveEventListener(EventID.EvilErosionChangeFormationPos, self.DelegateOnChangeFormationPos)
	EventDispatcher.RemoveEventListener(EventID.EvilErosionChangePosition, self.DelegateOnChangePosition)
	EventDispatcher.RemoveEventListener(EventID.EvilErosionWearingEquipChanged, self.DelegateOnWearingEquipChanged)
	EventDispatcher.RemoveEventListener(EventID.EvilErosionChangeCustomSkill, self.DelegateOnChangeCustomSkill)
end

function EvilErosionLevelDetailUI:OnPause()
	return
end

function EvilErosionLevelDetailUI:OnResume()
	return
end

function EvilErosionLevelDetailUI:OnCover()
	return
end

function EvilErosionLevelDetailUI:OnReveal()
	return
end

function EvilErosionLevelDetailUI:OnRefocus(userData)
	return
end

function EvilErosionLevelDetailUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EvilErosionLevelDetailUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EvilErosionLevelDetailUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EvilErosionLevelDetailUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EvilErosionLevelDetailUI:OnDestroy()
	self:ClearMonsterElementCells()
	self.MonsterElementPool:Dispose()

	for i = 1, #self.RewardCells do
		local cell = self.RewardCells[i]

		cell:Dispose()
	end

	for i = 1, #self.FormationCells do
		local cell = self.FormationCells[i]

		cell:Dispose()
	end

	self.SoulInfoPanel:Dispose()
end

function EvilErosionLevelDetailUI:OnClickChangeSoulBtn()
	if self.FormationIndex == nil or self.FormationIndex == 0 then
		logError("FormationIndex is Error: " .. tostring(self.FormationIndex))

		return
	end

	UIModule.Open(Constant.UIControllerName.EvilErosionSoulListUI, Constant.UILayer.UI, {
		curFormationPos = self.FormationIndex
	})
end

function EvilErosionLevelDetailUI:OnClickEnterLevelBtn()
	local soulNum = 0

	for i = 1, #self.FormationCells do
		local cell = self.FormationCells[i]

		if cell.SoulPrefabPOD ~= nil then
			soulNum = soulNum + 1
		end
	end

	if soulNum == 0 then
		NoticeModule.ShowNotice(21040093)

		return
	end

	EvilErosionModule.Fight(self.LevelCid)
end

function EvilErosionLevelDetailUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function EvilErosionLevelDetailUI:UpdateView(levelCid)
	self.LevelCid = levelCid

	local cfgEvilErosionLevelData = CfgEvilErosionLevelTable[levelCid]

	UGUIUtil.SetText(self.LevelNameText, cfgEvilErosionLevelData.Name)
	self:ClearMonsterElementCells()

	local weakTypes = EvilErosionModule.GetGlobalData().WeakType

	for i = 1, #weakTypes do
		local cell = self.MonsterElementPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.MonsterElementGrid.transform, false)
		cell:SetData(weakTypes[i])
		table.insert(self.MonsterElementCells, cell)
	end

	local rewards = cfgEvilErosionLevelData.Reward

	for i = 1, #self.RewardCells do
		local itemCell = self.RewardCells[i]
		local itemCid = rewards[(i - 1) * 2 + 1] or 0
		local itemNum = rewards[(i - 1) * 2 + 2]

		itemCell:SetData(itemCid, itemNum, false, false)
	end

	self:RefreshFormation(true)
end

function EvilErosionLevelDetailUI:RefreshFormation(isReset)
	local soulsInFormation = {}

	for i = 1, #EvilErosionModule.DailyDupPOD.evilErosionPOD.soulPrefabs do
		local soulPrefabPOD = EvilErosionModule.DailyDupPOD.evilErosionPOD.soulPrefabs[i]

		if soulPrefabPOD.formationPos ~= 0 then
			soulsInFormation[soulPrefabPOD.formationPos] = soulPrefabPOD
		end
	end

	local focusFormationPos

	for i = 1, #self.FormationCells do
		local cell = self.FormationCells[i]
		local soulPrefabPOD = soulsInFormation[i]

		cell:SetData(soulPrefabPOD)

		if isReset then
			if focusFormationPos == nil and soulPrefabPOD ~= nil then
				focusFormationPos = i
			end
		elseif cell:IsSelected() then
			focusFormationPos = i
		end
	end

	focusFormationPos = focusFormationPos or 1

	local toggleSuccess = self.FormationCells[focusFormationPos]:SetSelected()

	if not toggleSuccess then
		self:ShowFormationSoulInfo(focusFormationPos)
	end
end

function EvilErosionLevelDetailUI:ClearMonsterElementCells()
	for i = 1, #self.MonsterElementCells do
		local cell = self.MonsterElementCells[i]

		cell.View:SetActive(false)
		cell.View.transform:SetParent(self.UIController.transform, false)
		self.MonsterElementPool:Release(cell)
	end

	self.MonsterElementCells = {}
end

function EvilErosionLevelDetailUI:OnFormationCellSelected(formationIndex, openSoulUIDirectly)
	self:ShowFormationSoulInfo(formationIndex, openSoulUIDirectly)
end

function EvilErosionLevelDetailUI:ShowFormationSoulInfo(formationIndex, openSoulUIDirectly)
	self.FormationIndex = formationIndex

	local cell = self.FormationCells[formationIndex]

	cell:SetSelected()
	self.SoulInfoPanel:SetData(cell.SoulPrefabPOD)

	if openSoulUIDirectly then
		UIModule.Open(Constant.UIControllerName.EvilErosionSoulListUI, Constant.UILayer.UI, {
			curFormationPos = self.FormationIndex
		})
	end
end

function EvilErosionLevelDetailUI:OnChangeFormationPos()
	self:RefreshFormation(false)
end

function EvilErosionLevelDetailUI:OnChangePosition()
	self:RefreshFormation(false)
end

function EvilErosionLevelDetailUI:OnWearingEquipChanged()
	self:RefreshFormation(false)
end

function EvilErosionLevelDetailUI:OnChangeCustomSkill()
	self:RefreshFormation(false)
end

return EvilErosionLevelDetailUI
