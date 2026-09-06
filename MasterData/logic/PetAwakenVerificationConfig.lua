-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petawakenverification/config/PetAwakenVerificationConfig.lua

module("logic.extensions.petawakenverification.config.PetAwakenVerificationConfig", package.seeall)

local PetAwakenVerificationConfig = class("PetAwakenVerificationConfig", BaseConfig)

function PetAwakenVerificationConfig:onInit()
	PetAwakenVerificationConfig.super.onInit(self)
end

function PetAwakenVerificationConfig:getNames()
	return {
		"pet_awaken_verification",
		"pet_awaken_verification_pet",
		"pet_awaken_verification_prize",
		"pet_awaken_verification_goto",
		"pet_awaken_verification_paramDic"
	}
end

function PetAwakenVerificationConfig:handleConfig(name, content)
	if name == "pet_awaken_verification" then
		self._verCfgs = content
	elseif name == "pet_awaken_verification_pet" then
		self._verPetCfgs = content
	elseif name == "pet_awaken_verification_prize" then
		self._verPetPrizeCfgs = content
	elseif name == "pet_awaken_verification_goto" then
		self._verPetGoToCfgs = content
	elseif name == "pet_awaken_verification_paramDic" then
		self._verPetParamDicCfgs = content
	end
end

function PetAwakenVerificationConfig:getPetAwakenVerCfg(actId)
	return self._verCfgs[actId] or {}
end

function PetAwakenVerificationConfig:getPetAwakenVerPetCfgs(actId)
	local verCfg = self:getPetAwakenVerCfg(actId)

	if not verCfg.petPlanId then
		return self._verPetCfgs[verCfg.petPlanId] or {}
	end
end

function PetAwakenVerificationConfig:getPetAwakenVerPetCfgById(actId, id)
	local verCfg = self:getPetAwakenVerCfg(actId)

	if not verCfg.petPlanId then
		if not self._verPetCfgs[verCfg.petPlanId] then
			local verPetCfgs = {}

			return verPetCfgs[id] or {}
		end
	end
end

function PetAwakenVerificationConfig:getPetAwakenVerPrizeCfgs(actId, id)
	local verPetCfg = self:getPetAwakenVerPetCfgById(actId, id)

	if not verPetCfg.prizePlanId then
		return self._verPetPrizeCfgs[verPetCfg.prizePlanId] or {}
	end
end

function PetAwakenVerificationConfig:getPetAwakenVerGoToCfgs(actId)
	local verCfg = self:getPetAwakenVerCfg(actId)

	if not verCfg.goPlanId then
		return self._verPetGoToCfgs[verCfg.goPlanId] or {}
	end
end

function PetAwakenVerificationConfig:getPetAwakenVerParamDicCfgs(key)
	return self._verPetParamDicCfgs[key]
end

PetAwakenVerificationConfig.instance = PetAwakenVerificationConfig.New()

return PetAwakenVerificationConfig
