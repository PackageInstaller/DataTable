-- chunkname: @IQIGame\\UI\\PlaceGameFormationChooseEquipUI.lua

local PlaceGameFormationChooseEquipUI = {
	selectedCellIndex = -1,
	isOpen = false,
	equipCards = {},
	equipCells = {},
	itemDataList = {}
}

PlaceGameFormationChooseEquipUI = Base:Extend("PlaceGameFormationChooseEquipUI", "IQIGame.Onigao.UI.PlaceGameFormationChooseEquipUI", PlaceGameFormationChooseEquipUI)

require("IQIGame.UIExternalApi.PlaceGameFormationChooseEquipUIApi")

local PlaceGameFormationSoulInfoItem = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGameFormationChooseSoul.PlaceGameFormationSoulInfoItem")
local PlaceGameFormationEquipCard = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGameFormationChooseEquip.PlaceGameFormationEquipCard")
local PlaceGameFormationEquipItemCell = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGameFormationChooseEquip.PlaceGameFormationEquipItemCell")
local PlaceGameFormationEquipPrefabPanel = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGameFormationChooseEquip.PlaceGameFormationEquipPrefabPanel")
local PlaceGameFormationEquipTipController = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGameFormationChooseEquip.PlaceGameFormationEquipTipController")

function PlaceGameFormationChooseEquipUI:OnInit()
	UGUIUtil.SetText(self.TitleText, PlaceGameFormationChooseEquipUIApi:GetString("TitleText"))
	UGUIUtil.SetTextInChildren(self.EquipPrefabBtn, PlaceGameFormationChooseEquipUIApi:GetString("EquipPrefabBtnText"))
	UGUIUtil.SetTextInChildren(self.UnloadAllBtn, PlaceGameFormationChooseEquipUIApi:GetString("UnloadAllBtnText"))
	UGUIUtil.SetTextInChildren(self.ConfirmBtn, PlaceGameFormationChooseEquipUIApi:GetString("ConfirmBtnText"))
	UGUIUtil.SetTextInChildren(self.GoSoulBtn, PlaceGameFormationChooseEquipUIApi:GetString("GoSoulBtnText"))
	UGUIUtil.SetTextInChildren(self.GoEquipText, PlaceGameFormationChooseEquipUIApi:GetString("GoEquipText"))
	UGUIUtil.SetTextInChildren(self.EquipEmptyView, PlaceGameFormationChooseEquipUIApi:GetString("EquipEmptyViewText"))

	function self.DelegateOnClickGoSoulBtn()
		self:OnClickGoSoulBtn()
	end

	function self.DelegateOnClickUnloadAllBtn()
		self:OnClickUnloadAllBtn()
	end

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateOnClickEquipPrefabBtn()
		self:OnClickEquipPrefabBtn()
	end

	function self.DelegateOnClickCloseTipBtn()
		self:OnClickCloseTipBtn()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegatePlaceGameSoulPrefabUpdate(prefabId)
		self:OnPlaceGameSoulPrefabUpdate(prefabId)
	end

	self.EquipCellGrid:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderEquipCell(cell)
	end
	self.EquipCellGrid:GetComponent("ScrollAreaList").onSelectedCell = function(cell)
		self:OnClickEquipCell(cell)
	end
	self.soulInfoItem = PlaceGameFormationSoulInfoItem.New(self.SoulInfoView)
	self.equipCards = {}

	local fields = {
		Constant.PlaceGameEquipType.PlaceGame_Field_Arms,
		Constant.PlaceGameEquipType.PlaceGame_Field_Equipment,
		Constant.PlaceGameEquipType.PlaceGame_Field_Jewelry
	}

	for i = 1, #fields do
		local type = fields[i]
		local card = PlaceGameFormationEquipCard.New(UnityEngine.Object.Instantiate(self.EquipCardPrefab), type, function(card)
			self:OnClickEquipCard(card)
		end, function(card)
			self:OnLongClickEquipCard(card)
		end)

		card.View.transform:SetParent(self.EquipCardGrid.transform, false)

		self.equipCards[type] = card
	end

	self.equipTipController = PlaceGameFormationEquipTipController.New(self.TipView, function()
		self.CloseTipBtn:SetActive(false)
		self:ClearAllEquipCellSelect()
	end)

	self.equipTipController:Hide()

	self.equipPrefabPanel = PlaceGameFormationEquipPrefabPanel.New(self.EquipPrefabView, function()
		self.EquipListPanel:SetActive(true)
		self.EquipListPanelBottomButtons:SetActive(true)
	end)

	self.equipPrefabPanel:Hide()
