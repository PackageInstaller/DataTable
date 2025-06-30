-- chunkname: @IQIGame\\Module\\CommonActivity\\RestaurantOperation\\ROFruitCleanGame\\ROFruitData.lua

local m = {
	x = 0,
	y = 0,
	pos = 0,
	isClean = false
}

function m.New(cid, clean)
	local o = Clone(m)

	o:Init(cid, clean)

	return o
end

function m:Init(cid, clean)
	self.cid = cid
	self.isClean = clean
end

function m:SetPos(pos)
	self.pos = pos

	local x, y = self:GetX_Y()

	self.x = x
	self.y = y
end

function m:GetCfgData()
	if self.cid > 0 then
		return CfgRestaurantOperationFruitListTable[self.cid]
	end

	return nil
end

function m:GetX_Y()
	local x = math.ceil(self.pos / 10)
	local y = self.pos - 10 * (x - 1)

	return x, y
end

return m
