-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/config/TimedPointRaceModeConfig.lua

module("logic.extensions.timelimitedchallenge.config.TimedPointRaceModeConfig", package.seeall)

local TimedPointRaceModeConfig = class("TimedPointRaceModeConfig", BaseConfig)

function TimedPointRaceModeConfig:onInit()
	TimedPointRaceModeConfig.super.onInit(self)

	self._commonCfgs = nil
	self._buffChanllengeCfgs = nil
	self._buffEnterTypes = nil
	self._scorePlanCfgs = nil
	self._buffCfgs = nil
	self._prizeCfgs = nil
	self._creepCfgs = nil
	self._monsterCfgs = nil
end

function TimedPointRaceModeConfig:getNames()
	return {
		"timed_challenge_ranking_score",
		"timed_challenge_ranking_score_buff_progress",
		"timed_challenge_ranking_score_plan",
		"timed_challenge_ranking_score_buff",
		"timed_challenge_ranking_score_prize",
		"timed_challenge_ranking_score_monster",
		"timed_challenge_ranking_score_creeps"
	}
end

function TimedPointRaceModeConfig:handleConfig(name, content)
	if name == "timed_challenge_ranking_score" then
		self._commonCfgs = content
	elseif name == "timed_challenge_ranking_score_buff_progress" then
		self._buffChanllengeCfgs = content
		self._buffEnterTypes = {}

		for _, v in ipairs(content.dataList) do
			self._buffEnterTypes[v.challengeId] = self._buffEnterTypes[v.challengeId] or {}
			self._buffEnterTypes[v.challengeId][v.enterViewType] = self._buffEnterTypes[v.challengeId][v.enterViewType] or {}
			self._buffEnterTypes[v.challengeId][v.enterViewType][v.buffType] = true
		end
	elseif name == "timed_challenge_ranking_score_plan" then
		self._scorePlanCfgs = content
	elseif name == "timed_challenge_ranking_score_buff" then
		self._buffCfgs = content
	elseif name == "timed_challenge_ranking_score_prize" then
		self._prizeCfgs = content
	elseif name == "timed_challenge_ranking_score_monster" then
		self._creepCfgs = content
	elseif name == "timed_challenge_ranking_score_creeps" then
		self._monsterCfgs = content
	end
end

function TimedPointRaceModeConfig:getCommonCfg(challengeId)
	return self._commonCfgs[challengeId]
end

function TimedPointRaceModeConfig:getBuffChallengeCfgs(challengeId, buffType, buffLv)
	local buffTypes = challengeId and self._buffChanllengeCfgs[challengeId]

	if buffType then
		local buffCfgs = buffType and buffTypes[buffType]

		if buffCfgs then
			if buffLv then
				return buffCfgs[buffLv]
			else
				return buffCfgs
			end
		else
			return nil
		end
	else
		return buffTypes
	end
end

function TimedPointRaceModeConfig:getBuffChallengeTypeByEnterType(challengeId, enterType)
	local buffTypes = challengeId and enterType and self._buffEnterTypes[challengeId][enterType]

	return buffTypes or {}
end

function TimedPointRaceModeConfig:getBuffCfgs(buffId)
	return self._buffCfgs and self._buffCfgs[buffId]
end

function TimedPointRaceModeConfig:getPrizeCfgs(challengeId, prizeId)
	local prizeCfgs = challengeId and self._prizeCfgs[challengeId]

	if prizeId then
		return prizeCfgs[prizeId]
	else
		return prizeCfgs or {}
	end
end

function TimedPointRaceModeConfig:getCreepCfgById(challengeId, creepsMasterId)
	return creepsMasterId and challengeId and self._creepCfgs[challengeId][creepsMasterId]
end

function TimedPointRaceModeConfig:getMonsterCfgs(creepsMasterId)
	return creepsMasterId and self._monsterCfgs[creepsMasterId]
end

function TimedPointRaceModeConfig:isTimeAbleToChallenge(challengeId)
	local commonCfg = self:getCommonCfg(challengeId)
	local challengeCfg = TimeLimitedConfig.instance:getCfgById(challengeId)

	if commonCfg and challengeCfg then
		local curTime = ServerTime.now()
		local endDateTime = GameUtil.string2time(challengeCfg.absoluteEndDay) - commonCfg.notFightDays * 86400
		local isDateAble = curTime < endDateTime
		local param = string.split(commonCfg.closeRange, "-")
		local curDateStr = GameUtil.formatTimeStamp("%Y-%m-%d", curTime)
		local startTime = GameUtil.string2time(curDateStr .. " " .. param[1])
		local endTime = GameUtil.string2time(curDateStr .. " " .. param[2])
		local isTimeAble = curTime < startTime or endTime < curTime

		return isTimeAble and isDateAble, isTimeAble, isDateAble
	end

	return false, false, false
end

TimedPointRaceModeConfig.instance = TimedPointRaceModeConfig.New()

return TimedPointRaceModeConfig
