-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petstrategy/config/PetStrategyConfig.lua

module("logic.extensions.petstrategy.config.PetStrategyConfig", package.seeall)

local PetStrategyConfig = class("PetStrategyConfig", BaseConfig)

PetStrategyConfig.LEFTBTN = "leftBtn"
PetStrategyConfig.RIGHTBTN = "rightBtn"
PetStrategyConfig.UPDATE = "update"

function PetStrategyConfig:onInit()
	PetStrategyConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function PetStrategyConfig:getNames()
	return {
		"pet_strategy"
	}
end

function PetStrategyConfig:handleConfig(name, content)
	if name == "pet_strategy" then
		self._petStrategy = content
	end
end

function PetStrategyConfig:getStrategyById(id)
	return self._petStrategy[id]
end

PetStrategyConfig.instance = PetStrategyConfig.New()

return PetStrategyConfig
