-- chunkname: @IQIGame\\Module\\Maze\\AreaNodeData.lua

local m = {
	IsComplete = false,
	NodeId = 0,
	IsExit = false,
	YIndex = 0,
	XIndex = 0,
	IsActive = false,
	ExploreWeight = 0,
	IsPastComplete = false,
	EffectType = 0,
	AreaIx = 0,
	y = 0,
	x = 0,
	CID = 0,
	ParentNodes = {}
}

function m.New()
	return Clone(m)
end

return m