end

function PlaceGameFormationChooseEquipUI:GetPreloadAssetPaths()
	return nil
end

function PlaceGameFormationChooseEquipUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function PlaceGameFormationChooseEquipUI:IsManualShowOnOpen(userData)
	return false
end

function PlaceGameFormationChooseEquipUI:GetBGM(userData)
	return nil
end

function PlaceGameFormationChooseEquipUI:OnOpen(userData)
	self.isOpen = true
	self.prefabId = userData.PrefabId
	self.formationIndex = userData.FormationIndex

	self.equipTipController:Hide()
	self:UpdateView()
end

function PlaceGameFormationChooseEquipUI:OnClose(userData)
	return
end

function PlaceGameFormationChooseEquipUI:OnAddListeners()
	self.GoSoulBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickGoSoulBtn)
	self.UnloadAllBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickUnloadAllBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.EquipPrefabBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickEquipPrefabBtn)
	self.CloseTipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseTipBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.AddEventListener(EventID.PlaceGameSoulPrefabUpdate, self.DelegatePlaceGameSoulPrefabUpdate)
end

function PlaceGameFormationChooseEquipUI:OnRemoveListeners()
	self.GoSoulBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickGoSoulBtn)
	self.UnloadAllBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickUnloadAllBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.EquipPrefabBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickEquipPrefabBtn)
	self.CloseTipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseTipBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.RemoveEventListener(EventID.PlaceGameSoulPrefabUpdate, self.DelegatePlaceGameSoulPrefabUpdate)
end

function PlaceGameFormationChooseEquipUI:OnPause()
	return
end

function PlaceGameFormationChooseEquipUI:OnResume()
	return
end

function PlaceGameFormationChooseEquipUI:OnCover()
	return
end

function PlaceGameFormationChooseEquipUI:OnReveal()
	return
end

function PlaceGameFormationChooseEquipUI:OnRefocus(userData)
	return
end

function PlaceGameFormationChooseEquipUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function PlaceGameFormationChooseEquipUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function PlaceGameFormationChooseEquipUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function PlaceGameFormationChooseEquipUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PlaceGameFormationChooseEquipUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.soulInfoItem:Dispose()

	self.soulInfoItem = nil

	self.equipTipController:Dispose()

	self.equipTipController = nil

	self.equipPrefabPanel:Dispose()

	self.equipPrefabPanel = nil

	for i, v in pairs(self.equipCards) do
		v:Dispose()
	end

	for i, v in pairs(self.equipCells) do
		v:Dispose()
	end
end

function PlaceGameFormationChooseEquipUI:OnClickEquipCard(card)
	self:SelectEquipCard(card)

	if card.EquipCell.itemData ~= nil then
		self:ShowTip(card.EquipCell.itemData, card.Index, card.Index, false)
	end
end

function PlaceGameFormationChooseEquipUI:SelectEquipCard(card)
	if self.selectedEquipCard ~= nil then
		self.selectedEquipCard:SetSelected(false)
	end

	card:SetSelected(true)

	self.selectedEquipCard = card

	self:RefreshEquipList(true)
end

function PlaceGameFormationChooseEquipUI:OnLongClickEquipCard(card)
	self:OpenEquipUI(card.EquipCell.itemData, 1)
end

function PlaceGameFormationChooseEquipUI:OnPlaceGameSoulPrefabUpdate(prefabId)
	if self.prefabId == prefabId then
		self.equipTipController:Hide()
		self:UpdateView()
	end
end

function PlaceGameFormationChooseEquipUI:UpdateView()
	self.soulPrefabData = PlaceGameModule.GetPlaceGameSoulPrefabDataByID(self.prefabId)

	local soulData = PlaceGameModule.GetPlaceGameSoulDataByCid(self.soulPrefabData.placeGameSoulPrefabPOD.soulCid)

	self.soulInfoItem:SetData(soulData, self.soulPrefabData, self.formationIndex)
	self:RefreshWearingEquips()
	self:RefreshSelectedEquip()
end

function PlaceGameFormationChooseEquipUI:RefreshWearingEquips()
	local hasEquip = false

	for i, v in pairs(self.equipCards) do
		local itemID = self.soulPrefabData.placeGameSoulPrefabPOD.equipments[i]
		local itemData = WarehouseModule.GetItemDataById(itemID)

		v:SetData(itemData)

		if itemID ~= nil then
			hasEquip = true
		end
	end

	self.UnloadAllBtn:GetComponent("Button").interactable = hasEquip
	self.UnloadAllBtn:GetComponent("ButtonDisabledComponent").IsDisabled = not hasEquip
