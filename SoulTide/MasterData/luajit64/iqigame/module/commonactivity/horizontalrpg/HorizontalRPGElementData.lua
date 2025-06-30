-- chunkname: @IQIGame\\Module\\CommonActivity\\HorizontalRPG\\HorizontalRPGElementData.lua

local m = {
	isShow = true
}

function m.New(cid, mapID, areaID)
	local o = Clone(m)

	o:Init(cid, mapID, areaID)

	return o
end

function m:Init(cid, mapID, areaID)
	self.cid = cid
	self.mapID = mapID
	self.areaID = areaID
end

function m:GetCfgData()
	return CfgHorizontalRPGElementTable[self.cid]
end

function m:UpDateState(isShow, RPGElementPOD)
	self.isShow = isShow
	self.horizontalRPGElementPOD = RPGElementPOD
end

function m:GetSuccessfulService(triggerType)
	local haveService = false
	local successfulService = {}

	for i = 1, #self:GetCfgData().ServiceID do
		local serviceID = self:GetCfgData().ServiceID[i]
		local cfgServiceData = CfgHorizontalRPGServiceTable[serviceID]

		if cfgServiceData.ServiceType == triggerType then
			local executionIds = {}
			local conditionRes = ConditionModule.Check(cfgServiceData.ConditionID)

			if conditionRes then
				executionIds = cfgServiceData.ExecutionId
			else
				executionIds = cfgServiceData.VetoExecutionId
			end

			if #executionIds > 0 then
				haveService = true
				successfulService[serviceID] = executionIds
			end
		end
	end

	return haveService, successfulService
end

return m
