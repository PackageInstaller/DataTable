-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/config/PeakTournamentConfig.lua

module("logic.extensions.peaktournament.config.PeakTournamentConfig", package.seeall)

local PeakTournamentConfig = class("PeakTournamentConfig", BaseConfig)

function PeakTournamentConfig:onInit()
	PeakTournamentConfig.super.onInit(self)
end

function PeakTournamentConfig:getNames()
	return {
		"peak_tournament",
		"peak_tournament_common",
		"peak_tournament_zone",
		"peak_tournament_qualifier_level",
		"peak_tournament_qualifier_rank_score",
		"peak_tournament_qualifier_match_score",
		"peak_tournament_qualifier_match",
		"peak_tournament_qualifier_task",
		"peak_tournament_eliminator_round",
		"peak_tournament_eliminator_rank_prize",
		"peak_tournament_eliminator_vote_plate",
		"peak_tournament_kudos_prize",
		"peak_tournament_ban_pet",
		"peak_tournament_not_ban_pet"
	}
end

function PeakTournamentConfig:handleConfig(name, content)
	if name == "peak_tournament" then
		self._ptCfg = content
	elseif name == "peak_tournament_common" then
		self._ptCommonCfg = content
	elseif name == "peak_tournament_zone" then
		self._ptZoneCfg = content
		self._ptZoneDataList = content
	elseif name == "peak_tournament_qualifier_level" then
		self._ptQuaLevelCfgs = content
	elseif name == "peak_tournament_qualifier_rank_score" then
		self._ptQuaRankScoreCfgs = content
	elseif name == "peak_tournament_qualifier_match_score" then
		self._ptQuaMatchScoreCfgs = content
	elseif name == "peak_tournament_qualifier_match" then
		self._ptQuaMatchCfgs = content
	elseif name == "peak_tournament_qualifier_task" then
		self._ptQuaTaskCfgs = content

		self:_handleQuaTaskCfgs(content)
	elseif name == "peak_tournament_eliminator_round" then
		self._ptEliRoundCfgs = content
	elseif name == "peak_tournament_eliminator_rank_prize" then
		self._ptEliRankPrizeCfgs = content
	elseif name == "peak_tournament_eliminator_vote_plate" then
		self._ptEliVotePlateCfg = content
	elseif name == "peak_tournament_kudos_prize" then
		self._ptKudosPrizeCfg = content
	elseif name == "peak_tournament_ban_pet" then
		self.peak_tournament_ban_pet = content
	elseif name == "peak_tournament_not_ban_pet" then
		self.peak_tournament_not_ban_pet = content
	end
end

function PeakTournamentConfig:getPtBaseData(activityId)
	return self._ptCfg[activityId]
end

function PeakTournamentConfig:getPtCommonValue(key)
	if self._ptCommonCfg[key] then
		if not string.nilorempty(self._ptCommonCfg[key].value2) then
			return self._ptCommonCfg[key].value2
		else
			return self._ptCommonCfg[key].value
		end
	end
end

function PeakTournamentConfig:getQualifierRankShowCount()
	return checknumber(self:getPtCommonValue("QUALIFIER_RANK_SHOW_COUNT"))
end

function PeakTournamentConfig:getQualifierRankRegisterCount()
	return checknumber(self:getPtCommonValue("QUALIFIER_RANK_REGISTER_COUNT"))
end

function PeakTournamentConfig:getVoteMate()
	return self:getPtCommonValue("VOTE_MAT")
end

function PeakTournamentConfig:getVoteWinRatio()
	return checknumber(self:getPtCommonValue("VOTE_WIN_RATIO"))
end

function PeakTournamentConfig:getPushMatchingCountInVotePlate()
	return checknumber(self:getPtCommonValue("PUSH_MATCHING_COUNT_IN_VOTE_PLATE"))
end

function PeakTournamentConfig:getRedPackActivityId()
	return checknumber(self:getPtCommonValue("RED_PACK_ACTIVITY_ID"))
end

function PeakTournamentConfig:getActivityShopId()
	return checknumber(self:getPtCommonValue("ACTIVITY_SHOP_ID"))
end

function PeakTournamentConfig:getRewardDescriptionFrameId()
	return checknumber(self:getPtCommonValue("REWARD_DESCRIPTION_FRAMEID"))
end

function PeakTournamentConfig:getEliminatorBaseFrameId()
	return checknumber(self:getPtCommonValue("ELIMINATOR_BASE_FRAMEID"))
end

function PeakTournamentConfig:getPtZoneCfg(activityId)
	return self._ptZoneCfg[activityId]
