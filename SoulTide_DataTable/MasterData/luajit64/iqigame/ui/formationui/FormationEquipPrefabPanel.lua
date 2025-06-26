-- chunkname: @IQIGame\\UI\\FormationUI\\FormationEquipPrefabPanel.lua

local m = {
	IsShow = false,
	EquipPrefabItems = {}
}
local FormationEquipPrefabItem = require("IQIGame.UI.FormationUI.FormationEquipPrefabItem")

function m.New(view, onHide)
	local obj = Clone(m)

	obj:Init(view, onHide)

	return obj
end

function m:Init(view, onHide)
	self.View = view
	self.OnHideCallback = onHide

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickUseBtn()
		self:OnClickUseBtn()
	end

	function self.DelegateOnClickCoverBtn()
		self:OnClickCoverBtn()
	end

	function self.DelegateOnEquipPrefabUpdate(pod)
		self:OnEquipPrefabUpdate(pod)
	end

	function self.DelegateOnSoulPrefabUpdate()
		self:OnSoulPrefabUpdate()
	end

	local scrollAreaList = self.PrefabGrid:GetComponent("ScrollAreaList")

	function scrollAreaList.onSelectedCell(cell)
		self:OnClickPrefabItem(cell)
	end

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderPrefabItem(cell)
	end

	UGUIUtil.SetTextInChildren(self.UseBtn, FormationChooseEquipUIApi:GetString("UsePrefabBtnText"))
	UGUIUtil.SetTextInChildren(self.CoverBtn, FormationChooseEquipUIApi:GetString("CoverBtnPrefabBtnText"))
end

function m:Show(soulPrefabData)
	self.SoulPrefabData = soulPrefabData
	self.IsShow = true

	self.View:SetActive(true)

	self.PrefabDataList = {}

	for i = 1, #PlayerModule.PlayerInfo.equipmentPrefabs do
		local prefab = PlayerModule.PlayerInfo.equipmentPrefabs[i]

		if prefab.soulCid == self.SoulPrefabData.soulCid then
			table.insert(self.PrefabDataList, prefab)
		end
	end

	table.sort(self.PrefabDataList, function(prefab1, prefab2)
		return prefab1.idx < prefab2.idx
	end)

	local scrollAreaList = self.PrefabGrid:GetComponent("ScrollAreaList")

	scrollAreaList.defaultSelectedToggle = 0

	scrollAreaList:Refresh(#self.PrefabDataList)
	UGUIUtil.SetText(self.CloseBtn2, FormationChooseEquipUIApi:GetString("CloseBtn2Text"))
	self:AddListeners()
end

function m:Hide()
	self.IsShow = false

	self.View:SetActive(false)
	self:RemoveListeners()

	self.SoulPrefabData = nil
	self.SelectedPrefabItem = nil

	self.OnHideCallback()
end

function m:AddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn2:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.UseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickUseBtn)
	self.CoverBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCoverBtn)
	EventDispatcher.AddEventListener(EventID.EquipPrefabChanged, self.DelegateOnEquipPrefabUpdate)
	EventDispatcher.AddEventListener(EventID.SoulPrefabUpdate, self.DelegateOnSoulPrefabUpdate)
end

function m:RemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn2:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.UseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickUseBtn)
	self.CoverBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCoverBtn)
	EventDispatcher.RemoveEventListener(EventID.EquipPrefabChanged, self.DelegateOnEquipPrefabUpdate)
	EventDispatcher.RemoveEventListener(EventID.SoulPrefabUpdate, self.DelegateOnSoulPrefabUpdate)
end

function m:OnClickCloseBtn()
	self:Hide()
end

function m:OnClickPrefabItem(cell)
	local item = self.EquipPrefabItems[cell.gameObject]

	self.SelectedPrefabItem = item
end

function m:OnRenderPrefabItem(cell)
	local item = self.EquipPrefabItems[cell.gameObject]

	if item == nil then
		item = FormationEquipPrefabItem.New(cell.gameObject)
		self.EquipPrefabItems[cell.gameObject] = item
	end

	item:SetData(self.PrefabDataList[cell.index + 1], cell.index + 1, self.SoulPrefabData)
end

function m:OnClickUseBtn()
	if self.SelectedPrefabItem == nil then
		return
	end

	local isOnOtherPrefabInOneTeam = false
	local equipHostPrefabId
	local hasEquip = false

	for index, id in pairs(self.SelectedPrefabItem.EquipmentPrefabPOD.equipmentMap) do
		hasEquip = true

		local itemData = WarehouseModule.GetItemDataById(id)

		isOnOtherPrefabInOneTeam, equipHostPrefabId = FormationModule.CheckEquipIsOnBySamplePrefab(itemData, self.SoulPrefabData.id, self.SoulPrefabData.id)

		if isOnOtherPrefabInOneTeam then
			break
		end
	end

	if hasEquip then
		local noticeCid = 21053014

		if isOnOtherPrefabInOneTeam then
			noticeCid = 21053008
		end

		NoticeModule.ShowNotice(noticeCid, function()
			EquipModule.ReqCoverEquipments(self.SoulPrefabData.id, self.SelectedPrefabItem.EquipmentPrefabPOD.equipmentMap)
		end, nil)
	else
		NoticeModule.ShowNotice(21046010)
	end
end

function m:OnClickCoverBtn()
	if self.SelectedPrefabItem == nil then
		return
	end

	local equipmentMap = {}
	local hasEquip = false

	for i, itemData in pairs(self.SoulPrefabData.equipItemDatum) do
		equipmentMap[i] = itemData.id
		hasEquip = true
	end

	if hasEquip then
		NoticeModule.ShowNotice(21053011, function()
			EquipModule.ReqSaveEquipmentPrefab(equipmentMap, self.SelectedPrefabItem.EquipmentPrefabPOD.id)
		end, nil)
	else
		NoticeModule.ShowNotice(21046011)
	end
end

function m:OnSoulPrefabUpdate()
	for gameObject, item in pairs(self.EquipPrefabItems) do
		item:OnSoulPrefabUpdate()
	end
end

function m:OnEquipPrefabUpdate(pod)
	for gameObject, item in pairs(self.EquipPrefabItems) do
		item:OnEquipPrefabUpdate(pod)
	end
end

function m:Dispose()
	if self.IsShow then
		self:Hide()
	end

	for gameObject, item in pairs(self.EquipPrefabItems) do
		item:Dispose()
	end

	self.EquipPrefabItems = nil
	self.OnHideCallback = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
