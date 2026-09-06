-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/config/GoddessContestConfig.lua

module("logic.extensions.goddesscontest.config.GoddessContestConfig", package.seeall)

local GoddessContestConfig = class("GoddessContestConfig", BaseConfig)

function GoddessContestConfig:onInit()
	GoddessContestConfig.super.onInit(self)
end

function GoddessContestConfig:getNames()
	return {
		"goddess_contest_activity",
		"goddess_contest_time",
		"goddess_contest_fans_group",
		"goddess_contest_popularity_frenzy",
		"goddess_contest_settlement_prize",
		"goddess_contest_config",
		"goddess_contest_progress_sld",
		"goddess_contest_group_tab",
		"goddess_contest_winner_tab",
		"goddess_contest_hud",
		"goddess_contest_grade",
		"goddess_contest_rank_prize",
		"goddess_contest_card_step",
		"goddess_contest_card",
		"goddess_contest_card_score",
		"goddess_contest_card_vote_rate"
	}
end

function GoddessContestConfig:handleConfig(name, content)
	if name == "goddess_contest_activity" then
		self._actCfgs = content
	elseif name == "goddess_contest_time" then
		self._timeCfgs = content
	elseif name == "goddess_contest_fans_group" then
		self._fansGroupCfgs = content
	elseif name == "goddess_contest_popularity_frenzy" then
		self._frenzyCfgs = content
	elseif name == "goddess_contest_settlement_prize" then
		self._settlementCfgs = content
	elseif name == "goddess_contest_config" then
		self._comCfgs = content
	elseif name == "goddess_contest_progress_sld" then
		self._progressSldCfgs = content
	elseif name == "goddess_contest_group_tab" then
		self._groupTabCfgs = content
	elseif name == "goddess_contest_winner_tab" then
		self._winnerTabCfgs = content
	elseif name == "goddess_contest_hud" then
		self._hudCfgs = content
	elseif name == "goddess_contest_grade" then
		self._gradeCfgs = content
	elseif name == "goddess_contest_rank_prize" then
		self._rankPrizeCfgs = content
	elseif name == "goddess_contest_card_step" then
		self.goddess_contest_card_step = content
	elseif name == "goddess_contest_card" then
		self.goddess_contest_card = content
	elseif name == "goddess_contest_card_score" then
		self._goddess_contest_card_score = content
	elseif name == "goddess_contest_card_vote_rate" then
		self._goddess_contest_card_vote_rate = content
	end
end

function GoddessContestConfig:getActCfgByActId(actId)
	return self._actCfgs[actId]
end

function GoddessContestConfig:getTimeStrByActIdAndTimeKey(actId, timeKey)
	local actCfg = self:getActCfgByActId(actId)

	if actCfg then
		local timeCfgs = self._timeCfgs[actCfg.timePlanId]

		if timeCfgs then
			return (timeCfgs[timeKey] or nil) and (timeCfgs[timeKey].value or "")
		end
	end
end

function GoddessContestConfig:getFanGroupCfgsByActId(actId)
	local actCfg = self:getActCfgByActId(actId)

	if actCfg then
		return self._fansGroupCfgs[actCfg.fansGroupPlanId]
	end
end

function GoddessContestConfig:getFanGroupCfgsByActIdAndGroupId(actId, groupId)
	local groupCfgs = self:getFanGroupCfgsByActId(actId)

	return groupCfgs and groupCfgs[groupId]
end

function GoddessContestConfig:getFrenzyCfgsByActId(actId)
	local actCfg = self:getActCfgByActId(actId)

	if actCfg then
		return self._frenzyCfgs[actCfg.popularityFrenzyPlanId]
	end
end

function GoddessContestConfig:getSettlementCfgsByActId(actId)
	local actCfg = self:getActCfgByActId(actId)

	if actCfg then
		return self._settlementCfgs[actCfg.settlementPrizePlanId]
	end
end

function GoddessContestConfig:getCommondValueByKey(key)
	if self._comCfgs[key] then
		if not string.nilorempty(self._comCfgs[key].value2) then
			return self._comCfgs[key].value2
		else
			return self._comCfgs[key].value
		end
	end
end

function GoddessContestConfig:getTimeSldCfgsByActId(actId)
	local actCfg = self:getActCfgByActId(actId)

	if actCfg then
		return self._progressSldCfgs[actCfg.progressSldPlanId]
	end
end

function GoddessContestConfig:getGroupTabCfgsByActId(actId)
	local actCfg = self:getActCfgByActId(actId)

	if actCfg then
		return self._groupTabCfgs[actCfg.groupTabsPlanId]
	end
end

function GoddessContestConfig:getWinnerTabCfgsByActId(actId)
	local actCfg = self:getActCfgByActId(actId)

	if actCfg then
		return self._winnerTabCfgs[actCfg.winnerTabsPlanId]
	end
end

function GoddessContestConfig:getWinnerHudCfgsByActId(actId)
	local actCfg = self:getActCfgByActId(actId)

	if actCfg then
		return self._hudCfgs[actCfg.hudPlanId]
	end
end

function GoddessContestConfig:getGradeCfg(gradeId)
	return self._gradeCfgs[gradeId]
end

function GoddessContestConfig:getRankCfgsByActId(actId)
	local list = {}

	for k, v in pairs(self._rankPrizeCfgs[actId]) do
		table.insert(list, v)
	end

	table.sort(list, function(a, b)
		return a.rankRange[1] < b.rankRange[1]
	end)

	return list
end

function GoddessContestConfig:getCardStepCfg(activityId)
	return self.goddess_contest_card_step[activityId]
end

function GoddessContestConfig:getCardStepData(activityId, stepId)
	if self.goddess_contest_card_step[activityId] then
		return self.goddess_contest_card_step[activityId][stepId]
	end
end

function GoddessContestConfig:getCardCfg(activityId, stepId)
	local stepData = self:getCardStepData(activityId, stepId)

	if stepData then
		if not stepData.collectCardPlanId then
			local collectCardPlanId = 0

			return self.goddess_contest_card[collectCardPlanId]
		end
	end
end

function GoddessContestConfig:getCardData(activityId, stepId, cardId)
	local cfg = self:getCardCfg(activityId, stepId)

	if cfg then
		return cfg[cardId]
	end
end

function GoddessContestConfig:getCardScoreCfg(activityId, stepId)
	local stepData = self:getCardStepData(activityId, stepId)

	if stepData then
		if not stepData.cardScorePlanId then
			local cardScorePlanId = 0

			return self._goddess_contest_card_score[cardScorePlanId]
		end
	end
end

function GoddessContestConfig:getCardScoreData(activityId, stepId, rankId)
	local cfg = self:getCardScoreCfg(activityId, stepId)

	if cfg then
		return cfg[rankId]
	end
end

function GoddessContestConfig:getCardVoteCfg(activityId, stepId)
	local stepData = self:getCardStepData(activityId, stepId)

	if stepData then
		if not stepData.cardVotePlanId then
			local cardVotePlanId = 0

			return self._goddess_contest_card_vote_rate[cardVotePlanId]
		end
	end
end

function GoddessContestConfig:getCardVoteData(activityId, stepId, rankId)
	local cfg = self:getCardVoteCfg(activityId, stepId)

	if cfg then
		return cfg[rankId]
	end
end

GoddessContestConfig.instance = GoddessContestConfig.New()

return GoddessContestConfig
