-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldcup/model/WorldCupModel.lua

module("logic.extensions.worldcup.model.WorldCupModel", package.seeall)

local WorldCupModel = class("WorldCupModel", BaseModel)

function WorldCupModel:onInit()
	self:onReset()
end

function WorldCupModel:onReset()
	self._info = {}
	self._rankInfo = {}
	self._matchMap = {}
	self._betMap = {}
	self._groupInfo = {}
	self._groupMatchInfo = {}
end

function WorldCupModel:saveGetInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._info[data.activityId] = data

	local matchMap = {}

	for i, v in ipairs(data.matchs or {}) do
		matchMap[v.matchId] = v

		if v.stageId == 1 then
			local groupNameAttr = string.split(v.groupName, "_")
			local groupName = groupNameAttr[2]

			self._groupInfo[v.homeTeamId] = groupName
			self._groupInfo[v.awayTeamId] = groupName
		end
	end

	self._matchMap[data.activityId] = matchMap

	local betMap = {}

	for i, v in ipairs(data.bets or {}) do
		betMap[v.matchId] = betMap[v.matchId] or {}
		betMap[v.matchId][v.defineId] = v
	end

	self._betMap[data.activityId] = betMap

	local groupMatchInfo = {}

	for i, v in ipairs(data.groupStandingInfo or {}) do
		groupMatchInfo[v.teamId] = v
	end

	self._groupMatchInfo[data.activityId] = groupMatchInfo
end

function WorldCupModel:getMatchList(activityId)
	if self._info[activityId] then
		return self._info[activityId].matchs or {}
	end
end

function WorldCupModel:getMatchInfo(activityId, matchId)
	if self._matchMap[activityId] then
		return self._matchMap[activityId][matchId]
	end
end

function WorldCupModel:getBetInfo(activityId, matchId, defineId)
	if self._betMap[activityId] and self._betMap[activityId][matchId] then
		return self._betMap[activityId][matchId][defineId]
	end
end

function WorldCupModel:getBetInfos(activityId, matchId)
	if self._betMap[activityId] then
		return self._betMap[activityId][matchId]
	end
end

function WorldCupModel:getAllBetInfo(activityId)
	if self._info[activityId] then
		return self._info[activityId].bets or {}
	end
end

function WorldCupModel:getTopGuessInfo(activityId)
	if self._info[activityId] then
		return self._info[activityId].guessInfo or {}
	end
end

function WorldCupModel:saveGuessTop(msg)
	if self._info[msg.activityId] then
		self._info[msg.activityId].guessInfo = self._info[msg.activityId].guessInfo or {}
		self._info[msg.activityId].guessInfo.championTeamId = msg.championTeamId
		self._info[msg.activityId].guessInfo.runnerUpTeamId = msg.runnerUpTeamId
		self._info[msg.activityId].guessInfo.thirdPlaceTeamId = msg.thirdPlaceTeamId
	end
end

function WorldCupModel:saveGetGuessTopPrize(msg)
	if self._info[msg.activityId] then
		self._info[msg.activityId].guessInfo = self._info[msg.activityId].guessInfo or {}
		self._info[msg.activityId].guessInfo.gainedPrize = true
	end
end

function WorldCupModel:getMatchListWithBets(activityId, filterStageId)
	local betByMatch = self._betMap[activityId]

	if not betByMatch then
		return {}
	end

	local list = {}

	for matchId, _ in pairs(betByMatch) do
		local info = self:getMatchInfo(activityId, matchId)

		if info and (not filterStageId or info.stageId == filterStageId) then
			table.insert(list, info)
		end
	end

	table.sort(list, function(a, b)
		return checknumber(a.startTime) > checknumber(b.startTime)
	end)

	return list
end

function WorldCupModel:getSortedBetEntriesForMatch(activityId, matchId)
	local byMatch = self._betMap[activityId]
	local t = {}

	if not byMatch or not byMatch[matchId] then
		return t
	end

	for defineId, betItem in pairs(byMatch[matchId]) do
		table.insert(t, {
			defineId = defineId,
			betItem = betItem
		})
	end

	table.sort(t, function(a, b)
		return a.defineId < b.defineId
	end)

	return t
end

function WorldCupModel:saveBetResult(msg)
	local data = GameUtil.pbToTable(msg)

	if self._betMap[msg.activityId] then
		self._betMap[msg.activityId][msg.matchId] = self._betMap[msg.activityId][msg.matchId] or {}
		self._betMap[msg.activityId][msg.matchId][msg.defineId] = data.betItem
	end
end

function WorldCupModel:saveRankInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._rankInfo[data.activityId] = data
end

function WorldCupModel:markDailyPrizeGained(activityId)
	local info = self._info[activityId]

	if info then
		info.gainedDailyPrize = true
	end
end

function WorldCupModel:isGainDailyPrize(activityId)
	local info = self._info[activityId]

	if info then
		return info.gainedDailyPrize or false
	end

	return false
end

function WorldCupModel:getGetInfo(activityId)
	return self._info[activityId]
end

function WorldCupModel:getRankInfo(activityId)
	return self._rankInfo[activityId]
end

function WorldCupModel:getGroupInfo()
	return self._groupInfo
end

function WorldCupModel:getGroupMatchInfo(activityId, teamId)
	if self._groupMatchInfo[activityId] then
		return self._groupMatchInfo[activityId][teamId]
	end
end

function WorldCupModel:saveGainBetPrize(msg)
	if self._info[msg.activityId] and self._info[msg.activityId].bets then
		for i, v in ipairs(self._info[msg.activityId].bets) do
			v.state = 1
		end
	end
end

WorldCupModel.instance = WorldCupModel.New()

return WorldCupModel
