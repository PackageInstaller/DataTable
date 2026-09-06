-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/challenge/config/ChallengeConfig.lua

module("logic.extensions.challenge.config.ChallengeConfig", package.seeall)

local ChallengeConfig = class("ChallengeConfig", BaseConfig)

function ChallengeConfig:onInit()
	ChallengeConfig.super.onInit(self)

	self._missionCfg = nil
	self._creepCfg = nil
	self._challengeCfg = nil
	self._challengemsnCfg = nil
	self._challengesmCfg = nil
	self._challengeKV = nil
end

function ChallengeConfig:getNames()
	return {
		"fight_monster",
		"fight_creeps",
		"challenge_c",
		"challengemission",
		"challengesubmission",
		"challenge_key_value",
		"challenge"
	}
end

function ChallengeConfig:handleConfig(name, content)
	if name == "fight_monster" then
		self._missionCfg = content
	elseif name == "fight_creeps" then
		self._creepCfg = content
	elseif name == "challenge_c" then
		self._challengeCfg = content
	elseif name == "challengemission" then
		self._challengemsnCfg = content
	elseif name == "challengesubmission" then
		self._challengesmCfg = content
	elseif name == "challenge_key_value" then
		self._challengeKV = content
	elseif name == "challenge" then
		self._challenges = content
	end
end

function ChallengeConfig:getChallenge(id)
	return self._challenges[id]
end

function ChallengeConfig:getMissionCfg(id)
	return self._missionCfg[id]
end

function ChallengeConfig:getCreepCfg(id)
	return self._creepCfg[id]
end

function ChallengeConfig:getChallengeCfg(id)
	return self._challengeCfg[id]
end

function ChallengeConfig:getChallengeCfgByRaceId(raceId)
	for k, v in pairs(self._challengeCfg) do
		if v.getRaceIds and v.getRaceIds[1] == raceId then
			return v
		end
	end

	return nil
end

function ChallengeConfig:getAllKingRoadIds()
	if self._challengeCfg then
		local kindRoadIds = {}

		for k, v in pairs(self._challengeCfg) do
			if type(k) == "number" then
				table.insert(kindRoadIds, k)
			end
		end

		return kindRoadIds
	end
end

function ChallengeConfig:getAllChallengeCfg()
	return self._challengeCfg
end

function ChallengeConfig:getAllKingRoadSubMissionCfgs()
	return self._challengemsnCfg
end

function ChallengeConfig:getChallengeMissionCfg(id, phase, branch)
	return self._challengemsnCfg[id][phase][branch]
end

function ChallengeConfig:getChallengeSubMissionCfg(id)
	return self._challengesmCfg[id]
end

function ChallengeConfig:getChallengemission(id)
	return self._challengemsnCfg[id]
end

function ChallengeConfig:getChallengeKV(challengeId, subId)
	if self._challengeKV[challengeId] then
		return self._challengeKV[challengeId][subId]
	end

	return nil
end

ChallengeConfig.instance = ChallengeConfig.New()

return ChallengeConfig
