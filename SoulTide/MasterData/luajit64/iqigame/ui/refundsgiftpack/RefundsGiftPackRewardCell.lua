-- chunkname: @IQIGame\\UI\\RefundsGiftPack\\RefundsGiftPackRewardCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ItemCell = ItemCell.New(self.CommonSlot)

	self:AddListener()
end

function m:SetData(cid, num)
	self.ItemCell:SetItemByCID(cid, num)
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:Dispose()
	self:RemoveListener()
	self.ItemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
