-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonpsychicclg/data/DragonPsychicClgMo.lua

module("logic.extensions.dragonpsychicclg.data.DragonPsychicClgMo", package.seeall)

local DragonPsychicClgMo = class("DragonPsychicClgMo")

function DragonPsychicClgMo:ctor(activityId)
	self._activityId = activityId
	self._canUseCreepsIds = {}
	self._curStageId = 0
	self._hatchInfo = nil
	self._norClgResMsg = nil
	self._extClgResMsg = nil
	self._isAllPassOfExt = false
	self._teamInfoMoLists = {}

	local stageCfgs = DragonPsychicClgConfig.instance:getDpcExtremeStageCfgs(activityId)

	if stageCfgs then
		for stageId, stageCfg in ipairs(stageCfgs) do
			self._teamInfoMoLists[stageId] = self._teamInfoMoLists[stageId] or {}

			for teamId, stageData in ipairs(stageCfg) do
				self._teamInfoMoLists[stageId][teamId] = DragonPsychicClgExtTeamInfoMo.New(stageId, teamId)
			end
		end
	end

	self._nullTeamInfoMo = DragonPsychicClgExtTeamInfoMo.New(0, 0)
end

function DragonPsychicClgMo:getActivityId()
	return self._activityId
end

function DragonPsychicClgMo:handlePM_DPClgGetUniversalInfoRes(msg)
	if self._canUseCreepsIds == nil then
		self._canUseCreepsIds = {}
	else
		table.clear(self._canUseCreepsIds)
	end

	table.insertto(self._canUseCreepsIds, msg.canUseCreepsIds)

	self._curStageId = msg.curStageId
	self._hatchInfo = msg.hatchInfo
end

function DragonPsychicClgMo:handlePM_DPClgUniversalChallengeRes(msg)
	return
end

function DragonPsychicClgMo:handlePM_DPClgHatchRes(msg)
	self._hatchInfo = msg.hatchInfo
end

function DragonPsychicClgMo:handlePM_DPClgDecHatchTimeRes(msg)
	self._hatchInfo = msg.hatchInfo
end

function DragonPsychicClgMo:handlePM_DPClgGainHatchPetRes(msg)
	if self._canUseCreepsIds == nil then
		self._canUseCreepsIds = {}
	end

	table.insert(self._canUseCreepsIds, msg.creepsId)

	self._hatchInfo = nil
end

function DragonPsychicClgMo:handlePM_DPClgSelectPetRes(msg)
	table.insertto(self._canUseCreepsIds, msg.canUseCreepsIds)
end

function DragonPsychicClgMo:handlePM_DPClgGetExtremeInfoRes(msg)
	self._isAllPassOfExt = msg.isAllPass

	for i, v in ipairs(msg.stageInfoList) do
		local stageId, teamId = v.stageId, v.teamId

		if self._teamInfoMoLists[stageId] then
			if self._teamInfoMoLists[stageId] == nil then
				printError(string.format("后端数据与前端配置不一( xl-龙系通灵师挑战.xlsx | export_极限挑战 | activityId=%s, stageId=%s, teamId=%s )", self._activityId, stageId, teamId))
			else
				self._teamInfoMoLists[stageId]:updateMsg(v)
			end
		end
	end
end

function DragonPsychicClgMo:handlePM_DPClgExtremeChallengeRes(msg)
	return
end

function DragonPsychicClgMo:handlePM_DPClgResetRes(msg)
	local stageId = msg.stageInfo.stageId

	if self._teamInfoMoLists[stageId] then
		if self._teamInfoMoLists[stageId] then
			self._teamInfoMoLists[stageId]:updateMsg(msg.stageInfo)

			self._isAllPassOfExt = false
		end
	end
end

function DragonPsychicClgMo:handlePM_DPClgNotifyUniversalChallengeRes(msg)
	self._norClgResMsg = msg
end

function DragonPsychicClgMo:handlePM_DPClgNotifyExtremeChallengeRes(msg)
	self._isAllPassOfExt = true

	local stageId = msg.stageInfo.stageId

	if self._teamInfoMoLists[stageId] then
		if self._teamInfoMoLists[stageId] then
			self._teamInfoMoLists[stageId]:updateMsg(msg.stageInfo)
		end

		self._extClgResMsg = msg
	end
end

function DragonPsychicClgMo:getCanUseCreepsIdsOfNor()
	return self._canUseCreepsIds
end

function DragonPsychicClgMo:getCurStageIdOfNor()
	return self._curStageId
end

function DragonPsychicClgMo:getHatchInfoOfNor()
	return self._hatchInfo
end

function DragonPsychicClgMo:getCreepsIdInHatchOfNor()
	local hatchInfo = self:getHatchInfoOfNor()

	return (hatchInfo or nil) and hatchInfo.creepsId
end

function DragonPsychicClgMo:getFinishTimeInHatchOfNor()
	local hatchInfo = self:getHatchInfoOfNor()

	return (hatchInfo or nil) and checknumber(hatchInfo.finishTime)
end

function DragonPsychicClgMo:isAllPassOfExt()
	return self._isAllPassOfExt
end

function DragonPsychicClgMo:getExtTeamInfoMo(stageId, teamId)
	local result

	return (self._teamInfoMoLists[stageId] and self._teamInfoMoLists[stageId][teamId] or nil) and self._teamInfoMoLists[stageId][teamId] or self._nullTeamInfoMo
end

return DragonPsychicClgMo
