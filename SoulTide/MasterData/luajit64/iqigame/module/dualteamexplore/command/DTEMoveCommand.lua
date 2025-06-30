-- chunkname: @IQIGame\\Module\\DualTeamExplore\\Command\\DTEMoveCommand.lua

local m = {
	TeamIndex = 0,
	NodeId = 0,
	IsStop = false
}

m = extend(DualTeamExploreBaseCommand, m)

function m.New(teamIndex, nodeId, isStop)
	local obj = Clone(m)

	obj:Init(teamIndex, nodeId, isStop)

	return obj
end

function m:Init(teamIndex, nodeId, isStop)
	self.TeamIndex = teamIndex
	self.NodeId = nodeId
	self.IsStop = isStop
end

function m.Type()
	return "DTEMoveCommand"
end

DTEMoveCommand = m
