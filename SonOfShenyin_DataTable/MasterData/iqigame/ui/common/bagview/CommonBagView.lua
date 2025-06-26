-- chunkname: @IQIGame\\UI\\Common\\BagView\\CommonBagView.lua

local BagView = {
	enableChangeSelectStateCall = true,
	itemDataList = {},
	itemCellList = {}
}

function BagView.New(view, itemCellClass)
	local obj = Clone(BagView)

	obj:__Init(view, itemCellClass)

	return obj
end

function BagView:__Init(view, itemCellClass)
	self.gameObject = view
	self.ItemCellClass = itemCellClass

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:__OnInitEventDelegate()

	self.scrollAreaList = self.scrollAreaListRoot:GetComponent("ScrollAreaList")

	function self.scrollAreaList.onRenderCell(cell)
		self:__OnRenderItemCell(cell)
	end

	function self.scrollAreaList.onSelectedCell(cell)
		self:__OnItemCellSelect(cell)
	end

	self:__OnInit()
	self:__AddListener()
end

function BagView:__OnInit()
	return
end

function BagView:__OnInitEventDelegate()
	function self.__OnCloseBtnClickEventProxy()
		self:Hide()
	end
end

function BagView:__AddListener()
	if self.closeBtn ~= nil then
		self.closeBtn:GetComponent("Button").onClick:AddListener(self.__OnCloseBtnClickEventProxy)
	end
end

function BagView:__RemoveListener()
	if self.closeBtn ~= nil then
		self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.__OnCloseBtnClickEventProxy)
	end
end

function BagView:__OnRenderItemCell(cell)
	local insID = cell.gameObject:GetInstanceID()
	local itemCell = self.itemCellList[insID]

	if itemCell == nil then
		itemCell = self.ItemCellClass.New(cell.gameObject, self.ItemCellClass)
		self.itemCellList[insID] = itemCell
	end

	local dataIndex = cell.index + 1

	self:__OnFileItemCellData(dataIndex, itemCell)
end

function BagView:__OnFileItemCellData(index, itemCell)
	local itemData = self.itemDataList[index]

	itemCell:Show(itemData)
end

function BagView:__OnItemCellSelect(cell)
	local insID = cell.gameObject:GetInstanceID()

	if self.enableChangeSelectStateCall then
		ForPairs(self.itemCellList, function(_insID, _item)
			local isSelect = _insID == insID

			_item:ChangeSelectState(isSelect)
		end)
	end

	if self.ItemSelectEvent == nil then
		return
	end

	local itemData = self.itemDataList[cell.index + 1]

	self.ItemSelectEvent(itemData)
end

function BagView:__OnShow(itemDataList)
	self.gameObject:SetActive(true)

	self.itemDataList = itemDataList

	self.scrollAreaList:Refresh(#self.itemDataList)
end

function BagView:Hide()
	self.gameObject:SetActive(false)
end

function BagView:Dispose()
	self:__RemoveListener()

	self.scrollAreaList = nil

	ForPairs(self.itemCellList, function(_insID, _itemCell)
		_itemCell:Dispose()
	end)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return BagView
