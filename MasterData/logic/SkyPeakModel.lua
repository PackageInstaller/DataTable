-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/skypeak/model/SkyPeakModel.lua

module("logic.extensions.skypeak.model.SkyPeakModel", package.seeall)

local SkyPeakModel = class("SkyPeakModel", BaseModel)

SkyPeakModel.StatePassStatus = {
	Pass = 1,
	NotPass = 0,
	Sweep = 2
}
SkyPeakModel.KillScoreParamType = {
	OriginalRace = "OriginalRace",
	OriginalPos = "OriginalPos"
}

function SkyPeakModel:onInit()
	self:onReset()
end

function SkyPeakModel:onReset()
	self._infoMap = {}
	self._stageDetailMap = {}
	self._rankInfoMap = {}
	self._lastStageChallengeResult = nil
	self._lastStageScoreBeforeChange = nil
	self._lastBossChallengeResult = nil
	self._bossMoMap = {}
end

function SkyPeakModel:getInfo(activityId)
	return self._infoMap[activityId]
end

function SkyPeakModel:getStageInfo(activityId, stageId)
	local info = self._infoMap[activityId]

	if info and info.stageInfoMap then
		return info.stageInfoMap[stageId]
	end
end

function SkyPeakModel:getBossInfo(activityId, bossId)
	local info = self._infoMap[activityId]

	if info and info.bossInfoMap then
		return info.bossInfoMap[bossId]
	end
end

function SkyPeakModel:getUnlockNodeMap(activityId)
	local info = self._infoMap[activityId]

	if info then
		return info.unlockNodeMap
	end
end

function SkyPeakModel:getStageDetail(activityId, stageId)
	if self._stageDetailMap[activityId] then
		return self._stageDetailMap[activityId][stageId]
	end
end

function SkyPeakModel:getRankInfo(activityId)
	return self._rankInfoMap[activityId]
end

function SkyPeakModel:getLastStageChallengeResult()
	return self._lastStageChallengeResult
end

function SkyPeakModel:getLastBossChallengeResult()
	return self._lastBossChallengeResult
end

function SkyPeakModel:getLastStageScoreBeforeChange()
	return checknumber(self._lastStageScoreBeforeChange)
end

function SkyPeakModel:clearLastChallengeResult()
	self._lastStageChallengeResult = nil
	self._lastStageScoreBeforeChange = 0
	self._lastBossChallengeResult = nil
end

function SkyPeakModel:getMaxPassStageId(activityId)
	local maxStageId = 0
	local info = self._infoMap[activityId]

	if info and info.stageInfoMap then
		for _, stageInfo in pairs(info.stageInfoMap) do
			if stageInfo.prizeState == SkyPeakModel.StatePassStatus.Pass or stageInfo.prizeState == SkyPeakModel.StatePassStatus.Sweep then
				maxStageId = math.max(maxStageId, stageInfo.stageId)
			end
		end
	end

	return maxStageId
end

function SkyPeakModel:getTotalPassStageCount(activityId)
	local count = 0
	local info = self._infoMap[activityId]

	if info and info.stageInfoMap then
		for _, stageInfo in pairs(info.stageInfoMap) do
			if stageInfo.prizeState == SkyPeakModel.StatePassStatus.Pass then
				count = count + 1
			end
		end
	end

	return count
end