end

function PeakTournamentConfig:getPtZoneData(activityId, zoneId)
	return self._ptZoneCfg[activityId][zoneId]
end

function PeakTournamentConfig:getPtZoneDataByAreaId(activityId, areaId)
	areaId = checknumber(areaId)

	local targetData
	local cfg = self:getPtZoneCfg(activityId)

	for i = 0, #cfg do
		local data = cfg[i]

		if data and areaId >= data.areaIds[1] and areaId <= data.areaIds[2] then
			targetData = data

			break
		end
	end

	return targetData
end

function PeakTournamentConfig:getPtQuaLevelCfg(quaLevelPlanId)
	return self._ptQuaLevelCfgs[quaLevelPlanId]
end

function PeakTournamentConfig:getPtQuaLevelData(quaLevelPlanId, quaLevelId)
	return self._ptQuaLevelCfgs[quaLevelPlanId][quaLevelId]
end

function PeakTournamentConfig:getPtQuaLevelCfgById(activityId)
	return self._ptQuaLevelCfgs[self._ptCfg[activityId].quaLevelPlanId]
end

function PeakTournamentConfig:getPtQuaLevelDataById(activityId, quaLevelId)
	return self._ptQuaLevelCfgs[self._ptCfg[activityId].quaLevelPlanId][quaLevelId]
end

function PeakTournamentConfig:getPtQuaLevelDataByScore(activityId, rankScore)
	local res

	for _, data in ipairs(self:getPtQuaLevelCfgById(activityId)) do
		if rankScore >= data.rankScoreLimit[1] and rankScore <= data.rankScoreLimit[2] then
			res = data

			break
		end
	end

	return res
end

function PeakTournamentConfig:getPtQuaRankScoreCfg(rankScorePlanId)
	return self._ptQuaRankScoreCfgs[rankScorePlanId]
end

function PeakTournamentConfig:getPtQuaRankScoreData(rankScorePlanId, rankScoreId)
	return self._ptQuaRankScoreCfgs[rankScorePlanId][rankScoreId]
end

function PeakTournamentConfig:getPtQuaRankScoreCfgById(activityId)
	return self._ptQuaRankScoreCfgs[self._ptCfg[activityId].rankScorePlanId]
end

function PeakTournamentConfig:getPtQuaRankScoreDataById(activityId, rankScoreId)
	return self._ptQuaRankScoreCfgs[self._ptCfg[activityId].rankScorePlanId][rankScoreId]
end

function PeakTournamentConfig:getPtQuaMatchScoreCfg(matchScorePlanId)
	return self._ptQuaMatchScoreCfgs[matchScorePlanId]
end

function PeakTournamentConfig:getPtQuaMatchScoreData(matchScorePlanId, matchScoreId)
	return self._ptQuaMatchScoreCfgs[matchScorePlanId][matchScoreId]
end

function PeakTournamentConfig:getPtQuaMatchScoreCfgById(activityId)
	return self._ptQuaMatchScoreCfgs[self._ptCfg[activityId].matchScorePlanId]
end

function PeakTournamentConfig:getPtQuaMatchScoreDataById(activityId, matchScoreId)
	return self._ptQuaMatchScoreCfgs[self._ptCfg[activityId].matchScorePlanId][matchScoreId]
end

function PeakTournamentConfig:getPtQuaMatchCfg(quaMatchingPlanId)
	return self._ptQuaMatchCfgs[quaMatchingPlanId]
end

function PeakTournamentConfig:getPtQuaMatchData(quaMatchingPlanId, quaMatchingId)
	return self._ptQuaMatchCfgs[quaMatchingPlanId][quaMatchingId]
end

function PeakTournamentConfig:getPtQuaMatchCfgById(activityId)
	return self._ptQuaMatchCfgs[self._ptCfg[activityId].quaMatchingPlanId]
end

function PeakTournamentConfig:getPtQuaMatchDataById(activityId, quaMatchingId)
	return self._ptQuaMatchCfgs[self._ptCfg[activityId].quaMatchingPlanId][quaMatchingId]
end

function PeakTournamentConfig:getPtQuaTaskCfg(quaTaskPlanId)
	return self._ptQuaTaskCfgs[quaTaskPlanId]
end

function PeakTournamentConfig:getPtQuaTaskData(quaTaskPlanId, quaTaskId)
	return self._ptQuaTaskCfgs[quaTaskPlanId][quaTaskId]
end

