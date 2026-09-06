-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingciyuan/config/DivineKingCiYuanConfig.lua

module("logic.extensions.divinekingciyuan.config.DivineKingCiYuanConfig", package.seeall)

local DivineKingCiYuanConfig = class("DivineKingCiYuanConfig", BaseConfig)

function DivineKingCiYuanConfig:getNames()
	return {
		"divine_king_ci_yuan_define",
		"divine_king_ci_yuan_phase",
		"divine_king_ci_yuan_stage",
		"divine_king_ci_yuan_monster",
		"divine_king_ci_yuan_creeps"
	}
end

function DivineKingCiYuanConfig:handleConfig(name, content)
	if name == "divine_king_ci_yuan_define" then
		self._divine_king_ci_yuan_define = content
	elseif name == "divine_king_ci_yuan_phase" then
		self._divine_king_ci_yuan_phase = content
	elseif name == "divine_king_ci_yuan_stage" then
		self._divine_king_ci_yuan_stage = content
	elseif name == "divine_king_ci_yuan_monster" then
		self._divine_king_ci_yuan_monster = content
	elseif name == "divine_king_ci_yuan_creeps" then
		self._divine_king_ci_yuan_creeps = content
	end
end

function DivineKingCiYuanConfig:getDefineCfgByActId(activityId)
	return self._divine_king_ci_yuan_define[activityId]
end

function DivineKingCiYuanConfig:getPhaseCfgsByActId(activityId)
	return self._divine_king_ci_yuan_phase[activityId]
end

function DivineKingCiYuanConfig:getStageCfgsByStagePlanId(stagePlanId)
	return self._divine_king_ci_yuan_stage[stagePlanId]
end

function DivineKingCiYuanConfig:getMonsterCfgById(creepsMasterId)
	return self._divine_king_ci_yuan_monster[creepsMasterId]
end

function DivineKingCiYuanConfig:getCreepsCfgsById(creepsMasterId)
	return self._divine_king_ci_yuan_creeps[creepsMasterId]
end

function DivineKingCiYuanConfig:getPhaseCfg(activityId, phaseId)
	return self._divine_king_ci_yuan_phase[activityId][phaseId]
end

function DivineKingCiYuanConfig:getStageCfg(activityId, phaseId, stageId)
	local stagePlanId = self._divine_king_ci_yuan_phase[activityId][phaseId].stagePlanId

	return self._divine_king_ci_yuan_stage[stagePlanId][stageId]
end

DivineKingCiYuanConfig.instance = DivineKingCiYuanConfig.New()

return DivineKingCiYuanConfig
