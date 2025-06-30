-- chunkname: @IQIGame\\Scene\\RestaurantOperation\\RestaurantOperationScenePosData.lua

local m = {}

function m.New(transform, pos, roleID)
	local o = Clone(m)

	o:Init(transform, pos, roleID)

	return o
end

function m:Init(transform, pos, roleID)
	self.transform = transform
	self.pos = pos
	self.roleID = roleID
end

return m
