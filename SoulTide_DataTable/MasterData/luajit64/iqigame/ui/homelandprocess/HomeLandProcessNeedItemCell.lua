-- chunkname: @IQIGame\\UI\\HomeLandProcess\\HomeLandProcessNeedItemCell.lua

local HomeLandProcessNeedItemCell = {}

function HomeLandProcessNeedItemCell.New(view)
	local obj = Clone(HomeLandProcessNeedItemCell)

	obj:Init(view)

	return obj
end

function HomeLandProcessNeedItemCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ItemCellCom = ItemCell.PackageOrReuseView(self, self.ItemSlot.transform:GetChild(0).gameObject, false)
end

function HomeLandProcessNeedItemCell:SetItemByCID(cid)
	if cid > 0 then
		self.ItemCellCom:SetItemByCID(cid)
		self.ItemSlot:SetActive(true)
		self.TextHave:SetActive(true)
		self.Image_Null:SetActive(false)
	else
		self.ItemSlot:SetActive(false)
		self.TextHave:SetActive(false)
		self.Image_Null:SetActive(true)
	end
end

function HomeLandProcessNeedItemCell:SetCustomNum(type, haveNum, needNum)
	self.type = type

	if self.type == 1 then
		UGUIUtil.SetText(self.TextHave, HomeLandMakeItemListUIApi:GetString("TextSpend", haveNum, needNum))
	else
		UGUIUtil.SetText(self.TextHave, tostring(needNum))
	end
end

function HomeLandProcessNeedItemCell:Dispose()
	ItemCell.DisposeIn(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return HomeLandProcessNeedItemCell
