-- chunkname: @modules/logic/backpack/config/BackpackConfig.lua

module("modules.logic.backpack.config.BackpackConfig", package.seeall)

local BackpackConfig = class("BackpackConfig", BaseConfig)

function BackpackConfig:ctor()
	self._tabConfig = nil
	self._subclassConfig = nil
end

function BackpackConfig:reqConfigNames()
	return {
		"backpack",
		"subclass_priority"
	}
end

function BackpackConfig:onConfigLoaded(configName, configTable)
	if configName == "backpack" then
		self._tabConfig = configTable
	elseif configName == "subclass_priority" then
		self._subclassConfig = configTable
	end
end

function BackpackConfig:getCategoryCO()
	return self._tabConfig.configDict
end

function BackpackConfig:getCategoryList()
	return self._tabConfig.configList
end

function BackpackConfig:getSubclassCo()
	return self._subclassConfig.configDict
end

BackpackConfig.instance = BackpackConfig.New()

return BackpackConfig
