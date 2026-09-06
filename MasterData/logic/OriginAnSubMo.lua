-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originan/data/OriginAnSubMo.lua

module("logic.extensions.originan.data.OriginAnSubMo", package.seeall)

local OriginAnSubMo = class("OriginAnSubMo")

function OriginAnSubMo:ctor(activityId)
	self._activityId = activityId

	self:onReset()
end

function OriginAnSubMo:onReset()
	self._extremePassedStages = {}
	self._extremeBlockHealTimes = {}
	self._extremeDizzyPositions = {}
	self._extremeBanRaces = {}
	self._extremeChangeSetId = nil
	self._extremeClgNotifyMsg = nil
	self._normalMaxBlockHealTimes = {}
	self._normalTotalBlockHealTimes = 0
	self._normalGainedProgress = {}
	self._normalClgNotifyMsg = nil
	self._isGainExtremePrize = false
end

function OriginAnSubMo:dispose()
	self:onReset()
end

function OriginAnSubMo:handlePM_OriginAnInfoRes(msg)
	self._normalTotalBlockHealTimes = msg.normalTotalBlockHealTimes
	self._isGainExtremePrize = msg.isGainExtremePrize

	table.clear(self._extremePassedStages)
	table.clear(self._extremeBlockHealTimes)
	table.clear(self._extremeDizzyPositions)
	table.clear(self._extremeBanRaces)

	for _, info in ipairs(msg.extremeStageInfo) do
		local stageId = info.stageId

		self._extremePassedStages[stageId] = true
		self._extremeBlockHealTimes[stageId] = info.blockHealTimes
		self._extremeDizzyPositions[stageId] = {}

		for _, posId in ipairs(info.dizzyPosition) do
			posId = posId + 1
			self._extremeDizzyPositions[stageId][posId] = self._extremeDizzyPositions[stageId][posId] or self._extremeDizzyPositions[stageId][posId] + 1
		end

		self._extremeBanRaces[stageId] = {}

		for _, raceId in ipairs(info.banRaceId) do
			table.insert(self._extremeBanRaces[stageId], raceId)
		end
	end

	table.clear(self._normalMaxBlockHealTimes)

	for _, info in ipairs(msg.normalStageInfo) do
		self._normalMaxBlockHealTimes[info.stageId] = info.maxBlockHealTimes
	end

	table.clear(self._normalGainedProgress)

	for _, progressId in ipairs(msg.normalGainProgress) do
		self._normalGainedProgress[progressId] = true
	end
end

function OriginAnSubMo:handlePM_OriginAnResetExtremeRes(msg)
	local stageId = msg.stageId

	self._extremePassedStages[stageId] = nil
	self._extremeBlockHealTimes[stageId] = nil
	self._extremeDizzyPositions[stageId] = nil
	self._extremeBanRaces[stageId] = nil
end

function OriginAnSubMo:handlePM_OriginAnExtremeClgRes(msg)
	return
end

function OriginAnSubMo:handlePM_OriginAnNotifyExtremeClgRes(msg)
	local stageId = msg.stageId

	self._extremeClgNotifyMsg = msg

	local needBlockHealTimes = self:getExtremeStagePassNeedBlockHealTimes(stageId)
	local totalBlockHealTimes = 0

	for _, v in ipairs(msg.posToBlockHealTimes) do
		totalBlockHealTimes = totalBlockHealTimes + v.right
	end

	if msg.isWin and needBlockHealTimes <= totalBlockHealTimes then
		self._extremePassedStages[stageId] = true

		local maxTimes = 0

		for _, v in ipairs(msg.posToBlockHealTimes) do
			local times = v.right

			if maxTimes < times then
				maxTimes = times
			end
		end

		self._extremeBlockHealTimes[stageId] = 0
		self._extremeDizzyPositions[stageId] = self._extremeDizzyPositions[stageId] or {}

		for _, v in ipairs(msg.posToBlockHealTimes) do
			local posId = v.left + 1
			local times = v.right

			if maxTimes > 0 and maxTimes == times then
				self._extremeDizzyPositions[stageId][posId] = self._extremeDizzyPositions[stageId][posId] or self._extremeDizzyPositions[stageId][posId] + 1
			end

			self._extremeBlockHealTimes[stageId] = self._extremeBlockHealTimes[stageId] + times
		end

		self._extremeBanRaces[stageId] = {}

		for _, raceId in ipairs(msg.banRaceId) do
			table.insert(self._extremeBanRaces[stageId], raceId)
		end
	end

	if msg:HasField("changeSetId") then
		self._extremeChangeSetId = msg.changeSetId
	end
