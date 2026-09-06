-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingjiclg/config/DivinekingjiclgConfig.lua

module("logic.extensions.divinekingjiclg.config.DivinekingjiclgConfig", package.seeall)

local DivinekingjiclgConfig = class("DivinekingjiclgConfig", BaseConfig)

function DivinekingjiclgConfig:onInit()
	return
end

function DivinekingjiclgConfig:getNames()
	return {
		"divine_king_ji_clg_creeps",
		"divine_king_ji_clg_monster",
		"divine_king_ji_clg_activity",
		"divine_king_ji_clg_stage",
		"divine_king_ji_clg_buff"
	}
end

function DivinekingjiclgConfig:handleConfig(name, content)
	if name == "divine_king_ji_clg_creeps" then
		self._divine_king_ji_clg_creeps = content
	elseif name == "divine_king_ji_clg_monster" then
		self._divine_king_ji_clg_monster = content
	elseif name == "divine_king_ji_clg_activity" then
		self._divine_king_ji_clg_activity = content
	elseif name == "divine_king_ji_clg_stage" then
		self._divine_king_ji_clg_stage = content
	elseif name == "divine_king_ji_clg_buff" then
		self._divine_king_ji_clg_buff = content
	end
end

function DivinekingjiclgConfig:getActCfg(activityId)
	return self._divine_king_ji_clg_activity[activityId]
end

function DivinekingjiclgConfig:getSkinId(activityId)
	return self._divine_king_ji_clg_activity[activityId].skinId
end

function DivinekingjiclgConfig:getStageCfgs(activityId)
	return self._divine_king_ji_clg_stage[activityId]
end

function DivinekingjiclgConfig:getStageCfg(activityId, stageId)
	return self._divine_king_ji_clg_stage[activityId][stageId]
end

function DivinekingjiclgConfig:getMasterCfg(creepsMasterId)
	return self._divine_king_ji_clg_monster[creepsMasterId]
end

function DivinekingjiclgConfig:getCreepsCfgs(creepsMasterId)
	return self._divine_king_ji_clg_creeps[creepsMasterId]
end

function DivinekingjiclgConfig:getBuffPlanCfgs(buffPlanId)
	return self._divine_king_ji_clg_buff[buffPlanId]
end

DivinekingjiclgConfig.instance = DivinekingjiclgConfig.New()

return DivinekingjiclgConfig
