-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dodragonchallenge/config/DoDragonChallengeConfig.lua

module("logic.extensions.dodragonchallenge.config.DoDragonChallengeConfig", package.seeall)

local DoDragonChallengeConfig = class("DoDragonChallengeConfig", BaseConfig)

function DoDragonChallengeConfig:onInit()
	DoDragonChallengeConfig.super.onInit(self)
end

function DoDragonChallengeConfig:getNames()
	return {
		"disorder_dragon_challenge",
		"disorder_dragon_challenge_common",
		"disorder_dragon_challenge_all",
		"disorder_dragon_challenge_extreme",
		"disorder_dragon_challenge_exchange",
		"disorder_dragon_challenge_master",
		"disorder_dragon_challenge_creeps",
		"disorder_dragon_challenge_buff"
	}
end

function DoDragonChallengeConfig:handleConfig(name, content)
	if name == "disorder_dragon_challenge" then
		self._ddCfg = content
	elseif name == "disorder_dragon_challenge_common" then
		self._ddCommonCfg = content
	elseif name == "disorder_dragon_challenge_all" then
		self._ddAllCfgs = content
	elseif name == "disorder_dragon_challenge_extreme" then
		self._ddExtremeCfg = content
	elseif name == "disorder_dragon_challenge_exchange" then
		self._ddExchangeCfgs = content
	elseif name == "disorder_dragon_challenge_master" then
		self._ddMasterCfg = content
	elseif name == "disorder_dragon_challenge_creeps" then
		self._ddCreepsCfgs = content
	elseif name == "disorder_dragon_challenge_buff" then
		self._ddBuffCfg = content
	end
end

function DoDragonChallengeConfig:getDdData(activityId)
	return self._ddCfg[activityId]
end

function DoDragonChallengeConfig:getTotalFireNum(activityId)
	return self:getDdData(activityId).allFire
end

function DoDragonChallengeConfig:getTotalChallengeTimes(activityId)
	return self:getDdData(activityId).extremeTime
end

function DoDragonChallengeConfig:getAllPrize(activityId)
	return self:getDdData(activityId).allPrize
end

function DoDragonChallengeConfig:getDdCommonValue(key, isToNumber)
	local data = self._ddCommonCfg[key]
	local value = data and data.value

	return isToNumber and checknumber(value) or value
end

function DoDragonChallengeConfig:getDdAllCfg(activityId)
	local ddData = self:getDdData(activityId)

	return self._ddAllCfgs[ddData.allPlanId]
end

function DoDragonChallengeConfig:getDdAllData(activityId, challengeId)
	return self:getDdAllCfg(activityId)[challengeId]
end

function DoDragonChallengeConfig:getDdExtremeData(activityId)
	local ddData = self:getDdData(activityId)

	return self._ddExtremeCfg[ddData.extremeId]
end

function DoDragonChallengeConfig:getDdExchangeCfg(activityId)
	local ddData = self:getDdData(activityId)

	return self._ddExchangeCfgs[ddData.extremeChangePlan]
end

function DoDragonChallengeConfig:getDdExchangeData(activityId, exchangeId)
	return self:getDdExchangeCfg(activityId)[exchangeId]
end

function DoDragonChallengeConfig:getDdExchangeId(activityId, hp)
	local exchangeId = 0
	local cfg = self:getDdExchangeCfg(activityId)

	if cfg then
		for _, data in ipairs(cfg) do
			if hp >= data.condition[1] and hp <= data.condition[2] then
				exchangeId = data.exchangeId

				break
			end
		end
	end

	return exchangeId
end

function DoDragonChallengeConfig:getDdMasterData(creepsMasterId)
	return self._ddMasterCfg[creepsMasterId]
end

function DoDragonChallengeConfig:getDdCreepsCfg(creepsMasterId)
	return self._ddCreepsCfgs[creepsMasterId]
end

function DoDragonChallengeConfig:getDdCreepsData(creepsMasterId, creepsId)
	return self._ddCreepsCfgs[creepsMasterId][creepsId]
end

function DoDragonChallengeConfig:getDdBuffData(buffId)
	return self._ddBuffCfg[buffId]
end

DoDragonChallengeConfig.instance = DoDragonChallengeConfig.New()

return DoDragonChallengeConfig