end

function OriginAnSubMo:handlePM_OriginAnNormalClgRes(msg)
	return
end

function OriginAnSubMo:handlePM_OriginAnNotifyNormalClgRes(msg)
	self._normalClgNotifyMsg = msg

	local stageId = msg.stageId

	if msg:HasField("blockHealTimes") then
		if not self._normalMaxBlockHealTimes[stageId] then
			local value = 0
			local newValue = Mathf.Max(value, msg.blockHealTimes)
			local offest = newValue - value

			self._normalMaxBlockHealTimes[stageId] = newValue
			self._normalTotalBlockHealTimes = self._normalTotalBlockHealTimes + offest
		end
	end
end

function OriginAnSubMo:handlePM_OriginAnGainNormalProgressRes(msg)
	self._normalGainedProgress[msg.progressId] = true
end

function OriginAnSubMo:isExtremeStagePassed(stageId)
	return self._extremePassedStages[stageId] == true
end

function OriginAnSubMo:getDizzyCountExtreme(posId)
	local result = 0

	for stageId, dizzyPositions in pairs(self._extremeDizzyPositions) do
		result = result + (dizzyPositions[posId] or 0)
	end

	return result
end

function OriginAnSubMo:getDizzyCountExtremeByStage(stageId, posId)
	return (self._extremeDizzyPositions[stageId] or nil) and (self._extremeDizzyPositions[stageId][posId] or 0)
end

function OriginAnSubMo:getStageExtremeBanRaceList(stageId)
	return self._extremeBanRaces[stageId] or {}
end

function OriginAnSubMo:getAllExtremeBanRace()
	local result = {}

	for stageId, list in pairs(self._extremeBanRaces) do
		for _, raceId in ipairs(list) do
			table.insert(result, raceId)
		end
	end

	return result
end

function OriginAnSubMo:getExtremeTotalBlockHealTimes()
	local count = 0

	for _, times in pairs(self._extremeBlockHealTimes) do
		count = count + times
	end

	return count
end

function OriginAnSubMo:getExtremeStageBlockHealTimes(stageId)
	return self._extremeBlockHealTimes[stageId] or 0
end

function OriginAnSubMo:getExtremeStagePassNeedBlockHealTimes(stageId)
	local stageData = OriginAnConfig.instance:getExtremeStageData(self._activityId, stageId)

	return stageData.blockHealTimes or 0
end

function OriginAnSubMo:popExtremeChangeSetId()
	self._extremeChangeSetId = nil

	return self._extremeChangeSetId
end

function OriginAnSubMo:isGainExtremeFirstPrize()
	return self._isGainExtremePrize
end

function OriginAnSubMo:getExtremeClgNotifyMsg()
	return self._extremeClgNotifyMsg
end

function OriginAnSubMo:isNormalStagePassed(stageId)
	return self._normalMaxBlockHealTimes[stageId] ~= nil
end

function OriginAnSubMo:getNormalStageMaxBlockHealTimes(stageId)
	return self._normalMaxBlockHealTimes[stageId] or 0
end

function OriginAnSubMo:getNormalTotalBlockHealTimes()
	return self._normalTotalBlockHealTimes
end

function OriginAnSubMo:getNormalClgNotifyMsg()
	return self._normalClgNotifyMsg
end

function OriginAnSubMo:isNormalProgressGained(progressId)
	return self._normalGainedProgress[progressId] == true
end

return OriginAnSubMo
