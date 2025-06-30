-- chunkname: @IQIGame\\UI\\Chapter\\BossChapter\\BossRewardItem.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ItemCell = ItemCell.New(self.Common_Slot, true, true)

	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(data)
	local itemData = ItemData.CreateByCIDAndNumber(data.id, data.num)

	self.ItemCell:SetItem(itemData)
	self.ItemCell:SetTag(data.tag)

	if data.num > 0 then
		self.ItemCell:SetNum(data.num)
	end
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
