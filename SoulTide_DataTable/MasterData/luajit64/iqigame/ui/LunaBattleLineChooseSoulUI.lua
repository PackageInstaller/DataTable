-- chunkname: @IQIGame\\UI\\LunaBattleLineChooseSoulUI.lua

local LunaBattleLineChooseSoulUI = {
	SelectedPrefabHereConflict = false,
	SkillGroupItems = {},
	EquipCards = {},
	SuitEffectItems = {},
	SoulCells = {}
}

LunaBattleLineChooseSoulUI = Base:Extend("LunaBattleLineChooseSoulUI", "IQIGame.Onigao.UI.LunaBattleLineChooseSoulUI", LunaBattleLineChooseSoulUI)

require("IQIGame.UIExternalApi.LunaBattleLineChooseSoulUIApi")

local FormationSoulInfoItem = require("IQIGame.UI.FormationUI.FormationSoulInfoItem")
local FormationSkillGroupItem = require("IQIGame.UI.FormationUI.FormationSkillGroupItem")
local FormationEquipCard = require("IQIGame.UI.FormationUI.FormationEquipCard")
local FormationSuitEffectItem = require("IQIGame.UI.FormationUI.FormationSuitEffectItem")
local LunaBattleEnhanceChooseSoulCell = require("IQIGame.UI.LunaBattleLine.Enhance.LunaBattleEnhanceChooseSoulCell")

function LunaBattleLineChooseSoulUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickRemoveBtn()
		self:OnClickRemoveBtn()
	end

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateOnClickShowSuitViewBtn()
		self:OnClickShowSuitViewBtn()
	end

	function self.DelegateOnClickHideSuitViewBtn()
		self:OnClickHideSuitViewBtn()
	end

	local scrollAreaList = self.SoulCellGrid:GetComponent("ScrollAreaList")

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderSoulCell(cell)
	end

	function scrollAreaList.onSelectedCell(cell)
		self:OnSelectedSoulCell(cell)
	end

	self.SoulInfoItem = FormationSoulInfoItem.New(self.SoulInfoView)

	for i = 1, 3 do
		local skillGroupItem = FormationSkillGroupItem.New(UnityEngine.Object.Instantiate(self.SkillGroupPrefab), i, self.DelegateOnSwitchSingleSkill)

		skillGroupItem.View.transform:SetParent(self.SkillGroupGrid.transform, false)

		self.SkillGroupItems[i] = skillGroupItem
	end

	for i = 1, 3 do
		local card = FormationEquipCard.New(UnityEngine.Object.Instantiate(self.EquipCardPrefab), i, function(card)
			self:OnClickEquipCard(card)
		end)

		card.View.transform:SetParent(self.EquipCardGrid.transform, false)

		self.EquipCards[i] = card
	end

	local suitEffectDataList = {}

	for id, cfgSoulPaintingRareSuitData in pairsCfg(CfgSoulPaintingRareSuitTable) do
		table.insert(suitEffectDataList, cfgSoulPaintingRareSuitData)
	end

	table.sort(suitEffectDataList, function(cfgData1, cfgData2)
		return cfgData1.Quality < cfgData2.Quality
	end)

	for i = 1, 4 do
		local cfgSoulPaintingRareSuitData = suitEffectDataList[i]
		local item = FormationSuitEffectItem.New(UnityEngine.Object.Instantiate(self.SuitEffectPrefab), cfgSoulPaintingRareSuitData)

		item.View.transform:SetParent(self.SuitEffectGrid.transform, false)

		self.SuitEffectItems[i] = item
	end

	UGUIUtil.SetText(self.TitleText, LunaBattleLineChooseSoulUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.ChooseSoulLabel, LunaBattleLineChooseSoulUIApi:GetString("ChooseSoulLabel"))
	UGUIUtil.SetTextInChildren(self.ConfirmBtn, LunaBattleLineChooseSoulUIApi:GetString("ConfirmBtnText"))
	UGUIUtil.SetTextInChildren(self.RemoveBtn, LunaBattleLineChooseSoulUIApi:GetString("RemoveBtnText"))
end

function LunaBattleLineChooseSoulUI:GetPreloadAssetPaths()
	return nil
end

function LunaBattleLineChooseSoulUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LunaBattleLineChooseSoulUI:IsManualShowOnOpen(userData)
	return false
end

