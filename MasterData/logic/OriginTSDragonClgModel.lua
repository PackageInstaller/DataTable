-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origintsdragonclg/model/OriginTSDragonClgModel.lua

module("logic.extensions.origintsdragonclg.model.OriginTSDragonClgModel", package.seeall)

local OriginTSDragonClgModel = class("OriginTSDragonClgModel", BaseModel)

function OriginTSDragonClgModel:onInit()
	self:onReset()
end

function OriginTSDragonClgModel:onReset()
	self._infos = {}
	self._customFmtMoPool = {}
	self._phaseInfoMaps = {}
	self._petInfoMaps = {}
	self._curSelectPuzMaps = {}
	self._curSelectPhaseIdMap = {}
end

function OriginTSDragonClgModel:getInfo(activityId)
	return self._infos[activityId]
end

function OriginTSDragonClgModel:getFmtMo(activityId)
	if self._customFmtMoPool[activityId] == nil then
		self._customFmtMoPool[activityId] = OriginTSDragonClgFmtMo.New()
	end

	return self._customFmtMoPool[activityId]
end

function OriginTSDragonClgModel:getPetInfoMaps(activityId)
	return self._petInfoMaps[activityId]
end

function OriginTSDragonClgModel:getPhaseInfoMaps(activityId)
	return self._phaseInfoMaps[activityId]
end

function OriginTSDragonClgModel:getSelectPuzId(activityId, phaseId)
	local map = self._curSelectPuzMaps[activityId]

	return map and checknumber(map[phaseId]) or 0
end

function OriginTSDragonClgModel:setSelectPuzId(activityId, phaseId, puzId)
	self._curSelectPuzMaps[activityId] = self._curSelectPuzMaps[activityId] or {}

	local map = self._curSelectPuzMaps[activityId]

	map[phaseId] = puzId
end

function OriginTSDragonClgModel:getSelectPhaseId(activityId)
	return checknumber(self._curSelectPhaseIdMap[activityId])
end

function OriginTSDragonClgModel:setSelectPhaseId(activityId, phaseId)
	self._curSelectPhaseIdMap[activityId] = phaseId
end

function OriginTSDragonClgModel:handlePM_OriginTSDragonClgInfoRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg)

	local activityId = msg.activityId
	local info = self._infos[msg.activityId]
	local phases = info and checktable(info.phases) or {}
	local pets = info and checktable(info.pets) or {}

	self._phaseInfoMaps[activityId] = self._phaseInfoMaps[activityId] or {}

	local phaseInfoMap = self._phaseInfoMaps[activityId]

	for i, phaseInfo in ipairs(phases) do
		local phaseId = phaseInfo.phaseId

		phaseInfoMap[phaseId] = phaseInfoMap[phaseId] or {}

		local stages = phaseInfo and checktable(phaseInfo.stages) or {}
		local phaseMap = phaseInfoMap[phaseId]

		for i, v in ipairs(stages) do
			phaseMap[v.stageId] = v.puzzleId
		end
	end

	self._petInfoMaps[activityId] = self._petInfoMaps[activityId] or {}

	local petInfoMap = self._petInfoMaps[activityId]

	for i, petInfo in ipairs(pets) do
		local petId = petInfo.petId

		petInfoMap[petId] = petInfo.leftHp
	end
end

function OriginTSDragonClgModel:handlePM_NotifyTSDragonChallengeFinishRes(msg)
	local activityId = msg.activityId
	local phaseId = msg.phaseId

	if msg.isWin then
		self:setSelectPuzId(activityId, phaseId, 0)
	end
end

function OriginTSDragonClgModel:handlePM_OriginTSDragonResetRes(msg)
	local info = self._infos[msg.activityId]

	info.phases = nil
	info.pets = nil
	self._phaseInfoMaps[msg.activityId] = nil
	self._petInfoMaps[msg.activityId] = nil
	self._curSelectPuzMaps[msg.activityId] = nil
end

function OriginTSDragonClgModel:getCurPuzNum(activityId, phaseId)
	local phaseMaps = self._phaseInfoMaps[activityId]
	local phaseMap = phaseMaps and checktable(phaseMaps[phaseId]) or {}
	local num = 0

	for i, puzzleId in pairs(phaseMap) do
		if puzzleId > 0 then
			num = num + 1
		end
	end

	return num
end

function OriginTSDragonClgModel:hasUsePuzId(activityId, phaseId, curPuzId)
	local phaseMaps = self._phaseInfoMaps[activityId]
	local phaseMap = phaseMaps and checktable(phaseMaps[phaseId]) or {}

	for stageId, puzId in pairs(phaseMap) do
		if curPuzId == puzId then
			return true
		end
	end

	return false
end

function OriginTSDragonClgModel:hasPassed(activityId, phaseId, stageId)
	local phaseMaps = self._phaseInfoMaps[activityId]
	local phaseMap = phaseMaps and checktable(phaseMaps[phaseId]) or {}

	return phaseMap[stageId] ~= nil
end

function OriginTSDragonClgModel:getUsePuzId(activityId, phaseId, stageId)
	local phaseMaps = self._phaseInfoMaps[activityId]
	local phaseMap = phaseMaps and checktable(phaseMaps[phaseId]) or {}

	return phaseMap[stageId]
end

function OriginTSDragonClgModel:saveTempSelect(phaseId, stageId)
	self._tempPhaseId = phaseId
	self._tempStageId = stageId
end

function OriginTSDragonClgModel:getTempSelect()
	return self._tempPhaseId, self._tempStageId
end

function OriginTSDragonClgModel:isGainPrize(activityId)
	if self._infos[activityId] then
		return self._infos[activityId].gainedPrize or false
	end

	return false
end

function OriginTSDragonClgModel:handlePM_OriginTSDragonConfirmRes(msg)
	if msg.changeSetId and checknumber(msg.changeSetId) > 0 then
		self:setTempChangeSetId(msg.changeSetId)
	end
end

function OriginTSDragonClgModel:getTempChangeSetId()
	return self._tempChangeSetId
end

function OriginTSDragonClgModel:setTempChangeSetId(changeSetId)
	self._tempChangeSetId = changeSetId
end

OriginTSDragonClgModel.instance = OriginTSDragonClgModel.New()

return OriginTSDragonClgModel
