-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/config/GoddessCompetitionConfig.lua

module("logic.extensions.goddesscompetition.config.GoddessCompetitionConfig", package.seeall)

local MmUtil = require("logic.extensions.goddessshop.data.MmUtil")
local GoddessCompetitionConfig = class("GoddessCompetitionConfig", BaseConfig)

function GoddessCompetitionConfig:getNames()
	return {
		"goddess_competition_final_rank_prize",
		"goddess_competition_super_fans_prize",
		"goddess_competition_step",
		"goddess_competition_red_pack_rank_prize",
		"goddess_competition_weekly_rank_prize",
		"goddess_competition_pool_pack",
		"goddess_competition_activity",
		"goddess_competition_goddess",
		"goddess_competition_red_pack",
		"goddess_competition_double_card",
		"goddess_competition_progress_prize",
		"goddess_competition_activity_popularity_rank_prize",
		"goddess_competition_step_popularity_rank_prize"
	}
end

function GoddessCompetitionConfig:handleConfig(name, content)
	if name == "goddess_competition_final_rank_prize" then
		self._goddess_competition_final_rank_prize = content

		self:_handlerFinalRankPrizeCfg()
	elseif name == "goddess_competition_super_fans_prize" then
		self._goddess_competition_super_fans_prize = content

		self:_handlerFansRankPrizeCfg()
	elseif name == "goddess_competition_step" then
		self._goddess_competition_step = content
	elseif name == "goddess_competition_red_pack_rank_prize" then
		self._goddess_competition_red_pack_rank_prize = content

		self:_handlerRedPackRankPrizeCfg()
	elseif name == "goddess_competition_weekly_rank_prize" then
		self._goddess_competition_weekly_rank_prize = content

		self:_handlerWeeklyRankPrizeCfg()
	elseif name == "goddess_competition_pool_pack" then
		self._goddess_competition_pool_pack = content
	elseif name == "goddess_competition_activity" then
		self._goddess_competition_activity = content
	elseif name == "goddess_competition_goddess" then
		self._goddess_competition_goddess = content

		self:_handlerGoddessCfg()
	elseif name == "goddess_competition_red_pack" then
		self._goddess_competition_red_pack = content

		self:_handlerRedPackCfg()
	elseif name == "goddess_competition_double_card" then
		self._goddess_competition_double_card = content
	elseif name == "goddess_competition_progress_prize" then
		self._goddess_competition_progress_prize = content
	elseif name == "goddess_competition_activity_popularity_rank_prize" then
		self._goddess_competition_activity_popularity_rank_prize = content
	elseif name == "goddess_competition_step_popularity_rank_prize" then
		self._goddess_competition_step_popularity_rank_prize = content
	end
end

function GoddessCompetitionConfig:getActCfg(activityId)
	return self._goddess_competition_activity[activityId]
end

function GoddessCompetitionConfig:getStepsCfgs(activityId)
	return self._goddess_competition_step[activityId]
end

function GoddessCompetitionConfig:getStepCfgByStepId(activityId, stepId)
	return self._goddess_competition_step[activityId][stepId]
end

function GoddessCompetitionConfig:_handlerFinalRankPrizeCfg()
	self._finalRankCfgs = {}

	for i, v in ipairs(self._goddess_competition_final_rank_prize.dataList) do
		self._finalRankCfgs[v.activityId] = self._finalRankCfgs[v.activityId] or {}
		self._finalRankCfgs[v.activityId][v.goddessRank] = self._finalRankCfgs[v.activityId][v.goddessRank] or {}

		table.insert(self._finalRankCfgs[v.activityId][v.goddessRank], v)
	end
end

