-- chunkname: @IQIGame\\UI\\Jewelry\\JewelryStrengthen\\JewelryStrengthenCostItemCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.itemCell = ItemCell.New(self.goSlot)

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(itemID, needNum, haveNum, showCost)
	self.goCostNum:SetActive(showCost)
	UGUIUtil.SetText(self.goCostNum, JewelryStrengthenUIApi:GetString("goCostNum", needNum, needNum <= haveNum))
	UGUIUtil.SetText(self.goOwnNum, JewelryStrengthenUIApi:GetString("goOwnNum", haveNum, needNum <= haveNum))
	self.itemCell:SetItemByCID(itemID)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	self.itemCell:Dispose()

	self.itemCell = nil

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
