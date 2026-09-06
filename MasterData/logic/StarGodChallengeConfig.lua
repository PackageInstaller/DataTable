-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargodchallenge/config/StarGodChallengeConfig.lua

module("logic.extensions.stargodchallenge.config.StarGodChallengeConfig", package.seeall)

local StarGodChallengeConfig = class("StarGodChallengeConfig", BaseConfig)

function StarGodChallengeConfig:onInit()
	StarGodChallengeConfig.super.onInit(self)

	self.star_god_challenge = nil
	self.star_god_challenge_master = nil
	self.star_god_challenge_creeps = nil
	self.star_god_challenge_params = nil
end

function StarGodChallengeConfig:getNames()
	return {
		"star_god_challenge",
		"star_god_challenge_master",
		"star_god_challenge_creeps",
		"star_god_challenge_params"
	}
end

function StarGodChallengeConfig:handleConfig(name, content)
	if name == "star_god_challenge" then
		self.star_god_challenge = content
	elseif name == "star_god_challenge_master" then
		self.star_god_challenge_master = content
	elseif name == "star_god_challenge_creeps" then
		self.star_god_challenge_creeps = content
	elseif name == "star_god_challenge_params" then
		self.star_god_challenge_params = content
	end
end

function StarGodChallengeConfig:getChallengeCfgList()
	return self.star_god_challenge.dataList
end

function StarGodChallengeConfig:getChallengeCfg(id)
	return self.star_god_challenge[id]
end

function StarGodChallengeConfig:getChallengeCfgByGroupId(groupId)
	for i, v in ipairs(self.star_god_challenge.dataList) do
		if v.groupId == groupId then
			return v
		end
	end
end

function StarGodChallengeConfig:getMasterCfg(creepsMasterId)
	return self.star_god_challenge_master[creepsMasterId]
end

function StarGodChallengeConfig:getCreepsCfg(creepsMasterId)
	return self.star_god_challenge_creeps[creepsMasterId]
end

function StarGodChallengeConfig:getConstValue(key)
	if self.star_god_challenge_params[key] then
		return self.star_god_challenge_params[key].value
	end
end

StarGodChallengeConfig.instance = StarGodChallengeConfig.New()

return StarGodChallengeConfig
