-- chunkname: @IQIGame\\Module\\DualTeamExplore\\Command\\DTEUpdateTeamStatusCommand.lua

local m = {
	TeamIndex = 0,
	Stop = false
}

m = extend(DualTeamExploreBaseCommand, m)

function m.New(teamId, stop)
	local obj = Clone(m)

	obj:Init(teamId, stop)

	return obj
end

function m:Init(teamId, stop)
	self.TeamIndex = teamId
	self.Stop = stop
end

function m.Type()
	return "DTEUpdateTeamStatusCommand"
end

DTEUpdateTeamStatusCommand = m
