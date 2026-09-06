-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/generalworldprogress/config/GeneralWorldProgressConfig.lua

module("logic.extensions.generalworldprogress.config.GeneralWorldProgressConfig", package.seeall)

local GeneralWorldProgressConfig = class("GeneralWorldProgressConfig", BaseConfig)

function GeneralWorldProgressConfig:onInit()
	GeneralWorldProgressConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function GeneralWorldProgressConfig:getNames()
	return {
		"general_world_progress_prize",
		"general_world_progress_activity"
	}
end

function GeneralWorldProgressConfig:handleConfig(name, content)
	if name == "general_world_progress_activity" then
		self._actCfgs = content
	elseif name == "general_world_progress_prize" then
		self._prizeCfgs = content
	end
end

function GeneralWorldProgressConfig:getActCfgById(actId)
	return self._actCfgs[actId]
end

function GeneralWorldProgressConfig:getprizeCfgsByPlanId(planId)
	return self._prizeCfgs[planId]
end

GeneralWorldProgressConfig.instance = GeneralWorldProgressConfig.New()

return GeneralWorldProgressConfig
