-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/party/config/PartyConfig.lua

module("logic.extensions.party.config.PartyConfig", package.seeall)

local PartyConfig = class("PartyConfig", BaseConfig)

function PartyConfig:onInit()
	PartyConfig.super.onInit(self)
end

function PartyConfig:getNames()
	return {
		"party"
	}
end

function PartyConfig:handleConfig(name, content)
	if name == "party" then
		self._actCfgs = content
	end
end

function PartyConfig:getActsfgByActId(actId)
	return self._actCfgs[actId]
end

PartyConfig.instance = PartyConfig.New()

return PartyConfig
