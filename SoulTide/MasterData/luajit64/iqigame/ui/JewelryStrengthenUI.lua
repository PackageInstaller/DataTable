-- chunkname: @IQIGame\\UI\\JewelryStrengthenUI.lua

local JewelryStrengthenUI = {
	isOnToggle = false,
	isNeedCostItem = false,
	isNeedCostJewelry = false,
	isWearing = false,
	isMaxStart = false,
	isPlayingEffect = false,
	needCostJewelryNum = 0,
	jewelryCostItemCells = {}
}

JewelryStrengthenUI = Base:Extend("JewelryStrengthenUI", "IQIGame.Onigao.UI.JewelryStrengthenUI", JewelryStrengthenUI)

require("IQIGame.UIExternalApi.JewelryStrengthenUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local JewelryStrengthenItemCell = require("IQIGame.UI.Jewelry.JewelryStrengthen.JewelryStrengthenItemCell")
local JewelryStrengthenCostItemCell = require("IQIGame.UI.Jewelry.JewelryStrengthen.JewelryStrengthenCostItemCell")

function JewelryStrengthenUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateBtnStart()
		self:OnBtnStart()
	end

	function self.DelegateUpdateJewelryEvent(soulCid)
		self:OnUpdateJewelryEvent(soulCid)
	end

	function self.DelegateUpdateJewelryBagEvent(itemCid)
		self:OnUpdateJewelryBagEvent(itemCid)
	end

	function self.DelegateToggleValueChange(isOn)
		self:OnToggleValueChange(isOn)
	end

	function self.DelegateJewelryUpStartEvent(isCloseUI)
		self:OnJewelryUpStartEvent(isCloseUI)
	end

	function self.DelegateUpdateItem()
		self:OnUpdateItem()
	end

	self.currentJewelryItemCell = JewelryStrengthenItemCell.New(self.CurrentNode)
	self.nextStarJewelryItemCell = JewelryStrengthenItemCell.New(self.NextNode)
	self.costJewelryItemCell = JewelryStrengthenCostItemCell.New(self.JewelryCostMould)

	self.CostMould:SetActive(false)

	self.jewelryCostItemCellPool = UIObjectPool.New(4, function()
		return JewelryStrengthenCostItemCell.New(UnityEngine.Object.Instantiate(self.CostMould))
	end, function(cell)
		cell:Dispose()
	end)
end

function JewelryStrengthenUI:GetPreloadAssetPaths()
	return nil
end

function JewelryStrengthenUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function JewelryStrengthenUI:IsManualShowOnOpen(userData)
	return false
end

function JewelryStrengthenUI:GetBGM(userData)
	return nil
end

function JewelryStrengthenUI:OnOpen(userData)
	self.jewelryEquipData = userData.ItemData

	self.Effect:SetActive(false)

	self.isPlayingEffect = false
	self.TipToggle:GetComponent("Toggle").isOn = self.isOnToggle

	self:UpdateView()
end

function JewelryStrengthenUI:OnClose(userData)
	if self.timer then
		self.timer:Stop()
	end
end

function JewelryStrengthenUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	self.BtnStart:GetComponent("Button").onClick:AddListener(self.DelegateBtnStart)
	self.TipToggle:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateToggleValueChange)
	EventDispatcher.AddEventListener(EventID.UpdateJewelryEvent, self.DelegateUpdateJewelryEvent)
	EventDispatcher.AddEventListener(EventID.UpdateJewelryBagEvent, self.DelegateUpdateJewelryBagEvent)
	EventDispatcher.AddEventListener(EventID.JewelryUpStarEvent, self.DelegateJewelryUpStartEvent)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
end

function JewelryStrengthenUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	self.BtnStart:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnStart)
	self.TipToggle:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateToggleValueChange)
	EventDispatcher.RemoveEventListener(EventID.UpdateJewelryEvent, self.DelegateUpdateJewelryEvent)
	EventDispatcher.RemoveEventListener(EventID.UpdateJewelryBagEvent, self.DelegateUpdateJewelryBagEvent)
	EventDispatcher.RemoveEventListener(EventID.JewelryUpStarEvent, self.DelegateJewelryUpStartEvent)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