function SkyPeakModel:getTotalSweepableStageCount(activityId)
	local stageCfgs = SkyPeakConfig.instance:getAllStageCfgs(activityId) or {}

	if #stageCfgs == 0 then
		return 0
	end

	local maxPassStageId = self:getMaxPassStageId(activityId)

	if maxPassStageId <= 0 then
		return 0
	end

	local totalPassStageCount = self:getTotalPassStageCount(activityId)

	if totalPassStageCount <= 0 then
		return 0
	end

	local sweepableCount = 0
	local maxNeedCheckStageId = math.min(maxPassStageId + totalPassStageCount, #stageCfgs)
	local needCheckStageCount = maxNeedCheckStageId - maxPassStageId

	if needCheckStageCount <= 0 then
		return 0
	end

	for i = 1, needCheckStageCount do
		local stageCfg = stageCfgs[i + maxPassStageId]

		if not stageCfg then
			break
		end

		if not stageCfg.unlockTime then
			local openTime = ""
			local isTimeMatch = false

			if not string.nilorempty(openTime) then
				local openTimestamp = GameUtil.string2time(openTime)
				local curTimestamp = ServerTime.now()

				if openTimestamp <= curTimestamp then
					isTimeMatch = true
				end
			else
				isTimeMatch = true
			end

			if isTimeMatch then
				sweepableCount = sweepableCount + 1
			else
				break
			end
		end
	end

	return sweepableCount
end

function SkyPeakModel:getBossMo(activityId, bossId)
	local key = activityId .. "_" .. bossId

	if self._bossMoMap[key] then
		return self._bossMoMap[key]
	end

	local bossCfg = SkyPeakConfig.instance:getBossCfgById(activityId, bossId)

	if bossCfg then
		local creepsMasterId = bossCfg.creepsMasterId
		local creepsCfgs = SkyPeakConfig.instance:getCreepsCfgs(creepsMasterId) or {}
		local creepCfg

		for _, cfg in pairs(creepsCfgs) do
			if not creepCfg then
				creepCfg = cfg

				break
			end
		end

		if creepCfg then
			local fmo = FightingPowerPetMo.New()

			fmo:fromChallengeCreepCo(creepCfg)

			local petMo = fmo:toBaseBagPetMo()

			self._bossMoMap[key] = petMo

			return petMo
		end
	end

	return nil
end

function SkyPeakModel:getBossTotalHp(activityId, bossId)
	local mo = self:getBossMo(activityId, bossId)

	if mo then
		if not mo._maxHp then
			return mo._maxHp
		end
	end

	return 0
end

function SkyPeakModel:isBossPassed(activityId, bossId)
	local info = self._infoMap[activityId]

	if info and info.bossInfoMap and info.bossInfoMap[bossId] then
		local bossInfo = info.bossInfoMap[bossId]

		return checknumber(bossInfo.bossLeftHp) <= 0
	end

	return false
end

function SkyPeakModel:isStagePassed(activityId, stageId)
	local info = self._infoMap[activityId]

	if info and info.stageInfoMap and info.stageInfoMap[stageId] then
		local stageInfo = info.stageInfoMap[stageId]

		return stageInfo.prizeState == SkyPeakModel.StatePassStatus.Pass or stageInfo.prizeState == SkyPeakModel.StatePassStatus.Sweep
	end

	return false
end

function SkyPeakModel:getStageScore(activityId, stageId)
	local info = self._infoMap[activityId]

	if info and info.stageInfoMap and info.stageInfoMap[stageId] then
		local stageInfo = info.stageInfoMap[stageId]

		return stageInfo.maxScore or 0
	end

	return 0
end

function SkyPeakModel:isBuffNodeUnlock(activityId, nodeId)
	local info = self._infoMap[activityId]

	if info and info.unlockNodeMap then
		return info.unlockNodeMap[nodeId] == true
	end

	return false
end

function SkyPeakModel:getBossScore(activityId)
	local info = self._infoMap[activityId]

	if info and info.bossInfoMap then
		local score = 0

		for _, bossInfo in pairs(info.bossInfoMap) do
			if checknumber(bossInfo.bossLeftHp) <= 0 then
				local bossCfg = SkyPeakConfig.instance:getBossCfgById(activityId, bossInfo.bossId)

				if bossCfg then
					score = score + (bossCfg.buffScore or 0)
				end
			end
		end

		return score
	end

	return 0
end

function SkyPeakModel:getUsedBuffScore(activityId)
	local info = self._infoMap[activityId]

	if info and info.unlockNodeMap then
		local score = 0

		for nodeId, _ in pairs(info.unlockNodeMap) do
			local nodeCfg = SkyPeakConfig.instance:getBuffCfgById(activityId, nodeId)

			if nodeCfg then
				score = score + (nodeCfg.costBuffScore or 0)
			end
		end

		return score
	end

	return 0
end

function SkyPeakModel:onGetInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId
	local stageInfoMap = {}

	for _, stageInfo in ipairs(info.stageInfos or {}) do
		stageInfoMap[stageInfo.stageId] = stageInfo
	end

	info.stageInfoMap = stageInfoMap

	local bossInfoMap = {}

	for _, bossInfo in ipairs(info.bossInfos or {}) do
		bossInfoMap[bossInfo.bossId] = bossInfo
	end

	info.bossInfoMap = bossInfoMap

	local unlockNodeMap = {}

	for _, nodeId in ipairs(info.unlockNodeIds or {}) do
		unlockNodeMap[nodeId] = true
	end

	info.unlockNodeMap = unlockNodeMap
	self._infoMap[activityId] = info
end

function SkyPeakModel:onGetStageInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId

	self._stageDetailMap[activityId] = self._stageDetailMap[activityId] or {}
	self._stageDetailMap[activityId][info.stageId] = info
end

function SkyPeakModel:onSweep(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId

	if not info.endStageId then
		local oldMaxPassStageId = self:getMaxPassStageId(activityId)
		local cacheInfo = self._infoMap[activityId]

		if cacheInfo then
			cacheInfo.hasSweepThisWeek = true

			if not cacheInfo.stageInfoMap then
				for i = oldMaxPassStageId + 1, info.endStageId do
					if not cacheInfo.stageInfoMap[i] then
						cacheInfo.stageInfoMap[i].stageId = i
						cacheInfo.stageInfoMap[i].prizeState = SkyPeakModel.StatePassStatus.Sweep
						cacheInfo.stageInfoMap[i].maxScore = 0
						cacheInfo.stageInfoMap[i] = cacheInfo.stageInfoMap[i]
					end
				end

				cacheInfo.stageInfoMap = cacheInfo.stageInfoMap
			end
		end
	end
end

function SkyPeakModel:onUnlockBuffNode(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId
	local cacheInfo = self._infoMap[activityId]

	if cacheInfo then
		cacheInfo.unlockNodeIds = cacheInfo.unlockNodeIds or {}
		cacheInfo.unlockNodeMap = cacheInfo.unlockNodeMap or {}

		local exists = cacheInfo.unlockNodeMap[info.nodeId] == true

		if not exists then
			table.insert(cacheInfo.unlockNodeIds, info.nodeId)
		end

		cacheInfo.unlockNodeMap[info.nodeId] = true
	end
end

function SkyPeakModel:onResetBuff(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId
	local cacheInfo = self._infoMap[activityId]

	if cacheInfo then
		cacheInfo.unlockNodeMap = {}
		cacheInfo.unlockNodeIds = {}
	end
end

function SkyPeakModel:onGetRankInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._rankInfoMap[info.activityId] = info
end

function SkyPeakModel:onNotifyStageChallengeResult(msg)
	local info = GameUtil.pbToTable(msg)

	self._lastStageChallengeResult = info

	local activityId = info.activityId
	local stageId = info.stageId

	self._lastStageScoreBeforeChange = self:getStageScore(activityId, stageId)

	local isWin = info.win

	if isWin then
		local cacheInfo = self._infoMap[activityId]

		if cacheInfo then
			local cacheStageInfo = self:getStageInfo(activityId, stageId)

			if not cacheStageInfo then
				cacheInfo.stageInfoMap = cacheInfo.stageInfoMap or {}

				local newStageInfo = {}

				newStageInfo.stageId = stageId
				newStageInfo.prizeState = SkyPeakModel.StatePassStatus.Pass
				newStageInfo.maxScore = info.maxScore or 0
				cacheInfo.stageInfoMap[stageId] = newStageInfo
			else
				cacheStageInfo.maxScore = info.maxScore or cacheStageInfo.maxScore

				if cacheStageInfo.prizeState ~= SkyPeakModel.StatePassStatus.Sweep then
					cacheStageInfo.prizeState = SkyPeakModel.StatePassStatus.Pass
				end
			end
		end
	end
end

function SkyPeakModel:onNotifyBossChallengeResult(msg)
	local info = GameUtil.pbToTable(msg)

	self._lastBossChallengeResult = info

	local activityId = info.activityId
	local bossId = info.bossId
	local cacheInfo = self._infoMap[activityId]

	if cacheInfo then
		local cacheBossInfo = self:getBossInfo(activityId, bossId)

		if not cacheBossInfo then
			cacheInfo.bossInfoMap = cacheInfo.bossInfoMap or {}

			local newBossInfo = {}

			newBossInfo.bossId = bossId
			newBossInfo.bossLeftHp = info.bossLeftHp
			cacheInfo.bossInfoMap[bossId] = newBossInfo
		else
			cacheBossInfo.bossLeftHp = info.bossLeftHp
		end
	end
end

SkyPeakModel.instance = SkyPeakModel.New()

return SkyPeakModel
