-- chunkname: @IQIGame\\UI\\Activity\\NewYearGift\\NewYearItemCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ItemCell = ItemCell.New(self.CommonSlot, true, true, true)
end

function m:SetData(id, haveNum, needNum)
	UGUIUtil.SetText(self.TextNum, haveNum)
	self.ItemCell:SetItemByCID(id)
	self.View:GetComponent("ImageGroupGrayComponent"):EnableGray(haveNum == 0)
end

function m:Dispose()
	self.ItemCell:Dispose()

	self.ItemCell = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
