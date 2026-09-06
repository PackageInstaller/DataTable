-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmengmengclg/data/OriginKingMengMengClgSubMo.lua

module("logic.extensions.originkingmengmengclg.data.OriginKingMengMengClgSubMo", package.seeall)

local OriginKingMengMengClgSubMo = class("OriginKingMengMengClgSubMo")

function OriginKingMengMengClgSubMo:ctor(activityId)
	self._activityId = activityId

	self:_resetData()
end

function OriginKingMengMengClgSubMo:_resetData()
	self._extremeClgPass = false
	self._normalClgPass = false
	self._stageValueMap = {}
	self._normalStagePassMap = {}
	self._stageLockRaceIdMap = {}
	self._extremeFightResult = nil
	self._bossFightResult = nil
	self._normalFightResult = nil
end

function OriginKingMengMengClgSubMo:dispose()
	self:_resetData()
end

function OriginKingMengMengClgSubMo:_updateStageInfo(stageInfo)
	local stageId = stageInfo.stageId

	self._stageValueMap[stageId] = stageInfo.value
	self._normalStagePassMap[stageId] = checkbool(stageInfo.gainNormalClgPrize)

	local raceIdMap = self._stageLockRaceIdMap[stageId]

	if raceIdMap == nil then
		raceIdMap = {}
		self._stageLockRaceIdMap[stageId] = raceIdMap
	else
		table.clear(raceIdMap)
	end

	for _, raceId in ipairs(stageInfo.unlockRaceIds) do
		raceIdMap[raceId] = true
	end
end

function OriginKingMengMengClgSubMo:handlePM_OriginKingMengMengClgGetInfoRes(msg)
	self._extremeClgPass = checkbool(msg.extremeClgPass)
	self._normalClgPass = checkbool(msg.normalClgPass)

	table.clear(self._stageValueMap)
	table.clear(self._normalStagePassMap)
	table.clear(self._stageLockRaceIdMap)

	for _, stageInfo in ipairs(msg.stageList) do
		self:_updateStageInfo(stageInfo)
	end
end

function OriginKingMengMengClgSubMo:handlePM_OriginKingMengMengClgExtremeFightNotifyRes(msg)
	self._extremeFightResult = msg
end

function OriginKingMengMengClgSubMo:handlePM_OriginKingMengMengClgBossFightNotifyRes(msg)
	self._extremeClgPass = checkbool(msg.extremeClgPass)
	self._bossFightResult = msg
end

function OriginKingMengMengClgSubMo:handlePM_OriginKingMengMengClgConfirmRes(msg)
	self:_updateStageInfo(msg.stageInfo)
end

function OriginKingMengMengClgSubMo:handlePM_OriginKingMengMengClgNormalFightNotifyRes(msg)
	self._normalFightResult = msg

	if not msg.isWin then
		return
	end

	if msg.stageId == -1 then
		self._normalClgPass = true
	else
		self._normalStagePassMap[msg.stageId] = true
	end
end

function OriginKingMengMengClgSubMo:handlePM_OriginKingMengMengClgResetRes(msg)
	self:_updateStageInfo(msg.stageInfo)
end

function OriginKingMengMengClgSubMo:getActivityId()
	return self._activityId
end

function OriginKingMengMengClgSubMo:isExtremeClgPass()
	return self._extremeClgPass
end

function OriginKingMengMengClgSubMo:isNormalClgPass()
	return self._normalClgPass
end

function OriginKingMengMengClgSubMo:getStageValueMap()
	return self._stageValueMap
end

function OriginKingMengMengClgSubMo:getNormalStagePassMap()
	return self._normalStagePassMap
end

function OriginKingMengMengClgSubMo:getStageValue(stageId)
	return self._stageValueMap[stageId] or 0
end

function OriginKingMengMengClgSubMo:getTotalValue()
	local total = 0

	for _, value in pairs(self._stageValueMap) do
		total = total + value
	end

	return total
end

function OriginKingMengMengClgSubMo:getUnlockBossStageValue()
	local data = OriginKingMengMengClgConfig.instance:getActivityData(self._activityId)

	return (data or nil) and (data.unlockBossStageValue or 0)
end

function OriginKingMengMengClgSubMo:isExtremeBossUnlocked()
	local data = OriginKingMengMengClgConfig.instance:getActivityData(self._activityId)

	return data and self:getTotalValue() >= data.unlockBossStageValue or false
end

function OriginKingMengMengClgSubMo:isExtremeStagePassed(stageId)
	local raceIdMap = self:getStageLockRaceIdMap(stageId)

	return raceIdMap and next(raceIdMap) ~= nil or false
end

function OriginKingMengMengClgSubMo:getStageLockRaceIdMap(stageId)
	return self._stageLockRaceIdMap[stageId] or {}
end

function OriginKingMengMengClgSubMo:isStageLockRaceId(stageId, raceId)
	local raceIdMap = self:getStageLockRaceIdMap(stageId)

	return raceIdMap[raceId] == true
end

function OriginKingMengMengClgSubMo:getAllLockRaceIdMap()
	local result = {}

	for _, raceIdMap in pairs(self._stageLockRaceIdMap) do
		for raceId, isLocked in pairs(raceIdMap) do
			if isLocked then
				result[raceId] = true
			end
		end
	end

	return result
end

function OriginKingMengMengClgSubMo:isNormalStagePassed(stageId)
	return self._normalStagePassMap[stageId] == true
end

function OriginKingMengMengClgSubMo:getNormalPassedStageCount()
	local count = 0
	local stageDatas = OriginKingMengMengClgConfig.instance:getStageDatas(self._activityId) or {}

	for _, data in ipairs(stageDatas) do
		if self:isNormalStagePassed(data.stageId) then
			count = count + 1
		end
	end

	return count
end

function OriginKingMengMengClgSubMo:getExtremePassedStageCount()
	local count = 0
	local stageDatas = OriginKingMengMengClgConfig.instance:getStageDatas(self._activityId) or {}

	for _, data in ipairs(stageDatas) do
		if self:isExtremeStagePassed(data.stageId) then
			count = count + 1
		end
	end

	return count
end

function OriginKingMengMengClgSubMo:getStageCount()
	local stageDatas = OriginKingMengMengClgConfig.instance:getStageDatas(self._activityId)

	return (stageDatas or nil) and (#stageDatas or 0)
end

function OriginKingMengMengClgSubMo:getExtremeFightResult()
	return self._extremeFightResult
end

function OriginKingMengMengClgSubMo:getBossFightResult()
	return self._bossFightResult
end

function OriginKingMengMengClgSubMo:getNormalFightResult()
	return self._normalFightResult
end

return OriginKingMengMengClgSubMo
