-- chunkname: @modules/logic/pcInput/config/pcInputConfig.lua

module("modules.logic.pcInput.config.pcInputConfig", package.seeall)

local pcInputConfig = class("pcInputConfig", BaseConfig)

function pcInputConfig:reqConfigNames()
	return {
		"key_binding",
		"key_block",
		"key_name_replace"
	}
end

function pcInputConfig:onConfigLoaded(configName, configTable)
	if configName == "key_binding" then
		self.key_binding = configTable
	end

	if configName == "key_block" then
		self.key_block = configTable
	end

	if configName == "key_name_replace" then
		self.key_name_replace = configTable
	end
end

function pcInputConfig:getKeyBinding()
	return self.key_binding.configDict
end

function pcInputConfig:getKeyBlock()
	return self.key_block.configDict
end

function pcInputConfig:getKeyNameReplace()
	return self.key_name_replace.configDict
end

pcInputConfig.instance = pcInputConfig.New()

return pcInputConfig