function LunaBattleLineChooseSoulUI:GetBGM(userData)
	return nil
end

function LunaBattleLineChooseSoulUI:OnOpen(userData)
	self.OnSelectCallback = userData.onSelect

	self:UpdateView(userData.selectCellPrefab, userData.teamPrefabs, userData.allPrefabs)
	self.SuitView:SetActive(false)
end

function LunaBattleLineChooseSoulUI:OnClose(userData)
	self.SoulInfoItem:OnClose()
end

function LunaBattleLineChooseSoulUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.RemoveBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickRemoveBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.ShowSuitViewBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickShowSuitViewBtn)
	self.HideSuitViewBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickHideSuitViewBtn)
end

function LunaBattleLineChooseSoulUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.RemoveBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickRemoveBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.ShowSuitViewBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickShowSuitViewBtn)
	self.HideSuitViewBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickHideSuitViewBtn)
end

function LunaBattleLineChooseSoulUI:OnPause()
	return
end

function LunaBattleLineChooseSoulUI:OnResume()
	return
end

function LunaBattleLineChooseSoulUI:OnCover()
	return
end

function LunaBattleLineChooseSoulUI:OnReveal()
	return
end

function LunaBattleLineChooseSoulUI:OnRefocus(userData)
	return
end

function LunaBattleLineChooseSoulUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LunaBattleLineChooseSoulUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LunaBattleLineChooseSoulUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LunaBattleLineChooseSoulUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LunaBattleLineChooseSoulUI:OnDestroy()
	self.SoulInfoItem:Dispose()

	for i = 1, #self.SkillGroupItems do
		local item = self.SkillGroupItems[i]

		item:Dispose()
	end

	for i = 1, #self.EquipCards do
		local card = self.EquipCards[i]

		card:Dispose()
	end

	for i = 1, #self.SuitEffectItems do
		local item = self.SuitEffectItems[i]

		item:Dispose()
	end

	for go, cell in pairs(self.SoulCells) do
		cell:Dispose()
	end
end

