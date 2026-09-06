-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinechenclg/config/DivineChenClgConfig.lua

module("logic.extensions.divinechenclg.config.DivineChenClgConfig", package.seeall)

local DivineChenClgConfig = class("DivineChenClgConfig", BaseConfig)

function DivineChenClgConfig:getNames()
	return {
		"divine_chen_clg_extreme_stage",
		"divine_chen_clg_normal_buff",
		"divine_chen_clg_creeps",
		"divine_chen_clg_normal_stage",
		"divine_chen_clg_normal_support_pet",
		"divine_chen_clg_normal_prize",
		"divine_chen_clg_self_buff_desc",
		"divine_chen_clg_team",
		"divine_chen_clg_activity"
	}
end

function DivineChenClgConfig:handleConfig(name, content)
	if name == "divine_chen_clg_extreme_stage" then
		self._divine_chen_clg_extreme_stage = content
	elseif name == "divine_chen_clg_normal_buff" then
		self._divine_chen_clg_normal_buff = content
	elseif name == "divine_chen_clg_creeps" then
		self._divine_chen_clg_creeps = content
	elseif name == "divine_chen_clg_normal_stage" then
		self._divine_chen_clg_normal_stage = content
	elseif name == "divine_chen_clg_normal_support_pet" then
		self._divine_chen_clg_normal_support_pet = content
	elseif name == "divine_chen_clg_normal_prize" then
		self._divine_chen_clg_normal_prize = content
	elseif name == "divine_chen_clg_self_buff_desc" then
		self._divine_chen_clg_self_buff_desc = content
	elseif name == "divine_chen_clg_team" then
		self._divine_chen_clg_team = content
	elseif name == "divine_chen_clg_activity" then
		self._divine_chen_clg_activity = content
	end
end

function DivineChenClgConfig:getActCfg(activityId)
	return self._divine_chen_clg_activity[activityId]
end

function DivineChenClgConfig:getBuffDescCfgs(planId)
	return self._divine_chen_clg_self_buff_desc[planId]
end

function DivineChenClgConfig:getNormalPrizeCfgs(activityId)
	return self._divine_chen_clg_normal_prize[activityId]
end

function DivineChenClgConfig:getSupportPetCfg(activityId, creepsId)
	return self._divine_chen_clg_normal_support_pet[activityId][creepsId]
end

function DivineChenClgConfig:getNormalStageCfgsById(activityId)
	return self._divine_chen_clg_normal_stage[activityId]
end

function DivineChenClgConfig:getCreepCfgs(creepsMasterId)
	return self._divine_chen_clg_creeps[creepsMasterId]
end

function DivineChenClgConfig:getTeamCfg(creepsMasterId)
	return self._divine_chen_clg_team[creepsMasterId]
end

function DivineChenClgConfig:getNormalBuffCfg(activityId, buffId)
	return self._divine_chen_clg_normal_buff[activityId][buffId]
end

function DivineChenClgConfig:getExtremeStageCfgs(activityId)
	return self._divine_chen_clg_extreme_stage[activityId]
end

DivineChenClgConfig.instance = DivineChenClgConfig.New()

return DivineChenClgConfig
