-- chunkname: @modules/logic/versionactivity1_9/matildagift/config/V1a9_MatildaGiftConfig.lua

module("modules.logic.versionactivity1_9.matildagift.config.V1a9_MatildaGiftConfig", package.seeall)

local V1a9_MatildaGiftConfig = class("V1a9_MatildaGiftConfig", BaseConfig)

function V1a9_MatildaGiftConfig:reqConfigNames()
	return nil
end

function V1a9_MatildaGiftConfig:onInit()
	return
end

function V1a9_MatildaGiftConfig:onConfigLoaded(configName, configTable)
	return
end

V1a9_MatildaGiftConfig.instance = V1a9_MatildaGiftConfig.New()

return V1a9_MatildaGiftConfig
