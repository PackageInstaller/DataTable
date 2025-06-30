-- chunkname: @IQIGame\\UI\\JewelryEquipUI.lua

local JewelryEquipUI = {
	speed = 1,
	jewelryDataTab = {},
	jewelryEquipCellPool = {},
	jewelryAttrCells = {}
}

JewelryEquipUI = Base:Extend("JewelryEquipUI", "IQIGame.Onigao.UI.JewelryEquipUI", JewelryEquipUI)

require("IQIGame.UIExternalApi.JewelryEquipUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local JewelryEquipCell = require("IQIGame.UI.Jewelry.JewelryEquip.JewelryEquipCell")
local JewelryAttrCell = require("IQIGame.UI.Jewelry.JewelryAttrCell")

function JewelryEquipUI:OnInit()
	self.equipItemCell = ItemCell.New(self.EquipMould, false)

	self.equipItemCell.ViewGo:SetActive(false)

	function self.DelegateBtnClose()
		self:OnBtnClose()
	end

	function self.DelegateBtnEquip()
		self:OnBtnEquip()
	end

	function self.DelegateBtnRemove()
		self:OnBtnRemove()
	end

	function self.DelegateBtnStart()
		self:OnBtnStart()
	end

	function self.DelegateSpeedSliderValue(value)
		self:OnSpeedSliderValueChange(value)
	end

	function self.DelegateUpdateJewelryEvent(soulCid)
		self:OnUpdateJewelryEvent(soulCid)
	end

	function self.DelegateUpdateSoulPrefab()
		self:OnUpdateSoulPrefab()
	end

	function self.DelegateUpdateItem()
		self:OnUpdateItem()
	end

	self.ScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderGridCell(cell)
	end
	self.ScrollArea:GetComponent("ScrollAreaList").onSelectedCell = function(cell)
		self:OnSelectedGridCell(cell)
	end

	self.AttrMould:SetActive(false)

	self.jewelryAttrCellPool = UIObjectPool.New(4, function()
		return JewelryAttrCell.New(UnityEngine.Object.Instantiate(self.AttrMould))
	end, function(cell)
		cell:Dispose()
	end)
end

function JewelryEquipUI:GetPreloadAssetPaths()
	return nil
end

function JewelryEquipUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function JewelryEquipUI:IsManualShowOnOpen(userData)
	return false
end

function JewelryEquipUI:GetBGM(userData)
	return nil
end

function JewelryEquipUI:OnOpen(userData)
	self.soulPrefab = userData.SoulPrefab
	self.formationIndex = userData.FormationIndex

	self:UpdateView()
end

function JewelryEquipUI:OnClose(userData)
	if self.selectJewelryEquipData and self.selectJewelryEquipData.jewelryData:IsPutOnPrefab(self.soulPrefab.id) then
		JewelryModule.SetJewelrySpeed(self.soulPrefab.id, self.selectJewelryEquipData.id, self.speed)
	end

	self.selectJewelryEquipData = nil
end

function JewelryEquipUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateBtnClose)
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateBtnClose)
	self.BtnEquip:GetComponent("Button").onClick:AddListener(self.DelegateBtnEquip)
	self.BtnRemove:GetComponent("Button").onClick:AddListener(self.DelegateBtnRemove)
	self.BtnStart:GetComponent("Button").onClick:AddListener(self.DelegateBtnStart)
	self.SpeedSlider:GetComponent(typeof(UnityEngine.UI.Slider)).onValueChanged:AddListener(self.DelegateSpeedSliderValue)
	EventDispatcher.AddEventListener(EventID.UpdateJewelryEvent, self.DelegateUpdateJewelryEvent)
	EventDispatcher.AddEventListener(EventID.SoulPrefabUpdate, self.DelegateUpdateSoulPrefab)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
end

function JewelryEquipUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnClose)
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnClose)
	self.BtnEquip:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnEquip)
	self.BtnRemove:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnRemove)
	self.BtnStart:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnStart)
	self.SpeedSlider:GetComponent(typeof(UnityEngine.UI.Slider)).onValueChanged:RemoveListener(self.DelegateSpeedSliderValue)
	EventDispatcher.RemoveEventListener(EventID.UpdateJewelryEvent, self.DelegateUpdateJewelryEvent)
	EventDispatcher.RemoveEventListener(EventID.SoulPrefabUpdate, self.DelegateUpdateSoulPrefab)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
