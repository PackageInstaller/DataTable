-- chunkname: @modules/logic/survival/config/SurvivalHandbookConfig.lua

module("modules.logic.survival.config.SurvivalHandbookConfig", package.seeall)

local SurvivalHandbookConfig = class("SurvivalHandbookConfig", BaseConfig)

function SurvivalHandbookConfig:ctor()
	return
end

function SurvivalHandbookConfig:reqConfigNames()
	return {
		"survival_handbook",
		"survival_equip"
	}
end

function SurvivalHandbookConfig:onConfigLoaded(configName, configTable)
	if configName == "survival_handbook" then
		-- block empty
	end
end

function SurvivalHandbookConfig:getConfigList()
	return lua_survival_handbook.configList
end

SurvivalHandbookConfig.instance = SurvivalHandbookConfig.New()

return SurvivalHandbookConfig
