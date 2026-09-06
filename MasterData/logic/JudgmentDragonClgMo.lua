-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/judgmentdragonclg/data/JudgmentDragonClgMo.lua

module("logic.extensions.judgmentdragonclg.data.JudgmentDragonClgMo", package.seeall)

local JudgmentDragonClgMo = class("JudgmentDragonClgMo")

function JudgmentDragonClgMo:ctor(activityId)
	self._activityId = activityId
	self._stageInfos = {}
	self._fightResMsg = nil
end

function JudgmentDragonClgMo:dispose()
	table.clear(self._stageInfos)

	self._fightResMsg = nil
end

function JudgmentDragonClgMo:handlePM_JudgmentDragonClgGetInfoRes(msg)
	table.clear(self._stageInfos)

	for _, v in ipairs(msg.phaseList) do
		local phaseId = v.phaseId

		self._stageInfos[phaseId] = self._stageInfos[phaseId] or {}

		for _, vv in ipairs(v.stageList) do
			self._stageInfos[phaseId][vv.stageId] = vv
		end
	end
end

function JudgmentDragonClgMo:handlePM_JudgmentDragonClgFightRes(msg)
	return
end

function JudgmentDragonClgMo:handlePM_JudgmentDragonClgResetRes(msg)
	local phaseId = msg.phaseId

	self._stageInfos[phaseId] = self._stageInfos[phaseId] or {}
	self._stageInfos[phaseId][msg.stage.stageId] = msg.stage
end

function JudgmentDragonClgMo:handlePM_JudgmentDragonNotifyFightRes(msg)
	self._fightResMsg = msg
end

function JudgmentDragonClgMo:isUnlockPhase(phaseId)
	return self:isPassPhase(phaseId - 1)
end

function JudgmentDragonClgMo:isPassChallenge()
	local result = true
	local cfg = JudgmentDragonClgConfig.instance:getPhaseCfg(self._activityId)

	if cfg then
		for _, data in ipairs(cfg) do
			if not self:isPassPhase(data.phaseId) then
				result = false

				break
			end
		end
	end

	return result
end

function JudgmentDragonClgMo:isPassPhase(phaseId)
	local result = true
	local cfg = JudgmentDragonClgConfig.instance:getStageCfg(self._activityId, phaseId)

	if cfg then
		for _, data in ipairs(cfg) do
			if not self:isPassStage(phaseId, data.stageId) then
				result = false

				break
			end
		end
	end

	return result
end

function JudgmentDragonClgMo:isPassStage(phaseId, stageId)
	local info = self:_getStageInfo(phaseId, stageId)

	return checkbool(info and info.isPass)
end

function JudgmentDragonClgMo:getLockRaceIdsInPhase(phaseId)
	local list = {}

	if self._stageInfos[phaseId] then
		for _, info in pairs(self._stageInfos[phaseId]) do
			table.insertto(list, info.lockRaceIds)
		end
	end

	return list
end

function JudgmentDragonClgMo:getLockRaceIdsInStage(phaseId, stageId)
	local info = self:_getStageInfo(phaseId, stageId)

	return (info or nil) and (info.lockRaceIds or {})
end

function JudgmentDragonClgMo:_getStageInfo(phaseId, stageId)
	if self._stageInfos[phaseId] then
		return self._stageInfos[phaseId][stageId]
	end
end

return JudgmentDragonClgMo
