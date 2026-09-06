-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/config/PerfectRuleModeConfig.lua

module("logic.extensions.timelimitedchallenge.config.PerfectRuleModeConfig", package.seeall)

local PerfectRuleModeConfig = class("PerfectRuleModeConfig", BaseConfig)

function PerfectRuleModeConfig:onInit()
	PerfectRuleModeConfig.super.onInit(self)

	self._commonCfgs = nil
	self._modeCfgs = nil
	self._modeCfgsByIds = nil
	self._ruleCfgs = nil
	self._ruleModeCfgs = nil
	self._buyTimeCostCfgs = nil
	self._creepCfgs = nil
	self._monsterCfgs = nil
	self._perfectWinCfgs = nil
	self._progressCfgs = nil
end

function PerfectRuleModeConfig:getNames()
	return {
		"perfect_rule_fight_common",
		"perfect_rule_fight_mode",
		"perfect_rule_fight_rule_plan",
		"perfect_rule_fight_buy_times",
		"perfect_rule_fight_monster_plan",
		"perfect_rule_fight_creeps",
		"perfect_rule_fight_perfect_win_op",
		"perfect_rule_fight_progress_prize",
		"perfect_rule_universal"
	}
end

function PerfectRuleModeConfig:handleConfig(name, content)
	if name == "perfect_rule_fight_common" then
		self._commonCfgs = content
	elseif name == "perfect_rule_fight_mode" then
		self._modeCfgs = {}
		self._modeCfgsByIds = {}

		for _, v in ipairs(content.dataList) do
			self._modeCfgs[v.challengeId] = self._modeCfgs[v.challengeId] or {}
			self._modeCfgs[v.challengeId][v.modeId] = v
			self._modeCfgsByIds[v.challengeId] = self._modeCfgsByIds[v.challengeId] or {}

			table.insert(self._modeCfgsByIds[v.challengeId], v)
		end
	elseif name == "perfect_rule_fight_rule_plan" then
		self._ruleCfgs = content
		self._ruleModeCfgs = {}

		for _, v in ipairs(content.dataList) do
			if not self._ruleModeCfgs[v.challengeId] then
				local cfgs = {}

				self._ruleModeCfgs[v.challengeId] = self._ruleModeCfgs[v.challengeId]
				cfgs = self._ruleModeCfgs[v.challengeId][v.modeId] or {}

				table.insert(self._ruleModeCfgs[v.challengeId], v)

				self._ruleModeCfgs[v.challengeId][v.modeId] = self._ruleModeCfgs[v.challengeId]
			end
		end
	elseif name == "perfect_rule_fight_buy_times" then
		self._buyTimeCostCfgs = content
	elseif name == "perfect_rule_fight_monster_plan" then
		self._creepCfgs = {}

		for _, v in ipairs(content.dataList) do
			self._creepCfgs[v.creepsMasterId] = v
		end
	elseif name == "perfect_rule_fight_creeps" then
		self._monsterCfgs = content
	elseif name == "perfect_rule_fight_perfect_win_op" then
		self._perfectWinCfgs = content
	elseif name == "perfect_rule_fight_progress_prize" then
		self._progressCfgs = content
	elseif name == "perfect_rule_universal" then
		self._perfectRuleCfg = content
	end
end

function PerfectRuleModeConfig:getCommonCfg(challengeId)
	return self._commonCfgs[challengeId]
end

function PerfectRuleModeConfig:getModeCfgs(challengeId, modeId)
	local cfgs = challengeId and self._modeCfgs[challengeId]

	if cfgs then
		if modeId then
			return cfgs[modeId]
		else
			return cfgs
		end
	end
end

function PerfectRuleModeConfig:getModeCfgsByIndex(challengeId, Id)
	local cfgs = challengeId and self._modeCfgsByIds[challengeId]

	if cfgs then
		if Id then
			return cfgs[Id]
		else
			return cfgs
		end
	end
end

function PerfectRuleModeConfig:getRuleCfgById(challengeId, ruleId)
	local cfgs = challengeId and self._ruleCfgs[challengeId]

	if cfgs then
		if ruleId then
			return cfgs[ruleId]
		else
			return cfgs
		end
	end
end

function PerfectRuleModeConfig:getRuleCfgByModeId(challengeId, modeId)
	return challengeId and modeId and self._ruleModeCfgs[challengeId][modeId]
end

function PerfectRuleModeConfig:getCostByIdAndTimes(challengeId, times)
	return challengeId and times and self._buyTimeCostCfgs[challengeId][checkint(times)].cost
end

function PerfectRuleModeConfig:getMaxBuyTimes(challengeId)
	return challengeId and #self._buyTimeCostCfgs[challengeId]
end

function PerfectRuleModeConfig:getCreepCfgById(creepsMasterId)
	return creepsMasterId and self._creepCfgs[creepsMasterId]
end

function PerfectRuleModeConfig:getMonsterCfgs(creepsMasterId)
	return creepsMasterId and self._monsterCfgs[creepsMasterId]
end

function PerfectRuleModeConfig:getPerfectWinCfgById(Id)
	return Id and self._perfectWinCfgs[Id]
end

function PerfectRuleModeConfig:getProgressPrizeCfg(planId)
	return self._progressCfgs[planId] or {}
end

function PerfectRuleModeConfig:getProgressPrize(challengeId, id)
	local cfg = self:getCommonCfg(challengeId)

	if cfg and cfg.progressPrizePlanId > 0 then
		local pCfg = self:getProgressPrizeCfg(cfg.progressPrizePlanId)

		if pCfg and pCfg[id] then
			local prizes = string.split(pCfg[id].prize, "#")
			local prize = string.split(prizes[1], ":")

			return prize[3]
		end
	end

	return 0
end

function PerfectRuleModeConfig:getPerfectCfgByKey(key)
	if self._perfectRuleCfg[key] then
		return self._perfectRuleCfg[key].value
	end

	printError("输入的key值有问题")

	return ""
end

PerfectRuleModeConfig.instance = PerfectRuleModeConfig.New()

return PerfectRuleModeConfig
