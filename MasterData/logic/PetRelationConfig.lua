-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petrelation/config/PetRelationConfig.lua

module("logic.extensions.petrelation.config.PetRelationConfig", package.seeall)

local PetRelationConfig = class("PetRelationConfig", BaseConfig)

function PetRelationConfig:onInit()
	PetRelationConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function PetRelationConfig:getNames()
	return {
		"pet_relation_group_prize",
		"pet_relation_seat",
		"pet_relation_line",
		"pet_relation_common",
		"pet_relation_poster"
	}
end

function PetRelationConfig:handleConfig(name, content)
	if name == "pet_relation_group_prize" then
		self._groupPrize = content
	elseif name == "pet_relation_seat" then
		self._seat = content
	elseif name == "pet_relation_line" then
		local _line = {}

		for k, v in pairs(content) do
			if v.raceId then
				v.scale = tonumber(v.scale)

				if v.raceId ~= "User" then
					v.raceId = tonumber(v.raceId)
				end

				if v.linkRaceId then
					for j, raceId in ipairs(v.linkRaceId) do
						if raceId ~= "User" then
							v.linkRaceId[j] = tonumber(raceId)
						end
					end
				end

				_line[v.id] = v
			end
		end

		self._line = _line
	elseif name == "pet_relation_common" then
		self._common = content
	elseif name == "pet_relation_poster" then
		self._poster = content
	end
end

function PetRelationConfig:getGroupPrize()
	return self._groupPrize
end

function PetRelationConfig:getGroupPrizeById(id)
	return self._groupPrize[id]
end

function PetRelationConfig:getSeat()
	return self._seat
end

function PetRelationConfig:getLine()
	return self._line
end

function PetRelationConfig:getCommonValue(key)
	return self._common[key].value
end

function PetRelationConfig:getPosterByType(type)
	if self._poster[type] then
		return self._poster[type].ids
	end
end

PetRelationConfig.instance = PetRelationConfig.New()

return PetRelationConfig
