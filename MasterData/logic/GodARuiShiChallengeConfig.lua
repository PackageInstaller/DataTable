-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godaruishichallenge/config/GodARuiShiChallengeConfig.lua

module("logic.extensions.godaruishichallenge.config.GodARuiShiChallengeConfig", package.seeall)

local GodARuiShiChallengeConfig = class("GodARuiShiChallengeConfig", BaseConfig)

function GodARuiShiChallengeConfig:onInit()
	GodARuiShiChallengeConfig.super.onInit(self)

	self.god_aruishi_challenge_info = nil
end

function GodARuiShiChallengeConfig:getNames()
	return {
		"god_aruishi_challenge_info",
		"god_aruishi_challenge_boss",
		"god_aruishi_challenge_boss_score",
		"god_aruishi_challenge_stage",
		"god_aruishi_challenge_support",
		"god_aruishi_challenge_team",
		"god_aruishi_challenge_creeps",
		"god_aruishi_challenge_enemy_bubble",
		"god_aruishi_challenge_my_bubble",
		"god_aruishi_challenge_stage_type",
		"god_aruishi_challenge_rule"
	}
end

function GodARuiShiChallengeConfig:handleConfig(name, content)
	if name == "god_aruishi_challenge_info" then
		self._god_aruishi_challenge_info = content
	elseif name == "god_aruishi_challenge_boss" then
		self._god_aruishi_challenge_boss = content
	elseif name == "god_aruishi_challenge_boss_score" then
		self._god_aruishi_challenge_boss_score = content
	elseif name == "god_aruishi_challenge_stage" then
		self._god_aruishi_challenge_stage = content
	elseif name == "god_aruishi_challenge_support" then
		self._god_aruishi_challenge_support = content
	elseif name == "god_aruishi_challenge_team" then
		self._god_aruishi_challenge_team = content
	elseif name == "god_aruishi_challenge_creeps" then
		self._god_aruishi_challenge_creeps = content
	elseif name == "god_aruishi_challenge_enemy_bubble" then
		self._god_aruishi_challenge_enemy_bubble = content
	elseif name == "god_aruishi_challenge_my_bubble" then
		self._god_aruishi_challenge_my_bubble = content
	elseif name == "god_aruishi_challenge_stage_type" then
		self._god_aruishi_challenge_stage_type = content
	elseif name == "god_aruishi_challenge_rule" then
		self._god_aruishi_challenge_rule = content
	end
end

function GodARuiShiChallengeConfig:getChallengeEvolveChallengeId()
	return self._god_aruishi_challenge_info.dataList[1].challengeId
end

function GodARuiShiChallengeConfig:getChallengeExtChallengeId()
	return self._god_aruishi_challenge_info.dataList[2].challengeId
end

function GodARuiShiChallengeConfig:getChallengeBossTimes(challengeId)
	return self._god_aruishi_challenge_info[challengeId].challengeBossTimes
end

function GodARuiShiChallengeConfig:getChallengeMaxWave(challengeId)
	return self._god_aruishi_challenge_info[challengeId].waveNum
end

function GodARuiShiChallengeConfig:getGlyData(challengeId)
	return self._god_aruishi_challenge_info[challengeId]
end

function GodARuiShiChallengeConfig:getCreeps(creepsMasterId)
	return self._god_aruishi_challenge_creeps[creepsMasterId]
end

function GodARuiShiChallengeConfig:getTeam(creepsMasterId)
	return self._god_aruishi_challenge_team[creepsMasterId]
end

function GodARuiShiChallengeConfig:getSupportCfg(creepsId)
	return self._god_aruishi_challenge_support[creepsId]
end

function GodARuiShiChallengeConfig:getBossInfo(challengeId, bossId)
	return self._god_aruishi_challenge_boss[challengeId][bossId]
end

function GodARuiShiChallengeConfig:getBossCreeps(challengeId, bossId)
	return self:getCreeps(self._god_aruishi_challenge_boss[challengeId][bossId].bossCreepsMasterId)
end

function GodARuiShiChallengeConfig:getStageInfo(challengeId, stageId)
	return self._god_aruishi_challenge_stage[challengeId][stageId]
end

function GodARuiShiChallengeConfig:getRandomEnemyBubble()
	return self._god_aruishi_challenge_enemy_bubble[math.random(1, #self._god_aruishi_challenge_enemy_bubble.dataList)].desc
end

function GodARuiShiChallengeConfig:getRandomMyBubble(num)
	local randomNum = 1

	if #self._god_aruishi_challenge_my_bubble.dataList == 1 then
		return self._god_aruishi_challenge_my_bubble[randomNum].desc, randomNum
	end

	randomNum = math.random(1, #self._god_aruishi_challenge_my_bubble.dataList - 1)

	if randomNum < num then
		return self._god_aruishi_challenge_my_bubble[randomNum].desc, randomNum
	else
		return self._god_aruishi_challenge_my_bubble[randomNum + 1].desc, randomNum + 1
	end

	return self._god_aruishi_challenge_my_bubble[randomNum].desc, randomNum
end

function GodARuiShiChallengeConfig:getScoreCfg(challengeId, bossId)
	return self._god_aruishi_challenge_boss_score[challengeId][bossId]
end

function GodARuiShiChallengeConfig:getStageScore(challengeId, stageId)
	return self._god_aruishi_challenge_stage.dataList[1].score
end

function GodARuiShiChallengeConfig:getStageFirstPrize(challengeId)
	local cfg = self._god_aruishi_challenge_stage[challengeId][1]

	if cfg.prize then
		local prizeParams = string.split(cfg.prize, "#")

		return prizeParams[1]
	end
end

function GodARuiShiChallengeConfig:getStageTypeInfo(stageId)
	return self._god_aruishi_challenge_stage_type[stageId]
end

function GodARuiShiChallengeConfig:getRuleList(ruleId)
	return self._god_aruishi_challenge_rule[ruleId]
end

GodARuiShiChallengeConfig.instance = GodARuiShiChallengeConfig.New()

return GodARuiShiChallengeConfig
