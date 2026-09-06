-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yishichallenge/config/YishiChallengeConfig.lua

module("logic.extensions.yishichallenge.config.YishiChallengeConfig", package.seeall)

local YishiChallengeConfig = class("YishiChallengeConfig", BaseConfig)

function YishiChallengeConfig:onInit()
	YishiChallengeConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function YishiChallengeConfig:getNames()
	return {
		"yishi_challenge_common",
		"yishi_challenge",
		"yishi_challenge_team",
		"yishi_challenge_creeps",
		"yishi_challenge_element",
		"yishi_challenge_sign_in_buff"
	}
end

function YishiChallengeConfig:handleConfig(name, content)
	if name == "yishi_challenge_common" then
		self._yishi_challenge_common = content
	elseif name == "yishi_challenge" then
		self._yishi_challenge = content
	elseif name == "yishi_challenge_team" then
		self._yishi_challenge_team = content
	elseif name == "yishi_challenge_creeps" then
		self._yishi_challenge_creeps = content
	elseif name == "yishi_challenge_element" then
		self._yishi_challenge_element = content
	elseif name == "yishi_challenge_sign_in_buff" then
		self._yishi_challenge_sign_in_buff = content
	end
end

function YishiChallengeConfig:getCfgById(id)
	return self._yishi_challenge_common[id]
end

function YishiChallengeConfig:getChallengeCfgById(id)
	return self._yishi_challenge[id]
end

function YishiChallengeConfig:getChallengeTeamCfgById(id)
	return self._yishi_challenge_team[id]
end

function YishiChallengeConfig:getChallengeCreepsCfgById(id)
	return self._yishi_challenge_creeps[id]
end

function YishiChallengeConfig:getPetPos(id)
	local cfg = self:getCfgById(id)

	if cfg and cfg.pos then
		return cfg.pos
	end

	return {
		0,
		0,
		0
	}
end

function YishiChallengeConfig:getBuffCfgs(challengeId)
	return self._yishi_challenge_sign_in_buff[challengeId]
end

function YishiChallengeConfig:getBuffCfg(challengeId, lv)
	if self._yishi_challenge_sign_in_buff[challengeId] then
		return self._yishi_challenge_sign_in_buff[challengeId][lv]
	end
end

YishiChallengeConfig.instance = YishiChallengeConfig.New()

return YishiChallengeConfig
