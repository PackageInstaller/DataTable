-- chunkname: @IQIGame\\UI\\HomeLandManufacture\\HomeLandNeedItemCell.lua

local HomeLandNeedItemCell = {}

function HomeLandNeedItemCell.New(view)
	local obj = Clone(HomeLandNeedItemCell)

	obj:Init(view)

	return obj
end

function HomeLandNeedItemCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ItemCellCom = ItemCell.PackageOrReuseView(self, self.ItemSlot.transform:GetChild(0).gameObject)
end

function HomeLandNeedItemCell:SetItemByCID(cid)
	self.ItemCellCom:SetItemByCID(cid)
end

function HomeLandNeedItemCell:SetCustomNum(haveNum, needNum)
	UGUIUtil.SetText(self.TextHave, HomeLandManufactureListUIApi:GetString("TextItemHave", haveNum, needNum <= haveNum))
	UGUIUtil.SetText(self.TextNeed, HomeLandManufactureListUIApi:GetString("TextItemNeed", needNum, needNum <= haveNum))
end

function HomeLandNeedItemCell:Dispose()
	ItemCell.DisposeIn(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return HomeLandNeedItemCell
