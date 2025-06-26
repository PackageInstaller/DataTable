-- chunkname: @IQIGame\\Module\\DualTeamExplore\\Command\\DTEUpdateNodeCommand.lua

local m = {}

m = extend(DualTeamExploreBaseCommand, m)

function m.New(nodePOD)
	local obj = Clone(m)

	obj:Init(nodePOD)

	return obj
end

function m:Init(nodePOD)
	self.NodePOD = nodePOD
end

function m.Type()
	return "DTEUpdateNodeCommand"
end

DTEUpdateNodeCommand = m
