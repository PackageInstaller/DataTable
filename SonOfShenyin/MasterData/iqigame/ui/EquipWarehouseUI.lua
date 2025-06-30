-- chunkname: @IQIGame\\UI\\EquipWarehouseUI.lua

local EquipWarehouseUI = Base:Extend("EquipWarehouseUI", "IQIGame.Onigao.UI.EquipWarehouseUI", {
	IsShowContrastingPanel = false,
	partEquipDataList = {},
	sortEquipDataList = {},
	equipCellList = {},
	curEquipCellList = {},
	suitScreenCellList = {}
})
local SuitScreenCellView = require("IQIGame.UI.Equip.SuitScreenCellView")
local EquipListCell = require("IQIGame.UI.Equip.EquipListCell")
local EquipBaseInfoView = require("IQIGame.UI.Equip.EquipBaseInfoView")
local EquipHoleView = require("IQIGame.UI.Equip.EquipHoleView")
local FilterSort = require("IQIGame.UI.Common.FilterSort")
local awakenEffectPanel = require("IQIGame/UI/Equip/EquipAwakenEffectPanel")
local equipReplacePanelClass = require("IQIGame/UI/Equip/EquipReplacePanel")
local CommonSortingPopupListView = require("IQIGame.UI.Common.CommonSortingPopupListView")
local CommonScreenControllerView = require("IQIGame/UI/Common/Screen/CommonScreenControllerView")

function EquipWarehouseUI:OnInit()
	self:InitComponent()
	self:InitDelegation()
	self:InitStaticText()
end

function EquipWarehouseUI:InitComponent()
	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
	self.EquipWarehouseScrollAreaList = self.EquipWarehouseContent:GetComponent("ScrollAreaList")

	function self.EquipWarehouseScrollAreaList.onSelectedCell(gridCell)
		self:OnSelectedGridCell(gridCell)
	end

	function self.EquipWarehouseScrollAreaList.onRenderCell(gridCell)
		self:OnRenderGridCell(gridCell)
	end

	self.Filter = Filter.New()
	self.Sorter = Sorter.New()

	self.Sorter:SetSortFunctionList(EquipModule.GetSortingFuncList(EquipModule.DefaultSortingIndex).SortingFunc)

	self.screenControllerView = CommonScreenControllerView.New(self.FilterSortParent, function(isSortChange)
		self:__OnEquipFilterSortCallback(isSortChange)
	end)

	function self.screenControllerView.resetScreenDataEvent()
		return CommonScreenModule.GetCommonEquipScreenData(true)
	end

	self.awakenEffectPanel = awakenEffectPanel.New(self.awakenEffectPanel, self)

	self.awakenEffectPanel:Hide()

	self.replacePanel = equipReplacePanelClass.New(self.equipReplacePanel, self)

	self.replacePanel:Hide()

	self.equipDefaultBaseInfoView = EquipBaseInfoView.New(self.EquipAttParent, self)
	self.equipContrastBaseInfoView = EquipBaseInfoView.New(self.EquipContrastParent, self)

	local equipPartToggleFunc = self:EquipPartToggleFuncTable()

	self.EquipHoleView = EquipHoleView.New(self.EquipHoleContent, equipPartToggleFunc, self)
	self.animCom = self.UIController:GetComponent("Animation")
end

function EquipWarehouseUI:EquipPartToggleFuncTable()
	local toggleFuncTable = {}
	local partSortTable = CfgDiscreteDataTable[54].Data

	for _, partIndex in pairs(partSortTable) do
		toggleFuncTable[partIndex] = function(isOn)
			if isOn then
				self:OnSelectPartIndex(partIndex)
			end
		end
	end

	return toggleFuncTable
end

