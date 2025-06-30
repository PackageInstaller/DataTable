-- chunkname: @IQIGame\\UI\\Common\\Decompose\\DecomposeContent.lua

local m = {
	itemList = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.itemScrollView = self.ItemScroll:GetComponent("ScrollAreaList")

	function self.itemScrollView.onRenderCell(cell)
		self:__OnRenderItemCell(cell)
	end

	function self.__delegateOnClickDecomposeBtn()
		self:__OnClickDecomposeBtn()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.DecomposeBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnClickDecomposeBtn)
end

function m:RemoveListeners()
	self.DecomposeBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnClickDecomposeBtn)
end

function m:SetData(decomposeItemIdList)
	self.decomposeItemIdList = decomposeItemIdList
	self.reuslt = WarehouseModule.GetDecomposeReward(Constant.ItemType.Skill, self.decomposeItemIdList)

	self.itemScrollView:Refresh(#self.reuslt)

	self.isCanDecompose = table.len(self.decomposeItemIdList) > 0

	self:__SetDecomposeBtnState()
end

function m:__OnRenderItemCell(cell)
	local itemData = self.reuslt[cell.index + 1]
	local insID = cell.gameObject:GetInstanceID()
	local itemCell = self.itemList[insID]

	if itemCell == nil then
		itemCell = ItemCell.New(cell.gameObject, true, true, true)
		self.itemList[insID] = itemCell
	end

	itemCell:SetItemByCid(itemData.cid)
	itemCell:SetNum(itemData.count)
end

function m:__OnClickDecomposeBtn()
	if not self.isCanDecompose then
		return
	end

	ItemModule.DecomposeItem(self.decomposeItemIdList)
end

function m:__SetDecomposeBtnState()
	self.DecomposeBtn:GetComponent("GrayComponent"):SetGray(not self.isCanDecompose)
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()

	self.itemScrollView = nil

	ForPairs(self.itemList, function(_, _itemCell)
		_itemCell:Dispose()
	end)

	self.itemList = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
