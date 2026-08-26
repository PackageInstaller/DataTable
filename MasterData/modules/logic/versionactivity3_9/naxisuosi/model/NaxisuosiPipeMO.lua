-- chunkname: @modules/logic/versionactivity3_9/naxisuosi/model/NaxisuosiPipeMO.lua

module("modules.logic.versionactivity3_9.naxisuosi.model.NaxisuosiPipeMO", package.seeall)

local NaxisuosiPipeMO = pureTable("NaxisuosiPipeMO")

function NaxisuosiPipeMO:init(x, y)
	self.x = x
	self.y = y
	self.typeId = 0
	self.value = 0
	self.pathIndex = 0
	self.pathType = 0
	self.numIndex = 0
	self.connectSet = {}
	self.entryConnect = {}
	self.entryCount = 0
	self.connectPathIndex = 0
	self.status = NaxisuosiPipeEnum.LineStatus.Normal
	self.hasWrongNode = false
end

local _cacheTable = {}

function NaxisuosiPipeMO:getConnectValue()
	local len = 0
	local result = 0

	if self.entryConnect then
		for k, v in pairs(self.entryConnect) do
			table.insert(_cacheTable, k)

			len = len + 1
		end

		table.sort(_cacheTable)

		for _, v in ipairs(_cacheTable) do
			result = result * 10 + v
		end

		for i = 1, len do
			_cacheTable[i] = nil
		end
	end

	return result
end

function NaxisuosiPipeMO:getBackgroundRes()
	return NaxisuosiPipeHelper.getBackgroundRes(self.typeId)
end

function NaxisuosiPipeMO:getConnectRes()
	return NaxisuosiPipeHelper.getConnectRes(self.typeId)
end

function NaxisuosiPipeMO:getErrorRes()
	return NaxisuosiPipeHelper.getErrorRes(self.typeId)
end

function NaxisuosiPipeMO:getStatusRes()
	local mapType = NaxisuosiPipeModel.instance:getMapType()

	return NaxisuosiPipeHelper.getResByStatus(self.typeId, self.status, mapType)
end

function NaxisuosiPipeMO:getRotation()
	return NaxisuosiPipeHelper.getRotation(self.typeId, self.value)
end

function NaxisuosiPipeMO:cleanEntrySet()
	for k, v in pairs(self.entryConnect) do
		self.entryConnect[k] = nil
	end

	self.entryCount = 0
	self.connectPathIndex = 0
end

function NaxisuosiPipeMO:isEntry()
	return NaxisuosiPipeEnum.entry[self.typeId]
end

function NaxisuosiPipeMO:setParamStr(str)
	local nums = string.splitToNumber(str, "#") or {}

	self.typeId = nums[1] or 0
	self.value = nums[2] or 0
	self.pathIndex = nums[3] or 0
	self.pathType = NaxisuosiPipeEnum.PathType.ConnectAll
	self.numIndex = nums[5] or 0
end

function NaxisuosiPipeMO:getParamStr()
	return string.format("%s#%s#%s#%s#%s", self.typeId, self.value, self.pathIndex, self.pathType, self.numIndex)
end

return NaxisuosiPipeMO
