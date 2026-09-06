-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pettitle/config/PetTitleConfig.lua

module("logic.extensions.pettitle.config.PetTitleConfig", package.seeall)

local PetTitleConfig = class("PetTitleConfig", BaseConfig)

function PetTitleConfig:onInit()
	PetTitleConfig.super.onInit(self)

	self._pet_title = nil
	self._pet_title_common = nil
	self._pet_title_common_client = nil
	self._raceId2PetTitleArray = {}
end

function PetTitleConfig:getNames()
	return {
		"pet_title",
		"pet_title_common",
		"pet_title_common_client"
	}
end

function PetTitleConfig:handleConfig(name, content)
	if name == "pet_title" then
		self._pet_title = content
		self._raceId2PetTitleArray = {}

		for i, v in pairs(self._pet_title) do
			if checknumber(i) > 0 then
				if not self._raceId2PetTitleArray[v.raceId] then
					self._raceId2PetTitleArray[v.raceId] = self._raceId2PetTitleArray[v.raceId]

					table.insert(self._raceId2PetTitleArray[v.raceId], v)
				end
			end
		end
	elseif name == "pet_title_common" then
		self._pet_title_common = content
	elseif name == "pet_title_common_client" then
		self._pet_title_common_client = content
	end
end

function PetTitleConfig:getPetTitleConfig(cfgId)
	return self._pet_title[cfgId]
end

function PetTitleConfig:getPetTitleConfigs()
	local result = {}

	for i, v in pairs(self._pet_title) do
		if checknumber(i) > 0 then
			table.insert(result, v)
		end
	end

	return result
end

function PetTitleConfig:getPetTitleConfigsByRaceId(raceId)
	return self._raceId2PetTitleArray[raceId] or {}
end

function PetTitleConfig:getCommonValue(key, bToNumber)
	if bToNumber then
		return checknumber(self._pet_title_common[key].value)
	else
		return self._pet_title_common[key].value
	end
end

function PetTitleConfig:getClientCommonValue(key, bToNumber)
	if bToNumber then
		return checknumber(self._pet_title_common_client[key].value)
	else
		return self._pet_title_common_client[key].value
	end
end

PetTitleConfig.instance = PetTitleConfig.New()

return PetTitleConfig