function PeakTournamentConfig:getPtQuaTaskCfgById(activityId)
	return self._ptQuaTaskCfgs[self._ptCfg[activityId].quaTaskPlanId]
end

function PeakTournamentConfig:getPtQuaTaskDataById(activityId, quaTaskId)
	return self._ptQuaTaskCfgs[self._ptCfg[activityId].quaTaskPlanId][quaTaskId]
end

function PeakTournamentConfig:_handleQuaTaskCfgs(content)
	self._ptQuaTaskCfgsWithPageIdx = {}

	for _, data in ipairs(content.dataList) do
		if self._ptQuaTaskCfgsWithPageIdx[data.quaTaskPlanId] == nil then
			self._ptQuaTaskCfgsWithPageIdx[data.quaTaskPlanId] = {}
		end

		if self._ptQuaTaskCfgsWithPageIdx[data.quaTaskPlanId][data.pageIdx] == nil then
			self._ptQuaTaskCfgsWithPageIdx[data.quaTaskPlanId][data.pageIdx] = {}
		end

		table.insert(self._ptQuaTaskCfgsWithPageIdx[data.quaTaskPlanId][data.pageIdx], data)
	end
end

function PeakTournamentConfig:getPtQuaTaskCfgWithPageIdxById(activityId, pageIdx)
	return self._ptQuaTaskCfgsWithPageIdx[self._ptCfg[activityId].quaTaskPlanId][pageIdx]
end

function PeakTournamentConfig:getPtEliRoundCfg(eliRoundPlanId)
	return self._ptEliRoundCfgs[eliRoundPlanId]
end

function PeakTournamentConfig:getPtEliRoundData(eliRoundPlanId, eliRoundId)
	return self._ptEliRoundCfgs[eliRoundPlanId][eliRoundId]
end

function PeakTournamentConfig:getPtEliRoundCfgById(activityId)
	return self._ptEliRoundCfgs[self._ptCfg[activityId].eliRoundPlanId]
end

function PeakTournamentConfig:getPtEliRoundDataById(activityId, eliRoundId)
	return self._ptEliRoundCfgs[self._ptCfg[activityId].eliRoundPlanId][eliRoundId]
end

function PeakTournamentConfig:getPtEliRankPrizeCfg(eliRankPrizePlanId)
	return self._ptEliRankPrizeCfgs[eliRankPrizePlanId]
end

function PeakTournamentConfig:getPtEliRankPrizeData(eliRankPrizePlanId, eliRankPrizeId)
	return self._ptEliRankPrizeCfgs[eliRankPrizePlanId][eliRankPrizeId]
end

function PeakTournamentConfig:getPtEliRankPrizeCfgById(activityId)
	return self._ptEliRankPrizeCfgs[self._ptCfg[activityId].eliRankPrizePlanId]
end

function PeakTournamentConfig:getPtEliRankPrizeDataById(activityId, eliRankPrizeId)
	return self._ptEliRankPrizeCfgs[self._ptCfg[activityId].eliRankPrizePlanId][eliRankPrizeId]
end

function PeakTournamentConfig:getPtEliVotePlateCfg()
	return self._ptEliVotePlateCfg
end

function PeakTournamentConfig:getPtEliVotePlateData(eliVotePlateId)
	return self._ptEliVotePlateCfg[eliVotePlateId]
end

function PeakTournamentConfig:getPtEliVotePlateDataById(activityId, eliRoundId)
	local roundData = PeakTournamentConfig.instance:getPtEliRoundDataById(activityId, eliRoundId)

	return self:getPtEliVotePlateData(roundData.eliVotePlateId)
end

function PeakTournamentConfig:getPtKudosPrizeCfg(activityId)
	return self._ptKudosPrizeCfg[self._ptCfg[activityId].kudosPlan]
end

function PeakTournamentConfig:getPtSpaceKudosPrizeCfg(activityId)
	return self._ptKudosPrizeCfg[self._ptCfg[activityId].spaceKudosPlan]
end

function PeakTournamentConfig:getPtBanPetData(activityId)
	return self.peak_tournament_ban_pet[activityId]
end

function PeakTournamentConfig:getPtNotBanPetCfg(activityId)
	local data = self:getPtBanPetData(activityId)

	if data then
		if not data.notBanPlanId then
			local notBanPlanId = 0

			return self.peak_tournament_not_ban_pet[notBanPlanId]
		end
	end
end

function PeakTournamentConfig:getPeakActivityList()
	return self._ptCfg.dataList
end

PeakTournamentConfig.instance = PeakTournamentConfig.New()

return PeakTournamentConfig
