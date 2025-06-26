-- chunkname: @IQIGame\\Module\\DualTeamExplore\\Command\\DTEGetItemCommand.lua

local m = {
	ExecutionId = 0,
	ServiceId = 0
}

m = extend(DualTeamExploreBaseCommand, m)

function m.New(serviceId, executionId, showItems)
	local obj = Clone(m)

	obj:Init(serviceId, executionId, showItems)

	return obj
end

function m:Init(serviceId, executionId, showItems)
	self.ServiceId = serviceId
	self.ExecutionId = executionId
	self.ShowItems = showItems
end

function m.Type()
	return "DTEGetItemCommand"
end

DTEGetItemCommand = m