end

function JewelryEquipUI:OnPause()
	return
end

function JewelryEquipUI:OnResume()
	return
end

function JewelryEquipUI:OnCover()
	return
end

function JewelryEquipUI:OnReveal()
	return
end

function JewelryEquipUI:OnRefocus(userData)
	return
end

function JewelryEquipUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function JewelryEquipUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function JewelryEquipUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function JewelryEquipUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function JewelryEquipUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.jewelryEquipCellPool) do
		v:Dispose()
	end

	for i, v in pairs(self.jewelryAttrCells) do
		self.jewelryAttrCellPool:Release(v)
	end

	self.jewelryAttrCells = {}

	self.jewelryAttrCellPool:Dispose()

	self.jewelryAttrCellPool = nil
end

function JewelryEquipUI:OnBtnClose()
	UIModule.CloseSelf(self)
end

function JewelryEquipUI:OnUpdateJewelryEvent(soulCid)
	if self.soulPrefab and self.soulPrefab.soulCid == soulCid then
		self:UpdateView()
	end
end

function JewelryEquipUI:OnUpdateSoulPrefab()
	if self.soulPrefab then
		self.soulPrefab = SoulPrefabModule.GetPrefab(self.soulPrefab.id)

		self:UpdateView()
	end
end

function JewelryEquipUI:OnUpdateItem()
	self:OnUpdateSoulPrefab()
end

function JewelryEquipUI:UpdateView()
	if self.soulPrefab and self.soulPrefab.soulCid then
		local soulData = SoulModule.GetSoulData(self.soulPrefab.soulCid)

		UGUIUtil.SetText(self.SoulName, soulData:GetCfgSoul().Name)

		local path = UIGlobalApi.GetImagePath(soulData:GetCfgSoulRes3D().HeadIcon)

		AssetUtil.LoadImage(self, path, self.SoulHeadIcon:GetComponent("Image"))
	end

	self.wearJewelryID = nil

	for i, v in pairs(self.soulPrefab.newJewelrySpeeds) do
		self.wearJewelryID = i
		self.speed = v

		break
	end

	self.jewelryDataTab = JewelryModule.GetNewJewelryBagItemDataTab()

	table.sort(self.jewelryDataTab, function(a, b)
		local isWearingA, soulCidA = a.jewelryData:GetWearInFormationState(self.formationIndex)
		local isWearingB, soulCidB = b.jewelryData:GetWearInFormationState(self.formationIndex)
		local isWearA = isWearingA and 1 or 0
		local isWearB = isWearingB and 1 or 0

		if isWearA ~= isWearB then
			return isWearB < isWearA
		elseif a.jewelryData.newJewelryEquipmentVoPOD.star ~= b.jewelryData.newJewelryEquipmentVoPOD.star then
			return a.jewelryData.newJewelryEquipmentVoPOD.star > b.jewelryData.newJewelryEquipmentVoPOD.star
		end

		return a.jewelryData.itemCid > b.jewelryData.itemCid
	end)
	self.EmptyNode:SetActive(#self.jewelryDataTab == 0)
	self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.jewelryDataTab)
	self:ShowSelectJewelry(self.selectJewelryEquipData, self.speed)
	self:RefreshSelection()
end

function JewelryEquipUI:OnSelectedGridCell(cell)
	self.selectJewelryEquipData = self.jewelryDataTab[cell.index + 1]

	self:ShowSelectJewelry(self.selectJewelryEquipData, self.speed)
	self:RefreshSelection()
end

function JewelryEquipUI:OnRenderGridCell(cell)
	local jewelryData = self.jewelryDataTab[cell.index + 1]

	if jewelryData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	cell.gameObject:SetActive(true)

	local instanceID = cell.gameObject:GetInstanceID()
	local jewelryEquipCell = self.jewelryEquipCellPool[instanceID]

	if jewelryEquipCell == nil then
		jewelryEquipCell = JewelryEquipCell.New(cell.gameObject)
		self.jewelryEquipCellPool[instanceID] = jewelryEquipCell
	end

	jewelryEquipCell:SetData(jewelryData, self.formationIndex)

	if self.selectJewelryEquipData then
		if self.selectJewelryEquipData.id == jewelryData.id then
			self.selectJewelryEquipData = jewelryData
		end
	elseif self.wearJewelryID then
		if self.wearJewelryID == jewelryData.id then
			self.selectJewelryEquipData = jewelryData
		end
	else
		self.selectJewelryEquipData = jewelryData
	end