function EquipWarehouseUI:InitDelegation()
	function self.DelegateOnClickReplaceButton()
		self:OnClickReplaceButton()
	end

	function self.delegateOnClickChargeButton()
		EquipModule.ReplaceEquip(WarlockModule.curWarlockData.cid, self.SelectedEquipData.id)
	end

	function self.DelegateOnClickDischargeButton()
		self:OnClickDischargeButton()
	end

	function self.DelegateOnClickIntensifyButton()
		self:OnClickIntensifyButton()
	end

	function self.DelegateOnClickLockButton()
		self:OnClickLockButton()
	end

	function self.DelegateOnClickContrastButton()
		self:OnClickContrastButton()
	end

	function self.delegateOnEquipSuccess()
		self:OnWearEquipSuccess()
	end

	function self.delegateOnUnloadEquipSucceedSucess()
		self:OnUnloadEquipSucceed()
	end

	function self.delegateOnIntensifyEquipSucess()
		self:OnIntensifyEquipSucess()
	end

	function self.delegateLockEquipSucceedSucess()
		self:OnLockEquipRefresh()
	end

	function self.delegateOnWarehouseChange()
		self:DataChangeRefresh()
	end

	function self.showAwakenEquipEvent(isShow, SuitIds)
		self:ShowAwakenEquipEvent(isShow, SuitIds)
	end
end

function EquipWarehouseUI:InitStaticText()
	return
end

function EquipWarehouseUI:OnDestroy()
	self:OnRemoveListeners()
	self.screenControllerView:Dispose()
	self.commonReturnBtn:Dispose()
	self.equipDefaultBaseInfoView:OnDestroy()
	self.EquipHoleView:OnDestroy()
	self.awakenEffectPanel:OnDestroy()

	for i, v in pairs(self.equipCellList) do
		v:OnDestroy()
	end

	for i, v in pairs(self.suitScreenCellList) do
		v:OnDestroy()
	end

	if self.effectID ~= nil then
		GameEntry.Effect:StopEffect(self.effectID)
	end

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function EquipWarehouseUI:OnOpen(equipPartIndex)
	self.partIndex = -1

	self.screenControllerView:SetSortPopupData(CommonSortingPopupListView.GetEquipSortingData(), 1)
	self.screenControllerView:SetSortOrderData(true)

	local commonScreenData = CommonScreenModule.GetCommonEquipScreenData(true)

	self.screenControllerView:SetScreenPopupData(commonScreenData)
	self:OnSelectPartIndex(equipPartIndex)
end

function EquipWarehouseUI:OnClose(userData)
	self.Sorter:Reset()
	self.Filter:Reset()
	self:ResetContrastPanel()

	if self.AnimCoroutine then
		self.AnimCoroutine:Stop()

		self.AnimCoroutine = nil
	end
end

function EquipWarehouseUI:OnAddListeners()
	self.ChargeButton:GetComponent("Button").onClick:AddListener(self.delegateOnClickChargeButton)
	self.ReplaceButton:GetComponent("Button").onClick:AddListener(self.DelegateOnClickReplaceButton)
	self.DischargeButton:GetComponent("Button").onClick:AddListener(self.DelegateOnClickDischargeButton)
	self.IntensityButton:GetComponent("Button").onClick:AddListener(self.DelegateOnClickIntensifyButton)
	self.LockButton:GetComponent("Button").onClick:AddListener(self.DelegateOnClickLockButton)
	self.ContrastButton:GetComponent("Button").onClick:AddListener(self.DelegateOnClickContrastButton)
	EventDispatcher.AddEventListener(EventID.WearEquipSucceedNew, self.delegateOnEquipSuccess)
	EventDispatcher.AddEventListener(EventID.UnloadEquipSucceedNew, self.delegateOnUnloadEquipSucceedSucess)
	EventDispatcher.AddEventListener(EventID.UpgradeEquipSucceedNew, self.delegateOnIntensifyEquipSucess)
	EventDispatcher.AddEventListener(EventID.LockEquipSucceedNew, self.delegateLockEquipSucceedSucess)
	EventDispatcher.AddEventListener(EventID.AddItem, self.delegateOnWarehouseChange)
	EventDispatcher.AddEventListener(EventID.DeleteItem, self.delegateOnWarehouseChange)
	EventDispatcher.AddEventListener(EventID.EquipWareHouseShowAwakenEvent, self.showAwakenEquipEvent)
end