end

function PlaceGameFormationChooseEquipUI:RefreshSelectedEquip()
	local selectType = -1

	for i, v in pairs(self.equipCards) do
		if v.EquipCell.itemData == nil then
			selectType = i

			break
		end
	end

	if selectType == -1 then
		if self.selectedEquipCard == nil then
			self:SelectEquipCard(self.equipCards[Constant.PlaceGameEquipType.PlaceGame_Field_Arms])
		else
			self:SelectEquipCard(self.selectedEquipCard)
		end
	else
		self:SelectEquipCard(self.equipCards[selectType])
	end
end

function PlaceGameFormationChooseEquipUI:RefreshEquipList(refreshPosition)
	if self.selectedEquipCard then
		local items = PlaceGameModule.GetPlaceGameEquips(self.selectedEquipCard.Index)

		self.itemDataList = PlaceGameModule.PlaceGameEquipSort(items)

		local scrollAreaList = self.EquipCellGrid:GetComponent("ScrollAreaList")

		if refreshPosition then
			scrollAreaList:Refresh(#self.itemDataList)
		else
			scrollAreaList:RenderCellsDynamic(#self.itemDataList)
		end

		self.EquipEmptyView:SetActive(#self.itemDataList == 0)
	end
end

function PlaceGameFormationChooseEquipUI:ClearAllEquipCellSelect()
	for gameObject, cell in pairs(self.equipCells) do
		cell:SetSelected(false)
	end

	self.selectedCellIndex = -1
end

function PlaceGameFormationChooseEquipUI:OnRenderEquipCell(cell)
	local equipCell = self.equipCells[cell.gameObject:GetInstanceID()]

	if equipCell == nil then
		equipCell = PlaceGameFormationEquipItemCell.New(cell.gameObject)
		equipCell.View.name = "Cell_" .. cell.index + 1
		self.equipCells[cell.gameObject:GetInstanceID()] = equipCell
	end

	equipCell:SetData(self.itemDataList[cell.index + 1], self.selectedEquipCard.ItemData, self.formationIndex, self.prefabId)
	equipCell:SetSelected(cell.index == self.selectedCellIndex)
end

function PlaceGameFormationChooseEquipUI:OnClickEquipCell(cell)
	local equipCell = self.equipCells[cell.gameObject:GetInstanceID()]

	if equipCell.IsSelected then
		self.equipTipController:Hide()
	else
		self:ClearAllEquipCellSelect()

		self.selectedCellIndex = cell.index

		equipCell:SetSelected(true)
		self:ShowTip(equipCell.ItemCell.ItemCfgOrData, self.selectedEquipCard.Index, 0, true)
	end
end

function PlaceGameFormationChooseEquipUI:ShowTip(itemData, selectedEquipIndex, tipPointType, isLinkCellOnLeft)
	self.equipTipController:Show(self.soulPrefabData.id, self.formationIndex, itemData, selectedEquipIndex, tipPointType, isLinkCellOnLeft)
	self.CloseTipBtn:SetActive(true)
end

function PlaceGameFormationChooseEquipUI:OnClickGoSoulBtn()
	UIModule.CloseSelf(self)
	UIModule.Open(Constant.UIControllerName.PlaceGameFormationChooseSoulUI, Constant.UILayer.UI, {
		FormationIndex = self.formationIndex,
		PrefabId = self.soulPrefabData.id
	})
end

function PlaceGameFormationChooseEquipUI:OnClickUnloadAllBtn()
	NoticeModule.ShowNotice(21045105, function()
		PlaceGameModule.SoulEquipUnload(self.soulPrefabData.id)
	end)
end

function PlaceGameFormationChooseEquipUI:OnClickConfirmBtn()
	UIModule.CloseSelf(self)
end

function PlaceGameFormationChooseEquipUI:OnClickEquipPrefabBtn()
	self.equipPrefabPanel:Show(self.soulPrefabData)
	self.EquipListPanel:SetActive(false)
	self.EquipListPanelBottomButtons:SetActive(false)
end

function PlaceGameFormationChooseEquipUI:OnClickCloseTipBtn()
	self.equipTipController:Hide()
end

function PlaceGameFormationChooseEquipUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

return PlaceGameFormationChooseEquipUI
