-- chunkname: @IQIGame\\Module\\DualTeamExplore\\Command\\DualTeamExploreBaseCommand.lua

local m = {
	BASE_TYPE_NAME = "DualTeamExploreBaseCommand"
}

function m.New()
	local obj = Clone(m)

	return obj
end

function m.Type()
	return m.BASE_TYPE_NAME
end

DualTeamExploreBaseCommand = m
