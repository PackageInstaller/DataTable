-- chunkname: @IQIGame\\UI\\ExploreHall\\FlightChallenge\\FlightGameTeam\\FlightPlayerMaterialsCell.lua

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

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(itemID, itemNum)
	self.ItemCell:SetItemByCID(itemID, itemNum)
	self.Line:SetActive(itemNum > 0)
	self.LineGray:SetActive(itemNum == 0)
	self.BgHave:SetActive(itemNum > 0)
	self.BgNone:SetActive(itemNum == 0)
	self.BgNum:SetActive(itemNum > 1)
	self.ItemCell.View.ItemNumText:SetActive(itemNum > 1)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	self.ItemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
