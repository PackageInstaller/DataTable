-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinezhongfeiclg/config/DivineZhongFeiClgConfig.lua

module("logic.extensions.divinezhongfeiclg.config.DivineZhongFeiClgConfig", package.seeall)

local DivineZhongFeiClgConfig = class("DivineZhongFeiClgConfig", BaseConfig)

function DivineZhongFeiClgConfig:onInit()
	DivineZhongFeiClgConfig.super.onInit(self)
end

function DivineZhongFeiClgConfig:getNames()
	return {
		"divine_zhong_fei_clg_activity",
		"divine_zhong_fei_clg_extreme_stage",
		"divine_zhong_fei_clg_extreme_buff",
		"divine_zhong_fei_clg_normal_prize",
		"divine_zhong_fei_clg_monster",
		"divine_zhong_fei_clg_creeps",
		"divine_zhong_fei_clg_normal_buff"
	}
end

function DivineZhongFeiClgConfig:handleConfig(name, content)
	if name == "divine_zhong_fei_clg_activity" then
		self._divine_zhong_fei_clg_activity = content
	elseif name == "divine_zhong_fei_clg_extreme_stage" then
		self._divine_zhong_fei_clg_extreme_stage = content
	elseif name == "divine_zhong_fei_clg_extreme_buff" then
		self._divine_zhong_fei_clg_extreme_buff = content
	elseif name == "divine_zhong_fei_clg_normal_prize" then
		self._divine_zhong_fei_clg_normal_prize = content
	elseif name == "divine_zhong_fei_clg_monster" then
		self._divine_zhong_fei_clg_monster = content
	elseif name == "divine_zhong_fei_clg_creeps" then
		self._divine_zhong_fei_clg_creeps = content
	elseif name == "divine_zhong_fei_clg_normal_buff" then
		self._divine_zhong_fei_clg_normal_buff = content
	end
end

function DivineZhongFeiClgConfig:getActivityCfg(activityId)
	return self._divine_zhong_fei_clg_activity[activityId]
end

function DivineZhongFeiClgConfig:getExtremeStageCfgs(activityId)
	return self._divine_zhong_fei_clg_extreme_stage[activityId]
end

function DivineZhongFeiClgConfig:getExtremeStageCfg(activityId, stageId)
	if self._divine_zhong_fei_clg_extreme_stage[activityId] then
		return self._divine_zhong_fei_clg_extreme_stage[activityId][stageId]
	end
end

function DivineZhongFeiClgConfig:getTeamCfg(creepsMasterId)
	return self._divine_zhong_fei_clg_monster[creepsMasterId]
end

function DivineZhongFeiClgConfig:getCreepsCfg(creepsMasterId)
	return self._divine_zhong_fei_clg_creeps[creepsMasterId]
end

function DivineZhongFeiClgConfig:getExtBuffCfgs(activityId)
	return self._divine_zhong_fei_clg_extreme_buff[activityId]
end

function DivineZhongFeiClgConfig:getNormalPrizeCfgs(activityId)
	return self._divine_zhong_fei_clg_normal_prize[activityId]
end

function DivineZhongFeiClgConfig:getNormalBattleBuffCfgs(activityId)
	return self._divine_zhong_fei_clg_normal_buff[activityId]
end

DivineZhongFeiClgConfig.instance = DivineZhongFeiClgConfig.New()

return DivineZhongFeiClgConfig
