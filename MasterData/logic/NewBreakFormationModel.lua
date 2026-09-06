-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newbreakformation/model/NewBreakFormationModel.lua

module("logic.extensions.newbreakformation.model.NewBreakFormationModel", package.seeall)

local NewBreakFormationModel = class("NewBreakFormationModel", BaseModel)

function NewBreakFormationModel:ctor()
	return
end

function NewBreakFormationModel:onInit()
	self:onReset()
end

function NewBreakFormationModel:onReset()
	self._info = {}
	self._buffMap = {}
	self._rankInfo = {}
	self._recordScore = {}
	self._myRank = 0
end

function NewBreakFormationModel:setInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._info[info.seasonId] = {}

	for i, tabInfo in ipairs(info.tabList or {}) do
		self._info[info.seasonId][tabInfo.tabId] = {}

		for j, periodInfo in ipairs(tabInfo.periodList) do
			self._info[info.seasonId][tabInfo.tabId][periodInfo.periodId] = {}

			local gainPrizeMap = {}

			if periodInfo.gainScorePrizeId then
				for k, prizeId in ipairs(periodInfo.gainScorePrizeId) do
					gainPrizeMap[prizeId] = true
				end
			end

			self._info[info.seasonId][tabInfo.tabId][periodInfo.periodId].gainPrizeMap = gainPrizeMap

			local stageInfoList = {}

			for k, stageInfo in ipairs(periodInfo.stageList) do
				stageInfoList[stageInfo.stageId] = stageInfo
			end

			self._info[info.seasonId][tabInfo.tabId][periodInfo.periodId].stageInfo = stageInfoList
		end
	end

	self:resetBuffMap()
end

function NewBreakFormationModel:getTotalScoreBySeason(seasonId)
	local totalScore = 0

	if self._info[seasonId] then
		for tabId, tabInfo in pairs(self._info[seasonId]) do
			for peiodId, periodInfo in pairs(tabInfo) do
				for stageId, stageInfo in pairs(periodInfo.stageInfo) do
					totalScore = totalScore + stageInfo.evenMaxscore or 0
				end
			end
		end
	end

	return totalScore
end

function NewBreakFormationModel:getTotalScoreByTab(seasonId, tabId)
	local totalScore = 0

	if self._info[seasonId] and self._info[seasonId][tabId] then
		local tabInfo = self._info[seasonId][tabId]
		local scoreMap = {}

		for peiodId, periodInfo in pairs(tabInfo) do
			for stageId, stageInfo in pairs(periodInfo.stageInfo) do
				scoreMap[stageId] = checknumber(scoreMap[stageId]) < stageInfo.evenMaxscore and stageInfo.evenMaxscore or scoreMap[stageId] or 0
			end
		end

		for stageId, score in ipairs(scoreMap) do
			totalScore = totalScore + score
		end
	end

	return totalScore
end

function NewBreakFormationModel:getTotalScoreByPeriod(seasonId, tabId, periodId)
	local totalScore = 0

	if self._info[seasonId] and self._info[seasonId][tabId] and self._info[seasonId][tabId][periodId] then
		local periodInfo = self._info[seasonId][tabId][periodId]

		for stageId, stageInfo in pairs(periodInfo.stageInfo) do
			totalScore = totalScore + stageInfo.evenMaxscore
		end
	end

	return totalScore
end

function NewBreakFormationModel:getTotalScoreByStage(seasonId, tabId, stageId)
	local totalScore = 0

	if self._info[seasonId] and self._info[seasonId][tabId] then
		local tabInfo = self._info[seasonId][tabId]

		for peiodId, periodInfo in pairs(tabInfo) do
			totalScore = periodInfo.stageInfo[stageId] and totalScore < periodInfo.stageInfo[stageId].evenMaxscore and periodInfo.stageInfo[stageId].evenMaxscore or totalScore or 0
		end
	end

	return totalScore
end

function NewBreakFormationModel:getStageInfo(seasonId, tabId, periodId, stageId)
	if self._info[seasonId] and self._info[seasonId][tabId] and self._info[seasonId][tabId][periodId] and self._info[seasonId][tabId][periodId].stageInfo then
		return self._info[seasonId][tabId][periodId].stageInfo[stageId]
	end

	return nil
end

function NewBreakFormationModel:getPerioPrizeInfo(seasonId, tabId, periodId)
	return self._info[seasonId][tabId][periodId].gainPrizeMap
end

function NewBreakFormationModel:isPerioPrizeGain(seasonId, tabId, periodId, prizeId)
	if self._info[seasonId] and self._info[seasonId][tabId] and self._info[seasonId][tabId][periodId] and self._info[seasonId][tabId][periodId].gainPrizeMap then
		return self._info[seasonId][tabId][periodId].gainPrizeMap[prizeId] or false
	end

	return false