function GoddessCompetitionConfig:_handlerFansRankPrizeCfg()
	self._fansRankCfgs = {}

	for i, v in ipairs(self._goddess_competition_super_fans_prize.dataList) do
		self._fansRankCfgs[v.activityId] = self._fansRankCfgs[v.activityId] or {}
		self._fansRankCfgs[v.activityId][v.goddessRank] = self._fansRankCfgs[v.activityId][v.goddessRank] or {}

		table.insert(self._fansRankCfgs[v.activityId][v.goddessRank], v)
	end
end

function GoddessCompetitionConfig:_handlerWeeklyRankPrizeCfg()
	self._weekRankCfgs = {}

	for i, v in ipairs(self._goddess_competition_weekly_rank_prize.dataList) do
		self._weekRankCfgs[v.rankPrizePlanId] = self._weekRankCfgs[v.rankPrizePlanId] or {}

		table.insert(self._weekRankCfgs[v.rankPrizePlanId], v)
	end
end

function GoddessCompetitionConfig:_handlerRedPackRankPrizeCfg()
	self._redPackRankCfgs = {}

	for i, v in ipairs(self._goddess_competition_red_pack_rank_prize.dataList) do
		self._redPackRankCfgs[v.activityId] = self._redPackRankCfgs[v.activityId] or {}

		table.insert(self._redPackRankCfgs[v.activityId], v)
	end
end

function GoddessCompetitionConfig:getFinalRankPrizeCfgs(activityId)
	return self._goddess_competition_final_rank_prize[activityId]
end

function GoddessCompetitionConfig:getFinalRankPrizeCfgsByRank(activityId, goddessRank)
	if self._finalRankCfgs[activityId] then
		return self._finalRankCfgs[activityId][goddessRank]
	end
end

function GoddessCompetitionConfig:getFansRankPrizeCfgs(activityId)
	return self._goddess_competition_super_fans_prize[activityId]
end

function GoddessCompetitionConfig:getFansRankPrizeCfgsByRank(activityId, goddessRank)
	if self._fansRankCfgs[activityId] then
		return self._fansRankCfgs[activityId][goddessRank]
	end
end

function GoddessCompetitionConfig:getWeekRankPrizeCfgs(rankPrizePlanId)
	return self._weekRankCfgs[rankPrizePlanId]
end

function GoddessCompetitionConfig:getRedPcakRankPrizeCfgs(activityId)
	return self._redPackRankCfgs[activityId]
end

function GoddessCompetitionConfig:getStepCfgs(activityId)
	return self._goddess_competition_step[activityId]
end

function GoddessCompetitionConfig:getStepCfg(activityId, stepId)
	if self._goddess_competition_step[activityId] then
		return self._goddess_competition_step[activityId][stepId]
	end
end

function GoddessCompetitionConfig:_handlerGoddessCfg()
	self._goddessCfgs = {}

	for i, v in ipairs(self._goddess_competition_goddess.dataList) do
		self._goddessCfgs[v.activityId] = self._goddessCfgs[v.activityId] or {}

		table.insert(self._goddessCfgs[v.activityId], v)
	end
end

function GoddessCompetitionConfig:getGoddessCfgs(activityId)
	return self._goddessCfgs[activityId]
end

function GoddessCompetitionConfig:getRedPackRankCfgs(activityId)
	return self._goddess_competition_red_pack_rank_prize[activityId]
end

function GoddessCompetitionConfig:getRedPackRankDataByRank(activityId, rank)
	local cfgs = self._goddess_competition_red_pack_rank_prize[activityId]

	return MmUtil.unorderedSearchInArrayKey(cfgs, "rankRange", rank)
end

function GoddessCompetitionConfig:getRedPackCfgs(activityId)
	return self._goddess_competition_red_pack[activityId]
end

function GoddessCompetitionConfig:getRedPackCfg(activityId, redPackId)
	if self._goddess_competition_red_pack[activityId] then
		return self._goddess_competition_red_pack[activityId][redPackId]
	end
end

function GoddessCompetitionConfig:getPoolCfgs(poolPlanId)
	return self._goddess_competition_pool_pack[poolPlanId]
