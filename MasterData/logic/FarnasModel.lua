-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/farnas/model/FarnasModel.lua

module("logic.extensions.farnas.view.FarnasModel", package.seeall)

local FarnasModel = class("FarnasModel", BaseModel)

function FarnasModel:ctor()
	return
end

function FarnasModel:onInit()
	self:onReset()
end

function FarnasModel:onReset()
	self._normalFightResultRes = nil
	self._customFmtMoOfNor = nil
	self._customFmtMoOfExt = nil
	self._msgInfos = {}
end

function FarnasModel:setInfo(msg)
	local extStageInfoPool = {}

	for _, v in ipairs(msg.extremeClgStageInfo) do
		extStageInfoPool[v.stageId] = v
	end

	self._msgInfos[msg.activityId] = {
		normalClgStageInfo = msg.normalClgStageInfo,
		extStageInfoPool = extStageInfoPool,
		hasGainExtremeClgPrize = msg.hasGainExtremeClgPrize,
		normalClgProgressPrizeGainedBitId = msg.normalClgProgressPrizeGainedBitId,
		normalClgTodayGroupId = msg.normalClgTodayGroupId,
		normalClgProgress = msg.normalClgProgress
	}
end

function FarnasModel:getNormalClgStageInfo(activityId)
	return self._msgInfos[activityId] and self._msgInfos[activityId].normalClgStageInfo
end

function FarnasModel:updateNormalClgStageBestScore(activityId, dataBitId, bestScore)
	local isUpdate = false
	local list = self:getNormalClgStageInfo(activityId)

	if not list then
		return
	end

	for i, v in ipairs() do
		if v.dataBitId == dataBitId then
			isUpdate = true
			v.bestScore = bestScore

			break
		end
	end

	if not isUpdate then
		local pb = FarnasChallengeExtension_pb.PM_NormalClgStageInfo()

		pb.dataBitId = dataBitId
		pb.bestScore = bestScore

		table.insert(list, pb)
	end
end

function FarnasModel:gainExtremeClgPrize(activityId)
	if self._msgInfos[activityId] then
		self._msgInfos[activityId].hasGainExtremeClgPrize = true
	end
end

function FarnasModel:isHasGainExtremeClgPrize(activityId)
	if self._msgInfos[activityId] then
		return self._msgInfos[activityId].hasGainExtremeClgPrize
	end
end

function FarnasModel:isPassOfExtStage(activityId, stageId)
	local pool = self:_getExtStageInfoPool(activityId)

	if pool then
		return pool[stageId]
	end
end

function FarnasModel:getProgressOfNorClg(activityId)
	if self._msgInfos[activityId] then
		return self._msgInfos[activityId].normalClgProgress or 0
	end

	return 0
end

function FarnasModel:getProgressPrizeGainedBitIdListOfNorClg(activityId)
	if self._msgInfos[activityId] then
		return self._msgInfos[activityId].normalClgProgressPrizeGainedBitId
	end
end

function FarnasModel:getNormalClgTodayGroupId(activityId)
	if self._msgInfos[activityId] then
		return self._msgInfos[activityId].normalClgTodayGroupId
	end

	return 0
end

function FarnasModel:getLockedRaceIdListOfExtStage(activityId, stageId)
	local raceIdList = {}
	local info = self:getExtStageInfo(activityId, stageId)

	if info then
		table.insertto(raceIdList, info.lockedRace)
	end

	return raceIdList
end

function FarnasModel:_getExtStageInfoPool(activityId)
	if self._msgInfos[activityId] then
		return self._msgInfos[activityId].extStageInfoPool
	end
end

function FarnasModel:getExtStageInfo(activityId, stageId)
	local pool = self:_getExtStageInfoPool(activityId)

	if pool then
		return pool[stageId]
	end
end

function FarnasModel:getCustomFmtMoOfNor()
	if self._customFmtMoOfNor == nil then
		self._customFmtMoOfNor = FarnasCustomFmtMoOfNor.New()
	end

	return self._customFmtMoOfNor
end

function FarnasModel:getCustomFmtMoOfExt()
	if self._customFmtMoOfExt == nil then
		self._customFmtMoOfExt = FarnasCustomFmtMoOfExt.New()
	end

	return self._customFmtMoOfExt
end

function FarnasModel:handlePM_FarnasClgNotifyNormalFightResultRes(msg)
	if msg.win then
		if msg.normalClgProgress and self._msgInfos[msg.activityId] then
			self._msgInfos[msg.activityId].normalClgProgress = msg.normalClgProgress
		end

		local infos = self:getNormalClgStageInfo(msg.activityId)

		if not infos then
			return
		end

		if #infos <= 0 then
			local info = infos:add()

			info.dataBitId = msg.dataBitId
			info.bestScore = msg.bestScore
		else
			for i, v in ipairs(infos) do
				if v.dataBitId == msg.dataBitId then
					v.bestScore = msg.bestScore

					break
				end
			end
		end
	end

	self._normalFightResultRes = msg
end

function FarnasModel:getFightResultResOfNorClg()
	return self._normalFightResultRes
end

function FarnasModel:gainNormalClgPrize(dataBitId)
	local info = self:getProgressPrizeGainedBitIdListOfNorClg(activityId)

	if info then
		info:append(dataBitId)
	end
end

function FarnasModel:handlePM_FarnasClgNotifyExtremeFightResultRes(msg)
	self._extFightResultRes = msg
end

function FarnasModel:getExtFightResultRes()
	return self._extFightResultRes
end

function FarnasModel:resetExtremeClg(activityId, stageId)
	if self._msgInfos[activityId] then
		self._msgInfos[activityId].extStageInfoPool[stageId] = nil
	end
end

function FarnasModel:getAllLockNums(activityId)
	local num = 0

	for i, v in pairs(self:_getExtStageInfoPool(activityId) or {}) do
		num = num + #v.lockedRace
	end

	return num
end

function FarnasModel:hasGainAllNormalClgPrize(activityId)
	local gainIds = {}

	for i, dataBitId in ipairs(self:getProgressPrizeGainedBitIdListOfNorClg(activityId) or {}) do
		gainIds[dataBitId] = true
	end

	local cfgs = FarnasConfig.instance:getNorProgressCfgs(activityId)

	for i, v in ipairs(cfgs) do
		if not gainIds[v.dataBitId] then
			return false
		end
	end

	return true
end

FarnasModel.instance = FarnasModel.New()

return FarnasModel
