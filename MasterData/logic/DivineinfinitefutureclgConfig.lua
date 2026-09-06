-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineinfinitefutureclg/config/DivineinfinitefutureclgConfig.lua

module("logic.extensions.divineinfinitefutureclg.config.DivineinfinitefutureclgConfig", package.seeall)

local DivineinfinitefutureclgConfig = class("DivineinfinitefutureclgConfig", BaseConfig)

function DivineinfinitefutureclgConfig:onInit()
	return
end

function DivineinfinitefutureclgConfig:getNames()
	return {
		"divine_infinite_future_clg_stage",
		"divine_infinite_future_clg_grid",
		"divine_infinite_future_clg_creeps_master",
		"divine_infinite_future_clg_creeps",
		"divine_infinite_future_clg"
	}
end

function DivineinfinitefutureclgConfig:handleConfig(name, content)
	if name == "divine_infinite_future_clg_stage" then
		self._divine_infinite_future_clg_stage = content
	elseif name == "divine_infinite_future_clg_grid" then
		self._divine_infinite_future_clg_grid = content
	elseif name == "divine_infinite_future_clg_creeps_master" then
		self._divine_infinite_future_clg_creeps_master = content
	elseif name == "divine_infinite_future_clg_creeps" then
		self._divine_infinite_future_clg_creeps = content
	elseif name == "divine_infinite_future_clg" then
		self._divine_infinite_future_clg = content
	end
end

function DivineinfinitefutureclgConfig:getActCfg(activityId)
	return self._divine_infinite_future_clg[activityId]
end

function DivineinfinitefutureclgConfig:getStageCfgs(activityId)
	return self._divine_infinite_future_clg_stage[activityId]
end

function DivineinfinitefutureclgConfig:getStageCfg(activityId, stageId)
	return self._divine_infinite_future_clg_stage[activityId][stageId]
end

function DivineinfinitefutureclgConfig:getSkinId(activityId)
	return self._divine_infinite_future_clg[activityId].skinId
end

function DivineinfinitefutureclgConfig:getGridCfgs(activityId, stageId)
	return self._divine_infinite_future_clg_grid[activityId][stageId]
end

function DivineinfinitefutureclgConfig:getGridCfg(activityId, gridId)
	return self._divine_infinite_future_clg_grid[activityId][gridId]
end

function DivineinfinitefutureclgConfig:getMasterCfg(creepsMasterId)
	return self._divine_infinite_future_clg_creeps_master[creepsMasterId]
end

function DivineinfinitefutureclgConfig:getCreepsCfgs(creepsMasterId)
	return self._divine_infinite_future_clg_creeps[creepsMasterId]
end

DivineinfinitefutureclgConfig.instance = DivineinfinitefutureclgConfig.New()

return DivineinfinitefutureclgConfig
