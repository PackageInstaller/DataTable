-- chunkname: @modules/logic/versionactivity3_8/echosong/config/V3a8EchoSongConfig.lua

module("modules.logic.versionactivity3_8.echosong.config.V3a8EchoSongConfig", package.seeall)

local V3a8EchoSongConfig = class("V3a8EchoSongConfig", BaseConfig)

function V3a8EchoSongConfig:reqConfigNames()
	return nil
end

function V3a8EchoSongConfig:onInit()
	return
end

function V3a8EchoSongConfig:onConfigLoaded(configName, configTable)
	return
end

V3a8EchoSongConfig.instance = V3a8EchoSongConfig.New()

return V3a8EchoSongConfig