end

function NewBreakFormationModel:getBuffMap(tabId)
	return self._buffMap[tabId]
end

function NewBreakFormationModel:setBuffMap(tabId, stageId, allBuff, uniqueBuff)
	self._buffMap[tabId] = self._buffMap[tabId] or {}
	self._buffMap[tabId][stageId] = self._buffMap[tabId][stageId] or {}
	self._buffMap[tabId][stageId].allBuffId = allBuff
	self._buffMap[tabId][stageId].uniqueBuffId = uniqueBuff
end

function NewBreakFormationModel:setPetBuffMap(tabId, stageId, petRaceId1, petRaceId2)
	self._buffMap[tabId] = self._buffMap[tabId] or {}
	self._buffMap[tabId][stageId] = self._buffMap[tabId][stageId] or {}
	self._buffMap[tabId][stageId].petRaceId1 = petRaceId1
	self._buffMap[tabId][stageId].petRaceId2 = petRaceId2
end

function NewBreakFormationModel:resetBuffMap()
	self._buffMap = {}
end

function NewBreakFormationModel:setRankInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._rankInfo[msg.seasonId] = {}
	self._rankInfo[msg.seasonId].rankList = info.rankInfoList or {}
	self._myRank = checknumber(info.myRank)

	if info.rankInfoList then
		local userId = checknumber(RoleModel.instance:getUserId())

		for i, v in ipairs(info.rankInfoList) do
			if checknumber(v.headInfo.userId) == userId then
				self._rankInfo[msg.seasonId].myRankInfo = v

				break
			end
		end
	end
end

function NewBreakFormationModel:getRankList(seasonId)
	if self._rankInfo[seasonId] then
		return self._rankInfo[seasonId].rankList
	end

	return {}
end

function NewBreakFormationModel:getMyRankInfo(seasonId)
	if self._rankInfo[seasonId] then
		return self._rankInfo[seasonId].myRankInfo
	end

	return nil
end

function NewBreakFormationModel:getMyRank()
	return self._myRank
end

function NewBreakFormationModel:getFmtMo()
	self._fmtMo = self._fmtMo or NewBreakFormationFmtMo.New()

	return self._fmtMo
end

function NewBreakFormationModel:setStageInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._info[info.seasonId] = self._info[info.seasonId] or {}
	self._info[info.seasonId][info.tabId] = self._info[info.seasonId][info.tabId] or {}
	self._info[info.seasonId][info.tabId][info.periodId] = self._info[info.seasonId][info.tabId][info.periodId] or {}
	self._info[info.seasonId][info.tabId][info.periodId].stageInfo = self._info[info.seasonId][info.tabId][info.periodId].stageInfo or {}
	self._info[info.seasonId][info.tabId][info.periodId].stageInfo[info.stageId] = self._info[info.seasonId][info.tabId][info.periodId].stageInfo[info.stageId] or {}

	local stageInfo = self._info[info.seasonId][info.tabId][info.periodId].stageInfo[info.stageId]

	stageInfo.stageId = info.stageId
	stageInfo.evenMaxscore = info.currentScore
	stageInfo.time = info.time
	stageInfo.buffInfo = stageInfo.buffInfo
	stageInfo.buffOption = info.buffOption
end

function NewBreakFormationModel:setPrizeInfo(msg)
	local info = GameUtil.pbToTable(msg)

	if checknumber(info.changeSetId) > 0 then
		self._info[info.seasonId] = self._info[info.seasonId] or {}
		self._info[info.seasonId][info.tabId] = self._info[info.seasonId][info.tabId] or {}
		self._info[info.seasonId][info.tabId][info.periodId] = self._info[info.seasonId][info.tabId][info.periodId] or {}
		self._info[info.seasonId][info.tabId][info.periodId].gainPrizeMap = self._info[info.seasonId][info.tabId][info.periodId].gainPrizeMap or {}
		self._info[info.seasonId][info.tabId][info.periodId].gainPrizeMap[info.prizeId] = true
	end
end

function NewBreakFormationModel:recordCurScore(seasonId)
	self._recordScore[seasonId] = NewBreakFormationModel.instance:getTotalScoreBySeason(seasonId)
end

function NewBreakFormationModel:clearRecordScore(seasonId)
	self._recordScore[seasonId] = nil
end

function NewBreakFormationModel:getRecordScore(seasonId)
	return self._recordScore[seasonId]
end

NewBreakFormationModel.instance = NewBreakFormationModel.New()

return NewBreakFormationModel