end

function JewelryStrengthenUI:OnPause()
	return
end

function JewelryStrengthenUI:OnResume()
	return
end

function JewelryStrengthenUI:OnCover()
	return
end

function JewelryStrengthenUI:OnReveal()
	return
end

function JewelryStrengthenUI:OnRefocus(userData)
	return
end

function JewelryStrengthenUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function JewelryStrengthenUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function JewelryStrengthenUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function JewelryStrengthenUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function JewelryStrengthenUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	if self.timer then
		self.timer:Stop()
	end

	self.timer = nil

	self.currentJewelryItemCell:Dispose()

	self.currentJewelryItemCell = nil

	self.nextStarJewelryItemCell:Dispose()

	self.nextStarJewelryItemCell = nil

	for i, v in pairs(self.jewelryCostItemCells) do
		self.jewelryCostItemCellPool:Release(v)
	end

	self.jewelryCostItemCells = {}

	self.jewelryCostItemCellPool:Dispose()

	self.jewelryCostItemCellPool = nil

	self.costJewelryItemCell:Dispose()

	self.currentJewelryItemCell = nil
end

function JewelryStrengthenUI:OnClickBtnClose()
	if self.isPlayingEffect then
		return
	end

	UIModule.CloseSelf(self)
end

function JewelryStrengthenUI:OnUpdateJewelryEvent(soulCid)
	if self.soulCid == soulCid then
		self:UpdateView()
	end
end

function JewelryStrengthenUI:OnUpdateJewelryBagEvent(itemCid)
	self.itemCid = itemCid

	self:UpdateView()
end

function JewelryStrengthenUI:OnUpdateItem()
	if self.jewelryEquipData then
		self.jewelryEquipData = WarehouseModule.GetItemDataById(self.jewelryEquipData.id)

		log("强化更新 饰品ID " .. self.jewelryEquipData.id .. "  星级 " .. self.jewelryEquipData.jewelryData.newJewelryEquipmentVoPOD.star)
		self:UpdateView()
	end
end

function JewelryStrengthenUI:OnJewelryUpStartEvent(isCloseUI)
	self.Effect:SetActive(false)
	self.Effect:SetActive(true)

	self.isPlayingEffect = true
	self.timer = Timer.New(function()
		self.isPlayingEffect = false

		if isCloseUI then
			self:OnClickBtnClose()
		end

		NoticeModule.ShowNotice(21045084)
	end, 1)

	self.timer:Start()
end

