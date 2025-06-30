-- chunkname: @IQIGame\\UI\\RoleDevelopment\\RoleBreachMaterialsItem.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ItemCell = ItemCell.PackageOrReuseView(self, self.CommonSlot, true, false)
	self.MaterialCountTextComponent = self.MaterialCountText:GetComponent("Text")

	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(data)
	local itemdata = WarehouseModule.FindItemForCid(data.ID)
	local haveNumStr

	if itemdata == nil then
		itemdata = ItemData.CreateByCIDAndNumber(data.ID, 0)
		haveNumStr = string.format(ColorCfg.RoleUpdate.zeroNum, "0")
	else
		local haveNum = WarehouseModule.GetItemNumByCfgID(itemdata.cid)

		if haveNum < data.Num then
			haveNumStr = string.format(ColorCfg.RoleUpdate.zeroNum, haveNum)
		else
			haveNumStr = string.format(ColorCfg.RoleUpdate.normalNum, haveNum)
		end
	end

	local needNum = string.format(ColorCfg.RoleUpdate.normalNum, data.Num)

	self.MaterialCountTextComponent.text = haveNumStr .. "/" .. needNum

	self.ItemCell:SetItem(itemdata)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
