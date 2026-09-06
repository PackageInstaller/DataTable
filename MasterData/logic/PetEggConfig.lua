-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petegg/config/PetEggConfig.lua

module("logic.extensions.petegg.config.PetEggConfig", package.seeall)

local PetEggConfig = class("PetEggConfig", BaseConfig)

function PetEggConfig:onInit()
	PetEggConfig.super.onInit(self)

	self._peteggCfg = nil
end

function PetEggConfig:getNames()
	return {
		"petegg"
	}
end

function PetEggConfig:handleConfig(name, content)
	if name == "petegg" then
		self._peteggCfg = content

		self:_handlePets()
	end
end

function PetEggConfig:_handlePets()
	for k, v in pairs(self._peteggCfg) do
		if type(k) == "number" then
			local jobStrs = string.split(v.job, ",")

			v.job = jobStrs[1]

			if jobStrs[2] and #jobStrs[2] > 0 then
				v.secondary_job = jobStrs[2]
			end
		end
	end
end

function PetEggConfig:getCfgById(id)
	return self._peteggCfg[id]
end

function PetEggConfig:getCfgs()
	return self._peteggCfg
end

PetEggConfig.instance = PetEggConfig.New()

return PetEggConfig
