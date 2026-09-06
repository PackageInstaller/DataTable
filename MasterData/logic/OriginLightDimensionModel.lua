-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlightdimension/model/OriginLightDimensionModel.lua

module("logic.extensions.originlightdimension.model.OriginLightDimensionModel", package.seeall)

local OriginLightDimensionModel = class("OriginLightDimensionModel", BaseModel)

function OriginLightDimensionModel:ctor()
	return
end

function OriginLightDimensionModel:onInit()
	self:onReset()
end

function OriginLightDimensionModel:onReset()
	self._infos = {}
	self._extremeStageInfo = {}
	self._extremeGlobalLockPet = {}
	self._normalFmtMo = nil
	self._extremeFmtMo = nil
	self._tempHpList = nil
	self._normalClgNotifyMsg = nil
	self._extremeClgNotifyMsg = nil
end

function OriginLightDimensionModel:getNormalFmtMo()
	self._normalFmtMo = self._normalFmtMo or OriginLightDimensionNormalFmtMo.New()

	return self._normalFmtMo
end

function OriginLightDimensionModel:getExtremeFmtMo()
	self._extremeFmtMo = self._extremeFmtMo or OriginLightDimensionExtremeFmtMo.New()

	return self._extremeFmtMo
end

function OriginLightDimensionModel:getInfo(activityId)
	return self._infos[activityId]
end

function OriginLightDimensionModel:saveInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._infos[data.activityId] = data

	local extremeStageInfo = {}
	local globalLockPet = {}

	if data.extremeStageInfo then
		for _, v in ipairs(data.extremeStageInfo) do
			local stageId = v.stageId

			if v.lockRaceId then
				for _, raceId in ipairs(v.lockRaceId) do
					if checknumber(raceId) > 0 then
						globalLockPet[raceId] = true
					end
				end
			end

			extremeStageInfo[stageId] = v
		end
	end

	self._extremeStageInfo[data.activityId] = extremeStageInfo
	self._extremeGlobalLockPet[data.activityId] = globalLockPet
end

function OriginLightDimensionModel:saveResetExtremeInfo(msg)
	local activityId = msg.activityId
	local stageId = msg.stageId
	local globalLockPet = {}

	if self._extremeStageInfo[activityId] then
		self._extremeStageInfo[activityId][stageId] = nil

		for stageId, v in pairs(self._extremeStageInfo[activityId]) do
			if v.lockRaceId then
				for _, raceId in ipairs(v.lockRaceId) do
					if checknumber(raceId) > 0 then
						globalLockPet[raceId] = true
					end
				end
			end
		end
	end

	self._extremeGlobalLockPet[msg.activityId] = globalLockPet
end

function OriginLightDimensionModel:getExtremeStageInfo(activityId, stageId)
	if self._extremeStageInfo[activityId] then
		return self._extremeStageInfo[activityId][stageId]
	end

	return nil
end

function OriginLightDimensionModel:getMaxNormalPassStage(activityId)
	if self._infos[activityId] then
		return checknumber(self._infos[activityId].normalStageInfo)
	end

	return 0
end

function OriginLightDimensionModel:isGainNormalPrize(activityId)
	local info = self._infos[activityId]

	return info and info.isGainNormalPrize == true or false
end

function OriginLightDimensionModel:isGainExtremePrize(activityId)
	local info = self._infos[activityId]

	return info and info.isGainExtremePrize == true or false
end

function OriginLightDimensionModel:getNormalChallengeCount(activityId)
	local info = self._infos[activityId]

	return info and checknumber(info.normalChallengeCount) or 0
end

function OriginLightDimensionModel:getLastBuff(activityId)
	local info = self._infos[activityId]

	return info and checknumber(info.lastBuff) or 0
end

function OriginLightDimensionModel:getHpWanPercent(activityId)
	local info = self._infos[activityId]

	return (info or nil) and (info.hpWanPercent or {})
end

function OriginLightDimensionModel:isExtremePetLock(activityId, raceId)
	local lockPet = self._extremeGlobalLockPet[activityId]

	return lockPet and lockPet[raceId] == true
end

function OriginLightDimensionModel:getAllLockPet(activityId)
	return self._extremeGlobalLockPet[activityId]
end

function OriginLightDimensionModel:_getStageCount(stageMap)
	if not stageMap then
		return 0
	end

	local count = 0

	for _ in pairs(stageMap) do
		count = count + 1
	end

	return count
end

function OriginLightDimensionModel:isNormalAllPass(activityId)
	local stageMap = OriginLightDimensionConfig.instance:getNormalStageCfgs(activityId)
	local maxPassStage = self:getMaxNormalPassStage(activityId)

	return maxPassStage >= self:_getStageCount(stageMap) and maxPassStage > 0
end

function OriginLightDimensionModel:saveNormalChallengeResult(msg)
	local data = GameUtil.pbToTable(msg)

	if not self._infos[data.activityId] then
		local normalInfo = {}

		if checknumber(data.stageId) > checknumber(normalInfo.normalStageInfo) and data.isWin == true then
			normalInfo.normalStageInfo = data.stageId
		end

		normalInfo.hpWanPercent = data.hpWanPercent and data.hpWanPercent or nil
		self._infos[data.activityId] = normalInfo

		local info = self._infos[data.activityId]

		if info and data.hpWanPercent then
			info.hpWanPercent = data.hpWanPercent
		end

		if info and msg.isWin then
			info.normalChallengeCount = info.normalChallengeCount - 1
		end
	end
end

function OriginLightDimensionModel:saveExtClgResult(msg)
	self._tempResultData = GameUtil.pbToTable(msg)
end

function OriginLightDimensionModel:getExtClgResult()
	return self._tempResultData
end

function OriginLightDimensionModel:saveExtremeChallengeResult(msg)
	local data = GameUtil.pbToTable(msg)
	local info = self._infos[data.activityId]

	if info then
		info.lastBuff = data.lastBuff
	end

	if not self._extremeStageInfo[data.activityId] then
		local extremeStageInfo = {}

		if not extremeStageInfo[data.stageId] then
			local stageInfo = {
				everPass = true,
				stageId = data.stageId,
				lockRaceId = {}
			}

			stageInfo.everPass = true
			stageInfo.buffId = data.lastBuff

			for _, raceId in ipairs(data.lockRaceIds or {}) do
				table.insert(stageInfo.lockRaceId, raceId)
			end

			extremeStageInfo[data.stageId] = stageInfo
			self._extremeStageInfo[data.activityId] = extremeStageInfo

			if not self._extremeGlobalLockPet[data.activityId] then
				for _, raceId in ipairs(stageInfo.lockRaceId) do
					self._extremeGlobalLockPet[data.activityId][raceId] = true
				end

				self._extremeGlobalLockPet[data.activityId] = self._extremeGlobalLockPet[data.activityId]
			end
		end
	end
end

function OriginLightDimensionModel:saveTempExtClgLastBuff(buffId)
	self._tempLastBuff = buffId
end

function OriginLightDimensionModel:getTempExtClgLastBuff()
	return self._tempLastBuff
end

OriginLightDimensionModel.instance = OriginLightDimensionModel.New()

return OriginLightDimensionModel
