-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pethire/config/PetHireConfig.lua

module("logic.extensions.pethire.config.PetHireConfig", package.seeall)

local PetHireConfig = class("PetHireConfig", BaseConfig)

function PetHireConfig:onInit()
	PetHireConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function PetHireConfig:getNames()
	return {
		"pet_hire_pet"
	}
end

function PetHireConfig:handleConfig(name, content)
	if name == "pet_hire_pet" then
		self._pet_hire_petCfg = content
	end
end

function PetHireConfig:getHirePetCfgById(id)
	return self._pet_hire_petCfg[id]
end

function PetHireConfig:getAllHirePetCfgs()
	return self._pet_hire_petCfg.dataList
end

PetHireConfig.instance = PetHireConfig.New()

return PetHireConfig