end

function JewelryEquipUI:RefreshSelection()
	for i, v in pairs(self.jewelryEquipCellPool) do
		if self.selectJewelryEquipData then
			v:SetSelectionState(v.jewelryEquipData.id == self.selectJewelryEquipData.id)
		else
			v:SetSelectionState(false)
		end
	end
end

function JewelryEquipUI:ShowSelectJewelry(equipJewelryData, speed)
	if equipJewelryData then
		self.equipItemCell:SetItem(equipJewelryData)
		UGUIUtil.SetText(self.TextJewelryName, equipJewelryData:GetCfg().Name)

		for i, v in pairs(self.jewelryAttrCells) do
			v.View.transform:SetParent(self.UIController.transform, false)
			v.View:SetActive(false)
			self.jewelryAttrCellPool:Release(v)
		end

		self.jewelryAttrCells = {}

		local cfgJewelryQualityData = equipJewelryData.jewelryData:GetJewelryQualityData()

		if cfgJewelryQualityData then
			if cfgJewelryQualityData.JewelryPabilityID > 0 then
				local cell = self.jewelryAttrCellPool:Obtain()

				cell.View:SetActive(true)
				cell.View.transform:SetParent(self.AttrSort.transform, false)
				cell:SetData(cfgJewelryQualityData.JewelryPabilityID)
				table.insert(self.jewelryAttrCells, cell)
			end

			local path = JewelryEquipUIApi:GetString("JewelryQualityBg", cfgJewelryQualityData.Quality)

			AssetUtil.LoadImage(self, path, self.ImgQuality:GetComponent("Image"))
		end
	end

	self.SelectNode:SetActive(self.selectJewelryEquipData ~= nil)

	local isPrefabWearing = false
	local isWearing = false
	local speedLimit = 0

	if self.selectJewelryEquipData then
		isPrefabWearing = self.selectJewelryEquipData.jewelryData:IsPutOnPrefab(self.soulPrefab.id)

		local cfgJewelryQualityData = self.selectJewelryEquipData.jewelryData:GetJewelryQualityData()

		if cfgJewelryQualityData then
			speedLimit = cfgJewelryQualityData.SpeedLimit
		end

		isWearing = #self.selectJewelryEquipData.jewelryData.newJewelryEquipmentVoPOD.soul > 0
	end

	self.BtnEquip:SetActive(not isPrefabWearing)
	self.BtnRemove:SetActive(isPrefabWearing)
	self.Bar:SetActive(isPrefabWearing)
	self.BtnStart:SetActive(isWearing)

	if isPrefabWearing then
		self.SpeedSlider:GetComponent(typeof(UnityEngine.UI.Slider)).minValue = 0
		self.SpeedSlider:GetComponent(typeof(UnityEngine.UI.Slider)).maxValue = speedLimit
		self.SpeedSlider:GetComponent(typeof(UnityEngine.UI.Slider)).value = speed

		UGUIUtil.SetText(self.SliderNum, speed)
	end
end

function JewelryEquipUI:OnBtnEquip()
	if self.selectJewelryEquipData == nil then
		return
	end

	if self.selectJewelryEquipData:GetCfg().Type == Constant.ItemType.JewelryEquip then
		JewelryModule.NewWear(self.soulPrefab.id, self.selectJewelryEquipData.id, 1)
	end
end

function JewelryEquipUI:OnBtnRemove()
	if self.soulPrefab ~= nil then
		JewelryModule.NewUnWear(self.soulPrefab.id)
	end
end

function JewelryEquipUI:OnBtnStart()
	if self.selectJewelryEquipData then
		UIModule.Open(Constant.UIControllerName.JewelryStrengthenUI, Constant.UILayer.UI, {
			ItemData = self.selectJewelryEquipData
		})
	end
end

function JewelryEquipUI:OnSpeedSliderValueChange(value)
	self.speed = value

	UGUIUtil.SetText(self.SliderNum, self.speed)

	if self.selectJewelryEquipData and self.selectJewelryEquipData.jewelryData:IsPutOnPrefab(self.soulPrefab.id) then
		self.soulPrefab.newJewelrySpeeds[self.selectJewelryEquipData.id] = self.speed
	end
end

return JewelryEquipUI
