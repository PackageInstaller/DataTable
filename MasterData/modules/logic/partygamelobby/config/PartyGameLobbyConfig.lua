-- chunkname: @modules/logic/partygamelobby/config/PartyGameLobbyConfig.lua

module("modules.logic.partygamelobby.config.PartyGameLobbyConfig", package.seeall)

local PartyGameLobbyConfig = class("PartyGameLobbyConfig", BaseConfig)

function PartyGameLobbyConfig:reqConfigNames()
	return {
		"party_building",
		"partygame_param"
	}
end

function PartyGameLobbyConfig:onInit()
	return
end

function PartyGameLobbyConfig:onConfigLoaded(configName, configTable)
	return
end

PartyGameLobbyConfig.instance = PartyGameLobbyConfig.New()

return PartyGameLobbyConfig
