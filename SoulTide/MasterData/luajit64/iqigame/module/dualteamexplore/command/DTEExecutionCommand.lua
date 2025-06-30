-- chunkname: @IQIGame\\Module\\DualTeamExplore\\Command\\DTEExecutionCommand.lua

local m = {
	ExecutionId = 0,
	ServiceId = 0
}

m = extend(DualTeamExploreBaseCommand, m)

function m.New(serviceId, executionId)
	local obj = Clone(m)

	obj:Init(serviceId, executionId)

	return obj
end

function m:Init(serviceId, executionId)
	self.ServiceId = serviceId
	self.ExecutionId = executionId
end

function m.Type()
	return "DTEExecutionCommand"
end

DTEExecutionCommand = m
