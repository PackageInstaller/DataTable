-- chunkname: @IQIGame\\Module\\Common\\ExecutionModule.lua

ExecutionModule = {
	ClientExecutionTypes = {
		1001,
		1002
	}
}

function ExecutionModule.Execute(executionIds)
	if executionIds == nil then
		return
	end

	for i, v in ipairs(executionIds) do
		local cfgExecutionData = CfgExecutionTable[v]

		if cfgExecutionData == nil then
			logError("cfgExecutionData is nil , id = " .. tostring(v))

			return
		end

		local type = cfgExecutionData.ExecutionType
		local params = cfgExecutionData.Params

		if type == 1001 then
			UIModule.Open(Constant.UIControllerName.SoulLockUI, Constant.UILayer.UI, SoulModule.GetSoulData(tonumber(params[1])))
		elseif type == 1002 then
			DialogModule.Pause()
			UIModule.Open(Constant.UIControllerName.VideoPlayerUI, Constant.UILayer.Mid, {
				videoCid = tonumber(params[1]),
				onComplete = function()
					DialogModule.Resume()
				end
			})
		end
	end
end

function ExecutionModule.HasServiceExecution(executionIds)
	for i, v in ipairs(executionIds) do
		local cfgExecutionData = CfgExecutionTable[v]

		if cfgExecutionData == nil then
			logError("cfgExecutionData is nil , id = " .. tostring(v))

			return false
		end

		if table.indexOf(ExecutionModule.ClientExecutionTypes, cfgExecutionData.ExecutionType) == -1 then
			return true
		end
	end

	return false
end