end

function GoddessCompetitionConfig:_handlerRedPackCfg()
	self._RedPackByTypesCfgs = {}

	for i, v in ipairs(self._goddess_competition_red_pack.dataList) do
		self._RedPackByTypesCfgs[v.activityId] = self._RedPackByTypesCfgs[v.activityId] or {}

		if not self._RedPackByTypesCfgs[v.activityId][v.type] then
			table.insert(self._RedPackByTypesCfgs[v.activityId][v.type], v)

			self._RedPackByTypesCfgs[v.activityId][v.type] = self._RedPackByTypesCfgs[v.activityId][v.type]
		end
	end
end

function GoddessCompetitionConfig:getRedPackCfgsByType(activityId, type)
	return self._RedPackByTypesCfgs[activityId][type]
end

function GoddessCompetitionConfig:getGoddessCfg(activityId, goddessFaceId)
	if self._goddess_competition_goddess[activityId] then
		return self._goddess_competition_goddess[activityId][goddessFaceId]
	end
end

function GoddessCompetitionConfig:getGoddessSortId(activityId, goddessFaceId)
	local cfg = self:getGoddessCfg(activityId, checknumber(goddessFaceId))

	if cfg then
		return cfg.sortId
	end

	return 0
end

function GoddessCompetitionConfig:getDoubleCardCfgs(activityId)
	return self._goddess_competition_double_card[activityId]
end

function GoddessCompetitionConfig:getDoubleCardCfg(activityId, cardId)
	if self._goddess_competition_double_card[activityId] then
		return self._goddess_competition_double_card[activityId][cardId]
	end
end

function GoddessCompetitionConfig:getProgressPrizeCfgs(activityId)
	return self._goddess_competition_progress_prize[activityId]
end

function GoddessCompetitionConfig:getProgressPrizeCfg(activityId, prizeId)
	if self._goddess_competition_progress_prize[activityId] then
		return self._goddess_competition_progress_prize[activityId][prizeId]
	end
end

function GoddessCompetitionConfig:getActivityRankPrizeCfgs(activityId)
	if self._goddess_competition_activity_popularity_rank_prize[activityId] then
		return self._goddess_competition_activity_popularity_rank_prize[activityId]
	end
end

function GoddessCompetitionConfig:getActivityRankPrizeCfgByRank(activityId, rank)
	local cfgs = self:getActivityRankPrizeCfgs(activityId)

	return MmUtil.unorderedSearchInArrayKey(cfgs, "rankRange", rank)
end

function GoddessCompetitionConfig:getStepRankPrizeCfgsByActivity(activityId)
	return self._goddess_competition_step_popularity_rank_prize[activityId]
end

function GoddessCompetitionConfig:getStepRankPrizeCfgs(activityId, stepId)
	if self._goddess_competition_step_popularity_rank_prize[activityId] then
		return self._goddess_competition_step_popularity_rank_prize[activityId][stepId]
	end
end

function GoddessCompetitionConfig:getStepRankPrizeCfgByRank(activityId, stepId, rank)
	local cfgs = self:getStepRankPrizeCfgs(activityId, stepId)

	return MmUtil.unorderedSearchInArrayKey(cfgs, "rankRange", rank)
end

function GoddessCompetitionConfig:getStepTypeByStepId(activityId, stepId)
	local stepCfg = self:getStepCfg(activityId, stepId)

	if stepCfg then
		return stepCfg.stepType
	end

	return nil
end

function GoddessCompetitionConfig:getStepIdByStepType(activityId, stepType)
	local stepCfgs = self:getStepCfgs(activityId)

	if stepCfgs then
		for _, cfg in ipairs(stepCfgs) do
			if cfg.stepType == stepType then
				return cfg.stepId
			end
		end
	end

	return nil
end

GoddessCompetitionConfig.instance = GoddessCompetitionConfig.New()

return GoddessCompetitionConfig
