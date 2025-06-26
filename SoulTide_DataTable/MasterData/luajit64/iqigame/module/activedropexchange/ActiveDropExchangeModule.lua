-- chunkname: @IQIGame\\Module\\ActiveDropExchange\\ActiveDropExchangeModule.lua

local m = {}

function m.Reload()
	return
end

function m.GetDropExchangedCount(operateEventID)
	local num = 0
	local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(operateEventID)

	if operationEventDataPOD and operationEventDataPOD.advPOD then
		num = operationEventDataPOD.advPOD.exchangedCount
	end

	return num
end

function m.Shutdown()
	return
end

ActiveDropExchangeModule = m
