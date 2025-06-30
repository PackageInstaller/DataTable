-- chunkname: @IQIGame\\UI\\FormationUI\\FormationEquipCard.lua

local m = {
	Index = 0,
	Selected = false
}

function m.New(view, index, onClick, onLongClick)
	local obj = Clone(m)

	obj:Init(view, index, onClick, onLongClick)

	return obj
end

function m:Init(view, index, onClick, onLongClick)
	self.View = view
	self.Index = index
	self.OnClickCallback = onClick
	self.OnLongClickCallback = onLongClick

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickSelf()
		self:OnClickSelf()
	end

	function self.DelegateOnLongClickSelf()
		self:OnLongClickSelf()
	end

	function self.DelegateOnUpdateItem(itemDataList)
		self:OnUpdateItem(itemDataList)
	end

	self.EquipCell = EquipCell.New(self.EquipCellGo)
	self.EquipCell.enableClick = false

	self:SetSelected(false)

	self.View:GetComponent("LongButton").repeatCall = false

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("LongButton").onClick:AddListener(self.DelegateOnClickSelf)
	self.View:GetComponent("LongButton").onLongDownClick:AddListener(self.DelegateOnLongClickSelf)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
end

function m:RemoveListeners()
	self.View:GetComponent("LongButton").onClick:RemoveListener(self.DelegateOnClickSelf)
	self.View:GetComponent("LongButton").onLongDownClick:RemoveListener(self.DelegateOnLongClickSelf)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
end

function m:SetData(itemData)
	self.EquipCell:Refresh(itemData, nil, true)
	self.EmptyView:SetActive(itemData == nil)
	self.EquipCardView:SetActive(itemData ~= nil)

	if self.RedPoint ~= nil then
		local itemDataList = MazeDataModule.GetEquipListByPosition(self.Index)

		self.RedPoint:SetActive(itemData == nil and #itemDataList > 0)
	end
end

function m:SetSelected(value)
	self.Selected = value

	self.CheckMark:SetActive(value)
end

function m:OnClickSelf()
	if self.OnClickCallback ~= nil then
		self.OnClickCallback(self)
	end
end

function m:OnLongClickSelf()
	if self.OnLongClickCallback ~= nil then
		self.OnLongClickCallback(self)
	end
end

function m:OnUpdateItem(itemDataList)
	if self.EquipCell.itemData == nil then
		return
	end

	for i = 1, #itemDataList do
		local itemData = itemDataList[i]

		if itemData.id == self.EquipCell.itemData.id then
			self:SetData(itemData)

			break
		end
	end
end

function m:SetIsQuickMode(value)
	self.CheckMark.transform:GetChild(0).gameObject:SetActive(not value)
end

function m:Dispose()
	self:RemoveListeners()
	self.EquipCell:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.OnClickCallback = nil
	self.OnLongClickCallback = nil
end

return m
