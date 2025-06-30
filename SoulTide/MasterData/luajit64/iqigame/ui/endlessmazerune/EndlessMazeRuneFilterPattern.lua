-- chunkname: @IQIGame\\UI\\EndlessMazeRune\\EndlessMazeRuneFilterPattern.lua

local m = {
	Qualities = {},
	Effects = {}
}

function m.New()
	return Clone(m)
end

function m:Clear()
	self.Qualities = {}
	self.Effects = {}
end

function m:IsEmpty()
	return #self.Qualities == 0 and #self.Effects == 0
end

return m
