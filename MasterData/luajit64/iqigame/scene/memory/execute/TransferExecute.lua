-- chunkname: @IQIGame\\Scene\\Memory\\Execute\\TransferExecute.lua

local TransferExecute = {}

function TransferExecute.New()
	local obj = Clone(TransferExecute)

	return obj
end

function TransferExecute:Execute(args)
	local sceneIndex = tonumber(args[1])

	MemorySModule.ExitScene(sceneIndex)
end

function TransferExecute:OnDestroy()
	return
end

return TransferExecute