function LunaBattleLineChooseSoulUI:UpdateView(selectCellPrefab, teamPrefabs, allPrefabs)
	self.SelectPrefabAtPrevUI = selectCellPrefab
	self.TeamPrefabs = teamPrefabs
	self.AllPrefabs = allPrefabs

	table.sort(allPrefabs, function(prefab1, prefab2)
		local indexInTeam1 = table.indexOf(teamPrefabs, prefab1)
		local indexInTeam2 = table.indexOf(teamPrefabs, prefab2)

		if indexInTeam1 == indexInTeam2 then
			if prefab1.soulCid == prefab2.soulCid then
				return prefab1.skillGroupId < prefab2.skillGroupId
			end

			return prefab1.soulCid < prefab2.soulCid
		end

		if indexInTeam1 == -1 then
			indexInTeam1 = Constant.Number.IntMaxValue
		end

		if indexInTeam2 == -1 then
			indexInTeam2 = Constant.Number.IntMaxValue
		end

		return indexInTeam1 < indexInTeam2
	end)

	local defaultSelectIndex

	if selectCellPrefab ~= nil then
		defaultSelectIndex = table.indexOf(allPrefabs, selectCellPrefab)
	else
		for i = 1, #allPrefabs do
			local soulPrefab = allPrefabs[i]
			local indexInTeam = table.indexOf(teamPrefabs, soulPrefab)

			if indexInTeam == -1 then
				defaultSelectIndex = i

				break
			end
		end
	end

	local scrollAreaList = self.SoulCellGrid:GetComponent("ScrollAreaList")

	scrollAreaList.defaultSelectedToggle = defaultSelectIndex - 1

	scrollAreaList:Refresh(#self.AllPrefabs)
end

function LunaBattleLineChooseSoulUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function LunaBattleLineChooseSoulUI:OnClickRemoveBtn()
	UIModule.CloseSelf(self)

	if self.OnSelectCallback ~= nil then
		self.OnSelectCallback(nil)
	end
end

function LunaBattleLineChooseSoulUI:OnClickConfirmBtn()
	local function onConfirm()
		UIModule.CloseSelf(self)

		if self.OnSelectCallback ~= nil then
			self.OnSelectCallback(self.SelectedPrefabHere)
		end
	end

	if self.SelectedPrefabHereConflict then
		NoticeModule.ShowNotice(21062002, onConfirm)
	else
		onConfirm()
	end
end

function LunaBattleLineChooseSoulUI:OnRenderSoulCell(cell)
	local soulCell = self.SoulCells[cell.gameObject]

	if soulCell == nil then
		soulCell = LunaBattleEnhanceChooseSoulCell.New(cell.gameObject)
		self.SoulCells[cell.gameObject] = soulCell
	end

	local soulPrefab = self.AllPrefabs[cell.index + 1]
	local isSelectAtPrevUI = self.SelectPrefabAtPrevUI ~= nil and soulPrefab == self.SelectPrefabAtPrevUI

	soulCell:SetData(soulPrefab, isSelectAtPrevUI, self.TeamPrefabs)
end

function LunaBattleLineChooseSoulUI:OnSelectedSoulCell(cell)
	local soulCell = self.SoulCells[cell.gameObject]

	self:ShowSoulInfo(soulCell.SoulPrefab, soulCell.ConflictSoul)
end

function LunaBattleLineChooseSoulUI:ShowSoulInfo(soulPrefab, isConflictSoul)
	self.SelectedPrefabHere = soulPrefab
	self.SelectedPrefabHereConflict = isConflictSoul

	self.RemoveBtn:SetActive(self.SelectedPrefabHere == self.SelectPrefabAtPrevUI)
	self.SoulInfoItem:SetShowDataByFormationSoulPrefabPOD(soulPrefab)

	local cfgSoulData = CfgSoulTable[soulPrefab.soulCid]
	local defaultSkillGroups = cfgSoulData.DefaultSkill
	local skillGroupIndex = table.indexOf(defaultSkillGroups, soulPrefab.skillGroupId)
	local customSkills

	if skillGroupIndex == 3 then
		customSkills = soulPrefab.customSkills
	end

	for i = 1, #self.SkillGroupItems do
		local item = self.SkillGroupItems[i]

		item.View:SetActive(i == skillGroupIndex)

		if i == skillGroupIndex then
			item:SetShowData(soulPrefab.soulCid, soulPrefab.skillGroupId, customSkills, soulPrefab.allSkillStrengths)
		end
	end

	for i = 1, #self.EquipCards do
		local card = self.EquipCards[i]
		local formationEquipPOD = soulPrefab.equipments[i]
		local itemData

		if formationEquipPOD ~= nil then
			itemData = LunaBattleLineModule.CreateEquipData(formationEquipPOD, i, false)
		end

		card:SetData(itemData)
	end

	local equipCount = 0
	local minQuality = 5

	for i, formationEquipPOD in pairs(soulPrefab.equipments) do
		local cfgItemData = CfgItemTable[formationEquipPOD.cid]

		minQuality = math.min(minQuality, cfgItemData.Quality)
		equipCount = equipCount + 1
	end

	local isSuitActive = equipCount >= #self.EquipCards

	if not isSuitActive then
		minQuality = 0
	end

	for i = 1, #self.SuitEffectItems do
		local item = self.SuitEffectItems[i]

		item:SetData(minQuality)
	end

	self.SuitActiveIcon:SetActive(isSuitActive)
	self.SuitInActiveIcon:SetActive(not isSuitActive)
	UGUIUtil.SetTextInChildren(self.ShowSuitViewBtn, FormationChooseEquipUIApi:GetString("SuitTipText", isSuitActive, minQuality))
end

function LunaBattleLineChooseSoulUI:OnClickShowSuitViewBtn()
	self.SuitView:SetActive(true)
end

function LunaBattleLineChooseSoulUI:OnClickHideSuitViewBtn()
	self.SuitView:SetActive(false)
end

function LunaBattleLineChooseSoulUI:OnClickEquipCard(card)
	local itemData = card.EquipCell.itemData

	if itemData ~= nil then
		local allEquipDataList = {}

		for i = 1, #self.EquipCards do
			local equipCard = self.EquipCards[i]

			if equipCard.EquipCell.itemData ~= nil then
				table.insert(allEquipDataList, equipCard.EquipCell.itemData)
			end
		end

		UIModule.Open(Constant.UIControllerName.EquipUI, Constant.UILayer.UI, {
			forShow = true,
			data = allEquipDataList,
			defaultItemData = itemData
		})
	end
end

return LunaBattleLineChooseSoulUI
