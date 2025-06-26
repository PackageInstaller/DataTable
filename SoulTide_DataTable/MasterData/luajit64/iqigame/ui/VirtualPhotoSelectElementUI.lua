-- chunkname: @IQIGame\\UI\\VirtualPhotoSelectElementUI.lua

require("IQIGame.UIExternalApi.VirtualPhotoSelectElementUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local VirtualPhotoElementCell = require("IQIGame.UI.VirtualPhoto.VirtualPhotoElementCell")
local ShowEntityData = {}
local VirtualPhotoSelectElementUI = {
	SelectedToggleIndex = 0,
	SelectedCid = 0,
	ToggleGos = {},
	ElementCellMap = {},
	CellShowEntityQueue = {}
}

VirtualPhotoSelectElementUI = Base:Extend("VirtualPhotoSelectElementUI", "IQIGame.Onigao.UI.VirtualPhotoSelectElementUI", VirtualPhotoSelectElementUI)

function VirtualPhotoSelectElementUI:OnInit()
	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateOnClickCloseBtn2()
		self:OnClickCloseBtn2()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateLoadSpineRequestFunc(cell, showEntityFunc, isCancel)
		self:LoadSpineRequestFunc(cell, showEntityFunc, isCancel)
	end

	function self.DelegateOnSpineLoaded()
		self:OnSpineLoaded()
	end

	local scrollAreaList = self.ScrollAreaList:GetComponent(typeof(Components.UI.Scroll.ScrollAreaList))

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function scrollAreaList.onSelectedCell(cell)
		self:OnSelectCell(cell)
	end

	self.TogglePool = UIObjectPool.New(5, function()
		return UnityEngine.Object.Instantiate(self.TogglePrefab)
	end, function(toggleGO)
		UnityEngine.Object.Destroy(toggleGO)
	end)

	UGUIUtil.SetText(self.TitleText, VirtualPhotoSelectElementUIApi:GetString("TitleText"))
	UGUIUtil.SetTextInChildren(self.ConfirmBtn, VirtualPhotoSelectElementUIApi:GetString("ConfirmBtnText"))
end

function VirtualPhotoSelectElementUI:GetPreloadAssetPaths()
	return nil
end

function VirtualPhotoSelectElementUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function VirtualPhotoSelectElementUI:IsManualShowOnOpen(userData)
	return false
end

function VirtualPhotoSelectElementUI:GetBGM(userData)
	return nil
end

function VirtualPhotoSelectElementUI:OnOpen(userData)
	self.OnConfirmCallback = userData.callback

	self:UpdateView()
end

function VirtualPhotoSelectElementUI:OnClose(userData)
	for instanceId, elementCell in pairs(self.ElementCellMap) do
		elementCell:HideEntity()
	end
end

function VirtualPhotoSelectElementUI:OnAddListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.CloseBtn2:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn2)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function VirtualPhotoSelectElementUI:OnRemoveListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.CloseBtn2:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn2)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function VirtualPhotoSelectElementUI:OnPause()
	return
end

function VirtualPhotoSelectElementUI:OnResume()
	return
end

function VirtualPhotoSelectElementUI:OnCover()
	return
end

function VirtualPhotoSelectElementUI:OnReveal()
	return
end

function VirtualPhotoSelectElementUI:OnRefocus(userData)
	return
end

function VirtualPhotoSelectElementUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if #self.CellShowEntityQueue > 0 then
		local data = table.remove(self.CellShowEntityQueue, 1)

		data.showEntity(data.cell)
	end
end

function VirtualPhotoSelectElementUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function VirtualPhotoSelectElementUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function VirtualPhotoSelectElementUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function VirtualPhotoSelectElementUI:OnDestroy()
	self:ClearToggles()
	self.TogglePool:Dispose()

	for instanceId, elementCell in pairs(self.ElementCellMap) do
		elementCell:Dispose()
	end
end

function VirtualPhotoSelectElementUI:OnClickConfirmBtn()
	UIModule.CloseSelf(self)
	self.OnConfirmCallback(self.SelectedCid)
end

function VirtualPhotoSelectElementUI:OnClickCloseBtn2()
	UIModule.CloseSelf(self)
end

function VirtualPhotoSelectElementUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function VirtualPhotoSelectElementUI:UpdateView()
	self.ElementDataMap = {}

	for id, cfgVirtualPhotoElementData in pairsCfg(CfgVirtualPhotoElementTable) do
		self.ElementDataMap[cfgVirtualPhotoElementData.Type] = self.ElementDataMap[cfgVirtualPhotoElementData.Type] or {}

		table.insert(self.ElementDataMap[cfgVirtualPhotoElementData.Type], cfgVirtualPhotoElementData)
	end

	self.TypeList = {}

	for type, cfgDataList in pairs(self.ElementDataMap) do
		table.insert(self.TypeList, type)
		table.sort(cfgDataList, function(cfgData1, cfgData2)
			return cfgData1.Id < cfgData2.Id
		end)
	end

	table.sort(self.TypeList, function(element1, element2)
		return element1 < element2
	end)
	self:ClearToggles()

	for i = 1, #self.TypeList do
		local toggleGo = self.TogglePool:Obtain()

		toggleGo.transform:SetParent(self.ToggleGrid.transform, false)
		toggleGo:SetActive(true)

		local type = self.TypeList[i]
		local toggleHelper = toggleGo:GetComponent("ToggleHelperComponent")

		toggleHelper.text = VirtualPhotoSelectElementUIApi:GetString("ElementTypeName", type)

		table.insert(self.ToggleGos, toggleGo)
	end

	local defaultToggleIndex = 1
	local defaultToggleGO = self.ToggleGos[defaultToggleIndex]

	defaultToggleGO:GetComponent("Toggle").isOn = true

	for i = 1, #self.ToggleGos do
		local toggleGo = self.ToggleGos[i]

		self["DelegateOnToggleValueChanged" .. i] = function(isOn)
			self:OnToggleValueChanged(isOn, i)
		end

		toggleGo:GetComponent("Toggle").onValueChanged:AddListener(self["DelegateOnToggleValueChanged" .. i])
	end

	self:OnSelectToggle(defaultToggleIndex)
end

function VirtualPhotoSelectElementUI:OnRenderCell(cell)
	local elementCell = self.ElementCellMap[cell.gameObject:GetInstanceID()]

	if elementCell == nil then
		elementCell = VirtualPhotoElementCell.New(cell.gameObject, self.UIController:GetComponent("Canvas"), self.DelegateLoadSpineRequestFunc, self.DelegateOnSpineLoaded)
		self.ElementCellMap[cell.gameObject:GetInstanceID()] = elementCell
	end

	local type = self.TypeList[self.SelectedToggleIndex]
	local cfgDataList = self.ElementDataMap[type]

	elementCell:SetData(cfgDataList[cell.index + 1])
end

function VirtualPhotoSelectElementUI:OnSelectCell(cell)
	local elementCell = self.ElementCellMap[cell.gameObject:GetInstanceID()]

	self.SelectedCid = elementCell.CfgVirtualPhotoElementData.Id
end

function VirtualPhotoSelectElementUI:ClearToggles()
	for i = 1, #self.ToggleGos do
		local toggleGO = self.ToggleGos[i]

		toggleGO:GetComponent("Toggle").onValueChanged:RemoveListener(self["DelegateOnToggleValueChanged" .. i])

		toggleGO:GetComponent("Toggle").isOn = false

		toggleGO:SetActive(false)
		toggleGO.transform:SetParent(self.UIController.transform, false)
		self.TogglePool:Release(toggleGO)
	end

	self.ToggleGos = {}
end

function VirtualPhotoSelectElementUI:OnSelectToggle(toggleIndex)
	if self.SelectedToggleIndex == toggleIndex then
		return
	end

	self.SelectedToggleIndex = toggleIndex

	local type = self.TypeList[toggleIndex]
	local cfgDataList = self.ElementDataMap[type]
	local scrollAreaList = self.ScrollAreaList:GetComponent(typeof(Components.UI.Scroll.ScrollAreaList))

	scrollAreaList.defaultSelectedToggle = 0

	scrollAreaList:Refresh(#cfgDataList)
end

function VirtualPhotoSelectElementUI:OnToggleValueChanged(isOn, index)
	if isOn then
		self:OnSelectToggle(index)
	end
end

function VirtualPhotoSelectElementUI:OnSpineLoaded()
	local mask = self.SpineMask:GetComponent(typeof(ToJ.Mask))

	mask:SetNodeDirty()
	mask:SetParamDirty()
end

function VirtualPhotoSelectElementUI:LoadSpineRequestFunc(cell, showEntityFunc, isCancel)
	if isCancel then
		local index = -1

		for i = 1, #self.CellShowEntityQueue do
			local data = self.CellShowEntityQueue[i]

			if data.cell == cell then
				index = i

				break
			end
		end

		if index ~= -1 then
			table.remove(self.CellShowEntityQueue, index)
		end
	else
		local data = {}

		data.cell = cell
		data.showEntity = showEntityFunc

		table.insert(self.CellShowEntityQueue, data)
	end
end

return VirtualPhotoSelectElementUI
