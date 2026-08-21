-- chunkname: @IQIGame\\Module\\CommonActivity\\RestaurantOperation\\RestaurantOperationMonsterData.lua

local m = {
	isPass = false
}

function m.New(id, pass)
	local o = Clone(m)

	o:Init(id, pass)

	return o
end

function m:Init(id, pass)
	self.cid = id
	self.isPass = pass
end

function m:GetCfgData()
	return CfgRestaurantOperationMonsterListTable[self.cid]
end

return m