function JewelryStrengthenUI:UpdateView()
	local equipJewelryID

	self.isNeedCostItem = true
	self.isNeedCostJewelry = true

	if self.jewelryEquipData then
		self.isMaxStart = self.jewelryEquipData.jewelryData.newJewelryEquipmentVoPOD.star >= JewelryModule.JewelryMaxStarLv

		self.currentJewelryItemCell:SetData(self.jewelryEquipData, self.jewelryEquipData.jewelryData.newJewelryEquipmentVoPOD.star)

		if not self.isMaxStart then
			local nextStar = self.jewelryEquipData.jewelryData.newJewelryEquipmentVoPOD.star + 1
			local nextQuality = self.jewelryEquipData.jewelryData:GetJewelryQualityData().Quality + 1

			if nextQuality > 5 then
				nextQuality = 5
			end

			self.nextStarJewelryItemCell:SetData(self.jewelryEquipData, nextStar, nextQuality)

			for i, v in pairs(self.jewelryCostItemCells) do
				v.View.transform:SetParent(self.UIController.transform, false)
				v.View:SetActive(false)
				self.jewelryCostItemCellPool:Release(v)
			end

			self.jewelryCostItemCells = {}

			local cfgJewelryQualityData = self.jewelryEquipData.jewelryData:GetJewelryQualityData()

			if cfgJewelryQualityData then
				for i = 1, #cfgJewelryQualityData.RisingStarCostItem, 2 do
					local itemID = cfgJewelryQualityData.RisingStarCostItem[i]
					local needNum = cfgJewelryQualityData.RisingStarCostItem[i + 1]
					local haveNum = WarehouseModule.GetItemNumByCfgID(itemID)
					local cell = self.jewelryCostItemCellPool:Obtain()

					cell.View:SetActive(true)
					cell.View.transform:SetParent(self.CostGrid.transform, false)
					cell:SetData(itemID, needNum, haveNum, true)
					table.insert(self.jewelryCostItemCells, cell)

					if self.isNeedCostItem then
						self.isNeedCostItem = needNum <= haveNum
					end
				end

				self.needCostJewelryNum = 0

				for i = 1, #cfgJewelryQualityData.RisingStarCostJewelry, 2 do
					local itemID = cfgJewelryQualityData.RisingStarCostJewelry[i]
					local needNum = cfgJewelryQualityData.RisingStarCostJewelry[i + 1]
					local haveNum = WarehouseModule.GetItemNumByCfgID(itemID)

					if not self.isWearing and equipJewelryID == itemID then
						haveNum = haveNum - 1
					end

					if haveNum < 0 then
						haveNum = 0
					end

					local cell = self.jewelryCostItemCellPool:Obtain()

					cell.View:SetActive(true)
					cell.View.transform:SetParent(self.CostGrid.transform, false)
					cell:SetData(itemID, needNum, haveNum, true)
					table.insert(self.jewelryCostItemCells, cell)

					if self.isNeedCostJewelry then
						self.isNeedCostJewelry = needNum <= haveNum
					end

					if self.needCostJewelryNum <= 0 then
						self.needCostJewelryNum = needNum - haveNum
					end
				end
			end
		end
	end

	if self.needCostJewelryNum < 0 then
		self.needCostJewelryNum = 0
	end

	local haveNum = WarehouseModule.GetItemNumByCfgID(Constant.ItemID.JEWELRY_STAR_MATERIAL)

	self.costJewelryItemCell:SetData(Constant.ItemID.JEWELRY_STAR_MATERIAL, self.needCostJewelryNum, haveNum, false)
	self.Point:SetActive(not self.isMaxStart)
	self.NextNode:SetActive(not self.isMaxStart)
	self.CostNode:SetActive(not self.isMaxStart)
	self.MaxStarNode:SetActive(self.isMaxStart)
	self.BtnStart:SetActive(not self.isMaxStart)
	self.TipNode:SetActive(not self.isMaxStart)
	self.ButtonNode:SetActive(not self.isMaxStart)
	self.JewelryCostMould:SetActive(not self.isMaxStart)
end

function JewelryStrengthenUI:OnToggleValueChange(isOn)
	self.isOnToggle = isOn
end

function JewelryStrengthenUI:OnBtnStart()
	if self.isPlayingEffect then
		return
	end

	if self.isMaxStart then
		return
	end

	if not self.isNeedCostItem then
		NoticeModule.ShowNotice(21040078)

		return
	end

	if not self.isNeedCostJewelry then
		if not self.isOnToggle then
			NoticeModule.ShowNotice(21040078)

			return
		end

		local have = WarehouseModule.GetItemNumByCfgID(Constant.ItemID.JEWELRY_STAR_MATERIAL)

		if have < self.needCostJewelryNum then
			NoticeModule.ShowNotice(21040078)

			return
		end

		NoticeModule.ShowNotice(21045078, function()
			self:UpStar()
		end, nil, self)

		return
	end

	self:UpStar()
end

function JewelryStrengthenUI:UpStar()
	if self.jewelryEquipData and self.jewelryEquipData:GetCfg().Type == Constant.ItemType.JewelryEquip then
		JewelryModule.NewUpStar(self.jewelryEquipData.id)
	end
end

return JewelryStrengthenUI