function EquipWarehouseUI:OnRemoveListeners()
	self.ChargeButton:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickChargeButton)
	self.ReplaceButton:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickReplaceButton)
	self.DischargeButton:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickDischargeButton)
	self.IntensityButton:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickIntensifyButton)
	self.LockButton:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickLockButton)
	self.ContrastButton:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickContrastButton)
	EventDispatcher.RemoveEventListener(EventID.WearEquipSucceedNew, self.delegateOnEquipSuccess)
	EventDispatcher.RemoveEventListener(EventID.UnloadEquipSucceedNew, self.delegateOnUnloadEquipSucceedSucess)
	EventDispatcher.RemoveEventListener(EventID.UpgradeEquipSucceedNew, self.delegateOnIntensifyEquipSucess)
	EventDispatcher.RemoveEventListener(EventID.LockEquipSucceedNew, self.delegateLockEquipSucceedSucess)
	EventDispatcher.RemoveEventListener(EventID.AddItem, self.delegateOnWarehouseChange)
	EventDispatcher.RemoveEventListener(EventID.DeleteItem, self.delegateOnWarehouseChange)
	EventDispatcher.RemoveEventListener(EventID.EquipWareHouseShowAwakenEvent, self.showAwakenEquipEvent)
end

function EquipWarehouseUI:ShowAwakenEquipEvent(isShow, SuitIds)
	if isShow then
		self.awakenEffectPanel:Show()
		self.awakenEffectPanel:Refresh(SuitIds)
	else
		self.awakenEffectPanel:Hide()
	end
end

