-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miyachallenge/config/MiyaChallengeConfig.lua

module("logic.extensions.miyachallenge.config.MiyaChallengeConfig", package.seeall)

local MiyaChallengeConfig = class("MiyaChallengeConfig", BaseConfig)

function MiyaChallengeConfig:onInit()
	MiyaChallengeConfig.super.onInit(self)
end

function MiyaChallengeConfig:getNames()
	return {
		"miya_challenge",
		"miya_challenge_tier",
		"miya_challenge_random",
		"miya_challenge_stage",
		"miya_challenge_boss_prize",
		"miya_challenge_master",
		"miya_challenge_creeps",
		"miya_challenge_buff",
		"miya_challenge_num"
	}
end

function MiyaChallengeConfig:handleConfig(name, content)
	if name == "miya_challenge" then
		self._miya_challenge = content
	elseif name == "miya_challenge_tier" then
		self._miya_challenge_tier = content
	elseif name == "miya_challenge_random" then
		self._miya_challenge_random = content
	elseif name == "miya_challenge_stage" then
		self._miya_challenge_stage = content
	elseif name == "miya_challenge_boss_prize" then
		self._miya_challenge_boss_prize = content
	elseif name == "miya_challenge_master" then
		self._miya_challenge_master = content
	elseif name == "miya_challenge_creeps" then
		self._miya_challenge_creeps = content
	elseif name == "miya_challenge_buff" then
		self._miya_challenge_buff = content
	elseif name == "miya_challenge_num" then
		self._miya_challenge_num = content
	end
end

function MiyaChallengeConfig:getActivityCfg(activityId)
	return self._miya_challenge[activityId]
end

function MiyaChallengeConfig:getFirstActivityCfg()
	return self._miya_challenge.dataList[1].activityId
end

function MiyaChallengeConfig:getTierStageCfg(tierPlanId, tierId)
	return self._miya_challenge_tier[tierPlanId][tierId]
end

function MiyaChallengeConfig:getStagesCfg(stagePlanId)
	return self._miya_challenge_stage[stagePlanId]
end

function MiyaChallengeConfig:getStageCfg(stagePlanId, stageId)
	return self._miya_challenge_stage[stagePlanId][stageId]
end

function MiyaChallengeConfig:getBossPrizeCfg(bossPrizePlanId, prizeId)
	return self._miya_challenge_boss_prize[bossPrizePlanId][prizeId]
end

function MiyaChallengeConfig:getBossPrizesCfg(activityId, stagePlanId, stageId)
	self._bossPrizes = self._bossPrizes or {}
	self._bossPrizes[stagePlanId] = self._bossPrizes[stagePlanId] or {}

	if not self._bossPrizes[stagePlanId][stageId] then
		self._bossPrizes[stagePlanId][stageId] = {}

		local actCfg = self:getActivityCfg(activityId)
		local stageCfg = self:getStageCfg(stagePlanId, stageId)

		for i, v in ipairs(stageCfg.prizes) do
			local prizeCfg = self:getBossPrizeCfg(actCfg.bossPrizePlanId, v)

			table.insert(self._bossPrizes[stagePlanId][stageId], {
				damage = stageCfg.damages[i],
				prize = prizeCfg.prize
			})
		end
	end

	return self._bossPrizes[stagePlanId][stageId]
end

function MiyaChallengeConfig:getBuffCfg(buffId)
	return self._miya_challenge_buff[buffId]
end

function MiyaChallengeConfig:getRandomCfg(randomPlanId)
	return self._miya_challenge_random[randomPlanId]
end

function MiyaChallengeConfig:getRandomDay0Cfg(randomPlanId, type)
	return self._miya_challenge_random[randomPlanId][type][0]
end

function MiyaChallengeConfig:getNum(type, id)
	if self._miya_challenge_num[type][id] then
		return self._miya_challenge_num[type][id].num
	else
		return nil
	end
end

function MiyaChallengeConfig:getWindDesc(type, id)
	if self._miya_challenge_num[type][id] then
		return self._miya_challenge_num[type][id].desc
	else
		return nil
	end
end

function MiyaChallengeConfig:getTeamCfg(creepsMasterId)
	return self._miya_challenge_master[creepsMasterId]
end

function MiyaChallengeConfig:getEnemyCreepsCfg(creepsMasterId)
	return self._miya_challenge_creeps[creepsMasterId]
end

MiyaChallengeConfig.instance = MiyaChallengeConfig.New()

return MiyaChallengeConfig
