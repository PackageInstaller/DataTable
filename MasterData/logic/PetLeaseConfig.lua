-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petlease/config/PetLeaseConfig.lua

module("logic.extensions.petlease.config.PetLeaseConfig", package.seeall)

local PetLeaseConfig = class("PetLeaseConfig", BaseConfig)

function PetLeaseConfig:onInit()
	PetLeaseConfig.super.onInit(self)

	self._useInfoCfgs = nil
	self._commonCfgs = nil
end

function PetLeaseConfig:getNames()
	return {
		"pet_lease_use_times",
		"pet_lease_params"
	}
end

function PetLeaseConfig:handleConfig(name, content)
	if name == "pet_lease_use_times" then
		self._useInfoCfgs = content
	elseif name == "pet_lease_params" then
		self._commonCfgs = {
			rentPosCount = 1,
			hirePosCount = 1,
			hireDay = 1
		}

		if content.MAX_RENT_SLOT_NUM then
			self._commonCfgs.hirePosCount = tonumber(content.MAX_RENT_SLOT_NUM.value)
		end

		if content.MAX_LEASE_SLOT_NUM then
			self._commonCfgs.rentPosCount = tonumber(content.MAX_LEASE_SLOT_NUM.value)
		end

		if content.RENT_DAYS then
			self._commonCfgs.hireDay = tonumber(content.RENT_DAYS.value)
		end

		if content.RENT_PET_ZDL_LIMIT_FACTOR then
			self._commonCfgs.maxHirePower = tonumber(content.RENT_PET_ZDL_LIMIT_FACTOR.value)
		end
	end
end

function PetLeaseConfig:GetUseInfoCfg(leaseType)
	if checknumber(leaseType) <= 0 then
		return self._useInfoCfgs
	end

	return self._useInfoCfgs[leaseType]
end

function PetLeaseConfig:getHireCfg(leaseType)
	return self._useInfoCfgs[leaseType]
end

function PetLeaseConfig:GetCommonCfgs()
	return self._commonCfgs
end

function PetLeaseConfig:GetMaxHirePower()
	if self._commonCfgs == nil or checknumber(self._commonCfgs.maxHirePower) <= 0 then
		return 12000
	end

	return self._commonCfgs.maxHirePower
end

PetLeaseConfig.instance = PetLeaseConfig.New()

return PetLeaseConfig