function EquipWarehouseUI:RefreshEquipWarehousePanel(selectRefresh)
	if selectRefresh then
		for k, v in pairs(self.curEquipCellList) do
			local data = self.sortEquipDataList[k + 1]

			if data then
				v:Refresh(data, v.tableIndex)
			end
		end
	else
		self.curEquipCellList = {}

		LuaUtility.SetGameObjectShow(self.textEmpty, #self.sortEquipDataList == 0)
		self.EquipWarehouseScrollAreaList:Refresh(#self.sortEquipDataList)
	end
end

function EquipWarehouseUI:FilterEquip(equipList)
	local filteredEquipList = self.Filter:ApplyFilter(equipList)

	filteredEquipList = self.Sorter:Apply(filteredEquipList)

	return filteredEquipList
end

function EquipWarehouseUI:GetEquipByPartIndex(partIndex)
	local equipList = {}

	for i, item in pairs(WarehouseModule.AllItems) do
		if item.equipData ~= nil and item:GetCfg().Part == partIndex then
			table.insert(equipList, item.equipData)
		end
	end

	return equipList
end

function EquipWarehouseUI:OnSelectedGridCell(gridCellData)
	local data = self.sortEquipDataList[gridCellData.index + 1]
	local insID = gridCellData.gameObject:GetInstanceID()
	local cell = self.equipCellList[insID]

	data.insID = insID
	data.tableIndex = gridCellData.index

	if cell == nil then
		cell = EquipListCell.New(gridCellData.gameObject)
		self.equipCellList[insID] = cell
	end

	local lastSelectedEquipData = self.SelectedEquipData

	if lastSelectedEquipData then
		lastSelectedEquipData.ItemCustomCount = 0

		local lastSelectedEquipCell = self.equipCellList[lastSelectedEquipData.insID]

		if lastSelectedEquipCell then
			lastSelectedEquipCell:Refresh(lastSelectedEquipData, lastSelectedEquipData.tableIndex)
		end
	end

	self.SelectedEquipData = data
	self.SelectedEquipData.ItemCustomCount = 1

	cell:Refresh(self.SelectedEquipData, gridCellData.index)

	cell.gameObject.name = self.SelectedEquipData.id

	self:RefreshAttributePanel(self.SelectedEquipData, true)
	self:RefreshOperationPanel()
end

function EquipWarehouseUI:GetEquipByIndex(index)
	return self.sortEquipDataList[index]
end

function EquipWarehouseUI:OnRenderGridCell(gridCellData)
	local data = self.sortEquipDataList[gridCellData.index + 1]
	local insID = gridCellData.gameObject:GetInstanceID()

	data.insID = insID
	data.tableIndex = gridCellData.index

	local cell = self.equipCellList[insID]

	if cell == nil then
		cell = EquipListCell.New(gridCellData.gameObject, self)
		self.equipCellList[insID] = cell
	end

	cell:Refresh(data, data.tableIndex)

	cell.gameObject.name = data.id
	self.curEquipCellList[data.tableIndex] = cell
end

local FilterEnum = {
	Suit = 1,
	PartIndex = 2
}

function EquipWarehouseUI:OnSelectedFilterPanelGridCell(gridCellData)
	local data = self.SuitFilterItemList[gridCellData.index + 1]

	self.suitScreenSelectData = data

	self.Filter:SetFilter(FilterEnum.Suit, function(item)
		return item:GetEquipCfg().SuitId[1] == data.SuitID
	end)

	self.sortEquipDataList = self:FilterEquip(self.partEquipDataList)

	self:RefreshEquipWarehousePanel()
	self:ResetEquipFilterCellSelectedState()
	self.suitScreenCellList[gridCellData.gameObject:GetInstanceID()]:IsChooseItem(true)
end

function EquipWarehouseUI:OnRenderFilterPanelGridCell(gridCellData)
	local data = self.SuitFilterItemList[gridCellData.index + 1]
	local instanceID = gridCellData.gameObject:GetInstanceID()
	local cell = self.suitScreenCellList[instanceID]

	data.insID = instanceID

	if cell == nil then
		cell = SuitScreenCellView.New(gridCellData.gameObject)
		self.suitScreenCellList[instanceID] = cell
	end

	cell:Refresh(data, self.partEquipDataList)

	gridCellData.gameObject.name = gridCellData.index + 1
end

function EquipWarehouseUI:ResetEquipFilterCellSelectedState()
	for k, v in pairs(self.suitScreenCellList) do
		v:IsChooseItem(false)
	end
end

function EquipWarehouseUI:OnClickUnfilterButton()
	self.Filter:SetFilter(FilterEnum.Suit, function(item)
		return true
	end)

	self.sortEquipDataList = self:FilterEquip(self.partEquipDataList)

	self:RefreshEquipWarehousePanel()
end

function EquipWarehouseUI:ResetEquipItemSelectedState()
	for k, equipData in pairs(self.sortEquipDataList) do
		equipData.ItemCustomCount = 0
	end
end

function EquipWarehouseUI:OnSelectPartIndex(partIndex)
	if self.partIndex == partIndex then
		return
	end

	self.partIndex = partIndex

	EquipModule.CalculateCurrentSuitNumList(partIndex)
	self.screenControllerView.screenData:ChangeItemChoiceIDByValue(Constant.EquipScreenType.Part, partIndex, true)

	self.partEquipDataList = EquipModule.GetEquipListByScreenData(self.screenControllerView.screenData)
	self.sortEquipDataList = EquipModule.SortEquipListBySortType(self.partEquipDataList, self.screenControllerView.sortIndex, true)

	if self.SelectedEquipData then
		self.SelectedEquipData.ItemCustomCount = 0
	end

	local selectedEquipItemIndex = self:GetEquippedItemIndex(EquipModule.currentHeroCid)

	self.SelectedEquipData = self:GetEquipByIndex(selectedEquipItemIndex)

	if self.SelectedEquipData then
		self.SelectedEquipData.ItemCustomCount = 1
	end

	self.EquipHoleView:SetSelected(partIndex)
	self:DataChangeRefresh()
end

function EquipWarehouseUI:GetEquippedItemIndex(heroCid)
	for index, equipData in pairs(self.sortEquipDataList) do
		if equipData.heroCid == heroCid then
			return index
		end
	end

	return 1
end

function EquipWarehouseUI:OnClickSortingOrderButton()
	self.Sorter:SwitchSortingOrder()

	self.sortEquipDataList = self:FilterEquip(self.partEquipDataList)

	self:RefreshEquipWarehousePanel()
end

function EquipWarehouseUI:OnClickSortingTypeButton(index, isOn)
	self.Sorter:SetSortFunctionList(EquipModule.GetSortingFuncList(index).SortingFunc)

	self.sortEquipDataList = self:FilterEquip(self.partEquipDataList)

	self:RefreshEquipWarehousePanel()
end

function EquipWarehouseUI:OnClickReplaceButton()
	self.replacePanel:Show()
	self.replacePanel:Refresh(Constant.EquipReplacePanelType.Equip, WarlockModule.curWarlockData.cid, self.SelectedEquipData.heroCid, function()
		EquipModule.ReplaceEquip(WarlockModule.curWarlockData.cid, self.SelectedEquipData.id)
	end)
end

function EquipWarehouseUI:OnClickDischargeButton()
	EquipModule.UnloadEquip(WarlockModule.curWarlockData.cid, self.SelectedEquipData.id)
end

function EquipWarehouseUI:OnClickIntensifyButton()
	UIModule.Open(Constant.UIControllerName.EquipStrengthUI, Constant.UILayer.UI, {
		equipData = self.SelectedEquipData
	})
end

function EquipWarehouseUI:OnClickLockButton()
	EquipModule.LockEquip({
		self.SelectedEquipData.id
	})
end

function EquipWarehouseUI:OnClickContrastButton()
	self.IsShowContrastingPanel = not self.IsShowContrastingPanel

	self.ContrastButtonCommonState:SetActive(not self.IsShowContrastingPanel)
	self.ContrastButtonPackUpState:SetActive(self.IsShowContrastingPanel)

	local EquipDataArr = EquipModule.GetCurrentHeroEquipData()
	local curPartEquipData = EquipDataArr[self.partIndex]

	if self.IsShowContrastingPanel then
		self.equipContrastBaseInfoView:Refresh(curPartEquipData)
		self.equipContrastBaseInfoView:Show()
	else
		self.equipContrastBaseInfoView:Hide()
	end

	if curPartEquipData.id == self.SelectedEquipData.id then
		if self.IsShowContrastingPanel then
			self.equipDefaultBaseInfoView:Hide()
		else
			self.equipDefaultBaseInfoView:Show()
		end
	end
end

function EquipWarehouseUI:OnWearEquipSuccess()
	self:DataChangeRefresh(true)
end

function EquipWarehouseUI:OnUnloadEquipSucceed()
	self:DataChangeRefresh(true)
end

function EquipWarehouseUI:OnIntensifyEquipSucess()
	self:DataChangeRefresh(true)
end

function EquipWarehouseUI:OnLockEquipRefresh()
	for k, v in pairs(self.equipCellList) do
		local data = self.sortEquipDataList[v.tableIndex + 1]

		v:Refresh(data, v.tableIndex)
	end

	self:RefreshEquipWarehousePanel(true)
	self.equipDefaultBaseInfoView:RefreshLockIcon(self.SelectedEquipData.isLock)
	self:PlayQualityAnim(CfgItemTable[self.SelectedEquipData.cid].Quality)
end

function EquipWarehouseUI:DataChangeRefresh(selectRefresh)
	self:RefreshEquipWarehousePanel(selectRefresh)

	self.SuitFilterItemList = EquipModule.GetSuitConfigList(self.partEquipDataList)

	self:RefreshAttributePanel(self.SelectedEquipData, false)
	self:ResetContrastPanel()
	self.EquipHoleView:RefreshHolePanel()
	self:RefreshOperationPanel()
end

function EquipWarehouseUI:RefreshAttributePanel(data, isSelect)
	self:RefreshImage(data, isSelect)

	if data == nil then
		self.equipDefaultBaseInfoView:Hide()

		return
	end

	self.equipDefaultBaseInfoView:Refresh(data)
	self.equipDefaultBaseInfoView:Show()

	local EquipDataArr = EquipModule.GetCurrentHeroEquipData()
	local curPartEquipData = EquipDataArr[self.partIndex]

	if curPartEquipData ~= nil then
		self.equipContrastBaseInfoView:Refresh(curPartEquipData)

		if self.IsShowContrastingPanel and curPartEquipData.id == data.id then
			self.equipDefaultBaseInfoView:Hide()
		end
	end
end

function EquipWarehouseUI:RefreshImage(equipData, isSelect)
	if equipData == nil then
		LuaUtility.SetGameObjectShow(self.EquipImgParent, false)
		LuaUtility.SetGameObjectShow(self.emptyInfoRoot, true)
		LuaUtility.SetText(self.textEmptyPartName, EquipApi:GetPartName(self.partIndex))
		LuaUtility.SetText(self.emptyTextPart, EquipApi:GetPartName(self.partIndex))

		return
	end

	LuaUtility.SetGameObjectShow(self.EquipImgParent, true)
	LuaUtility.SetGameObjectShow(self.emptyInfoRoot, false)

	local cfgEquip = equipData:GetEquipCfg()

	AssetUtil.LoadImage(self, EquipApi:GetEquipBigIconPath(equipData.cid), self.EquipImage:GetComponent("Image"))
	AssetUtil.LoadImage(self, EquipApi:GetEquipAttrQualityImagePath(self.partIndex, cfgEquip.Quality), self.QualityImage:GetComponent("Image"))
	AssetUtil.LoadImage(self, EquipApi:GetEquipQualityBgPath(self.partIndex), self.imageQualityBg:GetComponent("Image"))
	LuaUtility.SetText(self.textPartName, EquipApi:GetPartName(cfgEquip.Place))
	LuaUtility.SetText(self.EquipLevelNumText, "+ " .. equipData.lv)
	self:PlayQualityAnim(CfgItemTable[equipData.cid].Quality)
end

function EquipWarehouseUI:ResetContrastPanel()
	self.IsShowContrastingPanel = false

	self.ContrastButtonCommonState:SetActive(not self.IsShowContrastingPanel)
	self.ContrastButtonPackUpState:SetActive(self.IsShowContrastingPanel)
	self.equipContrastBaseInfoView:Hide()
end

function EquipWarehouseUI:RefreshOperationPanel()
	self.ChargeButton:SetActive(self.SelectedEquipData and self.SelectedEquipData.heroCid == 0)
	self.DischargeButton:SetActive(self.SelectedEquipData and self.SelectedEquipData.heroCid ~= 0 and self.SelectedEquipData.heroCid == EquipModule.currentHeroCid)
	self.ReplaceButton:SetActive(self.SelectedEquipData and self.SelectedEquipData.heroCid ~= 0 and self.SelectedEquipData.heroCid ~= EquipModule.currentHeroCid)

	local EquipDataArr = EquipModule.GetCurrentHeroEquipData()

	self.ContrastButton:SetActive(EquipDataArr[self.partIndex] ~= nil and self.SelectedEquipData ~= nil and self.SelectedEquipData.id ~= EquipDataArr[self.partIndex].id)
	self.IntensityButton:SetActive(self.SelectedEquipData ~= nil)
end

function EquipWarehouseUI:PlayQualityAnim(quality)
	if self.effectID ~= nil then
		GameEntry.Effect:StopEffect(self.effectID)
	end

	local effectId = EquipApi:GetShowEffect(quality)

	if effectId == nil then
		logError("装备品质不正确:" .. quality .. " 无法找到该品质的特效!")

		return
	end

	self.effectID = GameEntry.Effect:PlayUIMountPointEffect(EquipApi:GetShowEffect(quality), 50000, 0, self.EffectParent, 0)
end

function EquipWarehouseUI:GetPreloadAssetPaths()
	return nil
end

function EquipWarehouseUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EquipWarehouseUI:IsManualShowOnOpen(userData)
	return false
end

function EquipWarehouseUI:GetBGM(userData)
	return nil
end

function EquipWarehouseUI:OnPause()
	return
end

function EquipWarehouseUI:OnResume()
	return
end

function EquipWarehouseUI:OnCover()
	return
end

function EquipWarehouseUI:OnReveal()
	self:OnOpen(self.partIndex or Constant.Equip.Part.Chu)
end

function EquipWarehouseUI:OnRefocus(userData)
	return
end

function EquipWarehouseUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EquipWarehouseUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EquipWarehouseUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EquipWarehouseUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EquipWarehouseUI:__OnEquipFilterSortCallback(isSortChange)
	if not isSortChange then
		self.partEquipDataList = EquipModule.GetEquipListByScreenData(self.screenControllerView.screenData)
	end

	self.sortEquipDataList = EquipModule.SortEquipListBySortType(self.partEquipDataList, self.screenControllerView.sortIndex, self.screenControllerView.ascending)

	self:RefreshEquipWarehousePanel()
end

return EquipWarehouseUI
