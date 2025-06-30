-- chunkname: @IQIGame\\UI\\Equip\\EquipHoleView.lua

local EquipHoleView = {
	baseAttributeCellList = {}
}
local EquipCellView = require("IQIGame.UI.Equip.EquipCellView")

function EquipHoleView.New(go, partToggleFunc, mainView)
	local o = Clone(EquipHoleView)

	o:Initialize(go, partToggleFunc, mainView)

	return o
end

function EquipHoleView:Initialize(go, partToggleFunc, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitEquipPartItem(partToggleFunc)

	function self.delegateOnEquipChangeSuccess()
		self:RefreshHolePanel()
	end

	self:OnAddListeners()
end

function EquipHoleView:InitEquipPartItem(partToggleFunc)
	local partObjectMap = {
		[Constant.Equip.Part.Chu] = self.Chu,
		[Constant.Equip.Part.Mian] = self.Mian,
		[Constant.Equip.Part.Tong] = self.Tong,
		[Constant.Equip.Part.Xing] = self.Xing,
		[Constant.Equip.Part.Gu] = self.Gu,
		[Constant.Equip.Part.Hun] = self.Hun
	}

	self.equipCellTable = {}

	local partSortTable = CfgDiscreteDataTable[54].Data

	for i = 1, #partSortTable do
		local partIndex = partSortTable[i]
		local itemCellObj = partObjectMap[partIndex]
		local equipPartItem = EquipCellView.New(itemCellObj, partIndex, partToggleFunc[partIndex], self.mainView)

		equipPartItem:SetSelectState(false)
		equipPartItem:SetPartName(partIndex)

		self.equipCellTable[partIndex] = equipPartItem
	end
end

function EquipHoleView:OnAddListeners()
	EventDispatcher.AddEventListener(EventID.WearEquipSucceedNew, self.delegateOnEquipChangeSuccess)
	EventDispatcher.AddEventListener(EventID.UnloadEquipSucceedNew, self.delegateOnEquipChangeSuccess)
	EventDispatcher.AddEventListener(EventID.UpgradeEquipSucceedNew, self.delegateOnEquipChangeSuccess)
end

function EquipHoleView:OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.WearEquipSucceedNew, self.delegateOnEquipChangeSuccess)
	EventDispatcher.RemoveEventListener(EventID.UnloadEquipSucceedNew, self.delegateOnEquipChangeSuccess)
	EventDispatcher.RemoveEventListener(EventID.UpgradeEquipSucceedNew, self.delegateOnEquipChangeSuccess)
end

function EquipHoleView:Show()
	self:RefreshHolePanel()
	self.gameObject:SetActive(true)
end

function EquipHoleView:Hide()
	self.gameObject:SetActive(false)
end

function EquipHoleView:RefreshHolePanel()
	local EquipDataArr = EquipModule.GetCurrentHeroEquipData()

	for partIndex = 1, #self.equipCellTable do
		self.equipCellTable[partIndex]:RefreshData(EquipDataArr[partIndex])
	end
end

function EquipHoleView:SetSelected(partIndex)
	for _, v in pairs(self.equipCellTable) do
		v:SetSelectState(false)
	end

	self.equipCellTable[partIndex]:SetSelectState(true)
end

function EquipHoleView:OnDestroy()
	for i, equipCellView in pairs(self.equipCellTable) do
		equipCellView:OnDestroy()
	end

	self:OnRemoveListeners()
end

return EquipHoleView
