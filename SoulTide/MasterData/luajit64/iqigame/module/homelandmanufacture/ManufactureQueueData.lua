-- chunkname: @IQIGame\\Module\\HomeLandManufacture\\ManufactureQueueData.lua

ManufactureQueueData = {
	status = 0,
	costs = {}
}

function ManufactureQueueData.New()
	local o = Clone(ManufactureQueueData)

	return o
end

function ManufactureQueueData:Init(id)
	self.id = id
end

function ManufactureQueueData:Update(cid, status, finishTime, costs, unlock)
	self.cid = cid
	self.status = status
	self.finishTime = finishTime
	self.costs = costs
	self.unlock = unlock
end

return ManufactureQueueData
