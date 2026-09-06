-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/data/UltimateWarPointInfo.lua

module("logic.extensions.ultimatewar.data.UltimateWarPointInfo", package.seeall)

local UltimateWarPointInfo = class("UltimateWarPointInfo")

function UltimateWarPointInfo:ctor(activityId, pointId)
	self._activityId = activityId
	self._pointId = pointId
	self._raceIds = {}
	self._supRaceIds = {}
	self._norRaceIds = {}
	self._pointData = UltimateWarConfig.instance:getDefenceLineData(activityId, pointId)
	self._itemLimit = self._pointData.itemLimit
	self._specialScoreRatio = self._pointData.specialScoreRatio
	self._scoreRatio = self._pointData.scoreRatio

	self:onReset()
end

function UltimateWarPointInfo:onReset()
	table.clear(self._raceIds)

	self._gainItemCount = 0
	self._leftItemCount = 0
	self._lastRefreshTime = 0
end

function UltimateWarPointInfo:updateData(value)
	self._gainItemCount = checknumber(value.gainItemCount)
	self._leftItemCount = checknumber(value.leftItemCount)
	self._lastRefreshTime = checknumber(value.lastRefreshTime)

	table.clear(self._raceIds)
	table.insertto(self._raceIds, value.raceIds)
	table.clear(self._supRaceIds)
	table.clear(self._norRaceIds)

	for _, raceId in ipairs(self._raceIds) do
		if table.indexof(self._pointData.specialRaceIds, raceId) ~= false then
			table.insert(self._supRaceIds, raceId)
		else
			table.insert(self._norRaceIds, raceId)
		end
	end

	local awakeLvA, awakeLvB = 0, 0

	for _, list in ipairs({
		self._supRaceIds,
		self._norRaceIds
	}) do
		table.sort(list, function(a, b)
			awakeLvA = HandbookModel.instance:getAwakenNum(a)
			awakeLvB = HandbookModel.instance:getAwakenNum(b)

			return awakeLvA > awakeLvB
		end)
	end
end

function UltimateWarPointInfo:getPointId()
	return self._pointId
end

function UltimateWarPointInfo:getGainItemCount()
	return self._gainItemCount
end

function UltimateWarPointInfo:getLeftItemCount()
	return self._leftItemCount
end

function UltimateWarPointInfo:getLastRefreshTime()
	return self._lastRefreshTime
end

function UltimateWarPointInfo:isDispatchingTheRace(raceId)
	return table.indexof(self._raceIds, raceId) ~= false
end

function UltimateWarPointInfo:getSupRaceIdOfDispatching()
	return self._supRaceIds
end

function UltimateWarPointInfo:getNorRaceIdOfDispatching()
	return self._norRaceIds
end

function UltimateWarPointInfo:getCurDispatchCount()
	return #self._raceIds
end

function UltimateWarPointInfo:getCurSupRaceCount()
	return #self._supRaceIds
end

function UltimateWarPointInfo:getCurNorRaceCount()
	return #self._norRaceIds
end

function UltimateWarPointInfo:getAllRaceIds()
	local list = {}

	table.insertto(list, self._supRaceIds)
	table.insertto(list, self._norRaceIds)

	return list
end

function UltimateWarPointInfo:getMaxDispatchCount()
	return #self._pointData.specialRaceIds + self._pointData.normalPetCountLimit
end

function UltimateWarPointInfo:getItemLimit()
	return self._itemLimit
end

function UltimateWarPointInfo:getSpecialScoreRatio()
	return self._specialScoreRatio
end

function UltimateWarPointInfo:getScoreRatio()
	return self._scoreRatio
end

function UltimateWarPointInfo:getAddScoreRatioByAwaken()
	local value = 0

	for _, raceId in ipairs(self._supRaceIds) do
		local awakenLv = HandbookModel.instance:getAwakenNum(raceId)

		value = value + UltimateWarConfig.instance:getAddScoreRatioByAwaken(self._activityId, awakenLv)
	end

	for _, raceId in ipairs(self._norRaceIds) do
		local awakenLv = HandbookModel.instance:getAwakenNum(raceId)

		value = value + UltimateWarConfig.instance:getAddScoreRatioByAwaken(self._activityId, awakenLv)
	end

	return value
end

function UltimateWarPointInfo:getXiaoLvOfSec(timeSec)
	local addScoreRatioByAwaken = self:getAddScoreRatioByAwaken()

	return Mathf.Floor((self._specialScoreRatio * #self._supRaceIds + self._scoreRatio * #self._norRaceIds + addScoreRatioByAwaken) * timeSec)
end

function UltimateWarPointInfo:getCurMaxLimtItem()
	return Mathf.Max(self._itemLimit - self._gainItemCount, 0)
end

return UltimateWarPointInfo
