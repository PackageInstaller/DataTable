-- chunkname: @IQIGame\\Scene\\AmusementPark\\AmusementParkNpcWalkAreaData.lua

local m = {}

function m.New(trans)
	local o = Clone(m)

	o:Init(trans)

	return o
end

function m:Init(trans)
	self.trans = trans

	if self.trans then
		self.leftPos = self.trans:Find("LimitLeft").localPosition
		self.rightPos = self.trans:Find("LimitRight").localPosition
	end
end

function m:GetRandomPoint()
	local randomRatio = math.Random(0, 1)
	local targetPos = self.leftPos + (self.rightPos - self.leftPos) * randomRatio

	return targetPos
end

return m
