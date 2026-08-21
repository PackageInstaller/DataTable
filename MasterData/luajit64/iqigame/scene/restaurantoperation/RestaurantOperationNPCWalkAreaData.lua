-- chunkname: @IQIGame\\Scene\\RestaurantOperation\\RestaurantOperationNPCWalkAreaData.lua

local m = {}

function m.New(areaType, trans)
	local o = Clone(m)

	o:Init(areaType, trans)

	return o
end

function m:Init(areaType, trans)
	self.areaType = areaType
	self.trans = trans

	if self.trans then
		self.leftPos = self.trans:Find("LimitLeft").localPosition
		self.rightPos = self.trans:Find("LimitRight").localPosition
	end
end

function m:IsMoveArea()
	if self.areaType == RestaurantOperationConstant.WalkAreaType.WalkArea_NPC then
		return true
	end

	return false
end

return m
