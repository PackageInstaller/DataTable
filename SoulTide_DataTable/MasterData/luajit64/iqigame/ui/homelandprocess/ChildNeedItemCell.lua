-- chunkname: @IQIGame\\UI\\HomeLandProcess\\ChildNeedItemCell.lua

local ChildNeedItemCell = {}

function ChildNeedItemCell.New(view, index)
	local obj = Clone(ChildNeedItemCell)

	obj:Init(view, index)

	return obj
end

function ChildNeedItemCell:Init(view, index)
	self.View = view
	self.index = index

	LuaCodeInterface.BindOutlet(self.View, self)

	self.itemCell = ItemCell.PackageOrReuseView(self, self.Slot)
end

function ChildNeedItemCell:SetData(cid)
	self.itemCid = cid

	if self.itemCid == 0 then
		self.Null:SetActive(true)
		self.Name:SetActive(false)
		self.Slot:SetActive(false)
		self.Num:SetActive(false)
	else
		self.itemCell:SetItemByCID(self.itemCid)

		local cfgItem = CfgItemTable[self.itemCid]

		UGUIUtil.SetText(self.TextName, cfgItem.Name)
		self.Null:SetActive(false)
		self.Name:SetActive(true)
		self.Slot:SetActive(true)
		self.Num:SetActive(true)
	end
end

function ChildNeedItemCell:SetNum(num)
	UGUIUtil.SetText(self.TextNum, tostring(num))
end

function ChildNeedItemCell:Dispose()
	self.itemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return ChildNeedItemCell
