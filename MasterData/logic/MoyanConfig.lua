-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/config/MoyanConfig.lua

module("logic.extensions.timelimitedchallenge.config.MoyanConfig", package.seeall)

local MoyanConfig = class("MoyanConfig", BaseConfig)

function MoyanConfig:getNames()
	return {
		"mo_yan_challenge",
		"mo_yan_challenge_plan",
		"mo_yan_challenge_stage",
		"mo_yan_challenge_creeps",
		"mo_yan_challenge_progress_prize",
		"mo_yan_challenge_buy_times",
		"mo_yan_challenge_boss_damage_score",
		"mo_yan_challenge_system_pet",
		"mo_yan_challenge_buff"
	}
end

function MoyanConfig:handleConfig(name, content)
	if name == "mo_yan_challenge" then
		self._commonCfg = content
	elseif name == "mo_yan_challenge_plan" then
		self.mo_yan_challenge_planCfg = content
	elseif name == "mo_yan_challenge_stage" then
		self._monsterCfg = content
	elseif name == "mo_yan_challenge_creeps" then
		self._creepsCfg = content
	elseif name == "mo_yan_challenge_progress_prize" then
		self._prizeCfg = content
	elseif name == "ice_king_bubble_config" then
		self._bubble_config = content
	elseif name == "mo_yan_challenge_system_pet" then
		self.mo_yan_challenge_system_petCfg = content
	elseif name == "mo_yan_challenge_buff" then
		self.mo_yan_challenge_buffCfg = content
	elseif name == "mo_yan_challenge_boss_damage_score" then
		self.mo_yan_challenge_boss_damage_scoreCfg = content
	elseif name == "mo_yan_challenge_buy_times" then
		self.mo_yan_challenge_buy_timesCfg = content
	end
end

function MoyanConfig:getRandBubbleTxt()
	if self._bubble_config then
		local len = #self._bubble_config.dataList
		local idx = math.random(1, len)

		return self._bubble_config[idx].content
	end

	return ""
end

function MoyanConfig:getBaseConfig(challengeId)
	return self._commonCfg[challengeId]
end

function MoyanConfig:getPrizeCfgs(planId)
	if self._prizeCfg and self._prizeCfg[planId] then
		local plan = self._prizeCfg[planId]
		local list = table.values(plan)

		table.sort(list, function(a, b)
			return a.id < b.id
		end)

		return list
	end
end

function MoyanConfig:getSysPetListCfg(planId)
	local cfgList = self.mo_yan_challenge_system_petCfg[planId]

	return cfgList or {}
end

function MoyanConfig:getMonsterCfgList(planId)
	if self._monsterCfg and self._monsterCfg[planId] then
		return self._monsterCfg[planId]
	end

	return {}
end

function MoyanConfig:getMonsterCfg(planId, stage)
	if self._monsterCfg and self._monsterCfg[planId] then
		local cfgList = self._monsterCfg[planId]
		local len = #cfgList

		stage = math.min(stage, len)

		local cfg = cfgList[stage]

		return cfg or {}
	end

	return {}
end

function MoyanConfig:getCreepsCfg(creepsMasterId)
	if self._creepsCfg and self._creepsCfg[creepsMasterId] then
		return self._creepsCfg[creepsMasterId]
	end
end

function MoyanConfig:getPlanCfg(planId, type)
	if self.mo_yan_challenge_planCfg[planId] then
		return self.mo_yan_challenge_planCfg[planId][type]
	end
end

function MoyanConfig:getBuffCfg(planId, count)
	if self.mo_yan_challenge_buffCfg[planId] then
		return self.mo_yan_challenge_buffCfg[planId][count]
	end
end

function MoyanConfig:getScoreCfgList(planId)
	return self.mo_yan_challenge_boss_damage_scoreCfg[planId] or {}
end

function MoyanConfig:getBuyCfgList(planId)
	return self.mo_yan_challenge_buy_timesCfg[planId] or {}
end

MoyanConfig.instance = MoyanConfig.New()

return MoyanConfig
