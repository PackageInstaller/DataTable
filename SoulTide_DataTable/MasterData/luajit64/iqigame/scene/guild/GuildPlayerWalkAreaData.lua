-- chunkname: @IQIGame\\Scene\\Guild\\GuildPlayerWalkAreaData.lua

local m = {}

function m.New(trans)
	local o = Clone(m)

	o:Init(trans)

	return o
end

function m:Init(trans)
	self.trans = trans
	self.leftPos = self.trans:Find("LimitLeft").localPosition
	self.rightPos = self.trans:Find("LimitRight").localPosition
end

return m
