-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingdragonchallenge/config/DivineKingDragonChallengeConfig.lua

module("logic.extensions.divinekingdragonchallenge.config.DivineKingDragonChallengeConfig", package.seeall)

local DivineKingDragonChallengeConfig = class("DivineKingDragonChallengeConfig", BaseConfig)

function DivineKingDragonChallengeConfig:onInit()
	DivineKingDragonChallengeConfig.super.onInit(self)
end

function DivineKingDragonChallengeConfig:getNames()
	return {
		"divine_king_dragon_activity",
		"divine_king_dragon_common",
		"divine_king_dragon_stage",
		"divine_king_dragon_team",
		"divine_king_dragon_monster",
		"divine_king_dragon_creeps"
	}
end

function DivineKingDragonChallengeConfig:handleConfig(name, content)
	if name == "divine_king_dragon_activity" then
		self._dkdActData = content
	elseif name == "divine_king_dragon_common" then
		self._dkdCommonData = content
	elseif name == "divine_king_dragon_stage" then
		self._dkdStageCfg = content
	elseif name == "divine_king_dragon_team" then
		self._dkdTeamCfg = content
	elseif name == "divine_king_dragon_monster" then
		self._dkdMonsterData = content
	elseif name == "divine_king_dragon_creeps" then
		self._dkdCreepsCfg = content
	end
end

function DivineKingDragonChallengeConfig:getDkdActData(actId)
	return self._dkdActData[actId]
end

function DivineKingDragonChallengeConfig:getDkdCommonData(actId)
	local actData = self:getDkdActData(actId)

	if actData then
		return self._dkdCommonData[actData.comPlanId]
	end
end

function DivineKingDragonChallengeConfig:getDkdCommonValue(actId, key)
	local data = self:getDkdCommonData(actId)

	if data then
		return data[key]
	end
end

function DivineKingDragonChallengeConfig:getDkdStageDataList(actId)
	return self._dkdStageCfg[actId]
end

function DivineKingDragonChallengeConfig:getDkdStageData(actId, stageId)
	if self._dkdStageCfg[actId] then
		return self._dkdStageCfg[actId][stageId]
	end
end

function DivineKingDragonChallengeConfig:getDkdTeamDataList(teamPlanId)
	return self._dkdTeamCfg[teamPlanId]
end

function DivineKingDragonChallengeConfig:getDkdTeamData(teamPlanId, teamId)
	if self._dkdTeamCfg[teamPlanId] then
		return self._dkdTeamCfg[teamPlanId][teamId]
	end
end

function DivineKingDragonChallengeConfig:getDkdTeamDataListByStage(actId, stageId)
	local stageData = self:getDkdStageData(actId, stageId)

	if stageData then
		return self:getDkdTeamDataList(stageData.teamPlanId)
	end
end

function DivineKingDragonChallengeConfig:getDkdTeamDataByStage(actId, stageId, teamId)
	local dataList = self:getDkdTeamDataListByStage(actId, stageId)

	if dataList then
		return dataList[teamId]
	end
end

function DivineKingDragonChallengeConfig:getDkdMonsterData(creepsMasterId)
	return self._dkdMonsterData[creepsMasterId]
end

function DivineKingDragonChallengeConfig:getDkdCreepsDataList(creepsMasterId)
	return self._dkdCreepsCfg[creepsMasterId]
end

function DivineKingDragonChallengeConfig:getDkdCreepsData(creepsMasterId, creepsId)
	if self._dkdCreepsCfg[creepsMasterId] then
		return self._dkdCreepsCfg[creepsMasterId][creepsId]
	end
end

DivineKingDragonChallengeConfig.instance = DivineKingDragonChallengeConfig.New()

return DivineKingDragonChallengeConfig
