-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalchallenge/config/EternalChallengeConfig.lua

module("logic.extensions.eternalchallenge.config.EternalChallengeConfig", package.seeall)

local EternalChallengeConfig = class("EternalChallengeConfig", BaseConfig)

function EternalChallengeConfig:onInit()
	EternalChallengeConfig.super.onInit(self)
end

function EternalChallengeConfig:getNames()
	return {
		"eternal_challenge_activity",
		"eternal_challenge_pet",
		"eternal_challenge_pet_creeps",
		"eternal_challenge_buff",
		"eternal_challenge_master",
		"eternal_challenge_creeps",
		"eternal_challenge_client_common"
	}
end

function EternalChallengeConfig:handleConfig(name, content)
	if name == "eternal_challenge_activity" then
		self._ecActCfg = content
	elseif name == "eternal_challenge_pet" then
		self._ecPetCfg = content
	elseif name == "eternal_challenge_pet_creeps" then
		self._ecPetCreepsCfg = content
	elseif name == "eternal_challenge_buff" then
		self._ecBuffCfg = content
	elseif name == "eternal_challenge_master" then
		self._ecMasterCfg = content
	elseif name == "eternal_challenge_creeps" then
		self._ecCreepsCfg = content
	elseif name == "eternal_challenge_client_common" then
		self._clientCommonCfg = content
	end
end

function EternalChallengeConfig:getEcActData(activityId)
	return self._ecActCfg[activityId]
end

function EternalChallengeConfig:getEcPetDataLists(activityId)
	return self._ecPetCfg[activityId]
end

function EternalChallengeConfig:getEcPetDataList(activityId, raceId)
	return self._ecPetCfg[activityId][raceId]
end

function EternalChallengeConfig:getEcPetData(activityId, raceId, level)
	return self._ecPetCfg[activityId][raceId][level]
end

function EternalChallengeConfig:getEcPetCreepsData(creepsId)
	return self._ecPetCreepsCfg[creepsId]
end

function EternalChallengeConfig:getEcBuffDataLists(activityId)
	return self._ecBuffCfg[activityId]
end

function EternalChallengeConfig:getEcBuffDataList(activityId, buffId)
	return self._ecBuffCfg[activityId][buffId]
end

function EternalChallengeConfig:getEcBuffData(activityId, buffId, level)
	return self._ecBuffCfg[activityId][buffId][level]
end

function EternalChallengeConfig:getEcMasterData(creepsMasterId)
	return self._ecMasterCfg[creepsMasterId]
end

function EternalChallengeConfig:getECreepsDataList(creepsMasterId)
	return self._ecCreepsCfg[creepsMasterId]
end

function EternalChallengeConfig:getEcCreepsData(creepsMasterId, creepsId)
	return self._ecCreepsCfg[creepsMasterId][creepsId]
end

function EternalChallengeConfig:getEcClientCommonValue(activityId, key, isToNumber)
	local baseData = self:getEcActData(activityId)

	if baseData then
		if not baseData.comPlanId then
			local comPlanId = 0

			if self._clientCommonCfg[comPlanId] then
				local data = self._clientCommonCfg[comPlanId][key]
				local value

				if data then
					value = data.value

					if isToNumber then
						value = checknumber(value)
					end
				end

				return value
			end
		end
	end
end

EternalChallengeConfig.instance = EternalChallengeConfig.New()

return EternalChallengeConfig
