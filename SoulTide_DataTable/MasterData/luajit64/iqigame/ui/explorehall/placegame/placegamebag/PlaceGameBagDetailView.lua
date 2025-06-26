-- chunkname: @IQIGame\\UI\\ExploreHall\\PlaceGame\\PlaceGameBag\\PlaceGameBagDetailView.lua

local m = {
	isLockMode = false,
	haveSelectItemData = false,
	isRecoveryMode = false,
	itemDataList = {},
	bagItemCells = {},
	selectQuality = {}
}
local PlaceGameEquipDetailView = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGameFormationChooseEquip.PlaceGameEquipDetailView")
local PlaceGameBagItemCell = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGameBag.PlaceGameBagItemCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickSelectedEquipBtn()
		self:OnClickSelectedEquipBtn()
	end

	self.ScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderEquipCell(cell)
	end
	self.ScrollArea:GetComponent("ScrollAreaList").onSelectedCell = function(cell)
		self:OnClickEquipCell(cell)
	end
	self.selectedEquipController = PlaceGameEquipDetailView.New(self.SelectedEquipTipCell)

	self.SelectedEquipBtn:SetActive(false)
	self:AddListener()
end

function m:AddListener()
	self.SelectedEquipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSelectedEquipBtn)
end

function m:RemoveListener()
	self.SelectedEquipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSelectedEquipBtn)
end

function m:OnClickSelectedEquipBtn()
	return
end

function m:RefreshBagMode(isLockMode, isRecoveryMode)
	self.isLockMode = isLockMode
	self.isRecoveryMode = isRecoveryMode

	self:UpdateView()
end

function m:RefreshSelectRecovery(quality)
	self.selectQuality = quality

	self:UpdateView()
end

function m:UpdateView()
	local items = WarehouseModule.GetItemsByType(Constant.ItemType.PlaceGameEquip, false)

	self.itemDataList = PlaceGameModule.PlaceGameEquipSort(items)

	for i, v in pairs(self.itemDataList) do
		v.placeGameEquipData.selectRecovery = false

		if self.isRecoveryMode then
			local canRecover = self:CheckEquipRecovery(v, false)
			local isInQuality = table.indexOf(self.selectQuality, v:GetCfg().Quality) ~= -1

			if canRecover and isInQuality then
				v.placeGameEquipData.selectRecovery = true
			end
		end
	end

	self.haveSelectItemData = false

	self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.itemDataList)
	self.Empty:SetActive(#self.itemDataList == 0)
	self.TextItemNum:SetActive(#self.itemDataList > 0)
	UGUIUtil.SetText(self.TextItemNum, PlaceGameBagUIApi:GetString("TextItemNum", #self.itemDataList, CfgPlaceGameControlTable[PlaceGameModule.GlobalCid].EquipMaxNum))

	if #self.itemDataList == 0 or self.haveSelectItemData == false then
		self.selectItemData = nil
	end

	self:ShowSelectItemTip()
end

function m:OnRenderEquipCell(cell)
	local itemData = self.itemDataList[cell.index + 1]
	local equipCell = self.bagItemCells[cell.gameObject:GetInstanceID()]

	if equipCell == nil then
		equipCell = PlaceGameBagItemCell.New(cell.gameObject)
		equipCell.View.name = "Cell_" .. cell.index + 1
		self.bagItemCells[cell.gameObject:GetInstanceID()] = equipCell
	end

	equipCell:SetData(itemData, self.isLockMode)

	if self.selectItemData and self.selectItemData.id == itemData.id then
		equipCell:SetSelect(true)

		self.haveSelectItemData = true
	else
		equipCell:SetSelect(false)
	end
end

function m:OnClickEquipCell(cell)
	local equipCell = self.bagItemCells[cell.gameObject:GetInstanceID()]

	self.selectItemData = self.itemDataList[cell.index + 1]

	for i, v in pairs(self.bagItemCells) do
		v:SetSelect(v.itemData.id == self.selectItemData.id)
	end

	if self.isLockMode then
		equipCell.itemData.placeGameEquipData.placeGameEquipPOD.lock = not equipCell.itemData.placeGameEquipData.placeGameEquipPOD.lock

		equipCell:SetData(equipCell.itemData, self.isLockMode)

		if equipCell.itemData.placeGameEquipData.placeGameEquipPOD.lock then
			NoticeModule.ShowNotice(21040109)
			PlaceGameModule.EquipmentLock(equipCell.itemData.id, true)
		else
			NoticeModule.ShowNotice(21040111)
			PlaceGameModule.EquipmentLock(equipCell.itemData.id, false)
		end

		equipCell:SetSelect(false)

		self.selectItemData = nil
	end

	if self.isRecoveryMode then
		local canRecover = self:CheckEquipRecovery(equipCell.itemData, true)

		if canRecover then
			equipCell.itemData.placeGameEquipData.selectRecovery = not equipCell.itemData.placeGameEquipData.selectRecovery

			equipCell:SetData(equipCell.itemData, self.isLockMode)
		end

		equipCell:SetSelect(false)

		self.selectItemData = nil
	end

	self:ShowSelectItemTip()
end

function m:CheckEquipRecovery(itemData, top)
	if itemData == nil then
		return false
	end

	if itemData.id == 0 then
		return false
	end

	local isPutOn, placeGameSoulCid = itemData.placeGameEquipData:IsWearingState()

	if isPutOn then
		if top then
			NoticeModule.ShowNoticeNoCallback(21053002)
		end

		return false
	elseif itemData.placeGameEquipData.placeGameEquipPOD.lock then
		if top then
			NoticeModule.ShowNoticeNoCallback(21045106)
		end

		return false
	end

	return true
end

function m:ShowSelectItemTip()
	self.SelectedEquipTipCell:SetActive(self.selectItemData ~= nil)

	if self.selectItemData then
		local isPutOn, placeGameSoulCid = self.selectItemData.placeGameEquipData:IsWearingState()
		local soulCid = 0

		if placeGameSoulCid > 0 then
			soulCid = CfgPlaceGameSoulTable[placeGameSoulCid].SoulID
		end

		self.selectedEquipController:Refresh(self.selectItemData, nil, soulCid)
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	self.selectedEquipController:Dispose()

	for i, v in pairs(self.bagItemCells) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
