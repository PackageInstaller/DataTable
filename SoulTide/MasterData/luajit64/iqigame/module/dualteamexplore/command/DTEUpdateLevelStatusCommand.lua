-- chunkname: @IQIGame\\Module\\DualTeamExplore\\Command\\DTEUpdateLevelStatusCommand.lua

local m = {
	Separate = false
}

m = extend(DualTeamExploreBaseCommand, m)

function m.New(separate)
	local obj = Clone(m)

	obj:Init(separate)

	return obj
end

function m:Init(separate)
	self.Separate = separate
end

function m.Type()
	return "DTEUpdateLevelStatusCommand"
end

DTEUpdateLevelStatusCommand = m
