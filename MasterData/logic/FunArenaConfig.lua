-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funarena/config/FunArenaConfig.lua

module("logic.extensions.funarena.config.FunArenaConfig", package.seeall)

local FunArenaConfig = class("FunArenaConfig", BaseConfig)

function FunArenaConfig:onInit()
	FunArenaConfig.super.onInit(self)
end

function FunArenaConfig:getNames()
	return {
		"big_cast_challenge_params",
		"big_cast_challenge",
		"big_cast_challenge_pet",
		"big_cast_challenge_job_prop",
		"big_cast_challenge_buff",
		"big_cast_challenge_lottery",
		"big_cast_challenge_win_streak_prize"
	}
end

function FunArenaConfig:handleConfig(name, content)
	if name == "big_cast_challenge_params" then
		self._challengeParamsCfgs = content
	elseif name == "big_cast_challenge" then
		self._challengeCfgs = content
	elseif name == "big_cast_challenge_pet" then
		self._petCfgs = content
	elseif name == "big_cast_challenge_job_prop" then
		self._jobPropCfgs = content
	elseif name == "big_cast_challenge_buff" then
		self._buffCfgs = content
	elseif name == "big_cast_challenge_lottery" then
		self._lotteryCfgs = content
	elseif name == "big_cast_challenge_win_streak_prize" then
		self._winStreakPrizeCfgs = content
	end
end

function FunArenaConfig:getChallengeParamsCfgs(key)
	return self._challengeParamsCfgs[key] or {}
end

function FunArenaConfig:getChallengeCfgById(actId)
	return self._challengeCfgs[actId] or {}
end

function FunArenaConfig:getPetCfgsById(actId)
	local cfgs = {}
	local challengeCfg = self:getChallengeCfgById(actId)

	if challengeCfg then
		local planId = challengeCfg.petPlan

		for _, data in ipairs(self._petCfgs[planId]) do
			table.insert(cfgs, data)
		end
	end

	return cfgs
end

function FunArenaConfig:getJobPropCfgs()
	return self._jobPropCfgs or {}
end

function FunArenaConfig:getBuffCfgs()
	return self._buffCfgs or {}
end

function FunArenaConfig:getLotteryCfgsById(actId)
	local challengeCfg = self:getChallengeCfgById(actId)
	local planId = challengeCfg.lotteryPlan

	if not self._lotteryCfgs[planId] then
		local lotteryCfg = {}

		for startTimes, data in pairs(self._lotteryCfgs[planId]) do
			if data then
				local t = {}

				t.startTimes = startTimes
				t.data = data

				table.insert(lotteryCfg, t)
			end
		end

		table.sort(lotteryCfg, function(a, b)
			return a.startTimes < b.startTimes
		end)

		local tab = {}

		for startTimes, cfgs in ipairs(lotteryCfg) do
			for prizeId, data in ipairs(cfgs.data) do
				tab[prizeId] = tab[prizeId] or {}

				table.insert(tab[prizeId], data)
			end
		end

		return tab
	end
end

function FunArenaConfig:getWinStreakPrizeCfgsById(actId)
	local tab = {}
	local challengeCfg = self:getChallengeCfgById(actId)

	if challengeCfg then
		local planId = challengeCfg.winStreakPrizePlan

		tab = self._winStreakPrizeCfgs[planId]
	end

	return tab
end

FunArenaConfig.instance = FunArenaConfig.New()

return FunArenaConfig
