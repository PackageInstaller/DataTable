-- chunkname: @modules/logic/help/config/HelpConfig.lua

module("modules.logic.help.config.HelpConfig", package.seeall)

local HelpConfig = class("HelpConfig", BaseConfig)

function HelpConfig:ctor()
	self._helpConfig = nil
	self._pageConfig = nil
	self._helpPageTabConfig = nil
	self._helpVideoConfig = nil
end

function HelpConfig:reqConfigNames()
	return {
		"viewhelp",
		"helppage",
		"help_page_tab",
		"help_video"
	}
end

function HelpConfig:onConfigLoaded(configName, configTable)
	if configName == "viewhelp" then
		self._helpConfig = configTable
	elseif configName == "helppage" then
		self._pageConfig = configTable
	elseif configName == "help_page_tab" then
		self._helpPageTabConfig = configTable
	elseif configName == "help_video" then
		self._helpVideoConfig = configTable
	end
end

function HelpConfig:getHelpCO(id)
	return self._helpConfig.configDict[id]
end

function HelpConfig:getHelpPageCo(id)
	return self._pageConfig.configDict[id]
end

function HelpConfig:getHelpPageTabList()
	return self._helpPageTabConfig.configList
end

function HelpConfig:getHelpPageTabCO(id)
	return self._helpPageTabConfig.configDict[id]
end

function HelpConfig:getHelpVideoCO(id)
	return self._helpVideoConfig.configDict[id]
end

HelpConfig.instance = HelpConfig.New()

return HelpConfig
