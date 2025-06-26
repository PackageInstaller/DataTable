-- chunkname: @IQIGame\\Scene\\HorizontalRPG\\HorizontalRPGStateData.lua

local m = {
	checkGroundY = 0
}

function m.New(state, animationName, playTime, isLoop, checkGroundY)
	local o = Clone(m)

	o:Init(state, animationName, playTime, isLoop, checkGroundY)

	return o
end

function m:Init(state, animationName, playTime, isLoop, checkGroundY)
	self.state = state
	self.animationName = animationName
	self.playTime = playTime
	self.isLoop = isLoop
	self.checkGroundY = checkGroundY
end

return m
