-- chunkname: @IQIGame\\UI\\MazeClock\\MazeClockBlockController.lua

local m = {
	Type = 0
}

function m.New(view, type)
	local obj = Clone(m)

	obj:Init(view, type)

	return obj
end

function m:Init(view, type)
	self.View = view
	self.Type = type
end

function m:Dispose()
	self.View = nil
end

return m
