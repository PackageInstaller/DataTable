-- chunkname: @modules/logic/versionactivity3_3/arcade/model/game/counter/ArcadeGameBaseCounter.lua

module("modules.logic.versionactivity3_3.arcade.model.game.counter.ArcadeGameBaseCounter", package.seeall)

local ArcadeGameBaseCounter = class("ArcadeGameBaseCounter")

function ArcadeGameBaseCounter:ctor(name, paramList)
	self._counterName = name
	self._paramList = paramList
	self._recordNum = 0
	self._paramRecordDict = nil

	if self._paramList and #self._paramList > 0 then
		self._paramRecordDict = {}

		for _, param in ipairs(self._paramList) do
			local strParma = tostring(param)

			self._paramRecordDict[strParma] = 0
		end
	end
end

function ArcadeGameBaseCounter:triggerRecord(param, count)
	count = count or 1

	self:_addRecord(param, count)
end

function ArcadeGameBaseCounter:_addRecord(param, count)
	local strParam

	if param then
		strParam = tostring(param)
	end

	if not count then
		logError(string.format("ArcadeGameBaseCounter:_addRecord count is nil, counterName:%s", self._counterName))

		return
	end

	if not string.nilorempty(strParam) then
		if not self._paramRecordDict then
			logError(string.format("ArcadeGameBaseCounter:_addRecord paramRecordDict is nil, counterName:%s param:%s", self._counterName, param))

			return
		end

		local record = self._paramRecordDict[strParam]

		if record then
			self._paramRecordDict[strParam] = record + count
		end
	else
		if self._paramRecordDict then
			logError(string.format("ArcadeGameBaseCounter:_addRecord param is nil, but paramRecordDict is not nil, counterName:%s", self._counterName))

			return
		end

		self._recordNum = self._recordNum + count
	end
end

function ArcadeGameBaseCounter:clearRecord()
	self._recordNum = 0

	if self._paramRecordDict then
		for param, _ in pairs(self._paramRecordDict) do
			self._paramRecordDict[param] = 0
		end
	end
end

function ArcadeGameBaseCounter:getRecord(param)
	local result = 0
	local strParam = tostring(param)

	if self._paramRecordDict then
		if self._paramRecordDict[strParam] then
			result = self._paramRecordDict[strParam]
		else
			logError(string.format("ArcadeGameBaseCounter:getRecord error, no record param data, counterName:%s param:%s", self._counterName, strParam))
		end
	else
		return self._recordNum
	end

	return result
end

function ArcadeGameBaseCounter:getSaveCounterBoxList()
	local result = {}

	if self._paramRecordDict then
		for param, record in pairs(self._paramRecordDict) do
			result[#result + 1] = {
				key = string.format("%s#%s", self._counterName, param),
				count = record
			}
		end
	else
		result[#result + 1] = {
			key = self._counterName,
			count = self._recordNum
		}
	end

	return result
end

return ArcadeGameBaseCounter
