-- chunkname: @IQIGame\\UI\\ExploreHall\\Survival\\SurvivalFlyGameSettlement\\SurvivalFlyGameSettlementRewardCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ItemCell = ItemCell.New(self.CommonSlotUI)

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(itemShowPOD)
	self.ItemCell:SetItemByCID(itemShowPOD.cid, itemShowPOD.num)
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
