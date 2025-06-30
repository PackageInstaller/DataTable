-- chunkname: @IQIGame\\Module\\CommonActivity\\RestaurantOperation\\ROCardGame\\ROCardData.lua

local m = {
	isOpen = false
}

function m.New(cid, open)
	local o = Clone(m)

	o:Init(cid, open)

	return o
end

function m:Init(cid, open)
	self.cid = cid
	self.open = open
end

function m:GetCfgData()
	return CfgRestaurantOperationCardListTable[self.cid]
end

return m
