-- chunkname: @IQIGame\\Scene\\HorizontalRPG\\HorizontalRPGCameraObsData.lua

local m = {
	moveInterpolation = 0
}

function m.New(pos, moveInter)
	local o = Clone(m)

	o:Init(pos, moveInter)

	return o
end

function m:Init(pos, moveInter)
	self.pos = pos
	self.moveInterpolation = moveInter
end

return m
