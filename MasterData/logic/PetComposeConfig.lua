-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcompose/config/PetComposeConfig.lua

module("logic.extensions.petcompose.config.PetComposeConfig", package.seeall)

local PetComposeConfig = class("PetComposeConfig", BaseConfig)

function PetComposeConfig:onInit()
	return
end

function PetComposeConfig:getNames()
	return {
		"pet_rare_compose"
	}
end

function PetComposeConfig:handleConfig(name, content)
	if name == "pet_rare_compose" then
		self._pet_rare_compose_numCfg = content
	end
end

function PetComposeConfig:getNeedPetNumByRare(rare)
	return (self._pet_rare_compose_numCfg[rare] or nil) and (self._pet_rare_compose_numCfg[rare].needNum or 0)
end

function PetComposeConfig:getCostStrByRare(rare)
	return self._pet_rare_compose_numCfg[rare].needExtCost
end

PetComposeConfig.instance = PetComposeConfig.New()

return PetComposeConfig
