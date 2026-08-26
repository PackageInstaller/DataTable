-- chunkname: @modules/logic/versionactivity1_3/armpipe/model/ArmPuzzlePipeMO.lua

module("modules.logic.versionactivity1_3.armpipe.model.ArmPuzzlePipeMO", package.seeall)

local ArmPuzzlePipeMO = pureTable("ArmPuzzlePipeMO")

function ArmPuzzlePipeMO:init(x, y)
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
end

local _cacheTable = {}

function ArmPuzzlePipeMO:getConnectValue()
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

function ArmPuzzlePipeMO:getBackgroundRes()
	return ArmPuzzleHelper.getBackgroundRes(self.typeId)
end

function ArmPuzzlePipeMO:getConnectRes()
	return ArmPuzzleHelper.getConnectRes(self.typeId)
end

function ArmPuzzlePipeMO:getRotation()
	return ArmPuzzleHelper.getRotation(self.typeId, self.value)
end

function ArmPuzzlePipeMO:cleanEntrySet()
	for k, v in pairs(self.entryConnect) do
		self.entryConnect[k] = nil
	end

	self.entryCount = 0
	self.connectPathIndex = 0
end

function ArmPuzzlePipeMO:getEntryCount(count, pathIndex)
	return
end

function ArmPuzzlePipeMO:isEntry()
	return ArmPuzzlePipeEnum.entry[self.typeId]
end

function ArmPuzzlePipeMO:setParamStr(str)
	local nums = string.splitToNumber(str, "#") or {}

	self.typeId = nums[1] or 0
	self.value = nums[2] or 0
	self.pathIndex = nums[3] or 0
	self.pathType = nums[4] or 0
	self.numIndex = nums[5] or 0
end

function ArmPuzzlePipeMO:getParamStr()
	return string.format("%s#%s#%s#%s#%s", self.typeId, self.value, self.pathIndex, self.pathType, self.numIndex)
end

return ArmPuzzlePipeMO
